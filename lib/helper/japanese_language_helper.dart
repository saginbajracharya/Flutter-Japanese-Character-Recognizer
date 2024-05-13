// 1 Identify Japanese Characters in the Text
// 2 Identify Hiragana, Katakana, and Kanji
// 3 Identify Single byte[Half-width] & Double Byte[Full-width] Characters

import 'package:get/get.dart';
import 'package:jp_text_recognizer/controller/main_controller.dart';

class JapaneseLanguageHelper {
  final MainController mainCon = Get.put(MainController()); 

  String identifyJpCharacters(String text){
    // \u3040-\u30FF: Range for Hiragana and Katakana characters.
    // \u3400-\u4DBF: Range for CJK [Chinese, Japanese, and Korean] Unified Ideographs Extension A.
    // \u4E00-\u9FFF: Range for CJK [Chinese, Japanese, and Korean] Unified Ideographs. The range \u4E00-\u9FFF covers a wide array of Kanji characters
    // \uF900-\uFAFF: Range for CJK [Chinese, Japanese, and Korean] Compatibility Ideographs.
    String message = '';
    bool textContainsJapanese = false;
    RegExp regex = RegExp(r'[\u3040-\u30FF\u3400-\u4DBF\u4E00-\u9FFF\uF900-\uFAFF]');
    if(text.isNotEmpty){
      for (int i = 0; i < text.length; i++) {
        String character = text[i];
        if (regex.hasMatch(character)==true) {
          textContainsJapanese = true;
          message = '$character is a Japanese Character';
          mainCon.historyList.add(message);
        }
        else if(regex.hasMatch(character)==false){
          textContainsJapanese = false;
          message = '$character is not a Japanese Character';
          mainCon.historyList.add(message);
        }
      }
      if(textContainsJapanese){
        message = 'In Given Text [ $text ] All characters are Japanese';
        mainCon.historyList.add(message);
      }
      else{
        message = 'In Given Text [ $text ] All characters are Not Japanese';
        mainCon.historyList.add(message);
      }
    }
    else{
      message = 'Empty Text';
    }
    return message;
  }

  String identifyJpCharacterType(String text){
    // \u3040-\u309F: Range for Hiragana.  There is no half-width version of the hiragana characters
    // \u30A0-\u30FF: Range for KataKana. 
    // \u4E00-\u9FFF: Range for Kanji , CJK [Chinese, Japanese, and Korean] Unified Ideographs. The range \u4E00-\u9FFF covers a wide array of Kanji characters
    // \u3400-\u4DBF: Range for CJK [Chinese, Japanese, and Korean] Unified Ideographs Extension A.
    // \uF900-\uFAFF: Range for CJK [Chinese, Japanese, and Korean] Compatibility Ideographs.
    String message = '';
    RegExp hiraganaRegex = RegExp(r'[\u3040-\u309F]'); // Hiragana (full-width)
    RegExp katakanaRegex = RegExp(r'[\u30A0-\u30FF\uFF65-\uFF9F]'); // Katakana (full-width + half-width)
    RegExp kanjiRegex = RegExp(r'[\u4E00-\u9FFF\uFF66-\uFF9F]'); // Kanji (full-width + half-width forms)
    RegExp unifiedIdeographsExtARegex   = RegExp(r'[\u3400-\u4DBF]'); // Unified Ideographs Extension A
    RegExp compatibilityIdeographsRegex = RegExp(r'[\uF900-\uFAFF]'); // compatibilityIdeographs
    if(text.isNotEmpty){
      for (int i = 0; i < text.length; i++) {
        String character = text[i];
        if (hiraganaRegex.hasMatch(character)==true) {
          message = '$character is a Japanese [ HIRAGANA ] Character';
          mainCon.historyList.add(message);
        }
        else if(katakanaRegex.hasMatch(character)==true){
          message = '$character is a Japanese [ KATAKANA ] Character';
          mainCon.historyList.add(message);
        }
        else if(kanjiRegex.hasMatch(character)==true){
          message = '$character is a Japanese [ KANJI ] Character';
          mainCon.historyList.add(message);
        }
        else if(unifiedIdeographsExtARegex.hasMatch(character)==true){
          message = '$character is a Japanese [ Unified Ideographs Extension A ] Character';
          mainCon.historyList.add(message);
        }
        else if(compatibilityIdeographsRegex.hasMatch(character)==true){
          message = '$character is a Japanese [ Compatibility Ideographs ] Character';
          mainCon.historyList.add(message);
        }
        else{
          message = '$character is [ NOT RECOGNIZED AS A JAPANESE OR CJK CHARACTERS ]';
          mainCon.historyList.add(message);
        }
      }
    }
    else{
      message = 'Empty Text';
    }
    return message;
  }

  String identifySingleOrDoubleByteJpChar(String text) {
    String message = '';
    if (text.isNotEmpty) {
      for (int i = 0; i < text.length; i++) {
        String character = text[i];
        // Check if the character is a single-byte character (ASCII range)
        if (character.codeUnitAt(0) <= 127) {
          message = '$character is a [ Single-Byte Character ]';
        } 
        // Check if the character is a full-width character
        else if ((character.codeUnitAt(0) >= 0xFF01 && character.codeUnitAt(0) <= 0xFF5E) || (character.codeUnitAt(0) >= 0xFF61 && character.codeUnitAt(0) <= 0xFF9F)) {
          message = '$character is a [ Full-Width Character ]';
        }
        // Otherwise, assume single-byte
        else {
          message = '$character is a [ Single-Byte Character ]';
        }
        mainCon.historyList.add(message);
      }
    } else {
      message = 'Empty Text';
    }
    return message;
  }
}