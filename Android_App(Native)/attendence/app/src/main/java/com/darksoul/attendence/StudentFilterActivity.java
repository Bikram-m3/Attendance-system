package com.darksoul.attendence;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;

import com.darksoul.attendence.SessionManager.Sessions;

import java.util.ArrayList;

public class StudentFilterActivity extends AppCompatActivity {
    private ImageView backBtn;
    private Spinner semester,subject;
    private String facultyValue, semesterValue,subjectValue,roll;
    private Button view;
    private ArrayList<String> Subdata;
    private ArrayAdapter<CharSequence> arrayAdapter, arrayAdapter2,arrayAdapter3;
    private ArrayAdapter<String> arraySubAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_student_filter);

        //back button work.................................
        backBtn=findViewById(R.id.about_back);
        backBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        //getting Value.......................
        Sessions sessions = new Sessions(StudentFilterActivity.this, Sessions.SESSION_USER);
        facultyValue=sessions.getDepart();


        //setup semester spinner...................
        semester = findViewById(R.id.spn_sem);
        arrayAdapter2 = ArrayAdapter.createFromResource(StudentFilterActivity.this, R.array.Semester, R.layout.spinner_layout);
        arrayAdapter2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        semester.setAdapter(arrayAdapter2);
        semesterValue = semester.getSelectedItem().toString();
        semester.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                semesterValue = semester.getSelectedItem().toString();
                Subdata = loadSubject(facultyValue, semesterValue);
                arraySubAdapter.clear();
                arraySubAdapter.addAll(Subdata);
                subjectValue = subject.getSelectedItem().toString();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        //setup subject spinner....................................
        subject=findViewById(R.id.spn_sub);
        Subdata = loadSubject(facultyValue, semesterValue);
        arraySubAdapter = new ArrayAdapter<String>(StudentFilterActivity.this, android.R.layout.simple_spinner_item, Subdata);
        arraySubAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        subject.setAdapter(arraySubAdapter);
        subjectValue = subject.getSelectedItem().toString();
        subject.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                subjectValue = subject.getSelectedItem().toString();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });


        //view button event..................................
        view=findViewById(R.id.btn_view);
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(StudentFilterActivity.this, StudentAttendanceListActivity.class);
                i.putExtra("sem",semesterValue);
                i.putExtra("sub",subjectValue);
                startActivity(i);
            }
        });


    }

    ArrayList<String> loadSubject(String fac, String sem) {
        Sessions sessions = new Sessions(StudentFilterActivity.this, Sessions.SESSION_USER);
        ArrayList<String> dataa = new ArrayList<>();
        String key = fac + sem;
        if (sessions.getSubject(key) != null) {
            dataa.addAll(sessions.getSubject(key));
        } else {
            dataa.add("");
        }
        Log.e("test..........................................",dataa.get(0).toString());
        return dataa;
    }
}