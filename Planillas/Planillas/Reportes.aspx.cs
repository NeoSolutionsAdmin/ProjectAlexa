using DotNetNuke.Entities.Users;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using ConnectionDispensario.Modelos.Reporting;
using ConnectionDispensario.Modelos;

namespace Christoc.Modules.Planillas
{
    public partial class Reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            filenamefield.ClientIDMode = ClientIDMode.Static;

            if (!IsPostBack)
            {
                string filename = Guid.NewGuid().ToString() + ".pdf";
                string filenameExcel = Guid.NewGuid().ToString() + ".xls";
                filenamefield.Value = filename;
                bool Validate = true;
                if (Request["C1"] == null && Request["C2"] == null && Request["C3"] == null)
                {
                    Validate = false;
                }
                if (Request["C1"] != null) GenerateC1();
                if (Request["C2"] != null) GenerateC2();
                if (Request["C3"] != null) GenerateC3();

                if (Validate == true)
                {
                    RV.LocalReport.Refresh();
                    byte[] b = RV.LocalReport.Render("PDF");
                    byte[] excelb = RV.LocalReport.Render("Excel");


                    string path = Server.MapPath(DotNetNuke.Entities.Portals.PortalSettings.Current.HomeDirectory);
                    File.WriteAllBytes(path + "\\" + filename, b);
                    File.WriteAllBytes(path + "\\" + filenameExcel, excelb);
                }
                Response.Redirect("/Portals/0/" + filenameExcel);

            }
        }

        protected void GenerateC1()
        {
            RV.LocalReport.ReportPath = MapPath("/DesktopModules/Turnero/Reports/ReportC1.rdlc");

            ConnectionDispensario.Modelos.Reporting.C1 C1 = new ConnectionDispensario.Modelos.Reporting.C1();

            int PID = int.Parse(Request["PID"].ToString());
            int UID = int.Parse(Request["UID"].ToString());
            string Y = Request["Y"].ToString();
            string MS = Request["MS"].ToString();
            string ME = Request["ME"].ToString();
            string DS = Request["DS"].ToString();
            string DE = Request["DE"].ToString();
            string HS = Request["HS"].ToString();
            string HE = Request["HE"].ToString();
            string MinStart = Request["MinStart"].ToString();
            string MinEnd = Request["MinEnd"].ToString();
            string Est = Request["EST"].ToString();
            string Servicio = Request["SERV"].ToString();

            string datestart = Y + "-" + MS + "-" + DS + " " + HS + ":" + MinStart +  ":00";
            string dateend = Y + "-" + ME + "-" + DE + " " + HE + ":" + MinEnd + ":00";

            ConnectionDispensario.Conexiones.Con_Turno Conturn = new ConnectionDispensario.Conexiones.Con_Turno();
            TimeSpan TS = DateTime.Parse(datestart) - DateTime.Parse(dateend);
            int hour = Convert.ToInt32(decimal.Parse(TS.TotalHours.ToString()));
            if (hour < 0) hour = hour * -1;
            Conturn.InsertC1(UID, DateTime.Now, hour);



            List<ConnectionDispensario.Modelos.Reporting.C1Item> LIST = C1.GetC1(DateTime.Parse(datestart), DateTime.Parse(dateend), int.Parse(Request["UID"].ToString()), "Finalizado");
            ConnectionDispensario.Conexiones.Con_Turno CT = new ConnectionDispensario.Conexiones.Con_Turno();
            
            

            if (LIST == null)
            {
                LIST = new List<ConnectionDispensario.Modelos.Reporting.C1Item>();
            }
            UserController UC = new UserController();
            UserInfo UI = UC.GetUser(int.Parse(Request["PID"].ToString()), int.Parse(Request["UID"].ToString()));

            ReportDataSource RDS = new ReportDataSource("DS1", LIST);
            RV.LocalReport.DataSources.Add(RDS);

            RV.LocalReport.SetParameters(new ReportParameter[] {
                    new ReportParameter("NombreMedico",UI.FirstName + " " + UI.LastName),
                    new ReportParameter("Establecimiento","Dispensario Municipal \"Dr. H Weihmuller\""),
                    new ReportParameter("Servicio",Servicio),
                    new ReportParameter("CodigoEstablecimiento","4200026"),
                    new ReportParameter("CodigoServicio","..."),
                    new ReportParameter("TotalObraSocial",C1.totalplandesalud.ToString()),
                    new ReportParameter("TotalNingunaObraSocial",C1.totalsinplandesalud.ToString()),
                    new ReportParameter("Tmenor1m",C1.totalmenor1m.ToString()),
                    new ReportParameter("Tmenor1f",C1.totalmenor1f.ToString()),
                    new ReportParameter("T1m",C1.total1anom.ToString()),
                    new ReportParameter("T1f",C1.total1anof.ToString()),
                    new ReportParameter("T2a4m",C1.total2a4m.ToString()),
                    new ReportParameter("T2a4f",C1.total2a4f.ToString()),
                    new ReportParameter("T5a9m",C1.total5a9m.ToString()),
                    new ReportParameter("T5a9f",C1.total5a9f.ToString()),
                    new ReportParameter("T10a14m",C1.total10a14m.ToString()),
                    new ReportParameter("T10a14f",C1.total10a14f.ToString()),
                    new ReportParameter("T15a49m",C1.total15a49m.ToString()),
                    new ReportParameter("T15a49f",C1.total15a49f.ToString()),
                    new ReportParameter("T50m",C1.total50amasm.ToString()),
                    new ReportParameter("T50f",C1.total50amasf.ToString()),
                    new ReportParameter("Totalmenor1",(C1.totalmenor1f+C1.totalmenor1m).ToString()),
                    new ReportParameter("Total1",(C1.total1anof+C1.total1anom).ToString()),
                    new ReportParameter("Total2a4",(C1.total2a4f+C1.total2a4m).ToString()),
                    new ReportParameter("Total5a9",(C1.total5a9f+C1.total5a9m).ToString()),
                    new ReportParameter("Total10a14",(C1.total10a14f+C1.total10a14m).ToString()),
                    new ReportParameter("Total15a49",(C1.total15a49f+C1.total15a49m).ToString()),
                    new ReportParameter("Total50",(C1.total50amasf+C1.total50amasm).ToString()),
                    new ReportParameter("TotalM",(C1.totalmenor1m+C1.total1anom+C1.total2a4m+C1.total5a9m+C1.total10a14m+C1.total15a49m+C1.total50amasm).ToString()),
                    new ReportParameter("TotalF",(C1.totalmenor1f+C1.total1anof+C1.total2a4f+C1.total5a9f+C1.total10a14f+C1.total15a49f+C1.total50amasf).ToString()),
                    new ReportParameter("Total",(LIST.Count).ToString()),
                    new ReportParameter("TotalCtrlEmb",(C1.totalcontrolembarazo).ToString()),
                    new ReportParameter("Fecha", DateTime.Now.Day + "/" + DateTime.Now.Month + "/" + DateTime.Now.Year)
                    });
        }

        protected void GenerateC3()
        {

            int Month = int.Parse(Request["month"].ToString());
            int year = int.Parse(Request["year"].ToString());
            RV.LocalReport.ReportPath = MapPath("/DesktopModules/Planillas/Reports/ReportC3.rdlc");
            List<ConnectionDispensario.Modelos.Reporting.C3Item> itemsC3 = null;
            if (Month == 2)
            {
                if (DateTime.IsLeapYear(year) == true)
                {
                    itemsC3 = new C3().GetC3(year, Month, 29);
                }
                else
                {
                    itemsC3 = new C3().GetC3(year, Month, 28);
                }
            }
            else
            {
                itemsC3 = new C3().GetC3(year, Month, DateTime.DaysInMonth(year,Month));
            }
            

            
            ReportDataSource RDS = new ReportDataSource("DataSetC3", itemsC3);
            RV.LocalReport.SetParameters(new ReportParameter[] {
                    new ReportParameter("ano",year.ToString()),
                    new ReportParameter("mes",Month.ToString()),
            new ReportParameter("ResponsableLlenado","____________________"),
            new ReportParameter("Fecha",DateTime.Now.Day.ToString() + "/" + DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString())});
            RV.LocalReport.DataSources.Add(RDS);


        }

        protected void GenerateC2()
        {
            RV.LocalReport.ReportPath = MapPath("/DesktopModules/Planillas/Reports/ReportC2.rdlc");
            List<ConnectionDispensario.Modelos.Reporting.C2Item> itemsC2 = new List<ConnectionDispensario.Modelos.Reporting.C2Item>();
            int Month = int.Parse(Request["month"].ToString());
            int year = int.Parse(Request["year"].ToString());
            //Buscar dentro de los usuarios que cumplan con el servicio
            string nombreservicio="";
            if (Request["service"] != null)
            {
                //DotNetNuke.Entities.Portals.PortalController PC = new DotNetNuke.Entities.Portals.PortalController();
                

                
                ConnectionDispensario.Modelos.Servicio Service = ConnectionDispensario.Modelos.Servicio.ObtenerServicioById(int.Parse(Request["service"].ToString()));
                nombreservicio = Service.NOMBRE;

                for (int dia = 0; dia < DateTime.DaysInMonth(year, Month); dia++)
                {
                    itemsC2.Add(new ConnectionDispensario.Modelos.Reporting.C2Item());
                    itemsC2[dia].Dia = dia + 1;
                    List<Jornada> ListaJornadas = Jornada.SelectClosedJornadasByDateAndIdService(year, Month, dia+1, Service.ID);
                    decimal horasdeconsulta=0;
                    if (ListaJornadas != null)
                    {
                        foreach (Jornada j in ListaJornadas)
                        {
                            List<Turno> T = Turno.GetTurnosByPeriod(j.Start, j.End.Value, j.USERID.Value, "Finalizado");
                            horasdeconsulta+=(decimal)((j.End.Value-j.Start).TotalMinutes / 60);
                            itemsC2[dia].HorasAtencion += horasdeconsulta;
                            if (T != null)
                            {
                                foreach (Turno t in T)
                                {
                                    if (t.Pac != null)
                                    {

                                        Paciente p = t.Pac;
                                        int age = ConnectionDispensario.Utils.Conversiones.getAge(p.FECHA_NACIMIENTO);
                                        string sex="";
                                        if (p.SEXO == "Masculino") { sex = "m"; } else { sex = "f"; }



                                        itemsC2[dia].TotalTotal++;

                                        if (sex == "m")
                                        {
                                            itemsC2[dia].Totalm++;
                                            if (age < 1) itemsC2[dia].Menor1m++;
                                            if (age == 1) itemsC2[dia].Ano1m++;
                                            if (age > 1 && age < 5) itemsC2[dia].Ano2a4m++;
                                            if (age > 4 && age < 10) itemsC2[dia].Ano5a9m++;
                                            if (age > 9 && age < 15) itemsC2[dia].Ano10a14m++;
                                            if (age > 14 && age < 50) itemsC2[dia].Ano15a49m++;
                                            if (age > 49 ) itemsC2[dia].Ano50ymasm++;

                                            
                                        }
                                        else
                                        {
                                            itemsC2[dia].Totalf++;
                                            if (age < 1) itemsC2[dia].Menor1f++;
                                            if (age == 1) itemsC2[dia].Ano1f++;
                                            if (age > 1 && age < 5) itemsC2[dia].Ano2a4f++;
                                            if (age > 4 && age < 10) itemsC2[dia].Ano5a9f++;
                                            if (age > 9 && age < 15) itemsC2[dia].Ano10a14f++;
                                            if (age > 14 && age < 50) itemsC2[dia].Ano15a49f++;
                                            if (age > 49) itemsC2[dia].Ano50ymasf++;
                                        }

                                        if (t.ControlEmbarazo == true) { itemsC2[dia].TotalPregnant++; }
                                    }
                                }
                            }

                        }
                    }

                }

            }

            ReportDataSource RDS = new ReportDataSource("DataSetC2", itemsC2);
            RV.LocalReport.DataSources.Add(RDS);
            RV.LocalReport.SetParameters(new ReportParameter[] {
                    new ReportParameter("Establecimiento","Dispensario Municipal \"Dr. H Weihmuller\""),
                    new ReportParameter("Departamento", "Gral. San Martin"),
                    new ReportParameter("NombreServicio",nombreservicio),
                    new ReportParameter("CodigoEstablecimiento","4200026"),
                    new ReportParameter("CodigoServicio","..."),
                    new ReportParameter("Mes", Month.ToString() ),
                    new ReportParameter("Anio", year.ToString() )

            });

        }

    }
}