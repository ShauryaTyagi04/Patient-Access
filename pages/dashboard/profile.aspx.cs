using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PatientAccess.pages.dashboard
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropdowns();
                LoadPatientProfile();
            }
        }

        private void PopulateDropdowns()
        {
            dobMonth.Items.Clear();
            dobMonth.Items.Add(new ListItem("Month", ""));

            foreach (var monthName in System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.MonthNames)
            {
                if (!string.IsNullOrEmpty(monthName))
                {
                    dobMonth.Items.Add(new ListItem(monthName, monthName));
                }
            }
        }

        private void LoadPatientProfile()
        {
            string query = "SELECT EmergencyContactNumber, FirstName, LastName, Email, PhoneNumber, PatientID, NHSNumber, DateOfBirth, PostCode, Gender, ProfileImage FROM Patients WHERE Email = @Email";
            SqlParameter[] parameters = { new SqlParameter("@Email", Session["UserEmail"].ToString()) };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                ViewState["CurrentPatientID"] = row["PatientID"].ToString();

                firstName.Value = row["FirstName"].ToString();
                lastName.Value = row["LastName"].ToString();
                email.Value = row["Email"].ToString();
                phoneNumber.Value = row["PhoneNumber"].ToString();
                emergencyContact.Value = row["EmergencyContactNumber"].ToString();
                nhsNumber.Value = row["NHSNumber"].ToString();

                DateTime dob = Convert.ToDateTime(row["DateOfBirth"]);
                dobDay.Value = dob.ToString("dd");
                dobYear.Value = dob.ToString("yyyy");
                dobMonth.Value = dob.ToString("MMMM");

                gender.Value = row["Gender"].ToString();

                patientId.Value = row["PatientID"].ToString();
                postcode.Value = row["PostCode"].ToString();

                if (row["ProfileImage"] != DBNull.Value)
                {
                    byte[] imageData = (byte[])row["ProfileImage"];
                    string base64String = Convert.ToBase64String(imageData);
                    profileImage.Src = "data:image/png;base64," + base64String;
                }
            }
        }

        protected void SubmitChanges(object sender, EventArgs e)
        {
            string newEmail = email.Value.Trim();
            string newPhoneNumber = phoneNumber.Value.Trim();
            string currentPatientID = ViewState["CurrentPatientID"].ToString();

            bool isDuplicateEmail = CheckDuplicate("Email", newEmail, currentPatientID);
            bool isDuplicatePhone = CheckDuplicate("PhoneNumber", newPhoneNumber, currentPatientID);

            if (isDuplicateEmail)
            {
                emailError.Attributes["style"] = "display: block !important;";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowTooltip", "showTooltip('email');", true);
                return;
            }

            if (isDuplicatePhone)
            {
                phoneError.Attributes["style"] = "display: block !important;";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowTooltip", "showTooltip('phoneNumber');", true);
                return;
            }

            string query = "UPDATE Patients SET FirstName = @FirstName, LastName = @LastName, PhoneNumber = @PhoneNumber, EmergencyContactNumber = @EmergencyContactNumber WHERE Email = @Email";
            SqlParameter[] parameters = {
                new SqlParameter("@FirstName", firstName.Value),
                new SqlParameter("@LastName", lastName.Value),
                new SqlParameter("@PhoneNumber", phoneNumber.Value),
                new SqlParameter("@EmergencyContactNumber", emergencyContact.Value),
                new SqlParameter("@Email", Session["UserEmail"].ToString())
            };

            bool isUpdated = DatabaseHelper.ExecuteNonQuery(query, parameters);


            if (isUpdated)
            {

                Response.Redirect(ResolveClientUrl(Page.GetRouteUrl("Profile", null)));
            }
        }

        protected void UploadImage(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                // Check file size (50MB limit)
                int maxFileSize = 50 * 1024 * 1024; // 50MB
                if (fileUpload.PostedFile.ContentLength > maxFileSize)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowToast", "showToast('File size exceeds the 50MB limit!', 'error');", true);
                    return;
                }

                byte[] imageBytes;
                using (BinaryReader br = new BinaryReader(fileUpload.PostedFile.InputStream))
                {
                    imageBytes = br.ReadBytes(fileUpload.PostedFile.ContentLength);
                }

                string query = "UPDATE Patients SET ProfileImage = @ProfileImage WHERE Email = @Email";
                SqlParameter[] parameters = {
            new SqlParameter("@ProfileImage", imageBytes),
            new SqlParameter("@Email", Session["UserEmail"].ToString())
        };

                bool isUpdated = DatabaseHelper.ExecuteNonQuery(query, parameters);

                if (isUpdated)
                {
                    Response.Redirect(ResolveClientUrl(Page.GetRouteUrl("Profile", null)));
                }
            }
        }


        protected void ChangePassword(object sender, EventArgs e)
        {
            string Password = newPassword.Value.Trim();

            // Basic Validation
            if (string.IsNullOrEmpty(Password) || Password.Length < 6)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowToast", "showToast('Password must be at least 6 characters long', 'error');", true);
                return;
            }

            string hashedPassword = HashPassword(Password);
            string query = "UPDATE Patients SET PasswordHash = @PasswordHash WHERE Email = @Email";
            SqlParameter[] parameters = {
                new SqlParameter("@PasswordHash", hashedPassword),
                new SqlParameter("@Email", Session["UserEmail"].ToString())
            };

            bool isUpdated = DatabaseHelper.ExecuteNonQuery(query, parameters);

            if (isUpdated)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowToast", "showToast('Password updated successfully!', 'success');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowToast", "showToast('Error updating password. Try again.', 'error');", true);
            }
        }

        private static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private bool CheckDuplicate(string columnName, string value, string currentPatientID)
        {
            string query = $"SELECT COUNT(*) FROM Patients WHERE {columnName} = @Value AND PatientID != @PatientID";
            SqlParameter[] parameters = {
                new SqlParameter("@Value", value),
                new SqlParameter("@PatientID", currentPatientID)
            };

            object result = DatabaseHelper.ExecuteScalar(query, parameters);
            return Convert.ToInt32(result) > 0;
        }

    }
}