//%attributes = {}
  // M$html:=EMail_ReturnURL_IncludeHeader ($filename;$html;$answer)

  // now we should have in the arrays all data we need, to replace file names!
  // we need to start from back, because we modify the content!

  //
  // Parameter
  // $html:=EMail_ReturnURL_IncludeHeader ($mime;$html)

  // ----------------------------------------------------

$mime:=$1
$message_text_t:=$2

  // Header including

$style:=EMail_Msg_HTML_StyleSheet (True:C214)
$header:=EMail_Msg_HTML_MsgHeader ($mime)+"<div id=\"headerline\"></div>\r\r"



$pos:=Position:C15("<Body";$message_text_t)
If ($pos>0)
	$sub:=Substring:C12($message_text_t;$pos;200)
	$pos2:=Position:C15(">";$sub)
	If ($pos2>0)
		$origheader:=Substring:C12($message_text_t;1;$pos-1)
		$newmail:=$origheader+$style
		$body:=Substring:C12($message_text_t;$pos;$pos2)
		$message_text_t:=$newmail+$body+$header+Substring:C12($message_text_t;$pos+$pos2)
	End if 
Else 
	  // no body? So we build it ourself...
	$message_text_t:="<HTML><head><meta http-equiv=content-type content=\"text/html; charset=UTF-8\"></head>"+$style+"<Body>"+$header+"<div id=\"message\">\r"+$message_text_t+"\r</div>\r</Body></HTML>"
	
End if 
$0:=$message_text_t