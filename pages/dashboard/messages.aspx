<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="messages.aspx.cs" Inherits="PatientAccess.pages.dashboard.messages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        <style>
        .chat-box {
            height: 400px;
            overflow-y: scroll;
            background-color: #ffffff;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #DC60A2;
        }

        .chat-message {
            max-width: 75%;
            padding: 10px 15px;
            border-radius: 18px;
            margin-bottom: 15px;
            display: inline-block;
            word-wrap: break-word;
            font-size: 14px;
            position: relative;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .chat-patient {
            background-color: #dc60a220; /* Transparent #DC60A2 */
            color: #000000;
            float: right;
            text-align: left;
            clear: both;
        }

        .chat-clinic {
            background-color: #f1f0f0;
            color: #198754;
            float: left;
            text-align: left;
            clear: both;
        }

        .timestamp {
            font-size: 11px;
            color: gray;
            margin-top: 5px;
            display: block;
            text-align: right;
        }

        /* Optional: Reset float fix */
        .chat-box::after {
            content: "";
            display: block;
            clear: both;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function loadMessages() {
            $.ajax({
                type: "POST",
                url: "/pages/dashboard/messages.aspx/GetMessages",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (xhr, status, error) {
                    console.error("AJAX Error:", status, error);
                },
                success: function (response) {
                    const messages = JSON.parse(response.d);
                    const container = document.getElementById('<%= messageContainer.ClientID %>');
                    container.innerHTML = "";

                    messages.forEach(msg => {
                        const className = msg.sender === "Patient" ? "chat-patient" : "chat-clinic";
                        container.innerHTML += `
                            <div class='chat-message ${className}'>
                                <div>${msg.message}</div>
                                <div class='timestamp'>${msg.sentTime}</div>
                            </div>`;
                    });

                }
            });
        }

        setInterval(loadMessages, 3000); // Refresh every 3 seconds
        window.onload = loadMessages;
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const input = document.getElementById('<%= messageInput.ClientID %>');
            const button = document.getElementById('<%= sendBtn.ClientID %>');

            input.addEventListener("input", function () {
                button.disabled = input.value.trim() === "";
            });
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

    <!-- Sticky Header -->
    <div class="container-fluid bg-white sticky-top py-2 px-4" style="z-index: 100;">
        <h4 class="mb-0 text-primary"><asp:Label ID="ClinicNameLabel" runat="server" Text="Your Clinic"></asp:Label></h4>
    </div>

    <!-- Chat Box -->
    <div class="chat-box p-4" id="messageContainer" runat="server"></div>

    <!-- Sticky Footer Input Section -->
    <div class="container-fluid sticky-bottom bg-white pt-3 px-4 pb-4 border-top" style="z-index: 100;">
        <div class="d-flex gap-2">
            <asp:TextBox ID="messageInput" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Type your message..."></asp:TextBox>
            <asp:Button ID="sendBtn" runat="server" Text="Send" CssClass="btn btn-primary" OnClick="SendBtn_Click" />
        </div>
    </div>
</asp:Content>

