class DataModelStream{
  
  String stream;

  int responseStatus;

  List<dynamic> data;

  String action;

  var requestId;


  DataModelStream(
      {
        this.stream,
        this.responseStatus,
        this.requestId,
        this.action,
        this.data,
      });

  factory DataModelStream.fromJson(Map<String, dynamic> json){
    return DataModelStream(
      stream: json["stream"],
      responseStatus: json["response_status"],
      requestId: json["request_id"],
      action: json["action"],
      data: json["data"],
    );
  }
}