package com.darksoul.attendence.Database;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import androidx.annotation.Nullable;

import java.util.ArrayList;

public class DatabaseHelper extends SQLiteOpenHelper {
    public DatabaseHelper(Context context) {
        super(context,"Attendance.db",null,1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("create Table AttendanceDetail(uid TEXT primary key,year TEXT,month TEXT,day TEXT,teacherID TEXT,sub TEXT,depart TEXT,sem TEXT,shift TEXT)");
        db.execSQL("create Table Attendance(uid TEXT,username TEXT,device TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("drop Table if exists AttendanceDetail");
        db.execSQL("drop Table if exists Attendance");
    }

    public Boolean insertData(String uid,String year,String month,String day,String teacherID,String sub,String depart,String sem,String shift){
        SQLiteDatabase db=this.getWritableDatabase();
        ContentValues contentValues= new ContentValues();
        contentValues.put("uid",uid);
        contentValues.put("year",year);
        contentValues.put("month",month);
        contentValues.put("day",day);
        contentValues.put("teacherID",teacherID);
        contentValues.put("sub",sub);
        contentValues.put("depart",depart);
        contentValues.put("sem",sem);
        contentValues.put("shift",shift);

        long result=db.insert("AttendanceDetail",null,contentValues);

        if(result==-1){
            return false;
        }else{
            return true;
        }
    }


    public Cursor getHeaderData(){
        SQLiteDatabase db=this.getWritableDatabase();
        String query="SELECT * FROM AttendanceDetail";
        Cursor data= db.rawQuery(query,null);
        return data;
    }


    public Boolean insertAttendanceData(String uid, ArrayList<String> rollList,ArrayList<String> deviceList){
        SQLiteDatabase db=this.getWritableDatabase();
        for(int i=0;i<rollList.size();i++){
            String Query="INSERT INTO Attendance (uid,username,device) VALUES('" +uid+ "','" +rollList.get(i)+ "','" +deviceList.get(i)+ "');";
            db.execSQL(Query);
        }
        db.close();

        return true;
    }

    public Boolean insertSingleAttendData(String uid, String rollList,String device){
        SQLiteDatabase db=this.getWritableDatabase();
        String Query="INSERT INTO Attendance (uid,username,device) VALUES('" +uid+ "','" +rollList+ "','" +device+ "');";
        db.execSQL(Query);
        db.close();

        return true;
    }


    public Boolean deleteAttendData(String uid){
        SQLiteDatabase db=this.getWritableDatabase();
        String Query1="DELETE FROM Attendance WHERE uid='" +uid+ "';";
        String Query2="DELETE FROM AttendanceDetail WHERE uid='" +uid+ "';";
        db.execSQL(Query1);
        db.execSQL(Query2);
        db.close();

        return true;
    }


    public Cursor getListData(String uid){
        SQLiteDatabase db=this.getWritableDatabase();
        String query="SELECT * FROM Attendance where uid='" +uid+ "'";
        Cursor data= db.rawQuery(query,null);
        Log.e("wifi......................................................", String.valueOf(data.getCount()));
        return data;
    }


}
