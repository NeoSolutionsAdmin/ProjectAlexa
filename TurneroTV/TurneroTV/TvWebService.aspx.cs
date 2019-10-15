using ConnectionDispensario.Modelos;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Christoc.Modules.TurneroTV
{

    public class ShortTurno
    {

        public ShortTurno(Turno p)
        {
            Estado = p.Esstado;
            Hour = p.FechaRecepcion;
            UserInfo UI = UserController.GetUserById(0, p.IdUser);
            Profesional = UI.FirstName + " " + UI.LastName;
            Paciente = p.Pac.NOMBRE + " " + p.Pac.APELLIDO;
            RecepcionHora = p.FechaRecepcion.Hour.ToString() + ":" + p.FechaRecepcion.Minute.ToString() + ":" + p.FechaRecepcion.Second.ToString();
        }

        public string Estado;
        public DateTime Hour;
        public string Profesional;
        public string Paciente;
        public string RecepcionHora;

    }

    public class file
    {
        public string fileName;
        public file(string p)
        {
            fileName = p;
        }
    }

    public partial class TvWebService : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {


            Response.Clear();
            Response.ClearHeaders();

            if (Request["turnos"] != null && Request["turnos"] == "1")
            {
                GetTurnos();
            }
            if (Request["videos"] != null && Request["videos"] == "1")
            {
                GetVideos();
            }

            Response.ContentType = "text/plain";
            Response.Flush();
            Response.End();




        }

        private void GetVideos()
        {
            string directory = Server.MapPath("/DesktopModules/TurneroTV/Videos");
            string[] archivos = Directory.GetFiles(directory);
            List<file> d = new List<file>();
            int count = 0;
            foreach (string s in archivos)
            {
                //Response.Write( "[" + count.ToString() + "]" +s + Environment.NewLine);
                string[] h = s.Split(new string[] { "\\" }, StringSplitOptions.None);
                string filename = h[h.Length-1];

                d.Add(new file(filename));
                count++;
            }
            JavaScriptSerializer S = new JavaScriptSerializer();
            String Lista = S.Serialize(d);
            Response.Write(Lista);

        }

        public void GetTurnos()
        {
            List<ShortTurno> ST = new List<ShortTurno>();
            //Response.Flush();
            ArrayList AL = UserController.GetUsers(0);
            foreach (object a in AL)
            {
                UserInfo user = a as UserInfo;
                //Response.Write(user.DisplayName);
                int Year = DateTime.Now.Year;
                int Month = DateTime.Now.Month;
                int Day = DateTime.Now.Day;


                //busca turnos en Espera
                List<Turno> TL = Turno.GetTurnosRecepcion((new DateTime(Year, Month, Day, 0, 1, 0)).AddDays(-1), (new DateTime(Year, Month, Day , 23, 59, 0)).AddDays(1), user.UserID, "Espera");
                if (TL != null)
                {
                    foreach (Turno t in TL)
                    {
                        ST.Add(new ShortTurno(t));
                    }
                }

                //busca turnos en Progreso
                TL = Turno.GetTurnosRecepcion((new DateTime(Year, Month, Day, 0, 1, 0)).AddDays(-1), (new DateTime(Year, Month, Day , 23, 59, 0)).AddDays(1), user.UserID, "Progreso");
                if (TL != null)
                {
                    foreach (Turno t in TL)
                    {
                        ST.Add(new ShortTurno(t));
                    }
                }




            }
            if (ST.Count > 0)
            {
                ST.Sort((x, y) => DateTime.Compare(x.Hour, y.Hour));
                JavaScriptSerializer S = new JavaScriptSerializer();
                String Lista = S.Serialize(ST);
                Response.Write(Lista);

            }
            else
            {
                Response.Write("*No Hay Nada*");
            }



        }


    }
}