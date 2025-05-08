<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/HealthInfo.master" AutoEventWireup="true" CodeBehind="immunizationHistory.aspx.cs" Inherits="PatientAccess.pages.healthInformation.immunizationHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
        <div class="pb-4">
<h1 class="text-primary">Immunization <span class="text-secondary">History</span></h1>
</div>
            <div class="row">
    <asp:Repeater ID="rptImmunizations" runat="server">
        <ItemTemplate>
            <div class="col-md-6">
                <div class="data-card">
                    <h5><%# Eval("VaccineName") %></h5>
                    <div class="px-3 py-2">
                    <p><strong>Date Administered:</strong> <%# Eval("DateAdministered", "{0:dd-MMM-yyyy}") %></p>
                    <p><strong>Dosage:</strong> <%# Eval("Dosage") %></p>
                    <p><strong>Administrator Name:</strong> <%# Eval("AdministratorName") %></p>
                    <p><strong>Clinc Location:</strong> <%# Eval("ClinicLocation") %></p>
                </div>
                    </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
</asp:Content>
