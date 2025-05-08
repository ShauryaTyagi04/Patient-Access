using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace PatientAccess.pages.dashboard
{
    public partial class appointments : System.Web.UI.Page
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
            if (Session["ClinicID"] == null)
            {
                return;
            }

            int clinicId = Convert.ToInt32(Session["ClinicID"]);

            string query = @"
        SELECT 
            ab.AvailableBookingID,
            CONVERT(varchar(11), ab.BookingDate, 106) AS [Date], 
            CONVERT(varchar(8), ab.BookingTime, 108) AS [StartTime], 
            CONVERT(varchar(8), DATEADD(HOUR, 1, ab.BookingTime), 108) AS [EndTime],
            ('Dr. ' + d.FirstName + ' ' + d.LastName) AS [Doctor]
        FROM AvailableBookings ab
        INNER JOIN Doctors d ON ab.DoctorID = d.DoctorID
        WHERE ab.ClinicID = @ClinicID
        ORDER BY ab.BookingDate, ab.BookingTime";

            SqlParameter[] parameters = {
        new SqlParameter("@ClinicID", clinicId)
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
        protected void upcomingAppointmentBtn_Click(object sender, EventArgs e)
        {
            string upcomingAppUrl = ResolveClientUrl(Page.GetRouteUrl("UpcomingAppointments", null));
            Response.Redirect(upcomingAppUrl);
        }

        protected void BookAppointment(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int availableBookingId = Convert.ToInt32(btn.CommandArgument);

            string selectQuery = @"
        SELECT BookingDate, BookingTime, DoctorID, ClinicID 
        FROM AvailableBookings 
        WHERE AvailableBookingID = @AvailableBookingID";
            SqlParameter[] selectParams = { new SqlParameter("@AvailableBookingID", availableBookingId) };
            DataTable dt = DatabaseHelper.ExecuteQuery(selectQuery, selectParams);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                DateTime bookingDate = Convert.ToDateTime(row["BookingDate"]);
                TimeSpan bookingTime = (TimeSpan)row["BookingTime"];
                int doctorId = Convert.ToInt32(row["DoctorID"]);
                int clinicId = Convert.ToInt32(row["ClinicID"]);
                int patientId = Convert.ToInt32(Session["PatientID"]);

                string insertQuery = @"
            INSERT INTO BookedAppointments (AppointmentDate, AppointmentTime, DoctorID, ClinicID, PatientID)
            VALUES (@AppointmentDate, @AppointmentTime, @DoctorID, @ClinicID, @PatientID)";
                SqlParameter[] insertParams = {
            new SqlParameter("@AppointmentDate", bookingDate),
            new SqlParameter("@AppointmentTime", bookingTime),
            new SqlParameter("@DoctorID", doctorId),
            new SqlParameter("@ClinicID", clinicId),
            new SqlParameter("@PatientID", patientId)
        };

                bool inserted = DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);

                if (inserted)
                {
                    LoadAppointments();

                    string successAppUrl = ResolveClientUrl(Page.GetRouteUrl("AppointmentSuccess", null));
                    Response.Redirect(successAppUrl);
                }
            }
        }

    }
}