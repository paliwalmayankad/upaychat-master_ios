
class PendingRequestModels{
	String status;
	String message;
	List<PendingRequestData> pendingrequestlist;
	PendingRequestModels.map(dynamic obj){
		this.status=obj["status"];
		this.message=obj["message"];
		this.pendingrequestlist=(obj['data']as List).map((i)=>PendingRequestData.fromJson(i)).toList();
	}


}
class PendingRequestData{
	String amount;
	String timestamp;
	String transaction_type;
	String touser_id;
	String touser_name;
	String to_userimage;
	String message;
	String privacy;
	String caption;
	int id;

	PendingRequestData.fromJson(Map jsonMap)
			: amount = jsonMap['amount'],
				timestamp = jsonMap['timestamp'],
				transaction_type = jsonMap['transaction_type'],
				touser_id = jsonMap['touser_id'],
				touser_name = jsonMap['touser_name'],
				to_userimage = jsonMap['to_userimage'],
				message = jsonMap['message'],
				caption = jsonMap['caption'],
				id = jsonMap['id'],
				privacy = jsonMap['privacy']

	;
}