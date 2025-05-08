<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="appointments.aspx.cs" Inherits="PatientAccess.pages.dashboard.appointments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4 container-fluid-blur">
        <div class="d-flex justify-content-between align-items-center pb-4">
        <h2 class="text-primary">Book an <span class="text-secondary">Appointment</span></h2>
            <div>
                <asp:button runat="server" ID="upcomingAppointmentRedirect" OnClick="upcomingAppointmentBtn_Click" Text="Upcoming Appointments" CssClass="alt-btn-primary medium-button me-2"/>
                <asp:button runat="server" ID="manualAppointmentRedirect" OnClick="manualAppointmentBtn_Click" Text="Manual Booking Form" CssClass="alt-btn-primary medium-button me-2"/>
            </div>
         </div>

        <div class="alert alert-info">Available slots for 3 weeks</div>
        <div class="alert alert-danger">In case of an emergency contact your clinic for an early appointment</div>

        <!-- Repeater for Appointments -->
        <asp:Repeater ID="rptAppointments" runat="server">
            <ItemTemplate>
                <div class="appointment-card">
                    <div class="row align-items-center">
                        <div class="col-md-3">
                            <i class="fas fa-calendar-alt fa-2x text-primary"></i>
                            <label class="d-block text-secondary"><%# Eval("Date") %></label>
                        </div>
                        <div class="col-md-3">
                            <i class="fas fa-user-md fa-2x text-success"></i>
                            <label class="d-block"><%# Eval("Doctor") %></label>
                        </div>
                        <div class="col-md-3">
                            <i class="fas fa-clock fa-2x text-info"></i>
                            <label class="d-block"> <%# Eval("StartTime") %> - <%# Eval("EndTime") %></label>
                        </div>
                        <div class="col-md-3">
                            <asp:Button ID="btnBook" runat="server" CssClass="btn btn-primary btn-sm" Text="Book Now" CommandArgument='<%# Eval("AvailableBookingID") %>' OnClick="BookAppointment" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
</asp:Content>
