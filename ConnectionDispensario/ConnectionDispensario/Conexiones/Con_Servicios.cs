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



        public DataRow GetLast()
        {
            DispensarioACDataSet.Select_LastServicioDataTable DT = new DispensarioACDataSet.Select_LastServicioDataTable();
            DispensarioACDataSetTableAdapters.Select_LastServicioTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_LastServicioTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }

        }

        public bool ExisteEnServicio(int idServicio, int idProfesional)
        {
            DispensarioACDataSet.Select_ProfesionalServicioByBothIdDataTable DT = new DispensarioACDataSet.Select_ProfesionalServicioByBothIdDataTable();
            DispensarioACDataSetTableAdapters.Select_ProfesionalServicioByBothIdTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_ProfesionalServicioByBothIdTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT, idProfesional, idServicio);
            if (DT.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public DataTable GetProfesionalesID(int idServicio)
        {
            DispensarioACDataSet.Select_IdProfesionalesByIdServiciosDataTable DT = new DispensarioACDataSet.Select_IdProfesionalesByIdServiciosDataTable();
            DispensarioACDataSetTableAdapters.Select_IdProfesionalesByIdServiciosTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_IdProfesionalesByIdServiciosTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT, idServicio);
            if (DT.Rows.Count > 0)
            {
                
                return DT;
            }
            else
            {
                return null;
            }
        }

        public bool InsertProfesionalServicio(int idprofesional, int idservicio)
        {
            QTACustomizado QTA = new QTACustomizado();
            int res = QTA.Insert_ProfesionalServicio(idprofesional, idservicio);
            if (res > 0)
            {
                return true;
            }
            else
            {
                return false;
            }


        }

        public DataRow GetLastProfesionalServicio()
        {
            DispensarioACDataSet.Select_LastProfesionalServicioDataTable DT = new DispensarioACDataSet.Select_LastProfesionalServicioDataTable();
            DispensarioACDataSetTableAdapters.Select_LastProfesionalServicioTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_LastProfesionalServicioTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
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
