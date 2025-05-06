<?php
// Include database connection
require_once 'config/database.php';
require_once 'classes/User.php';
require_once 'includes/session.php';

// Redirect if already logged in
if (isLoggedIn()) {
    // Redirect based on role
    switch ($_SESSION['user_role']) {
        case 'admin':
            header("Location: pages/admin/dashboard.php");
            break;
        case 'cashier':
            header("Location: pages/cashier/dashboard.php");
            break;
        case 'order_handler':
            header("Location: pages/order_handler/dashboard.php");
            break;
        case 'chef':
            header("Location: pages/chef/dashboard.php");
            break;
        default:
            header("Location: pages/unauthorized.php");
    }
    exit();
}

// Process login form
$error_message = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get database connection
    $database = new Database();
    $db = $database->getConnection();

    // Create user object
    $user = new User($db);

    // Set username and password
    $user->username = $_POST['username'];
    $user->password = $_POST['password'];

    // Attempt login
    if ($user->login()) {
        // Set session variables
        $_SESSION['user_id'] = $user->id;
        $_SESSION['user_name'] = $user->username;
        $_SESSION['user_role'] = $user->role;
        $_SESSION['user_full_name'] = $user->full_name;

        // تسجيل حدث تسجيل الدخول
        $logger->security("تسجيل دخول ناجح", [
            'user_id' => $user->id,
            'username' => $user->username,
            'role' => $user->role
        ]);

        // Redirect based on role
        switch ($user->role) {
            case 'admin':
                header("Location: pages/admin/dashboard.php");
                break;
            case 'cashier':
                header("Location: pages/cashier/dashboard.php");
                break;
            case 'order_handler':
                header("Location: pages/order_handler/dashboard.php");
                break;
            case 'chef':
                header("Location: pages/chef/dashboard.php");
                break;
            default:
                header("Location: pages/unauthorized.php");
        }
        exit();
    } else {
        $error_message = 'اسم المستخدم أو كلمة المرور غير صحيحة';

        // تسجيل محاولة تسجيل دخول فاشلة
        $logger->warning("محاولة تسجيل دخول فاشلة", [
            'username' => $_POST['username'],
            'ip' => $_SERVER['REMOTE_ADDR'] ?? 'unknown'
        ]);
    }
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>تسجيل الدخول - نظام إدارة المطعم</title>
    <!-- Bootstrap RTL CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.rtl.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/notifications.css">
    <link rel="stylesheet" href="assets/css/dark-mode.css">
    <link rel="stylesheet" href="assets/css/loading.css">

    <!-- Dark Mode JS -->
    <script src="assets/js/dark-mode.js"></script>
    <script src="assets/js/loading.js"></script>
    <style>
        /* تنسيق زر إظهار/إخفاء كلمة المرور */
        #togglePassword {
            cursor: pointer;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            transition: all 0.3s ease;
        }
        #togglePassword:hover {
            background-color: #0d6efd;
            color: white;
            border-color: #0d6efd;
            transform: translateY(-1px);
        }
        #togglePassword:active {
            transform: translateY(1px);
        }
        #togglePassword:focus {
            box-shadow: none;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="login-container">
            <div class="login-logo">
                <i class="fas fa-utensils"></i>
                <h2>نظام إدارة المطعم</h2>
                <p class="text-muted">تسجيل الدخول للوصول إلى لوحة التحكم</p>
            </div>

            <?php if (!empty($error_message)): ?>
            <div class="alert alert-danger" role="alert">
                <?php echo $error_message; ?>
            </div>
            <?php endif; ?>

            <form method="POST" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>">
                <div class="mb-3">
                    <label for="username" class="form-label">اسم المستخدم</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">كلمة المرور</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">اختر دورك</label>
                    <div class="row">
                        <div class="col-6 mb-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role_selector" id="role_admin" value="admin">
                                <label class="form-check-label" for="role_admin">
                                    <i class="fas fa-user-shield"></i> مدير
                                </label>
                            </div>
                        </div>
                        <div class="col-6 mb-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role_selector" id="role_cashier" value="cashier">
                                <label class="form-check-label" for="role_cashier">
                                    <i class="fas fa-cash-register"></i> كاشير
                                </label>
                            </div>
                        </div>
                        <div class="col-6 mb-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role_selector" id="role_order_handler" value="order_handler">
                                <label class="form-check-label" for="role_order_handler">
                                    <i class="fas fa-clipboard-list"></i> مسؤول الطلبات
                                </label>
                            </div>
                        </div>
                        <div class="col-6 mb-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role_selector" id="role_chef" value="chef">
                                <label class="form-check-label" for="role_chef">
                                    <i class="fas fa-hat-chef"></i> طباخ
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">تسجيل الدخول</button>
                </div>
            </form>

            <div class="mt-3 text-center">
                <small class="text-muted">تم التطوير بواسطة قيدار أحمد</small>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script>
        // Auto-fill username based on role selection
        document.querySelectorAll('input[name="role_selector"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const username = document.getElementById('username');
                const password = document.getElementById('password');

                // Set default credentials based on role
                switch(this.value) {
                    case 'admin':
                        username.value = 'admin';
                        password.value = 'admin123';
                        break;
                    case 'cashier':
                        username.value = 'cashier';
                        password.value = 'cashier123';
                        break;
                    case 'order_handler':
                        username.value = 'order_handler';
                        password.value = 'order123';
                        break;
                    case 'chef':
                        username.value = 'chef';
                        password.value = 'chef123';
                        break;
                }
            });
        });

        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');

            // Toggle the type attribute
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);

            // Toggle the icon
            if (type === 'password') {
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            } else {
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            }
        });
    </script>
</body>
</html>
