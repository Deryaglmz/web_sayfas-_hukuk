using System;
using System.Configuration;
using System.Web.UI;
using WebApplication1.DataAccess;

namespace WebApplication1.Yonetim
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("../Giris.aspx");
            }

            LoadCounts();
        }
        
        private void LoadCounts()
        {
            var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
            int blogPostCount = repository.GetBlogPostCount();
            int messageCount = repository.GetMessageCount();

            lblBlogPostCount.InnerText = blogPostCount.ToString();
            lblMessageCount.InnerText = messageCount.ToString();
        }
    }
}