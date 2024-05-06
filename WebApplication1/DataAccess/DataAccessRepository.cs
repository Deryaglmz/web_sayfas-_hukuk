using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using MySql.Data.MySqlClient;
using System.Security.Cryptography;
using System.Text;

namespace WebApplication1.DataAccess
{
    
    public enum PostStatus
    {
        Unpublished = 0,
        Published = 1
    }

    public class DataAccessRepository
    {
        private readonly string _connectionString;

        public DataAccessRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public bool SaveContactMessage(string name, string email, string subject, string message)
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                var query = "INSERT INTO contact_messages (name, email, subject, message) VALUES (@name, @email, @subject, @message)";
                var cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@subject", subject);
                cmd.Parameters.AddWithValue("@message", message);

                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }
        
        public bool AuthenticateUser(string username, string password)
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                var query = "SELECT password_hash FROM users WHERE username=@username";
                var cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                
                conn.Open();
                var result = cmd.ExecuteScalar();
                var hash = Convert.ToString(result);
                if (string.IsNullOrEmpty(hash))
                    return false;

                return VerifyPasswordHash(password, hash);
            }
        }
        
        private bool VerifyPasswordHash(string password, string storedHash)
        {
            using (var sha256 = SHA256.Create())
            {
                var hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                var hashString = BitConverter.ToString(hashBytes).Replace("-", "").ToLowerInvariant();

                return hashString == storedHash;
            }
        }

        public DataTable ReadPosts()
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                string sql = "SELECT * FROM blog_posts";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return dataTable;
            }
        }
        
        public Dictionary<string, object> GetPostById(int postId)
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                string sql = "SELECT * FROM blog_posts WHERE id = @postId";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@postId", postId);

                DataTable dataTable = new DataTable();
                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                adapter.Fill(dataTable);

                if (dataTable.Rows.Count > 0)
                {
                    DataRow row = dataTable.Rows[0];
                    var result = new Dictionary<string, object>();
                    foreach (DataColumn column in dataTable.Columns)
                    {
                        result[column.ColumnName] = row[column];
                    }
                    return result;
                }
                return null;
            }
        }


        public void CreatePost(string title, string image, string content, PostStatus status, DateTime? publishedAt)
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                string sql = "INSERT INTO blog_posts (title, image, content, status, published_at) VALUES (@title, @image, @content, @status, @published_at)";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@image", image);
                cmd.Parameters.AddWithValue("@content", content);
                cmd.Parameters.AddWithValue("@status", (int)status);
                cmd.Parameters.AddWithValue("@published_at", publishedAt ?? (object)DBNull.Value);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        
        public void UpdatePost(int postId, string title = null, string image = null, string content = null, PostStatus? status = null, DateTime? publishedAt = null)
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                var sql = "UPDATE blog_posts SET";
                var parameters = new List<string>();

                if (!string.IsNullOrEmpty(title))
                    parameters.Add(" title = @title");
                if (!string.IsNullOrEmpty(image))
                    parameters.Add(" image = @image");
                if (!string.IsNullOrEmpty(content))
                    parameters.Add(" content = @content");
                if (status.HasValue)
                    parameters.Add(" status = @status");
                if (publishedAt.HasValue)
                    parameters.Add(" published_at = @publishedAt");

                sql += string.Join(",", parameters);
                sql += " WHERE id = @PostId";

                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@PostId", postId);
                if (!string.IsNullOrEmpty(title))
                    cmd.Parameters.AddWithValue("@title", title);
                if (!string.IsNullOrEmpty(image))
                    cmd.Parameters.AddWithValue("@image", image);
                if (!string.IsNullOrEmpty(content))
                    cmd.Parameters.AddWithValue("@content", content);
                if (status.HasValue)
                    cmd.Parameters.AddWithValue("@status", (int)status.Value);
                if (publishedAt.HasValue)
                    cmd.Parameters.AddWithValue("@publishedAt", publishedAt);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void DeletePost(int postId)
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                string sql = "DELETE FROM blog_posts WHERE id = @PostId";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@PostId", postId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        
        
        public DataTable ReadMessages()
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                string sql = "SELECT * FROM contact_messages";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return dataTable;
            }
        }
        
        public Dictionary<string, object> GetMessageById(int messageId)
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                string sql = "SELECT * FROM contact_messages WHERE id = @messageId";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@messageId", messageId);

                DataTable dataTable = new DataTable();
                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                adapter.Fill(dataTable);

                if (dataTable.Rows.Count > 0)
                {
                    DataRow row = dataTable.Rows[0];
                    var result = new Dictionary<string, object>();
                    foreach (DataColumn column in dataTable.Columns)
                    {
                        result[column.ColumnName] = row[column];
                    }
                    return result;
                }
                return null;
            }
        }
        
        public int GetBlogPostCount()
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                conn.Open();
                var cmd = new MySqlCommand("SELECT COUNT(*) FROM blog_posts", conn);
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public int GetMessageCount()
        {
            using (var conn = new MySqlConnection(_connectionString))
            {
                conn.Open();
                var cmd = new MySqlCommand("SELECT COUNT(*) FROM contact_messages", conn);
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

    }
}