class EmailRegistrationBloc {
  /*
    Method to validate email id, return true if email id is valid else return false
   */
  bool validateEmailId(String? strEmailId) {
    if (strEmailId == null || strEmailId.isEmpty) return false;
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(strEmailId);
  }
}

final bloc = EmailRegistrationBloc();
