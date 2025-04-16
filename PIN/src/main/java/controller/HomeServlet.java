package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BlogsPostDAO;
import dao.DeviceDAO;
import dao.DeviceImageDAO;
import model.BlogsPost;
import model.Device;
import model.DeviceImage;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DeviceDAO deviceDAO;
    private BlogsPostDAO blogsPostDAO;
    private DeviceImageDAO deviceImageDAO;

    public void init() {
        deviceDAO = new DeviceDAO();
        blogsPostDAO = new BlogsPostDAO();
        deviceImageDAO = new DeviceImageDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get limited featured devices (6 items)
            List<Device> featuredDevices = deviceDAO.getAllDevices(4);
            // For each device, get its images
            for (Device device : featuredDevices) {
                List<DeviceImage> images = deviceImageDAO.getImagesByDeviceId(device.getDeviceId());
                device.setImages(images);
            }
            request.setAttribute("featuredDevices", featuredDevices);

            // Get limited latest blog posts (4 items)
            List<BlogsPost> latestBlogPosts = blogsPostDAO.getAllPosts(3);
            request.setAttribute("latestBlogPosts", latestBlogPosts);

            // Forward to home page
            request.getRequestDispatcher("/Pages/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}