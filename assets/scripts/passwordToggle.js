document.addEventListener("DOMContentLoaded", function () {
    const togglePassword = document.getElementById("togglePassword");
    const passwordInput = document.getElementById("password");

    if (togglePassword && passwordInput) {
        togglePassword.addEventListener("click", function () {
            const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
            passwordInput.setAttribute("type", type);

            this.classList.toggle("fa-eye");
            this.classList.toggle("fa-eye-slash");
        });
    }

    const cTogglePassword = document.getElementById("cTogglePassword");
    const cPasswordInput = document.getElementById("cPassword");

    if (cTogglePassword && cPasswordInput) {
        cTogglePassword.addEventListener("click", function () {
            const type = cPasswordInput.getAttribute("type") === "password" ? "text" : "password";
            cPasswordInput.setAttribute("type", type);

            this.classList.toggle("fa-eye");
            this.classList.toggle("fa-eye-slash");
        });
    }
});
