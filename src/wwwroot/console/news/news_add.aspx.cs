﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Text;
using System.IO;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using eap.share;

public partial class cms_news_news_add : System.Web.UI.Page 
{

    static int id = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        //判断是否登录，如果未登陆，则跳到登陆页面
        MemberInfo adminmerinfo = (MemberInfo)Session["adminmerinfo"];

        if (adminmerinfo == null)
        {
            ClientScript.RegisterStartupScript(ClientScript.GetType(), "t", "<script>displaymenu();</script>");
            Response.Redirect("~/console/login.aspx", true);
        }

        if (!IsPostBack)
        {
            //初始化页面
            if (Request.QueryString["id"] != null)
            {
                id = Convert.ToInt32(Request.QueryString["id"].ToString());
                string str = "select * from FY_news where id=" + id;
                DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.ConnString_select, CommandType.Text, str);
                title.Value = ds.Tables[0].Rows[0]["title"].ToString();

                type.Value = ds.Tables[0].Rows[0]["type"].ToString();

                from.Value= ds.Tables[0].Rows[0]["newsfrom"].ToString();

                this.isUploadPic.Text = "已上传：<img src=../../" + ds.Tables[0].Rows[0]["newsPic"].ToString() + " height='80' width='80'>";
                this.oldPic.Value = ds.Tables[0].Rows[0]["newsPic"].ToString();

                if (Convert.ToInt32(ds.Tables[0].Rows[0]["isTop"].ToString()) == 1)
                {
                    radisTop1.Checked = true;
                    radisTop0.Checked = false;
                }
                else
                {
                    radisTop0.Checked = true;
                    radisTop1.Checked = false;
                }

                if (Convert.ToInt32(ds.Tables[0].Rows[0]["isRecom"].ToString()) == 1)
                {
                    radisRecom1.Checked = true;
                    radisRecom0.Checked = false;
                }
                else
                {
                    radisRecom0.Checked = true;
                    radisRecom1.Checked = false;
                }

                if (ds.Tables[0].Rows[0]["isRecom"].ToString()!="")
                {
                    hits.Value = ds.Tables[0].Rows[0]["hots"].ToString();
                }

                FCKeditor1.Value = ds.Tables[0].Rows[0]["content"].ToString();

                this.lblTitle.Text = "修改资讯信息";
            }
            else
            {
                id = 0;
                this.lblTitle.Text = "添加资讯信息";
            }
        }
    }

    /// <summary>
    ///添加或修改资讯信息
    /// </summary> 
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string picPath = "";
         if (FileUpload_picPath.HasFile)
        {
            FileUploadOK(out picPath);
         }
        int  istop = 0, isrecom = 0 ;

        if (radisTop1.Checked == true) istop = 1; else istop = 0;
        if (radisRecom1.Checked == true) isrecom = 1; else isrecom = 0;

        if (type.Value == "")
        {
            scripthelp.Alert("请选择信息类型",this.Page);
            return ;
        }

        if (id == 0)
        {
            string str = "insert into FY_news(title,type,newsfrom,content,addtime,isRecom,isTop,newsPic,hots)";
            str += " values('" + Sys.filterSQLStr(title.Value.Trim()) + "'," + type.Value + ",'" + Sys.filterSQLStr(from.Value.Trim()) + "',";
            str += "'" + Sys.filterSQLStr(FCKeditor1.Value.Trim()) + "',getdate()," + isrecom + "," + istop + ",'" + picPath .Trim() + "',0)";

                int inserttag = 0;

                inserttag = SqlHelper.ExecuteNonQuery(SqlHelper.ConnString_insert, CommandType.Text, str);

                if (inserttag > 0)
                {
                    Response.Write("<script>alert('操作成功！');location.href='news_list.aspx'</script>");
                }
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "t", "<script>window.alert('操作失败！')</script>");      
        }
        else
        {
            string str = "update FY_news set  title='" + Sys.filterSQLStr(title.Value.Trim()) + "',type=" + type.Value + ",newsfrom='" + Sys.filterSQLStr(from.Value.Trim()) + "',";
            if (picPath != "")
            {
                str += "content='" + Sys.filterSQLStr(FCKeditor1.Value.Trim()) + "',newsPic='" + picPath.Trim() + "', isRecom=" + isrecom + ",isTop=" + istop + " where id=" + id + "";
           
            }else{
               
                str += "content='" + Sys.filterSQLStr(FCKeditor1.Value.Trim()) + "',isRecom=" + isrecom + ",isTop=" + istop + " where id=" + id + "";
           
            }
                int inserttag = 0;

                inserttag = SqlHelper.ExecuteNonQuery(SqlHelper.ConnString_insert, CommandType.Text, str);

                if (inserttag > 0)
                {
                    Response.Write("<script>alert('操作成功！');location.href='news_list.aspx'</script>");
                }
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "t", "<script>window.alert('操作失败！')</script>");
   
        }


    }

    /// <summary>
    /// 上传图片
    /// </summary>
    /// <param name="license_url"></param>
    /// <returns></returns>
    private bool FileUploadOK(out string picPath)
    {
        bool _ok = false;
        string _picName = Sys.getDistinctFilename();//图片随机名称
        string _picExtension = string.Empty;//图片后缀
        string _physicPath = string.Empty;//物理路径
        string _picPath = string.Empty;//图片相对路径
        string _dbpicPath = string.Empty;
        string fname = "";

        if (FileUpload_picPath.HasFile)
        {
            #region 生成文件夹
            string _time = DateTime.Now.ToString("yyyy-MM-dd").Replace("-", "/");
            _picPath = "../../upload_web/" + _time + "/";
            _dbpicPath = "upload_web/" + _time + "/";
            _physicPath = Request.MapPath(_picPath);
            if (!Directory.Exists(_physicPath))
                Directory.CreateDirectory(_physicPath);
            #endregion

            #region 上传图片

            //读取所有上传的文件
            HttpFileCollection files = HttpContext.Current.Request.Files;
            long maxSize = long.Parse(ConfigurationManager.AppSettings.Get("newsPicSize"));
            //long maxSize = 512 * 1024;
            for (int i = 0; i < files.Count; i++)
            {
                string _fileName = FileUpload_picPath.FileName; // 客户端文件路径
                fname = Path.GetFileName(files[i].FileName);
                if (maxSize > 0 && files[i].ContentLength > maxSize)
                {
                    scripthelp.Alert("该文件(" + fname + ")超过了限制大小(" + maxSize + "byte),不允许上传。!", this.Page);
                    picPath = string.Empty;
                    return false;
                }
                //取得图片后缀
                _picExtension = GetFileExtends(_fileName);

                picPath = _picPath + _picName + _picExtension;//图片相对路径+图片随机名称+图片后缀

                FileUpload_picPath.SaveAs(_physicPath + _picName + _picExtension);//保存图片
            }
            #endregion
            _ok = true;
        }
        else
        {
            #region 返回信息
            picPath = string.Empty;
            _ok = false;
            #endregion
        }
        picPath = _dbpicPath + _picName + _picExtension;
        return _ok;
    }

    /// <summary>
    /// 取得文件后缀
    /// </summary>
    /// <param name="filename"></param>
    /// <returns></returns>
    public static string GetFileExtends(string filename)
    {
        string ext = null;
        if (filename.IndexOf('.') > 0)
        {
            string[] fs = filename.Split('.');
            ext = fs[fs.Length - 1];
        }
        return "." + ext;
    }

}
