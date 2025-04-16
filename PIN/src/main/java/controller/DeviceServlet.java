package controller;

import dao.DeviceDAO;
import dao.DeviceImageDAO;
import model.Device;
import model.DeviceImage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.JsonUtils;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/devices")
public class DeviceServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(DeviceServlet.class.getName());
    private DeviceDAO deviceDAO;
    private DeviceImageDAO deviceImageDAO;

    @Override
    public void init() throws ServletException {
        deviceDAO = new DeviceDAO();
        deviceImageDAO = new DeviceImageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String deviceId = request.getParameter("id");
            if (deviceId != null) {
                // Handle single device request
                Device device = deviceDAO.getDeviceById(Integer.parseInt(deviceId));
                if (device != null) {
                    List<DeviceImage> images = deviceImageDAO.getImagesByDeviceId(device.getDeviceId());
                    device.setImages(images);

                    // Extract specs from JSON string
                    if (device.getSpecs() != null && !device.getSpecs().isEmpty()) {
                        try {
                            JsonUtils jsonUtils = new JsonUtils();
                            Map<String, Map<String, String>> specsMap = jsonUtils.parseSpecsManually(device.getSpecs());
                            request.setAttribute("performance", specsMap.get("performance"));
                            request.setAttribute("connectivity", specsMap.get("connectivity"));
                            request.setAttribute("design_display", specsMap.get("design_display"));
                            request.setAttribute("camera", specsMap.get("camera"));
                            request.setAttribute("battery", specsMap.get("battery"));
                        } catch (Exception e) {
                            LOGGER.log(Level.WARNING, "Error parsing device specs", e);
                        }
                    }

                    request.setAttribute("device", device);
                    request.getRequestDispatcher("/Pages/DeviceDetails.jsp").forward(request, response);
                    return;
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Device not found");
                    return;
                }
            }
            // Existing device listing logic remains unchanged
            int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
            int pageSize = 12;
            String[] selectedCategories = request.getParameterValues("category");
            String[] selectedBrands = request.getParameterValues("brand");
            String minPriceStr = request.getParameter("min-price");
            String maxPriceStr = request.getParameter("max-price");
            String sortBy = request.getParameter("sort-by");

            BigDecimal minPrice = minPriceStr != null && !minPriceStr.isEmpty() ? new BigDecimal(minPriceStr) : null;
            BigDecimal maxPrice = maxPriceStr != null && !maxPriceStr.isEmpty() ? new BigDecimal(maxPriceStr) : null;

            List<Device> devices = deviceDAO.getFilteredDevices(selectedCategories, selectedBrands, minPrice, maxPrice, sortBy, page, pageSize);

            for (Device device : devices) {
                List<DeviceImage> images = deviceImageDAO.getImagesByDeviceId(device.getDeviceId());
                device.setImages(images);
            }

            int totalDevices = deviceDAO.getTotalDeviceCount(selectedCategories, selectedBrands, minPrice, maxPrice);
            int totalPages = (int) Math.ceil((double) totalDevices / pageSize);

            request.setAttribute("devices", devices);
            request.setAttribute("categories", getCategories());
            request.setAttribute("brands", getBrands());
            request.setAttribute("selectedCategories", selectedCategories != null ? List.of(selectedCategories) : new ArrayList<>());
            request.setAttribute("selectedBrands", selectedBrands != null ? List.of(selectedBrands) : new ArrayList<>());
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/Pages/Devices.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing device request", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong.");
        }
    }

    private List<Category> getCategories() {
        List<Category> categories = new ArrayList<>();
        categories.add(new Category("Mobile Phone", "Mobile Phone"));
        categories.add(new Category("laptop", "Laptops"));
        categories.add(new Category("smartwatch", "Smartwatches"));
        return categories;
    }

    private List<Brand> getBrands() {
        List<Brand> brands = new ArrayList<>();
        brands.add(new Brand("apple", "Apple"));
        brands.add(new Brand("samsung", "Samsung"));
        brands.add(new Brand("xiaomi", "Xiaomi"));
        return brands;
    }

    public static class Category {
        private String value;
        private String name;

        public Category(String value, String name) {
            this.value = value;
            this.name = name;
        }

        public String getValue() { return value; }
        public String getName() { return name; }
    }

    public static class Brand {
        private String value;
        private String name;

        public Brand(String value, String name) {
            this.value = value;
            this.name = name;
        }

        public String getValue() { return value; }
        public String getName() { return name; }
    }
}