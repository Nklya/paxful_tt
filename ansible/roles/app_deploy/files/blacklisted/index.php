<html>
 <head>
  <title>444</title>
 </head>
 <body>

<?php
require_once 'config.inc';

function block_ip($ip, $file)
{
    $current = file_get_contents($file);
    $current .= "deny " . $ip . ";\n";
    file_put_contents($file, $current);
    exec('sudo /bin/systemctl reload nginx');
}

function send_email($to, $ip)
{
    mail($to, "Ip address " . $ip . " is blocked", $ip);
}

function add_pg_log($dbconn, $uri, $ip)
{
    pg_insert($dbconn, 'blocked', array('path' => $uri, 'ip' => $ip, 'datetime' => date('Y-m-d H:i:s')));
}

http_response_code(444);
block_ip($_SERVER['REMOTE_ADDR'], $access_list);
send_email($email_to, $_SERVER['REMOTE_ADDR']);
$dbconn = pg_connect('host=' . $db . ' port=' . $port . ' dbname=' . $dbname . ' user=' . $user . ' password=' . $pass);
add_pg_log($dbconn, $_SERVER['REQUEST_URI'], $_SERVER['REMOTE_ADDR']);
?>

 </body>
</html>
