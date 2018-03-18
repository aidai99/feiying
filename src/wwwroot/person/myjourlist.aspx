﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="myjourlist.aspx.cs" Inherits="person_myjourlist" %>
<%@ Register Src="../share/searchControl.ascx" TagName="searchControl" TagPrefix="uc2" %>
<%@ Register Src="../share/footControl.ascx" TagName="footControl" TagPrefix="uc2" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>日记列表-飞瀛网</title>
    <link href="../css/main.css" rel="stylesheet" type="text/css" />
    <link href="../css/person.css" rel="stylesheet" type="text/css" />
    <meta name="Description"  content="飞瀛网" />
    <meta name="keywords" content="飞瀛网" />
</head>
<body>
  <div class="mainbody" >
  <form id="form1" runat="server">
  <!--header start-->
<div class="headertop"><span><img src="../images/home.jpg" alt="飞瀛网" /><img src="../images/homeinfor.jpg" alt="国际机票专家" />国际、国内机票服务热线：4008-850-663(免费)</span></div>
<div class="headerbottom">
  <div class="headerbottom_left"><a href="http://www.fei580.com" title="飞瀛网"><img src="../images/logo.jpg" alt="" /></a></div>
  <div class="headerbottom_right">
    <div class="headerbottom_rightone">
    <% if (Session["Mem_LoginName"] == null)
       { %>
    <a href="../login.aspx" title="">会员登录</a>|<a href="../regAgree.aspx" title="会员注册">会员注册</a>
    <%
        }
        else
        {
     %>
    <a href="../person/myticket.aspx" title="">您好，<%=Session["Mem_LoginName"].ToString() %> </a>| <a href="../person/myticket.aspx" title="">积分 <%=Session["Mem_Money"].ToString() %></a>|<a href="../person/myinfo.aspx" title="">个人中心</a>|<a href="../logout.aspx" title="">退出登录</a>
    <%}
         %> 
    </div>
    <ul class="menu_1">
      <li class="two"><a href="http://www.fei580.com" title="首页">首&nbsp;页</a></li>
      <li class="two"><a href="../recommend.aspx" title="特价机票">特价机票</a></li>
      <li class="two"><a href="../international.aspx" title="国际机票">国际机票</a></li>
      <li class="two"><a href="../ticket" title="国内机票">国内机票</a></li>
      <li class="two"><a href="../hotel" title="特价酒店">特价酒店</a></li>
      <li class="two"><a href="../quan.aspx"title="飞瀛圈" target="_blank">飞瀛圈</a></li>
      <li class="two" style="background:none;"><a href="/sm/" title="飞瀛服务">飞瀛服务</a></li>
      <li class="new_imgs" style="padding:0px;background:none;"><img src="../images/new.gif" alt="" /></li>
    </ul>
    <div class="menubottom">
	    <ul class="nohidden">
	      <li class="two"><a href="../airline.aspx" title="航空公司">航空公司</a></li>
	      <li class="two"><a href="../airport.aspx" title="世界机场">世界机场</a></li>
	      <li class="two"><a href="../airplane.aspx" title="民航机型">民航机型</a></li>
	      <li class="two"><a href="../news.aspx" title="">新闻资讯</a></li>
	    </ul>
            <uc2:searchControl ID="SearchControl1" runat="server" />
    </div>
  </div>
</div>



    <div style="margin:0px auto;width:953px;">

      <div class="persontopnav">你当前的积分是：<code><%=Mem_Money%></code><span>赶快兑换吧!</span></div>
       <div class="person_leftboxtwo">
         <h2>个人中心主页</h2>
         <ul>
          <li><a class="person_leftboxtwo_out" href="myinfo.aspx" title="个人资料">个人资料</a><a class="person_leftboxtwo_out" href="myticket.aspx" title="我的机票">我的机票</a></li>
          <li><a class="person_leftboxtwo_out" href="../quan.aspx" title="飞瀛圈" target="_blank">飞瀛圈</a><a class="person_leftboxtwo_out" href="../quanPublish.aspx" title="我的话题">发表话题</a><a class="person_leftboxtwo_out" href="../quanList.aspx?username=<%=Session["Mem_LoginName"]%>" title="">我的话题</a></li>
          <li><a class="person_leftboxtwo_out" href="http://quan.fei580.com" title="" target="_blank">飞瀛社区</a></li>
          <li><a class="person_leftboxtwo_out" href="../prizes.aspx" title="" target="_blank">兑换奖品</a></li>
          <li style="background:none;"><a class="person_leftboxtwo_out" href="mypwdedit.aspx" title="修改密码">修改密码</a><a class="person_leftboxtwo_out" href="myfeedlist.aspx" title="意见反馈">意见反馈</a></li>
         </ul>
       </div>
       
      <div class="person_rightbox">
         <span class="yijancss"><a href="myjouradd.aspx" title="发表日记" class="white">发表日记</a></span>
        <table cellpadding="0" cellspacing="0" class="person_tableone">
          <asp:Repeater ID="rptshopnews" runat="server">
            <HeaderTemplate>
          <tr>
            <th>日记标题</th><th>发表日期</th><th>操作</th>
          </tr>
               </HeaderTemplate>
            <ItemTemplate>
          <tr>
            <td><%#Eval("title") %></td><td><%#Eval("addtime") %></td><td><a href="myjourinfo.aspx?id=<%#Eval("jId")%>" title="查看详情" class="blackline">查看详情</a>|<a href="?Oper=del&id=<%#Eval("jId")%>" class="blackline" >删除</a></td>
          </tr> 
            </ItemTemplate>
         </asp:Repeater>                                                                       
        </table>
        <div class="list_nav">
         <webdiyer:AspNetPager ID="Pager" runat="server" FirstPageText="首页" 
            LastPageText="末页" NextPageText="下一页" PageSize="20" PrevPageText="上一页" ShowPageIndexBox="Never"
            SubmitButtonText="转到" OnPageChanged="Pager_PageChanged" AlwaysShow="True">
        </webdiyer:AspNetPager>
        </div>
      </div>
      
    </div>
       
    </form>
  <uc2:footControl ID="FootControl" runat="server" />
  </div>
</body>
</html>
