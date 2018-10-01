

class DayOfJob {
    
    DateTime jobDay; 
    DateTime entry; 
    DateTime goLauch; 
    DateTime returnLauch; 
    DateTime endDay;

    DayOfJob(this.jobDay, this.entry, this.goLauch, this.returnLauch, this.endDay);

    DayOfJob.fromJson(Map<String, dynamic> json)
          : jobDay = json['jobDay'], 
            entry = json['entry'], 
            goLauch = json['goLauch'], 
            returnLauch = json['returnLauch'], 
            endDay = json['endDay'];
    Map<String, dynamic> toJson() => 
    {
        'jobDay' : jobDay,
        'entry' : entry,
        'goLauch' : goLauch,
        'returnLauch' : returnLauch,
        'endDay' : endDay,
    };

    String get dayFormatPtBr =>
      '${jobDay.day}/${jobDay.month.toString()}/${jobDay.year}';

    String hourFormatPtBr(DateTime period) =>
        period != null ? 
          '${_getFormatedNumber(period.hour)}:${_getFormatedNumber(period.minute)}:${_getFormatedNumber(period.second)}' 
          : 'nenhum registro encontrado';

      
  String _getFormatedNumber(int numbe) {
    if (numbe < 11 ) {
      return '0${numbe}';
    }
    return '${numbe}';
  }
}