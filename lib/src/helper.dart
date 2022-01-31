import 'html_text_model.dart';

class HtmlTextHelper {
  // i - italic
  // b - bold
  // u - underline

  static String _convertHTML(String value) {
    var text = value
        .replaceAll('<i>', '%i')
        .replaceAll('</i>', '%i%')
        .replaceAll('<b>', '%b')
        .replaceAll('</b>', '%b%')
        .replaceAll('<u>', '%u')
        .replaceAll('</u>', '%u%')
        .replaceAll('src', '%p')
        .replaceAll('<img', '')
        .replaceAll(RegExp(r'<[^>]*>|&nbsp;|width="[0-9]*"'), '')
        .replaceAll(RegExp('class="[A-z| |-]*">'), '%p%');
    return text;
  }

  // NOTE separates the texts.
  static List<HtmlTextModel> mountText(String value) {
    var texto = _convertHTML(value);
    List<HtmlTextModel> list = <HtmlTextModel>[];

    while (texto.isNotEmpty) {
      var i = texto.indexOf('%');
      // NOTE check if it only has text in normal format
      if (i == -1) {
        list.add(HtmlTextModel(text: texto, format: HtmlTextFormat.normal));
        break;
      }

      var fragmentOne = _getFragment(texto);

      // NOTE add
      list.add(HtmlTextModel(text: fragmentOne, format: HtmlTextFormat.normal));
      // NOTE remove the part that has already been saved
      texto = _removeFragment(texto, fragmentOne);

      // NOTE get the format of which the text is
      HtmlTextFormat format;
      switch (texto.substring(0, 2)) {
        case '%i':
          format = HtmlTextFormat.italic;
          break;
        case '%b':
          format = HtmlTextFormat.bold;
          break;
        case '%u':
          format = HtmlTextFormat.underline;
          break;
        case '%p':
          format = HtmlTextFormat.image;
          break;
        default:
          format = HtmlTextFormat.normal;
          break;
      }

      // NOTE remove the first tag
      texto = _replaceStepOne(texto);
      // detecta o final
      var fragmentTwo = _getFragment(texto);
      if (format == HtmlTextFormat.image) {
        var fragmentTwoImage = fragmentTwo.replaceAll(RegExp('="|"'), '');
        list.add(HtmlTextModel(text: fragmentTwoImage, format: format));
      } else {
        list.add(HtmlTextModel(text: fragmentTwo, format: format));
      } // NOTE remove the part that has already been saved
      texto = _removeFragment(texto, fragmentTwo);

      // NOTE remove the second tag
      texto = _replaceStepTwo(texto);
    }

    return list;
  }

  static String _getFragment(String value) =>
      value.substring(0, value.indexOf('%'));

  static String _removeFragment(String value, String fragment) =>
      value.replaceFirst(fragment, '');
  static String _replaceStepOne(String value) =>
      value.replaceFirst(RegExp(r'%i|%b|%u|%p'), '');
  static String _replaceStepTwo(String value) =>
      value.replaceFirst(RegExp(r'%i%|%b%|%u%|%p%'), '');
}
