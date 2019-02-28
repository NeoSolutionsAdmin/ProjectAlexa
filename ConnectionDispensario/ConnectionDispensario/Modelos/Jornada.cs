using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos
{
    public class Jornada
    {

        public int? Id;
        public int? USERID;
        public DateTime Start;
        public DateTime? End;
        public decimal? Horas;
        public int? IdServicio;

        private Jornada(DataRow dr)
        {
            Id = int.Parse(dr["Id"].ToString());
            USERID = int.Parse(dr["UserId"].ToString());
            Start = DateTime.Parse(dr["EntradaJornada"].ToString());
            if (dr.IsNull("SalidaJornada") == false) { End = DateTime.Parse(dr["SalidaJornada"].ToString()); }
            if (dr.IsNull("Horas") == false) { decimal.Parse( (dr["Horas"].ToString())); }
            if (dr.IsNull("IdServicio") == false) { IdServicio = int.Parse(dr["IdServicio"].ToString()); }
        }

        public decimal ExitJornada()
        {
            TimeSpan TS = (DateTime)Start - DateTime.Now.AddMinutes(2);
            Horas = Convert.ToDecimal(TS.TotalHours);
            End = DateTime.Now.AddMinutes(2);
            Conexiones.Con_Jornada.UpdateJornada((int)Id, (Convert.ToDecimal(TS.TotalHours)));
            return (decimal)Horas; 
        }

        public static Jornada GetLast(int UserId)
        {
            DataRow dr = Conexiones.Con_Jornada.GetLastJornada(UserId);
            if (dr != null)
            {
                return new Jornada(dr);
            }
            else
            {
                return null;
            }
        }

        public static List<Jornada> SelectClosedJornadasByDateAndIdService(int year, int month, int day, int idservice)
        {
            DataTable DT = Conexiones.Con_Jornada.GetClosedByIdServiceAndDate(year, month, day, idservice);
            if (DT != null)
            {
                List<Jornada> J = new List<Jornada>();
                foreach (DataRow R in DT.Rows)
                {
                    J.Add(new Jornada(R));
                }
                return J;
            }
            else
            {
                return null;
            }
        }

        public static void Insert(int UserId, int ServicioId)
        {
            Conexiones.Con_Jornada.InsertarJornada(UserId, ServicioId);
        }

        public static List<Jornada> GetPeriod(int UserId, DateTime Start, DateTime End)
        {
            
            DataTable dt = Conexiones.Con_Jornada.GetPeriodo(Start, End, UserId);
            if (dt != null)
            {
                List<Jornada> lj = new List<Jornada>();
                for (int a = 0; a < dt.Rows.Count; a++)
                {
                    Jornada j = new Jornada(dt.Rows[a]);
                    if (j.End != null) { 
                    lj.Add(j);
                    }
                }
                return lj;
            }
            else return null;
        }


    }
}
