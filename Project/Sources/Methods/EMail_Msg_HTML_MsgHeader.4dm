//%attributes = {}
  // ----------------------------------------------------
  // Project Method: EMail_Msg_HTML_MsgHeader --> Text

  // Returns the header information for the current email message as HTML text.

  // Access Type: Private

  // Parameters: 
  // $1: object with mime email

  // Returns: 
  //   $0 : Text : The message header info

  // original idea based on EM4D_Msg_HTML_MsgHeader from Dave Batton, March 2006
  // ----------------------------------------------------

C_TEXT:C284($0;$html_t;$label_t;$content_t)
C_LONGINT:C283($headerLabelNumber_i)
C_OBJECT:C1216($mime;$1;$element)

$mime:=$1
ARRAY TEXT:C222($headers_at;6)  // Localize these.
$headers_at{1}:=String:C10($mime.subject)
$headers_at{2}:=String:C10($mime.from[0].name)+" "+String:C10($mime.from[0].email)
$headers_at{3}:=String:C10($mime.replyTo[0].name)+" "+String:C10($mime.replyTo[0].email)
$headers_at{4}:=String:C10(Date:C102($mime.sendAt))+" "+String:C10(Time:C179($mime.sendAt))
$To:=""
If ($mime.to#Null:C1517)
	For each ($element;$mime.to)
		$To:=$To+String:C10($element.name)+" "+String:C10($element.email)+Char:C90(13)
	End for each 
End if 
$headers_at{5}:=$to
$CC:=""
If ($mime.cc#Null:C1517)
	For each ($element;$mime.cc)
		$CC:=$CC+String:C10($element.name)+" "+String:C10($element.email)+Char:C90(13)
	End for each 
End if 
$headers_at{6}:=$cc

ARRAY TEXT:C222($labels_at;6)  // Localize these.
$labels_at{1}:=Get localized string:C991("EMail_Subject")
$labels_at{2}:=Get localized string:C991("EMail_From")
$labels_at{3}:=Get localized string:C991("EMail_ReplyTo")
$labels_at{4}:=Get localized string:C991("EMail_Date")
$labels_at{5}:=Get localized string:C991("EMail_To")
$labels_at{6}:=Get localized string:C991("EMail_CC")

$html_t:="<div id=\"header\">\r<table border=\"0\" cellspacing=\"0\">\r"

For ($headerLabelNumber_i;1;Size of array:C274($headers_at))
	$html_t:=$html_t+"\t<tr>\r"
	
	If ($headerLabelNumber_i=3)  // Do NOT localize.
		$content_t:=$headers_at{$headerLabelNumber_i}
		If (Position:C15($content_t;$headers_at{2})>0)
			$content_t:=""  // Display the Reply-To header only if it doesn't match the From header.
		End if 
	Else 
		$content_t:=$headers_at{$headerLabelNumber_i}
	End if 
	
	  // If there's something to show, add it to the HTML.
	If ($content_t#"")
		  //$content_t:=EMail_Util_Text2Html($content_t;True)
		
		  // The Label column.
		$html_t:=$html_t+"\t\t<td align=\"right\" valign=\"top\">\r"
		$html_t:=$html_t+"\t\t\t<span class=\"headerlabel\">"+$labels_at{$headerLabelNumber_i}+":&nbsp;</span>\r"
		$html_t:=$html_t+"\t\t</td>\r"
		
		  // The content column.
		$html_t:=$html_t+"\t\t<td>\r"
		If ($headerLabelNumber_i=1)  // We use a different css style for the header.
			$html_t:=$html_t+"\t\t\t<span class=\"headersubject\">"+$content_t+"</span>\r"
		Else 
			$html_t:=$html_t+"\t\t\t<span class=\"headerfield\">"+$content_t+"</span>\r"
		End if 
		$html_t:=$html_t+"\t\t</td>\r"
	End if 
	
	$html_t:=$html_t+"\t</tr>\r"
End for 

$html_t:=$html_t+"</table>\r</div>\r\r"

$0:=$html_t