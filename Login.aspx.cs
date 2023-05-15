using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.ServiceModel.Channels;
using MySql.Data;
using MySql.Data.MySqlClient;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
        MySqlConnection con = new MySqlConnection(connectionString);
        MySqlCommand cmd = new MySqlCommand("select appuserid, apppassword, approle from user_credentials where appuserid=@username and apppassword=@password", con);
        cmd.Parameters.AddWithValue("@username", txtUserName.Text);
        cmd.Parameters.AddWithValue("@password", txtPwd.Text);
        MySqlDataAdapter sda = new MySqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        con.Open();
        int i = cmd.ExecuteNonQuery();
        con.Close();

        if (dt.Rows.Count > 0)
        {
          
            //Messagebox("Hello Login");
            string url = "ServerAdministration.aspx";
            
            //string s = "window.location.assign('" + url + "', 'popup_window', 'width=1200,height=1000,left=10,top=10,resizable=no');";
            string s = "self.close();window.open('" + url + "', 'popup_window', 'width=800,height=600,left=100,top=100,resizable=no');";

            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
            Label1.Text = "";
            //ClientScript.RegisterStartupScript(typeof(Page), "closePage", "window.close();", true);

        }
        else
        {
            //Messagebox(" Login failed ");
             Label1.Text = "Your username and password is incorrect";
             Label1.ForeColor = System.Drawing.Color.Red;

        }

    }

    
}