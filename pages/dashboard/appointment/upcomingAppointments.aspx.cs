using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.dashboard
{
    public partial class upcomingAppointments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAppointments();
            }
        }

        private void LoadAppointments()
        {
            if (Session["PatientID"] == null)
            {
                return;
            }
            int patientId = Convert.ToInt32(Session["PatientID"]);

            string query = @"
                SELECT 
                    ba.AppointmentID,
                    CONVERT(varchar(11), ba.AppointmentDate, 106) AS [Date],
                    CONVERT(varchar(8), ba.AppointmentTime, 108) AS [StartTime],
                    CONVERT(varchar(8), DATEADD(HOUR, 1, ba.AppointmentTime), 108) AS [EndTime],
                    ('Dr. ' + d.FirstName + ' ' + d.LastName) AS [Doctor]
                FROM BookedAppointments ba
                INNER JOIN Doctors d ON ba.DoctorID = d.DoctorID
                WHERE ba.PatientID = @PatientID
                ORDER BY ba.AppointmentDate, ba.AppointmentTime";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptAppointments.DataSource = dt;
            rptAppointments.DataBind();
        }

        protected void manualAppointmentBtn_Click(object sender, EventArgs e)
        {
            string manualAppUrl = ResolveClientUrl(Page.GetRouteUrl("ManualAppointments", null));
            Response.Redirect(manualAppUrl);
        }
        protected void availableAppointmentBtn_Click(object sender, EventArgs e)
        {
            string availableAppUrl = ResolveClientUrl(Page.GetRouteUrl("Appointments", null));
            Response.Redirect(availableAppUrl);
        }

        protected void ConfirmCancel(object sender, EventArgs e)
        {
            int appointmentId = Convert.ToInt32(hfAppointmentID.Value);

            string selectQuery = @"
                SELECT AppointmentDate, AppointmentTime, DoctorID, ClinicID 
                FROM BookedAppointments 
                WHERE AppointmentID = @AppointmentID";
            SqlParameter[] selectParams = { new SqlParameter("@AppointmentID", appointmentId) };
            DataTable dt = DatabaseHelper.ExecuteQuery(selectQuery, selectParams);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                DateTime appointmentDate = Convert.ToDateTime(row["AppointmentDate"]);
                TimeSpan appointmentTime = (TimeSpan)row["AppointmentTime"];
                int doctorId = Convert.ToInt32(row["DoctorID"]);
                int clinicId = Convert.ToInt32(row["ClinicID"]);

                string insertQuery = @"
                    INSERT INTO AvailableBookings (BookingDate, BookingTime, DoctorID, ClinicID)
                    VALUES (@BookingDate, @BookingTime, @DoctorID, @ClinicID)";
                SqlParameter[] insertParams = {
                    new SqlParameter("@BookingDate", appointmentDate),
                    new SqlParameter("@BookingTime", appointmentTime),
                    new SqlParameter("@DoctorID", doctorId),
                    new SqlParameter("@ClinicID", clinicId)
                };

                bool inserted = DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);

                if (inserted)
                {
                    LoadAppointments();
                    string upcomingAppUrl = ResolveClientUrl(Page.GetRouteUrl("UpcomingAppointments", null));
                    Response.Redirect(upcomingAppUrl);
                }
            }
        }
    }
}