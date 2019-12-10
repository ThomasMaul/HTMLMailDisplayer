//%attributes = {}
  // ----------------------------------------------------
  // Project Method: EM4D_Msg_HTML_StyleSheet ({font size}) --> Text

  // Adds the tags needed to display the message with the user's preferred font and font size.

  // Access Type: Private

  // Parameters: 
  // $1 True = Style for header only, pass if body is HTML already
  // Returns: 
  //   $0 : Text : The css style sheet to use 

  // Created by Dave Batton, March 2006
  // Modified Thomas Maul, August 2008
  // ----------------------------------------------------

If (Count parameters:C259>0)
	$OnlyHeader:=$1
Else 
	$OnlyHeader:=False:C215
End if 

C_TEXT:C284($0;$fontName_t;$style_t)
C_LONGINT:C283($fontSize_i;$headerLineHeight_i;$headerFontSize_i)

$fontName_t:="Arial"  // - change here if you want a different font
$fontSize_i:=12  // change here if you want to use a different font size

  // I tried some different stuff and decided I like the header slightly smaller than the body text.
$headerFontSize_i:=$fontSize_i-1
$headerLineHeight_i:=$headerFontSize_i

$style_t:="<style type=\"text/css\">\r"
  // $style_t:=$style_t+"<!--\r"   ` incompatible if forwarded email contains some style attributes, like Amazon ad's.

If (Not:C34($OnlyHeader))
	$style_t:=$style_t+"body, table\r"
	$style_t:=$style_t+"{\r"
	$style_t:=$style_t+"  color: black;\r"
	$style_t:=$style_t+"  background: white;\r"
	$style_t:=$style_t+"  font-family: "+$fontName_t+", Verdana, Arial, sans-serif;\r"
	$style_t:=$style_t+"  font-size: "+String:C10($fontSize_i)+"px;\r"
	$style_t:=$style_t+"  margin: 0px;\r"
	$style_t:=$style_t+"}\r\r"
	
	$style_t:=$style_t+"#header {\r"
Else 
	$style_t:=$style_t+"#header, #message {\r"
End if 
$style_t:=$style_t+"  margin: 10px;\r"
$style_t:=$style_t+"}\r\r"

$style_t:=$style_t+".headerlabel\r"
$style_t:=$style_t+"{\r"
$style_t:=$style_t+"  background: white;\r"
$style_t:=$style_t+"  font-family: "+$fontName_t+", Verdana, Arial, sans-serif;\r"
$style_t:=$style_t+"  font-size: "+String:C10($headerFontSize_i)+"px;\r"
$style_t:=$style_t+"  font-weight: bold;\r"
$style_t:=$style_t+"  line-height: "+String:C10($headerLineHeight_i)+"px;\r"
$style_t:=$style_t+"  vertical-align: top;\r"
$style_t:=$style_t+"  color: #777;\r"
$style_t:=$style_t+"}\r\r"

$style_t:=$style_t+".headerfield\r"  // This isn't really necessary, but it allows us to easily change it later.
$style_t:=$style_t+"{\r"
$style_t:=$style_t+"  background: white;\r"
$style_t:=$style_t+"  font-family: "+$fontName_t+", Verdana, Arial, sans-serif;\r"
$style_t:=$style_t+"  font-size: "+String:C10($headerFontSize_i)+"px;\r"
$style_t:=$style_t+"  font-weight: normal;\r"
$style_t:=$style_t+"  line-height: "+String:C10($headerLineHeight_i)+"px;\r"
$style_t:=$style_t+"  vertical-align: top;\r"
$style_t:=$style_t+"  color: #000000;\r"
$style_t:=$style_t+"}\r\r"

$style_t:=$style_t+".headersubject\r"
$style_t:=$style_t+"{\r"
$style_t:=$style_t+"  background: white;\r"
$style_t:=$style_t+"  font-family: "+$fontName_t+", Verdana, Arial, sans-serif;\r"
$style_t:=$style_t+"  font-size: "+String:C10($headerFontSize_i)+"px;\r"
$style_t:=$style_t+"  font-weight: bold;\r"
$style_t:=$style_t+"  line-height: "+String:C10($headerLineHeight_i)+"px;\r"
$style_t:=$style_t+"  vertical-align: top;\r"
$style_t:=$style_t+"  color: #000000;\r"
$style_t:=$style_t+"}\r\r"

$style_t:=$style_t+"#headerline\r"
$style_t:=$style_t+"{\r"
$style_t:=$style_t+"  position: relative;\r"
$style_t:=$style_t+"  width: 100%;\r"
$style_t:=$style_t+"  top: auto;\r"
$style_t:=$style_t+"  border-bottom: lightgray;\r"
$style_t:=$style_t+"  border-width: 0 0 1px 0;\r"
$style_t:=$style_t+"  border-style: none none solid none;\r"
$style_t:=$style_t+"  margin: 0px;\r"
$style_t:=$style_t+"}\r"

  // $style_t:=$style_t+"-->\r"
$style_t:=$style_t+"</style>\r\r"

$0:=$style_t
