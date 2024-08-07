//%attributes = {}

// ----------------------------------------------------
// Anwender (OS): Thomas
// Datum und Zeit: 12.08.08, 10:13:40
// ----------------------------------------------------
// Methode: EMail_ShowHiddenImages
// Beschreibung
// shows hidden images from a HTML email
// only useful if currently a HTML mail is displayed and if images was hidden

//
// Parameter
// $1 = object name (not variable name!) of Web Area
// ----------------------------------------------------

#DECLARE($areaname : Text)

//If (Email_CountHiddenImages #0)
var $code : Text:="function myshowimage() {\r var count=document.images.length;\r"
$code:=$code+"for (i=0;i<count;i++) \r{ var mylink=document.images[i].src;\r mylink=mylink.replace('em4d:','http:');\r document.images[i].src=mylink;\r} }; myshowimage(); "
var $result : Text:=WA Evaluate JavaScript:C1029(*; $areaname; $code)
//Email_ImagesHidden:=0
//End if 