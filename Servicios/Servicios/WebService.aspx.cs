using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ConnectionDispensario.Modelos;
using System.Web.Script.Serialization;

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
                    Servicio tS = Servicio.ObtenerUltimoServicio();
                    if (tS != null)
                    {
                        SendText(tS.ID.ToString());
                    }
                    else
                    {
                        SendText("error");
                    }
                }
                else
                {
                    SendText("error");
                }
            }
            if (Request["getservicebyiduser"] != null)
            {
                int portalid = int.Parse(Request["PortalId"]);
                int idservice = int.Parse(Request["ServiceId"]);
                List<ProfesionalServicio> ps = Usuario.GetUsersByServicio(idservice, portalid);
                List<Usuario> u = new List<Usuario>();
                foreach (ProfesionalServicio i in ps)
                {
                    u.Add(i.user);
                }
                if (u != null)
                {
                    JavaScriptSerializer Serializer = new JavaScriptSerializer();
                    string serialized = Serializer.Serialize(u);
                    SendText(serialized);
                }

            }
            if (Request["getallusers"] != null)
            {
                int PortalId = int.Parse(Request["PortalId"]);
                List<Usuario> ul =  Usuario.GetUsers(PortalId);
                if (ul != null)
                {
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    string res = serializer.Serialize(ul);
                    SendText(res);

                }
            }
            if (Request["insertuserservicio"] != null)
            {
                Usuario U = new Usuario(int.Parse(Request["userid"]), 0);
                if (U.ExisteEnServicio(int.Parse(Request["serviceid"])) == true)
                {
                    SendText("existe");
                }
                else
                {
                    if (U.InsertServicio(int.Parse(Request["serviceid"])) == true)
                    {
                        ProfesionalServicio PS= ProfesionalServicio.GetLast();
                        if (PS != null)
                        {
                            JavaScriptSerializer JS = new JavaScriptSerializer();
                            SendText(JS.Serialize(PS));
                        }
                        SendText("insertado");
                    }
                    else
                    {
                        SendText("error");
                    };
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