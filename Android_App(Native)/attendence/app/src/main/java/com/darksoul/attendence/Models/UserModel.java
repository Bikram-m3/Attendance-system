package com.darksoul.attendence.Models;

import com.google.gson.annotations.SerializedName;

public class UserModel {
    @SerializedName("name")
    private String name;

    @SerializedName("username")
    private String username;

    @SerializedName("phone")
    private String phone;

    @SerializedName("uid")
    private String uid;

    @SerializedName("sem")
    private String sem;

    @SerializedName("faculty")
    private String depart;

    @SerializedName("shift")
    private String shift;

    public String getBatch() {
        return batch;
    }

    @SerializedName("Batch")
    private String batch;

    public String getShift() {
        return shift;
    }

    @SerializedName("roll")
    private String roll;

    @SerializedName("role")
    private int role;

    public String getName() {
        return name;
    }

    public String getEmail() {
        return username;
    }

    public String getPhone() {
        return phone;
    }

    public String getUserID() {
        return uid;
    }

    public int getRole() {
        return role;
    }

    public String getRoll() {
        return roll;
    }

    public String getSem() { return sem; }

    public String getDepart() { return depart; }
}
