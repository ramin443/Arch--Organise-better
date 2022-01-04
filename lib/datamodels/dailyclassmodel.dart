class DailyClassModel{
  int? _id;
  String? _date;
  String? _classtitle;
  String? _classlocation;
  String? _starttime;
  String? _endtime;
  DailyClassModel(this._classtitle,this._classlocation,this._date,this._starttime,this._endtime);

  int? get id => _id;
  String? get date => _date;
  String? get classtitle => _classtitle;
  String? get classlocation => _classlocation;
  String? get starttime => _starttime;
  String? get endtime => _endtime;

  set date(String? newdate) {
      this._date = newdate;
  }
  set classtitle(String? newclasstitle) {
    this._classtitle = newclasstitle;
  }
  set classlocation(String? newlocation) {
    this._classlocation = newlocation;
  }
  set starttime(String? newstarttime) {
      this._starttime = newstarttime;
  }

  set endtime(String? newendtime) {
    this._endtime = newendtime;
  }
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['classtitle'] = _classtitle;
    map['classlocation'] = _classlocation;
    map['date'] = _date;
    map['starttime'] = _starttime;
    map['endtime'] = _endtime;

    return map;
  }

  // Extract a Note object from a Map object
  DailyClassModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._classtitle = map['classtitle'];
    this._classlocation = map['classlocation'];
    this._date = map['date'];
    this._starttime = map['starttime'];
    this._endtime = map['endtime'];
  }

}