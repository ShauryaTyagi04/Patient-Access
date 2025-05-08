using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.healthInformation
{
    public partial class patientInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadPatientInformation();
        }

        private void LoadPatientInformation()
        {
            string query = "SELECT EmergencyContactNumber, BloodType, FirstName, LastName, Email, PhoneNumber, PatientID, NHSNumber, DateOfBirth, PostCode, Gender, ProfileImage FROM Patients WHERE Email = @Email";
            SqlParameter[] parameters = { new SqlParameter("@Email", Session["UserEmail"].ToString()) };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                firstName.Text = row["FirstName"].ToString();
                lastName.Text = row["LastName"].ToString();
                email.Text = row["Email"].ToString();
                phoneNumber.Text = row["PhoneNumber"].ToString();
                emergencyContact.Text = row["EmergencyContactNumber"].ToString();
                nhsNumber.Text = row["NHSNumber"].ToString();

                DateTime dob = Convert.ToDateTime(row["DateOfBirth"]);
                DOB.Text = dob.ToString("dd/MM/yyyy");

                gender.Text = row["Gender"].ToString();

                patientId.Text = row["PatientID"].ToString();
                postcode.Text = row["PostCode"].ToString();
                bloodGroup.Text = row["BloodType"].ToString();

            }
        }
    }
}