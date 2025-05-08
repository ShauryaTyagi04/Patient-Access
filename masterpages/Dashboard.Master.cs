using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.masterpages
{
    public partial class Dashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect(ResolveClientUrl(Page.GetRouteUrl("Login", null)));
                return;
            }

            if (!IsPostBack)
            {
                LoadPatientProfile();
                LoadClinicID();
                LoadUnreadMessagesCount();
            }
        }

        private void LoadPatientProfile()
        {
            string query = "SELECT ProfileImage FROM Patients WHERE Email = @Email";
            SqlParameter[] parameters = { new SqlParameter("@Email", Session["UserEmail"].ToString()) };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0 && dt.Rows[0]["ProfileImage"] != DBNull.Value)
            {
                byte[] imageData = (byte[])dt.Rows[0]["ProfileImage"];
                string base64String = Convert.ToBase64String(imageData);
                profileImage.Src = "data:image/png;base64," + base64String;
            }
        }

        private void LoadClinicID()
        {
            string query = "SELECT ClinicName FROM Clinics WHERE ClinicID = @Clinic";
            SqlParameter[] parameters = { new SqlParameter("@Clinic", Session["ClinicID"]) };

            object result = DatabaseHelper.ExecuteScalar(query, parameters);

            clinicName.Text = result != null ? result.ToString() : "Unknown Clinic";
        }



        public string GetActiveClass(string expectedPath)
        {
            string currentPath = Request.AppRelativeCurrentExecutionFilePath.ToLower();

            return currentPath.Contains(expectedPath.ToLower()) ? "active" : "";
        }

        protected void ConfirmLogout(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect(ResolveClientUrl(Page.GetRouteUrl("Home", null)));
        }


        private void LoadUnreadMessagesCount()
        {
            string query = @"SELECT COUNT(*) 
                     FROM Messages 
                     WHERE PatientID = @PatientID 
                       AND ClinicID = @ClinicID 
                       AND SenderRole = 'Clinic' 
                       AND IsRead = 0";

            SqlParameter[] parameters = {
        new SqlParameter("@PatientID", Session["PatientID"]),
        new SqlParameter("@ClinicID", Session["ClinicID"])
    };

            object result = DatabaseHelper.ExecuteScalar(query, parameters);
            bookings.Text = result.ToString();
        }


    }


}