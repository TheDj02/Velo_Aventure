class UserModel {
  final String email4;
  final String password4;
  String uid;

  UserModel({
    this.uid,
    this.email4,
    this.password4
  });

  set setUid(value) => uid =value;



  Map<String, dynamic> toJson() =>
      {
        'uid': uid,
        '_email4': email4,
        '_password4': password4,
      };
}