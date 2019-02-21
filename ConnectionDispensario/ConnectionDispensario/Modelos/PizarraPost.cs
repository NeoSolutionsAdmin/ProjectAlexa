using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos
{
    [Serializable]
    class PizarraPost
    {
        private int id;
        private string titulo;
        private int idprofesional;
        private DateTime fechacreacion;
        private int idpaciente;
        private string estado;

        public int Id { get => id; set => id = value; }
        public string Titulo { get => titulo; set => titulo = value; }
        public int Idprofesional { get => idprofesional; set => idprofesional = value; }
        public DateTime Fechacreacion { get => fechacreacion; set => fechacreacion = value; }
        public int Idpaciente { get => idpaciente; set => idpaciente = value; }
        public string Estado { get => estado; set => estado = value; }

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
        }

        public PizarraPost(DataRow DR)
        {
            Id = int.Parse(DR["Id"].ToString());
            Titulo = DR["TituloPost"].ToString();
            Idprofesional = int.Parse(DR["IdProfesional"].ToString());
            Fechacreacion = DateTime.Parse(DR["FechaCreacion"].ToString());
            Idpaciente = int.Parse(DR["IdPaciente"].ToString());
            Estado = DR["Estado"].ToString();
        }

        /*public static InsertarPost(string titulo, int idprofesional, DateTime fechacreacion, int idpaciente, string estado)
        {

        }*/
    }
}
