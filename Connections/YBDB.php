<?php
# FileName="Connection_php_mysql.htm"
# Type="MYSQL"
# HTTP="true"
$hostname_YBDB = "enter_servername";
$database_YBDB = "enter_database_name";
$username_YBDB = "enter_database_username";
$password_YBDB = "enter_database_password";
$YBDB = mysql_pconnect($hostname_YBDB, $username_YBDB, $password_YBDB) or trigger_error(mysql_error(),E_USER_ERROR); 
?>