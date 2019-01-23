using System;
using System.Collections.Generic;
using System.Data;
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

        public DataTable GetAll()
        {
            DispensarioACDataSet.Select_AllServiciosDataTable DT = new DispensarioACDataSet.Select_AllServiciosDataTable();
            DispensarioACDataSetTableAdapters.Select_AllServiciosTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_AllServiciosTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT);
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
