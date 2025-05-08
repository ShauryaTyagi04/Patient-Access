using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.dashboard
{
    public partial class dashboardHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUpcomingAppointment();
                LoadUnreadMessages();
            }
        }

        private void LoadUnreadMessages()
        {
            int patientId = Convert.ToInt32(Session["PatientID"]);
            int clinicId = Convert.ToInt32(Session["ClinicID"]);

            string query = @"
                SELECT TOP 5 
                    LEFT(MessageText, 50) + 
                    CASE WHEN LEN(MessageText) > 100 THEN '...' ELSE '' END AS MessageText,
                    FORMAT(SentAt, 'dd MMM yyyy hh:mm tt') AS SentAt
                FROM Messages
                WHERE PatientID = @PatientID
                  AND ClinicID = @ClinicID
                  AND SenderRole = 'Clinic'
                  AND IsRead = 0
                ORDER BY SentAt DESC";

            SqlParameter[] parameters = {
        new SqlParameter("@PatientID", patientId),
        new SqlParameter("@ClinicID", clinicId)
    };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                rptUnreadMessages.DataSource = dt;
                rptUnreadMessages.DataBind();
            }
            else
            {
                litNoMessages.Text = "<p class='text-muted text-center'>No new messages.</p>";
            }
        }



        private void LoadUpcomingAppointment()
        {
            if (Session["PatientID"] == null)
            {
                return;
            }
            int patientId = Convert.ToInt32(Session["PatientID"]);

            string query = @"
                SELECT TOP 1 
                    ba.AppointmentDate,
                    ba.AppointmentTime,
                    ('Dr. ' + d.FirstName + ' ' + d.LastName) AS DoctorName
                FROM BookedAppointments ba
                INNER JOIN Doctors d ON ba.DoctorID = d.DoctorID
                WHERE ba.PatientID = @PatientID
                  AND ba.AppointmentDate >= CAST(GETDATE() AS DATE)
                ORDER BY ba.AppointmentDate ASC, ba.AppointmentTime ASC";

            SqlParameter[] parameters = { new SqlParameter("@PatientID", patientId) };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                DateTime appointmentDate = Convert.ToDateTime(row["AppointmentDate"]);
                TimeSpan appointmentTime = (TimeSpan)row["AppointmentTime"];
                string doctorName = row["DoctorName"].ToString();

                litAppointmentDate.Text = appointmentDate.ToString("dd MMM yyyy");

                DateTime startDateTime = appointmentDate.Add(appointmentTime);
                DateTime endDateTime = startDateTime.AddHours(1);
                litAppointmentTime.Text = startDateTime.ToString("HH:mm") + " - " + endDateTime.ToString("HH:mm");

                litDoctorName.Text = doctorName;
            }
            else
            {
                litAppointmentDate.Text = "No upcoming appointments.";
                litAppointmentTime.Text = "";
                litDoctorName.Text = "";
            }
        }
    }
}