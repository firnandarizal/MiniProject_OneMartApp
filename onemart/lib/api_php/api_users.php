<?php
require_once "method_users.php";
$apiUsers = new ApiUsers();
$request_method=$_SERVER["REQUEST_METHOD"];
switch ($request_method) {
	case 'GET':
			if(!empty($_GET["id"]))
			{
				$id=intval($_GET["id"]);
				$apiUsers->get_usersid($id);
			}
			else
			{
				$apiUsers->get_users();
			}
			break;
	case 'POST':
			if(!empty($_GET["id"]))
			{
				$id=intval($_GET["id"]);
				$apiUsers->update_barang($id);
			}
			else
			{
				$apiUsers->insert_users();
			}		
			break; 
	case 'DELETE':
		    $id=intval($_GET["id"]);
            $apiUsers->delete_barang($id);
            break;
	default:
		// Invalid Request Method
			header("HTTP/1.0 405 Method Not Allowed");
			break;
		break;
}


?>