package com.darksoul.attendence.Models;

import com.google.gson.annotations.SerializedName;

public class SingleDateAttendanceModel {
    @SerializedName("name")
    String name;

    @SerializedName("roll")
    String roll;

    public String getName() {
        return name;
    }

    public String getRoll() {
        return roll;
    }
}
