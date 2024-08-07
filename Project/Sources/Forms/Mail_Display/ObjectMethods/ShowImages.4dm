If (FORM Event:C1606.code=On Clicked:K2:4)
	var $path_encl : Text:=Get 4D folder:C485(Database folder:K5:14)+"encl"+Folder separator:K24:12
	If (Form:C1466.ShowImage)
		TEXT TO DOCUMENT:C1237($path_encl+"body.html"; Form:C1466.BodyHTML)
		var $url : Text:=$path_encl+"body.html"
		$url:=Convert path system to POSIX:C1106($url; *)
		WA OPEN URL:C1020(*; "HTMLPreview"; "file:///"+$url)
	Else 
		var $html:=EMail_ReturnURL_RemoveIMG(Form:C1466.BodyHTML)
		TEXT TO DOCUMENT:C1237($path_encl+"body.html"; $html)
		$url:=$path_encl+"body.html"
		$url:=Convert path system to POSIX:C1106($url; *)
		WA OPEN URL:C1020(*; "HTMLPreview"; "file:///"+$url)
	End if 
End if 