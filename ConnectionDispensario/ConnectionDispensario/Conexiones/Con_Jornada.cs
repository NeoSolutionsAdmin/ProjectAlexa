using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Conexiones
{
    public static class Con_Jornada
    {
        public static void InsertarJornada(int UserId, int ServicioId)
        {
            QTACustomizado QTA = new QTACustomizado();
            QTA.InsertarPeriodo_Cronograma_Entrada(UserId, Utils.Conversiones.SQL_To_FullString_DateTime(DateTime.Now), ServicioId); 
        }

        public static void UpdateJornada(int JornadaId, decimal Horas)
        {
            QTACustomizado QTA = new QTACustomizado();
            QTA.InsertarPeriodo_Cronograma_Salida(JornadaId, Utils.Conversiones.SQL_To_FullString_DateTime(DateTime.Now), Horas);
        }

        public static DataTable GetClosedByIdServiceAndDate(int year, int month, int day, int service)
        {

            DispensarioACDataSet.Select_JornadaLaboralByIdServicioAndDateComienzoDataTable DT = new DispensarioACDataSet.Select_JornadaLaboralByIdServicioAndDateComienzoDataTable();
            DispensarioACDataSetTableAdapters.Select_JornadaLaboralByIdServicioAndDateComienzoTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_JornadaLaboralByIdServicioAndDateComienzoTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "mi clase");
            TA.Connection = SQLCONN;
            try{
                TA.Fill(DT, day, month, year, service);
                if (DT.Rows.Count > 0)
                {
                    return DT;
                }
                else
                {
                    return null;

                }
            } catch (Exception E)
            {
                
                throw new Exception(day.ToString() + month.ToString() + year.ToString());
            }

        }


        public static DataTable GetClosedByIdServiceEntireMonth(int year, int month, int countday, int service)
        {

            DispensarioACDataSet.Select_JornadaLaboralByIdServicioAndEntireMonthDataTable DT = new DispensarioACDataSet.Select_JornadaLaboralByIdServicioAndEntireMonthDataTable();
            DispensarioACDataSetTableAdapters.Select_JornadaLaboralByIdServicioAndEntireMonthTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_JornadaLaboralByIdServicioAndEntireMonthTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "mi clase");
            TA.Connection = SQLCONN;
            TA.Fill(DT, countday, month, year, service);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }

        }

        public static DataRow GetLastJornada(int UserId)
        {
            DispensarioACDataSet.SeleccionarPeriodo_Cronograma_UltimoDataTable DT = new DispensarioACDataSet.SeleccionarPeriodo_Cronograma_UltimoDataTable();
            DispensarioACDataSetTableAdapters.SeleccionarPeriodo_Cronograma_UltimoTableAdapter TA = new DispensarioACDataSetTableAdapters.SeleccionarPeriodo_Cronograma_UltimoTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "mi clase");
            TA.Connection = SQLCONN;
            TA.Fill(DT,UserId);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }
        }

        public static DataTable GetPeriodo(DateTime Start, DateTime End, int UserId) 
        {
            DispensarioACDataSet.SeleccionarPeriodo_Cronograma_PeriodoDataTable DT = new DispensarioACDataSet.SeleccionarPeriodo_Cronograma_PeriodoDataTable();
            DispensarioACDataSetTableAdapters.SeleccionarPeriodo_Cronograma_PeriodoTableAdapter TA = new DispensarioACDataSetTableAdapters.SeleccionarPeriodo_Cronograma_PeriodoTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "mi clase");
            TA.Connection = SQLCONN;
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
