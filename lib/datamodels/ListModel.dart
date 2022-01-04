class ListModel{
  int? _id;
  String? _listtitle;
  int? _listid;
  String? _createddate;
  String? _createdtime;
  String? _status;
  String? _remindat;
  String? _createdby;
  ListModel(this._listtitle,this._listid,this._createddate,this._createdtime,
      this._status,this._remindat,this._createdby);

  int? get id => _id;
  String? get listtitle => _listtitle;
  int? get listid => _listid;
  String? get createddate => _createddate;
  String? get createdtime => _createdtime;
  String? get status => _status;
  String? get remindat => _remindat;
  String? get createdby => _createdby;


  set listtitle(String? newlisttitle) {
    this._listtitle = newlisttitle;
  }
  set listid(int? newlistid) {
    this._listid = newlistid;
  }
  set createddate(String? newcreateddate) {
    this._createddate = newcreateddate;
  }
  set createdtime(String? newcreatedtime) {
    this._createdtime = newcreatedtime;
  }

  set status(String? newstatus) {
    this._status = newstatus;
  }
  set remindat(String? newremindat) {
    this._remindat = newremindat;
  }
  set createdby(String? newcreatedby) {
    this._createdby = newcreatedby;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['listtitle'] = _listtitle;
    map['listid'] = _listid;
    map['createddate'] = _createddate;
    map['createdtime'] = _createdtime;
    map['status'] = _status;
    map['remindat'] = _remindat;
    map['createdby'] = _createdby;

    return map;
  }

  // Extract a Note object from a Map object
  ListModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._listtitle = map['listtitle'];
    this._listid = map['listid'];
    this._createddate = map['createddate'];
    this._createdtime = map['createdtime'];
    this._status = map['status'];
    this._remindat = map['remindat'];
    this._createdby = map['createdby'];
  }

}