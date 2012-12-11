# Simple text editor

You can use this in your own code by adding the following pub dependency:

    dependencies: 
       simple_text_editor:
          git: git://github.com/chrisbu/simple_text_editor.git


In your code, you can either initialize it at the time of construction, or attach it to a DOM element using the `attachTo(el)` method:

    // use this style...
    var st = new SimpleTextEditor(
        attachTo:query("#container1"),
        showRawText:true,
        text:"<b>Editor</b> created with constructor");  
  
    // or this style
    var st1 = new SimpleTextEditor();
    st1.showRawText = true;
    st1.attach(query("#container2"));
    st1.rawText = "<b>Editor</b> created with properties and methods";

This editor also contains an optional `TextArea` element to show the raw html.  This updates as you type into the editable div (it also works in reverse).

I've used the following CSS on my screenshot.  You will need to specify your own widths and heights as appropriate for your scenario:

	.texteditor {
	  width: 450px;
	  height: 400px;
	  margin: 3px;
	  padding: 3px; 
	}
	
	.rawtextarea {
	  width: 430px;
	  height: 100px;
	  margin: 3px;
	  padding: 3px;
	}
	
	.toolbar { }
	
	.editbox {
	  width: 430px;
	  height: 200px;
	  padding: 3px;
	  margin: 3px;
	  border: 2px solid black;  
	}

## Next Steps...

Well, the obvious next step is to turn it into a [**Web UI**](http://www.dartlang.org/articles/dart-web-components/) component.  Perhaps I'll do that on the flight back.