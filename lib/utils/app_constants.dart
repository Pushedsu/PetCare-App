class appConstants {
  static RegExp nameRegExp = RegExp(r"^(?=.*[a-z0-9])[a-z0-9]{2,16}$");
  static RegExp emailRegExp =  RegExp(r"^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"); //영문자로 시작하는 영문자 또는 숫자 6~20자
  static RegExp passwordRegExp =  RegExp(r"^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}"); //8 ~ 16자 영문, 숫자 조합
  static RegExp deleteImgRegExp = RegExp(r'profileImg\/[^\s]+');
}