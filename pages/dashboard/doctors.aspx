<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="doctors.aspx.cs" Inherits="PatientAccess.pages.dashboard.doctors" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4 container-fluid-blur">
    <div class="d-flex justify-content-between align-items-center pb-4">
        <h2 class="text-primary">Meet Your <span class="text-secondary">Doctors</span></h2>
    </div>
        <div class="row">
            <asp:Repeater ID="rptDoctors" runat="server">
                <ItemTemplate>
                    <div class="col-md-6">
                        <div class="doctor-card">
                            <!-- Circle avatar using FA icon as placeholder -->
                            <div class="doctor-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <!-- Doctor's name with pink background -->
                            <h4 class="doctor-name">Dr. <%# Eval("DoctorName") %></h4>
                            <!-- Doctor details -->
                            <div class="doctor-info">
                                <div><%# Eval("Specialization") %></div>
                                <div><%# Eval("Description") %></div>
                                <div><%# Eval("ClinicName") %></div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        </div>
</asp:Content>
