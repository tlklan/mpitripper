<?php

require_once("/srv/werket.tlk.fi/helpers/autoloader.php");

$user = new LocalUserController(true);
if(!$user->isLoggedIn())
	$user->setForbidden();

?>
