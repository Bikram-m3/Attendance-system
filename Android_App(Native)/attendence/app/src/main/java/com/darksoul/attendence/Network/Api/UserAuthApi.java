package com.darksoul.attendence.Network.Api;


import com.darksoul.attendence.Models.UserModel;

import java.util.HashMap;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.POST;

public interface UserAuthApi {
    @POST("/login/")
    Call<UserModel> loginUser(@Header ("API-KEY") String apiKey,
                              @Body HashMap<String,String>map);
}
