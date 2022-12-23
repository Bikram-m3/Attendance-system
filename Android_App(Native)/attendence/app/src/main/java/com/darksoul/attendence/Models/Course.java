package com.darksoul.attendence.Models;

import com.google.gson.annotations.SerializedName;

public class Course {
    @SerializedName("faculty")
    private String faculty;

    @SerializedName("sem")
    private String semester;

    @SerializedName("subject")
    private String subject;

    public String getFaculty() {
        return faculty;
    }

    public String getSemester() {
        return semester;
    }

    public String getSubject() {
        return subject;
    }
}
