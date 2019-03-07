using DotNetNuke.Entities.Users;
using DotNetNuke.Security.Roles;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos.Reporting
{
    public class C3Item
    {
        int ID;
        string Servicio;
        int CodigoServicio;
        decimal HsDeAtencion;
        int Menor1M;
        int Menor1F;
        int año1M;
        int año1F;
        int año2a4M;
        int año2a4F;
        int año5a9M;
        int año5a9F;
        int año10a14M;
        int año10a14F;
        int año15a49M;
        int año15a49F;
        int año50M;
        int año50F;
        int ControlEmbarazo;

        public string Servicio1 { get => Servicio; set => Servicio = value; }
        public int CodigoServicio1 { get => CodigoServicio; set => CodigoServicio = value; }
        public decimal HsDeAtencion1 { get => HsDeAtencion; set => HsDeAtencion = value; }
        public int Menor1M1 { get => Menor1M; set => Menor1M = value; }
        public int Menor1F1 { get => Menor1F; set => Menor1F = value; }
        public int Año1M { get => año1M; set => año1M = value; }
        public int Año1F { get => año1F; set => año1F = value; }
        public int Año2a4M { get => año2a4M; set => año2a4M = value; }
        public int Año2a4F { get => año2a4F; set => año2a4F = value; }
        public int Año5a9M { get => año5a9M; set => año5a9M = value; }
        public int Año5a9F { get => año5a9F; set => año5a9F = value; }
        public int Año10a14M { get => año10a14M; set => año10a14M = value; }
        public int Año10a14F { get => año10a14F; set => año10a14F = value; }
        public int Año15a49M { get => año15a49M; set => año15a49M = value; }
        public int Año15a49F { get => año15a49F; set => año15a49F = value; }
        public int Año50M { get => año50M; set => año50M = value; }
        public int Año50F { get => año50F; set => año50F = value; }
        public int ControlEmbarazo1 { get => ControlEmbarazo; set => ControlEmbarazo = value; }
        public int ID1 { get => ID; set => ID = value; }
    }
    public class C3
    {
        
        private List<C3Item> myItems;
        public C3() { }

        public List<C3Item> MyItems { get => myItems; set => myItems = value; }

        public List<C3Item> GetC3(int year, int month,int countdays)
        {

            List<C3Item> I = new List<C3Item>();

            List<Servicio> LS = Servicio.ObtenerServicios();
            if (LS != null)
            {
                for (int a=0; a<LS.Count;a++)
                {
                    Servicio srv = LS[a];
                    I.Add(new C3Item());
                    I[I.Count - 1].ID1 = a + 1;
                    I[I.Count - 1].Servicio1 = LS[a].NOMBRE;
                    if (LS[a].CODIGO == null) { I[I.Count - 1].CodigoServicio1 = 0; } else { I[I.Count - 1].CodigoServicio1 = int.Parse(LS[a].CODIGO); } 
                    List<Jornada> ListadoJornadas = Jornada.SelectClosedJornadasByEntireMonth(year, month, countdays, srv.ID);
                    if (ListadoJornadas != null)
                    {
                        foreach (Jornada j in ListadoJornadas)
                        {
                            I[I.Count - 1].HsDeAtencion1 = I[I.Count - 1].HsDeAtencion1 + (decimal)(j.End.Value-j.Start).TotalMinutes / 60;
                            List<Turno> T = Turno.GetTurnosByPeriod(j.Start, j.End.Value, j.USERID.Value, "Finalizado");

                            if (T != null)
                            {
                                foreach (Turno t in T)
                                {
                                    if (t.Pac != null)
                                    {

                                        Paciente p = t.Pac;
                                        int age = ConnectionDispensario.Utils.Conversiones.getAge(p.FECHA_NACIMIENTO);
                                        string sex = "";
                                        if (p.SEXO == "Masculino") { sex = "m"; } else { sex = "f"; }
                                        if (sex == "m")
                                        {
                                            
                                            if (age < 1) I[I.Count - 1].Menor1M1++;
                                            if (age == 1) I[I.Count - 1].Año1M++;
                                            if (age > 1 && age < 5) I[I.Count - 1].Año2a4M++;
                                            if (age > 4 && age < 10) I[I.Count - 1].Año5a9M++;
                                            if (age > 9 && age < 15) I[I.Count - 1].Año10a14M++;
                                            if (age > 14 && age < 50) I[I.Count - 1].Año15a49M++;
                                            if (age > 49) I[I.Count - 1].Año50M++;


                                        }
                                        else
                                        {

                                            if (age < 1) I[I.Count - 1].Menor1F1++;
                                            if (age == 1) I[I.Count - 1].Año1F++;
                                            if (age > 1 && age < 5) I[I.Count - 1].Año2a4F++;
                                            if (age > 4 && age < 10) I[I.Count - 1].Año5a9F++;
                                            if (age > 9 && age < 15) I[I.Count - 1].Año10a14F++;
                                            if (age > 14 && age < 50) I[I.Count - 1].Año15a49F++;
                                            if (age > 49) I[I.Count - 1].Año50F++;
                                        }

                                        if (t.ControlEmbarazo == true) { I[I.Count - 1].ControlEmbarazo1++; }
                                    }
                                }
                            }

                        }
                    }


                }
            }


            return I;
        }

    }
}
