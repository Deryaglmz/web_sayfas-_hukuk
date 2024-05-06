using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using WebApplication1.DataAccess;

namespace WebApplication1.Yonetim
{
    public partial class Messages : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        
        [WebMethod]
        public static string GetMessages()
        {
            var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
            var dataTable = repository.ReadMessages();
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
        public static string GetMessageById(int messageId)
        {
            var repository = new DataAccessRepository(ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString);
            var message = repository.GetMessageById(messageId);
            var serializer = new JavaScriptSerializer();
            return serializer.Serialize(message);
        }
    }
}