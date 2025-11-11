<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html><head><meta charset="utf-8">
        <title>Admin Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="d-flex align-items-center" style="height:100vh;background:#f5f5f5">
        <div class="container"><div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="card p-4">
                        <h3 class="text-center">Admin Login</h3>
                        <form action="adminLogin" method="post">
                            <div class="mb-3">
                                <label>Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label>Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <button class="btn btn-primary w-100">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
