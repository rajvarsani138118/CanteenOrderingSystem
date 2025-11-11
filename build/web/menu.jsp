<%@ page import="java.sql.*, com.mycompany.canteen.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Canteen Menu</title>

    <!-- ✅ Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .add-cart {
            width: 100%;
            border-radius: 10px;
        }
    </style>
</head>

<body>
    <!-- ✅ Navbar -->
    <nav class="navbar navbar-light bg-white shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="menu.jsp">🍴 Canteen System</a>
            <div>
                <a class="btn btn-outline-primary position-relative" href="order.jsp">
                    <i class="bi bi-cart3"></i> Cart
                    <span class="badge bg-danger position-absolute top-0 start-100 translate-middle" id="cartCount">0</span>
                </a>
            </div>
        </div>
    </nav>

    <!-- ✅ Menu List -->
    <div class="container mt-4">
        <div class="row">
            <%
                Connection conn = null;
                Statement st = null;
                ResultSet rs = null;

                try {
                    conn = DBConnection.getConnection();
                    st = conn.createStatement();
                    rs = st.executeQuery("SELECT * FROM menu_items");

                    while (rs.next()) {
            %>
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <img src="images/<%= rs.getString("image_url") %>" 
                                     class="card-img-top" 
                                     alt="<%= rs.getString("name") %>" 
                                     onerror="this.src='images/default.jpg'">

                                <div class="card-body text-center">
                                    <h5 class="card-title"><%= rs.getString("name") %></h5>
                                    <p class="card-text text-muted"><%= rs.getString("description") %></p>
                                    <p class="fw-bold text-success">₹<%= rs.getDouble("price") %></p>

                                    <button class="btn btn-primary add-cart" 
                                            data-id="<%= rs.getInt("id") %>" 
                                            data-name="<%= rs.getString("name") %>" 
                                            data-price="<%= rs.getDouble("price") %>">
                                        <i class="bi bi-cart-plus-fill"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Error loading menu: " + e.getMessage() + "</div>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                    try { if (st != null) st.close(); } catch (Exception ignored) {}
                    try { if (conn != null) conn.close(); } catch (Exception ignored) {}
                }
            %>
        </div>
    </div>

    <!-- ✅ Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- ✅ AJAX Add to Cart -->
    <script>
    document.querySelectorAll('.add-cart').forEach(btn => {
        btn.addEventListener('click', function() {
            const id = this.dataset.id;
            const name = this.dataset.name;
            const price = this.dataset.price;

            fetch('addToCart', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ menuItemId: id, name: name, price: price })
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'success') {
                    document.getElementById('cartCount').textContent = data.count;
                    showToast("✅ " + name + " added to cart!");
                } else {
                    alert("Error adding item to cart");
                }
            })
            .catch(err => alert("Error connecting to server"));
        });
    });

    // ✅ Simple toast notification
    function showToast(msg) {
        const toast = document.createElement('div');
        toast.className = 'toast align-items-center text-white bg-success border-0 position-fixed bottom-0 end-0 m-3';
        toast.style.zIndex = '9999';
        toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">${msg}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>`;
        document.body.appendChild(toast);
        const bsToast = new bootstrap.Toast(toast);
        bsToast.show();
        setTimeout(() => toast.remove(), 3000);
    }
    </script>
</body>
</html>
