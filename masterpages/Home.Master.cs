using System;

namespace PatientAccess.masterpages
{
    public partial class Home : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void signinBtnRedirect_Click(object sender, EventArgs e)
        {
            string routeUrl = Page.GetRouteUrl("Login", null);
            Response.Redirect(ResolveClientUrl(routeUrl));
        }

        protected void registerBtnRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.GetRouteUrl("Register", null));
        }
    }
}