using ConnectionDispensario.Conexiones;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ConnectionDispensario.Utils;

namespace ConnectionDispensario.Modelos
{
    [Serializable]
    public class PizarraPost
    {
        private int id;
        private string titulo;
        private int idprofesional;
        private DateTime fechacreacion;
        private int idpaciente;
        private string estado;
        List<PizarraComentario> comentarios;

        public int Id { get => id; set => id = value; }
        public string Titulo { get => titulo; set => titulo = value; }
        public int Idprofesional { get => idprofesional; set => idprofesional = value; }
        public DateTime Fechacreacion { get => fechacreacion; set => fechacreacion = value; }
        public int Idpaciente { get => idpaciente; set => idpaciente = value; }
        public string Estado { get => estado; set => estado = value; }
        internal List<PizarraComentario> Comentarios { get => comentarios; set => comentarios = value; }

        private Conexiones.Con_Pizarra CON = new Conexiones.Con_Pizarra();

        public PizarraPost()
        {

        }

        public PizarraPost(int id, string titulo, int idprofesional, DateTime fechacreacion, int idpaciente, string estado)
        {
            Id = id;
            Titulo = titulo;
            Idprofesional = idprofesional;
            Fechacreacion = fechacreacion;
            Idpaciente = idpaciente;
            Estado = estado;
            Comentarios = PizarraComentario.ComentariosPorPost(Id);
        }

        public PizarraPost(DataRow DR)
        {
            Id = int.Parse(DR["Id"].ToString());
            Titulo = DR["TituloPost"].ToString();
            Idprofesional = int.Parse(DR["IdProfesional"].ToString());
            Fechacreacion = DateTime.Parse(DR["FechaCreacion"].ToString());
            Idpaciente = int.Parse(DR["IdPaciente"].ToString());
            Estado = DR["Estado"].ToString();
            Comentarios = PizarraComentario.ComentariosPorPost(Id);
        }

        public int InsertarPost()
        {
            DataTable DT = CON.Insert_Post(Titulo, Idprofesional, Conversiones.SQL_To_FullString_DateTime(Fechacreacion), Idpaciente, Estado);

            if (DT != null)
            {
                int lastPostId = int.Parse(DT.Rows[0][0].ToString());
                return lastPostId;
            }
            else
            {
                return 0;
            }
            
        }

        public static bool ActualizarEstado(int idpost, string estado)
        {
            Con_Pizarra c = new Con_Pizarra();
            bool result = c.Update_PostStatus(idpost, estado);

            return result;
        }

        public static List<PizarraPost> PostsPorPaciente(int idpaciente)
        {
            Con_Pizarra c = new Con_Pizarra();
            DataTable DT = c.Select_PostsByIdPaciente(idpaciente);

            if (DT != null)
            {
                List<PizarraPost> aux = new List<PizarraPost>();
                foreach (DataRow post in DT.Rows)
                {
                    aux.Add(new PizarraPost(post));
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
