using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace PatientAccess.pages.home
{
    public partial class signIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            signInError.Visible = false;
        }

        protected void signInBtn_Click(object sender, EventArgs e)
        {
            ResetErrorStates();
            bool isValid = true;

            if (string.IsNullOrWhiteSpace(email.Value))
            {
                email.Attributes["class"] += " input-error";
                isValid = false;
            }

            string pwd = password.Value;
            if (string.IsNullOrWhiteSpace(pwd))
            {
                password.Attributes["class"] += " input-error";
                isValid = false;
            }

            if (!isValid)
            {
                return;
            }

            if (AuthenticateUser(email.Value, pwd))
            {
                Session["UserEmail"] = email.Value;

                string query = "SELECT PatientID FROM Patients WHERE Email = @Email";
                SqlParameter[] parameters = { new SqlParameter("@Email", email.Value) };
                object patientIDObj = DatabaseHelper.ExecuteScalar(query, parameters);

                if (patientIDObj != null)
                {
                    Session["PatientID"] = Convert.ToInt32(patientIDObj);
                }

                string queryC = "SELECT ClinicID FROM Patients WHERE Email = @Email";
                SqlParameter[] parametersC = { new SqlParameter("@Email", email.Value) };
                object clinicIDObj = DatabaseHelper.ExecuteScalar(queryC, parametersC);

                if (clinicIDObj != null)
                {
                    Session["ClinicID"] = Convert.ToInt32(clinicIDObj);
                }
                string dashboardUrl = ResolveClientUrl(Page.GetRouteUrl("DashboardHome", null));
                Response.Redirect(dashboardUrl);
            }
            else
            {
                signInError.Visible = true;
            }
        }

        private bool AuthenticateUser(string email, string password)
        {
            string query = "SELECT PasswordHash FROM Patients WHERE Email = @Email";

            SqlParameter[] parameters = {
                new SqlParameter("@Email", email)
            };

            object storedHash = DatabaseHelper.ExecuteScalar(query, parameters);

            if (storedHash != null)
            {
                string storedPassword = storedHash.ToString();
                return VerifyPassword(password, storedPassword);
            }

            return false;
        }

        private bool VerifyPassword(string inputPassword, string storedHash)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(inputPassword));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString() == storedHash;
            }
        }

        private void ResetErrorStates()
        {
            email.Attributes["class"] = email.Attributes["class"].Replace(" input-error", "");
            password.Attributes["class"] = password.Attributes["class"].Replace(" input-error", "");
            signInError.Visible = false;
        }
    }
}