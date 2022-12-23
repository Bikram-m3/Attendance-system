package com.darksoul.attendence.Network.Api;

import com.darksoul.attendence.Models.SingleDateAttendanceModel;
import com.darksoul.attendence.Models.TotalAttendanceModel;
import com.darksoul.attendence.Models.UserCountModel;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;

public interface SingleDateAttendanceApi {
    @GET("/auidattendance/")
    Call<ArrayList<SingleDateAttendanceModel>> SingleDateAttendanceList(@Header("API-KEY") String apiKey,
                                                                        @Header("AUID")String AUID);

    @GET("/UsersCountBydepart/")
    Call<ArrayList<UserCountModel>> SingleDateCountUsers(@Header("API-KEY") String apiKey,
                                                         @Header("depart")String depart,
                                                         @Header("sem")String sem,
                                                         @Header("shift")String shift);
}
