//%attributes = {}
  // ----------------------------------------------------
  // Method : Demo_clock
  // Created 26/09/08 by vdl
  // ----------------------------------------------------
  // Modified by Vincent de Lachaux (22/06/09)
  // v12
  // ----------------------------------------------------
  // Description
  //
  // ----------------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l)
C_TEXT:C284($t)

If (False:C215)
	C_TEXT:C284(Demo_clock ;$1)
End if 

If (Count parameters:C259>=1)
	
	$t:=$1
	
End if 

Case of 
		
		  //___________________________________________________________
	: (Length:C16($t)=0)
		
		Case of 
				
				  //……………………………………………………………………
			: (Method called on error:C704=Current method name:C684)
				
				  // Error managemnt routine
				
				  //……………………………………………………………………
			Else 
				
				  // This method must be executed in a new process
				BRING TO FRONT:C326(New process:C317(Current method name:C684;12*1024;Current method name:C684;"_run";*))
				
				  //……………………………………………………………………
		End case 
		
		  //___________________________________________________________
	: ($t="_run")
		
		  // First launch of this method executed in a new process
		Demo_clock ("_declarations")
		Demo_clock ("_init")
		
		$l:=Open form window:C675("Demo";Plain form window:K39:10)
		DIALOG:C40("Demo")
		CLOSE WINDOW:C154
		
		Demo_clock ("_deinit")
		
		  //___________________________________________________________
	: ($t="_declarations")
		
		COMPILER_Demo 
		
		  //___________________________________________________________
	: ($t="_init")
		
		  //___________________________________________________________
	: ($t="_deinit")
		
		  //___________________________________________________________
	Else 
		
		TRACE:C157
		
		  //___________________________________________________________
End case 