using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

namespace PatientAccess.services
{
    public partial class NotificationService : System.Web.UI.Page
    {
        [WebMethod(EnableSession = true)]
        public static string GetUnreadMessageCount()
        {
            int patientId = Convert.ToInt32(HttpContext.Current.Session["PatientID"]);
            int clinicId = Convert.ToInt32(HttpContext.Current.Session["ClinicID"]);

            string query = @"SELECT COUNT(*) 
                             FROM Messages 
                             WHERE PatientID = @PatientID AND ClinicID = @ClinicID 
                               AND SenderRole = 'Clinic' AND IsRead = 0";

            SqlParameter[] parameters = {
                new SqlParameter("@PatientID", patientId),
                new SqlParameter("@ClinicID", clinicId)
            };

            object count = DatabaseHelper.ExecuteScalar(query, parameters);
            return count.ToString();
        }
    }
}
