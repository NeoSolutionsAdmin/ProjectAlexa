using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ConnectionDispensario.Modelos;
using System.Web.Script.Serialization;

namespace Christoc.Modules.TagManager
{
    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string busqueda = "%";
            string json = "null";

            if(Request["tag"] != null)
            {
                busqueda = Request["tag"];
                List<Tag> resultados = Tag.GetTagByTagName(busqueda);
                json = new JavaScriptSerializer().Serialize(resultados);
            }

            Response.Clear();
            Response.ClearHeaders();
            Response.Write(json);
            Response.Flush();
            Response.End();
        }
    }
}