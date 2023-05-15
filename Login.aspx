<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="overflow-y:hidden">
<head runat="server">
    <title>Credentials</title>
    <link href="Styles/stylesheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>

        <div>
            <table style="width:100%; background-color: #0099FF;height:30px">
                <tr>
                    <td style="width:20%"><asp:Image ID="Image1" runat="server" AlternateText="Home" ImageUrl="~/Images/W.png" Height="32px" Width="42px" /></td>
                    <td style="text-align:center;width:70%"><b>Server Reservation Center</b></td>
                    <td style="width:10%">Version 1.0</td>
                </tr>
            </table>
            <div id="loginform" >
                <table style="table-layout:fixed;margin-left: auto; margin-right: auto; margin-top: 50px; margin-bottom: auto; top: 50px;">

                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top"><span class="txt">Username: </span><span class="redstar">*</span></td>
                        <td>
                            <asp:TextBox ID="txtUserName" runat="server" placeholder=" UserName"
                                Width="186px"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="rfvUserName" runat="server"
                                ErrorMessage="Please enter  User Name" ControlToValidate="txtUserName"
                                Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top"><span class="txt">Password: <span class="redstar">*</span> &nbsp;&nbsp;</span></td>
                        <td>
                            <asp:TextBox ID="txtPwd" runat="server" TextMode="Password" placeholder=" Password" Width="186px"></asp:TextBox>
                            <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="txtPwd" Display="Dynamic"
                                ErrorMessage="Please enter Password" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Label ID="lllInfo" Text="sample creds: userid001/password" runat="server"></asp:Label>
                            <br />
                            <asp:Button ID="btnSubmit" runat="server" Text="Login" OnClick="btnSubmit_Click" />
                            <asp:Button ID="btnclose" runat="server" Text="Close" OnClientClick="javascript:window.close(); return false;"  CausesValidation="false" /></td>
                    </tr>
                    <tr>
                        
                        <td colspan="2">
                            <asp:Label ID="Label1" Text="" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <%--  </asp:Panel>--%>
        </div>
    </form>
    

</body>
   
</html>
