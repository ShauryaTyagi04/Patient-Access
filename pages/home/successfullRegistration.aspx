<%@ Page Title="Successful Registration" Language="C#" MasterPageFile="~/masterpages/Home.Master" AutoEventWireup="true" CodeBehind="successfullRegistration.aspx.cs" Inherits="PatientAccess.pages.home.successfullRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .confetti-container {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 1000;
        }
        .success-message {
            text-align: center;
            margin-top: 100px;
        }
        .success-message h1 {
            font-size: 2.5rem;
            color: #007bff; /* Bootstrap primary color */
        }
        .success-message p {
            font-size: 1.2rem;
            color: #555;
        }
        .success-message .btn {
            margin-top: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Confetti Effect -->
    <div class="confetti-container" id="confetti-container"></div>

    <!-- Success Message -->
    <div class="success-message mb-5">
        <h1>🎉 Welcome to <span class="text-primary">Patient</span> <span class="text-secondary">Access!</span></h1>
        <p>Your registration was successful.</p>
        <p>Start exploring your account now.</p>
        <a href="signIn.aspx" class="btn btn-primary btn-lg mx-">Go to Sign In</a>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            startConfetti();
        });

        function startConfetti() {
            const confettiContainer = document.getElementById("confetti-container");
            for (let i = 0; i < 100; i++) {
                let confettiPiece = document.createElement("div");
                confettiPiece.classList.add("confetti");
                confettiPiece.style.left = Math.random() * 100 + "vw";
                confettiPiece.style.animationDuration = Math.random() * 3 + 2 + "s";
                confettiContainer.appendChild(confettiPiece);
            }
        }

        function stopConfetti() {
            document.getElementById("confetti-container").innerHTML = "";
        }
    </script>

    <style>
        .confetti {
            width: 10px;
            height: 10px;
            background-color: #DC60A2;
            position: absolute;
            top: 0;
            animation: fall linear infinite;
        }
        
        @keyframes fall {
            0% {
                transform: translateY(0);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh);
                opacity: 0;
            }
        }
    </style>
</asp:Content>
