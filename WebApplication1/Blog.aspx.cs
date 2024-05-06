using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using WebApplication1.DataAccess;

namespace WebApplication1
{
    public partial class Blog : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBlogPosts();
            }
        }
        
        private void BindBlogPosts()
        {
            var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
            DataTable blogPosts = repository.ReadPosts();

            foreach (DataRow row in blogPosts.Rows)
            {
                row["content"] = CleanContent(HttpUtility.HtmlDecode(row["content"].ToString()));
            }

            rptBlogPosts.DataSource = blogPosts;
            rptBlogPosts.DataBind();
        }
        
        private string CleanContent(string content)
        {
            // Trim double quotes from start and end
            return content.Trim('"');
        }

    }
}