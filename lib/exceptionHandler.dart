class exceptionHandler{
  int register(String email, String name, String number, String interests, String password, String city, String confpass){
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
     if(name.length<2){
      return 2;
    }
    else if(number.length!=10) {
      return 3;
    }
    else if (password.length<6){
      return 4;
    }
    else if (city.length<4){
      return 5;
    }
    else if(confpass!=password){
      return 6;
    }
    return 0;
  }

}