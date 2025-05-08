using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.healthInformation
{
    public partial class allergies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllergies();
            }
        }

        private void LoadAllergies()
        {
            if (Session["PatientID"] == null)
            {
                return;
            }

            int patientId = Convert.ToInt32(Session["PatientID"]);

            string query = @"
                SELECT AllergyID, AllergyName, Allergen, DateDiagnosed, Severity, Treatment, Notes 
                FROM Allergies 
                WHERE PatientID = @PatientID
                ORDER BY DateDiagnosed DESC";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptAllergies.DataSource = dt;
            rptAllergies.DataBind();
        }
    }
}