package com.darksoul.attendence.Models;

public class AttendanceModel {
    String username;
    String deviceId;

    public AttendanceModel(String username, String deviceId) {
        this.username = username;
        this.deviceId = deviceId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }
}
