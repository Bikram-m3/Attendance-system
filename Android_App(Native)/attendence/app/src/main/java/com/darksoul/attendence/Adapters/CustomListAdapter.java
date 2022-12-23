package com.darksoul.attendence.Adapters;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.darksoul.attendence.AttendanceLIst;
import com.darksoul.attendence.ListActivity;
import com.darksoul.attendence.MainActivity;
import com.darksoul.attendence.Models.AttendDetailModel;
import com.darksoul.attendence.R;

import java.util.ArrayList;

public class CustomListAdapter extends ArrayAdapter<AttendDetailModel> {
    public CustomListAdapter(Context context, ArrayList<AttendDetailModel> data) {
        super(context,0,data);
    }



    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        AttendDetailModel user = getItem(position);

        if (convertView == null) {

            convertView = LayoutInflater.from(getContext()).inflate(R.layout.custom_listview,parent,false);

        }

        TextView header =convertView.findViewById(R.id.tvName);

        TextView sideHeader = convertView.findViewById(R.id.tvHome);

        LinearLayout linearView=convertView.findViewById(R.id.linearView);

        linearView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(getContext(), AttendanceLIst.class);
                i.putExtra("uid",user.getUid());
                i.putExtra("day",user.getDay());
                i.putExtra("month",user.getMonth());
                i.putExtra("year",user.getYear());
                i.putExtra("teacherId",user.getTeacherID());
                i.putExtra("sub",user.getSubject());
                i.putExtra("depart",user.getDepart());
                i.putExtra("sem",user.getSemester());
                i.putExtra("shift",user.getShift());
                i.putExtra("auid",user.getUid());
                getContext().startActivity(i);
            }
        });



        header.setText(user.getDay()+"/"+user.getMonth()+"/"+user.getYear());

        sideHeader.setText("Sub :- "+user.getSubject()+"   Shift :- "+user.getShift()+"   Depart :- "+user.getDepart());


        return convertView;
    }
}
