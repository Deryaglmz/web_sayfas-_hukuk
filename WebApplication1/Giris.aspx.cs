using System;
using System.Configuration;
using System.Web.UI;
using WebApplication1.DataAccess;

namespace WebApplication1
{
    public partial class Giris : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                // Kullanıcı oturum açtıysa yönetici paneline yönledir
                Response.Redirect("Yonetim");
            }
        }
        
        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string username = TxtUsername.Text;
            string password = TxtPassword.Text;

            if (AuthenticateUser(username, password))
            {
                Session["Username"] = username;
                Response.Redirect("Yonetim");
            }
            else
            {
                LblErrorMessage.Text = "Invalid username or password.";
                LblErrorMessage.Visible = true;
            }
        }

        private bool AuthenticateUser(string username, string password)
        {
            var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);

            return repository.AuthenticateUser(username, password);
        }
    }
}