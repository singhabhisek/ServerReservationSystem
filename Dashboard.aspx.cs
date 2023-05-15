using DayPilot.Web.Ui;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DayPilot.Web.Ui.Events;
using System.Activities.Expressions;
using static System.Net.Mime.MediaTypeNames;
using System.ServiceModel.Activities;
using System.Globalization;
using DayPilot.Utils;
using System.Reflection.Emit;
using MySql.Data.MySqlClient;
using System.Security.Cryptography;
using System.Web.DynamicData;

public partial class Dashboard : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {



        if (!IsPostBack)
        {
            Session["CalendarSelect"] = null;
            DayPilotCalendar1.DataStartField = "StartTime";
            DayPilotCalendar1.DataEndField = "EndTime";
            DayPilotCalendar1.DataTextField = "TestEventDetails";

            DayPilotCalendar1.DataIdField = "Id";
            // DayPilotCalendar1.ViewType = "Week";
            DayPilotCalendar1.DataSource = GetData(DateTime.Today, DateTime.Today);// dt;

            //changed to +1 - 04/10/2023
            DayPilotCalendar1.StartDate = DateTime.Today;
            DayPilotCalendar1.Days = 7;

            DayPilotCalendar1.DataBind();

            gv.DataSource = GetData(DateTime.Today, DateTime.Today);// dt;
            gv.DataBind();
            if (Session["CalendarSelect"] == null || Session["CalendarSelect"].ToString() == "Week")
            {

                Calendar1.SelectionMode = CalendarSelectionMode.DayWeek;
                ArrayList selectedDates = new ArrayList();
                DateTime today = DateTime.Now;
                Session["CalendarSelect"] = "Week";
                DateTime firstDay = today.AddDays(-(double)(today.DayOfWeek));
                //Messagebox(((double)today.DayOfWeek).ToString());
                for (int loop = 0; loop < 7; loop++)
                    Calendar1.SelectedDates.Add(firstDay.AddDays(loop));
            }

        }


    }

    private DataTable GetData(DateTime start, DateTime end)
    {
        MySqlDataAdapter da = new MySqlDataAdapter("SELECT " +
            "Id,StartTime,EndTime," +
            "concat(\"<b>ID:</b> \", Id, \"<br/> <b>TestName:</b> \", TestName, \"<br/> <b>VUsers</b> : \", VUserCount, \"<br/> <b>Host Count</b> : \", LoadGeneratorCount) as TestEventDetails" +
            " FROM ReservationTable", ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString);
        //da.SelectCommand.Parameters.AddWithValue("start", start);
        //da.SelectCommand.Parameters.AddWithValue("end", end);

        DataTable dt = new DataTable();
        da.Fill(dt);

        DayPilotCalendar1.DataStartField = "StartTime";
        DayPilotCalendar1.DataEndField = "EndTime";
        DayPilotCalendar1.DataTextField = "TestEventDetails";

        DayPilotCalendar1.DataIdField = "Id";

        return dt;
    }

    private void GetDataByID(String pID)
    {
        //Module to get data from the database and populate in datagrid/calendar
        MySqlDataAdapter da = new MySqlDataAdapter("SELECT Id, RequestorName, TestName, ProjectID, VUserCount, StartTime, EndTime, TestDuration, Comments, LoadGeneratorRefID, LoadGeneratorCount, CreatedOn FROM ReservationTable where ID=@Id", ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString);
        da.SelectCommand.Parameters.AddWithValue("Id", pID);
        
        DataTable dt = new DataTable();
        da.Fill(dt);

        //Fetch recrods from the datatable and polulate the labels
        lblTimeSlotID.Text = dt.Rows[0][0].ToString();
        lblTestName.Text = dt.Rows[0][2].ToString();
        lblStartTime.Text = dt.Rows[0][5].ToString();
        lblEndTime.Text = dt.Rows[0][6].ToString();
        lblDuration.Text = dt.Rows[0][7].ToString();
        lblHostCount.Text = dt.Rows[0][10].ToString();
        lblVuserCount.Text = dt.Rows[0][4].ToString();
        lblProjectName.Text = dt.Rows[0][3].ToString();
        lblCreatedBy.Text = dt.Rows[0][1].ToString();
        lblCreatedOn.Text = dt.Rows[0][11].ToString();
        lblComments.Text = dt.Rows[0][8].ToString();
        lblHostNames.Text = getLGDetails(dt.Rows[0][9].ToString());
        lblLoadGeneratorRefID.Text = dt.Rows[0][9].ToString();
    }

    public string getLGDetails(string LoadTestRefID)
    {
        //Module to get all the LoadGenerator Details from the database
        string result = "";
        using (MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString))
        {
            con.Open();

            MySqlCommand cmd = new MySqlCommand("SELECT (servername) FROM ServerReservation where ReservationID =@LoadTestRefID");
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("LoadTestRefID", LoadTestRefID);
            MySqlDataReader readIn = cmd.ExecuteReader();
            while (readIn.Read())
            {
                // reading data from reader
                result = result + readIn.GetString(0) + "\n";
            }

            con.Close();
        }
        return result;
    }
    private void UpdateReservationSchedule(string RowIdentifier, DateTime startTime, DateTime endTime)
    {
        //Module to update the Reservation schedule

        // clearlabels();
        DataTable table = GetData(DateTime.Today, DateTime.Today);
        
        //based on the data table, take the ID coumn and filter records

        DataColumn[] keyColumns = new DataColumn[1];
        keyColumns[0] = table.Columns["Id"];
        table.PrimaryKey = keyColumns;
        DataRow dr = table.Rows.Find(RowIdentifier);
        TimeSpan span = (endTime - startTime);

        String.Format("{0} days, {1} hours, {2} minutes, {3} seconds",
            span.Days, span.Hours, span.Minutes, span.Seconds);
        string TestDuration = span.Hours.ToString() + "hr " + span.Minutes.ToString() + "min ";
        //String TestEventDetails = "<b>ID:</b> " + Id + " <br/> <b>TestName:</b> " + txtTestName.Text + " <br/> <b>VUsers</b> : " + txtVUserCount.Text + " <br/> <b>Host Count</b> : " + LGSelectCount;

        //Messagebox(TestDuration);
        if (dr != null)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;

            var sql = "UPDATE ReservationTable SET StartTime = @StartTime, TestDuration = @TestDuration, EndTime = @EndTime " +
        "WHERE Id = @Id";

            using (var connection = new MySqlConnection(connectionString))
            {
                using (var command = new MySqlCommand(sql, connection))
                {
                    // Add the parameters for the UpdateCommand.
                    command.Parameters.Add("@StartTime", MySqlDbType.DateTime).Value = startTime;
                    command.Parameters.Add("@TestDuration", MySqlDbType.VarChar).Value = TestDuration;
                    command.Parameters.Add("@EndTime", MySqlDbType.DateTime).Value = endTime;
                    command.Parameters.Add("@Id", MySqlDbType.VarChar).Value = RowIdentifier;
                    connection.Open();

                    command.ExecuteNonQuery();

                    connection.Close();

                }
            }
        }
    }


    public void Messagebox(string xMessage)
    {

        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + xMessage + "');", true);
        //Module to inovke java script
        //Response.Write("<script>alert('" + xMessage + "')</script>");
       // ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + xMessage + "');", true);
    }


    protected void DayPilotCalendar1_OnEventMove(object sender, EventMoveEventArgs e)
    {
        //clearlabels();
        UpdateReservationSchedule(e.Id, e.NewStart, e.NewEnd);

        DayPilotCalendar1.DataSource = GetData(DateTime.Today, DateTime.Today);
        DayPilotCalendar1.DataBind();
        GetDataByID(e.Id);

    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        clearlabels();
        if (Session["CalendarSelect"] != null && Session["CalendarSelect"].ToString() == "Week")
        {
            Calendar1.SelectionMode = CalendarSelectionMode.DayWeek;
            ArrayList selectedDates = new ArrayList();
            DateTime today = Calendar1.SelectedDate;
            
            DateTime firstDay = today.AddDays(-(double)(today.DayOfWeek));
            
            for (int loop = 0; loop < 7; loop++)
                Calendar1.SelectedDates.Add(firstDay.AddDays(loop));
            //changed on 04/10/2023
            DayPilotCalendar1.StartDate = firstDay.AddDays(7);// Calendar1.SelectedDate;
            
        }

        if (Session["CalendarSelect"] != null && Session["CalendarSelect"].ToString() == "Day")
        {
            Calendar1.SelectionMode = CalendarSelectionMode.Day;
            DayPilotCalendar1.Days = 1;
            DayPilotCalendar1.ViewType = 0;
            DayPilotCalendar1.StartDate = Calendar1.SelectedDate;
        }
    }

    protected void Calendar1_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
    {
        Calendar1.SelectedDate = Convert.ToDateTime("01/01/0001");
        if (Session["CalendarSelect"] != null && Session["CalendarSelect"].ToString() == "Week")
        {
            Calendar1.SelectionMode = CalendarSelectionMode.DayWeek;
            ArrayList selectedDates = new ArrayList();
            DateTime today = new DateTime(Calendar1.VisibleDate.Year, Calendar1.VisibleDate.Month, 1);
            DateTime firstDay = today.AddDays(-(double)(today.DayOfWeek));
            for (int loop = 0; loop < 7; loop++)
                Calendar1.SelectedDates.Add(firstDay.AddDays(loop));

            DayPilotCalendar1.StartDate = new DateTime(Calendar1.VisibleDate.Year, Calendar1.VisibleDate.Month, 1);
        }



        if (Session["CalendarSelect"] != null && Session["CalendarSelect"].ToString() == "Day")
        {
            Calendar1.SelectionMode = CalendarSelectionMode.Day;
            Calendar1.SelectedDate = new DateTime(Calendar1.VisibleDate.Year, Calendar1.VisibleDate.Month, 1);
            DayPilotCalendar1.StartDate = new DateTime(Calendar1.VisibleDate.Year, Calendar1.VisibleDate.Month, 1);
        }
    }

    protected void DayPilotCalendar1_BeforeEventRender(object sender, DayPilot.Web.Ui.Events.Calendar.BeforeEventRenderEventArgs e)
    {
        //if ((string)e.DataItem["Id"] == "R002")  // "type" field must be available in the DataSource
        //{
        //    e.CssClass = "special";
        //    e.BackgroundColor = "lightyellow";
        //    e.Html = "<i>WARNING: This is an unusual event.</i><br>" + e.Html;
        //}
    }

    protected void DayPilotCalendar1_EventClick(object sender, EventClickEventArgs e)
    {
        GetDataByID(e.Id);
    }
    protected void DayPilotCalendar1_TimeRangeSelected(object sender, TimeRangeSelectedEventArgs e)
    {
        DayPilotCalendar1.Focus();
        clearlabels();


        Session["StartTime"] = e.Start.ToString("yyyy-MM-ddTHH:mm");
        Session["EndTime"] = e.End.ToString("yyyy-MM-ddTHH:mm");
        TimeSpan span = e.End - e.Start;

        String.Format("{0} days, {1} hours, {2} minutes, {3} seconds",
        span.Days, span.Hours, span.Minutes, span.Seconds);
        string TestDuration = span.Hours.ToString() + "hr " + span.Minutes.ToString() + "min ";
        Session["TestDuration"] = TestDuration;
        Session["RequestType"] = "New";

        string url = "ServerReservation.aspx";
        // string url = "ServerReservation.aspx?start=2022-08-22T01:58 & end=2022-08-22T02:58";
        //Messagebox(url);
        string s = "window.open('" + url + "', 'popup_window', 'width=1200,height=600,left=100,top=100,resizable=no');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);

        DayPilotCalendar1.DataSource = GetData(DateTime.Today, DateTime.Today);
        DayPilotCalendar1.DataBind();

    }

    protected void DayPilotCalendar1_OnEventResize(object sender, EventResizeEventArgs e)
    {
        UpdateReservationSchedule(e.Id, e.NewStart, e.NewEnd);
        GetDataByID(e.Id);
        gv.DataSource = GetData(DateTime.Today, DateTime.Today);
        gv.DataBind();
        DayPilotCalendar1.DataSource = GetData(DateTime.Today, DateTime.Today);
        DayPilotCalendar1.DataBind();

    }

    protected void btnEditSchedule_Click(object sender, EventArgs e)
    {
        if (lblTimeSlotID.Text.Length < 1)
        {
            Messagebox("Please select a timeslot to edit!!");
        }
        else
        {
            Session.Clear();
            // DayPilotCalendar1.ViewType = "Day";
            MySqlDataAdapter da = new MySqlDataAdapter("SELECT Id, RequestorName, TestName, ProjectID, VUserCount, StartTime, EndTime, TestDuration, Comments, LoadGeneratorRefID, LoadGeneratorCount, CreatedOn FROM ReservationTable where ID=@Id", ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString);
            da.SelectCommand.Parameters.AddWithValue("Id", lblTimeSlotID.Text);

            DataTable dt = new DataTable();
            da.Fill(dt);

            CultureInfo culture = new CultureInfo("en-US");
            DateTime StartTime = Convert.ToDateTime(dt.Rows[0][5], culture);
            DateTime EndTime = Convert.ToDateTime(dt.Rows[0][6], culture);


            Session["TimeslotID"] = lblTimeSlotID.Text;
            Session["RequestorName"] = lblCreatedBy.Text;
            Session["TestName"] = lblTestName.Text;
            Session["ProjectID"] = lblProjectName.Text;
            Session["VUserCount"] = lblVuserCount.Text;
            Session["StartTime"] = StartTime.ToString("yyyy-MM-ddTHH:mm");
            Session["EndTime"] = EndTime.ToString("yyyy-MM-ddTHH:mm");
            Session["TestDuration"] = lblDuration.Text;
            Session["Comments"] = lblComments.Text;
            Session["LoadGeneratorRefID"] = dt.Rows[0][9].ToString();
            Session["LoadGeneratorCount"] = lblHostCount.Text;
            Session["RequestType"] = "Edit";
            string url = "ServerReservation.aspx";

            string s = "window.open('" + url + "', 'popup_window', 'width=1297,height=570,left=100,top=100,resizable=no');";
            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);

            DayPilotCalendar1.DataSource = GetData(DateTime.Today, DateTime.Today);
            DayPilotCalendar1.DataBind();
        }
    }

    protected void btnDeleteSchedule_Click(object sender, ImageClickEventArgs e)
    {
        if (lblTimeSlotID.Text.Length < 1)
        {
            Messagebox("Please select a timeslot to delete!!");



        }
        else
        {
            // this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "Confirm()", true);

            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                string connectionString = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ConnectionString;

                var sqlDelRecordTable = "DELETE a.*, b.* FROM reservationtable a LEFT JOIN ServerReservation b ON b.ReservationId = a.LoadGeneratorRefID WHERE a.Id = @Id";

                using (var connection = new MySqlConnection(connectionString))
                {
                    using (var command = new MySqlCommand(sqlDelRecordTable, connection))
                    {
                        // Add the parameters for the UpdateCommand.
                        command.Parameters.Add("@Id", MySqlDbType.VarChar).Value = lblTimeSlotID.Text;
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                clearlabels();
                DayPilotCalendar1.DataSource = GetData(DateTime.Today, DateTime.Today);
                DayPilotCalendar1.DataBind();
            }
        }
    }


    protected void btnNewSchedule_Click(object sender, ImageClickEventArgs e)
    {

        clearlabels();
        Session.Clear();
        DateTime dtFirstInterval = RoundUpToPreviousQuarter(DateTime.Now, TimeSpan.FromMinutes(15));
        DateTime dtSecondInterval = dtFirstInterval.AddMinutes(30);

        Session["StartTime"] = dtFirstInterval;
        Session["EndTime"] = dtSecondInterval;
        Session["RequestType"] = "New";
        string url = "ServerReservation.aspx";

        string s = "window.open('" + url + "', 'popup_window', 'width=1297,height=570,left=100,top=100,resizable=no');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, false);

        DayPilotCalendar1.DataSource = GetData(DateTime.Today, DateTime.Today);
        DayPilotCalendar1.DataBind();
    }
    private DateTime RoundUpToPreviousQuarter(DateTime date, TimeSpan d)
    {
        return new DateTime(((date.Ticks + d.Ticks - 1) / d.Ticks) * d.Ticks);
    }

    // call the method


    protected void btnRefreshSchedule_Click(object sender, ImageClickEventArgs e)
    {
        clearlabels();
        DayPilotCalendar1.DataSource = GetData(DateTime.Today, DateTime.Today);
        DayPilotCalendar1.DataBind();
    }

    protected void lnkDaily_Click(object sender, EventArgs e)
    {
        Session["CalendarSelect"] = "Day";

        Calendar1.TodaysDate = System.DateTime.Now;
        Calendar1.SelectedDate = DateTime.Today;
        DayPilotCalendar1.ViewType = 0;
        DayPilotCalendar1.Days = 1;
        DayPilotCalendar1.StartDate = Calendar1.SelectedDate;
    }

    protected void lnkWeekly_Click(object sender, EventArgs e)
    {
        Session["CalendarSelect"] = "Week";
        DayPilotCalendar1.ViewType = (DayPilot.Web.Ui.Enums.Calendar.ViewTypeEnum)2;
        DayPilotCalendar1.Days = 7;
        DayPilotCalendar1.StartDate = DateTime.Today;
        Calendar1.SelectionMode = CalendarSelectionMode.DayWeek;
        ArrayList selectedDates = new ArrayList();
        DateTime today = DateTime.Now;
        DateTime firstDay = today.AddDays(-(double)(today.DayOfWeek));
        for (int loop = 0; loop < 7; loop++)
            Calendar1.SelectedDates.Add(firstDay.AddDays(loop));
    }


    public void clearlabels()
    {
        lblComments.Text = "";
        lblTestName.Text = string.Empty;
        lblProjectName.Text = string.Empty;
        lblCreatedBy.Text = string.Empty;
        lblCreatedOn.Text = string.Empty;
        lblStartTime.Text = string.Empty;
        lblEndTime.Text = string.Empty;
        lblDuration.Text = string.Empty;
        lblHostCount.Text = string.Empty;
        lblHostNames.Text = string.Empty;
        lblLoadGeneratorRefID.Text = string.Empty;
        lblVuserCount.Text = string.Empty;
        lblTimeSlotID.Text = string.Empty;

    }



}