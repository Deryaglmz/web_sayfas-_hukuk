using System;
using System.Web.UI;

namespace WebApplication1.Yonetim
{
    public partial class Admin : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("../Giris.aspx");
            }
            
            SetActiveNavItem();
        }
        
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            
            Response.Redirect("~/Giris.aspx");
        }
        
        private void SetActiveNavItem()
        {
            string path = Request.AppRelativeCurrentExecutionFilePath;

            System.Console.WriteLine(path);
            navHome.Attributes["class"] = (path == "~/Yonetim/Default.aspx") ? "nav-item-active w-100" : "nav-item w-100";
            navBlog.Attributes["class"] = (path == "~/Blog.aspx") ? "nav-item-active w-100" : "nav-item w-100";
            navMessage.Attributes["class"] = (path == "~/Messages.aspx") ? "nav-item-active w-100" : "nav-item w-100";
        }
    }
}