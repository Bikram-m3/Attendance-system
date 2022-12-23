package com.darksoul.attendence;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.darksoul.attendence.SessionManager.Sessions;
import com.google.android.material.navigation.NavigationView;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

public class ClientActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener{

    TextView textResponse;
    Button btnMarkAttendence;
    String DEVICE_ID,Name;
    private NavigationView navigationView;
    private Toolbar toolbar;
    private DrawerLayout mdrawerLayout;
    private ActionBarDrawerToggle toggleMenu;
    private Menu menu;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_client);
        Sessions sessions = new Sessions(ClientActivity.this,Sessions.SESSION_USER);

        //toolbar & menu works.................................................
        toolbar=findViewById(R.id.toolbar1);
        mdrawerLayout = findViewById(R.id.mdrawer);
        Name=sessions.getName();
        toolbar.setTitle(Name);
        setSupportActionBar(toolbar);
        toggleMenu = new ActionBarDrawerToggle(this, mdrawerLayout, toolbar, R.string.toggle_open, R.string.toggle_close);
        mdrawerLayout.addDrawerListener(toggleMenu);
        toggleMenu.syncState();

        //menu event listener....
        navigationView = findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);
        menu=navigationView.getMenu();
        MenuItem roll=menu.findItem(R.id.nav_roll);
        MenuItem phone=menu.findItem(R.id.nav_phone);
        roll.setTitle(sessions.getRoll());
        phone.setTitle(sessions.getPhone());

        //for device id...............................
        DEVICE_ID = sessions.getUID();
        btnMarkAttendence = findViewById(R.id.connect);
        textResponse = findViewById(R.id.response);
        btnMarkAttendence.setOnClickListener(buttonConnectOnClickListener);
    }

    public String getUsername() {
        Sessions sessions = new Sessions(ClientActivity.this,Sessions.SESSION_USER);
        String user = sessions.getUser();
        return user;
    }

    public String getSemm() {
        Sessions sessions = new Sessions(ClientActivity.this,Sessions.SESSION_USER);
        String sem = sessions.getSem();
        return sem;
    }

    public String getDepartt() {
        Sessions sessions = new Sessions(ClientActivity.this,Sessions.SESSION_USER);
        String depart = sessions.getDepart();
        return depart;
    }

    public String getShiftt() {
        Sessions sessions = new Sessions(ClientActivity.this,Sessions.SESSION_USER);
        String shift = sessions.getShift();
        return shift;
    }


    View.OnClickListener buttonConnectOnClickListener =
            new View.OnClickListener() {

                @Override
                public void onClick(View arg0) {
                    MyClientTask myClientTask = new MyClientTask();
                    myClientTask.execute();
                    Log.e("11.wifi....................................................",getShiftt()+" -- "+getSemm()+" -- "+getDepartt());
                    Log.e("10.wifi.........................................................","wifi off --"+myClientTask.isCancelled());
                }
            };

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        int id = item.getItemId();
        switch (id) {
            case R.id.nav_phone:
            case R.id.nav_roll:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                break;
            case R.id.nav_logout:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                Sessions sessions=new Sessions(ClientActivity.this,Sessions.SESSION_USER);
                sessions.logOutUserSession();
                Intent i = new Intent(ClientActivity.this, LoginActivity.class);
                startActivity(i);
                finish();
                break;
            case R.id.nav_share:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                share(ClientActivity.this, "");
                break;
            case R.id.nav_rate:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                startActivity(new Intent(Intent.ACTION_VIEW,
                        Uri.parse("http://play.google.com/store/apps/details?id=" + BuildConfig.APPLICATION_ID)));
                break;
            case R.id.nav_about:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                Intent in = new Intent(ClientActivity.this, AboutActivity.class);
                startActivity(in);
                break;
            case R.id.nav_detail:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                Intent innn = new Intent(ClientActivity.this, StudentFilterActivity.class);
                startActivity(innn);
                break;
        }
        return true;
    }

    //after share button clicked.....
    public static void share(Context context, String body) {
        Intent sharingIntent = new Intent(android.content.Intent.ACTION_SEND);
        sharingIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        sharingIntent.setType("text/plain");
        String shareBody = body + "\n\n" + context.getString(R.string.share_body) + BuildConfig.APPLICATION_ID;
        String shareSub = "Share app";
        sharingIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, shareSub);
        sharingIntent.putExtra(android.content.Intent.EXTRA_TEXT, shareBody);
        context.startActivity(Intent.createChooser(sharingIntent, "Share using"));
    }

    public class MyClientTask extends AsyncTask<Void, Void, Void> {

        String dstAddress;
        int dstPort;
        String response = "";

        MyClientTask() {
            dstAddress = "192.168.43.1";
            dstPort = 9000;
        }

        @Override
        protected Void doInBackground(Void... arg0) {

            Socket socket = null;
            DataOutputStream dataOutputStream = null;
            DataInputStream dataInputStream = null;

            try {
                socket = new Socket(dstAddress, dstPort);

                dataOutputStream = new DataOutputStream(socket.getOutputStream());
                dataInputStream = new DataInputStream(socket.getInputStream());

                if (DEVICE_ID != null) {
                    dataOutputStream.writeUTF(DEVICE_ID);
                    dataOutputStream.writeUTF(getUsername());
                    dataOutputStream.writeUTF(getSemm());
                    dataOutputStream.writeUTF(getDepartt());
                    dataOutputStream.writeUTF(getShiftt());
                }

                response = dataInputStream.readUTF();

            } catch (UnknownHostException e) {
                e.printStackTrace();
                response = "UnknownHostException: " + e.toString();
            } catch (IOException e) {
                e.printStackTrace();
                response = "You are not connected with teacher's Hotspot .";
            } finally {

                if (socket != null) {
                    try {
                        Log.e("1.wifi.........................................................","wifi off");
                        socket.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (dataOutputStream != null) {
                    try {
                        Log.e("2.wifi.........................................................","wifi off");
                        dataOutputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (dataInputStream != null) {
                    try {
                        Log.e("3.wifi.........................................................","wifi off");
                        dataInputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            switch (response) {
                case "404":
                    textResponse.setText(String.format("%s Not Marked", response));
                    break;
                case "200":
                    textResponse.setText(R.string.success_attendance);
                    Toast.makeText(getApplicationContext(), "Success Attendance", Toast.LENGTH_SHORT).show();
                    break;
                case "420":
                    textResponse.setText(R.string.duplicate_message);
                    Toast.makeText(getApplicationContext(), "Duplicate Attendance", Toast.LENGTH_SHORT).show();
                    break;
                case "501":
                    textResponse.setText("Department Didn't Matched..!!");
                    Toast.makeText(getApplicationContext(), "Department Didn't Matched..!!", Toast.LENGTH_SHORT).show();
                    break;
                case "502":
                    textResponse.setText("Semester Didn't Matched..!!");
                    Toast.makeText(getApplicationContext(), "Semester Didn't Matched..!!", Toast.LENGTH_SHORT).show();
                    break;
                case "503":
                    textResponse.setText("Shift Didn't Matched..!!");
                    Toast.makeText(getApplicationContext(), "Shift Didn't Matched..!!", Toast.LENGTH_SHORT).show();
                    break;
                default:
                    textResponse.setText(response);
                    break;
            }
            super.onPostExecute(result);
        }

    }


}