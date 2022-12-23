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
import com.darksoul.attendence.Models.TotalAttendanceModel;
import com.darksoul.attendence.R;
import com.darksoul.attendence.TeacherAttendanceSingleList;

import java.util.ArrayList;

public class CustomTeacherAttendanceAdapter extends ArrayAdapter<TotalAttendanceModel> {
    public CustomTeacherAttendanceAdapter(Context context, ArrayList<TotalAttendanceModel> data) {
        super(context,0,data);
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        TotalAttendanceModel user = getItem(position);

        if (convertView == null) {

            convertView = LayoutInflater.from(getContext()).inflate(R.layout.custom_listview,parent,false);

        }

        TextView header =convertView.findViewById(R.id.tvName);

        TextView sideHeader = convertView.findViewById(R.id.tvHome);

        LinearLayout linearView=convertView.findViewById(R.id.linearView);

        linearView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(getContext(), TeacherAttendanceSingleList.class);
                i.putExtra("day",String.valueOf(user.getDay()));
                i.putExtra("month",String.valueOf(user.getMonth()));
                i.putExtra("year",String.valueOf(user.getYear()));
                i.putExtra("depart",user.getDepart());
                i.putExtra("sem",user.getSem());
                i.putExtra("shift",user.getShift());
                i.putExtra("batch",user.getBatch());
                i.putExtra("auid",user.getAuid());
                getContext().startActivity(i);
            }
        });



        header.setText(user.getDay()+"/"+user.getMonth()+"/"+user.getYear());



        return convertView;
    }



}
