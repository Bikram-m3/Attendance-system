package com.darksoul.attendence;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;

import com.darksoul.attendence.SessionManager.Sessions;
import com.onesignal.OneSignal;


public class SplashScreen extends AppCompatActivity {

    private static final String TAG = "SplashScreen";
    private int SPLASH_TIME = 2500;
    private Thread timer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_splash_screen);



        //checking 1st login...............................


        

        //starting thread.........
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    Sessions sessions = new Sessions(SplashScreen.this,Sessions.SESSION_USER);

                    if (sessions.checkLogin() == true) {
                        if(sessions.getRole()==0){
                            Intent i = new Intent(SplashScreen.this, ClientActivity.class);
                            startActivity(i);
                            finish();
                        }else{
                            Intent i = new Intent(SplashScreen.this, MainActivity.class);
                            startActivity(i);
                            finish();
                        }
                    } else {
                        Intent i = new Intent(SplashScreen.this, LoginActivity.class);
                        startActivity(i);
                        finish();
                    }
                }
            },SPLASH_TIME);
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
    }
}