using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

//Used to get live updates using ajax

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class MessageService : System.Web.Services.WebService
{
    [WebMethod(EnableSession = true)]
    public static string GetMessages()
    {
        int patientId = Convert.ToInt32(HttpContext.Current.Session["PatientID"]);
        int clinicId = Convert.ToInt32(HttpContext.Current.Session["ClinicID"]);

        //Sorting messages
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
}
