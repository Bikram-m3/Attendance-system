package com.darksoul.attendence;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.TextView;
import android.widget.Toast;

import com.darksoul.attendence.Adapters.CustomListAdapter;
import com.darksoul.attendence.Adapters.attendanceListAdapter;
import com.darksoul.attendence.Database.DatabaseHelper;
import com.darksoul.attendence.Models.AttendDetailModel;
import com.darksoul.attendence.Models.AttendanceModel;
import com.darksoul.attendence.Models.UserModel;
import com.darksoul.attendence.Network.Api.UploadRecordApi;
import com.darksoul.attendence.Network.Api.UserAuthApi;
import com.darksoul.attendence.Network.RetrofitClient;
import com.darksoul.attendence.SessionManager.Sessions;
import com.darksoul.attendence.Utilities.app_config;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class AttendanceLIst extends AppCompatActivity {

    private ImageView backBtn,addBtn;
    private ListView listView;
    private TextView header;
    private EditText addUser1;
    private Button uploadBtn,add;
    DatabaseHelper db;
    private String uid;
    ArrayList<AttendanceModel> listData;
    ArrayList<String> users;
    ArrayList<String> deviceID;
    UploadRecordApi uploadRecordApi;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_attendance_list);

        Intent i = getIntent();
        addBtn=findViewById(R.id.addBtn);
        uploadBtn=findViewById(R.id.upload_button);
        db=new DatabaseHelper(this);
        uid=i.getStringExtra("uid");

        //init API.....................................
        Retrofit retrofit = RetrofitClient.getInstance();
        uploadRecordApi = retrofit.create(UploadRecordApi.class);

        // Back button work..................................
        backBtn=findViewById(R.id.about_back);
        backBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        //header work...........................................
        header=findViewById(R.id.textHeader);

        addBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //create buttons display and their events handling............
                LayoutInflater layoutInflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
                View view = layoutInflater.inflate(R.layout.add_attendance_option, null);
                final PopupWindow popup = new PopupWindow(view, 800, 600, true);
                popup.showAtLocation(v, Gravity.CENTER, 0, 0);
                addUser1=view.findViewById(R.id.userID);
                add=view.findViewById(R.id.add1);
                add.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        String temp="null";
                        db.insertSingleAttendData(uid,addUser1.getText().toString(),temp);
                        finish();
                        startActivity(getIntent());
                        popup.dismiss();
                    }
                });
            }
        });

        listView=findViewById(R.id.list_22);

        loadListData();

        header.setText(i.getStringExtra("day")+"/"+i.getStringExtra("month")+"/"+i.getStringExtra("year"));


        uploadBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Sessions sessions = new Sessions(AttendanceLIst.this, Sessions.SESSION_USER);
                String teacherID=sessions.getUser();
                Call<String> call = uploadRecordApi.UploadRecord(app_config.API_KEY,"application/json",teacherID,i.getStringExtra("depart"),i.getStringExtra("sem"),i.getStringExtra("sub"),i.getStringExtra("shift"),i.getStringExtra("year"),i.getStringExtra("month"),i.getStringExtra("day"),i.getStringExtra("auid"),listData);
                call.enqueue(new Callback<String>() {
                    @Override
                    public void onResponse(Call<String> call, Response<String> response) {
                        if (response.code() == 400) {
                            db.deleteAttendData(uid);
                            Toast.makeText(getApplicationContext(), "Uploaded", Toast.LENGTH_SHORT).show();
                            Intent i = new Intent(getApplicationContext(), ListActivity.class);
                            startActivity(i);
                            finish();
                        }else {
                            Toast.makeText(getApplicationContext(), "Failed to Update..!!", Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onFailure(Call<String> call, Throwable t) {
                        Toast.makeText(getApplicationContext(), t.getMessage(), Toast.LENGTH_LONG).show();
                    }

                });

            }


        });
    }

    private void loadListData() {
        Cursor data=db.getListData(uid);
        listData=new ArrayList<AttendanceModel>();
        int count=0;
        while (data.moveToNext()){
            AttendanceModel temp = new AttendanceModel(data.getString(1),data.getString(2));
            listData.add(count,temp);
            count++;
        }


        attendanceListAdapter adapter=new attendanceListAdapter(this,listData);
        listView.setAdapter(adapter);
    }
}