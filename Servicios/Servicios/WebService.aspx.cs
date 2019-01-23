using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ConnectionDispensario.Modelos;

namespace Christoc.Modules.Servicios
{

   

    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["addservice"] != null)
            {
                string nombre = Request["name"];
                Servicio S = new Servicio(nombre);
                if (S.Guardar() == true)
                {
                    SendText("ok");
                }
                else
                {
                    SendText("error");
                }
            }
        }

        public void SendText(string text)
        {
            Response.Clear();
            Response.ClearHeaders();
            Response.AddHeader("Content-Type", "text/plain");
            Response.Write(text);
            Response.Flush();
            Response.End();
        }
    }

    
}