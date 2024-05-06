using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;

namespace WebApplication1
{
    public class Global : HttpApplication
    {
        private void Application_Start(object sender, EventArgs e)
        {
            // Uygulama başlangıcında çalışan kod
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}