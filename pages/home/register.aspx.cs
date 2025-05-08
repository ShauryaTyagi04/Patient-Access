using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.WebControls;

namespace PatientAccess.pages.home
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dobMonth.Items.Add(new ListItem("Month", ""));

                foreach (var monthName in System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.MonthNames)
                {
                    if (!string.IsNullOrEmpty(monthName))
                    {
                        dobMonth.Items.Add(new ListItem(monthName, (dobMonth.Items.Count).ToString()));
                    }
                }
            }
        }

        protected void registerBtn_Click(object sender, EventArgs e)
        {
            ResetErrorStates();


            if (!ValidateInputs())
            {
                return;
            }

            byte[] imageBytes = null;

            if (fileUpload.HasFile)
            {
                using (System.IO.BinaryReader br = new System.IO.BinaryReader(fileUpload.PostedFile.InputStream))
                {
                    imageBytes = br.ReadBytes(fileUpload.PostedFile.ContentLength);
                }
            }



            string hashedPassword = HashPassword(password.Value);

            string dob = $"{dobYear.Value}-{dobMonth.Value}-{dobDay.Value}";

            string query = @"INSERT INTO Patients (FirstName, LastName, Email, PhoneNumber, NHSNumber, DateOfBirth, 
                            PostCode, Gender, EmergencyContactNumber, PasswordHash, BloodType, ProfileImage) 
                            VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @NHSNumber, @DateOfBirth, 
                            @PostCode, @Gender, @EmergencyContactNumber, @PasswordHash, @BloodType, @ProfileImage)";

            SqlParameter[] parameters = {
                new SqlParameter("@FirstName", firstName.Value),
                new SqlParameter("@LastName", lastName.Value),
                new SqlParameter("@Email", email.Value),
                new SqlParameter("@PhoneNumber", phoneNumber.Value),
                new SqlParameter("@NHSNumber", nhsNumber.Value),
                new SqlParameter("@DateOfBirth", dob),
                new SqlParameter("@PostCode", postcode.Value),
                new SqlParameter("@Gender", gender.Value),
                new SqlParameter("@EmergencyContactNumber", emergencyContact.Value),
                new SqlParameter("@PasswordHash", hashedPassword),
                new SqlParameter("@BloodType", DBNull.Value),
            new SqlParameter("@ProfileImage", (object)imageBytes ?? DBNull.Value)
            };

            bool isInserted = DatabaseHelper.ExecuteNonQuery(query, parameters);

            if (isInserted)
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowRegisterModal", "$(document).ready(function() { showRegisterModal(); });", true);
                string successRegUrl = ResolveClientUrl(Page.GetRouteUrl("SuccessfullRegistration", null));
                Response.Redirect(successRegUrl);
            }
            else
            {

            }
        }

        private bool ValidateInputs()
        {
            bool isValid = true;

            string day = dobDay.Value;
            string month = dobMonth.Value;
            string year = dobYear.Value;

            string emailInput = email.Value;
            string phoneInput = phoneNumber.Value;
            string nhsInput = nhsNumber.Value;

            lblMessage.InnerHtml = "";

            List<string> errorMessages = new List<string>();

            if (!fileUpload.HasFile)
            {
                fileUpload.CssClass += " input-error my-3";
                isValid = false;
            }

            if (IsDuplicateEntry("Email", email.Value))
            {
                email.Attributes["class"] += " input-error";
                errorMessages.Add("This email is already registered.");
                isValid = false;
            }

            if (IsDuplicateEntry("PhoneNumber", phoneNumber.Value))
            {
                phoneNumber.Attributes["class"] += " input-error";
                errorMessages.Add("This phone number is already registered.");
                isValid = false;
            }

            if (IsDuplicateEntry("NHSNumber", nhsNumber.Value))
            {
                nhsNumber.Attributes["class"] += " input-error";
                errorMessages.Add("This NHS number is already registered.");
                isValid = false;
            }


            if (!ValidateDateOfBirth(day, month, year))
            {
                dobDay.Attributes.Add("class", "form-input input-error");
                dobMonth.Attributes.Add("class", "form-select input-error");
                dobYear.Attributes.Add("class", "form-input input-error");
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(firstName.Value))
            {
                firstName.Attributes.Add("class", "form-input input-error mb-3");
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(nhsNumber.Value))
            {
                nhsNumber.Attributes.Add("class", "form-input input-error mb-3");
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(postcode.Value))
            {
                postcode.Attributes.Add("class", "form-input input-error mb-3");
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(email.Value))
            {
                email.Attributes.Add("class", "form-input input-error mb-3");
                isValid = false;
            }

            string pwd = password.Value;
            string confirmPwd = cPassword.Value;

            if (string.IsNullOrWhiteSpace(pwd) || string.IsNullOrWhiteSpace(confirmPwd))
            {
                password.Attributes["class"] += " input-error mb-3";
                cPassword.Attributes["class"] += " input-error mb-3";
                isValid = false;
            }
            else
            {
                if (!pwd.Equals(confirmPwd))
                {
                    password.Attributes["class"] += " input-error mb-3";
                    cPassword.Attributes["class"] += " input-error mb-3";
                    errorMessages.Add("Passwords do not match.");
                    isValid = false;
                }
                else if (pwd.Length < 8 ||
                         !pwd.Any(char.IsUpper) ||
                         !pwd.Any(char.IsLower) ||
                         !pwd.Any(char.IsDigit) ||
                         !pwd.Any(ch => "!@#$%^&*()_+-=[]{}|;':\",.<>?/".Contains(ch)))
                {
                    password.Attributes["class"] += " input-error mb-3";
                    cPassword.Attributes["class"] += " input-error mb-3";
                    errorMessages.Add("Password must be at least 8 characters, include uppercase, lowercase, number, and special character.");
                    isValid = false;
                }
            }


            string phone = phoneNumber.Value;
            if (string.IsNullOrWhiteSpace(phone) || phone.Length < 10 || phone.Length > 11 || !phone.All(char.IsDigit))
            {
                phoneNumber.Attributes.Add("class", "form-input input-error mb-3");
                isValid = false;
            }
            string ePhone = emergencyContact.Value;
            if (string.IsNullOrWhiteSpace(ePhone) || ePhone.Length < 10 || ePhone.Length > 11 || !ePhone.All(char.IsDigit))
            {
                emergencyContact.Attributes.Add("class", "form-input input-error mb-3");
                isValid = false;
            }
            if (phone.Equals(ePhone))
            {
                phoneNumber.Attributes.Add("class", "form-input input-error mb-3");
                emergencyContact.Attributes.Add("class", "form-input input-error mb-3");
                isValid = false;
            }

            if (!int.TryParse(dobYear.Value, out int yearInt) || yearInt > DateTime.Now.Year)
            {
                dobYear.Attributes.Add("class", "form-input input-error mb-3");
                isValid = false;
            }

            if (string.IsNullOrEmpty(gender.Value))
            {
                gender.Attributes.Add("class", "form-select input-error mt-3");
                isValid = false;
            }

            if (errorMessages.Count > 0)
            {
                lblMessage.InnerHtml = string.Join("<br/>", errorMessages);
            }

            return isValid;
        }

        private bool ValidateDateOfBirth(string day, string month, string year)
        {
            if (string.IsNullOrWhiteSpace(day) || string.IsNullOrWhiteSpace(month) || string.IsNullOrWhiteSpace(year))
            {
                return false;
            }

            string dateStr = $"{day}/{month}/{year}";

            if (DateTime.TryParseExact(dateStr, "d/M/yyyy",
                System.Globalization.CultureInfo.InvariantCulture,
                System.Globalization.DateTimeStyles.None,
                out DateTime parsedDate))
            {
                return parsedDate <= DateTime.Now;
            }

            return false;
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

        private void ResetErrorStates()
        {
            void RemoveErrorClass(System.Web.UI.HtmlControls.HtmlControl control)
            {
                string classes = control.Attributes["class"];
                if (!string.IsNullOrEmpty(classes))
                {
                    control.Attributes["class"] = string.Join(" ", classes.Split(' ').Where(c => c != "input-error"));
                }
            }

            RemoveErrorClass(dobDay);
            RemoveErrorClass(dobMonth);
            RemoveErrorClass(dobYear);
            RemoveErrorClass(firstName);
            RemoveErrorClass(nhsNumber);
            RemoveErrorClass(postcode);
            RemoveErrorClass(email);
            RemoveErrorClass(password);
            RemoveErrorClass(phoneNumber);
            RemoveErrorClass(cPassword);
            RemoveErrorClass(emergencyContact);
        }

        private bool IsDuplicateEntry(string columnName, string value)
        {
            string query = $"SELECT COUNT(*) FROM Patients WHERE {columnName} = @Value";

            SqlParameter[] parameters = {
                new SqlParameter("@Value", value)
            };

            object result = DatabaseHelper.ExecuteScalar(query, parameters);

            return (result != null && Convert.ToInt32(result) > 0);
        }

    }
}