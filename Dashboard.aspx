<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard Form</title>
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="Styles/JavaScript.js" type="text/javascript"></script>
    <script type="text/javascript" src="Styles/jquery.min.js"></script>
    <script src="Styles/jquery-ui.js" type="text/javascript"></script>
    <link href="Styles/jquery-ui.css"
        rel="stylesheet" type="text/css" />


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 100%; background-color: #0099FF; height: 70px">
                <tr>
                    <td style="width: 20%">
                        <asp:Image ID="Image1" runat="server" AlternateText="Home" ImageUrl="~/Images/W.png" Height="32px" Width="42px" /></td>
                    <td style="text-align: center; width: 70%"><b>Server Reservation Center</b></td>
                    <td style="width: 10%">Version 1.0</td>
                </tr>
            </table>
            <div class="auto-style7" style="background-color: #E9E9E9; border-style: solid; border-width: thin">

                <table width="100%">
                    <tr>
                        <td width="25%">
                            <table width="100%">
                                <tr>
                                    <td width="10%">
                                        <asp:ImageButton ID="btnNewSchedule" runat="server" ImageUrl="~/Images/new.png" AlternateText="New" Width="31px" Height="35px" OnClick="btnNewSchedule_Click" />
                                    </td>
                                    <td class="auto-style5"></td>
                                    <td width="10%">
                                        <asp:ImageButton ID="btnEditSchedule" runat="server" ImageUrl="~/Images/edit.png" AlternateText="New" Width="31px" Height="35px" OnClick="btnEditSchedule_Click" />
                                    </td>
                                    <td class="auto-style5"></td>
                                    <td width="10%">
                                        <asp:ImageButton ID="btnDeleteSchedule" runat="server" ImageUrl="~/Images/del.png" AlternateText="Delete" Width="31px" Height="35px" CausesValidation="False"
                                            OnClick="btnDeleteSchedule_Click" />
                                    </td>
                                    <td class="auto-style6"></td>
                                    <td width="10%">
                                        <asp:ImageButton ID="btnRefreshSchedule" runat="server" ImageUrl="~/Images/refresh.png" AlternateText="Refresh" Width="31px" Height="35px" OnClick="btnRefreshSchedule_Click" />
                                    </td>
                                    <td width="5%"></td>
                                    <td class="auto-style4">


                                        <table>
                                            <tr>
                                                <td width="15%" class="auto-style1">
                                                    <asp:LinkButton ID="lnkDaily" Text="Day" Font-Names="Calibri" Font-Size="Small" runat="server" OnClick="lnkDaily_Click" />
                                                </td>
                                                <td class="auto-style9"></td>
                                                <td width="15%" class="auto-style1">
                                                    <asp:LinkButton ID="lnkWeekly" Text="Week" Font-Names="Calibri" Font-Size="Small" runat="server" OnClick="lnkWeekly_Click" />
                                                </td>
                                                <td class="auto-style8"></td>
                                                <td></td>


                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>

                        <td align="right" width="75%" class="auto-style17" style="align-content: center">
                            <asp:HyperLink ID="btnLogin" runat="server" Font-Names="Calibri" Font-Size="Small" NavigateUrl="javascript:w= window.open('Login.aspx','mywin','left=200,top=200,width=900,height=270,toolbar=0,directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,dialog=yes,resizable=no');">Server Adminstration</asp:HyperLink>
                        </td>
                    </tr>
                </table>


                <asp:GridView ID="gv" runat="server" Visible="false">
                </asp:GridView>
            </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

            <%-- <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                <ContentTemplate>--%>

            <table>

                <tr>
                    <td style="vertical-align: top" width="10%">
                        <asp:Calendar ID="Calendar1" FirstDayOfWeek="Sunday" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="Calendar1_SelectionChanged" OnVisibleMonthChanged="Calendar1_VisibleMonthChanged" SelectionMode="DayWeek" Width="200px">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <OtherMonthDayStyle ForeColor="#808080" />
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <WeekendDayStyle BackColor="#FFFFCC" />
                        </asp:Calendar>

                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MySQLConnectionString %>" SelectCommand="SELECT * FROM ReservationTable"></asp:SqlDataSource>
                    </td>
                    <td width="70%" style="vertical-align: top">
                        <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" ClientObjectName="dp_week" StartDate="2022-08-21" ViewType="Week" ScrollPositionHour="8" HeaderDateFormat="d MMMM yyyy" OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender"
                            EventClickHandling="PostBack"
                            OnEventClick="DayPilotCalendar1_EventClick"
                            TimeRangeSelectedHandling="PostBack"
                            OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected"
                            EventMoveHandling="PostBack"
                            OnEventMove="DayPilotCalendar1_OnEventMove"
                            EventResizeHandling="PostBack"
                            OnEventResize="DayPilotCalendar1_OnEventResize" CellHeight="30" />
                    </td>
                    <td width="20%" style="vertical-align: top; background-color: #E9E9E9;">
                        <table class="auto-style10" width="100%">
                            <tr>
                                <td colspan="2" style="font-family: Calibri; font-size: large; font-weight: bold">Summary</td>
                            </tr>
                            <tr>
                                <td class="auto-style13">&nbsp;</td>
                                <td class="auto-style14">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Timeslot ID:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblTimeSlotID" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Test Name:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblTestName" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Start Time:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblStartTime" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">End Time:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblEndTime" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Duration:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblDuration" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Host(s):</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblHostCount" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Vusers:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblVuserCount" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Project:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblProjectName" runat="server" Width="100%"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Created By:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblCreatedBy" runat="server" Width="100%"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Created On:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblCreatedOn" runat="server" Width="100%"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Comments:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblComments" runat="server" Width="100%"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13">Host Names:</td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblHostNames" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style13"></td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblLoadGeneratorRefID" runat="server" Visible="false"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>



            <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>


            <script type="text/javascript">
                function Confirm() {
                    var confirm_value = document.createElement("INPUT");
                    confirm_value.type = "hidden";
                    confirm_value.name = "confirm_value";
                    var a = document.getElementById('<%= lblTimeSlotID.Text %>');
                    if (typeof a !== 'undefined') {
                        if (confirm("Do you want to delete the timeslot?")) {
                            confirm_value.value = "Yes";
                        } else {
                            confirm_value.value = "No";
                        }
                        document.forms[0].appendChild(confirm_value);

                    }

                }
            </script>

            <script type="text/javascript">
                function PostToNewWindow() {
                    originalTarget = document.forms[0].target;
                    document.forms[0].target = '_blank';
                    window.setTimeout("document.forms[0].target=originalTarget;", 300);
                    return true;
                }
                function ShowPopup(message, title) {
                    $(function () {
                        $("#dialog").html(message);
                        $("#dialog").dialog({
                            title: title,
                            width: 450,
                            buttons: {
                                Close: function () {
                                    $(this).dialog('close');

                                }
                            },
                            modal: true
                        });
                    });
                };
            </script>

            <script language="javascript">
                function popitup(url) {
                    newwindow = window.open(url, 'name', 'height=400,width=500');
                    if (window.focus) { newwindow.focus() }
                    return false;
                }

                //function showModal() {
                //    window.showModalDialog("ServerReservation.aspx", "", "dialogHeight:500px; dialogWidth:600px")
                //}
            </script>

        </div>
        <div id="dialog" style="display: none">
        </div>
        <table style="width: 100%">
            <tr>
                <td style="text-align: center; align-content: end"><b>Copyright by </b></td>

            </tr>
        </table>
    </form>


</body>
</html>
