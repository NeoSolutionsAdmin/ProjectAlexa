using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;

namespace ConnectionDispensario.Modelos
{
    public class UserFields
    {
        string FieldName;
        string FieldValue;
    }

    public class Usuario
    {

        int userid;
        string name;
        string lastname;
        UserInfo Ui = null;


        
        public int USERID { get { return userid; } }
        public string NAME { get { return name; } }
        public string LASTNAME { get { return lastname; } }
        [ScriptIgnore]
        public UserInfo USERINFO { get { return Ui; } }

        

        public Usuario(DotNetNuke.Entities.Users.UserInfo p_UI)
        {
            name = p_UI.FirstName;
            lastname = p_UI.LastName;
            userid = p_UI.UserID;
            Ui = p_UI;
            
        }


        public Usuario(int IdUser, int PortalId)
        {

            UserController UC = new UserController();
            Ui = UC.GetUser(PortalId,IdUser);
            userid = Ui.UserID;
            name = Ui.FirstName;
            lastname = Ui.LastName;
            

        }

        public static List<Usuario> GetUsers(int PortalId)
        {
            ArrayList AL = UserController.GetUsers(PortalId);
            List<Usuario> lu = new List<Usuario>();
            foreach (object o in AL)
            {
                UserInfo UI = o as UserInfo;
                lu.Add(new Usuario(UI));


            }
            if (lu.Count > 0)
            {
                return lu;
            }
            else
            {
                return null;
            }
        }

        public bool InsertServicio(int idservicio)
        {
            Conexiones.Con_Servicios C = new Conexiones.Con_Servicios();
            return C.InsertProfesionalServicio(userid, idservicio);
        }

        public static List<ProfesionalServicio> GetUsersByServicio(int IdServicio, int PortalId)
        {
            Conexiones.Con_Servicios CS = new Conexiones.Con_Servicios();
            DataTable dt = CS.GetProfesionalesID(IdServicio);
            if (dt!= null)
            {
                List<ProfesionalServicio> u = new List<ProfesionalServicio>();
                foreach (DataRow a in dt.Rows)
                {
                    u.Add(new ProfesionalServicio(a));
                }
                return u;
            }
            else
            {
                return null;
            }
        }

        public bool ExisteEnServicio(int IdServicio)
        {
            Conexiones.Con_Servicios S = new Conexiones.Con_Servicios();
            return S.ExisteEnServicio(IdServicio, USERID);
        }

        public static Usuario GetUserByUserInfo(DotNetNuke.Entities.Users.UserInfo UI)
        {
            if (UI != null)
            {
                return new Usuario(UI);
            } else
            {
                return null;
            }
        }
    }
}
