<%@ WebHandler Language="C#" Class="WebApplication1.Yonetim.Handlers.FileUploadHandler" %>

using System;
using System.IO;
using System.Web;

namespace WebApplication1.Yonetim.Handlers
{
    public class FileUploadHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                foreach (string key in files)
                {
                    HttpPostedFile file = files[key];
                    string filename = Path.GetFileName(file.FileName);
                    string filePath = "/Uploads/" + filename;
                    string serverPath = context.Server.MapPath(filePath);
                    try
                    {
                        file.SaveAs(serverPath);
                        context.Response.Write(filePath);
                    }
                    catch (Exception ex)
                    {
                        context.Response.Write("Error: " + ex.Message);
                    }
                }
            }
            else
            {
                context.Response.Write("No files uploaded.");
            }
        }


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
