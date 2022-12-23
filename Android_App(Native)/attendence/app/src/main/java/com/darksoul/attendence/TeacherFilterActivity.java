package com.darksoul.attendence;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatEditText;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.Toast;

import com.darksoul.attendence.SessionManager.Sessions;

import java.util.ArrayList;

public class TeacherFilterActivity extends AppCompatActivity {

    private ImageView backBtn;
    private Spinner faculty, semester, subject,shift;
    private String facultyValue, semesterValue, subjectValue,shiftValue;
    private ArrayList<String> Subdata;
    private AppCompatEditText Batch;
    private Button view;

    private ArrayAdapter<CharSequence> arrayAdapter, arrayAdapter2,arrayAdapter3;
    private ArrayAdapter<String> arraySubAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teacher_filter);


        //back button work.................................
        backBtn=findViewById(R.id.about_back);
        backBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });


        view=findViewById(R.id.btn_view);
        Batch=findViewById(R.id.batch);
        faculty = findViewById(R.id.depart);
        subject = findViewById(R.id.sub);
        Subdata = new ArrayList<>();


        //setup department spinner...............
        arrayAdapter = ArrayAdapter.createFromResource(TeacherFilterActivity.this, R.array.Depart, R.layout.spinner_layout);
        arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        faculty.setAdapter(arrayAdapter);
        facultyValue = faculty.getSelectedItem().toString();
        faculty.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                facultyValue = faculty.getSelectedItem().toString();
                Subdata = loadSubject(facultyValue, semesterValue);
                arraySubAdapter.clear();
                arraySubAdapter.addAll(Subdata);
                subjectValue = subject.getSelectedItem().toString();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });

        //setup semester spinner...................
        semester = findViewById(R.id.sem);
        arrayAdapter2 = ArrayAdapter.createFromResource(TeacherFilterActivity.this, R.array.Semester, R.layout.spinner_layout);
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

        //setup shift spinner...................
        shift=findViewById(R.id.shift);
        arrayAdapter3 = ArrayAdapter.createFromResource(TeacherFilterActivity.this, R.array.Shift, R.layout.spinner_layout);
        arrayAdapter3.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        shift.setAdapter(arrayAdapter3);
        shiftValue = (String) shift.getSelectedItem();
        shift.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                shiftValue = (String) shift.getSelectedItem();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        //setup subject spinner....................................
        Subdata = loadSubject(facultyValue, semesterValue);
        arraySubAdapter = new ArrayAdapter<String>(TeacherFilterActivity.this, android.R.layout.simple_spinner_item, Subdata);
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
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(Batch.length()==4) {
                    Intent i = new Intent(TeacherFilterActivity.this, DisplayAttendanceListActivity.class);
                    i.putExtra("depart", facultyValue);
                    i.putExtra("sem", semesterValue);
                    i.putExtra("shift", shiftValue);
                    i.putExtra("sub", subjectValue);
                    i.putExtra("batch", Batch.getText().toString());
                    startActivity(i);
                }else{
                    Toast.makeText(TeacherFilterActivity.this, "Please Enter Correct Batch..!!", Toast.LENGTH_SHORT).show();
                }
            }
        });


    }

    ArrayList<String> loadSubject(String fac, String sem) {
        Sessions sessions = new Sessions(TeacherFilterActivity.this, Sessions.SESSION_USER);
        ArrayList<String> dataa = new ArrayList<>();
        String key = fac + sem;
        if (sessions.getSubject(key) != null) {
            dataa.addAll(sessions.getSubject(key));
        } else {
            dataa.add("");
        }
        return dataa;
    }
}