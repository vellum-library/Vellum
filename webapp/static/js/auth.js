document.querySelectorAll(".toggle-password").forEach(button => {

    button.addEventListener("click", () => {

        const input = document.getElementById(button.dataset.target);

        if (input.type === "password") {
            input.type = "text";
            button.textContent = "Ocultar";
        } else {
            input.type = "password";
            button.textContent = "Mostrar";
        }

    });

});