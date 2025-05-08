<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="manualAppointments.aspx.cs" Inherits="PatientAccess.pages.dashboard.manualAppointments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4 container-fluid-blur">
        <div class="d-flex justify-content-between align-items-center pb-4">
            <h2 class="text-primary">Manual <span class="text-secondary">Appointment Booking</span></h2>
        </div>

        <div class="card p-4 shadow-sm">
            <div class="row">
                <!-- Date Selection -->
                <div class="col-md-4">
                    <label class="text-primary" for="appointmentDate">Select Date:</label>
                    <asp:TextBox 
                        ID="appointmentDate" 
                        runat="server" 
                        CssClass="form-control" 
                        TextMode="Date" 
                        AutoPostBack="true" 
                        OnTextChanged="appointmentDate_TextChanged" 
                        required>
                    </asp:TextBox>
                </div>


                <!-- Time Slot -->
                <div class="col-md-4">
                    <label class="text-primary" for="appointmentTime">Select Time:</label>
                    <asp:DropDownList ID="appointmentTime" runat="server" CssClass="form-select" required></asp:DropDownList>
                </div>

                <!-- Doctor Selection -->
                <div class="col-md-4">
                    <label class="text-primary" for="doctorList">Select Doctor:</label>
                    <asp:DropDownList 
                        ID="doctorList" 
                        runat="server" 
                        CssClass="form-select" 
                        AutoPostBack="true" 
                        OnSelectedIndexChanged="doctorList_SelectedIndexChanged" 
                        required>
                    </asp:DropDownList>
                </div>

            <div class="text-center mt-4">
                <asp:Button runat="server" ID="btnBookManual" CssClass="btn btn-primary" Text="Book Appointment" OnClick="BookManualAppointment" />
            </div>
        </div>
    </div>
        </div>
</asp:Content>
