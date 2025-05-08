<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Home.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="PatientAccess.pages.home.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-top: 50px;">
        <div class="row align-items-center text-center justify-content-center">
            <div class="col-md-4">
                <h3>Create your 
                    <span class="text-secondary">Patient </span>
                    <span class="text-primary">Access </span>
                    Account
                </h3>
                <p>Already have an account? 
                    <a class="text-primary" href="signIn.aspx">Sign in to Patient Access</a>
                </p>
                <label class="text-danger" id="lblMessage" runat="server"></label>
             </div>
      </div>
        <div class="row justify-content-center">
            <!-- Container 1 -->
            <div class="column-container col-md-5 mb-4 justify-content-evenly">
                <input type="text" id="firstName" placeholder="Enter your first name" class="form-input mb-3" runat="server" />
                <input type="text" id="lastName" placeholder="Enter your last name" class="form-input mb-3" runat="server" />
                <input type="text" id="postcode" placeholder="Enter your postcode" class="form-input mb-3" runat="server" />
                <label class="form-label mb-1">Date of Birth</label>
                <div class="d-flex gap-2">
                    <input type="text" id="dobDay" placeholder="Day" class="form-input" runat="server" />
                    <select id="dobMonth" class="form-select" runat="server"></select>

                    <input type="text" id="dobYear" placeholder="Year" class="form-input" runat="server" />
                </div>
                <select id="gender" class="form-select mt-3" runat="server">
                    <option value="" disabled selected>Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <!-- Container 2 -->
            <div class="column-container col-md-5 mb-4 justify-content-evenly">
                <div class="position-relative mb-3" style="width:100%">
                    <input type="text" id="nhsNumber" placeholder="Enter your NHS number" class="form-input" runat="server" />
                </div>
                <div class="position-relative mb-3" style="width:100%">
                    <input type="email" id="email" placeholder="Enter your email address" class="form-input" runat="server" />
                </div>
                <div class="position-relative mb-3" style="width:100%">
                    <input type="text" id="phoneNumber" placeholder="Enter your phone number" class="form-input" runat="server" />
                </div>
                <div class="password-container">
                    <input type="password" id="password" placeholder="Enter your password" class="form-input mb-3" runat="server" ClientIDMode="Static" />
                </div>
                <div class="password-container">
                    <input type="password" id="cPassword" placeholder="Confirm your password" class="form-input mb-3" runat="server" ClientIDMode="Static" />
                </div>
                <input type="text" id="emergencyContact" placeholder="Enter an emergency contact number" class="form-input" runat="server" />

                <div class="mt-3" style="width:100%;">
                    <label class="text-primary form-label mb-2">Upload your profile picture</label>
                    <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control mb-4" />
                </div>
            </div>
            

            <!-- Submit Button -->
            <div class="text-center">
                <asp:Button runat="server" ID="registerBtn" OnClick="registerBtn_Click" Text="Register" CssClass="btn-primary large-button mt-2 mb-4" />
            </div>
        </div>
    </div>
</asp:Content>
