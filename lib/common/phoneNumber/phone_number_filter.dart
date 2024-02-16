String phoneNumberFilter(String userNumber) {
  if (userNumber[0] == "0") {
    String formattedNumber = userNumber.replaceFirst("0", "255");
    return formattedNumber;
  } else if (userNumber[0] == "+") {
    String formattedNumber = userNumber.substring(1);

    return formattedNumber;
  } else {
    return 'invalid format';
  }
}
