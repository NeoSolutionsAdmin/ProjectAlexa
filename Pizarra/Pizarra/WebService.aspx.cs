using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ConnectionDispensario.Modelos;
using System.Web.Script.Serialization;

namespace Christoc.Modules.Pizarra
{
    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ClearHeaders();

            string busqueda = "";
            string json = "null";

            if (Request["busquedaPaciente"] != null)
                json = GetPacientes(Request["busquedaPaciente"], Request["tipoDeDatos"]);

            Response.Write(json);
            Response.Flush();
            Response.End();
        }

        private string GetPacientes(
            string busqueda,
            string searchType)
        {
            if (searchType == "1")
            {
                List<Paciente> resultados = 
                    Paciente.BuscarPacientesByApellido(busqueda);
                string json = new JavaScriptSerializer().Serialize(resultados);
                return json;
            }
            else
            {
                List<Paciente> resultados =
                    Paciente.BuscarPacientesByDNI(busqueda);
                string json = new JavaScriptSerializer().Serialize(resultados);
                return json;
            }            
        }

    }
}