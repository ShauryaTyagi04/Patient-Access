using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.healthInformation
{
    public partial class immunizationHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadImmunizations();
            }
        }

        private void LoadImmunizations()
        {
            if (Session["PatientID"] == null)
            {
                return;
            }

            int patientId = Convert.ToInt32(Session["PatientID"]);

            string query = @"
                SELECT ImmunizationID, VaccineName, DateAdministered, Dosage, AdministratorName, ClinicLocation 
                FROM Immunizations 
                WHERE PatientID = @PatientID
                ORDER BY DateAdministered DESC";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptImmunizations.DataSource = dt;
            rptImmunizations.DataBind();
        }
    }
}