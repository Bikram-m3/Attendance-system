package com.darksoul.attendence.Adapters;

import android.content.Context;
import android.content.Intent;
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
import com.darksoul.attendence.Models.SingleDateAttendanceModel;
import com.darksoul.attendence.R;

import java.util.ArrayList;

public class CustomSingleAteendanceAdapter extends ArrayAdapter<SingleDateAttendanceModel> {
    public CustomSingleAteendanceAdapter(Context context, ArrayList<SingleDateAttendanceModel> data) {
        super(context,0,data);
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        SingleDateAttendanceModel user = getItem(position);

        if (convertView == null) {

            convertView = LayoutInflater.from(getContext()).inflate(R.layout.custom_listview,parent,false);

        }

        TextView header =convertView.findViewById(R.id.tvName);

        TextView sideHeader = convertView.findViewById(R.id.tvHome);


        header.setText(user.getName());

        sideHeader.setText("Roll :- "+user.getRoll());


        return convertView;
    }
}
