using System;

namespace PatientAccess.masterpages
{
    public partial class HealthInfo : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect(ResolveClientUrl(Page.GetRouteUrl("Login", null)));
                return;
            }
        }

        public string GetActiveClass(string expectedPath)
        {
            string currentPath = Request.AppRelativeCurrentExecutionFilePath.ToLower();

            return currentPath.Contains(expectedPath.ToLower()) ? "active" : "";
        }

    }
}