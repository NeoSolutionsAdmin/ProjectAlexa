using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace ConnectionDispensario.Conexiones
{
    public class Con_Toxicologia
    {
        public bool Insertar_Toxicologia(int IdPaciente, string Toxicologia)
        {
            QTACustomizado QTA = new QTACustomizado();
            int cant = QTA.Insert_Toxicologia(IdPaciente, Toxicologia);
            if (cant > 0)
            {
                return true;
            }
            else 
            {
                return false;
            }
        }

        public bool Borrar_Toxicologia(int Id)
        {
            QTACustomizado QTA = new QTACustomizado();
            int cant = QTA.Delete_Toxicologia(Id);
            if (cant > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public DataTable Select_Toxicologia(int IdPaciente) 
        {
            DispensarioACDataSet.Select_ToxicologiaDataTable DT = new DispensarioACDataSet.Select_ToxicologiaDataTable();
            DispensarioACDataSetTableAdapters.Select_ToxicologiaTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_ToxicologiaTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Connection = SQLCONN;
            TA.Fill(DT, IdPaciente);
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
