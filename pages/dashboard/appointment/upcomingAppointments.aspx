<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="upcomingAppointments.aspx.cs" Inherits="PatientAccess.pages.dashboard.upcomingAppointments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4 container-fluid-blur">
        <div class="d-flex justify-content-between align-items-center pb-4">
            <h2 class="text-primary">Your <span class="text-secondary">Upcoming Appointments</span></h2>
            <div>
                <asp:Button runat="server" ID="availableAppointmentRedirect" OnClick="availableAppointmentBtn_Click" Text="Available Appointments" CssClass="alt-btn-primary medium-button me-2" />
                <asp:Button runat="server" ID="manualAppointmentRedirect" OnClick="manualAppointmentBtn_Click" Text="Manual Booking Form" CssClass="alt-btn-primary medium-button me-2" />
            </div>
        </div>

        <div class="alert alert-info">Below are your upcoming appointments. Click Cancel to free up the slot for others.</div>
        <div class="alert alert-danger">If you need to reschedule, please contact your clinic.</div>

        <!-- Repeater for Booked Appointments -->
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
                            <label class="d-block"><%# Eval("StartTime") %> - <%# Eval("EndTime") %></label>
                        </div>
                        <div class="col-md-3">
                            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-error btn-sm" Text="Cancel" 
                                CommandArgument='<%# Eval("AppointmentID") %>' OnClientClick='<%# "return showConfirmModal(" + Eval("AppointmentID") + ");" %>' />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <asp:HiddenField ID="hfAppointmentID" runat="server" />
            <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmModalLabel">Confirm Appontment Cancellation</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to cancel this appointment?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <asp:Button runat="server" ID="confirmCancelBtn" CommandArgument='<%# Eval("AppointmentID") %>' Text="Confirm" CssClass="btn btn-error" OnClick="ConfirmCancel" />
                        </div>
                    </div>
                </div>
            </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
            <script>
                function showConfirmModal(appointmentId) {
                    document.getElementById('<%= hfAppointmentID.ClientID %>').value = appointmentId;
                    const confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
                    confirmModal.show();
                    return false;
                }
            </script>
</asp:Content>
