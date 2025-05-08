<%@ Page Title="" Language="C#" MasterPageFile="~/masterpages/Dashboard.Master" AutoEventWireup="true" CodeBehind="dashboardHome.aspx.cs" Inherits="PatientAccess.pages.dashboard.dashboardHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row">
            <!-- First Card: Upcoming Appointments -->
            <div class="mb-4">
                <div class="card rounded-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3 class="text-primary">Upcoming Appointments</h3>
                        <button type="button" onclick=location.href='<%= ResolveClientUrl(Page.GetRouteUrl("UpcomingAppointments", null)) %>' class="alt-btn-primary">View All</button>
                    </div>
                    <div class="card-body text-center">
                        <p><strong class="text-primary">Date:</strong> <asp:Literal ID="litAppointmentDate" runat="server" /></p>
                        <p><strong class="text-primary">Time:</strong> <asp:Literal ID="litAppointmentTime" runat="server" /></p>
                        <p><strong class="text-primary">Doctor:</strong> <asp:Literal ID="litDoctorName" runat="server" /></p>
                    </div>
                </div>
            </div>

            <!-- Second Card: Messages -->
            <div>
                <div class="card rounded-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3 class="text-primary">Messages</h3>
                        <button type="button" onclick=location.href='<%= ResolveClientUrl(Page.GetRouteUrl("Messages", null)) %>' class="btn alt-btn-primary">View All</button>
                    </div>
                    <div class="card-body">
                        <asp:Repeater ID="rptUnreadMessages" runat="server">
                            <ItemTemplate>
                                <div class="mb-2">
                                    <p class="mb-1"><strong><%# Eval("SentAt") %></strong></p>
                                    <p class="text-secondary mb-0"><%# Eval("MessageText") %></p>
                                    <hr />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:Literal ID="litNoMessages" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
