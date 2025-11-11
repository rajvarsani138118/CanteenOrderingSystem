<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Menu Item - Admin Panel</title>

    <!-- ✅ Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .btn-success {
            background: linear-gradient(90deg, #28a745, #4cd964);
            border: none;
            font-weight: 500;
        }
        .btn-success:hover {
            background: linear-gradient(90deg, #218838, #34c759);
        }
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>

<body>
<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white mb-4">
  <div class="container">
    <a class="navbar-brand fw-bold text-success" href="adminDashboard.jsp">
      🛠️ Admin Panel
    </a>
    <div class="ms-auto">
      <a href="logout.jsp" class="btn btn-outline-danger btn-sm">Logout</a>
    </div>
  </div>
</nav>

<!-- ✅ Add Item Form -->
<div class="container">
    <div class="card p-4 mx-auto" style="max-width: 600px;">
        <h3 class="text-center mb-4 text-success">Add New Menu Item</h3>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success text-center">✅ Item added successfully!</div>
        <% } else if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center">❌ Failed to add item: <%= request.getParameter("error") %></div>
        <% } %>

        <form action="addMenuItem" method="post">
            <div class="mb-3">
                <label class="form-label">Item Name</label>
                <input type="text" class="form-control" name="name" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea class="form-control" name="description" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Price (₹)</label>
                <input type="number" step="0.01" class="form-control" name="price" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Image URL (optional)</label>
                <input type="text" class="form-control" name="image_url" placeholder="e.g., burger.jpg">
            </div>

            <button type="submit" class="btn btn-success w-100">
                <i class="bi bi-plus-circle"></i> Add Item
            </button>
        </form>
    </div>
</div>

<!-- ✅ Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
