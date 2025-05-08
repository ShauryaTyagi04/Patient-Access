<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/HealthInfo.master" AutoEventWireup="true" CodeBehind="allergies.aspx.cs" Inherits="PatientAccess.pages.healthInformation.allergies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container-fluid-blur">
<div class="pb-4">
    <h1 class="text-primary">Patient <span class="text-secondary">Allergies</span></h1>
</div>
<div class="row">
        <asp:Repeater ID="rptAllergies" runat="server">
            <ItemTemplate>
                <div class="col-md-6">
                    <div class="data-card">
                        <h5><%# Eval("AllergyName") %></h5>
                        <div class="px-3 py-2">
                        <p><strong>Allergen:</strong> <%# Eval("Allergen") %></p>
                        <p><strong>Date Diagnosed:</strong> <%# Eval("DateDiagnosed", "{0:dd-MMM-yyyy}") %></p>
                        <p><strong>Severity:</strong> <%# Eval("Severity") %></p>
                        <p><strong>Treatment:</strong> <%# Eval("Treatment") %></p>
                        <p><strong>Notes:</strong> <%# Eval("Notes") %></p>
                    </div>
                        </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
</asp:Content>
