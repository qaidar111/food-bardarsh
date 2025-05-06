<?php
// Set page title
$page_title = "غير مصرح";

// Include header (without requiring login)
require_once 'includes/header.php';
?>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-6 mx-auto">
            <div class="card">
                <div class="card-header bg-danger text-white">
                    <h4 class="mb-0"><i class="fas fa-exclamation-triangle me-2"></i> غير مصرح</h4>
                </div>
                <div class="card-body text-center">
                    <i class="fas fa-lock fa-5x text-danger mb-4"></i>
                    <h5>عذراً، ليس لديك صلاحية للوصول إلى هذه الصفحة.</h5>
                    <p class="text-muted">يرجى التواصل مع مدير النظام إذا كنت تعتقد أن هذا خطأ.</p>
                    <div class="mt-4">
                        <a href="/pa6/index.php" class="btn btn-primary">
                            <i class="fas fa-home me-1"></i> العودة إلى الصفحة الرئيسية
                        </a>
                        <a href="/pa6/logout_process.php" class="btn btn-outline-secondary ms-2">
                            <i class="fas fa-sign-out-alt me-1"></i> تسجيل الخروج
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once 'includes/footer.php'; ?>
