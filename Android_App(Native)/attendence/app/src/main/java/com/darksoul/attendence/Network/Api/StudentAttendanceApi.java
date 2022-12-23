package com.darksoul.attendence.Network.Api;

import com.darksoul.attendence.Models.StudentAttendanceModel;
import com.darksoul.attendence.Models.TotalAttendanceModel;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;

public interface StudentAttendanceApi {
    @GET("/rollattendance/")
    Call<ArrayList<StudentAttendanceModel>> StudentAttendanceDetail(@Header("API-KEY") String apiKey,
                                                                   @Header("roll")String roll,
                                                                   @Header("sem")String sem,
                                                                   @Header("sub")String sub);

    @GET("/gettotalattend/")
    Call<ArrayList<TotalAttendanceModel>> TotalAttendanceDetail(@Header("API-KEY") String apiKey,
                                                                @Header("teacherID")String teacherID,
                                                                @Header("depart")String depart,
                                                                @Header("sem")String sem,
                                                                @Header("shift")String shift,
                                                                @Header("sub")String sub,
                                                                @Header("batch")String batch);
}
