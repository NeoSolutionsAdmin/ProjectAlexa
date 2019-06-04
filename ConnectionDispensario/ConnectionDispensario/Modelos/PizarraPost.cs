using ConnectionDispensario.Conexiones;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ConnectionDispensario.Utils;
using ConnectionDispensario.Modelos;
using DotNetNuke.Entities.Users;

namespace ConnectionDispensario.Modelos
{
    [Serializable]
    public class PizarraPost
    {
        // Agregado un FechaCreacionString para parsear la fecha y visualizarla - 27/02/2019 - 16:10 - Losha
        // Agregado apellid y nombre del profesional para el View.ascx - 27/02/2019 - 23:10 - Losha
        // Cambiado List<PizarraComentario> de "internal" a "public" - 28/02/2019 - 
        private int id;
        private string titulo;
        private int idprofesional;
        private string nombreprofesional;
        private string apellidoprofesional;    
        private DateTime fechacreacion;
        private string fechacreacionstring;
        private int idpaciente;
        private string estado;
        private List<PizarraComentario> comentarios;

        public int Id { get => id; set => id = value; }
        public string Titulo { get => titulo; set => titulo = value; }
        public int Idprofesional { get => idprofesional; set => idprofesional = value; }
        public string NombreProfesional { get => nombreprofesional; set => nombreprofesional = value; }
        public string ApellidoProfesional { get => apellidoprofesional; set => apellidoprofesional = value; }
        public DateTime Fechacreacion { get => fechacreacion; set => fechacreacion = value; }
        public string FechaCreacionString { get => fechacreacionstring; set => fechacreacionstring = value; }
        public int Idpaciente { get => idpaciente; set => idpaciente = value; }
        public string Estado { get => estado; set => estado = value; }
        public List<PizarraComentario> Comentarios { get => comentarios; set => comentarios = value; }

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

        public List<PizarraComentario> GetComments()
        {
            List<PizarraComentario> comments = PizarraComentario.ComentariosPorPost(id);
            if (comments != null && comments.Count > 0)
            {
                return comments;
            }
            else
            {
                return null;
            }
        }

        public PizarraPost(DataRow DR)
        {
            Id = int.Parse(DR["Id"].ToString());
            Titulo = DR["TituloPost"].ToString();
            Idprofesional = int.Parse(DR["IdProfesional"].ToString());

            UserInfo ui = UserController.GetUserById(0, Idprofesional);
            NombreProfesional = ui.Username;
            ApellidoProfesional = ui.LastName;

            Fechacreacion = DateTime.Parse(DR["FechaCreacion"].ToString());
            FechaCreacionString = Fechacreacion.ToString();

            Idpaciente = int.Parse(DR["IdPaciente"].ToString());
            Estado = DR["Estado"].ToString();
            Comentarios = PizarraComentario.ComentariosPorPost(Id);
        }

        //Ahora pasó a ser estático y devuelve un DataRow en vez de un DataTable - 26/02/2019 - 01:00 - Losha
        public static int InsertarPost(
            string titulo,
            int idProfesional,
            DateTime fechaCreacion,
            int idPaciente,
            string estado)
        {

            DataRow DR = Conexiones.Con_Pizarra.Insert_Post(
                    titulo,
                    idProfesional,
                    Conversiones.SQL_To_FullString_DateTime(fechaCreacion),
                    idPaciente,
                    estado);

            if (DR != null)
            {
                int lastPostId = int.Parse(DR[0].ToString());
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
