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

import com.darksoul.attendence.Adapters.CustomSingleAteendanceAdapter;
import com.darksoul.attendence.Adapters.CustomTeacherAttendanceAdapter;
import com.darksoul.attendence.Models.SingleDateAttendanceModel;
import com.darksoul.attendence.Models.TotalAttendanceModel;
import com.darksoul.attendence.Models.UserCountModel;
import com.darksoul.attendence.Network.Api.SingleDateAttendanceApi;
import com.darksoul.attendence.Network.Api.TeacherAttendanceApi;
import com.darksoul.attendence.Network.RetrofitClient;
import com.darksoul.attendence.Utilities.app_config;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class TeacherAttendanceSingleList extends AppCompatActivity {
    private String sem,depart,shift,auid,year,month,day,batch;
    private ImageView backBtn;
    private TextView err,header;
    private ListView listView;
    private SingleDateAttendanceApi singleDateAttendanceApi;
    private int CountTotal=0;
    private ArrayList<SingleDateAttendanceModel> totalDataModel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teacher_attendance_single_list);

        //init..................................
        err=findViewById(R.id.listError);
        listView=findViewById(R.id.list_22);
        header=findViewById(R.id.textHeader);

        //init Api
        Retrofit retrofit = RetrofitClient.getInstance();
        singleDateAttendanceApi= retrofit.create(SingleDateAttendanceApi.class);

        //getting intent Data.......................
        Intent intent = getIntent();
        depart=intent.getStringExtra("depart");
        sem=intent.getStringExtra("sem");
        shift=intent.getStringExtra("shift");
        auid=intent.getStringExtra("auid");
        year=intent.getStringExtra("year");
        month=intent.getStringExtra("month");
        day = intent.getStringExtra("day");
        batch=intent.getStringExtra("batch");


        Log.e("111........................", sem+"--"+shift+"--"+depart+"--"+auid);

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

        Call<ArrayList<UserCountModel>> call = singleDateAttendanceApi.SingleDateCountUsers(app_config.API_KEY,depart,sem,shift);
        call.enqueue(new Callback<ArrayList<UserCountModel>>() {
            @Override
            public void onResponse(Call<ArrayList<UserCountModel>> call, Response<ArrayList<UserCountModel>> response) {
                if (response.code() == 200) {
                    CountTotal=response.body().size();

                    Call<ArrayList<SingleDateAttendanceModel>> call1 = singleDateAttendanceApi.SingleDateAttendanceList(app_config.API_KEY,auid);
                    call1.enqueue(new Callback<ArrayList<SingleDateAttendanceModel>>() {
                        @Override
                        public void onResponse(Call<ArrayList<SingleDateAttendanceModel>> call1, Response<ArrayList<SingleDateAttendanceModel>> response1) {
                            if (response1.code() == 200) {
                                totalDataModel = response1.body();
                                header.setText(day+"/"+month+"/"+year+" ( T.S. :- "+CountTotal+" , T.P. :- "+response1.body().size()+" )");
                                CustomSingleAteendanceAdapter adapter=new CustomSingleAteendanceAdapter(TeacherAttendanceSingleList.this,totalDataModel);
                                listView.setAdapter(adapter);
                            }else{
                                listView.setVisibility(View.GONE);
                                err.setVisibility(View.VISIBLE);
                            }
                        }

                        @Override
                        public void onFailure(Call<ArrayList<SingleDateAttendanceModel>> call1, Throwable t1) {
                            Toast.makeText(getApplicationContext(), t1.getMessage(), Toast.LENGTH_LONG).show();
                        }

                    });








                }else{
                    listView.setVisibility(View.GONE);
                    err.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onFailure(Call<ArrayList<UserCountModel>> call, Throwable t) {
                Toast.makeText(getApplicationContext(), t.getMessage(), Toast.LENGTH_LONG).show();
            }

        });

    }
}