  // ----------------------------------------------------
  // Form method : clock
  // Created 26/09/08 by vdl
  // ----------------------------------------------------
  // Description
  //
  // ----------------------------------------------------
  // Modified by Vincent de Lachaux (22/06/09)
  // v12
  // ----------------------------------------------------
  // Modified #26-4-2013 by Vincent de Lachaux
  // transform to widget
  // ----------------------------------------------------
  // Modified #06-5-2013 by Roland Lannuzel
  // Test of bound variable type
  // Resize
  // ----------------------------------------------------
  // Modified #05/02/220 by Vincent de Lachaux
  // Code rewriting for v18
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($bUpdate)
C_LONGINT:C283($height;$Lon_secondAngle;$Lon_secondes;$width)
C_TIME:C306($Gmt_currentTime;$Gmt_offset)
C_POINTER:C301($ptr)
C_REAL:C285($Num_cx;$Num_cy;$Num_hourAngle;$Num_Hours;$Num_minuteAngle;$Num_Minutes)
C_TEXT:C284($node;$root;$t;$tFill;$tFillColor;$tStroke)
C_TEXT:C284($tStrokeColor)
C_OBJECT:C1216($event;$file)

  // ----------------------------------------------------
  // Initialisations
$event:=FORM Event:C1606

  // ----------------------------------------------------
Case of 
		
		  //__________________________________________________________________________________
	: ($event.code=On Load:K2:1)
		
		  // Get host database clock file
		$file:=Folder:C1567(fk resources folder:K87:11;*).file("clock.svg")
		
		If (Not:C34($file.exists))
			
			  // Get widget clock file
			$file:=File:C1566("/RESOURCES/clock.svg")
			
		End if 
		
		If ($file.exists)
			
			$t:=$file.getText()
			
			$root:=DOM Parse XML variable:C720($t)
			
		End if 
		
		If (Bool:C1537(OK))
			
			  // Ensures that  that attribute "transform" will be available for the 3 hands {
			$node:=DOM Find XML element by ID:C1010($root;"hours-hand")
			
			If (Bool:C1537(OK))
				
				DOM SET XML ATTRIBUTE:C866($node;\
					"transform";"")
				
			End if 
			
			$node:=DOM Find XML element by ID:C1010($root;"minutes-hand")
			
			If (Bool:C1537(OK))
				
				DOM SET XML ATTRIBUTE:C866($node;\
					"transform";"")
				
			End if 
			
			$node:=DOM Find XML element by ID:C1010($root;"seconds-hand")
			
			If (Bool:C1537(OK))
				
				DOM SET XML ATTRIBUTE:C866($node;\
					"transform";"")
				
			End if   //}
			
			  // Load the picture once for all
			SVG EXPORT TO PICTURE:C1017($root;(OBJECT Get pointer:C1124(Object named:K67:5;"gClock"))->;Get XML data source:K45:16)
			
			SET TIMER:C645(-1)
			
		End if 
		
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($width;$height)
		OBJECT MOVE:C664(*;"gClock";1;1;$width-1;$height-1;*)
		
		  //__________________________________________________________________________________
	: ($event.code=On Bound Variable Change:K2:52)
		
		SET TIMER:C645(-1)
		
		  //__________________________________________________________________________________
	: ($event.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($width;$height)
		OBJECT MOVE:C664(*;"gClock";1;1;$width-1;$height-1;*)
		
		$ptr:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		
		If (Not:C34(Is nil pointer:C315($ptr)))
			
			If (Type:C295($ptr->)=Is time:K8:8)
				
				$Gmt_currentTime:=$ptr->
				
			Else 
				
				$bUpdate:=True:C214
				
				$Gmt_offset:=$ptr->
				$Gmt_currentTime:=Current time:C178+$Gmt_offset
				$Gmt_currentTime:=Choose:C955($Gmt_currentTime>?24:00:00?;$Gmt_currentTime-?24:00:00?;$Gmt_currentTime)
				
			End if 
			
			$Lon_secondes:=$Gmt_currentTime%60
			$Num_Minutes:=(($Gmt_currentTime\60)%60)+($Lon_secondes/60)
			$Num_Hours:=$Gmt_currentTime/3600
			
			$Lon_secondAngle:=($Lon_secondes*6)+180
			$Num_minuteAngle:=($Num_Minutes*6)+180
			$Num_hourAngle:=(($Num_Hours-(12*Num:C11($Num_Hours>12)))*30)+180
			
			  // Modifie the rotation of the 3 hands : according to the user value of cx cy if any
			SVG GET ATTRIBUTE:C1056(*;"gClock";"seconds-hand";"d4:cx";$Num_cx)
			SVG GET ATTRIBUTE:C1056(*;"gClock";"seconds-hand";"d4:cy";$Num_cy)
			$Num_cx:=Choose:C955($Num_cx=0;199;$Num_cx)
			$Num_cy:=Choose:C955($Num_cy=0;199;$Num_cy)
			SVG SET ATTRIBUTE:C1055(*;"gClock";"seconds-hand";\
				"transform";"rotate("+String:C10($Lon_secondAngle;"&xml")+","+String:C10($Num_cx;"&xml")+","+String:C10($Num_cy;"&xml")+")")
			
			SVG GET ATTRIBUTE:C1056(*;"gClock";"minutes-hand";"d4:cx";$Num_cx)
			SVG GET ATTRIBUTE:C1056(*;"gClock";"minutes-hand";"d4:cy";$Num_cy)
			$Num_cx:=Choose:C955($Num_cx=0;199;$Num_cx)
			$Num_cy:=Choose:C955($Num_cy=0;198;$Num_cy)
			SVG SET ATTRIBUTE:C1055(*;"gClock";"minutes-hand";\
				"transform";"rotate("+String:C10($Num_minuteAngle;"&xml")+","+String:C10($Num_cx;"&xml")+","+String:C10($Num_cy;"&xml")+")")
			
			SVG GET ATTRIBUTE:C1056(*;"gClock";"hours-hand";"d4:cx";$Num_cx)
			SVG GET ATTRIBUTE:C1056(*;"gClock";"hours-hand";"d4:cy";$Num_cy)
			$Num_cx:=Choose:C955($Num_cx=0;199;$Num_cx)
			$Num_cy:=Choose:C955($Num_cy=0;197;$Num_cy)
			SVG SET ATTRIBUTE:C1055(*;"gClock";"hours-hand";\
				"transform";"rotate("+String:C10($Num_hourAngle;"&xml")+","+String:C10($Num_cx;"&xml")+","+String:C10($Num_cy;"&xml")+")")
			
			  // Set the background according to the daylight if any
			If ($Gmt_currentTime>?08:00:00?)\
				 & ($Gmt_currentTime<?20:00:00?)
				
				$tFill:="d4:day-fill"
				$tStroke:="d4:day-stroke"
				
			Else 
				
				$tFill:="d4:night-fill"
				$tStroke:="d4:night-stroke"
				
			End if 
			
			For each ($t;New collection:C1472("watch-dial";"hours-hand";"minutes-hand";"seconds-hand";"labels";"clock-glass"))
				
				SVG GET ATTRIBUTE:C1056(*;"gClock";$t;$tFill;$tFillColor)
				
				If (Length:C16($tFillColor)#0)
					
					SVG SET ATTRIBUTE:C1055(*;"gClock";$t;\
						"fill";$tFillColor)
					
				End if 
				
				SVG GET ATTRIBUTE:C1056(*;"gClock";$t;$tStroke;$tStrokeColor)
				
				If (Length:C16($tStrokeColor)#0)
					
					SVG SET ATTRIBUTE:C1055(*;"gClock";$t;\
						"stroke";$tStrokeColor)
					
				End if 
			End for each 
			
			SET TIMER:C645(10*Num:C11($bUpdate))  // 6 X PER SECOND
			
		End if 
		
		  //__________________________________________________________________________________
End case 