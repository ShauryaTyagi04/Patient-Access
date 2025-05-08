<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="appointmentSuccess.aspx.cs" Inherits="PatientAccess.pages.dashboard.appointmentSuccess" %>
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
        color: #007bff;
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
        <h1>🎉 Appointment <span class="text-primary">Booked</span> <span class="text-secondary"> Successfuly!</span></h1>
        <p> View your upcoming appointments.</p>
        <a href='<%= ResolveClientUrl(Page.GetRouteUrl("UpcomingAppointments", null)) %>' class="btn btn-primary btn-lg mx-">Upcoming Appointments</a>
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
            background-color: #79EE8D;
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
