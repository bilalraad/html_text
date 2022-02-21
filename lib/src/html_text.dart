import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import 'helper.dart';
import 'html_text_model.dart';

class HtmlText extends StatelessWidget {
  final String value;
  final int? maxLines;

  HtmlText(this.value, {Key? key, this.maxLines}) : super(key: key);

  FontWeight get _normal => FontWeight.w400;
  Document? get parsedHTML => parse(value);

  TextStyle get _style => GoogleFonts.montserrat(
      fontSize: 20, fontWeight: _normal, color: Colors.black);

  FontWeight _getFontWeight(HtmlTextFormat value) {
    switch (value) {
      case HtmlTextFormat.bold:
        return FontWeight.bold;
      default:
        return _normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    var texts = HtmlTextHelper.mountText(value);

    var first = texts.first;
    texts = texts.where((e) => e.text != first.text).toList();

    return RichText(
      maxLines: maxLines,
      text: TextSpan(
        text: first.text,
        style: _style.copyWith(
          fontWeight: _getFontWeight(first.format),
          decoration: first.format == HtmlTextFormat.underline
              ? TextDecoration.underline
              : TextDecoration.none,
          fontStyle: first.format == HtmlTextFormat.italic
              ? FontStyle.italic
              : FontStyle.normal,
        ),
        children: texts.map((e) {
          if (e.format != HtmlTextFormat.image) {
            return TextSpan(
              text: e.text,
              style: _style.copyWith(
                fontWeight: _getFontWeight(e.format),
                decoration: e.format == HtmlTextFormat.underline
                    ? TextDecoration.underline
                    : TextDecoration.none,
                fontStyle: e.format == HtmlTextFormat.italic
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            );
          } else {
            return WidgetSpan(
              child: CachedNetworkImage(
                imageUrl: e.text,
                placeholder: (context, url) => Container(
                    padding: const EdgeInsets.all(6.0),
                    child: CircularProgressIndicator()),
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}
