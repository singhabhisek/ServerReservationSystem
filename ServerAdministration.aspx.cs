using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.IdentityModel.Protocols.WSTrust;
using System.Web.Services.Protocols;

public partial class DefaultAdmin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // string connstring = @"server=localhost;userid=root;password=12345;database=performance_center";
        //string connstring = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;

        //MySqlConnection conn = null;

        //    conn = new MySqlConnection(connstring);
        //    conn.Open();

        //    string query = "SELECT * FROM ServerInventory;";
        //    MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
        //    DataSet ds = new DataSet();
        //    da.Fill(ds, "table_name");
        //    DataTable dt = ds.Tables["table_name"];
        //GV1.DataSource= dt;
        //GV1.DataBind();


        if (!this.IsPostBack)
        {
            this.BindGrid();
        }


    }

    private void BindGrid()
    {
        string constr = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;

        string query = "SELECT * FROM ServerInventory";
        using (MySqlConnection con = new MySqlConnection(constr))
        {
            using (MySqlDataAdapter sda = new MySqlDataAdapter(query, con))
            {
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }
    }

    protected void Insert(object sender, EventArgs e)
    {
        int serverid = Convert.ToInt32(txtId.Text);
        string servername = txtServerName.Text;
        string servertype = txtServerType.Text;
        string status = txtStatus.Text;
        txtId.Text = "";
        txtServerName.Text = "";
        txtServerType.Text = "";
        txtStatus.Text = "";
        string query = "INSERT INTO ServerInventory VALUES(@Id, @ServerName, @ServerType, @Status)";
        string constr = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
        using (MySqlConnection con = new MySqlConnection(constr))
        {
            using (MySqlCommand cmd = new MySqlCommand(query))
            {
                cmd.Parameters.AddWithValue("@Id", serverid);
                cmd.Parameters.AddWithValue("@ServerName", servername);
                cmd.Parameters.AddWithValue("@ServerType", servertype);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindGrid();
    }

    protected void OnRowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditRowStyle.BackColor = System.Drawing.Color.LightYellow;

        GridView1.EditIndex = e.NewEditIndex;
        this.BindGrid();
    }

    protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = GridView1.Rows[e.RowIndex];
        int serverid = Convert.ToInt32((row.FindControl("txtId") as TextBox).Text);
        string servername = (row.FindControl("txtServerName") as TextBox).Text;
        string servertype = (row.FindControl("txtServerType") as TextBox).Text;
        string status = (row.FindControl("txtStatus") as TextBox).Text;
        string query = "UPDATE ServerInventory SET servername=@servername, servertype=@servertype, status=@status WHERE Id=@Id";
        string constr = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
        using (MySqlConnection con = new MySqlConnection(constr))
        {
            using (MySqlCommand cmd = new MySqlCommand(query))
            {
                cmd.Parameters.AddWithValue("@Id", serverid);
                cmd.Parameters.AddWithValue("@ServerName", servername);
                cmd.Parameters.AddWithValue("@ServerType", servertype);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        GridView1.EditIndex = -1;
        this.BindGrid();
    }

    protected void OnRowCancelingEdit(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
        this.BindGrid();
    }

    protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int Id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0].ToString());
        string query = "DELETE FROM ServerInventory WHERE id=@Id";
        string constr = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;
        using (MySqlConnection con = new MySqlConnection(constr))
        {
            using (MySqlCommand cmd = new MySqlCommand(query))
            {
                cmd.Parameters.AddWithValue("@Id", Id);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        this.BindGrid();
    }

    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridView1.EditIndex)
        {
          //  string item = e.Row.Cells[1].Text;
            string item = ((Label)e.Row.FindControl("lblServerName")).Text;
            foreach (LinkButton button in e.Row.Cells[4].Controls.OfType<LinkButton>())
            {
                if (button.CommandName == "Delete")
                {
                    
                    button.Attributes["onclick"] = "if(!confirm('Do you want to delete - " + item + "?')){ return false; };";
                }
            }
        }
    }

    protected void OnPaging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        this.BindGrid();
    }

}