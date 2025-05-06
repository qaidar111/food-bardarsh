<?php
// تضمين ملفات النظام
require_once 'includes/session.php';

// تسجيل حدث تسجيل الخروج
if (isLoggedIn()) {
    $user_id = getCurrentUserId();
    $user_role = getCurrentUserRole();
    $logger->security("تسجيل خروج المستخدم", [
        'user_id' => $user_id,
        'role' => $user_role
    ]);
}

// Clear all session variables
$_SESSION = array();

// If it's desired to kill the session, also delete the session cookie
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Destroy the session
session_destroy();

// Redirect to login page using JavaScript
echo '<script>window.location.href = "/pa6/index.php";</script>';

// Also try PHP redirect as a fallback
header("Location: /pa6/index.php");
exit();
?>
