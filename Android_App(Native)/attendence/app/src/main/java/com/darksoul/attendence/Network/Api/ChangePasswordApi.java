package com.darksoul.attendence.Network.Api;

import com.darksoul.attendence.Models.Course;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;

public interface ChangePasswordApi {
    @GET("/changepassword/")
    Call<String> ChangePassword(@Header("API-KEY") String apiKey,
                                @Header("username")String username,
                                @Header("oldpassword")String oldpass,
                                @Header("newpassword")String newPass);
}
