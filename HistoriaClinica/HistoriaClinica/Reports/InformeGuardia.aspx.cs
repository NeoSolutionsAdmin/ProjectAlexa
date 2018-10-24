using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using ConnectionDispensario.Modelos;
using System.IO;
using Microsoft.Reporting.WebForms;

namespace Christoc.Modules.HistoriaClinica.Reports
{
    public partial class InformeGuardia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int ID = int.Parse(Request["hid"].ToString().Replace('H',' '));
            Historial _Historial = Historial.GetHistorialById(ID);
            string filename = Guid.NewGuid().ToString() + ".pdf";
            if (_Historial == null)
            {
                Response.Write("Error en consulta historial inexistente...");
            }
            else
            {
                
                Paciente _Paciente = Paciente.Select_Paciente_By_Id(_Historial.IDPACIENTE);
                ReportParameter RPOS;
                if (_Paciente.IDOBRASOCIAL == 0)
                {
                    RPOS = new ReportParameter("pobrasocial", "No");
                }
                else
                {
                    ObraSocial OS = ObraSocial.GetObraSocial(_Paciente.IDOBRASOCIAL);
                    RPOS = new ReportParameter("pobrasocial", OS.NOMBRE);
                }
                if (_Paciente != null)
                {

                    string date =
                            DateTime.Now.Day +
                            "/" +
                            DateTime.Now.Month +
                            "/" +
                            DateTime.Now.Year;
                
                RV.LocalReport.ReportPath = MapPath("/DesktopModules/HistoriaClinica/Reports/InformeDeGuardia.rdlc");
                    RV.LocalReport.SetParameters(new ReportParameter[]
                    {
                    new ReportParameter("pfecha",date),
                    new ReportParameter("ppaciente",_Paciente.APELLIDO + ", " + _Paciente.NOMBRE),
                    new ReportParameter("pdni",_Paciente.NRODOCUMENTO),
                    RPOS,
                    new ReportParameter("pdiagnostico",Request["Diag"].ToString()),
                    new ReportParameter("pobservacionenguardia",Request["obs"].ToString()),
                    new ReportParameter("pprovisiondemedicamento",Request["med"].ToString()),
                    new ReportParameter("pampliaciondediagnostico",_Historial.RAWDIAGNOSTICO)

                });
                RV.LocalReport.Refresh();
                byte[] b = RV.LocalReport.Render("PDF");

                DotNetNuke.Entities.Portals.PortalController PC = new DotNetNuke.Entities.Portals.PortalController();
                
                string path = Server.MapPath("/"+PC.GetPortal(0).HomeDirectory);
                Response.Write(path);
                File.WriteAllBytes(path + "\\" + filename, b);
                Response.Redirect("/Portals/0/" + filename);
                }
            }
            
            
        }
    }
}