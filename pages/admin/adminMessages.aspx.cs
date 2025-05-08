using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace PatientAccess.pages.admin
{
    public partial class adminMessages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPatientList();
            }
        }

        private void LoadPatientList()
        {
            int clinicId = Convert.ToInt32(Session["ClinicID"]);

            string query = @"SELECT DISTINCT p.PatientID, p.FirstName + ' ' + p.LastName AS FullName
                             FROM Messages m
                             INNER JOIN Patients p ON m.PatientID = p.PatientID
                             WHERE m.ClinicID = @ClinicID";

            SqlParameter[] parameters = {
                new SqlParameter("@ClinicID", clinicId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            ddlPatients.Items.Clear();
            ddlPatients.Items.Add("-- Select Patient --");

            foreach (DataRow row in dt.Rows)
            {
                ddlPatients.Items.Add(new System.Web.UI.WebControls.ListItem(row["FullName"].ToString(), row["PatientID"].ToString()));
            }
        }

        private void LoadMessages(int patientId)
        {
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
                string cssClass = sender == "Clinic" ? "chat-clinic" : "chat-patient";

                sb.Append($"<div class='chat-message {cssClass}'>" +
                          $"<div>{message}</div><div class='timestamp'>{sentTime}</div></div>");
            }

            chatContainer.InnerHtml = sb.ToString();
        }

        protected void ddlPatients_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (int.TryParse(ddlPatients.SelectedValue, out int patientId))
            {
                Session["SelectedPatientID"] = patientId;
                LoadMessages(patientId);
            }
        }

        protected void sendReplyBtn_Click(object sender, EventArgs e)
        {
            int clinicId = Convert.ToInt32(Session["ClinicID"]);
            int patientId = Convert.ToInt32(Session["SelectedPatientID"]);
            string messageText = messageInput.Text.Trim();

            if (!string.IsNullOrEmpty(messageText))
            {
                string query = @"INSERT INTO Messages (PatientID, ClinicID, SenderRole, MessageText, SentAt)
                                 VALUES (@PatientID, @ClinicID, 'Clinic', @MessageText, GETDATE())";

                SqlParameter[] parameters = {
                    new SqlParameter("@PatientID", patientId),
                    new SqlParameter("@ClinicID", clinicId),
                    new SqlParameter("@MessageText", messageText)
                };

                DatabaseHelper.ExecuteNonQuery(query, parameters);
                messageInput.Text = "";
                LoadMessages(patientId);
            }
        }
    }
}