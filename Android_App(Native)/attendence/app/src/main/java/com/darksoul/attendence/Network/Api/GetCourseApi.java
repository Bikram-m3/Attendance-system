package com.darksoul.attendence.Network.Api;

import com.darksoul.attendence.Models.Course;
import com.darksoul.attendence.Models.CourseModel;

import java.util.ArrayList;
import java.util.HashMap;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;

public interface GetCourseApi {
    @GET("/course/")
    Call<ArrayList<Course>> GetCourses(@Header("API-KEY") String apiKey);
}
