/*
' Copyright (c) 2017  Christoc.com
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System;
using System.Collections.Generic;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using ConnectionDispensario.Modelos;
using System.Web.UI.WebControls;

namespace Christoc.Modules.Turnero
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from TurneroModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : TurneroModuleBase, IActionable
    {
        public static string SessionTurnos = "SessionTurnos";
        public static string Users = "SessionUsers";


        private void redirecttome() 
        {
            Response.Redirect("/Turnos");
        }

        private void PreparacionDeJornada()
        {
            Jornada J = Jornada.GetLast(UserId);
            if (J != null)
            {
                if (J.End != null)
                {
                    StartJornada.Visible = true;
                    MostrarBotonesServicios(true);
                    Session.Remove("EstadoJornada");
                    //tablaturnos.Visible = false;
                    EndJornada.Visible = false;
                }
                else
                {
                    EndJornada.Visible = true;
                    //tablaturnos.Visible = true;
                    StartJornada.Visible = false;
                    MostrarBotonesServicios(false);
                    Session.Add("EstadoJornada", "Activa");
                }
            }
            else
            {
                //tablaturnos.Visible = false;
                EndJornada.Visible = false;
                StartJornada.Visible = true;
                MostrarBotonesServicios(true);
                Session.Remove("EstadoJornada");
            }
        }

        
        void ClickJornada(object sender, EventArgs e)
        {
            
            Button MiBoton = sender as Button;
            Jornada.Insert(UserId, int.Parse(MiBoton.ID));
            Response.Redirect("/Turnos");
        }

        void MostrarBotonesServicios(bool estado)
        {
            if (estado)
            {
                //Se consiguen los servicios del user y se muestran como botones de ASP:
                List<Servicio> ListaServicios = Servicio.ObtenerServiciosPorProfesional(UserId);
                if (ListaServicios != null)
                {
                    foreach (Servicio servicio in ListaServicios)
                    {
                        Button btnService = new Button();
                        btnService.Text = servicio.NOMBRE;
                        btnService.ID = servicio.ID.ToString();
                        btnService.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                        btnService.Click += ClickJornada;
                        BotonesServicios.Controls.Add(btnService);
                    }
                }
                else
                {
                    Label NoService = new Label();
                    NoService.Text = "Usted no tiene servicios asignados. Contacte a un administrativo.";
                    BotonesServicios.Controls.Add(NoService);
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            PreparacionDeJornada();

            Turno T = null;
            if (Request["IDT"] != null) 
            {
                T = Turno.GetTurnoByID(int.Parse(Request["IDT"].ToString()));
            }

            if (Request["com"]!=null)
            {
                if (T != null)
                {
                    if (Request["com"] == "I")
                    {
                        T.ComenzarTurno();
                        string GUI = T.Pac.GUID;
                        Response.Redirect("/Historia-Clinica?m=s&gui=" + GUI);
                    }
                    if (Request["com"] == "C") { 
                        T.CancelarTurno();
                        Response.Redirect("/Turnos");
                    }
                    if (Request["com"] == "F")
                    {
                        T.FinalizarTurno();
                        Response.Redirect("/Turnos");
                    }
                    
                }
            }

            

            List<Turno> LT = Turno.GetTurnosByUser(UserId);
            if (LT != null)
            {
                //ConnectionDispensario.Statics.LogCatcher.AddLog("Hay Session", "", this, Session);
                Session.Add(SessionTurnos, LT);
            }
            else 
            {
                Session.Remove(SessionTurnos);
            }
            
            try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        public ModuleActionCollection ModuleActions
        {
            get
            {
                var actions = new ModuleActionCollection
                    {
                        {
                            GetNextActionID(), Localization.GetString("EditModule", LocalResourceFile), "", "", "",
                            EditUrl(), false, SecurityAccessLevel.Edit, true, false
                        }
                    };
                return actions;
            }
        }

        protected void btnGuardarDiagnostico_Click(object sender, EventArgs e)
        {
            int IDT = int.Parse(HF_IDT.Value);
            ConnectionDispensario.Modelos.Turno T = Turno.GetTurnoByID(IDT);
            if (T != null && txtDiagnostico.Text!=null) 
            {
                if (chkControlEmbarazo.Checked == true)
                {
                    T.ActualizarTurno("Control Embarazo", 0, chkControlEmbarazo.Checked);
                }
                else 
                {
                    T.ActualizarTurno(txtDiagnostico.Text, 0, false);
                }
                redirecttome();
            }
        }

        protected void btnCancelarDiagnostico_Click(object sender, EventArgs e)
        {

        }

        protected void ImprimirC1_Click(object sender, EventArgs e)
        {
            int DS = int.Parse(DiaStart.SelectedItem.Text);
            int DE = int.Parse(DiaEnd.SelectedItem.Text);
            int MESS = int.Parse(MesStart.SelectedItem.Text);
            int MESE = int.Parse(MesEnd.SelectedItem.Text);
            int AÑO = int.Parse(Año.SelectedItem.Text);
            int HS = int.Parse(HoraStart.SelectedItem.Text);
            int HE = int.Parse(HoraEnd.SelectedItem.Text);
            string Establecimiento = lstEstablecimiento.SelectedValue;
            string parameters = "C1=1&IDP=" + PortalId.ToString()
                + "&UID=" + UserId.ToString()
                + "&PID=" + PortalId.ToString()
                + "&Y=" + AÑO.ToString()
                + "&MS=" + MESS.ToString()
                + "&ME=" + MESE.ToString()
                + "&DS=" + DS.ToString()
                + "&DE=" + DE.ToString()
                + "&HS=" + HS.ToString()
                + "&HE=" + HE.ToString()
                + "&EST=" + Establecimiento;
            Response.Redirect("/DesktopModules/Turnero/Reportes.aspx?" + parameters);

        }

        protected void StartJornada_Click(object sender, EventArgs e)
        {
            
            Jornada.Insert(UserId, 0);
            Response.Redirect("/Turnos");
        }

        protected void EndJornada_Click(object sender, EventArgs e)
        {
            Jornada J = Jornada.GetLast(UserId);
            J.ExitJornada();
            int DS = J.Start.Day;
            int DE = J.End.Value.Day;
            int MESS = J.Start.Month;
            int MESE = J.End.Value.Month;
            int AÑO = J.Start.Year;
            int HS = J.Start.Hour;
            int HE = J.End.Value.Hour;
            int MinStart = J.Start.Minute;
            int MinEnd = J.End.Value.Minute;
            Servicio S = null;
            if (J.IdServicio != null)
            {
                S = Servicio.ObtenerServicioById(J.IdServicio.Value);
            }
            if (S != null) { 
            string Establecimiento = lstEstablecimiento.SelectedValue;
            string parameters = "C1=1&IDP=" + PortalId.ToString()
                + "&UID=" + UserId.ToString()
                + "&PID=" + PortalId.ToString()
                + "&Y=" + AÑO.ToString()
                + "&MS=" + MESS.ToString()
                + "&ME=" + MESE.ToString()
                + "&DS=" + DS.ToString()
                + "&DE=" + DE.ToString()
                + "&HS=" + HS.ToString()
                + "&HE=" + HE.ToString()
                + "&MinStart=" + MinStart.ToString()
                + "&MinEnd=" + MinEnd.ToString()
                + "&EST=" + Establecimiento
                + "&SERV=" + S.NOMBRE;
            Response.Redirect("/DesktopModules/Turnero/Reportes.aspx?" + parameters);
            }

        }
    }
}