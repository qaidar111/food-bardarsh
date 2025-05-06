<!DOCTYPE html>
<html>
<head>
    <title>Logout Test</title>
</head>
<body>
    <h1>Logout Test</h1>
    <p>Click on the links below to test logout:</p>
    
    <ul>
        <li><a href="/pafe/logout.php">Logout (Original)</a></li>
        <li><a href="/pafe/logout2.php">Logout (Alternative)</a></li>
        <li><a href="/pafe/logout_test.php">Logout (Test with Debug Info)</a></li>
    </ul>
    
    <p>Or try these direct PHP session destruction links:</p>
    
    <ul>
        <li>
            <a href="<?php 
                session_start(); 
                session_destroy(); 
                echo '/pafe/index.php?logout=1'; 
            ?>">Direct Session Destroy</a>
        </li>
    </ul>
</body>
</html>
