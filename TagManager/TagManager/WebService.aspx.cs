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
            Response.Clear();
            Response.ClearHeaders();

            string busqueda = "%";
            string json = "null";

            if(Request["getAllTags"] != null)
            {
                busqueda = "%";
                List<Tag> resultados = Tag.GetTagByTagName(busqueda);
                json = new JavaScriptSerializer().Serialize(resultados);
                Response.Write(json);
            }


            if(Request["saveTagIcono"] != null) SaveTag(Request["saveTagIcono"], Request["saveTagName"]);
            if (Request["deleteTagId"] != null) DeleteTag(int.Parse(Request["deleteTagId"]));


           
            
            Response.Flush();
            Response.End();
        }

        private void SaveTag(string icono, string name)
        {
            bool verify = Tag.AgregarTag(new Tag(name, icono));

            if (verify) Response.Write("true");
            else Response.Write("false");
        }

        private void DeleteTag(int id)
        {
            bool verify = Tag.EliminarTag(id);

            if (verify) Response.Write("true");
            else Response.Write("false");
        }
    }
}