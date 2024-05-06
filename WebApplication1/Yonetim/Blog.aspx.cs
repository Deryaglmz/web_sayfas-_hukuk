using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using WebApplication1.DataAccess;

namespace WebApplication1.Yonetim
{
    public partial class Blog : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        [WebMethod]
        public static string GetPosts()
        {
            var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
            var dataTable = repository.ReadPosts();
            var list = new List<Dictionary<string, object>>();

            foreach (DataRow row in dataTable.Rows)
            {
                var dict = new Dictionary<string, object>();
                foreach (DataColumn col in dataTable.Columns)
                {
                    if (col.DataType == typeof(DateTime))
                    {
                        dict[col.ColumnName] = ((DateTime)row[col]).ToString("MM/dd/yyyy");
                    }
                    else if (col.ColumnName == "status" && row[col] != DBNull.Value)
                    {
                        dict[col.ColumnName] = ((PostStatus)(int)row[col]).ToString();
                    }
                    else
                    {
                        dict[col.ColumnName] = row[col];
                    }
                }
                list.Add(dict);
            }

            var serializer = new JavaScriptSerializer();
            return serializer.Serialize(list);
        }
        
        [WebMethod]
        public static string GetPostById(int postId)
        {
            var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
            var post = repository.GetPostById(postId);
            var serializer = new JavaScriptSerializer();
            return serializer.Serialize(post);
        }

        
        [WebMethod]
        public static bool CreatePost(string title, string publishedDate, string imagePath, string content, int status)
        {
            try
            {
                var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
                DateTime? date = null;
                if (DateTime.TryParse(publishedDate, out DateTime parsedDate))
                {
                    date = parsedDate;
                }

                repository.CreatePost(title, imagePath, content, (PostStatus)status, date);
                return true;
            }
            catch
            {
                return false;
            }
        }
        
        [WebMethod]
        public static bool UpdatePost(int postId, string title, string publishedDate, string imagePath, string content, int status)
        {
            try
            {
                var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
                DateTime? date = null;
                if (DateTime.TryParse(publishedDate, out DateTime parsedDate))
                {
                    date = parsedDate;
                }

                repository.UpdatePost(postId, title, imagePath, content, (PostStatus)status, date);
                return true;
            }
            catch
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeletePost(int postId)
        {
            try
            {
                var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
                repository.DeletePost(postId);
                return true;
            }
            catch
            {
                return false;
            }
        }

    }
}