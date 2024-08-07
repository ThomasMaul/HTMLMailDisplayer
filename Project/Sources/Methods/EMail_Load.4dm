//%attributes = {"shared":true}
// EMail_Load(blob or mailcontent/text)
// execute in context of your form (call form)
// the form needs to include an internal web area named HTMLPreview,
// optionally a listbox showing form.enclosures[].name and a checkbox  with expression Form.ShowImage
// you might set Form.ShowImage in another way
// set Form.enclosurepath here you you want to store  enclosures
// if not set, it is saved inside temp folder
// $1 = form object or other object, $2 variant with blob or text

#DECLARE($form : Object; $variant : Variant)

C_OBJECT:C1216($partindex; $attachment)  // contains Form

C_TEXT:C284($part)


If ($form.enclosurepath=Null:C1517)
	$form.enclosurepath:=Temporary folder:C486+"4D_encl"+Folder separator:K24:12
End if 

If ($form.enclosurepath#"")
	If (Test path name:C476($form.enclosurepath)=Is a folder:K24:2)
		DELETE FOLDER:C693($form.enclosurepath; Delete with contents:K24:24)
	End if 
	CREATE FOLDER:C475($form.enclosurepath; *)
End if 


$form.mail:=MAIL Convert from MIME:C1681($2)

If (False:C215)
	var $text:=JSON Stringify:C1217($form.mail)
	SET TEXT TO PASTEBOARD:C523($text)
End if 

If ($form.mail.bodyStructure#Null:C1517)
	$sub:=$form.mail.bodyStructure.subParts
	If ($sub#Null:C1517)
		C_COLLECTION:C1488($ishtml; $sub)
		
		$ishtml:=$sub.query("type=:1"; "text/html")
		If ($ishtml.length>0)
			var $html:=""
			For each ($partindex; $ishtml)
				$part:=$partindex.partId
				If ($form.mail.bodyValues[$part].value#Null:C1517)
					$html:=$html+Char:C90(13)+$form.mail.bodyValues[$part].value
				End if 
			End for each 
			
			$html:=EMail_ReturnURL_IncludeHeader($Form.mail; $html)
			
		Else   // only text/plain?
			$ishtml:=$sub.query("type=:1"; "text/plain")
			If ($ishtml.length>0)
				$part:=$ishtml[0].partId
				If ($form.mail.bodyValues[$part].value#Null:C1517)
					$html:=$form.mail.bodyValues[$part].value
				End if 
			End if 
			
			$html:=Replace string:C233($html; Char:C90(Carriage return:K15:38); "<BR>")
			var $style:=EMail_Msg_HTML_StyleSheet(False:C215)
			var $header:=EMail_Msg_HTML_MsgHeader($form.mail)+"<div id=\"headerline\"></div>\r\r"
			$html:="<HTML><head><meta http-equiv=content-type content=\"text/html; charset=UTF-8\"></head>"+$style+"<Body>"+$header+"<div id=\"message\">\r"+$html+"\r</div>\r</Body></HTML>"
		End if 
		//End if 
	End if 
End if 


If ($html="")  // totally empty email? Add at least headers..
	$style:=EMail_Msg_HTML_StyleSheet(False:C215)
	$header:=EMail_Msg_HTML_MsgHeader($form.mail)+"<div id=\"headerline\"></div>\r\r"
	$html:="<HTML><head><meta http-equiv=content-type content=\"text/html; charset=UTF-8\"></head>"+$style+"<Body>"+$header+"<div id=\"message\">\"\r</div>\r</Body></HTML>"
	
End if 


// internal images and enclosures
var $count:=0
$form.enclosures:=New collection:C1472
If ($form.mail.attachments#Null:C1517)
	$count:=$form.mail.attachments.length
	If ($count>0)
		For each ($attachment; $form.mail.attachments)
			var $cid:=String:C10($attachment.cid)
			C_BLOB:C604($content)
			$content:=$attachment.getContent()
			var $filename:=Replace string:C233($attachment.name; ":"; "_")
			$filename:=Replace string:C233($filename; "/"; "_")
			$filename:=Replace string:C233($filename; "\\"; "_")
			BLOB TO DOCUMENT:C526($form.enclosurepath+$filename; $content)
			If ($cid#"")
				var $old:="cid:"+$cid
				var $new:=Convert path system to POSIX:C1106($form.enclosurepath+$filename)
				If (Position:C15($old; $html; *)>0)
					$html:=Replace string:C233($html; $old; $new; *)  // character code, so none diacritical/case sensitive because @  
				Else   // error ?
					// not sure if that should have been included/embedded, no reference found
					$form.enclosures.push(New object:C1471("name"; $filename))  // at least in enclosure list
				End if 
			Else 
				$form.enclosures.push(New object:C1471("name"; $filename))
			End if 
		End for each 
	End if 
End if 
// we have a collection of enclsoures in $form.enclosures
// to display them as list box


$form.BodyHTML:=$html

If (Bool:C1537($form.ShowImage)=False:C215)  // remove external images
	$html:=EMail_ReturnURL_RemoveIMG($html)
End if 

TEXT TO DOCUMENT:C1237($form.enclosurepath+"body.html"; $html)
var $url : Text:=$form.enclosurepath+"body.html"
$url:=Convert path system to POSIX:C1106($url; *)
WA OPEN URL:C1020(*; "HTMLPreview"; "file:///"+$url)

