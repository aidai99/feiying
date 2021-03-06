﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="personadd.aspx.cs" Inherits="console_person_personadd" %>
<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>查看或修改会员信息</title>
    <link rel="stylesheet" href="../css/control.css" type="text/css" />
    <script language="javascript" type="text/javascript" src="../../tools/fckeditor/fckeditor.js"></script>
    <script type="text/javascript" src="../../js/DateControls.js"></script>
    <script type="text/javascript" language="javascript">
      //表单验证
     function checkperregister()
     {
        var username = document.getElementById("username");
        if(username.value=='')
        {
            alert('请填写您的姓名！');
            return false;
        }
        
        var nickname = document.getElementById("nickname");
        if(nickname.value=='')
        {
            alert('请填写您的昵称！');
            return false;
        }
      
        var email = document.getElementById("email");
        if(email.value=='')
        {
            alert('请填写您的邮箱！');
            return false;
        }
       
     }
    
    function FCKeditor_OnComplete(editorInstance) {
        oEditer = editorInstance;
    }
   　//检测图片后缀名
function CheckFile(sender,arg)
{
    var enableExt =["jpg","gif","bmp","png"]; // add your enable extension on that
    if (arg.Value=="")
    {
        arg.IsValid =true;
    }
    else
    {
        var temp = arg.Value.split(".");
        var extension = temp[temp.length-1];
        extension = extension.toLowerCase();
        var isValid = false;
        
        for(i=0;i<enableExt.length;i++)
        {
           if (extension==enableExt[i])
           {
                isValid=true;
           }
        }
        arg.IsValid = isValid;
    }
}  
    </script>
</head>
<body>
    <form id="form1" runat="server">
   <table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" id="TABLE1">
            <tr>
                <td align="center" bgcolor="#799AE1" class="B" style="width: 413px" >
                    </td>
                <td height="25" align="left" bgcolor="#799AE1" class="B" style="width: 839px">
                    <asp:Label ID ="lblTitle" runat ="server"></asp:Label></td>
                <td align="center" bgcolor="#799AE1" class="B" style="width: 253px">
                    </td>
            </tr>
            <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    用户名：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="username" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr> 
             <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    姓名：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="nickname" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
             <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                   电话：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="tel" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
             <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                   等级：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="txt_type" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
            <tr style="display:none;" >
                <td align="center" bgcolor="#F6F6F6" style="width: 413px; height: 30px;">
                    个人头像：</td>
                <td align="left" bgcolor="#F6F6F6" style="width: 839px; height: 30px">
                <asp:Label ID="isUploadPic" runat="server" Text=""></asp:Label>
	  	               <input id="isReload" type="hidden" runat="server" value="0" />
	  	               <input id="oldPic" type="hidden" runat="server" value="" />
                    </td>
                <td bgcolor="#F6F6F6" style="width: 253px; height: 30px;">
                  </td>
            </tr>
            <tr style="display:none;" id="picUpload" >
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    图片路径：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
                 <asp:FileUpload ID="FileUpload_picPath" runat="server" Width="285px" />
            <label>
          &nbsp;</label><asp:CustomValidator ID="CustomValidator_pic" runat="server" 
                ClientValidationFunction="CheckFile" ControlToValidate="FileUpload_picPath" 
                Display="Dynamic" ErrorMessage="&lt;br/&gt;*只支持 jpg , gif , bmp , png 等图片格式"></asp:CustomValidator>   </td>       
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
             <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    Email：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="email" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
             <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    公司：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="company" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
             <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    QQ：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="qq" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
             <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    MSN：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="msn" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
            
            <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    性别：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input id="sexm"  name="sex" runat="server" value="M" type="radio" />男&nbsp;&nbsp;&nbsp;&nbsp;<input id="sexr" name="sex" runat="server" value="S" type="radio" />女
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
            
             <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    出生日期：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="date" onfocus="return setday(this)" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
            
            <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    地址：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="post" runat="server" type="text" size="58" />
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
            
            <tr>
                <td align="center" bgcolor="#F6F6F6" style="width: 413px">
                    积分：</td>
                <td height="25" align="left" bgcolor="#F6F6F6" style="width: 839px">
               <input  id="txtMoney" runat="server" type="text" size="58" /><br /><br />
               <span style="color:Red;" >积分1000分，请设置会员等级为“飞瀛浪客”,3000分为“飞瀛人”。</span> 
               </td>
                <td bgcolor="#F6F6F6" style="width: 253px">
                  </td>
            </tr>
            
            <tr>
                <td align="center" bgcolor="#F6F6F6" style="height: 27px" colspan="3">
                    <asp:Button ID="btnSave" runat="server" Text="保 存"  Height="23" OnClientClick="return checkperregister()"
                      OnClick="btnSave_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                 <input name="Submit3" type="button" style="height: 23px;"onclick="location.href='personlist.aspx'" value="返 回" />
                    </td>
            </tr>
            <tr>
                <td align="center" colspan="3">
                 </td>
            </tr>
        </table>
    </form>
</body>
</html>
