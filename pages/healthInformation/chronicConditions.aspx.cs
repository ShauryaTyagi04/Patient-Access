using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.healthInformation
{
    public partial class chronicConditions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadConditions();
            }
        }

        private void LoadConditions()
        {
            if (Session["PatientID"] == null)
            {
                return;
            }

            int patientId = Convert.ToInt32(Session["PatientID"]);

            string query = @"
                SELECT ConditionID, ConditionName, DateDiagnosed, Severity, Treatment, Notes 
                FROM ChronicConditions 
                WHERE PatientID = @PatientID
                ORDER BY DateDiagnosed DESC";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptConditions.DataSource = dt;
            rptConditions.DataBind();
        }
    }
}