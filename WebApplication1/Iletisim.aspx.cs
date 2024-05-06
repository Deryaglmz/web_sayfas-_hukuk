using System;
using System.ComponentModel;
using System.Configuration;
using System.Net.Mail;
using System.Web.UI;
using WebApplication1.DataAccess;

namespace WebApplication1
{
    public partial class Iletisim : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        
        protected void Submit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string email = txtEmail.Text;
            string subject = txtSubject.Text;
            string message = txtMessage.Text;
    
            string username = ConfigurationManager.AppSettings["MailgunUsername"];
            string password = ConfigurationManager.AppSettings["MailgunPassword"];
            
            // save to db
            try
            {
                var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
                repository.SaveContactMessage(name, email, subject, message);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            //send contact message to email
            try
            {
                MailMessage mailMessage = new MailMessage(email, "biruniprojectdemo@gmail.com")
                {
                    Subject = subject,
                    Body = $"From: {name}\nEmail: {email}\nMessage: {message}",
                    IsBodyHtml = false
                };
            
                using (SmtpClient smtpClient = new SmtpClient("smtp.mailgun.org"))
                {
                    smtpClient.Port = 587;
                    smtpClient.Credentials = new System.Net.NetworkCredential(username, password);
                    smtpClient.EnableSsl = true;
                    smtpClient.Send(mailMessage);
                }
            
                lblStatus.Text = "Message sent successfully!";
                lblStatus.CssClass = "status-message alert alert-success";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Failed to send message. Error: " + ex.Message;
                lblStatus.CssClass = "status-message alert alert-danger";
            }
            lblStatus.Visible = true;
        }
    }
}