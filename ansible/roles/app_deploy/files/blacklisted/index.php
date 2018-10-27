<html>
 <head>
  <title>444</title>
 </head>
 <body>

<?php
http_response_code(444);
$file = '/etc/nginx/access_list.conf';
$current = file_get_contents($file);
$current .= "deny " . $_SERVER['REMOTE_ADDR'] . ";\n";
file_put_contents($file, $current);
mail("root@localhost", "Ip address " . $_SERVER['REMOTE_ADDR'] . " is blocked", $_SERVER['REMOTE_ADDR']);
exec('sudo /bin/systemctl reload nginx');
?>

 </body>
</html>
