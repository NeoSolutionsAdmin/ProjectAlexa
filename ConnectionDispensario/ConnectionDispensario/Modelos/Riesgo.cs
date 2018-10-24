using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos
{
    public class Riesgo
    {

        /*Id	Diabetes	Sexo	Edad	Tabaquismo	PAS	Colesterol	Riesgo*/


        public int ID;
        public Boolean Diabetes;
        public string Sexo;
        public int Edad;
        public Boolean Tabaquismo;
        public int PAS;
        public Decimal Colesterol;
        public string RiesgoCV;

        public Riesgo() { }

        public Riesgo(DataRow DR)
        {
            ID = int.Parse(DR["Id"].ToString());
            Diabetes = Boolean.Parse(DR["Diabetes"].ToString());
            Sexo = DR["Sexo"].ToString();
            Edad = int.Parse(DR["Edad"].ToString());
            Tabaquismo= Boolean.Parse(DR["Tabaquismo"].ToString());
            PAS = int.Parse(DR["PAS"].ToString());
            Colesterol = Decimal.Parse(DR["Colesterol"].ToString());
            RiesgoCV = DR["Riesgo"].ToString();
            
        }

        public List<Riesgo> GetRiesgo(bool p_Diabetes, string p_Sexo, int p_Edad, bool p_Tabaquismo)
        {
            List<Riesgo> RiesgoList = new List<Riesgo>();
            Conexiones.Con_Riesgo C = new Conexiones.Con_Riesgo();
            DataTable DT = C.Get_Riesgo(p_Diabetes, p_Sexo, p_Edad, p_Tabaquismo);
            if (DT != null && DT.Rows.Count > 0)
            {
                for (int a = 0; a < DT.Rows.Count; a++)
                {
                    RiesgoList.Add(new Riesgo(DT.Rows[a]));
                }
                return RiesgoList;
            }
            else {
                return null;
            }
        }
    }
}
