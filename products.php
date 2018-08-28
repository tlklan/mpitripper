<?php

// perform user authentication
require_once("/srv/werket.tlk.fi/helpers/autoloader.php");

$user = new LocalUserController(true);
if(!$user->isLoggedIn())
	$user->setForbidden();

// determine the parameters used
if (isset($_GET['g1'])) {
	$name = 'g1';
	$value = $_GET['g1'];
}
elseif (isset($_GET['p'])) {
	$name = 'p';
	$value = $_GET['p'];
}

$filename = 'products.php?'.$name.'='.$value;

// get the full path to it
$filePath = getcwd() . '/' . $filename;

if (file_exists($filePath))
	echo file_get_contents($filePath);
else
	die("h4x: command not found");
