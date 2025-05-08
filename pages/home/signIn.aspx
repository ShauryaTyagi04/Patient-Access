<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Home.Master" AutoEventWireup="true" CodeBehind="signIn.aspx.cs" Inherits="PatientAccess.pages.home.signIn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-top: 50px;">
    <div class="row align-items-center text-center justify-content-center">
        <div class="col-md-4">
            <h3>Sign in to your 
                <span class="text-secondary">Patient </span>
                <span class="text-primary">Access </span>
                Account
            </h3>
            <p>Don't have an account? 
                <a class="text-primary" href="register.aspx">Register with Patient Access</a>

            </p>
         </div>
  </div>
    <div class="row justify-content-center">
        <div class="column-container-small col-md-5 mb-4 justify-content-evenly">
            <div class="alert alert-danger align-middle" style="width:100%; font-size:12px" id="signInError" runat="server" role="alert">
              Invalid email or password.
            </div>
            <input type="email" id="email" placeholder="Enter your email address" class="form-input mb-3" runat="server" />
            <div class="password-container">
                <input type="password" id="password" placeholder="Enter your password" class="form-input mb-3" runat="server" ClientIDMode="Static" />
            </div>
            </div>
        </div>
        <div class="text-center">
            <asp:Button runat="server" ID="signInBtn" OnClick="signInBtn_Click" Text="Sign in" CssClass="btn-primary large-button mt-2 mb-4" />
        </div>
    </div>
</asp:Content>
