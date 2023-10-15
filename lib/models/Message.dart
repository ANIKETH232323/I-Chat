class Message {
  Message({
    required this.msg,
    required this.formId,
    required this.read,
    required this.told,
    required this.type,
    required this.sent,
  });
  late final String msg;
  late final String formId;
  late final String read;
  late final String told;
  late final String sent;
  late final Type type;


  Message.fromJson(Map<String, dynamic> json){
    msg = json['msg'].toString();
    formId = json['formId'].toString();
    read = json['read'].toString();
    told = json['told'].toString();
    type = json['type'].toString() ==Type.image.name ? Type.image :Type.text;
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['formId'] = formId;
    _data['read'] = read;
    _data['told'] = told;
    _data['type'] = type.name;
    _data['sent'] = sent;
    return _data;
  }

}

enum Type {text,image}