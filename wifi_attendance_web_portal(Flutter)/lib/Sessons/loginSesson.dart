import 'dart:html';

class loginSesson {
  final Storage _localStorage = window.localStorage;

  Future save(String id) async {
    _localStorage['ID'] = id;
  }

  Future<String?> getId() async => _localStorage['ID'];

  bool getisLogin(){
    String uid='';
    getId().then((value) => uid=value!);
    if(uid==''){
      return false;
    }else{
      return true;
    }
  }

  Future logout() async {
    _localStorage.remove('ID');
  }
}