//%attributes = {}
  // Methode: EMail_ReturnURL_RemoveIMG
  //  removes Images (<img...src=..."http...)
  // by replacing http:// with em4d://
  //
  // Parameter
  // $1 = mail
  // $0 = mail without image

  // ----------------------------------------------------

$message_text_t:=$1

  // search for embedded images
$pattern_t:="(?is)(\\<*[img][^\\>]*[src]=\")http(s?)://"
C_LONGINT:C283($Lon_Start;$flags_i;$Lon_Positions_i;$Lon_Lengths_i)
C_BOOLEAN:C305($MatchedRgx)
$Lon_Start:=1

Repeat 
	
	$MatchedRgx:=Match regex:C1019($pattern_t;$message_text_t;$Lon_Start;$Lon_Positions_i;$Lon_Lengths_i)
	If ($MatchedRgx)
		  // we have at least one hit.Now the fun starts...
		
		$value:=Substring:C12($message_text_t;$Lon_Positions_i+$Lon_Lengths_i-7;7)  // that should be http 
		$Lon_Start:=$Lon_Positions_i+$Lon_Lengths_i+2
		$message_text_t:=Change string:C234($message_text_t;"em4d";$Lon_Positions_i+$Lon_Lengths_i-7)
	Else 
		$Lon_Start:=Length:C16($message_text_t)
	End if 
	
Until ($Lon_Start>=Length:C16($message_text_t))

$0:=$message_text_t
