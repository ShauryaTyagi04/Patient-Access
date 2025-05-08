using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.dashboard
{
    public partial class doctors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDoctors();
            }
        }

        private void LoadDoctors()
        {
            if (Session["ClinicID"] == null)
            {
                return;
            }
            int clinicId = Convert.ToInt32(Session["ClinicID"]);

            string query = @"
                SELECT d.DoctorID, 
                       (d.FirstName + ' ' + d.LastName) AS DoctorName, 
                       d.Specialization, 
                       d.Description,
                       c.ClinicName
                FROM Doctors d
                INNER JOIN Clinics c ON d.ClinicID = c.ClinicID
                WHERE d.ClinicID = @ClinicID
                ORDER BY d.FirstName, d.LastName";

            SqlParameter[] parameters = {
                new SqlParameter("@ClinicID", clinicId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptDoctors.DataSource = dt;
            rptDoctors.DataBind();
        }
    }
}