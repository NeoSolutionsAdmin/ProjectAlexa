using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace ConnectionDispensario.Modelos
{
    public class Servicio
    {
        private string name="";
        private int id;

        public string NOMBRE { get { return name; } }

        public Servicio(string p_name)
        {
            name = p_name;
        }

        private Servicio(DataRow dr)
        {
            id = int.Parse(dr["Id"].ToString());
            name = dr["NombreServicio"].ToString();
        }

        public bool Guardar()
        {
            if (name != "")
            {
                Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
                return C.InsertServicio(name);
            }
            else
            {
                return false;
            }
        }

        public static List<Servicio> ObtenerServicios()
        {
            Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
            DataTable DT = C.GetAll();
            if (DT != null)
            {
                List<Servicio> LS = new List<Servicio>();
                foreach (DataRow dr in DT.Rows)
                {
                    LS.Add(new Servicio(dr));
                }
                return LS;
            }
            else
            {
                return null;
            }
        }
        

    }
}
