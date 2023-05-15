<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ServerReservation.aspx.cs" Inherits="ServerReservation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="overflow-y:hidden">

<head runat="server">
    <title>ServerReservationForm</title>
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="Styles/JavaScript.js" type="text/javascript"></script>
    <script type="text/javascript" src="Styles/jquery.min.js"></script>
    <script src="Styles/jquery-ui.js" type="text/javascript"></script>
    <link href="Styles/jquery-ui.css"
        rel="stylesheet" type="text/css" />


    <script type="text/javascript">
        function ShowPopup(message) {
            $(function () {
                $("#dialog").html(message);
                $("#dialog").dialog({
                    title: "Error Message",
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

  <%--  <script type="text/javascript">

        function resizeWindow() {
            // you can get height and width from serverside as well      
            var width = 400;
            var height = 400;
            this.resizeTo(width, height);
            this.focus();


        }
    </script>--%>



    <%--Highlight GridView row on mouseover event--%>

    <script type="text/javascript">

        function Filter(searchString) {

            var tblGrid = document.getElementById('<%= GridView1.ClientID %>');
            var rows = tblGrid.rows;
            var i = 0, row, cell;
            for (i = 1; i < rows.length; i++) {
                row = rows[i];
                var found = false;
                for (var j = 0; j < row.cells.length; j++) {
                    cell = row.cells[j];
                    if (cell.innerHTML.indexOf(searchString) >= 0) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    row.style['display'] = 'none';

                }
                else {
                    row.style.display = '';
                }
            }

            return false;
        }

    </script>
    <script type="text/javascript">
        function MouseEvents(objRef, evt) {
            var checkbox = objRef.getElementsByTagName("input")[0];
            if (evt.type == "mouseover") {
                objRef.style.backgroundColor = "green";
            }
            else {
                if (checkbox.checked) {
                    objRef.style.backgroundColor = "red";
                }
                else if (evt.type == "mouseout") {
                    if (objRef.rowIndex % 2 == 0) {
                        //Alternating Row 
                        objRef.style.backgroundColor = "#C2D69B";
                    }
                    else {
                        objRef.style.backgroundColor = "white";
                    }
                }
            }
        }
    </script>


    <%--Highlight Row when checkbox is checked--%>

    <script type="text/javascript">
        function Check_Click(objRef) {
            //Get the Row based on checkbox
            var row = objRef.parentNode.parentNode;
            if (objRef.checked) {
                //If checked change color to Aqua
                row.style.backgroundColor = "red";
            }
            else {
                //If not checked change back to original color
                if (row.rowIndex % 2 == 0) {
                    //Alternating Row Color
                    row.style.backgroundColor = "#C2D69B";
                }
                else {
                    row.style.backgroundColor = "white";
                }
            }

            //Get the reference of GridView
            var GridView = row.parentNode;
            //Get all input elements in Gridview
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                //The First element is the Header Checkbox
                var headerCheckBox = inputList[0];
                //Based on all or none checkboxes
                //are checked check/uncheck Header Checkbox
                var checked = true;
                if (inputList[i].type == "checkbox" && inputList[i] != headerCheckBox) {
                    if (!inputList[i].checked) {
                        checked = false;
                        break;
                    }
                }
            }
            headerCheckBox.checked = checked;
        }

    </script>


    <script type="text/javascript">
        function diff_hours() {

            var dt1 = document.getElementById('txtStartTimeCal').value;
            var dt2 = document.getElementById('txtEndTimeCal').value;

            if (dt1 && dt2) {
                var dt3 = new Date(dt1.replace('T', ' '));
                var dt4 = new Date(dt2.replace('T', ' '));
                if (dt3 > dt4) {
                    ShowPopup("Start Time is greater than End Time. Please correct");
                    document.getElementById('txtStartTimeCal').value = new Date().toISOString().split('T')[0] + "T" + new Date().toLocaleTimeString('en-US', {
                        hour12: false,
                        hour: "numeric",
                        minute: "numeric"
                    });
                    document.getElementById('txtEndTimeCal').value = "";
                    document.getElementById('txtTestDuration').value = "";
                    return;
                }

                var hourDiff = (dt4 - dt3);
                //alert(hourDiff);
                var minDiff = hourDiff / 60 / 1000; //in minutes
                var hDiff = hourDiff / 3600 / 1000; //in hours
                var humanReadable = {};
                humanReadable.hours = Math.floor(hDiff);
                humanReadable.minutes = minDiff - 60 * humanReadable.hours;

                if (hourDiff / 1000 / 60 < 30) {
                    ShowPopup("Please select a test duration of 30 minutes at least. Please correct");
                    document.getElementById('txtEndTimeCal').value = "";
                    document.getElementById('txtTestDuration').value = "";
                    return;
                }
                if (!dt1) {
                    document.getElementById("txtTestDuration").value = "";
                }
                else {
                    document.getElementById("txtTestDuration").value = humanReadable.hours + "hr " + humanReadable.minutes + "min";
                }
                document.getElementById("LinkButton3").click();
            }
        }
    </script>

    <script type="text/javascript">
        function validate_hours() {
            var dt1 = document.getElementById('txtStartTimeCal').value;
            var dt3 = new Date(dt1.replace('T', ' '));
            var today = new Date();
            today.setHours(0, 0, 0, 0);

            if (dt3 < today) {
                ShowPopup("Start Time cannot be in past. Please correct");
                document.getElementById('txtStartTimeCal').value = new Date().toISOString().split('T')[0] + "T" + new Date().toLocaleTimeString('en-US', {
                    hour12: false,
                    hour: "numeric",
                    minute: "numeric"
                });
                return;
            }
        }
    </script>


    <style type="text/css">
        #txtTestDuration {
            width: 225px;
            height: 25px;
        }

        .auto-style25 {
            height: 483px;
        }

        .auto-style26 {
            height: 81px;
        }
    </style>

</head>
<body>

    <form id="form1" runat="server">
        <table style="width:100%">
            <tr style="height:10%">
                <td>
                    <div id="dialog" style="display: none">
                    </div>
                    <table style="width: 100%; background-color: #0099FF; height: 50px">
                        <tr>
                            <td style="width: 20%">
                                <asp:Image ID="Image1" runat="server" AlternateText="Home" ImageUrl="~/Images/W.png" Height="32px" Width="42px" /></td>
                            <td style="text-align: center; width: 70%"><b>Server Reservation Center</b></td>
                            <td style="width: 10%">Version 1.0</td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr style="height:90%">
                <td>
                    <div>

                        <table style=" height: 100%;width: 100%;">
                            <tr>
                                <td width="2%" class="auto-style25"></td>
                                <td width="96%" style="" class="auto-style25">

                                    <asp:Label ID="lblHeading" runat="server" Text="Add a new Timeslot"></asp:Label>

                                    <table style="display: block;">
                                        <tr>
                                            <td class="auto-style21">
                                                <asp:Label runat="server" Text="User Name: "></asp:Label>
                                            </td>
                                            <td class="table-style1">
                                                <asp:TextBox ID="txtUserName" runat="server" Height="25px" Width="225px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>

                                            </td>
                                            <td class="auto-style21">
                                                <asp:Label ID="lnkButtonLGController" runat="server">Available Resources</asp:Label>
                                            </td>
                                            <td rowspan="8" style="vertical-align: top" width="50%">
                                                <%--</asp:Panel>--%><%--<asp:UpdatePanel runat="server" ID="UpdatePanel1">
									<Triggers>
										<asp:PostBackTrigger ControlID="Button3" />
									</Triggers>
									<ContentTemplate>--%>
                                                <table width="60%">
                                                    <tr>
                                                        <td class="grid-style1">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="false" OnClick="LinkButton3_Click">All Servers</asp:LinkButton>
                                                        </td>
                                                        <td class="grid-style1">
                                                            <asp:LinkButton ID="LinkButton1" CausesValidation="false" runat="server" OnClick="LinkButton1_Click1">Filter Controller</asp:LinkButton>
                                                            <%--OnClientClick="Filter('Controller');return false;" --%>
                                                        </td>
                                                        <td class="grid-style1">
                                                            <asp:LinkButton ID="LinkButton2" CausesValidation="false" runat="server" OnClick="LinkButton2_Click">Filter Load Generator</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:GridView ID="GridView1" runat="server" EmptyDataText="Click on above link to show relevant resources" AllowPaging="True" DataKeyNames="ServerName" AutoGenerateColumns="False" CellPadding="3" OnRowDataBound="GridView1_RowDataBound" Width="516px" PageSize="8" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" OnPageIndexChanging="GridView1_PageIndexChanging" ShowHeaderWhenEmpty="True" CssClass="grid-style1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Select Data">

                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="CheckBox1" runat="server" />
                                                                <%--Enabled='<%# Eval("Status").ToString().Equals("Available") %>' --%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="ServerType" HeaderText="ServerType" SortExpression="ServerType" />
                                                        <asp:BoundField DataField="ServerName" HeaderText="ServerName" SortExpression="ServerName" />
                                                        <asp:BoundField DataField="TestReservationID" HeaderText="TestReservationID" SortExpression="Status" Visible="true" />
                                                        <asp:TemplateField HeaderText="Status" ItemStyle-Width="100" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Image ID="Image1" ImageUrl='<%# "~/Images/" + (Eval("Status").ToString() == "Available" ? "P.png" : "A.png") %>' runat="server" Height="25" Width="25" />
                                                            </ItemTemplate>

                                                            <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <HeaderStyle BackColor="#006699" ForeColor="White" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <RowStyle ForeColor="#000066" />
                                                    <SelectedRowStyle BackColor="#669999" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                                                </asp:GridView>


                                                <%--<asp:Button ID="Button3" runat="server" Text="OK" OnClick="Button3_Click" />
										<asp:Button ID="Button4" runat="server" Text="Close" />
									</ContentTemplate>
								</asp:UpdatePanel>--%>
						   
                                            </td>
                                        </tr>
                                        <br />
                                        <tr>
                                            <td class="auto-style21">
                                                <asp:Label runat="server" Text="Test Name:" ID="Label7"></asp:Label>
                                            </td>
                                            <td class="table-style1">
                                                <asp:TextBox ID="txtTestName" runat="server" Height="25px" Width="225px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTestName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <br />
                                        <tr>
                                            <td class="auto-style21">
                                                <asp:Label runat="server" Text="Project Name: " ID="Label2"></asp:Label>
                                            </td>
                                            <td class="table-style1">
                                                <asp:TextBox ID="txtProjectName" runat="server" Height="25px" Width="225px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtProjectName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style21">
                                                <asp:Label runat="server" Text="VUser Count: " ID="Label6"></asp:Label>
                                            </td>
                                            <td class="table-style1">
                                                <asp:TextBox ID="txtVUserCount" Text="10" runat="server" Height="25px" Width="225px"></asp:TextBox>

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtVUserCount" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>

                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style21">
                                                <asp:Label runat="server" Text="Start Time:"></asp:Label>
                                            </td>
                                            <td class="table-style1">
                                                <asp:TextBox ID="txtStartTimeCal" runat="server" onchange="validate_hours();diff_hours();" TextMode="DateTimeLocal" placeholder="mm/dd/yyyy" Height="25px" Width="225px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtStartTimeCal" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style21">
                                                <asp:Label ID="Label1" runat="server" Text="End Time:"></asp:Label>
                                            </td>
                                            <td class="table-style1">
                                                <asp:TextBox ID="txtEndTimeCal" runat="server" onchange="diff_hours()" TextMode="DateTimeLocal" placeholder="mm/dd/yyyy" Height="25px" Width="225px" CssClass="auto-style8" AutoPostBack="False"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEndTimeCal" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style21">
                                                <asp:Label runat="server" Text="Total Duration: " ID="Label5"></asp:Label>
                                            </td>
                                            <td class="table-style1">
                                                <input type="text" readonly="readonly" runat="server" id="txtTestDuration" />
                                                <%--<asp:TextBox ID="txtTestDuration" runat="server" Height="25px" Width="123px" AutoPostBack="False" ReadOnly="true"></asp:TextBox>--%>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style21">
                                                <asp:Label ID="Label3" runat="server" Text="Comments:"></asp:Label></td>
                                            <td class="table-style1">
                                                <asp:TextBox ID="txtComments" runat="server" Height="25px" Width="225px"></asp:TextBox></td>
                                            <td style="vertical-align: top">&nbsp;</td>

                                        </tr>
                                        <tr>

                                            <td colspan="2" class="auto-style26">
                                                <%--<cc1:NumericUpDownExtender ID="NumericUpDownExtender1" runat="server"
                                        TargetControlID="txtVUserCount" Width="20" Maximum="9999" Minimum="1"></cc1:NumericUpDownExtender>--%>
                                    &nbsp;</td>

                                            <%--<cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="lnkButtonLGController" PopupControlID="Panel1" CancelControlID="Button4" BackgroundCssClass="popup"></cc1:ModalPopupExtender>--%><%--<asp:Panel ID="Panel1" runat="server">
							Select Controller and Load Generators--%>
                                            <td colspan="2" width="50%" class="auto-style26">
                                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MySQLConnectionString %>" SelectCommand="SELECT ServerType, ServerName, Status FROM ServerInventory"></asp:SqlDataSource>

                                                <asp:Button ID="Button1" runat="server" Text="Book Schedule" OnClick="Button1_Click" Height="35px" />
                                                &nbsp;&nbsp;


						<asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Cancel" CausesValidation="false" Height="35px" />
                                                <%-- <input type="button" value="close popup" onclick="self.close(); window.opener.location.reload(false); "/>--%>
                                            </td>


                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                
                                            </td>
                                        </tr>

                                    </table>

                                </td>
                                <td width="2%" class="auto-style25"></td>
                            </tr>
                        </table>


                    </div>
                </td>
            </tr>

            <tr style="height:10%">
                <td>

                    <table style="width: 100%">
                        <tr>
                            <td style="width:20%"></td>
                            <td style="width:60%; text-align: center; align-content: end"><b>Copyright by </b></td>
                            <td style="width:20%"><asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager></td>
                        </tr>
                    </table>

                    
                </td>
            </tr>

        </table>




    </form>
</body>
</html>
