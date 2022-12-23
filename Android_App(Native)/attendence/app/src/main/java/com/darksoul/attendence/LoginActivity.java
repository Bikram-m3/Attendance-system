package com.darksoul.attendence;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.StackView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatEditText;

import com.darksoul.attendence.Models.Course;
import com.darksoul.attendence.Models.CourseModel;
import com.darksoul.attendence.Models.UserModel;
import com.darksoul.attendence.Network.Api.DepartGetApi;
import com.darksoul.attendence.Network.Api.GetCourseApi;
import com.darksoul.attendence.Network.Api.UserAuthApi;
import com.darksoul.attendence.Network.RetrofitClient;
import com.darksoul.attendence.SessionManager.Sessions;
import com.darksoul.attendence.Utilities.app_config;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseException;
import com.google.firebase.FirebaseTooManyRequestsException;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthInvalidCredentialsException;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.PhoneAuthOptions;
import com.google.firebase.auth.PhoneAuthProvider;
import com.onesignal.OneSignal;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class LoginActivity extends AppCompatActivity {

    private TextView viewSignup;
    private Button loginBtn,btnDone;
    private AppCompatEditText Email, Password,getOTP;
    private CheckBox remember;
    private UserAuthApi ApiAuth;
    private DepartGetApi departGetApi;
    private GetCourseApi getCourseApi;
    private Set<String> depart;
    private RelativeLayout relativeLayout;
    String Uid;
    private FirebaseAuth mAuth;
    private String verificationId;
    UserModel data;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        //init Api
        Retrofit retrofit = RetrofitClient.getInstance();
        ApiAuth = retrofit.create(UserAuthApi.class);
        departGetApi = retrofit.create(DepartGetApi.class);
        getCourseApi = retrofit.create(GetCourseApi.class);

        //firebase init..............
        mAuth = FirebaseAuth.getInstance();

        //handle notifications..................
        OneSignal.setLogLevel(OneSignal.LOG_LEVEL.VERBOSE, OneSignal.LOG_LEVEL.NONE);
        // OneSignal Initialization
        OneSignal.initWithContext(this);
        OneSignal.setAppId(app_config.ONESIGNAL_APP_ID);
        Uid = OneSignal.getDeviceState().getUserId();
        OneSignal.promptForPushNotifications();


        //view init..........
        loginBtn = findViewById(R.id.btn_login);
        Email = findViewById(R.id.login_email);
        Password = findViewById(R.id.login_password);
        remember = findViewById(R.id.cb_rememberme);
        relativeLayout=findViewById(R.id.relativeLayout);


        //remember me works.......
        Sessions sessions = new Sessions(LoginActivity.this, Sessions.SESSION_REMEMBER);
        if (sessions.checkRememberMe()) {
            HashMap<String, String> data = sessions.getRememberMeFromSession();
            Email.setText(data.get(Sessions.KEY_USERNAME));
            Password.setText(data.get(Sessions.KEY_PASSWORD));
        }


        //login button click listener.................
        loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String email = Email.getText().toString();
                String pass = Password.getText().toString();
                if (remember.isChecked()) {
                    RememberME(email, pass);
                    UserAuthantication(email, pass,Uid);
                    relativeLayout.setVisibility(View.VISIBLE);

                } else {
                    UserAuthantication(email, pass,Uid);
                    relativeLayout.setVisibility(View.VISIBLE);
                }

            }
        });

    }


    private void LoadData() {
        //calling course api..........................................
        Call<ArrayList<Course>> call1 = getCourseApi.GetCourses(app_config.API_KEY);
        call1.enqueue(new Callback<ArrayList<Course>>() {
            @Override
            public void onResponse(Call<ArrayList<Course>> call, Response<ArrayList<Course>> response) {
                if (response.code() == 200) {
                    ArrayList<Course> data1 = response.body();


                    List<String> strData = new ArrayList<String>();
                    strData.add("BECE");
                    strData.add("BEIT");
                    strData.add("BECIVIL");
                    strData.add("BEELX");
                    strData.add("BESE");
                    strData.add("BCA");

                    for (int i = 0; i < strData.size(); i++) {

                        String one = "", two = "", three = "", four = "", five = "", six = "", seven = "", eight = "";
                        Set<String> sub1 = new HashSet<String>();
                        Set<String> sub2 = new HashSet<String>();
                        Set<String> sub3 = new HashSet<String>();
                        Set<String> sub4 = new HashSet<String>();
                        Set<String> sub5 = new HashSet<String>();
                        Set<String> sub6 = new HashSet<String>();
                        Set<String> sub7 = new HashSet<String>();
                        Set<String> sub8 = new HashSet<String>();

                        for (int j = 0; j < data1.size(); j++) {

                            if (strData.get(i).equals(data1.get(j).getFaculty())) {

                                if (data1.get(j).getSemester().equals("1")) {
                                    one = data1.get(j).getFaculty() + data1.get(j).getSemester();
                                    sub1.add(data1.get(j).getSubject());

                                } else if (data1.get(j).getSemester().equals("2")) {
                                    two = data1.get(j).getFaculty() + data1.get(j).getSemester();
                                    sub2.add(data1.get(j).getSubject());

                                } else if (data1.get(j).getSemester().equals("3")) {
                                    three = data1.get(j).getFaculty() + data1.get(j).getSemester();
                                    sub3.add(data1.get(j).getSubject());

                                } else if (data1.get(j).getSemester().equals("4")) {
                                    four = data1.get(j).getFaculty() + data1.get(j).getSemester();
                                    sub4.add(data1.get(j).getSubject());

                                } else if (data1.get(j).getSemester().equals("5")) {
                                    five = data1.get(j).getFaculty() + data1.get(j).getSemester();
                                    sub5.add(data1.get(j).getSubject());

                                } else if (data1.get(j).getSemester().equals("6")) {
                                    six = data1.get(j).getFaculty() + data1.get(j).getSemester();
                                    sub6.add(data1.get(j).getSubject());

                                } else if (data1.get(j).getSemester().equals("7")) {
                                    seven = data1.get(j).getFaculty() + data1.get(j).getSemester();
                                    sub7.add(data1.get(j).getSubject());

                                } else {
                                    eight = data1.get(j).getFaculty() + data1.get(j).getSemester();
                                    sub8.add(data1.get(j).getSubject());
                                }
                            }
                        }
                        //save department data to local..............................................
                        Sessions sessions = new Sessions(LoginActivity.this, Sessions.SESSION_USER);
                        sessions.SubjectSession(one, sub1);
                        sessions.SubjectSession(two, sub2);
                        sessions.SubjectSession(three, sub3);
                        sessions.SubjectSession(four, sub4);
                        sessions.SubjectSession(five, sub5);
                        sessions.SubjectSession(six, sub6);
                        sessions.SubjectSession(seven, sub7);
                        sessions.SubjectSession(eight, sub8);
                    }


                }
            }

            @Override
            public void onFailure(Call<ArrayList<Course>> call, Throwable t) {
                Toast.makeText(getApplicationContext(), t.getMessage(), Toast.LENGTH_LONG).show();
            }

        });


    }

    private void UserAuthantication(String email, String pass,String UID) {
        HashMap<String, String> map = new HashMap<>();
        map.put("email", email);
        map.put("password", pass);
        map.put("uid",UID);
        Call<UserModel> call = ApiAuth.loginUser(app_config.API_KEY,map);
        call.enqueue(new Callback<UserModel>() {
            @Override
            public void onResponse(Call<UserModel> call, Response<UserModel> response) {
                if (response.code() == 200) {
                    data = response.body();
                    relativeLayout.setVisibility(View.GONE);
                    sendOtp(data.getPhone());

                } else if (response.code() == 400) {
                    Toast.makeText(getApplicationContext(), "Wrong Password !!!", Toast.LENGTH_SHORT).show();
                    relativeLayout.setVisibility(View.GONE);
                } else {
                    Toast.makeText(getApplicationContext(), "User Not Exists !!!", Toast.LENGTH_SHORT).show();
                    relativeLayout.setVisibility(View.GONE);
                }
            }

            @Override
            public void onFailure(Call<UserModel> call, Throwable t) {
                Toast.makeText(getApplicationContext(), t.getMessage(), Toast.LENGTH_LONG).show();
                relativeLayout.setVisibility(View.GONE);
            }

        });
    }

    private void sendOtp(String number) {
        PhoneAuthProvider.OnVerificationStateChangedCallbacks mCallbacks = new PhoneAuthProvider.OnVerificationStateChangedCallbacks() {

            @Override
            public void onVerificationCompleted(PhoneAuthCredential credential) {
                final String code=credential.getSmsCode();

                if(code!=null){
                    verifyCode(code);
                }

            }

            @Override
            public void onVerificationFailed(FirebaseException e) {
                Toast.makeText(LoginActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onCodeSent(@NonNull String s,
                                   @NonNull PhoneAuthProvider.ForceResendingToken token) {
                super.onCodeSent(s,token);
                verificationId=s;
                Log.e("wifi..............................id....................",s);
                popUp();
            }
        };




        PhoneAuthOptions options =
                PhoneAuthOptions.newBuilder(mAuth)
                        .setPhoneNumber("+977"+number)       // Phone number to verify
                        .setTimeout(60L, TimeUnit.SECONDS) // Timeout and unit
                        .setActivity(this)                 // Activity (for callback binding)
                        .setCallbacks(mCallbacks)          // OnVerificationStateChangedCallbacks
                        .build();
        PhoneAuthProvider.verifyPhoneNumber(options);
    }

    private void popUp() {
        //create get code popup and their events handling............
        LayoutInflater layoutInflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
        View view = layoutInflater.inflate(R.layout.activity_otp, null);
        final PopupWindow popup = new PopupWindow(view, 700, 700, true);
        popup.showAtLocation(view, Gravity.CENTER, 0, 0);
        getOTP=view.findViewById(R.id.login_otp);
        btnDone=view.findViewById(R.id.btn_otp);
        btnDone.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(getOTP.getText().toString().isEmpty()){
                    Toast.makeText(LoginActivity.this, "Invalid OTP", Toast.LENGTH_SHORT).show();
                    popup.dismiss();
                }else{
                    verifyCode(getOTP.getText().toString());
                    popup.dismiss();
                }
            }
        });

    }

    private void verifyCode(String code) {
        PhoneAuthCredential credential=PhoneAuthProvider.getCredential(verificationId,code);
        signInWithCredential(credential);

    }


    private void signInWithCredential(PhoneAuthCredential credential) {
        mAuth.signInWithCredential(credential)
                .addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {

                            Sessions sessions = new Sessions(LoginActivity.this, Sessions.SESSION_USER);
                            sessions.createLoginSession(data.getName(), data.getEmail(), data.getPhone(), Uid,data.getSem(),data.getDepart(),data.getShift(), data.getRoll(), data.getRole(),data.getBatch());
                            if (data.getRole() == 0) {
                                //load faculty data..................................
                                LoadData();

                                Intent i = new Intent(LoginActivity.this, ClientActivity.class);
                                startActivity(i);
                                finish();

                            } else if (data.getRole() == 1) {
                                //load faculty data..................................
                                LoadData();

                                Intent i = new Intent(LoginActivity.this, MainActivity.class);
                                startActivity(i);
                                finish();
                            }

                        } else {

                            Toast.makeText(LoginActivity.this, task.getException().getMessage(), Toast.LENGTH_LONG).show();
                        }
                    }
                });
    }

    private void RememberME(String email, String pass) {
        Sessions sessions = new Sessions(LoginActivity.this, Sessions.SESSION_REMEMBER);
        sessions.createRememberMeSession(email, pass);
    }
}