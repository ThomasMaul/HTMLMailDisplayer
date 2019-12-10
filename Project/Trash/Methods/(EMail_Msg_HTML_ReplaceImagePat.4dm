//%attributes = {"invisible":true}
  // $newHtml:=EMail_Msg_HTML_ReplaceImagePath(html; cid; newpath)
  // modifies the email html to rewrite a single cid/included image to external path
  // call once for each enclosure which could be an included image

  // replace link in html, find in text cid:image001.jpg@01C84D36.D8262390

$old:="cid"+$cid
$new:=Convert path system to POSIX:C1106($path_encl+$attachment.name)
  // $html:=replace string($html;$old;$new)  // we cannot simply copy&paste, becasue cid's often uses @



