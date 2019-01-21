using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ConnectionDispensario.Modelos;
using System.Web.Script.Serialization;

namespace Christoc.Modules.Pacientes
{
    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ClearHeaders();

            if (Request["addTag"] != null) AttachTag(int.Parse(Request["idPaciente"]), int.Parse(Request["idTag"]));
            if (Request["deleteTag"] != null) DetachTag(int.Parse(Request["idPaciente"]), int.Parse(Request["idTag"]));
            if (Request["listTags"] != null) ListTags(int.Parse(Request["idPaciente"]));

            Response.Flush();
            Response.End();
        }

        private void ListTags(int idPaciente)
        {
            List<Tag> listaTags = Paciente.TagsPorPaciente(idPaciente);
            string jsontags = new JavaScriptSerializer().Serialize(listaTags);
            Response.Write(jsontags);
        }

        private void AttachTag(int idPaciente, int idTag)
        {
            bool yaExistente = false;
            List<Tag> ListaTags = Paciente.TagsPorPaciente(idPaciente);
            if (idTag == 0)
            {
                Response.Write("empty");
            }
            else
            {
                if (ListaTags != null)
                {
                    foreach (Tag tag in ListaTags)
                    {
                        //Response.Write(ListaTags.Count);
                        if (tag.ID == idTag)
                        {
                            yaExistente = true;
                            break;
                        }
                    }
                }

                if (yaExistente)
                {
                    Response.Write("duplicated");
                }
                else
                {
                    Paciente.AgregarTagAPaciente(idPaciente, idTag);
                    Response.Write("done");
                }
            }
        }

        private void DetachTag(int idPaciente, int idTag)
        {
            Paciente aux = Paciente.Select_Paciente_By_Id(idPaciente);
            aux.BorrarTag(idTag);
            Response.Write("done");
        }


    }
}