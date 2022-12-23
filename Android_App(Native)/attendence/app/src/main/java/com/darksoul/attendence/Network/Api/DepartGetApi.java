package com.darksoul.attendence.Network.Api;

import java.util.ArrayList;
import java.util.HashMap;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;

public interface DepartGetApi {
    @GET("/depart/")
    Call<ArrayList<HashMap<String,String>>> GetDepart(@Header("API-KEY") String apiKey);
}
