package com.darksoul.attendence.Network.Api;

import com.darksoul.attendence.Models.TotalAttendanceModel;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;

public interface TeacherAttendanceApi {
    @GET("/gettotalattend/")
    Call<ArrayList<TotalAttendanceModel>> TotalTeacherAttendanceDetail(@Header("API-KEY") String apiKey,
                                                                @Header("teacherID")String teacherID,
                                                                @Header("depart")String depart,
                                                                @Header("sem")String sem,
                                                                @Header("shift")String shift,
                                                                @Header("sub")String sub,
                                                                @Header("batch")String batch);
}
