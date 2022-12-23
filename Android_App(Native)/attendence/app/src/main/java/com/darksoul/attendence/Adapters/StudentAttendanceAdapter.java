package com.darksoul.attendence.Adapters;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.darksoul.attendence.AttendanceLIst;
import com.darksoul.attendence.Models.AttendDetailModel;
import com.darksoul.attendence.Models.StudentAttendanceModel;
import com.darksoul.attendence.Models.TotalAttendanceModel;
import com.darksoul.attendence.R;
import com.darksoul.attendence.StudentAttendanceListActivity;

import java.util.ArrayList;

import retrofit2.Callback;

public class StudentAttendanceAdapter extends ArrayAdapter<TotalAttendanceModel> {
    public StudentAttendanceAdapter(Context context, ArrayList<TotalAttendanceModel> data) {
        super(context, 0,data);
    }


    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        TotalAttendanceModel user = getItem(position);

        ArrayList<StudentAttendanceModel> studentdata= StudentAttendanceListActivity.dataModel;


        if (convertView == null) {

            convertView = LayoutInflater.from(getContext()).inflate(R.layout.custom_listview,parent,false);

        }

        TextView header =convertView.findViewById(R.id.tvName);

        TextView sideHeader = convertView.findViewById(R.id.tvHome);

        LinearLayout linearView=convertView.findViewById(R.id.linearView);



        header.setText(user.getDay()+"/"+user.getMonth()+"/"+user.getYear());

        int count=0;
        for(int i=0;i<studentdata.size();i++){
            if(user.getAuid().equals( studentdata.get(i).getAuid())) {
                count++;
            }
        }

        if(count != 0) {
            sideHeader.setText("Status :- Present");
        }else{
            sideHeader.setText("Status :- Absent");
        }
        return convertView;
    }

}
