<html>
 <head>
  <title>Fibonacci as a Service ツ</title>
 </head>
 <body>

<?php
function fibonacci($from, $to)
{
    $a = 0;
    $b = 1;
    $tmp;
    while ($to > 0) {
        if ($from > 0) {
            $from--;
        } else {
            yield $a;
        }
        $tmp = $a + $b;
        $a = $b;
        $b = $tmp;
        $to--;
    }
}

foreach (fibonacci(0, htmlspecialchars($_GET["n"])) as $fib) {
    echo $fib . " ";

}
?>

 </body>
</html>
