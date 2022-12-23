package com.darksoul.attendence;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.darksoul.attendence.Adapters.CustomListAdapter;
import com.darksoul.attendence.Adapters.StudentAttendanceAdapter;
import com.darksoul.attendence.Models.StudentAttendanceModel;
import com.darksoul.attendence.Models.TotalAttendanceModel;
import com.darksoul.attendence.Models.UserModel;
import com.darksoul.attendence.Network.Api.StudentAttendanceApi;
import com.darksoul.attendence.Network.Api.UserAuthApi;
import com.darksoul.attendence.Network.RetrofitClient;
import com.darksoul.attendence.SessionManager.Sessions;
import com.darksoul.attendence.Utilities.app_config;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class StudentAttendanceListActivity extends AppCompatActivity {
    private String roll,sem,sub,depart,shift,batch;
    private ImageView backBtn;
    private TextView err,header;
    private ListView listView;
    private StudentAttendanceApi studentAttendanceApi;
    public static ArrayList<StudentAttendanceModel> dataModel;
    private ArrayList<TotalAttendanceModel> totalDataModel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_student_attendance_list);

        //init..................................
        err=findViewById(R.id.listError);
        listView=findViewById(R.id.list_22);
        header=findViewById(R.id.textHeader);

        //getting Value.......................
        Sessions sessions = new Sessions(StudentAttendanceListActivity.this, Sessions.SESSION_USER);
        roll=sessions.getRoll();
        depart=sessions.getDepart();
        shift=sessions.getShift();
        batch=sessions.getBatch();

        //getting intent Data.......................
        Intent intent = getIntent();
        sem=intent.getStringExtra("sem");
        sub=intent.getStringExtra("sub");

        header.setText(sub);

        //init Api
        Retrofit retrofit = RetrofitClient.getInstance();
        studentAttendanceApi = retrofit.create(StudentAttendanceApi.class);

        //back button work.................................
        backBtn=findViewById(R.id.about_back);
        backBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        loadData();

    }

    private void loadData() {
        dataModel=new ArrayList<StudentAttendanceModel>();
        totalDataModel=new ArrayList<TotalAttendanceModel>();
        //load total attendance........................
        Call<ArrayList<StudentAttendanceModel>> call = studentAttendanceApi.StudentAttendanceDetail(app_config.API_KEY,roll,sem,sub);
        call.enqueue(new Callback<ArrayList<StudentAttendanceModel>>() {
            @Override
            public void onResponse(Call<ArrayList<StudentAttendanceModel>> call, Response<ArrayList<StudentAttendanceModel>> response) {
                if (response.code() == 200) {
                    loadTotalData(response.body());
                    listView.setVisibility(View.VISIBLE);
                    err.setVisibility(View.GONE);

                }else {
                    listView.setVisibility(View.GONE);
                    err.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onFailure(Call<ArrayList<StudentAttendanceModel>> call, Throwable t) {
                Toast.makeText(getApplicationContext(), t.getMessage(), Toast.LENGTH_LONG).show();
            }

        });
    }

    private void loadTotalData(ArrayList<StudentAttendanceModel> data) {
        dataModel=data;

        Call<ArrayList<TotalAttendanceModel>> call = studentAttendanceApi.TotalAttendanceDetail(app_config.API_KEY, dataModel.get(0).getTeacherID(), depart, sem, shift, sub, batch);
        call.enqueue(new Callback<ArrayList<TotalAttendanceModel>>() {
            @Override
            public void onResponse(Call<ArrayList<TotalAttendanceModel>> call, Response<ArrayList<TotalAttendanceModel>> response) {
                if (response.code() == 200) {
                    totalDataModel = response.body();
                    StudentAttendanceAdapter adapter=new StudentAttendanceAdapter(StudentAttendanceListActivity.this,totalDataModel);
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