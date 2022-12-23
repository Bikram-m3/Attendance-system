package com.darksoul.attendence.SessionManager;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

public class Sessions {

    SharedPreferences userSession;
    SharedPreferences.Editor editor;

    Context context;

    public static final String SESSION_USER="userLoginSession";
    public static final String SESSION_REMEMBER="rememberMe";

    private static final String IS_LOGIN = "IsLoggedIn";
    public static final boolean IS_FIRST_TIME = true;
    public static final String KEY_FULLNAME ="name";
    public static final String KEY_EMAIL ="email";
    public static final String KEY_PHONE ="phone";
    public static final String KEY_USERID ="uid";
    public static final String KEY_SEM ="sem";
    public static final String KEY_SHIFT ="shift";
    public static final String KEY_BATCH ="batch";

    //for remember me session........
    private static final String IS_REMEMBER = "IsRememberMe";
    public static final String KEY_USERNAME ="username";
    public static final String KEY_PASSWORD ="password";
    public static final String KEY_ROLL ="roll";
    public static final String KEY_ROLE ="role";



    public static final String KEY_ATTEND_DETAIL ="attendDetail";

    //department....................................
    public static final String KEY_DEPART ="depart";



    public Sessions(Context contextt, String sesson){
        context=contextt;
        userSession=context.getSharedPreferences(sesson,Context.MODE_PRIVATE);
        editor=userSession.edit();
    }

    public void createLoginSession(String name,String username,String phone,String uid,String sem,String depart,String shift,String roll,int role,String batch){
        editor.putString(IS_LOGIN,"true");
        editor.putString(KEY_FULLNAME,name);
        editor.putString(KEY_USERNAME,username);
        editor.putString(KEY_PHONE,phone);
        editor.putString(KEY_USERID,uid);
        editor.putString(KEY_SEM,sem);
        editor.putString(KEY_DEPART,depart);
        editor.putString(KEY_SHIFT,shift);
        editor.putInt(KEY_ROLE,role);
        editor.putString(KEY_ROLL,roll);
        editor.putString(KEY_BATCH,batch);
        editor.commit();
    }


    public void DepartmentSession(Set<String> data){
        editor.putStringSet(KEY_DEPART,data);
        editor.commit();
    }


    public Set<String> getDepartment(){
        Set<String> depart=userSession.getStringSet(KEY_DEPART,null);
        return depart;
    }


    public void SubjectSession(String KEY,Set<String> data){
        editor.putStringSet(KEY,data);
        editor.commit();
    }

    public Set<String> getSubject(String KEY){
        Set<String> sub=userSession.getStringSet(KEY,null);
        return sub;
    }




    public HashMap<String,String> getUserDataFromSession(){
        HashMap<String,String> userData = new HashMap<String,String>();

        userData.put(KEY_FULLNAME,userSession.getString(KEY_FULLNAME,null));
        userData.put(KEY_EMAIL,userSession.getString(KEY_EMAIL,null));
        userData.put(KEY_PHONE,userSession.getString(KEY_PHONE,null));
        userData.put(KEY_USERID,userSession.getString(KEY_USERID,null));

        return userData;
    }

    public boolean checkLogin(){
        if(userSession.getString(IS_LOGIN,null)==null){
            return false;
        }else{
            return true;
        }
    }

    public int getRole(){
        int role=userSession.getInt(KEY_ROLE,0);
        return role;
    }

    public String getRoll(){
        String roll=userSession.getString(KEY_ROLL,null);
        return roll;
    }

    public String getBatch(){
        String batch=userSession.getString(KEY_BATCH,null);
        return batch;
    }

    public String getPhone(){
        String phone=userSession.getString(KEY_PHONE,null);
        return phone;
    }

    public String getSem(){
        String sem=userSession.getString(KEY_SEM,null);
        return sem;
    }

    public String getDepart(){
        String depart=userSession.getString(KEY_DEPART,null);
        return depart;
    }
    public String getShift(){
        String shift=userSession.getString(KEY_SHIFT,null);
        return shift;
    }

    public String getUser(){
        String user=userSession.getString(KEY_USERNAME,null);
        return user;
    }

    public String getName(){
        String user=userSession.getString(KEY_FULLNAME,null);
        return user;
    }

    public String getUID(){
        String uid=userSession.getString(KEY_USERID,null);
        return uid;
    }

    public void logOutUserSession(){
        editor.clear();
        editor.commit();
    }

    //for remember me button...........
    public void createRememberMeSession(String username,String password){
        editor.putString(IS_REMEMBER,"true");
        editor.putString(KEY_PASSWORD,password);
        editor.putString(KEY_USERNAME,username);
        editor.commit();
    }

    public HashMap<String,String> getRememberMeFromSession(){
        HashMap<String,String> userData = new HashMap<String,String>();

        userData.put(KEY_USERNAME,userSession.getString(KEY_USERNAME,null));
        userData.put(KEY_PASSWORD,userSession.getString(KEY_PASSWORD,null));
        return userData;
    }

    public boolean checkRememberMe(){
        if(userSession.getString(IS_REMEMBER,null)==null){
            return false;
        }else{
            return true;
        }
    }

}
