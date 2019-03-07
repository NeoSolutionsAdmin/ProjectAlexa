using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DotNetNuke.Entities.Users;

namespace ConnectionDispensario.Modelos
{
    public class ProfesionalServicio
    {

        public int idServicio;
        public int idProfesional;
        public int id;
        public Usuario user;

        public ProfesionalServicio(DataRow dr)
        {
            idServicio = int.Parse(dr["IdServicio"].ToString());
            idProfesional = int.Parse(dr["IdProfesional"].ToString());
            id = int.Parse(dr["Id"].ToString());
            DotNetNuke.Entities.Users.UserController UC = new DotNetNuke.Entities.Users.UserController();
            UserInfo UI = UC.GetUser(0, idProfesional);
            user = Usuario.GetUserByUserInfo(UI);
        }

        public static ProfesionalServicio GetLast()
        {
            Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
            DataRow dr = C.GetLastProfesionalServicio();
            if (dr != null)
            {
                ProfesionalServicio PS = new ProfesionalServicio(dr);
                return PS;
            }
            else
            {
                return null;
            }
        }

        
    }

    public class Servicio
    {
        private string name="";
        private int id=0;
        private string codigo = null;


        public string NOMBRE { get { return name; } }
        public int ID { get { return id; } }
        public string CODIGO { get { return codigo; } }
        

        public Servicio(string p_name)
        {
            name = p_name;
        }

        private Servicio(DataRow dr)
        {
            id = int.Parse(dr["Id"].ToString());
            name = dr["NombreServicio"].ToString();
            if (dr.IsNull("Codigo") == false) { codigo = dr["Codigo"].ToString(); }
        }

        public List<ProfesionalServicio> GetProfesionales(int PortalId)
        {
            Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
            DataTable DT = C.GetProfesionalesID(id);
            if (DT != null)
            {
                List<ProfesionalServicio> LU = new List<ProfesionalServicio>();
                foreach (DataRow dr in DT.Rows)
                {
                    LU.Add(new ProfesionalServicio(dr));
                }
                return LU;
            }
            else
            {
                return null;
            }
        }
        
        public bool Insert_Profesional(int idprofesional)
        {
            if (id != 0)
            {
                Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
                return C.InsertProfesionalServicio(idprofesional, id);

            }
            else
            {
                return false;
            }

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

        public static bool DeleteProfesionalServicioById(int ID)
        {
            Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
            return C.DeleteProfesionalServicioById(ID);
        }

        public static Servicio ObtenerUltimoServicio()
        {
            Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
            DataRow dr = C.GetLast();
            if (dr != null)
            {
                return new Servicio(dr);
            }
            else
            {
                return null;
            }
        }

        public static Servicio ObtenerServicioById(int Id)
        {
            Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
            DataRow dr = C.GetServicioById(Id);
            if (dr != null)
            {
                return new Servicio(dr);
            }
            else
            {
                return null;
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
        
        public static List<Servicio> ObtenerServiciosPorProfesional(int IdProfesional)
        {
            Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
            DataTable DT = C.GetServiciosByUser(IdProfesional);
            if (DT!= null)
            {
                List<Servicio> LS = new List<Servicio>();
                foreach (DataRow dr in DT.Rows)
                {

                    LS.Add(Servicio.ObtenerServicioById(int.Parse( dr["IdServicio"].ToString() )));
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
