class SummarizeFileModel {
  String? extractedText;

  SummarizeFileModel({this.extractedText});

  SummarizeFileModel.fromJson(Map<String, dynamic> json) {
    extractedText = json['extracted_text'];
  }

 
}


class SummarizeTextModel {
  String? summary;

  SummarizeTextModel({this.summary});

  SummarizeTextModel.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
  }

 
}