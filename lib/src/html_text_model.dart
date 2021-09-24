class HtmlTextModel {
  final String text;
  final HtmlTextFormat format;

  HtmlTextModel({this.text, this.format});

  Map<String, dynamic> toJson() => {
        'text': text,
        'format': format
      };

  @override
  String toString() => toJson().toString();
}

enum HtmlTextFormat { normal, bold, italic, underline }
