<?php
	print_r($_FILES);
        file_put_contents("1.txt",json_encode($_FILES));
	move_uploaded_file($_FILES['file']['tmp_name'],"./2.jpg");
?>
