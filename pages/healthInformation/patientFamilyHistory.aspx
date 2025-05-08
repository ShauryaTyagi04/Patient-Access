<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/HealthInfo.master" AutoEventWireup="true" CodeBehind="patientFamilyHistory.aspx.cs" Inherits="PatientAccess.pages.healthInformation.patientFamilyHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
        <div class="pb-4">
<h1 class="text-primary">Patient <span class="text-secondary">Family History</span></h1>
</div>
        <div class="row">
        <asp:Repeater ID="rptHistories" runat="server">
            <ItemTemplate>
                <div class="col-md-6">
                    <div class="data-card">
                        <h5><%# Eval("FamilyMember") %></h5>
                        <div class="px-3 py-2">
                        <p><strong>Relation:</strong> <%# Eval("Relation") %></p>
                        <p><strong>Age:</strong> <%# Eval("Age") %></p>
                        <p><strong>Health Conditions:</strong> <%# Eval("HealthConditions") %></p>
                        <p><strong>Date Diagnosed:</strong> <%# Eval("DateDiagnosed", "{0:dd-MMM-yyyy}") %></p>
                        <p><strong>Notes:</strong> <%# Eval("Notes") %></p>
                    </div>
                        </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
