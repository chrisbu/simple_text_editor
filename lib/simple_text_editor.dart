library simple_text_editor;

import "dart:html";

class SimpleTextEditor {
 
  // set the raw text (innerHTML) of the editor element
  set rawText(String value) { 
    _textbox.innerHTML = value;
    _updateRawTextArea();
  }
  
  // read the raw text (innerHTML) of the editor element
  bool get showRawText => _rawTextArea != null;
  
  // toggle the raw text textarea on or off
  set showRawText(bool show) {
    if (!show && _rawTextArea != null) {
      _rawTextArea.remove();
    }
    else if (show) {
      _createRawTextArea();
      if (_attachTo != null) _attachRawTextArea(); // only attach if we have something to attach to
                                                   // otherwise it will be attached when attachTo() is called. 
    }
    // else, _rawTextArea is already null, so nothing to remove   
  }
  
  
  /*
   * use this style with the constructor
   *      var st = new SimpleTextEditor(
   *        attachTo:query("#container"),
   *        showRawText:true,
   *        text:"<b>Foo</b> Bar");  
   * 
   * or this style
   *       var st1 = new SimpleTextEditor();
   *       st1.showRawText = true;
   *       st1.attach(query("#container"));
   *       st1.rawText = "<b>Foo</b> Bar";
   */
  SimpleTextEditor({Element attachTo:null, bool showRawText:false, String text:""}) { 
    _textEditorContainer = new DivElement();
    _textEditorContainer.classes.add("texteditor");
    _textEditorContainer.children.add(_buildToolbar());
    _textEditorContainer.children.add(_buildEditor(text));  
    if (showRawText) {
      _createRawTextArea();
    }
    
    if (attachTo != null) {
      attach(attachTo);
    }
  }
  
  // attach the text editor to the element supplied
  void attach(Element attachTo) {
    this._attachTo = attachTo;
    this._attachTo.children.add(_textEditorContainer);
    _attachRawTextArea();
    _updateRawTextArea();
  }
 
  // **** Private properties and methods below ***
  
  Element _attachTo;
  DivElement _textbox;
  DivElement _toolbar;
  DivElement _textEditorContainer;
  TextAreaElement _rawTextArea;
  String get rawText => _textbox.innerHTML;
  
  void _attachRawTextArea() {
     if (this._rawTextArea != null) {
      _textEditorContainer.children.add(_rawTextArea);
    }
  }

  _buildEditor(String startingPointText) {
    _textbox = new DivElement();
    _textbox.classes.add("editbox");
    _textbox.innerHTML = startingPointText;
    _textbox.style.overflow =  "scroll";
    _textbox.contentEditable = "true";
    _textbox.on.keyPress.add((e) => _updateRawTextArea());
    return _textbox;
  }
  
  _buildToolbar() {
   _toolbar = new DivElement();
   _toolbar.classes.add("toolbar");
       
   _toolbar.children.add(_createButton("B",_toggleBold));
   _toolbar.children.add(_createButton("I",_toggleItalic));
   _toolbar.children.add(_createButton("U",_toggleUnderline));
   _toolbar.children.add(_getSeparator());
   _toolbar.children.add(_createButton("Left",_leftJustify));
   _toolbar.children.add(_createButton("Center",_centerJustify));
   _toolbar.children.add(_createButton("Right",_rightJustify));
   _toolbar.children.add(_getSeparator());
   _toolbar.children.add(_createButton("Ordered List",_orderedList));
   _toolbar.children.add(_createButton("Unordered List",_unorderedList));
   return _toolbar;
  }
  
  _createButton(label, clickFunction) {
    var button = new ButtonElement();
    button.text = label;
    button.on.click.add(clickFunction);
    button.on.click.add((e) => _updateRawTextArea());
    return button;
  }
  
  _getSeparator() {
    return new Element.html("<span>&nbsp;</span>");
  }
  
  _createRawTextArea() {
    _rawTextArea = new Element.tag("textarea");
    _rawTextArea.classes.add("rawtextarea");
    _rawTextArea.on.keyPress.add((e) => this.rawText = _rawTextArea.value);
  }
  
  _updateRawTextArea() {
    if (_rawTextArea != null) {
     _rawTextArea.text = _textbox.innerHTML; 
    }    
  }
  
  
  _toggleBold(e) => _textbox.document.execCommand("bold",true,"");
  _toggleItalic(e) => _textbox.document.execCommand("italic",true,"");
  _toggleUnderline(e) => _textbox.document.execCommand("underline",true,"");
  
  _leftJustify(e) => _textbox.document.execCommand("justifyleft",true,"");
  _centerJustify(e) => _textbox.document.execCommand("justifycenter",true,"");
  _rightJustify(e) => _textbox.document.execCommand("justifyright",true,"");
  
  _orderedList(e) => _textbox.document.execCommand("insertorderedlist",true,"");
  _unorderedList(e) => _textbox.document.execCommand("insertunorderedlist",true,"");
  
  
}