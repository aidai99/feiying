﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using eap.share;

public partial class console_person_personlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //判断是否登录，如果未登陆，则跳到登陆页面
        MemberInfo adminmerinfo = (MemberInfo)Session["adminmerinfo"];
        if (adminmerinfo == null)
        {

            ClientScript.RegisterStartupScript(ClientScript.GetType(), "t", "<script>displaymenu();</script>");
            Response.Redirect("~/console/login.aspx", true);
        }
        else
        {
            if (adminmerinfo.Flag == 2)
            {
                btndel.Visible = false;
            }
        }

        //获取会员信息列表
        GetShopNewslist();
    }


    /// <summary>
    /// 获取会员信息列表
    /// </summary>
    protected void GetShopNewslist()
    {

        DataSet ds = new DataSet();


        string str = @"select top 100 percent * from tmember where 1=1 ";

        if (txtsearch.Value.Trim() != "")
        {
            str += " and Mem_LoginName like '%" + txtsearch.Value.Trim() + "%' or Mem_Name like '%" + txtsearch.Value.Trim() + "%'";
        }

        str += " order by Mem_ID desc";


        SqlParameter[] parameters = {
                    new SqlParameter("@sql", SqlDbType.NVarChar,4000),
                    new SqlParameter("@currentpage", SqlDbType.Int),
                    new SqlParameter("@pagesize", SqlDbType.Int)};

        parameters[0].Value = str;
        parameters[1].Value = Pager.CurrentPageIndex;
        parameters[2].Value = Pager.PageSize;


        ds = SqlHelper.ExecuteDataset(SqlHelper.ConnString_select, CommandType.StoredProcedure, "p_splitpage", parameters);



        Pager.RecordCount = Convert.ToInt32(ds.Tables[2].Rows[0][0]);

        Pager.CustomInfoHTML = "&nbsp;第" + Pager.CurrentPageIndex.ToString() + "页/共" + Pager.PageCount.ToString() + "页 总记录数：" + Pager.RecordCount.ToString();

        rptshopnews.DataSource = ds.Tables[1];

        rptshopnews.DataBind();

    }

    /// <summary>
    /// 分页事件
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Pager_PageChanged(object sender, EventArgs e)
    {
        GetShopNewslist();
    }

    /// <summary>
    /// 根据条件来查询
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        GetShopNewslist();
    }


    /// <summary>
    /// 删除操作
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btndel_Click(object sender, EventArgs e)
    {
        string key = Request.Form["chk"];
        if (string.IsNullOrEmpty(key))
            return;

        string[] array = key.Split(',');

        StringBuilder str = new StringBuilder();
        for (int i = 0; i < array.Length; i++)
        {
            string[] arrayv = array[i].Split('&');
            str.Append("delete from tmember where Mem_ID=" + arrayv[0] + ";");
            str.Append("delete from FY_member_article where publishName='" + arrayv[1] + "';");
        }

        SqlConnection conn = new SqlConnection(SqlHelper.ConnString_insert);
        conn.Open();

        using (SqlTransaction trans = conn.BeginTransaction())
        {
            try
            {

                SqlHelper.ExecuteNonQuery(trans, CommandType.Text, str.ToString());
                trans.Commit();
                scripthelp.AlertAndRedirect("操作成功！", "personlist.aspx", this.Page);
            }
            catch
            {
                trans.Rollback();
                scripthelp.AlertAndRedirect("操作失败！", "personlist.aspx", this.Page);
            }
            finally
            {
                conn.Close();
            }
        }
    }

}
