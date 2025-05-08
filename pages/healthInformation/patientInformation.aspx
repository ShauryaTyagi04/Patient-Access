<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/HealthInfo.master" AutoEventWireup="true" CodeBehind="patientInformation.aspx.cs" Inherits="PatientAccess.pages.healthInformation.patientInformation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    
    <div>
        <div class="pb-4">
            <h1 class="text-primary">Patient <span class="text-secondary">Information</span></h1>
            </div>
            <div class="col-md-8 mx-auto">
            <div class="d-flex justify-content-center">

            <div class="p-4 shadow-sm bg-white rounded" style="width:700px;">

            <div class="mb-4">
                <label class="text-primary" for="firstName">First Name:</label>
                <asp:Label ID="firstName" runat="server" />
            </div>
            <div class="mb-4">
                <label class="text-primary" for="lastName">Last Name:</label>
                <asp:Label ID="lastName" runat="server"/>
            </div>
        <div class="mb-4">
            <label class="text-primary" for="patientId">Patient ID:</label>
            <asp:Label ID="patientId" runat="server"/>
        </div>

        <div class="mb-4">
            <label class="text-primary" for="email">Email Address:</label>
            <asp:Label ID="email" runat="server"/>
        </div>

        <div class="mb-4">
            <label class="text-primary" for="phoneNumber">Phone Number:</label>
            <asp:Label ID="phoneNumber" runat="server"/>
        </div>

        <div class="mb-4">
            <label class="text-primary" for="nhsNumber">NHS Number:</label>
            <asp:Label ID="nhsNumber" runat="server"/>
        </div>

        <div class="mb-4">
            <label class="text-primary" for="DOB">Date of Birth:</label>
            <asp:Label ID="DOB" runat="server" />
        </div>

        <div class="mb-4">
            <label class="text-primary" for="postcode">Post Code:</label>
            <asp:Label ID="postcode" runat="server"/>
        </div>

        <div class="mb-4">
                <label  class="text-primary" for="gender">Gender:</label>
            <asp:Label ID="gender" runat="server"/>
            </div>
            <div class="mb-4">
                <label class="text-primary" for="emergencyContact">Emergency Contact Number:</label>
                <asp:Label ID="emergencyContact" runat="server"/>
            </div>
                <div class="mb-4">
                    <label class="text-primary" for="bloodGroup">Blood Group:</label>
                    <asp:Label ID="bloodGroup" runat="server" />
                </div>

    </div>
                            </div>
                </div>
        </div>
</asp:Content>
