<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>UMS</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>

function editUser(id) {
	document.getElementById("editUserId").value = id;
	console.log(id);
}

function validateForm() {
	  var id = document.forms["myForm"]["id"].value;
	  if (id == "") {
	    console.log("ID must be filled out");
	  }else{
		  console.log("id is: "+id)
	  }
	}
</script>


<style>
h2 {
	text-align: center;
	margin-top: 20px;
}

table {
	margin-top: 20px;
}
</style>
</head>


<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<div class="container-fluid">
				<a href="#" class="navbar-brand"><b>User Management App</b></a>
				<div class="collapse navbar-collapse justify-content-between"
					id="navbarCollapse">
					<div class="navbar-nav">
						<a href="<%=request.getContextPath()%>/list"
							class="nav-item nav-link">Users</a>
					</div>
				</div>
			</div>
		</nav>
	</header>

	<main>
		<h2>List of Users</h2>
		<hr>
		<div class="container">
			<button type="button" class="btn btn-success" data-toggle="modal"
				data-target="#addUserModal">Add New User</button>
		</div>
		<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog"
			aria-labelledby="addUserModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="insert" method="post">
							<div class="form-group">
								<label for="name">Name</label> <input type="text"
									class="form-control" id="name" name="name" required>
							</div>
							<div class="form-group">
								<label for="email">Email</label> <input type="email"
									class="form-control" id="email" name="email" required>
							</div>
							<div class="form-group">
								<label for="email">Country</label> <input type="text"
									class="form-control" id="country" name="country" required>
							</div>
							<br>
							<button type="submit" class="btn btn-success">Save</button>
						</form>
					</div>
				</div>
			</div>
		</div>


		<div class="container">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Country</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listUser}" var="user">
						<tr>
							<td>${user.id}</td>
							<td>${user.name}</td>
							<td>${user.email}</td>
							<td>${user.country}</td>
							<td><a href="#" data-toggle="modal"
								data-target="#editUserModal" onclick="editUser(${user.id})">Edit</a>
								<a href="delete?id=${user.id}">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- data-toggle="modal" data-target="#editUserModal" -->

		<div class="modal fade" id="editUserModal" tabindex="-1" role="dialog"
			aria-labelledby="editUserModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form name="myForm" action="<%=request.getContextPath()%>/update"
							method="post" onsubmit="return validateForm()">
							<div class="form-group">
								Edit User with id: <input type="text" class="form-control"
									name="id" id="editUserId" readonly>
							</div>
							<div class="form-group">
								<label for="name">Name</label> <input type="text"
									class="form-control" id="name" name="name" required>
							</div>
							<div class="form-group">
								<label for="email">Email</label> <input type="email"
									class="form-control" id="email" name="email" required>
							</div>
							<div class="form-group">
								<label for="email">Country</label> <input type="text"
									class="form-control" id="country" name="country" required>
							</div>
							<br>
							<button type="submit" class="btn btn-success">Update</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
	

</body>
</html>