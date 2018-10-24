using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace ConnectionDispensario.Modelos
{
    public class Toxicologia
    {
        public int IdPaciente;
        public string NameToxicologia;
        public int ID;

        public Toxicologia(int p_IdPaciente, string p_Toxicologia)
        {
            IdPaciente = p_IdPaciente;
            NameToxicologia = p_Toxicologia;
        }

        public Toxicologia(DataRow p_DR) 
        {
            ID = int.Parse(p_DR["Id"].ToString());
            NameToxicologia = p_DR["Toxicologia"].ToString();
            IdPaciente = int.Parse(p_DR["IdPaciente"].ToString());
        }

        public Boolean Guardar() 
        {
            Conexiones.Con_Toxicologia CM = new Conexiones.Con_Toxicologia();
            return CM.Insertar_Toxicologia(IdPaciente, NameToxicologia);

        }

        public static Boolean Borrar(int IdToxicologia)
        {
            return new Conexiones.Con_Toxicologia().Borrar_Toxicologia(IdToxicologia);
        }


        public static List<Toxicologia> GetToxicologiaByIdPaciente(int IdPaciente) 
        {
            DataTable Result = new Conexiones.Con_Toxicologia().Select_Toxicologia(IdPaciente);
            List<Toxicologia> MyTemp;
            if (Result != null) 
            {
                MyTemp = new List<Toxicologia>();
                for (int a = 0; a < Result.Rows.Count; a++) 
                {
                    MyTemp.Add(new Toxicologia(Result.Rows[a]));
                }
                return MyTemp;
            } else { return null; }
        }
    }
}
