using System;
using System.Data;
using System.Data.SqlClient;

namespace PatientAccess.pages.dashboard
{
    public partial class manualAppointments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                appointmentDate.Text = DateTime.Today.AddDays(21).ToString("yyyy-MM-dd");

                LoadDoctors();
                LoadTimeSlots();
            }
        }
        private void LoadDoctors()
        {
            if (Session["ClinicID"] == null)
                return;

            int clinicId = Convert.ToInt32(Session["ClinicID"]);

            string query = @"
                SELECT DoctorID, (FirstName + ' ' + LastName) AS DoctorName
                FROM Doctors
                WHERE ClinicID = @ClinicID
                ORDER BY FirstName, LastName";

            SqlParameter[] parameters = {
                new SqlParameter("@ClinicID", clinicId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            doctorList.DataSource = dt;
            doctorList.DataTextField = "DoctorName";
            doctorList.DataValueField = "DoctorID";
            doctorList.DataBind();

            if (doctorList.Items.Count > 0)
            {
                doctorList.SelectedIndex = 0;
            }
        }

        private void LoadTimeSlots()
        {
            DateTime selectedDate;
            if (!DateTime.TryParse(appointmentDate.Text, out selectedDate))
            {
                selectedDate = DateTime.Today;
            }

            int doctorId = 0;
            if (doctorList.SelectedValue != null && int.TryParse(doctorList.SelectedValue, out doctorId))
            {
                string query = @"
                    SELECT BookingTime, 
                           CONVERT(varchar(8), BookingTime, 108) + ' - ' + CONVERT(varchar(8), DATEADD(HOUR, 1, BookingTime), 108) AS DisplayTime
                    FROM AvailableBookings 
                    WHERE DoctorID = @DoctorID 
                      AND BookingDate = @BookingDate
                    ORDER BY BookingTime";


                SqlParameter[] parameters = {
                    new SqlParameter("@DoctorID", doctorId),
                    new SqlParameter("@BookingDate", selectedDate)
                };

                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

                appointmentTime.DataSource = dt;
                appointmentTime.DataTextField = "DisplayTime";
                appointmentTime.DataValueField = "BookingTime";
                appointmentTime.DataBind();

                if (dt.Rows.Count == 0)
                {
                    appointmentTime.Items.Clear();
                    appointmentTime.Items.Add(new System.Web.UI.WebControls.ListItem("No slots available", ""));
                }
            }
            else
            {
                appointmentTime.Items.Clear();
            }
        }

        protected void doctorList_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTimeSlots();
        }

        protected void appointmentDate_TextChanged(object sender, EventArgs e)
        {
            LoadTimeSlots();
        }

        protected void BookManualAppointment(object sender, EventArgs e)
        {
            if (Session["PatientID"] == null || Session["ClinicID"] == null)
            {
                return;
            }

            DateTime appointmentDateValue;
            if (!DateTime.TryParse(appointmentDate.Text, out appointmentDateValue))
            {
                return;
            }

            TimeSpan appointmentTimeValue;
            if (!TimeSpan.TryParse(appointmentTime.SelectedValue, out appointmentTimeValue))
            {
                return;
            }

            int doctorId = Convert.ToInt32(doctorList.SelectedValue);
            int clinicId = Convert.ToInt32(Session["ClinicID"]);
            int patientId = Convert.ToInt32(Session["PatientID"]);

            string query = @"
                INSERT INTO BookedAppointments (AppointmentDate, AppointmentTime, DoctorID, ClinicID, PatientID)
                VALUES (@AppointmentDate, @AppointmentTime, @DoctorID, @ClinicID, @PatientID)";
            SqlParameter[] parameters = {
                new SqlParameter("@AppointmentDate", appointmentDateValue),
                new SqlParameter("@AppointmentTime", appointmentTimeValue),
                new SqlParameter("@DoctorID", doctorId),
                new SqlParameter("@ClinicID", clinicId),
                new SqlParameter("@PatientID", patientId)
            };

            bool inserted = DatabaseHelper.ExecuteNonQuery(query, parameters);
            if (inserted)
            {
                string successAppointment = ResolveClientUrl(Page.GetRouteUrl("AppointmentSuccess", null));
                Response.Redirect(successAppointment);
            }
        }
    }
}