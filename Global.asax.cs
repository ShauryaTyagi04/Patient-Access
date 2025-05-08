using System;
using System.Web.Routing;

namespace PatientAccess
{
    public class Global : System.Web.HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(
                routeName: "Home",
                routeUrl: "home",
                physicalFile: "~/pages/home/home.aspx"
            );

            routes.MapPageRoute(
                routeName: "Register",
                routeUrl: "register",
                physicalFile: "~/pages/home/register.aspx"
            );

            routes.MapPageRoute(
                routeName: "Login",
                routeUrl: "login",
                physicalFile: "~/pages/home/signIn.aspx"
            );

            routes.MapPageRoute(
                routeName: "SuccessfullRegistration",
                routeUrl: "register/success",
                physicalFile: "~/pages/home/successfullRegistration.aspx"
            );

            routes.MapPageRoute(
                routeName: "Appointments",
                routeUrl: "dashboard/appointments",
                physicalFile: "~/pages/dashboard/appointment/appointments.aspx"
            );

            routes.MapPageRoute(
                routeName: "AppointmentSuccess",
                routeUrl: "dashboard/appointments/success",
                physicalFile: "~/pages/dashboard/appointment/appointmentSuccess.aspx"
            );

            routes.MapPageRoute(
                routeName: "ManualAppointments",
                routeUrl: "dashboard/appointments/manual",
                physicalFile: "~/pages/dashboard/appointment/manualAppointments.aspx"
            );

            routes.MapPageRoute(
                routeName: "UpcomingAppointments",
                routeUrl: "dashboard/appointments/upcoming",
                physicalFile: "~/pages/dashboard/appointment/upcomingAppointments.aspx"
            );

            routes.MapPageRoute(
                routeName: "Profile",
                routeUrl: "dashboard/profile",
                physicalFile: "~/pages/dashboard/profile.aspx"
            );

            routes.MapPageRoute(
                routeName: "Doctors",
                routeUrl: "dashboard/doctors",
                physicalFile: "~/pages/dashboard/doctors.aspx"
            );

            routes.MapPageRoute(
                routeName: "Allergies",
                routeUrl: "dashboard/healthInfo/allergies",
                physicalFile: "~/pages/healthInformation/allergies.aspx"
            );

            routes.MapPageRoute(
                routeName: "ChronicConditions",
                routeUrl: "dashboard/healthInfo/chronicConditions",
                physicalFile: "~/pages/healthInformation/chronicConditions.aspx"
            );

            routes.MapPageRoute(
                routeName: "ImmunizationHistory",
                routeUrl: "dashboard/healthInfo/immunizationHistory",
                physicalFile: "~/pages/healthInformation/immunizationHistory.aspx"
            );

            routes.MapPageRoute(
                routeName: "PatientInformation",
                routeUrl: "dashboard/healthInfo/patientInformation",
                physicalFile: "~/pages/healthInformation/patientInformation.aspx"
            );

            routes.MapPageRoute(
                routeName: "PatientFamilyHistory",
                routeUrl: "dashboard/healthInfo/patientFamilyHistory",
                physicalFile: "~/pages/healthInformation/patientFamilyHistory.aspx"
            );

            routes.MapPageRoute(
                routeName: "DashboardHome",
                routeUrl: "dashboard",
                physicalFile: "~/pages/dashboard/dashboardHome.aspx"
            );

            routes.MapPageRoute(
                routeName: "Messages",
                routeUrl: "messages",
                physicalFile: "~/pages/dashboard/messages.aspx"
            );

            routes.MapPageRoute(
                routeName: "AdminMessages",
                routeUrl: "adminMessages",
                physicalFile: "~/pages/admin/adminMessages.aspx"
            );

        }
    }
}
