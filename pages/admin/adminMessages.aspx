<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="adminMessages.aspx.cs" Inherits="PatientAccess.pages.admin.adminMessages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .chat-box {
            height: 400px;
            overflow-y: scroll;
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .chat-message {
            margin-bottom: 12px;
        }

        .chat-patient {
            text-align: left;
            color: #0d6efd;
        }

        .chat-clinic {
            text-align: right;
            color: #198754;
        }

        .timestamp {
            font-size: 12px;
            color: gray;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Clinic Message Center</h3>

        <asp:DropDownList ID="ddlPatients" runat="server" AutoPostBack="true" CssClass="form-control mb-3" OnSelectedIndexChanged="ddlPatients_SelectedIndexChanged"></asp:DropDownList>

        <div class="chat-box mb-3" id="chatContainer" runat="server"></div>

        <asp:TextBox ID="messageInput" runat="server" CssClass="form-control mb-2" TextMode="MultiLine" Rows="3" placeholder="Type your reply..."></asp:TextBox>
        <asp:Button ID="sendReplyBtn" runat="server" Text="Send Reply" CssClass="btn btn-success" OnClick="sendReplyBtn_Click" />
</asp:Content>
