using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Conexiones
{
    public class Con_Riesgo
    {

        
        public DataTable Get_Riesgo(bool Diabetes, string Sexo, int Edad, bool tabaquismo)
        {
            DispensarioACDataSet.Select_RiesgoDataTable DT = new DispensarioACDataSet.Select_RiesgoDataTable();
            DispensarioACDataSetTableAdapters.Select_RiesgoTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_RiesgoTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Connection = SQLCONN;
            TA.Fill(DT,Diabetes,Sexo,Edad,tabaquismo);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }
    }
}
