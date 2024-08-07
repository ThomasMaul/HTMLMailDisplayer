//%attributes = {}
#DECLARE($area : Text)

WA SET PREFERENCE:C1041(*; $area; WA enable contextual menu:K62:6; False:C215)


// do not allow to load images at all
// we included that for some smails, which loaded a "spacer.gif" for mail reading detection 
// (as spam senders do), which was send to the standard browser
ARRAY TEXT:C222($filters; 0)
ARRAY BOOLEAN:C223($AllowDeny; 0)
APPEND TO ARRAY:C911($filters; "*.jpg")  // for all
APPEND TO ARRAY:C911($AllowDeny; False:C215)
APPEND TO ARRAY:C911($filters; "*.jepg")  // for all
APPEND TO ARRAY:C911($AllowDeny; False:C215)
APPEND TO ARRAY:C911($filters; "*.gif")  // for all
APPEND TO ARRAY:C911($AllowDeny; False:C215)
APPEND TO ARRAY:C911($filters; "*.png")  // for all
APPEND TO ARRAY:C911($AllowDeny; False:C215)
WA SET URL FILTERS:C1030(*; $area; $filters; $AllowDeny)

ARRAY TEXT:C222($filters; 0)
ARRAY BOOLEAN:C223($AllowDeny; 0)
APPEND TO ARRAY:C911($filters; "http*")  // for all
APPEND TO ARRAY:C911($AllowDeny; False:C215)
WA SET EXTERNAL LINKS FILTERS:C1032(*; $area; $filters; $AllowDeny)