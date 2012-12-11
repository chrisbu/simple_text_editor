import 'dart:html';

import '../lib/simple_text_editor.dart';

void main() {
  
  // use this style...
  var st = new SimpleTextEditor(
      attachTo:query("#container1"),
      showRawText:true,
      text:"<b>Editor</b> created with constructor");  
  
//  // or this style
//  var st1 = new SimpleTextEditor();
//  st1.showRawText = true;
//  st1.attach(query("#container2"));
//  st1.rawText = "<b>Editor</b> created with properties and methods";
}
