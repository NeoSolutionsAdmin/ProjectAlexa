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
using System.Web.Services;
using DotNetNuke;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using ConnectionDispensario;
using ConnectionDispensario.Modelos;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using System.Web.UI;

namespace Christoc.Modules.HistoriaClinica
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from HistoriaClinicaModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    /// 

    public static class ControlRender
    {
        public static string LoadMyControl(System.Web.UI.Control C)
        {
            System.Text.StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter writer = new HtmlTextWriter(sw);

            C.RenderControl(writer);
            return sb.ToString();
           

        }
    }

    public partial class View : HistoriaClinicaModuleBase, IActionable
    {

        
            
        public static string key_pacientes = "KeyListaPacientes";
       

       
            
           
        
        private DotNetNuke.Entities.Users.UserInfo Getuser(int ID, int IdPortal) 
        {
            DotNetNuke.Entities.Users.UserController UC = new DotNetNuke.Entities.Users.UserController();
            return UC.GetUser(IdPortal, ID);
           
        }

        private void CheckParameters()
        {
            
            if (Request["m"] != null) 
            {
                if (Request["gui"] != null) 
                {
                    if (Request["m"] == "s") 
                    {
                        Paciente P = Paciente.Select_Paciente_by_GUI(Request["gui"].ToString());
                        if (P != null) 
                        {
                            Session.Add("Paciente", P);
                            Response.Redirect("/Historia-Clinica");
                            

                        }

                    }
                }
            }
            if (Request["delmed"] != null) 
            {
                int med = int.Parse(Request["delmed"].ToString());
                Medicacion.Borrar(med);
                Response.Redirect("/Historia-Clinica");
            }

            if (Request["deltox"] != null)
            {
                int tox = int.Parse(Request["deltox"].ToString());
                Toxicologia.Borrar(tox);
                Response.Redirect("/Historia-Clinica");
            }
        }

        void ConstruirOdontograma() 
        {
            for (int a=18;a>10;a--){
            
            Tooth MyTooth = LoadControl("/DesktopModules/HistoriaClinica/Tooth.ascx") as Tooth;
            MyTooth.SetTooth(a);                
            Grupo1.Controls.Add(MyTooth);
            }
            
            for (int a = 21; a < 29; a++)
            {

                Tooth MyTooth = LoadControl("/DesktopModules/HistoriaClinica/Tooth.ascx") as Tooth;
                MyTooth.SetTooth(a);
                Grupo2.Controls.Add(MyTooth);
            }
            
            for (int a = 48; a > 40; a--)
            {

                Tooth MyTooth = LoadControl("/DesktopModules/HistoriaClinica/Tooth.ascx") as Tooth;
                MyTooth.SetTooth(a);
                Grupo3.Controls.Add(MyTooth);
            }
            
            for (int a = 31; a < 39; a++)
            {

                Tooth MyTooth = LoadControl("/DesktopModules/HistoriaClinica/Tooth.ascx") as Tooth;
                MyTooth.SetTooth(a);
                Grupo4.Controls.Add(MyTooth);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            EditorDeHistorial.ClientIDMode = System.Web.UI.ClientIDMode.Static;
            OdontogramaConstructor.ClientIDMode = System.Web.UI.ClientIDMode.Static;
            if (UserInfo.IsInRole("Administrativo") == true)
            {
                Session.Add("administrativo", "");
            }
            else
            {
                Session.Remove("administrativo");
            }
            
            try
            {
                EditorDeHistorial.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                if (Session["Paciente"] == null)
                {

                    
                    EditorDeHistorial.Visible = false;
                    ContainerAlergias.Visible = false;
                    ContainerCirugias.Visible = false;
                    ContainerPatologiasFamiliares.Visible = false;
                    ContainerPatologiasPersonales.Visible = false;
                    ContainerMedicacion.Visible = false;
                    ContainerToxicologia.Visible = false;
                    divHerramientas.Visible = false;
                    Session.Remove("Somatometria");
                    containersomatometria.Visible = false;
                }
                else
                {
                    ConstruirOdontograma();
                    Visible = true;
                    //Construccion de objeto de somatometria en Server como variable de sesion
                    //Si existe una somatometria la carga, caso contrario creau un nuevo registro y la carga
                    Paciente P = Session["Paciente"] as Paciente;
                    if (!IsPostBack && Somatometria.GetSomatometriaByIdPaciente(P.ID) != null)
                    {
                        Somatometria S = Somatometria.GetSomatometriaByIdPaciente(P.ID);
                        Session.Add("Somatometria", S);
                        ConstruirSomatometria(S);

                    }
                   

                }
                Session.Add("IdPortal", PortalId);
                Session.Add("IdUser", UserId);
                CheckParameters();
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

        private void ConstruirSomatometria(Somatometria p_S)
        {


            if (p_S.IdUsuario != 0)
            {
                DotNetNuke.Entities.Users.UserInfo UI = DotNetNuke.Entities.Users.UserController.GetUserById(PortalId, p_S.IdUsuario);
                string CompleteName = UI.FirstName + " " + UI.LastName;
                string Fecha = p_S.FechaHora.Day.ToString() + "/" + p_S.FechaHora.Month.ToString() + "/" + p_S.FechaHora.Year.ToString();
                Span_Profesional.InnerText = CompleteName;
                span_time.InnerText = Fecha;
            }
            if (p_S.PADiastolica !=null) txt_diastolica.Text = p_S.PADiastolica.ToString();
            if (p_S.PASistolica != null) txt_pasistolica.Text = p_S.PASistolica.ToString();
            if (p_S.Peso != null) txt_peso.Text = p_S.Peso.ToString();
            if (p_S.Talla != null) txt_talla.Text = p_S.Talla.ToString();
            if (p_S.IMC != null) span_imc.InnerText = p_S.IMC.ToString();
            if (p_S.Colesterol != null) txt_colesterol.Text = p_S.Colesterol.ToString();

            //buscador de termino "diabetes"

            List<APP> app = APP.GetAntecedentesByIdPaciente(p_S.IdPaciente);
            bool diabetes=false;
            if (app != null && app.Count > 0)
            {
                foreach (APP a in app)
                {
                    if (a.Patologia.ToLower().Contains("diab"))
                    {
                        diabetes = true;
                        break;
                    }
                }
            }
            if (diabetes == true)
            {
                span_diabetes.InnerText = "SI";
            }
            else
            {
                span_diabetes.InnerText = "NO";
            }

            //Buscador de tabaquismo
            List<Toxicologia> toxi = Toxicologia.GetToxicologiaByIdPaciente(p_S.IdPaciente);
            bool Tabaquismo = false;
            if (toxi != null && toxi.Count > 0)
            {
                foreach (Toxicologia a in toxi)
                {
                    if (a.NameToxicologia.ToLower().Contains("tabaq") || a.NameToxicologia.ToLower().Contains("fuma"))
                    {
                        Tabaquismo = true;
                        break;
                    }
                }
            }
            if (Tabaquismo == true)
            {
                span_Tabaquismo.InnerText = "SI";
            }
            else
            {
                span_Tabaquismo.InnerText = "NO";
            }


        }

        protected void Buscar_Click(object sender, EventArgs e)
        {
            Session.Remove(key_pacientes);
            List<Paciente> lp=null;
            if (SearchForm.SelectedValue.Contains("APELLIDO") == true)
            {
                 lp = Paciente.BuscarPacientesByApellido(StringSearch.Text);
            }
            if (SearchForm.SelectedValue.Contains("DNI") == true)
            {
                lp = Paciente.BuscarPacientesByDNI(StringSearch.Text);
            }
            if (lp != null) 
            {
                Session.Add(key_pacientes, lp);
            }
            
        }

        protected void btnGuardarAlergia_Click(object sender, EventArgs e)
        {
            if (Session["Paciente"]!=null && txtAlergia.Text!=""){
                Paciente P = Session["Paciente"] as Paciente;
                Alergia A = new Alergia(P.ID, txtAlergia.Text);
                A.Guardar();
                txtAlergia.Text="";
                }
        }

        protected void btnGuardarCirugia_Click(object sender, EventArgs e)
        {
            if (Session["Paciente"] != null && txtCirugia.Text!="")
            {
                Paciente P = Session["Paciente"] as Paciente;
                Cirugia A = new Cirugia(P.ID, txtCirugia.Text);
                A.Guardar();
                txtCirugia.Text = "";
            }
        }

        protected void btnGuardarPatologiaPeronal_Click(object sender, EventArgs e)
        {
            if (Session["Paciente"] != null && txtPatologiasPersonales.Text!="")
            {
                Paciente P = Session["Paciente"] as Paciente;
                APP A = new APP(P.ID, txtPatologiasPersonales.Text);
                A.Guardar();
                txtPatologiasPersonales.Text = "";
                Response.Redirect("/Historia-Clinica");
            }
        }

        protected void btnGuardarPatologiaFamiliar_Click(object sender, EventArgs e)
        {
            if (Session["Paciente"] != null && txtPatologiasFamiliares.Text!="")
            {
                Paciente P = Session["Paciente"] as Paciente;
                APF A = new APF(P.ID, txtPatologiasFamiliares.Text);
                A.Guardar();
                txtPatologiasFamiliares.Text = "";
            }
        }

        protected void btnGuardarMedicacion_Click(object sender, EventArgs e)
        {
            if (Session["Paciente"] != null && txtMedicacion.Text != "")
            {
                Paciente P = Session["Paciente"] as Paciente;
                Medicacion A = new Medicacion(P.ID, txtMedicacion.Text);
                A.Guardar();
                txtMedicacion.Text = "";
            }
        }

        protected void btnSaveSomatometria_Click(object sender, EventArgs e)
        {
            if (Session["Paciente"] != null)
            {
                Paciente P = Session["Paciente"] as Paciente;
                Somatometria S = Somatometria.GetSomatometriaByIdPaciente(P.ID);
                if (S == null)
                {
                    
                    S = new Somatometria(P.ID, UserId, DateTime.Now);
                    S.CreateNewSomatometria();
                    S.PADiastolica = int.Parse(txt_diastolica.Text);
                    S.PASistolica = int.Parse(txt_pasistolica.Text);
                    S.Peso = decimal.Parse(txt_peso.Text);
                    S.Talla = decimal.Parse(txt_talla.Text);
                    S.Colesterol = decimal.Parse(txt_colesterol.Text);
                    if (S.Talla != null && S.Peso != null && S.Talla != 0 && S.Peso != 0)
                    {
                        S.IMC = S.Peso / (S.Talla * S.Talla);
                    }
                    S.UpdateSomatometria();
                    Response.Redirect("/Historia-Clinica");

                }
                else
                {
                    S.PADiastolica = int.Parse(txt_diastolica.Text);
                    S.PASistolica = int.Parse(txt_pasistolica.Text);
                    S.Peso = decimal.Parse(txt_peso.Text);
                    S.Talla = decimal.Parse(txt_talla.Text);
                    S.Colesterol = decimal.Parse(txt_colesterol.Text);
                    if (S.Talla != null && S.Peso != null && S.Talla != 0 && S.Peso != 0)
                    {
                        S.IMC = S.Peso / (S.Talla * S.Talla);
                    }
                    S.UpdateSomatometria();
                    Response.Redirect("/Historia-Clinica");
                }
            }
        }

        protected void btnGuardarToxicologia_Click(object sender, EventArgs e)
        {
            if (Session["Paciente"] != null && txt_Toxicologia.Text != "")
            {
                Paciente P = Session["Paciente"] as Paciente;
                Toxicologia A = new Toxicologia(P.ID, txt_Toxicologia.Text);
                A.Guardar();
                txt_Toxicologia.Text = "";
                Response.Redirect("/Historia-Clinica");
            }
        }
    }
}