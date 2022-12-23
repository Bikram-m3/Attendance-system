import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/Models/countModel.dart';

import '../../ApiManagers/adminApi.dart';

class DashboardMain extends StatefulWidget {
  final String routeName;
  const DashboardMain({Key? key,required this.routeName}) : super(key: key);

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {

  late Future<List<countModel>> _loadedData;
  int BECE=0,BESE=0,BEIT=0,BECIVIL=0,BCA=0,BEELX=0,Total=0;

  bool getWidth(double width){
    if(width<1200.0){
      return true;
    }else{
      return false;
    }
  }


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: getWidth(MediaQuery.of(context).size.width) ? const EdgeInsets.only(left: 100,right: 100) : const EdgeInsets.only(left: 250,right: 250),
      margin: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
      ),
      child: FutureBuilder<List<countModel>>(
        future: _loadedData,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(child: Text("No Record Found !!!",style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            );
          }else if(snapshot.hasData){
            sortData(snapshot.data!);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total Students",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 5,),
                          Container(height: 1.5,color: Colors.black,),
                          const SizedBox(height: 10,),
                          Text(Total.toString(),style: const TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                    const SizedBox(width: 150,),
                    Container(
                      height: 80,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total BECE Students",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 5,),
                          Container(height: 1.5,color: Colors.black,),
                          const SizedBox(height: 10,),
                          Text(BECE.toString(),style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total BEIT Students",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 5,),
                          Container(height: 1.5,color: Colors.black,),
                          const SizedBox(height: 10,),
                          Text(BEIT.toString(),style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                    const SizedBox(width: 150,),
                    Container(
                      height: 80,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total BECIVIL Students",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 5,),
                          Container(height: 1.5,color: Colors.black,),
                          const SizedBox(height: 10,),
                          Text(BECIVIL.toString(),style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total BESE Students",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 5,),
                          Container(height: 1.5,color: Colors.black,),
                          const SizedBox(height: 10,),
                          Text(BESE.toString(),style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                    const SizedBox(width: 150,),
                    Container(
                      height: 80,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total BEELX Students",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 5,),
                          Container(height: 1.5,color: Colors.black,),
                          const SizedBox(height: 10,),
                          Text(BEELX.toString(),style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total BCA Students",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 5,),
                          Container(height: 1.5,color: Colors.black,),
                          const SizedBox(height: 10,),
                          Text(BCA.toString(),style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  void _loadData() {
    _loadedData=adminApi().countList();
  }

  void sortData(List<countModel> list) {
    print(list.length);
    for(int i=0;i<list.length;i++){
      if(list[i].faculty=="BECE"){
        BECE=list[i].count!;
      }else if(list[i].faculty=="BESE"){
        BESE=list[i].count!;
      }else if(list[i].faculty=="BEIT"){
        BEIT=list[i].count!;
      }else if(list[i].faculty=="BECIVIL"){
        BECIVIL=list[i].count!;
      }else if(list[i].faculty=="BCA"){
        BCA=list[i].count!;
      }else{
        BEELX=list[i].count!;
      }
    }
    Total=BECE+BESE+BEIT+BECIVIL+BCA+BEELX;

  }
}
