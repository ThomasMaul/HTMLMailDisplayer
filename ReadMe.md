## HTMLEmail_Viewer

4D Component to handle the display of a html or text only E-Mail (using a subform)
The component handles the job to parse the mail and automatically use HTML or text only part, as well as displaying receiver, subject, etc.


### Usage

Install component
In a form create a subform and assign "Mail_Display" from the component.
In form method or object method call:

EXECUTE METHOD IN SUBFORM("email";"EMail_Load";*;Form.email;$blob)

First parameter is the object name of the subform (here email)
Second parameter must be "EMail_Load" (name of the method inside the component doing all work)
Third parameter must be * (no return parameter)
Forth parameter needs to be an object, here using Form. This object will contain after execution the content of the email including enclosure list
Fifth parameter is the email to display. Pass as blob (when read from disk) or text (if you have the MIME in text)


The object (4th para) can be used later to display enclosures or handle them.
By example create a listbox based on a collection, assign Form.email.enclosures (same object as used in 4th parameter)
Assign for selected item Form.EnclSelected
For the column assign this.name
Example code to handle double click to save enclosure on disk:

```
If (FORM Event.code=On Double Clicked)
	C_OBJECT($encl)
	$encl:=Form.EnclSelected
	$path:=Form.email.enclosurepath
	$doc:=Select document(System folder(Documents folder)+$encl.name;"";"";File name entry)
	If (OK=1)
		COPY DOCUMENT($path+$encl.name;document)
	End if 
End if 
```

(the component automatically stores enclosures in path Form.email.enclosurepath, so the code just copies it into the directory selected by the end user)



### Note

* Project requires 4D v18 or newer (using project mode and C_Variant requires minimum v18).
* Included binary build is compiled for v18
