using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos
{
    [Serializable]
    class Tag
    {
        private int id;
        private string nombre;
        private string icono;

        public string NOMBRE { get { return nombre; } set { nombre = value; } }
        public string ICONO { get { return icono; } set { icono = value; } }

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

    }
}
