<?php
require_once "koneksi.php";
class ApiUsers
{

	public  function get_users()
	{
		global $mysqli;
		$query="SELECT * FROM users";
		$data=array();
		$result=$mysqli->query($query);
		while($row=mysqli_fetch_object($result))
		{
			$data[]=$row;
		}
		$response=array(
							'status' => 200,
							'message' =>'Get Data Users Berhasil.',
							'data' => $data
						);
		header('Content-Type: application/json');
		echo json_encode($response);
	}

	public function get_usersid($id=0)
	{
		global $mysqli;
		$query="SELECT * FROM service";
		if($id != 0)
		{
			$query.=" WHERE id=".$id." LIMIT 1";
		}
		$data=array();
		$result=$mysqli->query($query);
		while($row=mysqli_fetch_object($result))
		{
			$data[]=$row;
		}
		$response=array(
							'status' => 1,
							'message' =>'Get Data User.',
							'data' => $data
						);
		header('Content-Type: application/json');
		echo json_encode($response);
		 
	}

	public function insert_users()
		{
			global $mysqli;
			$arrcheckpost = array('nama' => '', 'alamat' => '', 'telp' => '', 'user' => '', 'password' => '');
			$hitung = count(array_intersect_key($_POST, $arrcheckpost));
			if($hitung == count($arrcheckpost)){
			
					$result = mysqli_query($mysqli, "INSERT INTO users SET
					nama = '$_POST[nama]',
					alamat = '$_POST[alamat]',
					user = '$_POST[user]',
					password = '$_POST[password]',
					telp = '$_POST[telp]'");
					
					if($result)
					{
						$response=array(
							'status' => 1,
							'message' =>'User Added Successfully.'
						);
					}
					else
					{
						$response=array(
							'status' => 0,
							'message' =>'User Addition Failed.'
						);
					}
			}else{
				$response=array(
							'status' => 0,
							'message' =>'Parameter Do Not Match'
						);
			}
			header('Content-Type: application/json');
			echo json_encode($response);
		}
}

 ?>