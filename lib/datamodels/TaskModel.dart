class TaskModel{
  int? _id;
  String? _tasktitle;
  int? _listid;
  String? _location;
  String? _createddate;
  String? _createdtime;
  String? _timer;
  String? _subtasks;
  String? _status;
  String? _remindat;
  String? _notesorlinks;
  String? _createdby;
  TaskModel(this._tasktitle,this._listid,this._location,this._createddate,this._createdtime,this._timer,this._subtasks,
      this._status,this._remindat,this._notesorlinks,this._createdby);

  int? get id => _id;
  String? get tasktitle => _tasktitle;
  int? get listid => _listid;
  String? get location => _location;
  String? get createddate => _createddate;
  String? get createdtime => _createdtime;
  String? get timer => _timer;
  String? get subtasks => _subtasks;
  String? get status => _status;
  String? get remindat => _remindat;
  String? get notesorlinks => _notesorlinks;
  String? get createdby => _createdby;

  set tasktitle(String? newtasktitle) {
    this._tasktitle = newtasktitle;
  }
  set listid(int? newlistid) {
    this._listid = newlistid;
  }
  set location(String? newclasslocation) {
    this._location = newclasslocation;
  }
  set createddate(String? newcreateddate) {
    this._createddate = newcreateddate;
  }
  set createdtime(String? newcreatedtime) {
    this._createdtime = newcreatedtime;
  }

  set timer(String? newtimer) {
    this._timer = newtimer;
  }
  set subtasks(String? nwsubtasks) {
    this._subtasks = nwsubtasks;
  }
  set status(String? newstatus) {
    this._status = newstatus;
  }
  set remindat(String? newremindat) {
    this._remindat = newremindat;
  }
  set notesorlinks(String? newnotesorlinks) {
    this._notesorlinks = newnotesorlinks;
  }
  set createdby(String? newcreatedby) {
    this._createdby = newcreatedby;
  }
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['tasktitle'] = _tasktitle;
    map['listid'] = _listid;
    map['location'] = _location;
    map['createddate'] = _createddate;
    map['createdtime'] = _createdtime;
    map['timer'] = _timer;
    map['subtasks'] = _subtasks;
    map['status'] = _status;
    map['remindat'] = _remindat;
    map['notesorlinks'] = _notesorlinks;
    map['createdby'] = _createdby;

    return map;
  }

  // Extract a Note object from a Map object
  TaskModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._tasktitle = map['tasktitle'];
    this._listid = map['listid'];
    this._location = map['location'];
    this._createddate = map['createddate'];
    this._createdtime = map['createdtime'];
    this._timer = map['timer'];
    this._subtasks = map['subtasks'];
    this._status = map['status'];
    this._remindat = map['remindat'];
    this._notesorlinks = map['notesorlinks'];
    this._createdby = map['createdby'];
  }

}