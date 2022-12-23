package com.darksoul.attendence;

import androidx.appcompat.app.AppCompatActivity;

import android.database.Cursor;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.darksoul.attendence.Adapters.CustomListAdapter;
import com.darksoul.attendence.Database.DatabaseHelper;
import com.darksoul.attendence.Models.AttendDetailModel;

import java.util.ArrayList;

public class ListActivity extends AppCompatActivity {

    private ImageView backBtn;
    private ListView listView;

    @Override
    protected void onResume() {
        super.onResume();
//        finish();
//        startActivity(getIntent());
    }

    private TextView error;
    DatabaseHelper db;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list);

        error=findViewById(R.id.listError);
        // Back button work..................................
        backBtn=findViewById(R.id.about_back);
        backBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        //listView work.......................................
        listView=findViewById(R.id.listView);
        db=new DatabaseHelper(this);

        ListViewData();

    }

    private void ListViewData() {
        Cursor data=db.getHeaderData();
        ArrayList<AttendDetailModel> listData=new ArrayList<AttendDetailModel>();
        int count=0;
        while (data.moveToNext()){
            AttendDetailModel temp = new AttendDetailModel(data.getString(6),data.getString(7),data.getString(5),data.getString(4),data.getString(0),data.getString(1),data.getString(2),data.getString(3),data.getString(8));
            listData.add(count,temp);
            count++;
        }

        Log.e("wifi...............................................", String.valueOf(data.getCount()));
        if(data.getCount()!=0){
            CustomListAdapter adapter=new CustomListAdapter(this,listData);

            listView.setAdapter(adapter);
        }else{
            listView.setVisibility(View.GONE);
            error.setVisibility(View.VISIBLE);
        }
    }

}