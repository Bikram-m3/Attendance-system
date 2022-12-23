package com.darksoul.attendence;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class Devices extends AppCompatActivity {

    private ListView ClientList;
    ArrayList<String> deviceID_LIST;
    ArrayList<String> rollNoList;
    ArrayAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_device_list);
        ClientList=findViewById(R.id.client_list);
        deviceID_LIST = new ArrayList<>();
        rollNoList = new ArrayList<>();
        adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, rollNoList);
        ClientList.setAdapter(adapter);

        Devices.this.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                adapter.notifyDataSetChanged();
                Toast.makeText(Devices.this, String.valueOf(deviceID_LIST.size()), Toast.LENGTH_SHORT).show();
            }
        });

    }

}