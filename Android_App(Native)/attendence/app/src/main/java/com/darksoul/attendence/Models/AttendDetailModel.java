package com.darksoul.attendence.Models;

import java.util.ArrayList;
import java.util.HashMap;

public class AttendDetailModel {
    String depart;
    String semester;
    String subject;

    public AttendDetailModel(String depart, String semester, String subject, String teacherID, String uid, String year, String month, String day, String shift) {
        this.depart = depart;
        this.semester = semester;
        this.subject = subject;
        this.teacherID = teacherID;
        this.uid = uid;
        this.year = year;
        this.month = month;
        this.day = day;
        this.shift = shift;
    }

    String teacherID;

    public String getDepart() {
        return depart;
    }

    public void setDepart(String depart) {
        this.depart = depart;
    }

    public String getTeacherID() {
        return teacherID;
    }

    public void setTeacherID(String teacherID) {
        this.teacherID = teacherID;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    String uid;
    String year;
    String month;
    String day;
    String shift;




    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getShift() {
        return shift;
    }

    public void setShift(String shift) {
        this.shift = shift;
    }

}
