using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos
{
    [Serializable]
    public class Tag
    {
        private int id;
        private string nombre;
        private string icono;

        public string NOMBRE { get { return nombre; } set { nombre = value; } }
        public string ICONO { get { return icono; } set { icono = value; } }
        public int ID { get { return id; } set { id = value; } }

        public Tag()
        {

        }

        public Tag(string p_nombre, string p_icono)
        {
            nombre = p_nombre;
            icono = p_icono;
        }

        public Tag(DataRow DR)
        {
            id = int.Parse(DR["Id"].ToString());
            nombre = DR["Nombre"].ToString();
            icono = DR["Icono"].ToString();
        }

        public static bool AgregarTag(Tag tag)
        {
            Conexiones.Con_Tags CT = new Conexiones.Con_Tags();
            bool flag = CT.AgregarTag(tag);
            return flag;
        }

        public static bool EliminarTag(int idTag)
        {
            Conexiones.Con_Tags CT = new Conexiones.Con_Tags();
            bool flag = CT.BorrarTag(idTag);
            return flag;
        }

        public static List<Tag> GetTags()
        {
            Conexiones.Con_Tags CT = new Conexiones.Con_Tags();
            DataTable DT = CT.GetTagByTagName("%");

            if (DT != null && DT.Rows.Count > 0)
            {
                List<Tag> LT = new List<Tag>();
                foreach (DataRow DR in DT.Rows)
                {
                    LT.Add(new Tag(DR));
                }
                return LT;
            }
            return null;
        }



        public static List<Tag> GetTagByTagName(string name)
        {
            Conexiones.Con_Tags CT = new Conexiones.Con_Tags();
            DataTable DT = CT.GetTagByTagName(name);

            if(DT != null && DT.Rows.Count > 0)
            {
                List<Tag> LT = new List<Tag>();
                foreach (DataRow DR in DT.Rows)
                {
                    LT.Add(new Tag(DR));
                }
                return LT;
            }
            return null;            
        }

        public static List<int> GetCharsDiscriminados()
        {
            Conexiones.Con_Tags CT = new Conexiones.Con_Tags();
            DataTable DT = CT.GetCharsDiscriminados();

            if(DT!= null && DT.Rows.Count > 0)
            {
                List<int> LI = new List<int>();
                for(int a = 0; a < DT.Rows.Count; a++)
                {                    
                    LI.Add(Convert.ToInt32(DT.Rows[a][0]));
                }
                return LI;
            }
            return null;
        }
    }
}
