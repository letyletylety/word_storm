import 'package:flutter_test/flutter_test.dart';
import 'package:word_storm_drift/create_csv_File.dart' as wordprocessing;

void main() {
  test('word collector ...', () async {
    await wordprocessing.createAllWordsCSVFile();
  });

  test('특수문자 테스트 - 물범.', () {
    expect(
      ['물범', '호랑이'],
      '물범.,호랑이.'
          .split(RegExp('.,'))
          .map(
            (string) =>
                string.trim().replaceAll(RegExp(r'[^a-zA-Z0-9가-힣]'), ''),
          )
          .toList(),
    );
  });
}
