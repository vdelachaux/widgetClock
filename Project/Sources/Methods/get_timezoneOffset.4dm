//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : get_timezoneOffset
  // ID[4DF06BF33A0A4D5DBFA57FD701964FC8]
  // Created #29-4-2013 by Vincent de Lachaux
  // ----------------------------------------------------
  // Modified #05/02/220 by Vincent de Lachaux
  // Code rewriting for v18
  // ----------------------------------------------------
  // Description:
  // Returns the time zone offset between
  // this computer and a given time zone
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($offset)

If (False:C215)
	C_LONGINT:C283(get_timezoneOffset ;$0)
	C_TEXT:C284(get_timezoneOffset ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
If (Asserted:C1132(Count parameters:C259>=0;"Missing parameter"))
	
	  // NO PARAMETERS REQUIRED
	
	If (Count parameters:C259>=1)
		
		SET ENVIRONMENT VARIABLE:C812("GET_LOCATION_TIMEZONE";$1)
		
	Else 
		
		SET ENVIRONMENT VARIABLE:C812("GET_LOCATION_TIMEZONE";"UTC")
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (PHP Execute:C1058(File:C1566("/RESOURCES/PHP/timeZone_offset.php").platformPath;"myFunction";$offset))
	
	$0:=$offset
	
End if 

  // ----------------------------------------------------
  // End