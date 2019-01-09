﻿using System;
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

        private Jornada(DataRow dr)
        {
            Id = int.Parse(dr["Id"].ToString());
            USERID = int.Parse(dr["UserId"].ToString());
            Start = DateTime.Parse(dr["EntradaJornada"].ToString());
            if (dr.IsNull("SalidaJornada") == false) { End = DateTime.Parse(dr["SalidaJornada"].ToString()); }
            if (dr.IsNull("Horas") == false) { decimal.Parse( (dr["Horas"].ToString())); }
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

        public static void Insert(int UserId)
        {
            Conexiones.Con_Jornada.InsertarJornada(UserId);
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