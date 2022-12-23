package com.darksoul.attendence;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.darksoul.attendence.Adapters.CustomTeacherAttendanceAdapter;
import com.darksoul.attendence.Adapters.StudentAttendanceAdapter;
import com.darksoul.attendence.Models.TotalAttendanceModel;
import com.darksoul.attendence.Network.Api.StudentAttendanceApi;
import com.darksoul.attendence.Network.Api.TeacherAttendanceApi;
import com.darksoul.attendence.Network.RetrofitClient;
import com.darksoul.attendence.SessionManager.Sessions;
import com.darksoul.attendence.Utilities.app_config;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class DisplayAttendanceListActivity extends AppCompatActivity {

    private  String teacherId,sem,sub,depart,shift,batch;
    private ImageView backBtn;
    private TeacherAttendanceApi teacherAttendanceApi;
    private ArrayList<TotalAttendanceModel> totalDataModel;
    private ListView listView;
    private TextView err;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display_attendance_list);

        //init Api
        Retrofit retrofit = RetrofitClient.getInstance();
        teacherAttendanceApi= retrofit.create(TeacherAttendanceApi.class);

        //view init.........................
        listView=findViewById(R.id.list_22);
        err=findViewById(R.id.listError);

        //getting techer ID.........................
        Sessions sessions = new Sessions(DisplayAttendanceListActivity.this, Sessions.SESSION_USER);
        teacherId=sessions.getUser();

        //getting intent Data.......................
        Intent intent = getIntent();
        sem=intent.getStringExtra("sem");
        sub=intent.getStringExtra("sub");
        depart=intent.getStringExtra("depart");
        shift=intent.getStringExtra("shift");
        batch=intent.getStringExtra("batch");



        //back button work.................................
        backBtn=findViewById(R.id.about_back);
        backBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        LoadData();
    }

    private void LoadData() {

        Call<ArrayList<TotalAttendanceModel>> call = teacherAttendanceApi.TotalTeacherAttendanceDetail(app_config.API_KEY, teacherId, depart, sem, shift, sub, batch);
        call.enqueue(new Callback<ArrayList<TotalAttendanceModel>>() {
            @Override
            public void onResponse(Call<ArrayList<TotalAttendanceModel>> call, Response<ArrayList<TotalAttendanceModel>> response) {
                if (response.code() == 200) {
                    totalDataModel = response.body();
                    CustomTeacherAttendanceAdapter adapter=new CustomTeacherAttendanceAdapter(DisplayAttendanceListActivity.this,totalDataModel);
                    listView.setAdapter(adapter);
                }else{
                    listView.setVisibility(View.GONE);
                    err.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onFailure(Call<ArrayList<TotalAttendanceModel>> call, Throwable t) {
                Toast.makeText(getApplicationContext(), t.getMessage(), Toast.LENGTH_LONG).show();
            }

        });
    }
}