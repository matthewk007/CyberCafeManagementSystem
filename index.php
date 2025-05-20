<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cyber Café - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded shadow-md w-full max-w-md">
        <h2 class="text-2xl font-bold mb-6 text-center">Cyber Café Login</h2>
        <?php
        error_reporting(E_ALL);
        ini_set('display_errors', 1);

        include 'includes/config.php';
        if (!$pdo) {
            die("Database connection not established.");
        }

        // Handle logout
        if (isset($_GET['logout'])) {
            session_destroy();
            echo '<p class="text-green-500 text-center">Logged out successfully!</p>';
        }

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $username = $_POST['username'];
            $password = $_POST['password'];
            try {
                $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
                $stmt->execute([$username]);
                $user = $stmt->fetch();
                if (!$user) {
                    echo '<p class="text-red-500 text-center">Debug: Username not found!</p>';
                } else {
                    echo '<p class="text-blue-500 text-center">Debug: Username found, checking password...</p>';
                    if ($password === $user['password']) {
                        session_start();
                        $_SESSION['user_id'] = $user['user_id'];
                        $_SESSION['role'] = $user['role'];
                        if ($user['role'] == 'admin') {
                            header('Location: admin/dashboard.php');
                            exit;
                        } else {
                            header('Location: user/dashboard.php');
                            exit;
                        }
                    } else {
                        echo '<p class="text-red-500 text-center">Debug: Password incorrect!</p>';
                    }
                }
                echo '<p class="text-red-500 text-center">Invalid credentials!</p>';
            } catch (PDOException $e) {
                echo '<p class="text-red-500 text-center">Database error: ' . $e->getMessage() . '</p>';
            }
        }
        ?>
        <form method="POST" class="space-y-4">
            <div>
                <label class="block text-sm font-medium">Username</label>
                <input type="text" name="username" class="w-full p-2 border rounded" required>
            </div>
            <div>
                <label class="block text-sm font-medium">Password</label>
                <input type="password" name="password" class="w-full p-2 border rounded" required>
            </div>
            <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600">Login</button>
        </form>
    </div>
</body>
</html>