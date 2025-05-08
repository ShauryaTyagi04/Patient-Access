using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;

namespace PatientAccess.pages.dashboard
{
    public partial class messages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMessages();
                MarkMessagesAsRead();
                LoadClinicName();
            }
        }

        private void LoadClinicName()
        {
            string query = "SELECT ClinicName FROM Clinics WHERE ClinicID = @ClinicID";
            SqlParameter[] parameters = { new SqlParameter("@ClinicID", Session["ClinicID"]) };
            object result = DatabaseHelper.ExecuteScalar(query, parameters);

            if (result != null)
            {
                ClinicNameLabel.Text = result.ToString();
            }
        }


        //Initial messages
        [WebMethod]
        public static string GetMessages()
        {
            int patientId = Convert.ToInt32(HttpContext.Current.Session["PatientID"]);
            int clinicId = Convert.ToInt32(HttpContext.Current.Session["ClinicID"]);

            string query = @"SELECT SenderRole, MessageText, SentAt 
                     FROM Messages 
                     WHERE PatientID = @PatientID AND ClinicID = @ClinicID 
                     ORDER BY SentAt ASC";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId),
                new SqlParameter("@ClinicID", clinicId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            var messages = new List<object>();

            foreach (DataRow row in dt.Rows)
            {
                messages.Add(new
                {
                    sender = row["SenderRole"].ToString(),
                    message = row["MessageText"].ToString(),
                    sentTime = Convert.ToDateTime(row["SentAt"]).ToString("g")
                });
            }

            return new JavaScriptSerializer().Serialize(messages);
        }

        //Experimental, No UI update
        private void MarkMessagesAsRead()
        {
            int patientId = Convert.ToInt32(Session["PatientID"]);
            int clinicId = Convert.ToInt32(Session["ClinicID"]);

            string query = @"UPDATE Messages 
                     SET IsRead = 1 
                     WHERE PatientID = @PatientID AND ClinicID = @ClinicID AND SenderRole = 'Clinic' AND IsRead = 0";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId),
                new SqlParameter("@ClinicID", clinicId)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }

        //Initial Load
        private void LoadMessages()
        {
            int patientId = Convert.ToInt32(Session["PatientID"]);
            int clinicId = Convert.ToInt32(Session["ClinicID"]);

            string query = @"SELECT SenderRole, MessageText, SentAt 
                             FROM Messages 
                             WHERE PatientID = @PatientID AND ClinicID = @ClinicID 
                             ORDER BY SentAt ASC";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId),
                new SqlParameter("@ClinicID", clinicId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            StringBuilder sb = new StringBuilder();

            foreach (DataRow row in dt.Rows)
            {
                string sender = row["SenderRole"].ToString();
                string message = row["MessageText"].ToString();
                string sentTime = Convert.ToDateTime(row["SentAt"]).ToString("g");

                string cssClass = sender == "Patient" ? "chat-patient" : "chat-clinic";
                sb.Append($"<div class='chat-message {cssClass}'>" +
                          $"<div>{message}</div><div class='timestamp'>{sentTime}</div></div>");
            }

            messageContainer.InnerHtml = sb.ToString();

            // Scroll to bottom after messages are loaded, Experimenal.
            ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollToBottom", @"
                window.onload = function() {
                    var container = document.getElementById('" + messageContainer.ClientID + @"');
                    if (container) {
                        container.scrollTop = container.scrollHeight;
                    }
                };", true);

        }

        //Send Message
        protected void SendBtn_Click(object sender, EventArgs e)
        {
            int patientId = Convert.ToInt32(Session["PatientID"]);
            int clinicId = Convert.ToInt32(Session["ClinicID"]);
            string messageText = messageInput.Text.Trim();

            if (!string.IsNullOrEmpty(messageText))
            {
                string query = @"INSERT INTO Messages (PatientID, ClinicID, SenderRole, MessageText, SentAt) 
                                 VALUES (@PatientID, @ClinicID, 'Patient', @MessageText, @SentAt)";

                SqlParameter[] parameters = {
                    new SqlParameter("@PatientID", patientId),
                    new SqlParameter("@ClinicID", clinicId),
                    new SqlParameter("@MessageText", messageText),
                    new SqlParameter("@SentAt", DateTime.Now)
                };

                DatabaseHelper.ExecuteNonQuery(query, parameters);

                //To prevent duplicate submissions on refresh
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}