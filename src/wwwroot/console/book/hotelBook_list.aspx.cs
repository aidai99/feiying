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

public partial class console_book_hotelBook_list : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            //获取预定酒店列表
            GetShopNewslist();
        }
    }

    /// <summary>
    /// 获取预定机票列表
    /// </summary>
    protected void GetShopNewslist()
    {

        DataSet ds = new DataSet();


        string str = @"select top 100 percent FY_HotelBook.*,FY_Hotel.hotelName,Mem_LoginName from FY_HotelBook left join FY_Hotel on FY_HotelBook.hId=FY_Hotel.hId left join tmember on FY_HotelBook.memberId=tmember.Mem_ID where 1=1  ";

        str += " order by FY_HotelBook.bId desc";


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
    /// 删除操作
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btndel_Click(object sender, EventArgs e)
    {
        StringBuilder str = new StringBuilder();

        str.Append("delete from FY_HotelBook where bId in (" + Request.Form["chk"] + ");");


        SqlConnection conn = new SqlConnection(SqlHelper.ConnString_insert);

        conn.Open();

        using (SqlTransaction trans = conn.BeginTransaction())
        {
            try
            {

                SqlHelper.ExecuteNonQuery(trans, CommandType.Text, str.ToString());
                trans.Commit();
                scripthelp.AlertAndRedirect("操作成功！", "hotelBook_list.aspx", this.Page);
            }
            catch
            {
                trans.Rollback();
                scripthelp.AlertAndRedirect("操作失败！", "hotelBook_list.aspx", this.Page);
            }
            finally
            {
                conn.Close();
            }
        }
    }

    /// <summary>
    /// 对所选择的项进行置顶
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btncheck_Click(object sender, EventArgs e)
    {
        string str = "update FY_HotelBook set state=1 where bId in (" + Request.Form["chk"] + ")";

        int chktag = 0;

        chktag = SqlHelper.ExecuteNonQuery(SqlHelper.ConnString_insert, CommandType.Text, str);

        if (chktag > 0)
            scripthelp.AlertAndRedirect("操作成功！", "hotelBook_list.aspx", this.Page);
        else
            scripthelp.AlertAndRedirect("操作失败！", "hotelBook_list.aspx", this.Page);

    }


    /// <summary>
    /// 取消置顶操作
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btncancelchk_Click(object sender, EventArgs e)
    {
        string str = "update FY_HotelBook set state=0 where bId in (" + Request.Form["chk"] + ")";

        int chktag = 0;

        chktag = SqlHelper.ExecuteNonQuery(SqlHelper.ConnString_insert, CommandType.Text, str);

        if (chktag > 0)
            scripthelp.AlertAndRedirect("操作成功！", "hotelBook_list.aspx", this.Page);
        else
            scripthelp.AlertAndRedirect("操作失败！", "hotelBook_list.aspx", this.Page);

    }

}
