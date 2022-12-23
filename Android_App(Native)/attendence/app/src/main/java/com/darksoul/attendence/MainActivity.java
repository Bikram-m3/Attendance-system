package com.darksoul.attendence;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.DatePickerDialog;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.location.LocationManager;
import android.net.Uri;
import android.net.wifi.SoftApConfiguration;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.provider.Settings;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatEditText;
import androidx.appcompat.widget.Toolbar;
import androidx.core.app.ActivityCompat;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import com.darksoul.attendence.Database.DatabaseHelper;
import com.darksoul.attendence.Models.AttendDetailModel;
import com.darksoul.attendence.SessionManager.Sessions;
import com.google.android.material.navigation.NavigationView;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.journeyapps.barcodescanner.BarcodeEncoder;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import pub.devrel.easypermissions.EasyPermissions;


public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    private final String TAG = getClass().getSimpleName();
    private Button startHotspot, listButton,Start,stopHotspot;
    private ServerSocket serverSocket;
    private String UID = "", UserName = "", Name,dep="",Sem="",shi="";
    private ArrayList<String> deviceUID_LIST;
    private ArrayList<String> rollNoList;
    private ArrayList<HashMap> completeUIDList;
    private ArrayList<HashMap> completeUSERList;
    private ListView clientList;
    private ArrayAdapter adapter;
    private Thread socketServerThread;
    private int wifi = 0;
    private ImageView qr;
    private TextView ssid, key;

    private WifiManager wifiManager;
    private WifiConfiguration config;
    private WifiManager.LocalOnlyHotspotReservation mReservation;
    private SoftApConfiguration softConfig;

    private static final int RC_ACCESS_FINE_LOCATION = 103;
    private static final int RC_INTERNET = 104;
    private Devices devices;

    private NavigationView navigationView;
    private Toolbar toolbar;
    private DrawerLayout mdrawerLayout;
    private ActionBarDrawerToggle toggleMenu;
    private Menu menu;

    //for popup tab.....................................
    private RelativeLayout picker;
    private TextView datee;
    private DatePickerDialog.OnDateSetListener dateSetListener;
    private Spinner faculty, semester, subject,shift;
    private String facultyValue, semesterValue, subjectValue,shiftValue;
    private int yearValue, monthValue, dayValue;
    private ArrayList<String> Subdata;

    private ArrayAdapter<CharSequence> arrayAdapter, arrayAdapter2,arrayAdapter3;
    private ArrayAdapter<String> arraySubAdapter;
    DatabaseHelper db;

    private Calendar calendar;
    private SimpleDateFormat dateFormat;
    private String Date;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        startHotspot = findViewById(R.id.start);
        stopHotspot=findViewById(R.id.stop);
        qr = findViewById(R.id.qrImage);
        ssid = findViewById(R.id.ssid);
        key = findViewById(R.id.key);
        listButton = findViewById(R.id.list);
        clientList = findViewById(R.id.lv_client_list);

        //for gps...................................
        turnGPSOn();

        //current date work..........................
        calendar = Calendar.getInstance();
        dateFormat = new SimpleDateFormat("M/d/yyyy");
        Date = dateFormat.format(calendar.getTime());

        //toolbar & menu works.................................................
        Sessions sessions = new Sessions(MainActivity.this, Sessions.SESSION_USER);
        toolbar = findViewById(R.id.toolbar1);
        mdrawerLayout = findViewById(R.id.mdrawer);
        Name = sessions.getName();
        toolbar.setTitle(Name);
        setSupportActionBar(toolbar);
        toggleMenu = new ActionBarDrawerToggle(this, mdrawerLayout, toolbar, R.string.toggle_open, R.string.toggle_close);
        mdrawerLayout.addDrawerListener(toggleMenu);
        toggleMenu.syncState();

        //calender work................................................
        Calendar calendar = Calendar.getInstance();
        final int year = calendar.get(Calendar.YEAR);
        final int month = calendar.get(Calendar.MONTH);
        final int day = calendar.get(Calendar.DAY_OF_MONTH);

        //menu event listener...........................................
        navigationView = findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);
        menu = navigationView.getMenu();
        MenuItem roll = menu.findItem(R.id.nav_roll);
        MenuItem phone = menu.findItem(R.id.nav_phone);
        roll.setTitle(sessions.getRoll());
        phone.setTitle(sessions.getPhone());

        //database........................................................
        db=new DatabaseHelper(this);

        //attendance list related works......................................
        deviceUID_LIST = new ArrayList<>();
        rollNoList = new ArrayList<>();
        completeUIDList = new ArrayList<>();
        completeUSERList = new ArrayList<>();
        adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, rollNoList);
        clientList.setAdapter(adapter);

        //start hotspot button event.............................................
        startHotspot.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                //create buttons display and their events handling............
                LayoutInflater layoutInflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
                View view = layoutInflater.inflate(R.layout.option_activity, null);
                final PopupWindow popup = new PopupWindow(view, 800, 1200, true);
                popup.showAtLocation(v, Gravity.CENTER, 0, 0);
                datee = view.findViewById(R.id.date_pick);

                faculty = view.findViewById(R.id.faculty);
                subject = view.findViewById(R.id.sub);
                Subdata = new ArrayList<>();


                //setup department spinner...............
                arrayAdapter = ArrayAdapter.createFromResource(MainActivity.this, R.array.Depart, R.layout.spinner_layout);
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
                semester = view.findViewById(R.id.sem);
                arrayAdapter2 = ArrayAdapter.createFromResource(MainActivity.this, R.array.Semester, R.layout.spinner_layout);
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
                shift=view.findViewById(R.id.shift);
                arrayAdapter3 = ArrayAdapter.createFromResource(MainActivity.this, R.array.Shift, R.layout.spinner_layout);
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
                arraySubAdapter = new ArrayAdapter<String>(MainActivity.this, android.R.layout.simple_spinner_item, Subdata);
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

                //setup date picker....................................
                picker = view.findViewById(R.id.datee);
                picker.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        DatePickerDialog datePicker = new DatePickerDialog(MainActivity.this, new DatePickerDialog.OnDateSetListener() {
                            @Override
                            public void onDateSet(DatePicker view, int year, int month, int day) {
                                month = month + 1;
                                String date = day + "/" + month + "/" + year;
                                datee.setText(date);
                                yearValue = year;
                                monthValue = month;
                                dayValue = day;
                            }
                        }, year, month, day);
                        datePicker.show();
                    }
                });

                //start button....................................................
                Start=view.findViewById(R.id.start);
                Start.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        String tempDate=monthValue+"/"+dayValue+"/"+yearValue;

                        if(yearValue==0){
                            Toast.makeText(getApplicationContext(), "Please Select Date", Toast.LENGTH_SHORT).show();
                        }else{

                            if(Date.equals(tempDate)){

                                //start hotspot....................................................................
                                if (ActivityCompat.checkSelfPermission(getApplicationContext(), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(getApplicationContext(), Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                                    getLocationPermission();
                                } else {

                                    turnOnWifiHotspot();
                                    startServer();
                                    while (getIpAddress().equals("")) {
                                    }
                                    // ipInfo.setText(getIpAddress());
                                    startHotspot.setVisibility(View.GONE);
                                    listButton.setVisibility(View.GONE);
                                    stopHotspot.setVisibility(View.VISIBLE);
                                    popup.dismiss();
                                }

                            }else{
                                Toast.makeText(getApplicationContext(), "Please Select Current Date", Toast.LENGTH_SHORT).show();
                            }

                        }
                    }
                });


            }
        });

        //stop hotspot button event............................................
        stopHotspot.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                stopServer();
                turnOffWifiHotspot();
                ssid.setVisibility(View.GONE);
                qr.setVisibility(View.INVISIBLE);
                key.setVisibility(View.GONE);
                stopHotspot.setVisibility(View.GONE);
                startHotspot.setVisibility(View.VISIBLE);
                listButton.setVisibility(View.VISIBLE);
                clientList.setVisibility(View.GONE);
                LoadToModel();

                yearValue=0;
                monthValue=0;
                dayValue=0;
                rollNoList.clear();
                deviceUID_LIST.clear();
            }
        });

        //list button event.....................................................
        listButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(MainActivity.this, ListActivity.class);
                startActivity(i);
            }
        });

    }

    //load data to database.................................................
    private void LoadToModel() {

        Sessions sessions = new Sessions(MainActivity.this, Sessions.SESSION_USER);
        String teacherId=sessions.getUser();
        String year=String.valueOf(yearValue);
        String month=String.valueOf(monthValue);
        String day=String.valueOf(dayValue);
        String uid = UUID.randomUUID().toString();

        Log.e("10.wifi........................................................",uid);
        if(!rollNoList.isEmpty()){
            Boolean check= db.insertData(uid,year,month,day,teacherId,subjectValue,facultyValue,semesterValue,shiftValue);
            Boolean check2=db.insertAttendanceData(uid,rollNoList,deviceUID_LIST);
        }

    }


    ArrayList<String> loadSubject(String fac, String sem) {
        Sessions sessions = new Sessions(MainActivity.this, Sessions.SESSION_USER);
        ArrayList<String> dataa = new ArrayList<>();
        String key = fac + sem;
        if (sessions.getSubject(key) != null) {
            dataa.addAll(sessions.getSubject(key));
        } else {
            dataa.add("");
        }
        return dataa;
    }


    private void stopServer() {
        if (serverSocket != null) {
            try {
                socketServerThread.interrupt();
                serverSocket.close();
                Toast.makeText(MainActivity.this, "ServerSocket CLOSED", Toast.LENGTH_SHORT).show();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    private void turnOffWifiHotspot() {
        if (mReservation != null) {
            mReservation.close();
            Toast.makeText(getApplicationContext(), "Hotspot Is Disabled", Toast.LENGTH_SHORT).show();
        }
    }


    //hotspot related works..................................................
    @SuppressLint("MissingPermission")
    @RequiresApi(api = Build.VERSION_CODES.O)
    private void turnOnWifiHotspot() {
        boolean result = false;
        try {
            WifiManager manager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
            if (manager != null) {
                manager.startLocalOnlyHotspot(new WifiManager.LocalOnlyHotspotCallback() {

                    @RequiresApi(api = Build.VERSION_CODES.R)
                    @Override
                    public void onStarted(WifiManager.LocalOnlyHotspotReservation reservation) {
                        super.onStarted(reservation);
                        Log.d("wifi", "Wifi Hotspot is on now");
                        mReservation = reservation;
                        config = mReservation.getWifiConfiguration();
                        initQRCode(config);
                        Toast.makeText(getApplicationContext(), "Hotspot Is Enabled", Toast.LENGTH_SHORT).show();
                    }

                    @Override
                    public void onStopped() {
                        super.onStopped();
                        Log.d("wifi", "Wifi Hotspot onStopped: ");
                        Toast.makeText(getApplicationContext(), "Hotspot Is Stopped", Toast.LENGTH_SHORT).show();
                    }

                    @Override
                    public void onFailed(int reason) {
                        super.onFailed(reason);
                        Log.d("wifi", "Wifi Hotspot onFailed: ");
                        Toast.makeText(getApplicationContext(), "Hotspot Failed", Toast.LENGTH_SHORT).show();
                    }
                }, new Handler());
            }
        } catch (Exception e) {
            Log.e("wifi", "ApManager configApState O Exception " + e.getMessage() + System.lineSeparator() + e.getCause());
        }


    }


    private void startServer() {
        socketServerThread = new Thread(new SocketServerThread());
        socketServerThread.start();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (serverSocket != null) {
            try {
                socketServerThread.interrupt();
                serverSocket.close();
                Toast.makeText(MainActivity.this, "ServerSocket CLOSED", Toast.LENGTH_SHORT).show();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        turnOffWifiHotspot();
    }


    //menu item listener.......................................
    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        int id = item.getItemId();
        switch (id) {
            case R.id.nav_setting:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                Intent intt = new Intent(MainActivity.this, SettingActivity.class);
                startActivity(intt);
                break;
            case R.id.nav_detail:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                Intent inttt = new Intent(MainActivity.this, TeacherFilterActivity.class);
                startActivity(inttt);
                break;
            case R.id.nav_phone:
            case R.id.nav_roll:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                break;
            case R.id.nav_logout:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                Sessions sessions = new Sessions(MainActivity.this, Sessions.SESSION_USER);
                sessions.logOutUserSession();
                Intent i = new Intent(MainActivity.this, LoginActivity.class);
                startActivity(i);
                finish();
                break;
            case R.id.nav_share:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                share(MainActivity.this, "");
                break;
            case R.id.nav_rate:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                startActivity(new Intent(Intent.ACTION_VIEW,
                        Uri.parse("http://play.google.com/store/apps/details?id=" + BuildConfig.APPLICATION_ID)));
                break;
            case R.id.nav_about:
                mdrawerLayout.closeDrawer(GravityCompat.START);
                Intent in = new Intent(MainActivity.this, AboutActivity.class);
                startActivity(in);
                break;
        }
        return true;
    }


    //after share button clicked................................
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


    //Starting socket server.............................................
    private class SocketServerThread extends Thread {
        static final int SOCKET_SERVER_PORT = 9000;//socket server port...........................

        @Override
        public void run() {
            Socket socket = null;
            DataInputStream dataInputStream = null;
            DataOutputStream dataOutputStream = null;

            try {
                serverSocket = new ServerSocket(SOCKET_SERVER_PORT);

                while (true) {
                    socket = serverSocket.accept();
                    dataInputStream = new DataInputStream(socket.getInputStream());
                    dataOutputStream = new DataOutputStream(socket.getOutputStream());

                    UID = dataInputStream.readUTF();
                    UserName = dataInputStream.readUTF();
                    Sem = dataInputStream.readUTF();
                    dep = dataInputStream.readUTF();
                    shi = dataInputStream.readUTF();

                    if (UID.equals("")) {
                        dataOutputStream.writeUTF("404");
                    } else {
                        boolean found = false;
                        Log.e("1.socket.....................................",dep+"--"+facultyValue);
                        if(dep.equals(facultyValue)){
                            if(Sem.equals(semesterValue)){

                                if(shi.equals(shiftValue)){

                                    for (int i = 0; i < deviceUID_LIST.size(); i++) {
                                        if (deviceUID_LIST.get(i).equals(UID)) {
                                            found = true;
                                            break;
                                        }
                                    }

                                }else{
                                    found=true;
                                    dataOutputStream.writeUTF("503");
                                }
                            }else{
                                found=true;
                                dataOutputStream.writeUTF("502");
                            }
                        }else{
                            found= true;
                            dataOutputStream.writeUTF("501");
                        }

                        if (found)
                            dataOutputStream.writeUTF("420");
                        else {
                            deviceUID_LIST.add(UID);
                            rollNoList.add(UserName);
                            HashMap<String, String> DeviceID = new HashMap<>();
                            HashMap<String, String> USERID = new HashMap<>();
                            DeviceID.put("uid", UID);
                            USERID.put("username", UserName);
                            completeUIDList.add(DeviceID);
                            completeUSERList.add(USERID);
                            dataOutputStream.writeUTF("200");
                        }
                    }

                    MainActivity.this.runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            adapter.notifyDataSetChanged();
                            Toast.makeText(MainActivity.this, String.valueOf(deviceUID_LIST.size()), Toast.LENGTH_SHORT).show();
                        }
                    });


                }

            } catch (IOException e) {
                e.printStackTrace();
            } finally {

                if (socket != null) {
                    try {
                        socket.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (dataInputStream != null) {
                    try {
                        dataInputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

                if (dataOutputStream != null) {
                    try {
                        dataOutputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

            }
        }
    }

    //getting current IP for hotspot.....................
    private String getIpAddress() {
        String ip = "";
        try {
            Enumeration<NetworkInterface> enumNetworkInterfaces = NetworkInterface
                    .getNetworkInterfaces();
            while (enumNetworkInterfaces.hasMoreElements()) {
                NetworkInterface networkInterface = enumNetworkInterfaces
                        .nextElement();
                Enumeration<InetAddress> enumInetAddress = networkInterface
                        .getInetAddresses();
                while (enumInetAddress.hasMoreElements()) {
                    InetAddress inetAddress = enumInetAddress.nextElement();

                    if (inetAddress.isSiteLocalAddress()) {
                        ip += "SiteLocalAddress: "
                                + inetAddress.getHostAddress() + "\n";
                    }

                }

            }

        } catch (SocketException e) {
            e.printStackTrace();
            ip += "Something Wrong! " + e.toString() + "\n";
        }

        return ip;
    }


    //for QR code activity.................................
    @RequiresApi(api = Build.VERSION_CODES.R)
    private void initQRCode(WifiConfiguration config) {
        StringBuilder textToSend = new StringBuilder();
        textToSend.append("WIFI:S:" + config.SSID + ";T:WPA;P:" + config.preSharedKey + ";H:false;");
        MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
        try {
            BitMatrix bitMatrix = multiFormatWriter.encode(textToSend.toString(), BarcodeFormat.QR_CODE, 512, 512);
            BarcodeEncoder barcodeEncoder = new BarcodeEncoder();
            Bitmap bitmap = barcodeEncoder.createBitmap(bitMatrix);
            qr.setImageBitmap(bitmap);
            qr.setVisibility(View.VISIBLE);
            ssid.setText("SSID :- " + config.SSID);
            ssid.setVisibility(View.VISIBLE);
            key.setText("Password :- " + config.preSharedKey);
            key.setVisibility(View.VISIBLE);

        } catch (WriterException e) {
            e.printStackTrace();
        }
    }


    //getting location permission..................
    private void getLocationPermission() {
        if (!EasyPermissions.hasPermissions(this, Manifest.permission.ACCESS_FINE_LOCATION)) {
            EasyPermissions.requestPermissions(this, "This app needs this permission to function properly", RC_ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION);
        }
    }

    //turn on gps for hotspot..........................
    private void turnGPSOn() {
        final LocationManager manager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);

        if (!manager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            Intent intent1 = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
            startActivity(intent1);
        }


    }

}

