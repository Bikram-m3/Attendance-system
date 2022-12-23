package com.darksoul.attendence.Network;

import com.darksoul.attendence.Utilities.app_config;

import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitClient {
    private static Retrofit instance;

    public static Retrofit getInstance() {
        if(instance==null){
            instance=new Retrofit.Builder()
                    .baseUrl(app_config.API_SERVER_URL)
                    .addConverterFactory(GsonConverterFactory.create())
                    .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                    .build();
        }
        return instance;
    }
}
