<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ServerAdministration.aspx.cs" Inherits="DefaultAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="overflow-y: hidden">
<head runat="server">
    <title>Server Administration</title>
    <link href="Styles/stylesheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%;border-style:solid">
            <tr style="width: 10%">
                <td>
                    <table style="width: 100%; background-color: #0099FF; height: 70px">
                        <tr>
                            <td style="width: 20%">
                                <asp:Image ID="Image1" runat="server" AlternateText="Home" ImageUrl="~/Images/W.png" Height="32px" Width="42px" /></td>
                            <td style="text-align: center; width: 70%"><b>Server Reservation Center</b></td>
                            <td style="width: 10%">Version 1.0</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="width: 80%;">
                <td >
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <div id="dvGrid" style="padding: 40px;">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowDataBound="OnRowDataBound"
                                    DataKeyNames="Id" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" PageSize="15" AllowPaging="True" OnPageIndexChanging="OnPaging"
                                    OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added."
                                    Width="653px" CellPadding="4" ForeColor="#333333" GridLines="None">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Server Id" ItemStyle-Width="150">
                                            <ItemTemplate>
                                                <asp:Label ID="lblServerId" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtId" runat="server" Text='<%# Eval("Id") %>' Width="140"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="150px" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Server Name" ItemStyle-Width="150">
                                            <ItemTemplate>
                                                <asp:Label ID="lblServerName" runat="server" Text='<%# Eval("ServerName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtServerName" runat="server" Text='<%# Eval("ServerName") %>' Width="140"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="150px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Server Type" ItemStyle-Width="150">
                                            <ItemTemplate>
                                                <asp:Label ID="lblServerType" runat="server" Text='<%# Eval("ServerType") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtServerType" runat="server" Text='<%# Eval("ServerType") %>' Width="140"></asp:TextBox>
                                            </EditItemTemplate>

                                            <ItemStyle Width="150px" />

                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Server Status" ItemStyle-Width="150">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtStatus" runat="server" Text='<%# Eval("Status") %>' Width="140"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="150px" />
                                        </asp:TemplateField>

                                        <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true"
                                            ItemStyle-Width="150">
                                            <ItemStyle Width="150px" />
                                        </asp:CommandField>
                                    </Columns>
                                    <EditRowStyle BackColor="#2461BF" />
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#EFF3FB" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                </asp:GridView>
                                <table cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                                    <tr>
                                        <td style="width: 150px">Server ID:<br />
                                            <asp:TextBox ID="txtId" runat="server" Width="140" />
                                        </td>
                                        <td style="width: 150px">Server Name:<br />
                                            <asp:TextBox ID="txtServerName" runat="server" Width="140" />
                                        </td>
                                        <td style="width: 150px">ServerType:<br />
                                            <asp:TextBox ID="txtServerType" runat="server" Width="140" />
                                        </td>
                                        <td style="width: 150px">Status:<br />
                                            <asp:TextBox ID="txtStatus" runat="server" Width="140" />
                                        </td>
                                        <td style="width: 150px">
                                            <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Insert" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
            <tr style="width: 10%">
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 20%"></td>
                            <td style="width: 60%; text-align: center; align-content: end"><b>Copyright by </b></td>
                            <td style="width: 20%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>



    </form>


</body>
</html>
