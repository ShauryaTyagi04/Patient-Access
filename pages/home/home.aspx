<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Home.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="PatientAccess.pages.home.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div style="margin-top: 50px;">
        <div class="row mb-5 align-items-center justify-content-center">
            <!-- Left Column: Text -->
            <div class="col-md-4">
                <h1 class="text-primary">Empowering You to Take Charge of Your Health</h1>
                <p class="fw-light mt-3">
                    Patient Access puts your healthcare at your fingertips. Manage your health with ease by booking doctor appointments and accessing your medical records. Log in securely with your credentials and get started on your journey to better health today.
                </p>
                <div class="row align-items-center">
                    <button class="btn-primary small-button me-2">Sign In</button>
                    <button class="btn-secondary small-button">Register</button>
                </div>
            </div>
            <!-- Right Column: Image -->
            <div class="col-md-4 text-center">
                <img src="../../assets/images/healthcare.jpg" class="img-fluid" id="healthcareImage" />
            </div>
        </div>
         <div class="row mt-5 mb-5 justify-content-center">
    <div class="col-md-10">
        <ul class="d-flex justify-content-around list-unstyled">
            <li class="text-center">
                <h4 class="text-primary"> Health Information
                </h4>
                <p>Description of the feature</p>
            </li>
            <li class="text-center">
                <h4 class="text-primary"> Communicate with<br>Healthcare Providers
                </h4>
                <p>Description of the feature</p>
            </li>
            <li class="text-center">
                <h4 class="text-primary"> Book Appointments
                </h4>
                <p>Description of the feature</p>
            </li>
        </ul>
    </div>
</div>

         <div class="quote-container text-center position-relative">
    <p class="fw-light fst-italic fs-4 mb-5">
        "Health is the greatest gift, contentment the greatest wealth, faithfulness the best relationship."
    </p>
    <p class="fw-lighter fst-italic quote-author">
        — Gautama Buddha, 5th–4th Century BC
    </p>
</div>

    </div>
</asp:Content>
