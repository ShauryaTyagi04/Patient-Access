using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.healthInformation
{
    public partial class patientFamilyHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHistory();
            }
        }

        private void LoadHistory()
        {
            if (Session["PatientID"] == null)
            {
                return;
            }

            int patientId = Convert.ToInt32(Session["PatientID"]);

            string query = @"
                SELECT HistoryID, FamilyMember, Relation, DateDiagnosed, HealthConditions, Age, Notes 
                FROM FamilyHistory
                WHERE PatientID = @PatientID
                ORDER BY DateDiagnosed DESC";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptHistories.DataSource = dt;
            rptHistories.DataBind();
        }
    }
}