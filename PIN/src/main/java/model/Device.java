package model;

import org.json.JSONObject;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class Device {
    private int deviceId;
    private String type;
    private String name;
    private String brand;
    private BigDecimal price;
    private Date releaseDate;
    private String about;
    private String provider;
    private Timestamp createdAt;
    private boolean isDeleted;
    private JSONObject specs;
    private List<DeviceImage> images;

    // Getters and setters
    public int getDeviceId() { return deviceId; }
    public void setDeviceId(int deviceId) { this.deviceId = deviceId; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Date getReleaseDate() { return releaseDate; }
    public void setReleaseDate(Date releaseDate) { this.releaseDate = releaseDate; }
    public String getAbout() { return about; }
    public void setAbout(String about) { this.about = about; }
    public String getProvider() { return provider; }
    public void setProvider(String provider) { this.provider = provider; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public boolean isDeleted() { return isDeleted; }
    public void setDeleted(boolean deleted) { isDeleted = deleted; }
    public JSONObject getSpecs() { return specs; }
    public void setSpecs(JSONObject specs) { this.specs = specs; }
    public List<DeviceImage> getImages() { return images; }
    public void setImages(List<DeviceImage> images) { this.images = images; }

    // For JSP compatibility
    public String getCategory() { return type; }
    public int getId() { return deviceId; }
}