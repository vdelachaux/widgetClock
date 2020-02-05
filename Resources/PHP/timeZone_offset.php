<?php

function myFunction () {
	$date = new DateTime("now");
	
	$refOffset = 0;
	$refSavingTime = date("I");
	
	if($refSavingTime ="1") {
		$refOffset = 3600;
	}
		
	$date->setTimezone(new DateTimeZone($_SERVER["GET_LOCATION_TIMEZONE"]));
	
	$targOffset = 0;
	$refSavingTime = date("I");
	if ($targOffset ="1") {
		$targOffset = 3600;
	}
	
	return $date->getOffset()-$refOffset-$targOffset;
}

?>