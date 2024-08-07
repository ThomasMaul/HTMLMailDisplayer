var $id:=1
var $last:=0
C_BLOB:C604($blob)

var $ref:=Open document:C264(""; ""; Get pathname:K24:6)
If (OK=1)
	DOCUMENT TO BLOB:C525(document; $blob)
	C_OBJECT:C1216($form)
	$form:=New object:C1471
	EXECUTE METHOD IN SUBFORM:C1085("email"; "EMail_Load"; *; Form:C1466.email; $blob)
End if 




