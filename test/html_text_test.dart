import 'package:flutter_test/flutter_test.dart';
import 'package:html_text/src/helper.dart';

void main() {
  test('Texto com imagem', () {
    HtmlTextHelper.mountText(
        '<p style=\"text-align: justify;\">(PUC RS) Utilize as partículas β<sup>+<\/sup> (beta-mais), β<sup>–<\/sup> (beta-menos) e α (alfa) para completar as lacunas dos decaimentos radioativos abaixo:<\/p><p style=\"text-align: justify;\"><img width=\"198\" src=\"https:\/\/saladosaber.com.br\/public\/uploads\/courses\/lessons\/1507_b93e_0907_ad27.png\" class=\"fr-fic fr-dii\"><\/p><p style=\"text-align: justify;\">Considerando que <img width=\"15\" src=\"https:\/\/saladosaber.com.br\/public\/uploads\/courses\/lessons\/1507_bece_0907_ad27.png\" class=\"fr-fic fr-dii\"> e <img width=\"15\" src=\"https:\/\/saladosaber.com.br\/public\/uploads\/courses\/lessons\/1507_0bc3_0907_ad27.png\" class=\"fr-fic fr-dii\">&nbsp;são, respectivamente, as representações do anti-neutrino do elétron e do neutrino do elétron, o correto preenchimento das lacunas, de cima para baixo, é<\/p>');
    expect(true, true);
  });
}
