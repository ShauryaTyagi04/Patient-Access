using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class DatabaseHelper
{
    private static readonly string connString = ConfigurationManager.ConnectionStrings["PatientAccess"].ConnectionString;

    public static SqlConnection GetConnection()
    {
        return new SqlConnection(connString);
    }

    /// Method to execute a query and return a DataTable
    public static DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = GetConnection())
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }
    }

    /// Method to execute a non-query command (INSERT, UPDATE, DELETE) Returns a boolean value
    public static bool ExecuteNonQuery(string query, SqlParameter[] parameters)
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddRange(parameters);
                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
        }
    }

    /// Method to execute a scalar command (e.g., COUNT, MAX) Returns a single value
    public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = GetConnection())
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                conn.Open();
                return cmd.ExecuteScalar();
            }
        }
    }

}
