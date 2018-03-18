﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="searchTicket.aspx.cs" EnableViewState="false" Inherits="searchTicket" %>
<%@ Register Src="share/searchControl.ascx" TagName="searchControl" TagPrefix="uc2" %>
<%@ Register Src="share/footControl.ascx" TagName="footControl" TagPrefix="uc1" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="all" name="robots" />
<title>国际机票查询-飞瀛网</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<meta name="Description"  content="飞瀛商旅提供最新广州国际机票查询,实时国际航班查询,网上订购系统,提供预定国际机票,国际酒店及东南亚签证服务" />
<meta name="keywords" content="国际机票查询" />
<meta property="og:image" content="http://www.fei580.com/logo.jpg"/>
<link rel="Baidu-Search-icon" sizes="121x75" href="http://www.fei580.com/logo.jpg" />
<link rel="shortcut icon" href="http://www.fei580.com/favicon.ico" />
<link href="http://www.fei580.com/css/main.css" rel="stylesheet" type="text/css" />
<link href="http://www.fei580.com/css/index.css" rel="stylesheet" type="text/css" />
<link href="http://www.fei580.com/css/search.css" rel="stylesheet" type="text/css" />
<link href="http://www.fei580.com/css/hotcity.css" rel="stylesheet" type="text/css" />
<link href="http://www.fei580.com/css/datepicker.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="http://www.fei580.com/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="http://www.fei580.com/ticket/script.js"></script>
<script src="http://www.fei580.com/js/search.js" type="text/javascript"></script>
<script src="http://www.fei580.com/js/postdata.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://www.fei580.com/js/JQuery.cookie.min.js"></script>
<%--<script type="text/javascript" src="http://www.fei580.com/js/ticket.search.js"></script>--%>
    <script src="js/ticket.search.js"></script>
<link href="http://www.fei580.com/CityClient/CitySelector.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://www.fei580.com/CityClient/CityData.js"></script>
<script type="text/javascript" src="http://www.fei580.com/CityClient/CitySelector.min.js"></script>
<link href="http://www.fei580.com/css/ticketorder.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://www.fei580.com/js/jquery.lightbox_me.js"></script>
<script type="text/javascript"  >
    function getRequest(name) {
        var url = location.href;
        var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
        var paraObj = {};
        for (i = 0; j = paraString[i]; i++) {
            paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
        }
        var returnValue = paraObj[name.toLowerCase()];
        return typeof (returnValue) == "undefined" ? "" : returnValue;
    }

    $(function() {
        var hmsr = getRequest("hmsr");
        var medium = getRequest("utm_medium");
        var campaign = getRequest("utm_campaign");
        var keywords = getRequest("utm_content");
        if (hmsr == null || hmsr == "") { hmsr = getRequest("utm_source"); } else { hmsr = getRequest("hmsr"); }
        if (keywords == null || keywords == "") { keywords = "<%=tocityName1%>"; } else { keywords = getRequest("utm_content"); }
        if (medium == null || medium == "") { medium = "PPC"; } else { medium = getRequest("utm_medium"); }
        if (campaign == null || campaign == "") { campaign = getRequest("hmpl"); } else { campaign = getRequest("utm_campaign"); }
        if (hmsr == null || hmsr == "") {
            $("#ochat").attr("href", function(i, origValue) { return origValue + "?utm_source=PageLink&utm_medium=Organic&utm_campaign=LeftSide&utm_content=" + keywords; });
            $("#mchat").attr("href", function(i, origValue) { return origValue + "?utm_source=PageLink&utm_medium=Organic&utm_campaign=LeftSide&utm_content=" + keywords; });
            $("#msn1").attr("href", function(i, origValue) { return origValue + "?utm_source=PageLink&utm_medium=Organic&utm_campaign=LeftSide&utm_content=" + keywords; });
            $("#msn2").attr("href", function(i, origValue) { return origValue + "?utm_source=PageLink&utm_medium=Organic&utm_campaign=LeftSide&utm_content=" + keywords; });
            $("#msn3").attr("href", function(i, origValue) { return origValue + "?utm_source=PageLink&utm_medium=Organic&utm_campaign=LeftSide&utm_content=" + keywords; });
        } else {
            $("#ochat").attr("href", function(i, origValue) { return origValue + "?utm_source=" + hmsr + "&utm_medium=" + medium + "&utm_campaign=" + campaign + "&utm_content=" + keywords; });
            $("#mchat").attr("href", function(i, origValue) { return origValue + "?utm_source=" + hmsr + "&utm_medium=" + medium + "&utm_campaign=" + campaign + "&utm_content=" + keywords; });
            $("#msn1").attr("href", function(i, origValue) { return origValue + "?utm_source=" + hmsr + "&utm_medium=" + medium + "&utm_campaign=" + campaign + "&utm_content=" + keywords; });
            $("#msn2").attr("href", function(i, origValue) { return origValue + "?utm_source=" + hmsr + "&utm_medium=" + medium + "&utm_campaign=" + campaign + "&utm_content=" + keywords; });
            $("#msn3").attr("href", function(i, origValue) { return origValue + "?utm_source=" + hmsr + "&utm_medium=" + medium + "&utm_campaign=" + campaign + "&utm_content=" + keywords; });
        }
    });
    $(document).ready(function() {
        //出发城市
        SetAllSelects.setAllSelectStyle();
        //目的城市
        var dx = new VSxClientCountrySelector('tocityName', CityData);
        dx.Init();
        //日期控件
        TripBackDate(document.getElementById("fromtripDate"), document.getElementById("backtripDate"));
        //日期控件
        TripBackDate(document.getElementById("tripDate"), document.getElementById("backDate"));
    });
</script>
</head>
<body>
<div class="mainbody" >
<form id="form1" runat="server">
<!--header start-->
<div class="headertop"><span><img src="http://www.fei580.com/images/home.jpg" alt="home" /><img src="http://www.fei580.com/images/homeinfor.jpg" alt="mail" />国际、国内机票服务热线：400-885-0663(免费)</span></div>
<div class="headerbottom">
  <div class="headerbottom_left"><a href="http://www.fei580.com/" title="飞瀛网"><img src="http://www.fei580.com/images/logo.jpg" alt="" /></a></div>
  <div class="headerbottom_right">
     <div class="headerbottom_rightone">
    <a href="http://www.fei580.com/login.aspx?url=http://www.fei580.com/searchTicket.aspx" title="会员登录" target="_blank" rel="nofollow">会员登录</a>|<a href="http://www.fei580.com/regAgree.aspx" title="会员注册" target="_blank" rel="nofollow">会员注册</a>|<a href="http://www.fei580.com/sm/" title="飞瀛服务" target="_blank" rel="nofollow">关于飞瀛</a>
    </div>     <ul class="menu_1">
      <li class="four"><a href="http://www.fei580.com/" title="首页" rel="nofollow">首&nbsp;页</a></li>
      <li class="two"><a href="http://www.fei580.com/recommend.aspx" title="特价机票">特价机票</a></li>
      <li class="one"><a href="http://www.fei580.com/international.aspx" title="国际机票">国际机票</a></li>
      <li class="two"><a href="http://www.fei580.com/ticket" title="会员专区" target="_blank">会员专区</a></li>
      <!--<li class="two"><a href="http://cn.fei580.com" title="国内机票" rel="nofollow">国内机票</a></li>-->
      <!--li class="two"><a href="http://www.fei580.com/visa.html" title="国际签证">国际签证</a></li-->
      <li class="two"><a rel="nofollow" href="http://hotel.fei580.com" target="_blank" title="国际酒店">国际酒店</a></li>
      <li class="two"><a href="http://www.fei580.com/quan.aspx" title="飞瀛圈" rel="nofollow">飞瀛圈</a></li>
      <li class="two" style="background:none;"><a href="http://www.fei580.com/yinlian/" target="_blank" title="在线支付方式" rel="nofollow">支付方式</a></li>
      <li class="new_imgs" style="padding:0px;background:none;"><img src="http://www.fei580.com/images/new.gif" alt="" /></li>
    </ul>
    <div class="menubottom">
	    <ul class="nohidden">
	      <li class="two"><a href="http://www.fei580.com/airline.aspx" title="航空公司">航空公司</a></li>
	      <li class="two"><a href="http://www.fei580.com/airport.aspx" title="世界机场">世界机场</a></li>
	      <li class="two"><a href="http://www.fei580.com/airplane.aspx" title="民航机型">民航机型</a></li>
	      <li class="two"><a href="http://www.fei580.com/news.aspx" title="新闻资讯">新闻资讯</a></li>
	      <li class="two"><a href="http://www.fei580.com/prizes.aspx" title="积分广场">积分广场</a></li>
	    </ul>
        <div class="menu_rightinput">
            <input name="SearchControl1$searchkey" type="text" id="SearchControl1_searchkey" onfocus="searchkeyfocus()" onblur="searchkeyblur()" value="搜索旅行攻略" class="headerinput serchcolor" onkeypress="if(event.keyCode==13){document.all.SearchControl1_buttSearch.click();return false;}" />
            <input name="SearchControl1$buttSearch" type="button" id="SearchControl1_buttSearch" class="heaersubmit" onclick="buttSearchNews()" />
        </div>
    </div>
	<div class="header_nav">您现在位置：<a href="http://www.fei580.com/" title="飞瀛网" rel="nofollow">飞瀛网</a>&gt;<a href="http://www.fei580.com/international.aspx" title="国际机票">国际机票查询</a>&gt;&nbsp;机票查询列表</div>
  </div>
</div>
<!--header end-->
  <!-- 爱飞机票计数 -->
  <input type="hidden" id="hidd_aifeinum" name="hidd_aifeinum" value="0" runat="server" />
  <div style="margin:10px auto 0px auto;width:990px; position:relative;">
  <!--searchleft start-->
  <div class="searchside">
   <div class="searchleft">
      <div class="research"></div>
      <div class="searchleftbox">
        <!--hiddenone start-->
        <div id="rightChild1" class="nohidden">
	        <table class="searchlefttable" cellpadding="0" cellspacing="5">
             <tbody><tr>
	            <td height="45" colspan="2" align="center" valign="middle">
	            <input id="tripType1" runat="server" type="radio" name="tripType" style="display:none;" value="2" /><%--全部&nbsp;--%>
	            <input id="tripType2" runat="server" type="radio" name="tripType" value="0" />单程&nbsp;
	            <input id="tripType3" runat="server" type="radio" name="tripType" value="1" />往返
	            </td>
	          </tr>
	          
	          <tr>
	            <th width="70" align="left" valign="middle" >出发地</th>
	            <td width="150" height="30" valign="top">
                <input id="fromCityHidden" type="text" value="广州" runat="server" class="searchl_input2" />
	                <asp:DropDownList ID="fromCity" runat="server" CssClass="select2"></asp:DropDownList>
                </td>
	          </tr>
	          <tr>
	            <th width="70" align="left" valign="middle" >目的地</th>
	            <td width="150" valign="middle">
	                <input type="text" class="searchl_input" runat="server" id="tocityName" />
	            </td>
	          </tr>
	          <tr>
	            <th width="70" align="left" valign="middle" >出发日期</th>
	            <td width="150" valign="middle">
	                <input id="fromtripDate" type="text" class="searchl_input" runat="server" />
	            </td>
	          </tr>
	          <tr>
	            <th width="70" align="left" valign="middle" >回程日期</th>
	            <td width="150" valign="middle">
	                <input id="backtripDate" type="text" class="searchl_input"  runat="server"/>
	            </td>
	          </tr>
	          <tr>
	            <td colspan="2" style="padding-bottom:26px;"><input type="button" id="btnSearch" value="" class="searchmitcss"  /></td>
	          </tr>
	        </tbody></table>
        </div>
        <!--hiddenone end-->
        <script type="text/javascript">
            var ts = TicketSearch();
        </script>
      </div>
      <div class="clear"></div><!-- add by xulingjue 2013-06-07 -->
    </div>
    
    <div id="hotcityDiv" style="position:absolute;z-index:999999; background-color:#f3fbff; display:none;">
	<div class="hotCityBox">
	<div class="close"><img src="http://www.fei580.com/images/i_close3.gif" onclick="closehotcity()" alt="" style="cursor:pointer" /></div>
	<div class="main">
		<div class="continent ">
			<ul>
				<li class="now" onclick="showStateCity(1)" id="state001"><span class="cn"><a href="javascript:void(0)" target="_self">亚洲</a></span><span class="en"><a href="javascript:void(0)" target="_self">Asia</a></span></li>
				<li  onclick="showStateCity(2)" id="state002"><span class="cn"><a href="javascript:void(0)" target="_self">欧洲</a></span><span class="en"><a href="javascript:void(0)" target="_self">Europe</a></span></li>
				<li  onclick="showStateCity(3)" id="state003"><span class="cn"><a href="javascript:void(0)" target="_self">北美</a></span><span class="en"><a href="javascript:void(0)" target="_self">N America</a></span></li>
				<li  onclick="showStateCity(4)" id="state004"><span class="cn"><a href="javascript:void(0)" target="_self">南美</a></span><span class="en"><a href="javascript:void(0)" target="_self">S America</a></span></li>
				<li  onclick="showStateCity(5)" id="state005"><span class="cn"><a href="javascript:void(0)" target="_self">澳洲</a></span><span class="en"><a href="javascript:void(0)" target="_self">Oceania</a></span></li>
				<li  onclick="showStateCity(6)" id="state006"><span class="cn"><a href="javascript:void(0)" target="_self">非洲</a></span><span class="en"><a href="javascript:void(0)" target="_self">Africa</a></span></li>
			</ul>
			<div class="clear"></div>
		</div>
		<div class="citylist" id="citylist001" style="display:block;">
			<ul>
				<li><span class="iName"><a href="javascript:selectCity('新加坡')" target="_self" title="Singapore" rel="nofollow">
                                        <nobr>新加坡</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('曼谷')" target="_self" title="Bangkok" rel="nofollow">
                                        <nobr>曼谷</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('首尔')" target="_self" title="Seoul" rel="nofollow">
                                        <nobr>首尔</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('东京')" target="_self" title="Tokyo" rel="nofollow">
                                        <nobr>东京</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('大阪')" target="_self" title="Osaka" rel="nofollow">
                                        <nobr>大阪</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('吉隆坡')" target="_self" title="Kuala Lumpur" rel="nofollow">
                                        <nobr>吉隆坡</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('雅加达')" target="_self" title="Jakarta" rel="nofollow">
                                        <nobr>雅加达</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('马尼拉')" target="_self" title="Manila" rel="nofollow">
                                        <nobr>马尼拉</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('加德满都')" target="_self" title="Kathmandu" rel="nofollow">
                                        <nobr>加德满都</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('普吉')" target="_self" title="Phuket" rel="nofollow">
                                        <nobr>普吉</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('金边')" target="_self" title="Phnom Penh" rel="nofollow">
                                        <nobr>金边 </nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('迪拜')" target="_self" title="Dubai" rel="nofollow">
                                        <nobr>迪拜</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('河内')" target="_self" title="Hanoi" rel="nofollow">
                                        <nobr>河内</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('胡志明')" target="_self" title="Hu Zhiming" rel="nofollow">
                                        <nobr>胡志明 </nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('巴厘岛')" target="_self" title="Bali Island" rel="nofollow">
                                        <nobr>巴厘岛</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('暹粒')" target="_self" title="Bali" rel="nofollow">
                                        <nobr>暹粒</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('马尔代夫')" target="_self" title="Maldives" rel="nofollow">
                                        <nobr>马尔代夫</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('新德里')" target="_self" title="New Delhi" rel="nofollow">
                                        <nobr>新德里</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('高雄')" target="_self" title="Kaohsiung" rel="nofollow">
                                        <nobr>高雄</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('台北')" target="_self" title="Taipei" rel="nofollow">
                                        <nobr>台北</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('槟城')" target="_self" title="Penang" rel="nofollow">
                                        <nobr>槟城</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('仰光')" target="_self" title="Yangon" rel="nofollow">
                                        <nobr>仰光</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('釜山')" target="_self" title="Busan" rel="nofollow">
                                        <nobr>釜山</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('名古屋')" target="_self" title="Nagoya" rel="nofollow">
                                        <nobr>名古屋</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('札幌')" target="_self" title="Sapporo" rel="nofollow">
                                        <nobr>札幌</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('福冈')" target="_self" title="Fukuoka" rel="nofollow">
                                        <nobr>福冈</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('科伦坡')" target="_self" title="Colombo" rel="nofollow">
                                        <nobr>科伦坡</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('孟买')" target="_self" title="Mumbai" rel="nofollow">
                                        <nobr>孟买</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('沙巴')" target="_self" title="Sabah" rel="nofollow">
                                        <nobr>沙巴</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('清迈')" target="_self" title="Chiang Mai" rel="nofollow">
                                        <nobr>清迈</nobr>
                                    </a></span></li>
			</ul>
		</div>
		<div class="citylist" id="citylist002" style="display:none;">
			<ul>
				<li><span class="iName"><a href="javascript:selectCity('巴黎')" target="_self" title="Paris" rel="nofollow">
                                        <nobr>巴黎</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('伦敦')" target="_self" title="London" rel="nofollow">
                                        <nobr>伦敦</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('法兰克福')" target="_self" title="Frankfurt" rel="nofollow">
                                        <nobr>法兰克福</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('罗马')" target="_self" title="Rome" rel="nofollow">
                                        <nobr>罗马</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('米兰')" target="_self" title="Milan" rel="nofollow">
                                        <nobr>米兰</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('莫斯科')" target="_self" title="Moscow" rel="nofollow">
                                        <nobr>莫斯科</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('阿姆斯特丹')" target="_self" title="Amsterdam" rel="nofollow">
                                        <nobr>阿姆斯特丹</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('柏林')" target="_self" title="Berlin" rel="nofollow">
                                        <nobr>柏林</nobr>
                                    </a></span></li> 
									<li><span class="iName"><a href="javascript:selectCity('伯明翰')" target="_self" title="Bermingham" rel="nofollow">
                                        <nobr>伯明翰</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('马德里')" target="_self" title="Madrid" rel="nofollow">
                                        <nobr>马德里</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('里昂')" target="_self" title="Leon" rel="nofollow">
                                        <nobr>里昂</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('雅典')" target="_self" title="Athens" rel="nofollow">
                                        <nobr>雅典</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('慕尼黑')" target="_self" title="Munich" rel="nofollow">
                                        <nobr>慕尼黑 </nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('苏黎世')" target="_self" title="Zurich" rel="nofollow">
                                        <nobr>苏黎世</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('哥本哈根')" target="_self" title="Copenhagen" rel="nofollow">
                                        <nobr>哥本哈根</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('赫尔辛基')" target="_self" title="Helsinki" rel="nofollow">
                                        <nobr>赫尔辛基</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('维也纳')" target="_self" title="Vienna" rel="nofollow">
                                        <nobr>维也纳</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('日内瓦')" target="_self" title="Geneva'" rel="nofollow">
                                        <nobr>日内瓦</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('爱丁堡')" target="_self" title="Edinburgh" rel="nofollow">
                                        <nobr>爱丁堡</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('布拉格')" target="_self" title="Prague" rel="nofollow">
                                        <nobr>布拉格</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('巴塞罗那')" target="_self" title="Barcelona" rel="nofollow">
                                        <nobr>巴塞罗那</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('斯德哥尔摩')" target="_self" title="Stockholm" rel="nofollow">
                                        <nobr>斯德哥尔摩</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('布达佩斯')" target="_self" title="Budapest" rel="nofollow">
                                        <nobr>布达佩斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('曼彻斯特')" target="_self" title="Manchester" rel="nofollow">
                                        <nobr>曼彻斯特</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('里斯本')" target="_self" title="Lisbon" rel="nofollow">
                                        <nobr>里斯本</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('威尼斯')" target="_self" title="Venice" rel="nofollow">
                                        <nobr>威尼斯</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('伊斯坦布尔')" target="_self" title="Istanbul" rel="nofollow">
                                        <nobr>伊斯坦布尔</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('格拉斯哥')" target="_self" title="Glasgow" rel="nofollow">
                                        <nobr>格拉斯哥</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('都柏林')" target="_self" title="Dublin" rel="nofollow">
                                        <nobr>都柏林</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('圣彼得堡')" target="_self" title="St Petersburg" rel="nofollow">
                                        <nobr>圣彼得堡</nobr>
                                    </a></span></li>
				</ul>
		</div>
		<div class="citylist" id="citylist003" style="display:none;">
			<ul>
				<li><span class="iName"><a href="javascript:selectCity('多伦多')" target="_self" title="Toronto" rel="nofollow">
                                        <nobr>多伦多</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('温哥华')" target="_self" title="Vancouver" rel="nofollow">
                                        <nobr>温哥华</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('纽约')" target="_self" title="New York" rel="nofollow">
                                        <nobr>纽约</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('洛杉矶')" target="_self" title="Losangeles" rel="nofollow">
                                        <nobr>洛杉矶</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('三藩市（旧金山）')" target="_self" title="San Francisco" rel="nofollow">
                                        <nobr>三藩市</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('芝加哥')" target="_self" title="Chicago" rel="nofollow">
                                        <nobr>芝加哥</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('波士顿')" target="_self" title="Boston" rel="nofollow">
                                        <nobr>波士顿</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('华盛顿')" target="_self" title="Washington" rel="nofollow">
                                        <nobr>华盛顿</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('西雅图')" target="_self" title="Seattle" rel="nofollow">
                                        <nobr>西雅图</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('蒙特利尔')" target="_self" title="Montreal" rel="nofollow">
                                        <nobr>蒙特利尔</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('亚特兰大')" target="_self" title="Atlanta" rel="nofollow">
                                        <nobr>亚特兰大 </nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('休斯顿')" target="_self" title="Houston" rel="nofollow">
                                        <nobr>休斯顿</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('底特律')" target="_self" title="Detroit" rel="nofollow">
                                        <nobr>底特律</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('夏威夷')" target="_self" title="Hawaii" rel="nofollow">
                                        <nobr>夏威夷</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('拉斯维加斯')" target="_self" title="Las Vegas" rel="nofollow">
                                        <nobr>拉斯维加斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('达拉斯')" target="_self" title="Dallas" rel="nofollow">
                                        <nobr>达拉斯</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('墨西哥城')" target="_self" title="Mexico" rel="nofollow">
                                        <nobr>墨西哥城</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('费城')" target="_self" title="Philadelphia" rel="nofollow">
                                        <nobr>费城</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('渥太华')" target="_self" title="Ottawa" rel="nofollow">
                                        <nobr>渥太华</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('迈阿密')" target="_self" title="Miami" rel="nofollow">
                                        <nobr>迈阿密</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('奥兰多')" target="_self" title="Orlando" rel="nofollow">
                                        <nobr>奥兰多</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('丹佛')" target="_self" title="Denver" rel="nofollow">
                                        <nobr>丹佛</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('塞班')" target="_self" title="Saipan" rel="nofollow">
                                        <nobr>塞班</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('埃德蒙顿')" target="_self" title="Edmonton" rel="nofollow">
                                        <nobr>埃德蒙顿</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('匹兹堡')" target="_self" title="Pittsburgh" rel="nofollow">
                                        <nobr>匹兹堡</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('明尼阿波利斯')" target="_self" title="Minneapolis" rel="nofollow">
                                        <nobr>明尼阿波利斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('卡尔加里')" target="_self" title="Calgary" rel="nofollow">
                                        <nobr>卡尔加里</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('圣路易斯')" target="_self" title="Saint Louis" rel="nofollow">
                                        <nobr>圣路易斯</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('温尼伯')" target="_self" title="Winnipeg" rel="nofollow">
                                        <nobr>温尼伯</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('盐湖城')" target="_self" title="Saline Lake" rel="nofollow">
                                        <nobr>盐湖城</nobr>
                                    </a></span></li>
			</ul>
		</div>
		<div class="citylist" id="citylist004" style="display:none;">
			<ul>
				
									<li><span class="iName"><a href="javascript:selectCity('圣保罗')" target="_self" title="St Paul" rel="nofollow">
                                        <nobr>圣保罗</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('布宜诺斯艾利斯')" target="_self" title="Buenos Aires" rel="nofollow">
                                        <nobr>布宜诺斯艾利斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('里约热内卢')" target="_self" title="Rio De Janeiro" rel="nofollow">
                                        <nobr>里约热内卢</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('哈瓦那')" target="_self" title="Havana" rel="nofollow">
                                        <nobr>哈瓦那</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('利马')" target="_self" title="Lima" rel="nofollow">
                                        <nobr>利马</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('圣地亚哥')" target="_self" title="Santiago" rel="nofollow">
                                        <nobr>圣地亚哥</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('加拉加斯')" target="_self" title="Caracas" rel="nofollow">
                                        <nobr>加拉加斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('波哥大')" target="_self" title="Bogota" rel="nofollow">
                                        <nobr>波哥大</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('巴西利亚')" target="_self" title="Brasilia" rel="nofollow">
                                        <nobr>巴西利亚</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('巴拿马')" target="_self" title="Panama" rel="nofollow">
                                        <nobr>巴拿马</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('基多')" target="_self" title="Quito" rel="nofollow">
                                        <nobr>基多 </nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('拉巴斯')" target="_self" title="La Paz" rel="nofollow">
                                        <nobr>拉巴斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('圣何塞')" target="_self" title="San Jose" rel="nofollow">
                                        <nobr>圣何塞</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('蒙得维的亚')" target="_self" title="Montevideo" rel="nofollow">
                                        <nobr>蒙得维的亚</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('瓜亚基尔')" target="_self" title="Guayaquil" rel="nofollow">
                                        <nobr>瓜亚基尔</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('麦德林')" target="_self" title="Medellin" rel="nofollow">
                                        <nobr>麦德林</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('帕拉马里博')" target="_self" title="Paramaribo" rel="nofollow">
                                        <nobr>帕拉马里博</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('瓜达拉哈拉')" target="_self" title="Hanoi" rel="nofollow">
                                        <nobr>瓜达拉哈拉</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('马纳瓜')" target="_self" title="Managua" rel="nofollow">
                                        <nobr>马纳瓜</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('马瑙斯')" target="_self" title="Manaus" rel="nofollow">
                                        <nobr>马瑙斯</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('太子港')" target="_self" title="Port au Prince" rel="nofollow">
                                        <nobr>太子港</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('危地马拉')" target="_self" title="Guatemala" rel="nofollow">
                                        <nobr>危地马拉</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('坎昆')" target="_self" title="Cancun" rel="nofollow">
                                        <nobr>坎昆</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('纳塔尔')" target="_self" title="Natal" rel="nofollow">
                                        <nobr>纳塔尔</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('亚松森')" target="_self" title="Asuncion" rel="nofollow">
                                        <nobr>亚松森</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('圣萨尔瓦多')" target="_self" title="San Salvador" rel="nofollow">
                                        <nobr>圣萨尔瓦多</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('苏克雷')" target="_self" title="Su Kelei" rel="nofollow">
                                        <nobr>苏克雷</nobr>
                                    </a></span></li> 
                                    <li><span class="iName"><a href="javascript:selectCity('库里提巴')" target="_self" title="Curitiba " rel="nofollow">
                                        <nobr>库里提巴</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('德古斯加巴')" target="_self" title="De Gus Gaba" rel="nofollow">
                                        <nobr>德古斯加巴</nobr>
                                    </a></span></li>
			</ul>
		</div>
		<div class="citylist" id="citylist005" style="display:none;">
			<ul>
				<li><span class="iName"><a href="javascript:selectCity('悉尼')" target="_self" title="Sydney" rel="nofollow">
                                        <nobr>悉尼</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('墨尔本')" target="_self" title="Melbourne" rel="nofollow">
                                        <nobr>墨尔本</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('奥克兰')" target="_self" title="Oakland" rel="nofollow">
                                        <nobr>奥克兰</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('布里斯班')" target="_self" title="Brisbane" rel="nofollow">
                                        <nobr>布里斯班</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('阿德莱德')" target="_self" title="Adelaide" rel="nofollow">
                                        <nobr>阿德莱德</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('珀斯')" target="_self" title="Perth" rel="nofollow">
                                        <nobr>珀斯</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('斐济')" target="_self" title="Fiji" rel="nofollow">
                                        <nobr>斐济</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('惠灵顿')" target="_self" title="Wellington" rel="nofollow">
                                        <nobr>惠灵顿</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('基督城')" target="_self" title="Christian City" rel="nofollow">
                                        <nobr>基督城</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('关岛')" target="_self" title="Guam" rel="nofollow">
                                        <nobr>关岛</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('堪培拉')" target="_self" title="Canberra" rel="nofollow">
                                        <nobr>堪培拉</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('凯恩斯')" target="_self" title="Keynes" rel="nofollow">
                                        <nobr>凯恩斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('黄金海岸')" target="_self" title="Gold Coast" rel="nofollow">
                                        <nobr>黄金海岸 </nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('达尔文')" target="_self" title="Darwin" rel="nofollow">
                                        <nobr>达尔文</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('莫尔兹比港')" target="_self" title="Port Moresby" rel="nofollow">
                                        <nobr>莫尔兹比港</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('皇后镇')" target="_self" title="Queen town" rel="nofollow">
                                        <nobr>皇后镇</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('达尼丁')" target="_self" title="Dunedin" rel="nofollow">
                                        <nobr>达尼丁</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('霍巴特')" target="_self" title="Hobart" rel="nofollow">
                                        <nobr>霍巴特</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('维拉港')" target="_self" title="Port Vila" rel="nofollow">
                                        <nobr>维拉港</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('朗塞斯顿')" target="_self" title="Ron Seth Don" rel="nofollow">
                                        <nobr>朗塞斯顿</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('努美阿')" target="_self" title="Noumea" rel="nofollow">
                                        <nobr>努美阿</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('黑德兰港')" target="_self" title="Port Hedland" rel="nofollow">
                                        <nobr>黑德兰港</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('帝力')" target="_self" title="Dili" rel="nofollow">
                                        <nobr>帝力</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('努库阿洛法')" target="_self" title="Nukualofa" rel="nofollow">
                                        <nobr>努库阿洛法</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('汤斯维尔')" target="_self" title="Townsville" rel="nofollow">
                                        <nobr>汤斯维尔</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('阳光海岸')" target="_self" title="Sunshine Coast" rel="nofollow">
                                        <nobr>阳光海岸</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('阿洛菲')" target="_self" title="Alof" rel="nofollow">
                                        <nobr>阿洛菲</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('奥班尼')" target="_self" title="Albany" rel="nofollow">
                                        <nobr>奥班尼</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('赫维湾')" target="_self" title="Hervey Bay" rel="nofollow">
                                        <nobr>赫维湾</nobr>
                                    </a></span></li>
			</ul>
		</div>
		<div class="citylist" id="citylist006" style="display:none;">
			<ul>
				<li><span class="iName"><a href="javascript:selectCity('开罗')" target="_self" title="Cairo" rel="nofollow">
                                        <nobr>开罗</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('内罗毕')" target="_self" title="Nairobi" rel="nofollow">
                                        <nobr>内罗毕</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('约翰内斯堡')" target="_self" title="Johannesburg" rel="nofollow">
                                        <nobr>约翰内斯堡</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('毛里求斯')" target="_self" title="Mauritius" rel="nofollow">
                                        <nobr>毛里求斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('开普敦')" target="_self" title="Cape Town" rel="nofollow">
                                        <nobr>开普敦</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('亚的斯亚贝巴')" target="_self" title="Addisababa" rel="nofollow">
                                        <nobr>亚的斯亚贝巴</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('拉各斯')" target="_self" title="Lagos" rel="nofollow">
                                        <nobr>拉各斯</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('罗安达')" target="_self" title="Luanda" rel="nofollow">
                                        <nobr>罗安达 </nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('阿克拉')" target="_self" title="Accra" rel="nofollow">
                                        <nobr>阿克拉</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('达累斯萨拉姆')" target="_self" title="Dar Es Salaam" rel="nofollow">
                                        <nobr>达累斯萨拉姆</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('卢萨卡')" target="_self" title="Lusaka" rel="nofollow">
                                        <nobr>卢萨卡</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('安塔那那利佛')" target="_self" title="Antananarivo" rel="nofollow">
                                        <nobr>安塔那那利佛</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('阿尔及尔')" target="_self" title="Algiers" rel="nofollow">
                                        <nobr>阿尔及尔</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('阿布贾')" target="_self" title="Abuja" rel="nofollow">
                                        <nobr>阿布贾</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('卡萨布兰卡')" target="_self" title="Casablanca" rel="nofollow">
                                        <nobr>卡萨布兰卡</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('马普托')" target="_self" title="Maputo" rel="nofollow">
                                        <nobr>马普托</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('金沙萨')" target="_self" title="Kinshasa" rel="nofollow">
                                        <nobr>金沙萨</nobr>
                                    </a></span></li> 
									<li><span class="iName"><a href="javascript:selectCity('雅温得')" target="_self" title="Yaounde" rel="nofollow">
                                        <nobr>雅温得</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('哈拉雷')" target="_self" title="Harare" rel="nofollow">
                                        <nobr>哈拉雷</nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('喀土穆')" target="_self" title="Khartoum" rel="nofollow">
                                        <nobr>喀土穆 </nobr>
                                    </a></span></li>
									<li><span class="iName"><a href="javascript:selectCity('杜阿拉')" target="_self" title="Douala" rel="nofollow">
                                        <nobr>杜阿拉</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('的黎波里')" target="_self" title="Tripoli" rel="nofollow">
                                        <nobr>的黎波里</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('蒙罗维亚')" target="_self" title="Monrovia" rel="nofollow">
                                        <nobr>蒙罗维亚</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('洛美')" target="_self" title="Lome" rel="nofollow">
                                        <nobr>洛美</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('突尼斯')" target="_self" title="Tunisia" rel="nofollow">
                                        <nobr>突尼斯</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('巴马科')" target="_self" title="Bamako" rel="nofollow">
                                        <nobr>巴马科</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('马拉博')" target="_self" title="Malabo" rel="nofollow">
                                        <nobr>马拉博</nobr>
                                    </a></span></li> 
                                    <li><span class="iName"><a href="javascript:selectCity('达喀尔')" target="_self" title="Dakar" rel="nofollow">
                                        <nobr>达喀尔</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('坎帕拉')" target="_self" title="Kampala" rel="nofollow">
                                        <nobr>坎帕拉</nobr>
                                    </a></span></li>
                                    <li><span class="iName"><a href="javascript:selectCity('科托努')" target="_self" title="Cotonou" rel="nofollow">
                                        <nobr>科托努</nobr>
                                    </a></span></li> 
				</ul>
		</div>
	</div>
</div>
</div>
   
    <!--other plan-->
    <div class="otherfly">
     <div class="flytitle">共有 <b style="font-size:16px;color:#F60;"><asp:Label ID="rptAirlinesCount" runat="server" Text=""></asp:Label></b> 家航空公司</div>
     <div class="otherflybox">
      <ul class="otherfly_box">
	    <asp:Repeater ID="rptAirlines" runat="server">
           <ItemTemplate>
              <li <%#((kabe_Airline)Container.DataItem).airlineId.Trim()==airlineId.ToString()?"style=\"background:#eee;\"":""%> ><img src="<%#((kabe_Airline)Container.DataItem).airlinePic.Trim()%>" class="flyico" alt="<%#((kabe_Airline)Container.DataItem).airlineName.Trim()%>" />
              <a href="http://www.fei580.com/searchTicket.aspx?airlineId=<%#((kabe_Airline)Container.DataItem).airlineId.Trim()%>&fromCity=<%=Server.UrlEncode(Request.QueryString["fromCity"].ToString())%>&tocityName=<%=Server.UrlEncode(Request.QueryString["tocityName"].ToString())%>&tripType=<%=Request.QueryString["tripType"].ToString()%>&tripDate=<%=Request.QueryString["tripDate"].ToString()%>&backDate=<%=Request.QueryString["backDate"].ToString()%>">
                <span class="flyname"><%#((kabe_Airline)Container.DataItem).airlineName.Trim()%></span>
              </a>
              </li>
	       </ItemTemplate>
        </asp:Repeater>
	  </ul>
     </div>
    </div>
    <!--other plan end-->
    <div class="clear"></div>
    <!---->
    <div class="searcblock"></div>
    <div class="searchlids">
     <div class="searchidst">
     <img src="http://www.fei580.com/images/searchleftids.gif" />
     </div>
     <div class="searchidsp">了解<b style="color:#09F"><%=fromcityName %>-<%=tocityName1%></b>价格分析</div>
    </div>
    </div>
  <!--searchleft end-->
  <!--searchright start-->
  <div class="searchresult">
  <div class="searchrtitle"><strong>[<asp:Label ID="tripTypeNameLabel" runat="server" Text=""></asp:Label>] <span id="fromCityNameLabel"><%=fromcityName %></span>&nbsp;--&nbsp;<span id="toCityNameLabel"><%=tocityName1%></span></strong></div>
  <div class="searchrnav">&nbsp;&nbsp;</div>
   <div class="clear"></div>
   <ul class="searchrtag">
      
       <%
       for (int i = 0; i < fromcitylist.Count; i++)
        {%>
         <%
       System.Data.DataRow citylist_row = fromcitylist[i];

       if (fromcity.ToString() == citylist_row["fId"].ToString())
       {     
        %>
	   <li class="one" id="Li1"><a href="javascript:void(0);"><%=citylist_row["chName"]%>出发</a></li>
	   <% }
       else
       {%>
	   <li class="two"><a href="javascript:SearchTicketByFromCity('<%=citylist_row["fId"]%>');"><%=citylist_row["chName"]%>出发</a></li>
	 
       <%
             }
       }%>
<script type="text/javascript">
    function showmoreCity() {
        var obj = document.getElementById("moreCity");
        if (obj.style.display == 'none')
            obj.style.display = 'block';
        else if (obj.style.display == 'block')
            obj.style.display = 'none';
    }
</script>
       
       <li class="two" id="moreSelect"><a href="javascript:showmoreCity();">更多出发地</a></li>
	</ul>
    <div class="clear"></div>
    <ul id="moreCity" class="flymore" style="display:none;">
<%
           for (int i = 0; i < morefromcitylist.Count; i++)
        {%>
        <%
         System.Data.DataRow morefromcitylist_row = morefromcitylist[i];

        if (fromCity.SelectedValue == morefromcitylist_row["fId"].ToString())
       {     
        %>
	   <a href="javascript:void(0);"><b><%=morefromcitylist_row["chName"]%>出发</b></a> 
	   <% }
       else
       {%>
	  <a href="javascript:SearchTicketByFromCity('<%=morefromcitylist_row["fId"]%>');"><%=morefromcitylist_row["chName"]%>出发</a> 
        <%
          }
        }%>
    </ul>
    <div class="clear"></div>
    <div class="searchrdiv">
		  <code>出发日期：<asp:Label ID="tripDateLabel" runat="server" Text=""></asp:Label>&nbsp;&nbsp;返回日期：<asp:Label ID="backDateLabel" runat="server" Text=""></asp:Label></code>
		  <div style=" float:right; width:195px;height:30px;"><a href="http://www.fei580.com/searchTicket.aspx?fromcity=<%=Request.QueryString["fromcity"].ToString()%>&tocityName=<%=Server.UrlEncode(Request.QueryString["tocityName"].ToString())%>&tripType=<%=Request.QueryString["tripType"].ToString()%>&tripDate=<%=Request.QueryString["tripDate"].ToString()%>&backDate=<%=Request.QueryString["backDate"].ToString()%>&orderStr=airLine" title="" class="slink_a">按航司排序</a><a href="http://www.fei580.com/searchTicket.aspx?fromcity=<%=Request.QueryString["fromcity"].ToString()%>&tocityName=<%=Server.UrlEncode(Request.QueryString["tocityName"].ToString())%>&tripType=<%=Request.QueryString["tripType"].ToString()%>&tripDate=<%=Request.QueryString["tripDate"].ToString()%>&backDate=<%=Request.QueryString["backDate"].ToString()%>" title="" class="slink_a">按价格排序</a></div>
		  
	 </div>
     <div class="clear"></div>
     
     <asp:Panel ID="panNoValue" runat="server" Visible="false" >  
    		<div style="width:745px; overflow:hidden; margin-top:15px;float:left;-webkit-border-radius: 5px;-moz-border-radius: 5px;border-radius: 5px;background:#c8f4ff url(http://www.fei580.com/images/bg2.jpg) no-repeat;">
            <table class="errmes">
              <tr>
                <td width="130px">&nbsp;</td>
                <td width="228"><div class="errtxt1" ><font class="errF1">搜索不到，不代表没有哦！</font><font class="errF2">(我们提供全球每一个城市的机票。)</font><br>
            <font class="errF1">您查询的航线可能涉及多段航程接驳，需要客服设计行程。</font></div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>
            	
	            <table width="100%" border="0">
              <tr>
                <td width="400px"><div class="errtxt4"><font class="errF1">请通过免费热线进行查询：</font></div></td>
                <td><a href="tencent://message/?uin=32335510&amp;Site=111&amp;Menu=yes"><img src="images/qq.jpg"></a></td>
              </tr>
              <tr>
                <td><div  class="errtxt2"><font class="errF3">400-885-0663</font></div></td>
                <td><a href="http://www.fei580.com/chat.html" target="_blank"><img src="http://www.fei580.com/images/msn.jpg"></a></td>
              </tr>
            </table>

            </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><div class="errtxt3" >
	            <font class="errF4">您还可以留下电话，客服马上与您联系</font><br>
	            <font class="errF4">
                <input style="margin-top:18px; margin-left:0px;float:left;" id="eMsg_tel" name="kw" type="text" /> <a href="javascript:void(0)" onclick="sendTelMsg();" ><img  style="margin-left:20px; margin-top:12px;float:left;" src="http://www.fei580.com/images/btn.jpg"></a></font>
                </div></td>
              </tr>
            </table>
		    </div>
      </asp:Panel>
      
     <asp:Panel ID="panLoading" runat="server" Visible="false" >  
         <div id="myads"class="searchlist">
            <p style="text-align:center;line-height:30px;"><img src="http://www.fei580.com/images/searchloading.gif" width="200" height="25" /></p>
            <p style="text-align:center;font-size:16px;font-weight:600;line-height:30px;">以穿梭机的速度为你查询，请稍候……</p>
         </div>
         <script type="text/javascript">
             $.ajax({
                 type: "get", cache: false, url: document.location.href + "&Loading=true", success: function (data) {
                 var obj = $(data);
                 var list = obj.find('.searchresult').html();
                 $('.searchresult').html(list);

                 var otherfly = obj.find('.otherfly').html();
                 $('.otherfly').html(otherfly);

                 obj.find('.scriptdiv').each(function() {
                     eval(this.innerHTML);
                 });
             },
                 error: function() {
                     return;
                 }
             });
         </script>
     </asp:Panel>
      
     <asp:Panel ID="panHaveValue1" runat="server">
     <% 
         foreach (kabe_flight flight in pageTickets)
         {
             %>
             
               <div class="searchlist">
                    <div class="flynav">
                     <ul>
                      <li style="width:120px;float:left;"><%=fromcityName%>-<%=tocityName1%></li>
                      <li style="width:40px;float:left;"><%=(flight.ft == "2") ? "往返" : "单程"%></li>
                     </ul>
                    </div>
                    <div class="table">
                    <div class="clearl"></div>
                    <table cellpadding="0" cellspacing="0" class="searchlisttable"> 
	                    <tr>
	                        <td width="100" align="center">
                                <ul>
                                    <%=display_airline(flight.airline)%>
                                 <li class="lititle2">
                                 
                                 
                                <%
                                    string fz = string.Empty;
                                    if (flight.source == "kabe")
                                    {
                                        if (flight.ft == "2")
                                        {
                                            fz = ((flight.deproute.route.Split('-').Length > 1) ? "中转" : "直飞") + "/" + ((flight.arrroute.route.Split('-').Length > 1) ? "中转" : "直飞");
                                        }
                                        else
                                        {
                                            fz = (flight.deproute.route.Split('-').Length > 1) ? "中转" : "直飞";
                                        }
                                    }
                                    else
                                    {
                                        fz = string.IsNullOrEmpty(flight.relayPort) ? "直飞" : "中转";
                                    } %>
                                <% = fz %>
                                 </li>
                                </ul>
                            </td>
                            
		                     <td width="150">
                                <ul>
                                <%
                                string seat = "-";
                                string deptime = string.Empty;
                                string arrtime = string.Empty;
                                if (flight.source == "kabe")
                                  {%>
                                    <% if (flight.ft == "2")
                                       {%>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.depport)%></li><li class="lititle2">起飞：<% = flight.deproute.depdate + " " + flight.deproute.deptime.Insert(2, ":")%></li>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.arrport)%></li><li class="lititle2">起飞：<% = flight.arrroute.depdate + " " + flight.arrroute.deptime.Insert(2, ":")%></li>
                                    <%}
                                       else
                                       { %>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.depport)%></li><li class="lititle2">起飞：<% = flight.deproute.depdate + " " + flight.deproute.deptime.Insert(2, ":")%></li>
                                    <%} deptime = flight.deproute.depdate + " " + flight.deproute.deptime.Insert(2, ":"); 
                                        seat = display_seat(flight.deproute.seat);
                                    %>
                                   
                                <%}
                                  else
                                  { %>
                                    <% if (flight.ft == "2")
                                       {%>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.depport)%></li><li class="lititle2">起飞：<%=readTimeFromCookie("from", flight.depport, flight.arrport, flight.airline, "toDt", this.tripDate, flight.ft, 1)%></li>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.arrport)%></li><li class="lititle2">起飞：<%=readTimeFromCookie("from", flight.arrport, flight.depport, flight.airline, "toDt", this.backDate, flight.ft, 3)%></li>
                                    <%}
                                       else
                                       { %>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.depport)%></li><li class="lititle2">起飞：<%=readTimeFromCookie("from", flight.depport, flight.arrport, flight.airline, "toDt", this.tripDate, flight.ft, 1)%></li>
                                    <%} deptime = readTimeFromCookie("from", flight.depport, flight.arrport, flight.airline, "toDt", this.tripDate, flight.ft, 1);%>
                                    
                                <%} %>
                                
                                </ul>
                            </td>
		                    <td width="30">
                                <ul>
                                    <% if (flight.ft == "2")
                                       {%>
                                    <li class="lititle1"><img src="http://www.fei580.com/images/sgo.gif"/>&rarr;</li><li class="lititle2">&nbsp;</li>
                                    <li class="lititle1"><img src="http://www.fei580.com/images/sback.gif"/>&rarr;</li><li class="lititle2">&nbsp;</li>
                                    <%}
                                       else
                                       { %>
                                    <li class="lititle1"><img src="http://www.fei580.com/images/sgo.gif"/>&rarr;</li><li class="lititle2">&nbsp;</li>
                                    <%} %>
                                </ul>
                            </td>
		                    <td width="150">
                                <ul>
                                <%if (flight.source == "kabe")
                                  {%>
                                    <% if (flight.ft == "2")
                                       {%>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.arrport)%></li><li class="lititle2">到达：<% = flight.deproute.arrdate + " " + flight.deproute.arrtime.Insert(2, ":")%></li>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.depport)%></li><li class="lititle2">到达：<% = flight.arrroute.arrdate + " " + flight.arrroute.arrtime.Insert(2, ":")%></li>
                                    <%}
                                       else
                                       { %>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.arrport)%></li><li class="lititle2">到达：<% = flight.deproute.arrdate + " " + flight.deproute.arrtime.Insert(2, ":")%></li>
                                    <%}
                                       arrtime = flight.deproute.arrdate + " " + flight.deproute.arrtime.Insert(2, ":");%>
                                <%}
                                  else
                                  { %>
                                    <% if (flight.ft == "2")
                                       {%>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.arrport)%></li><li class="lititle2">到达：<%=readTimeFromCookie("to", flight.depport, flight.arrport, flight.airline, "arriveDt", this.tripDate, flight.ft, 2)%></li>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.depport)%></li><li class="lititle2">到达：<%=readTimeFromCookie("to", flight.depport, flight.arrport, flight.airline, "arriveDt", this.backDate, flight.ft, 4)%></li>
                                    <%}
                                       else
                                       { %>
                                    <li class="lititle1"><%= ReadXmlHelper.GetAirPortNameByCode(flight.arrport)%></li><li class="lititle2">到达：<%=readTimeFromCookie("to", flight.depport, flight.arrport, flight.airline, "arriveDt", this.tripDate, flight.ft, 2)%></li>
                                    <%}
                                      arrtime = readTimeFromCookie("to", flight.depport, flight.arrport, flight.airline, "arriveDt", this.tripDate, flight.ft, 2);
                                       %>
                                <%} %>
                                </ul>
                            </td>
                            
		                    <td width="50"
                            <ul>
                                 <li class="lititle3">票价</li>
                                 <li class="lititle2"><!--(不含税)-->&nbsp;</li>
                                 <li class="lititle3">机型</li>
                                 <li class="lititle1">&nbsp;</li>
                            </ul>
                            </td>
		                    <td width="80">
                            <ul>
                                 <li class="price">￥<%=flight.adultprice%></li>
                                 <!--机位有限-->
                                 <li class="jiwei"><%= printJpjz(flight)%></li>
                                 <li class="lititle4">
                                <% string plan = display_plan(flight.segment,flight.source);%> 
                                     <% = plan %>
                                 </li>
                                 <li class="lititle1">&nbsp;</li>
                            </ul>
                            </td>
		                    <td width="80">
                            <ul>
                                <%if (flight.source == "kabe")
                                  {%>
                                   <li><a href="http://www.fei580.com/ticket_kabe_<%=this.tripType %>_<%=fromcityCode %>_<%=tocityCode %>_<%=Convert.ToDateTime(this.tripDate).ToString("yyyyMMdd") %>_<%=Convert.ToDateTime(this.backDate).ToString("yyyyMMdd") %>_<%=flight.ticketId %>.htm" target="_blank" rel="nofollow"><img src="http://www.fei580.com/images/hbinfoimg.gif" /></a></li>
                                  <%}
                                  else
                                  { %>
                                   <li><a href="http://localhost:6493/ticket_<%=flight.ticketId %>.htm" target="_blank" rel="nofollow"><img src="http://www.fei580.com/images/hbinfoimg.gif" /></a></li>
                                  <%} %>
                             <li>
                             <%--<a  href="http://www.fei580.com/chat.html" target="_blank" title="咨询客服" rel="nofollow"><img src="http://www.fei580.com/images/chatnowimg.gif" /></a>--%>
                             <a id="orderbox" href="javascript:void(0);" onclick="_hmt.push(['_trackPageview', 'http://www.fei580.com/virtual/orderbox']);_czc.push(['_trackEvent', '查询列表预订','预订','点击']);showorderbox(<%=flight.adultprice%>,'<%=display_orderboxairline(flight.airline)%>','<%= ReadXmlHelper.GetAirPortNameByCode(flight.depport)%>','<% = fz %>','<%= ReadXmlHelper.GetAirPortNameByCode(flight.arrport)%>',<%=flight.ft %>,'<%=deptime %>','<%=arrtime %>','<%=plan %>','<%=seat %>');"  title="咨询客服" rel="nofollow"><img src="http://www.fei580.com/images/chatnowimg.gif" /></a>
                             </li>
                             <li>&nbsp;</li>
                            </ul>
                            </td>
	                    </tr>
	                </table>   
                    </div>
               </div>
      <% }%> 
      </asp:Panel>
      <div class="search_threeboxbottom"> 
	    <asp:Panel ID="panHaveValue2" runat="server"> 	
	     <webdiyer:AspNetPager ID="Pager"  UrlPaging="true"  runat="server" FirstPageText="首页" CssClass="paginator" CurrentPageButtonClass="cpb" HorizontalAlign="Center" LastPageText="末页" NextPageText="下一页" PageSize="12" PrevPageText="上一页" ShowPageIndexBox="Always" SubmitButtonText="转到" OnPageChanged="Pager_PageChanged" AlwaysShow="True"></webdiyer:AspNetPager>
             </asp:Panel> 
      </div> 
  </div>
  <!--searchright end-->
  </div>
  <div class="clear"></div>
  <!--sixlinebox start-->
<div class="clear"></div>

<div id="duilianb02" style="top:220px; display:none;">
    <div  id="tipbi1" style="width:242px;display:none;">
        <div class="dubi_boxtitle"><a href="javascript:showCompare('tipbi1')">收回&gt;&gt;</a></div>
        <div class="dubi_boxtwo">
	        <ul id="compareList"></ul>
	        <p><input type="button" value="比较机票" onclick="window.open('http://www.fei580.com/contrast.aspx')" /> </p>
	    </div>
    </div>

    <div class="dubi_box" id="compareBut"><a href="javascript:showCompare('tipbi1')">&nbsp;</a><input onclick='closeCompareBut()' type="button" alt="" /></div>
    <script type="text/javascript">Compare_show();</script>
</div>
<uc1:footControl ID="FootControl" runat="server" />
</form>
</div>
<div class="clear"></div>
    <div id="duilian02" style="top: 250px; left: 0px;" class="kf_2012_box">
        <div class="kf_2012_lbox">
            <img src="http://www.fei580.com/images/kf_l.gif" border="0" usemap="#Map3" />
            <map name="Map3" id="map4">
                <area style="cursor: pointer;" onclick='show(1)' shape="rect" coords="4,12,26,101" href="javascript:void(0);" />
                <area style="cursor: pointer;" onclick='show(2)' shape="rect" coords="3,110,26,201" href="javascript:void(0);" />
            </map>
        </div>
        <div id="tip4341" class="kf_2012_rbox1" style="display: block;">
            <img src="http://www.fei580.com/images/kf_r1.gif" border="0" usemap="#Map" />
            <input id="eMsg_tel" type="text" class="kf_2012_input" />
            <map name="Map" id="map5">
                <area shape="rect" style="cursor: pointer;" coords="237,5,267,31" onclick='show("tip4341")' href="javascript:void(0);" />
                <area shape="rect" style="cursor: pointer;" coords="186,110,259,138" onclick="sendTelMsg()" href="javascript:void(0);" />
                <area shape="rect" style="cursor: pointer;" coords="123,160,260,183" href="http://www.fei580.com/chat/"  onclick="_czc.push(['_trackEvent', '查询列表客服','咨询','点击']);" id="ochat" rel="nofollow" target="_blank" title="在线客服" />
            </map>
        </div>
        <div id="tip4342" class="kf_2012_rbox2" style="display: none;">
            <img src="http://www.fei580.com/images/kf_r2.gif" border="0" usemap="#Map2" />
            <map name="Map2">
                <area shape="rect" style="cursor: pointer;" coords="237,5,267,31" onclick='show("tip4342")' href="javascript:void(0);" />
                <area shape="rect" style="cursor: pointer;" coords="83,36,256,62" href="http://www.fei580.com/chat/"  onclick="_czc.push(['_trackEvent', '查询列表客服','咨询','点击']);" id="mchat" rel="nofollow" target="_blank" title="在线客服" />
                <area shape="rect" style="cursor: pointer;" coords="84,72,167,98" href="tencent://message/?uin=32335510&Site=机票查询&Menu=yes" />
                <area shape="rect" style="cursor: pointer;" coords="84,100,167,123" href="tencent://message/?uin=937056717&Site=机票查询&Menu=yes" />
                <area shape="rect" style="cursor: pointer;" coords="83,127,167,147" href="tencent://message/?uin=531658630&Site=机票查询&Menu=yes" />
                <area shape="rect" style="cursor: pointer;" coords="173,71,258,96" id="msn1" href="http://www.fei580.com/chat/" target="_blank" />
                <area shape="rect" style="cursor: pointer;" coords="172,126,256,149" id="msn2" href="http://www.fei580.com/chat/" target="_blank" />
                <area shape="rect" style="cursor: pointer;" coords="173,99,256,122" id="msn3" href="http://www.fei580.com/chat/" target="_blank" />
            </map>
        </div>
    </div>
    <script language="javascript" type="text/javascript" src="http://www.fei580.com/js/datepicker.js"></script>
    <script language="javascript" type="text/javascript" src="http://www.fei580.com/js/scrolljs.js"></script>
<script type="text/javascript">
    function showorderbox(adultprice, airline, depport, fz, arrport, ft, deptime, arrtime, plan, seat) {
        $('.orderbox').lightbox_me({
            centered: true,
            onLoad: function() {
                $('.order_xc').html("不含税价：￥" + adultprice);
                $('#orderbox_airline').html(airline);
                $('#orderbox_depport').html("<span class=\"order_tag\">出发地</span>" + depport);
                $('#orderbox_fz').html("<span class=\"order_tag\">行 程</span>" + (ft == "2" ? "往返" : "单程") + "/" + fz);
                $('#orderbox_arrport').html("<span class=\"order_tag\">目的地</span>" + arrport);
                $('#orderbox_deptime').html("<span class=\"order_tag\">出发时间</span>" + deptime);
                $('#orderbox_arrtime').html("<span class=\"order_tag\">到达时间</span>" + arrtime);
                $('#orderbox_plan').html("<span class=\"order_tag\">机 型</span>" + plan);
                $('#orderbox_seat').html("<span class=\"order_tag\">舱 位</span>" + seat);
                $("#inp_submitorder").click(function() {
                    var cont = "[不含税价：￥" + adultprice + "][航空公司：" + $('#orderbox_airline').text().replace("航空公司", "") + "][行程：" + (ft == "2" ? "往返" : "单程") + "/" + fz + "][出发地：" + depport + "][目的地：" + arrport + "][出发时间：" + deptime + "][到达时间：" + arrtime + "][机 型：" + plan + "][舱 位：" + seat + "]";
                    if ($.trim(cont) == '') return false;

                    var order_input_contact = document.getElementById("order_input_contact").value;
                    var order_input_telephone = document.getElementById("order_input_telephone").value;
                    var order_input_otherWay = document.getElementById("order_input_otherWay").value;
                    var order_input_require = document.getElementById("order_input_require").value;
                    if (order_input_contact == "") {
                        alert('请输入您的联系人！');
                        document.getElementById("order_input_contact").focus();
                        return false;
                    }
                    if (order_input_telephone == "") {
                        alert('请输入联系电话！');
                        document.getElementById("order_input_telephone").focus();
                        return false;
                    }
                    $.get("share/ticketbook.aspx", { contact: escape(order_input_contact), telephone: escape(order_input_telephone), otherWay: escape(order_input_otherWay), req: escape(order_input_require), content: escape(cont) }, function(result) {
                        if (result == "1") {
                            alert("提交成功，我们客服将马上与您联系！")
                            $('.order_close').click();
                            return true;
                        }
                        else {
                            alert("提交失败，请重新提交！");
                            return false;
                        }
                    });
                });
                $('.order_close').click(function() {
                    $('.orderbox').trigger('close');
                });
            }
        });
    }
</script>
<div class="orderbox" style="display:none">
 <div class="orderinfo">
  <div class="order_kf_img"><img src="http://www.fei580.com/images/kfimg/cs<%=csA_num %>.jpg" /></div>
  <div class="order_kf_name"><strong>你的专属顾问</strong></div>
  <div class="order_xc">不含税价：￥</div>
  <div class="order_close">关闭</div>
  <div class="clear"></div>
  <div class="order_ticket">
  <ul>
   <li id="orderbox_airline"><span class="order_tag">航空公司</span><span class="airport"><img src="http://www.fei580.com/images/2010-01-27_13-32-35_0000.gif" /></span></li>
   <li id="orderbox_depport"><span class="order_tag">出发地</span></li>
   <li id="orderbox_fz"><span class="order_tag">行 程</span></li>
   <li id="orderbox_arrport"><span class="order_tag">目的地</span></li>
   <li id="orderbox_seat"><span class="order_tag">舱 位</span>经济舱</li>
   <li id="orderbox_deptime"><span class="order_tag">出发时间</span></li>
   <li id="orderbox_plan"><span class="order_tag">机 型</span></li>
   <li id="orderbox_arrtime"><span class="order_tag">到达时间</span></li>
  </ul>
  </div>
 </div>
 <div class="orderway">
  <div class="order_waybox">
   <ul>
    <li><span class="order_wayer">联系人</span><input id="order_input_contact" type="text" class="order_input" /><i>*</i></li>
    <li><span class="order_wayphone">联系方式</span><input  id="order_input_telephone" type="text" class="order_input" placeholder="微信、QQ、邮箱"/><i>*</i></li>
    <li><span class="order_wayother">QQ/微信</span><input  id="order_input_otherWay" type="text" class="order_input" /></li>
    <li><span class="order_wayother">行程要求</span><input  id="order_input_require" type="text" class="order_input" /></li>
   </ul>
  </div>
  <div class="clear"></div>
  <div class="order_submit">
   <input id="inp_submitorder" type="button" value="" class="submit_input" />
  </div>
 </div>
</div>
</body>
</html>