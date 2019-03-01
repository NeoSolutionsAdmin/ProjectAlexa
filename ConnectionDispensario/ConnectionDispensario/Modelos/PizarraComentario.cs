using ConnectionDispensario.Conexiones;
using ConnectionDispensario.Utils;
using DotNetNuke.Entities.Users;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos
{
    [Serializable]
    public class PizarraComentario
    {
        //Agregado apellido, nombre y fechastring para más comodidad - 28/02/2019 12:14 - Losha
        int id;
        int idpost;
        string comentario;

        int idprofesional;
        string nombreprofesional;
        string apellidoprofesional;

        DateTime fechacreacion;
        string fechacreacionstring;


        public int Id { get => id; set => id = value; }
        public int Idpost { get => idpost; set => idpost = value; }
        public string Comentario { get => comentario; set => comentario = value; }

        public int Idprofesional { get => idprofesional; set => idprofesional = value; }
        public string NombreProfesional { get => nombreprofesional; set => nombreprofesional = value; }
        public string ApellidoProfesional { get => apellidoprofesional; set => apellidoprofesional = value; }

        public DateTime Fechacreacion { get => fechacreacion; set => fechacreacion = value; }
        public string FechaCreacionString { get => fechacreacionstring; set => fechacreacionstring = value; }

        Con_Pizarra CON = new Con_Pizarra();

        public PizarraComentario()
        {

        }

        public PizarraComentario(int id, int idpost, string comentario, int idprofesional, DateTime fechacreacion)
        {
            Id = id;
            Idpost = idpost;
            Comentario = comentario;
            Idprofesional = idprofesional;
            Fechacreacion = fechacreacion;
        }

        public PizarraComentario(DataRow DR)
        {
            Id = int.Parse(DR["Id"].ToString());
            Idpost = int.Parse(DR["IdPost"].ToString());
            Comentario = DR["Comentario"].ToString();
            Idprofesional = int.Parse(DR["IdProfesional"].ToString());

            UserInfo ui = UserController.GetUserById(0, Idprofesional);
            NombreProfesional = ui.FirstName;
            ApellidoProfesional = ui.LastName;

            Fechacreacion = DateTime.Parse(DR["FechaCreacion"].ToString());
            FechaCreacionString = Fechacreacion.ToString();
        }

        public int InsertarComentario()
        {
            DataTable DT = CON.Insertar_ComentarioPizarra(Idpost, Comentario, Idprofesional, Conversiones.SQL_To_FullString_DateTime(Fechacreacion));
            
            if (DT != null)
            {
                int lastcommentId = int.Parse(DT.Rows[0][0].ToString());
                return lastcommentId;
            }
            else
            {
                return 0;
            }
        }

        public static List<PizarraComentario> ComentariosPorPost(int idpost)
        {
            Con_Pizarra c = new Con_Pizarra();
            DataTable DT = c.Select_ComentariosByIdPost(idpost);
            
            if (DT != null)
            {
                List<PizarraComentario> aux = new List<PizarraComentario>();
                foreach (DataRow comentario in DT.Rows)
                {
                    aux.Add(new PizarraComentario(comentario));
                }
                return aux;
            }
            else
            {
                return null;
            }
        }
    }
}
