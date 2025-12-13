using System;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using FiveStars.Models;

namespace FiveStars
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        protected void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
            if (HttpContext.Current.User != null &&
                HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var email = HttpContext.Current.User.Identity.Name;

                using (var db = new CinemaDBEntities())
                {
                    var user = db.Users.FirstOrDefault(u => u.Email == email);
                    if (user != null)
                    {
                        var identity = new GenericIdentity(email);
                        var principal = new GenericPrincipal(
                            identity,
                            new[] { user.Role }
                        );

                        HttpContext.Current.User = principal;
                    }
                }
            }
        }
    }
}
