<%@ page import="java.sql.*, com.mycompany.canteen.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Canteen</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .navbar { box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        table { background: white; border-radius: 10px; overflow: hidden; }
        th { background: #007bff; color: white; }
        .section-header {
            background: #e9ecef;
            padding: 10px 15px;
            font-weight: bold;
            border-radius: 5px;
            margin-top: 40px;
        }
    </style>
</head>
<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg bg-white mb-4">
  <div class="container">
    <a class="navbar-brand fw-bold text-primary">🛠️ Admin Dashboard</a>
    <div class="ms-auto">
      <a href="addItem.jsp" class="btn btn-success btn-sm"><i class="bi bi-plus-circle"></i> Add New Item</a>
      <a href="logout.jsp" class="btn btn-outline-danger btn-sm">Logout</a>
    </div>
  </div>
</nav>

<div class="container">
    <!-- ✅ Success Message -->
    <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">✅ Action completed successfully!</div>
    <% } %>

    <!-- 🍔 Menu Management Section -->
    <div class="section-header">🍽️ Menu Items</div>
    <table class="table table-bordered table-hover mt-3">
        <thead>
            <tr>
                <th>ID</th>
                <th>Item Name</th>
                <th>Description</th>
                <th>Price (₹)</th>
                <th>Image</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                conn = DBConnection.getConnection();
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM menu_items");

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("description") %></td>
                <td>₹<%= rs.getDouble("price") %></td>
                <td>
                    <img src="images/<%= rs.getString("image_url") %>" width="60" height="60" class="rounded" onerror="this.src='images/default.jpg'">
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
        %>
            <tr><td colspan="5" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
                try { if (conn != null) conn.close(); } catch (Exception ignored) {}
            }
        %>
        </tbody>
    </table>

    <!-- 🧾 Orders Overview Section -->
    <div class="section-header">📦 Student Orders</div>
    <table class="table table-bordered table-hover mt-3">
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Student Name</th>
                <th>Item</th>
                <th>Quantity</th>
                <th>Total (₹)</th>
                <th>Status</th>
                <th>Placed On</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection conn2 = null;
            Statement stmt2 = null;
            ResultSet rs2 = null;
            try {
                conn2 = DBConnection.getConnection();
                stmt2 = conn2.createStatement();
                rs2 = stmt2.executeQuery(
                    "SELECT o.id AS order_id, u.username, m.name AS item_name, " +
                    "o.quantity, o.total_price, o.status, o.order_date " +
                    "FROM orders o " +
                    "JOIN users u ON o.user_id = u.id " +
                    "JOIN menu_items m ON o.menu_item_id = m.id " +
                    "ORDER BY o.order_date DESC"
                );

                while (rs2.next()) {
        %>
            <tr>
                <td><%= rs2.getInt("order_id") %></td>
                <td><%= rs2.getString("username") %></td>
                <td><%= rs2.getString("item_name") %></td>
                <td><%= rs2.getInt("quantity") %></td>
                <td>₹<%= rs2.getDouble("total_price") %></td>
                <td><span class="badge bg-info text-dark"><%= rs2.getString("status") %></span></td>
                <td><%= rs2.getTimestamp("order_date") %></td>
            </tr>
        <%
                }
            } catch (Exception e) {
        %>
            <tr><td colspan="7" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
        <%
            } finally {
                try { if (rs2 != null) rs2.close(); } catch (Exception ignored) {}
                try { if (stmt2 != null) stmt2.close(); } catch (Exception ignored) {}
                try { if (conn2 != null) conn2.close(); } catch (Exception ignored) {}
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
