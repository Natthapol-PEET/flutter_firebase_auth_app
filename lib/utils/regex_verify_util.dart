/*
  username
    - ตัวอักษรใหญ่ เล็ก
    - ตัวเลข
    - อักขระพิเศษ !, @, #, $, -, _, &   (ถ้ามี)

  password
    - 8 digit
    - ตัวเลข
    - ตัวอักษรใหญ่ เล็ก
    - อักขระพิเศษ !, @, #, $, -, _, &
  */

class VerifyUtil {
  /* username */
  static RegExp engSinceThree = RegExp(r'^(?=.*[a-zA-Z]{3,}).{3,}$');
  static RegExp numberSinceOne = RegExp(r'^(?=.*[0-9]).*$');
  static RegExp usrCharIfThereIs =
      RegExp(r'^(?=.*[a-zA-Z]{3,})(?=.*[0-9]{1,})[a-zA-Z0-9!@#$_\-&]*$');

  /* password */
  static RegExp engSinceOne = RegExp(r'^(?=.*[a-zA-Z]).*$');
  static RegExp pwdCharSinceOne =
      RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$\-_&]).*$');

  static List<String> username(String txt) {
    List<String> list = [];

    if (!engSinceThree.hasMatch(txt)) {
      list.add('ต้องมีความยาวไม่น้อยกว่า 3 ตัว');
    }

    if (!numberSinceOne.hasMatch(txt)) {
      list.add('ต้องมีตัวเลขอย่างน้อย 1 ตัว');
    }

    if (!usrCharIfThereIs.hasMatch(txt)) {
      list.add('ห้ามใช้อักขระพิเศษที่นอกเหนือจาก !@#\$-_&');
    }

    return list;
  }

  static List<String> password(String txt) {
    List<String> list = [];

    if (txt.length < 8) {
      list.add('ต้องมีความยาวไม่น้อยกว่า 8 ตัว');
    }

    if (!engSinceOne.hasMatch(txt)) {
      list.add('ต้องมีตัวอักษรภาษาอังกฤษ อย่างน้อย 1 ตัว');
    }

    if (!numberSinceOne.hasMatch(txt)) {
      list.add('ต้องมีตัวเลข อย่างน้อย 1 ตัว');
    }

    if (!pwdCharSinceOne.hasMatch(txt)) {
      list.add('ต้องมีอักขระ !@#\$-_& อย่างน้อย 1 ตัว');
    }

    return list;
  }

  static List<String> phone(String txt) {
    List<String> list = [];

    if (txt.isEmpty) {
      list.add('ต้องไม่เป็นค่าว่าง');
    }

    if (txt.length != 10) {
      list.add('ต้องเป็นตัวเลขจำนวน 10 หลัก');
    }

    return list;
  }
}
