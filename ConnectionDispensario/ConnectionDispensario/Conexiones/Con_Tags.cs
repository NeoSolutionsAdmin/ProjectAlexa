using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace ConnectionDispensario.Conexiones
{
    class Con_Tags
    {
        QTACustomizado QTA = new QTACustomizado();

        public bool AgregarTag(Modelos.Tag p_tag)
        {
            int c = QTA.Insert_Tag(p_tag.NOMBRE, p_tag.ICONO);
            if (c > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool BorrarTag(Modelos.Tag p_tag)
        {
            int c = QTA.Delete_Tag(p_tag.ID);
            if (c > 0)
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
