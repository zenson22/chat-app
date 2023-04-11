function showPass() {
	var x = document.getElementById("password");
	if (x.type === "password") {
		x.type = "text";
	} else {
		x.type = "password";
	}
}
function check() {
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	if (username.value == "") {
		document.getElementById("username").innerHTML = "Vui lòng nhập đầy đủ họ tên";
	} else {
		document.getElementById("username").innerHTML = "ds";
	}
	if (password.value == "") {
		document.getElementById("password").innerHTML = "Vui lòng nhập mật khẩu";
	} else {
		document.getElementById("password").innerHTML = "sd";
	}
}
	var correct_user = "Doanphuong";
	var correct_password = "Phuongtit";

	var username = document.getElementById("username");
	var password = document.getElementById("password");

	var formlogin = document.getElementsByClassName("form-login");
	if (formlogin.attachEvent) {
		formlogin.attachEvent("submit", check);
	} else {
		formlogin.addEventListener("submit", check);
	}
	function check() {
		var username = inputuser.value;
		var password = inputpassword.value;
		if (username == correct_user && password == correct_password) {
			alert("Đăng nhập thành công!");
		} else {
			alert(" Đăng nhập không thành công + Hãy kiểm tra lại");
		}
	} 