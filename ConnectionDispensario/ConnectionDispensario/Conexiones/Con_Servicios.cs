using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Conexiones
{
    public class Con_Servicios
    {
        public bool InsertServicio(string nombreservicio)
        {
            QTACustomizado QTA = new QTACustomizado();
            if (QTA.Insert_Servicio(nombreservicio) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
