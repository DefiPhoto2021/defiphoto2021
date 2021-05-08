class CalculTemps {
  static String dateTimeCalcString(String value) {
    DateTime datetime = DateTime.parse(value);
    Duration diff = DateTime.now().difference(datetime);
    if ((diff.inDays / 365).floor() > 0) {
      return 'Il y a ' + (diff.inDays / 365).floor().toString() + ' an(s)';
    } else if ((diff.inDays / 30).floor() > 0) {
      return 'Il y a ' + (diff.inDays / 30).floor().toString() + ' mois';
    } else if ((diff.inDays).floor() > 0) {
      return 'Il y a ' + (diff.inDays).floor().toString() + ' jour(s)';
    } else if ((diff.inHours).floor() > 0) {
      return 'Il y a ' + (diff.inHours).floor().toString() + ' heure(s)';
    } else if ((diff.inMinutes).floor() > 0) {
      return 'Il y a ' + (diff.inMinutes).floor().toString() + ' minute(s)';
    } else if ((diff.inSeconds).floor() > 0) {
      return 'Il y a ' + (diff.inSeconds).floor().toString() + ' seconde(s)';
    }
    return "";
  }
}
