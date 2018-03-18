﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tax_list.aspx.cs" Inherits="console_taxManager_tax_list" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>税费信息列表</title>
    <link rel="stylesheet" href="../css/control.css" type="text/css" />
    <script type="text/javascript" src="../js/JScript.js"></script>
</head>
<body>
      <form id="form1" runat="server">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#C4D8ED">
            <tr>
                <td>
                </td>
                <td>
                    <div>
                        <table align="center" cellpadding="4" cellspacing="1" border="0" width="100%" class="toptable grid">
                            <tr>
                                <td height="25" width="100" style="color: Red;">
                                   税费信息列表管理</td>
                            </tr>
                        </table>
                      
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                            <tr>
                                <td style="width: 100%;">
                                    <asp:Repeater ID="rptshopnews" runat="server">
                                        <HeaderTemplate>
                                            <table width="100%" border="1" cellspacing="0" cellpadding="4" style="border-collapse: collapse">
                                                <tr style="background-color: #799AE1; color: White;">
                                                    <th style="width: 5%">
                                                        选择</th>
                                                    <th style="width: 10%">
                                                        类型</th>
                                                    <th style="width: 15%">
                                                        航空公司代码</th>
                                                    <th style="width: 20%">
                                                        航空公司</th>
                                                    <th style="width: 20%">
                                                        出发机场</th>
                                                     <th style="width:15%">
                                                        到达机场</th>
                                                    <th style="width: 15%">
                                                        税费</th>
                                                    <th style="width: 10%">
                                                        操作</th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr style="background-color: #F6F6F6; text-align: center;">
                                                <td>
                                                   <input id="chk" name="chk" type="checkbox" style="border: 0" value="<%#DataBinder.Eval(Container.DataItem, "id")%>" />
                                                </td>
                                                <td>
                                                    <%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "taxType"))==0?"单程":"双程"%>
                                                </td>
                                                <td>
                                                    <%#DataBinder.Eval(Container.DataItem, "airlineCode")%>
                                                </td>
                                                <td>
                                                    <%#DataBinder.Eval(Container.DataItem, "airlineName")%>
                                                </td>
                                                <td>
                                                    <%#DataBinder.Eval(Container.DataItem, "fromCityName")%>
                                                </td>
                                                <td>
                                                   <%#DataBinder.Eval(Container.DataItem, "toCityName")%>
                                                </td>
                                                <td>
                                                    <%#DataBinder.Eval(Container.DataItem, "tax")%>
                                                </td>
                                                <td>
                                                     <a style="color:Red" href="tax_add.aspx?id=<%#DataBinder.Eval(Container.DataItem, "id")%>">修改</a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        
                                        
                                        
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </td>
                            </tr>
                            <tr>
                                            <td style="height: 36px">
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr bgcolor="#E7E7E7">
                                                        <td style="width: 12%; height: 28px;">
                                                            <input id="chkall" type="checkbox" style="margin-left: 15px;" onclick="CheckAll(this.form)" />全选</td>
                                                        <td  style="width: 38%; height: 28px;" align="left">
                                                            <asp:Button ID="btndel" runat="server" Text="删 除" Height="23px" OnClientClick="return check()"
                                                                OnClick="btndel_Click" />
                                                        </td>
                                                        <td align="right" bgcolor="#E7E7E7" style="color: #000000; height: 28px; width: 50%;">
                                                            <webdiyer:AspNetPager ID="Pager" runat="server" FirstPageText="首页" HorizontalAlign="Right"
                                                                LastPageText="末页" NextPageText="下一页" PageSize="20" PrevPageText="上一页" ShowPageIndexBox="Always"
                                                                SubmitButtonText="转到" OnPageChanged="Pager_PageChanged" AlwaysShow="True">
                                                            </webdiyer:AspNetPager>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                            </tr>        
                        </table>
                    </div>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <img src="../images/r_4.gif" alt="" /></td>
                <td>
                </td>
                <td>
                    <img src="../images/r_3.gif" alt="" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
