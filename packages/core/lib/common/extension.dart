extension UnixMilliToDate on int {
  String toMonthAndYear() {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    final months = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    return "$month $year";
  }
}
