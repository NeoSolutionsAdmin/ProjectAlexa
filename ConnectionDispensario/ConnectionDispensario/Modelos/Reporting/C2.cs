using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos.Reporting
{
    public class C2Item
    {
        int dia;
        int horasAtencion;

        int menor1m;
        int menor1f;

        int ano1m;
        int ano1f;

        int ano2a4m;
        int ano2a4f;

        int ano5a9m;
        int ano5a9f;

        int ano10a14m;
        int ano10a14f;

        int ano15a49m;
        int ano15a49f;

        int ano50ymasm;
        int ano50ymasf;

        int totalm;
        int totalf;
        int totalTotal;
        int totalPregnant;

        public int Dia { get => dia; set => dia = value; }
        public int HorasAtencion { get => horasAtencion; set => horasAtencion = value; }
        public int Menor1m { get => menor1m; set => menor1m = value; }
        public int Menor1f { get => menor1f; set => menor1f = value; }
        public int Ano1m { get => ano1m; set => ano1m = value; }
        public int Ano1f { get => ano1f; set => ano1f = value; }
        public int Ano2a4m { get => ano2a4m; set => ano2a4m = value; }
        public int Ano2a4f { get => ano2a4f; set => ano2a4f = value; }
        public int Ano5a9m { get => ano5a9m; set => ano5a9m = value; }
        public int Ano5a9f { get => ano5a9f; set => ano5a9f = value; }
        public int Ano10a14m { get => ano10a14m; set => ano10a14m = value; }
        public int Ano10a14f { get => ano10a14f; set => ano10a14f = value; }
        public int Ano15a49m { get => ano15a49m; set => ano15a49m = value; }
        public int Ano15a49f { get => ano15a49f; set => ano15a49f = value; }
        public int Ano50ymasm { get => ano50ymasm; set => ano50ymasm = value; }
        public int Ano50ymasf { get => ano50ymasf; set => ano50ymasf = value; }

        public int Totalm
        {
            get => menor1m + ano1m + ano2a4m + ano5a9m + ano10a14m + ano15a49m + ano50ymasm;
            set => totalm = value;
        }
        public int Totalf
        {
            get => menor1f + ano1f + ano2a4f + ano5a9f + ano10a14f + ano15a49f + ano50ymasf;
            set => totalf = value;
        }
        public int TotalTotal
        {
            get => totalm + totalf;
            set => totalTotal = value;
        }
        public int TotalPregnant { get => totalPregnant; set => totalPregnant = value; }
    }

    public class C2
    {
        public List<int> HorasAtencionPorDia;

        public List<C1Item> ItemsDeC1;

        public C2(int UserId)
        {
            int cantidadDiaMes = DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month);
            C1 c1 = new C1();
            ItemsDeC1 = c1.GetC1(new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1), new DateTime(DateTime.Now.Year, DateTime.Now.Month, cantidadDiaMes).AddHours(23), UserId ,"Finalizado");
            int totalhsatencion = 0;
            Conexiones.Con_Turno T = new Conexiones.Con_Turno();
            DataTable DT =  T.GetallC1(UserId);
            List<int> HorasPorDia = new List<int>();
            for (int a = 0; a < cantidadDiaMes; a++)
            {
                HorasPorDia.Add(0);
                for (int b = 0; b < DT.Rows.Count;b++)
                {
                    DateTime fechac1 = DateTime.Parse(DT.Rows[a]["fechaC1"].ToString());
                    int canthor = int.Parse(DT.Rows[a]["CantidadHoras"].ToString());
                    if (fechac1.Month == DateTime.Now.Month)
                    {
                        HorasPorDia[HorasPorDia.Count - 1] = HorasPorDia[HorasPorDia.Count - 1] + canthor;
                    }

                }
            }

            
            
            

        }

    }
}
