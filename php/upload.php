<?php
      $str = file_get_contents('php://input','r');
      $fp = fopen(md5($str).".jpg","w");
      fwrite($fp,$str);
      fclose($fp);
      exit($str);
?>
