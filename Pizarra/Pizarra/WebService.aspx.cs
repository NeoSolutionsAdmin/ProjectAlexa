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

            string json = "null";

            if (Request["busquedaPaciente"] != null)
                json = GetPacientes(Request["busquedaPaciente"], Request["tipoDeDatos"]);
            if (Request["newPost"] != null)
                json = InsertPost(Request["titulo"], int.Parse(Request["idProfesional"]), int.Parse(Request["idPaciente"]));

            Response.Write(json);
            Response.Flush();
            Response.End();
        }

        private string InsertPost(
            string titulo,
            int idProfesional,
            int idPaciente)
        {
            int idNewPost = PizarraPost.InsertarPost(
                titulo,
                idProfesional,
                DateTime.Now,
                idPaciente,
                "Pendiente");
            

            if (idNewPost == 0)
                return "False";
            else return "True";

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