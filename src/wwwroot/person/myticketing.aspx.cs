﻿using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using eap.share;

public partial class person_myticketing : System.Web.UI.Page
{
    protected string Mem_LoginName = string.Empty;
    protected string Mem_ID = string.Empty;
    protected string Mem_Money = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        //判断登陆
        if (Session["Mem_LoginName"] == null||Session["Mem_ID"] == null || Session["Mem_Money"]==null)
            Response.Redirect("../index.aspx");
        else
        {
            Mem_LoginName = Session["Mem_LoginName"].ToString();
            Mem_ID = Session["Mem_ID"].ToString();
            Mem_Money = Session["Mem_Money"].ToString();

            this.GetTicketinglist();
        }
    }

    private string Con()
    {
        return ConfigurationManager.AppSettings.Get("DatabaseConnect_Manage");
    }

    /// <summary>
    /// 获取电子票列表
    /// </summary>
    protected void GetTicketinglist()
    {
        DataSet ds = new DataSet();
        string str = @"select top 100 percent FM_ticketing.number,FM_Customer.* from FM_ticketing left join FM_Customer on cId=memberId where 1=1 ";

        string txtkey = this.txtsearch.Value;
        if (txtkey == "请联系你的客服获取编号")
            txtkey = string.Empty;
        if (!string.IsNullOrEmpty(txtkey))
        {
            str += " and code = '" + this.txtsearch.Value.Trim() + "'";
        }

        str += " order by FM_ticketing.addtime desc";

        SqlParameter[] parameters = {
                    new SqlParameter("@sql", SqlDbType.NVarChar,4000),
                    new SqlParameter("@currentpage", SqlDbType.Int),
                    new SqlParameter("@pagesize", SqlDbType.Int)};

        parameters[0].Value = str;
        parameters[1].Value = Pager.CurrentPageIndex;
        parameters[2].Value = Pager.PageSize;

        ds = SqlHelper.ExecuteDataset(this.Con(), CommandType.StoredProcedure, "p_splitpage", parameters);
        this.Pager.RecordCount = Convert.ToInt32(ds.Tables[2].Rows[0][0]);
        this.rptshopnews.DataSource = ds.Tables[1];
        this.rptshopnews.DataBind();
    }

    /// <summary>
    /// 获取下载号
    /// </summary>
    /// <param name="adminId"></param>
    /// <returns></returns>
    public string getTicketing(string code)
    {
        if (string.IsNullOrEmpty(code))
            return string.Empty;

        string str = "select top 1 FM_ticketing.path from FM_ticketing where code='" + code + "' and state=0 order by FM_ticketing.addtime desc  ";

        object ob = SqlHelper.ExecuteScalar(this.Con(), CommandType.Text, str);
        if (ob == null)
            return string.Empty;

        return ob.ToString();
    }

    /// <summary>
    /// 获取下载号
    /// </summary>
    /// <param name="adminId"></param>
    /// <returns></returns>
    public int updateTicketing(string code)
    {
        if (string.IsNullOrEmpty(code))
            return 0;

        string str = "update  FM_ticketing set state=1 where code='" + code + "'";

        int count = SqlHelper.ExecuteNonQuery(this.Con(), CommandType.Text, str);

        return count;
    }


    /// <summary>
    /// 分页事件
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Pager_PageChanged(object sender, EventArgs e)
    {
        this.GetTicketinglist();
    }


    protected void butt_search_Click(object sender, EventArgs e)
    {
        string txtkey = this.txtsearch.Value;
        if (txtkey == "请联系你的客服获取编号")
            txtkey = string.Empty;

        if (string.IsNullOrEmpty(txtkey))
        {
            scripthelp.Alert("电子票号不为空！",this.Page);
            return;
        }

        string url = this.getTicketing(txtkey);
        if (string.IsNullOrEmpty(url))
        {
            scripthelp.Alert("无法查询该电子票号或电子票号已经被使用！", this.Page);
        }
        else
        {
            Response.Redirect("/" + url);
            this.updateTicketing(txtkey);
        }
    }
}
