package com.darksoul.attendence.Models;

import com.google.gson.annotations.SerializedName;

public class TotalAttendanceModel {

    @SerializedName("teacherID")
    String teacherID;

    @SerializedName("sem")
    String sem;

    @SerializedName("sub")
    String sub;

    public String getTeacherID() {
        return teacherID;
    }

    public String getSem() {
        return sem;
    }

    public String getSub() {
        return sub;
    }

    public int getYear() {
        return year;
    }

    public int getMonth() {
        return month;
    }

    public int getDay() {
        return day;
    }

    public String getDepart() {
        return depart;
    }

    public String getShift() {
        return shift;
    }

    public String getBatch() {
        return batch;
    }

    public String getAuid() {
        return auid;
    }

    @SerializedName("year")
    int year;

    @SerializedName("month")
    int month;

    @SerializedName("day")
    int day;

    @SerializedName("depart")
    String depart;

    @SerializedName("shift")
    String shift;

    @SerializedName("Batch")
    String batch;

    @SerializedName("AUID")
    String auid;
}
