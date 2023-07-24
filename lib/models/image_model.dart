import 'dart:convert';

class ImageModel {
  final String timeStamp;
  final String url;
  ImageModel({
    required this.timeStamp,
    required this.url,
  });

  ImageModel copyWith({
    String? timeStamp,
    String? url,
  }) {
    return ImageModel(
      timeStamp: timeStamp ?? this.timeStamp,
      url: url ?? this.url,
    );
  }

  ImageModel.fromSnapshot(snapshot)
      : timeStamp = snapshot.data()['timeStamp'],
        url = snapshot.data()['url'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeStamp': timeStamp,
      'url': url,
    };
  }

  String toJson() => json.encode(toMap());
}
