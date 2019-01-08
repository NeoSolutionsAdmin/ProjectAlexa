using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

        
        public int USERID { get { return userid; } }
        public string NAME { get { return name; } }
        public string LASTNAME { get { return lastname; } }


        public Usuario(DotNetNuke.Entities.Users.UserInfo p_UI)
        {
            name = p_UI.FirstName;
            lastname = p_UI.LastName;
            userid = p_UI.UserID;

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
