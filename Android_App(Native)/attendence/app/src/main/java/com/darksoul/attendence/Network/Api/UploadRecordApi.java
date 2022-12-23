package com.darksoul.attendence.Network.Api;

import com.darksoul.attendence.Models.AttendanceModel;
import com.darksoul.attendence.Models.UserModel;

import java.util.ArrayList;
import java.util.HashMap;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.POST;

public interface UploadRecordApi {
    @POST("/attendanceUpdate/")
    Call<String> UploadRecord(@Header("API-KEY") String apiKey,
                              @Header("Content-Type")String type,
                              @Header("teacherID") String teacherID,
                              @Header("depart") String depart,
                              @Header("sem") String sem,
                              @Header("sub") String sub,
                              @Header("shift") String shift,
                              @Header("year") String year,
                              @Header("month") String month,
                              @Header("day") String day,
                              @Header("AUID") String auid,
                              @Body ArrayList<AttendanceModel> Data);
}
