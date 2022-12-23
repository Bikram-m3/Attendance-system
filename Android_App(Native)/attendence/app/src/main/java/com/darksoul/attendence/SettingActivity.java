package com.darksoul.attendence;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatEditText;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import com.darksoul.attendence.Network.Api.ChangePasswordApi;
import com.darksoul.attendence.Network.Api.UploadRecordApi;
import com.darksoul.attendence.Network.RetrofitClient;
import com.darksoul.attendence.SessionManager.Sessions;
import com.darksoul.attendence.Utilities.app_config;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class SettingActivity extends AppCompatActivity {
    private ImageView backBtn;
    private AppCompatEditText oldPass,newPass,rePass;
    private Button changePass;
    ChangePasswordApi changePasswordApi;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_setting);

        //back button......................................
        backBtn=findViewById(R.id.about_back);
        backBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        //change password...................................
        oldPass=findViewById(R.id.old_password);
        newPass=findViewById(R.id.new_password);
        rePass=findViewById(R.id.re_password);

        //change password api init...................................................
        Retrofit retrofit = RetrofitClient.getInstance();
        changePasswordApi = retrofit.create(ChangePasswordApi.class);

        //change pass button.................................
        changePass=findViewById(R.id.btn_change);
        changePass.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Sessions sessions = new Sessions(SettingActivity.this, Sessions.SESSION_USER);
                String teacherId=sessions.getUser();
                boolean result=validation(oldPass.getText().toString(),newPass.getText().toString(),rePass.getText().toString());
                Log.e("wifi..........................................", String.valueOf(result));
                if(result){

                    Call<String> call = changePasswordApi.ChangePassword(app_config.API_KEY,teacherId,oldPass.getText().toString(),newPass.getText().toString());
                    call.enqueue(new Callback<String>() {
                        @Override
                        public void onResponse(Call<String> call, Response<String> response) {
                            if (response.code() == 200) {
                                Toast.makeText(getApplicationContext(), "Password Changed", Toast.LENGTH_SHORT).show();
                                Sessions sessions = new Sessions(SettingActivity.this, Sessions.SESSION_USER);
                                sessions.logOutUserSession();
                                Intent i = new Intent(SettingActivity.this, LoginActivity.class);
                                startActivity(i);
                                finish();
                            }else if(response.code()==400){
                                Toast.makeText(getApplicationContext(), "Current Password Doesn't Matched..!!", Toast.LENGTH_SHORT).show();
                            }else {
                                Toast.makeText(getApplicationContext(), "Failed to Change Password..!!", Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onFailure(Call<String> call, Throwable t) {
                            Toast.makeText(getApplicationContext(), t.getMessage(), Toast.LENGTH_LONG).show();
                        }

                    });



                    oldPass.getText().clear();
                    newPass.getText().clear();
                    rePass.getText().clear();
                }
            }
        });
    }

    private boolean validation(String oldPasss,String newPasss,String rePasss) {

        if(oldPass.length()<=6){
            Toast.makeText(this, "Wrong Current Password..!!", Toast.LENGTH_SHORT).show();
            return false;
        }else{
            if(newPasss.length()>6){
                if(newPasss.equals(rePasss)){
                    return  true;
                }else{
                    Toast.makeText(this, "Please Enter Password Properly..!!", Toast.LENGTH_SHORT).show();
                    return false;
                }
            }else{
                Toast.makeText(this, "New Password more than 6 digits..!!", Toast.LENGTH_SHORT).show();
                return false;
            }
        }

    }
}