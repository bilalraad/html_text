class ImageAddress {
  String url;
  int start;
  int end;
  ImageAddress({
    required this.url,
    required this.start,
    required this.end,
  });
}

class ImageHelper {
  static List<ImageAddress> findImageAddressTags(String value) {
    int imageStartIndex = 0;
    int imageEndIndex = 0;
    List<ImageAddress> imagesAddress = [];
    while (value.isNotEmpty) {
      imageStartIndex = value.indexOf(RegExp('<img'));
      if (imageStartIndex == -1) {
        break;
      } else {
        // TODO: Melhorar algoritmo
        for (int i = imageStartIndex; i < value.length; i++) {
          if (value[i] == '>') {
            imageEndIndex = i;
            break;
          }
        }
        var url = value.substring(imageStartIndex, imageEndIndex + 1);
        imagesAddress.add(ImageAddress(
          url: url,
          start: imageStartIndex,
          end: imageEndIndex + 1,
        ));
        value = value.replaceAll(url, '');
      }
    }
    return imagesAddress;
  }

  static String convertToUrl(String value) {
    int start = value.indexOf(RegExp('src="'));
    int end = value.indexOf(RegExp('.png"|.jpg"'));
    return ' %p' + value.substring(start + 5, end + 4) + '%p% ';
  }

  static bool containsImageTags(String value) {
    return value.contains('<img');
  }

  static String highlightImage(String value) {
    var imagesAddress = findImageAddressTags(value);
    for (var img in imagesAddress) {
      value = value.replaceAll(img.url, convertToUrl(img.url));
    }
    return value;
  }
}
