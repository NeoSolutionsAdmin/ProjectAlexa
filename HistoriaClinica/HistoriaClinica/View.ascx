<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.HistoriaClinica.View" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="ConnectionDispensario.Modelos" %>
<%@ Import Namespace="ConnectionDispensario.Statics" %>
<%@ Import Namespace="DotNetNuke" %>
<%@ Import Namespace="DotNetNuke.Entities.Users" %>
<%@ Import Namespace="Christoc.Modules.HistoriaClinica" %>


<div>

    <asp:Button CssClass="DispensarioButton DispensarioIconBuscarPaciente" Text="Buscar Paciente" ID="btnBuscarPaciente" runat="server" ClientIDMode="Static" OnClientClick="ShowDialog();return false;" />
</div>

<div id="DialogPacienteSearch" title="Busqueda de pacientes">
    <asp:TextBox ID="StringSearch" runat="server" CssClass="DispensarioTextBox" ClientIDMode="Static"></asp:TextBox>
    <asp:Button ID="Buscar" runat="server" OnClick="Buscar_Click" CssClass="DispensarioButton DispensarioIconBuscarPaciente" Text="BUSCAR" />
    <asp:RadioButtonList ID="SearchForm" runat="server">
        <asp:ListItem Text="Buscar Por DNI" Value="DNI" Selected="true"></asp:ListItem>
        <asp:ListItem Text="Buscar Por Apellido" Value="APELLIDO"></asp:ListItem>
    </asp:RadioButtonList>


    <br />
    <table class="DispensarioTable">
        <tbody>
            <tr class="DispensarioTableHeader">
                <th>Apellido</th>
                <th>Nombre</th>
                <th>Telefono</th>
                <th>Nro. Doc.</th>

            </tr>
        </tbody>
    </table>

    <div class="DispensarioScrollBox">
        <table class="DispensarioTable">

            <tbody>

                <%
                    
                    
                    if (Session[Christoc.Modules.HistoriaClinica.View.key_pacientes] != null)
                    {
                        List<ConnectionDispensario.Modelos.Paciente> resultados = Session["KeyListaPacientes"] as List<ConnectionDispensario.Modelos.Paciente>;
                        foreach (ConnectionDispensario.Modelos.Paciente P in resultados)
                        {
                            Response.Write("<tr class=\"DispensarioTableContentRow\" onclick=\"ShowHistorial('" + P.GUID + "')\">");
                            Response.Write("<td>" + P.APELLIDO + "</td>");
                            Response.Write("<td>" + P.NOMBRE + "</td>");
                            Response.Write("<td>" + P.TELEFONO + "</td>");
                            Response.Write("<td>" + P.NRODOCUMENTO + "</td>");
                    
                            Response.Write("</tr>");
                            

                        }
                        Session.Remove("KeyListaPacientes");
                        show_search.Value = "1";
                    }
                    else
                    {
                        Response.Write("No hay resultados");
                        show_search.Value = "0";
                    }
                    
                %>

                <asp:HiddenField runat="server" ID="show_search" />
            </tbody>
        </table>
    </div>
</div>



<div class="DispensarioContainer">

    <%  if (Session["Paciente"] != null)
        {
            ConnectionDispensario.Modelos.Paciente P = Session["Paciente"] as ConnectionDispensario.Modelos.Paciente;
            String ObraSocial = "(Ninguna)";
            String NumeroObraSocial = "(Ninguno)";
            if (P.IDOBRASOCIAL != 0)
            {
                ConnectionDispensario.Modelos.ObraSocial OS = ConnectionDispensario.Modelos.ObraSocial.GetObraSocial(P.IDOBRASOCIAL);
                if (OS != null)
                {
                    ObraSocial = OS.NOMBRE;
                    NumeroObraSocial = P.NROOBRASOCIAL;
                }
            }
            Response.Write("<div class=\"EncabezadoHistorial\">" +
                "<img src='/DesktopModules/HistoriaClinica/images/iconhistory.png' style='width:32px;height:32px' />"
                + "Historial del paciente <b> "
                + P.NOMBRE + " "
                + P.APELLIDO +
                "</b> </br> Edad: <b>" + ConnectionDispensario.Utils.Conversiones.getAge(P.FECHA_NACIMIENTO) + "</b></br>" +
                "DNI: <b>" + P.NRODOCUMENTO + "</b></br>" +
                "Obra Social:<b>" + ObraSocial + "</b></br>" +
                "Nro. Obra Social:<b>" + NumeroObraSocial + "</b></br>" +
                "</div>");
        }

    %>
</div>



<div class="DispensarioContainer" id="Gallery" runat="server">
    <div style="font-size: 18px">
        <b><u>Documentación digitalizada</u></b>
    </div>
    <%

        if (Session["Paciente"] != null)
        {
            ConnectionDispensario.Modelos.Paciente t_p = Session["Paciente"] as ConnectionDispensario.Modelos.Paciente;
            string idpaciente = t_p.ID.ToString();
            string path = Server.MapPath("/DesktopModules/Pacientes") + "\\ArchivosPacientes\\Paciente" + idpaciente;
            //Response.Write(path);

            if (System.IO.Directory.Exists(path) == true)
            {
                string[] files = Directory.GetFiles(path);
                for (int a = 0; a < files.Length; a++)
                {
                    string filename = Path.GetFileName(files[a]);
                    string extension = Path.GetFileName(files[a]);
                    if (filename.Contains("THMB") == true)
                    {
                        string fullpathbigfile = "/DesktopModules/Pacientes/ArchivosPacientes/Paciente" + idpaciente + "/" + filename.Remove(0, 4);
                        Response.Write("<div class=\"DispensarioThumb\" style=\"background-image:url('/DesktopModules/Pacientes/ArchivosPacientes/Paciente" + idpaciente + "/" + filename + "')\" onclick=\"OpenWindow('" + fullpathbigfile + "')\">");
                        Response.Write("<div class=\"InfoThumb\">");
                        Response.Write(File.GetCreationTime(files[a]).ToShortDateString());
                        Response.Write("</div>");
                        Response.Write("</div>");
                    }


                }
            }
        }

    %>
</div>

<div class="DispensarioContainer DispensarioContainerAlert" id="ContainerAlergias" runat="server">
    <img src="/DesktopModules/HistoriaClinica/images/iconallergy.png" style="width: 32px; height: 32px" />
    <b>Antecendentes Alérgicos:</b>
    <div>
        <%
            if (Session["Paciente"] != null)
            {
                Paciente P = Session["Paciente"] as Paciente;
                List<Alergia> tempAl = Alergia.GetAlergiasByIdPaciente(P.ID);
                if (tempAl != null)
                {
                    for (int a = 0; a < tempAl.Count; a++)
                    {
                        Response.Write("- " + tempAl[a].NameAlergia + "<br/>");
                    }
                }
            }

        %>
        <asp:TextBox ID="txtAlergia" runat="server"></asp:TextBox>
        <asp:Button runat="server" ID="btnGuardarAlergia" Text="+" OnClick="btnGuardarAlergia_Click" />
    </div>
</div>



<div class="DispensarioContainer DispensarioContainerMed" id="ContainerMedicacion" runat="server">
    <img src="/DesktopModules/HistoriaClinica/images/iconmed.png" style="width: 32px; height: 32px" />
    <b>Medicacion Habitual:</b>
    <div>
        <% 
            if (Session["Paciente"] != null)
            {
                Paciente P = Session["Paciente"] as Paciente;
                List<Medicacion> tempAl = Medicacion.GetMedicacionByIdPaciente(P.ID);
                if (tempAl != null)
                {
                    for (int a = 0; a < tempAl.Count; a++)
                    {
                        string button = "<input type=\"button\" value=\"-\" onclick=\"DelMed('" + tempAl[a].ID + "')\" /> ";
                        Response.Write("- " + tempAl[a].NameMedicacion + button + "<br/>");
                    }
                }
            }

        %>
        <asp:TextBox ID="txtMedicacion" runat="server"></asp:TextBox>
        <asp:Button runat="server" ID="btnGuardarMedicacion" Text="+" OnClick="btnGuardarMedicacion_Click" />
    </div>
</div>

<div class="DispensarioContainer DispensarioContainerMed" id="ContainerToxicologia" runat="server">
    <img src="/DesktopModules/HistoriaClinica/images/iconmed.png" style="width: 32px; height: 32px" />
    <b>Habitos Toxicos:</b>
    <div>
        <% 
            if (Session["Paciente"] != null)
            {
                Paciente P = Session["Paciente"] as Paciente;
                List<Toxicologia> tempAl = Toxicologia.GetToxicologiaByIdPaciente(P.ID);
                if (tempAl != null)
                {
                    for (int a = 0; a < tempAl.Count; a++)
                    {
                        string button = "<input type=\"button\" value=\"-\" onclick=\"DelTox('" + tempAl[a].ID + "')\" /> ";
                        Response.Write("- " + tempAl[a].NameToxicologia + button + "<br/>");
                    }
                }
            }

        %>
        <asp:TextBox ID="txt_Toxicologia" runat="server"></asp:TextBox>
        <asp:Button runat="server" ID="btnGuardarToxicologia" Text="+" OnClick="btnGuardarToxicologia_Click" />
    </div>
</div>





<div class="DispensarioContainer" id="ContainerPatologiasPersonales" runat="server">
    <img src="/DesktopModules/HistoriaClinica/images/iconpp.png" style="width: 32px; height: 32px" />
    <b>Antecendentes Patologicos Personales:</b>
    <div>
        <% 
            if (Session["Paciente"] != null)
            {
                Paciente P = Session["Paciente"] as Paciente;
                List<APP> tempAl = APP.GetAntecedentesByIdPaciente(P.ID);
                if (tempAl != null)
                {
                    for (int a = 0; a < tempAl.Count; a++)
                    {
                        Response.Write("- " + tempAl[a].Patologia + "<br/>");
                    }
                }
            }
        %>
        <asp:TextBox ID="txtPatologiasPersonales" runat="server"></asp:TextBox>
        <asp:Button runat="server" ID="btnGuardarPatologiaPeronal" Text="+" OnClick="btnGuardarPatologiaPeronal_Click" />
    </div>
</div>

<div class="DispensarioContainer" id="ContainerPatologiasFamiliares" runat="server">
    <img src="/DesktopModules/HistoriaClinica/images/iconfp.png" style="width: 32px; height: 32px" />
    <b>Antecendentes Patologicos Familiares:</b>
    <div>
        <% 
            if (Session["Paciente"] != null)
            {
                Paciente P = Session["Paciente"] as Paciente;
                List<APF> tempAl = APF.GetAntecedentesByIdPaciente(P.ID);
                if (tempAl != null)
                {
                    for (int a = 0; a < tempAl.Count; a++)
                    {
                        Response.Write("- " + tempAl[a].Patologia + "<br/>");
                    }
                }
            }
        %>
        <asp:TextBox ID="txtPatologiasFamiliares" runat="server"></asp:TextBox>
        <asp:Button runat="server" ID="btnGuardarPatologiaFamiliar" Text="+" OnClick="btnGuardarPatologiaFamiliar_Click" />
    </div>
</div>

<div class="DispensarioContainer" id="ContainerCirugias" runat="server">
    <img src="/DesktopModules/HistoriaClinica/images/iconcirugy.png" style="width: 32px; height: 32px" />
    <b>Antecendentes Quirurgicos:</b>
    <div>
        <% 

            string CuadroDeHerramientas = "hidden";
            string Odontrograma = "hidden";
            if (Session["Paciente"] != null)
            {
                CuadroDeHerramientas = "visible";
                Odontrograma = "hidden";
                Paciente P = Session["Paciente"] as Paciente;
                List<Cirugia> tempAl = Cirugia.GetCirugiasByIdPaciente(P.ID);
                if (tempAl != null)
                {
                    for (int a = 0; a < tempAl.Count; a++)
                    {
                        Response.Write("- " + tempAl[a].NameCirugia + "<br/>");
                    }
                }
            }
        %>
        <asp:TextBox ID="txtCirugia" runat="server"></asp:TextBox>
        <asp:Button runat="server" ID="btnGuardarCirugia" Text="+" OnClick="btnGuardarCirugia_Click" />
    </div>
</div>

<div class="DispensarioContainer" id="containersomatometria" runat="server">

    <b>Antropometría y signos vitales:</b>
    <% if (Session["Somatometria"] != null)
        {

        }
        else
        {
            containersomatometria.Visible = false;
        }%>
    <div style="width: 500px">
        <b>Ultima Actualizacion: </b><span runat="server" id="span_time"></span>
        <br />
        <b>Profesional: </b><span runat="server" id="Span_Profesional"></span>
        <br />
        <b>Peso:</b>
        <asp:TextBox CssClass="DispensarioTextBox" ID="txt_peso" runat="server" ClientIDMode="Static"></asp:TextBox> Kg.<br />
        <b>Talla:</b>
        <asp:TextBox CssClass="DispensarioTextBox" ID="txt_talla" runat="server" ClientIDMode="Static"></asp:TextBox> Mts.<br />
        <b>PA Sistolica:</b>
        <asp:TextBox CssClass="DispensarioTextBox" ID="txt_pasistolica" runat="server" ClientIDMode="Static"></asp:TextBox><br />
        <b>PA Diastolica:</b>
        <asp:TextBox CssClass="DispensarioTextBox" ID="txt_diastolica" runat="server" ClientIDMode="Static"></asp:TextBox><br />
        <b>Colesterol:</b>
        <asp:TextBox CssClass="DispensarioTextBox" ID="txt_colesterol" runat="server" ClientIDMode="Static"></asp:TextBox> mg/dl<br />
        <b>IMC: </b><span runat="server" id="span_imc"></span>
        <br />
        <b>Diabetes Mellitus:</b> <span runat="server" id="span_diabetes"></span>
        <br />
        <b style="color: gray">(En caso de diabetes, especificar en antecedentes patologicos personales)</b><br />
        <b>Tabaquismo:</b> <span runat="server" id="span_Tabaquismo"></span>
        <br />
        <b style="color: gray">(En caso de tabaquismo, especificar en habitos toxicos</b><br />
        <div>
            <table class="tableCV">
                <tbody id="tbodyCV" runat="server">
                    <%
                        if (Session["Paciente"] != null)
                        {
                            Paciente P = Session["Paciente"] as Paciente;
                            int Edad = ConnectionDispensario.Utils.Conversiones.getAge(P.FECHA_NACIMIENTO);
                            /*if (Edad >= 40 && Edad <= 49) { Edad = 40; }
                            if (Edad >= 50 && Edad <= 59) { Edad = 50; }
                            if (Edad >= 60 && Edad <= 69) { Edad = 60; }
                            if (Edad >= 70) { Edad = 70; }*/

                            List<ConnectionDispensario.Statics.VariableComparativa> ListadoDesordenadoEdades = new List<ConnectionDispensario.Statics.VariableComparativa>();
                            ListadoDesordenadoEdades.Add(new ConnectionDispensario.Statics.VariableComparativa(0, 40, 0));
                            ListadoDesordenadoEdades.Add(new ConnectionDispensario.Statics.VariableComparativa(1, 50, 0));
                            ListadoDesordenadoEdades.Add(new ConnectionDispensario.Statics.VariableComparativa(2, 60, 0));
                            ListadoDesordenadoEdades.Add(new ConnectionDispensario.Statics.VariableComparativa(3, 70, 0));

                            for (int a = 0;a<ListadoDesordenadoEdades.Count; a++)
                            {
                                
                                ListadoDesordenadoEdades[a].variableDiferencia = ListadoDesordenadoEdades[a].variableValor - Edad;
                                if (ListadoDesordenadoEdades[a].variableDiferencia < 0)
                                {
                                    ListadoDesordenadoEdades[a].variableDiferencia = ListadoDesordenadoEdades[a].variableDiferencia * -1;
                                }
                                Response.Write("Val="  + ListadoDesordenadoEdades[a].variableValor.ToString() + " Dif=" + ListadoDesordenadoEdades[a].variableDiferencia + "<br/>");

                            }



                            ListadoDesordenadoEdades.Sort((a,b) => (a.variableDiferencia.CompareTo(b.variableDiferencia)));


                            Response.Write("<br/> ------ <br/>");
                            foreach (VariableComparativa a in ListadoDesordenadoEdades)
                            {
                                Response.Write("Val="  + a.variableValor.ToString() + " Dif=" + a.variableDiferencia + "<br/>");
                            }


                            Somatometria S = Somatometria.GetSomatometriaByIdPaciente(P.ID);

                            decimal Colesterol=0M;
                            int PAS=0;

                            if (S != null) {
                                Colesterol = S.Colesterol.GetValueOrDefault(0m);
                                PAS = S.PASistolica.GetValueOrDefault(0);
                            }

                            if (S != null)
                            {
                                if (S.Colesterol > 309m) Colesterol = 309m;
                                if (S.Colesterol <= 309m) Colesterol = 309m;
                                if (S.Colesterol <= 270m) Colesterol = 270m;
                                if (S.Colesterol <= 232m) Colesterol = 232m;
                                if (S.Colesterol <= 193m) Colesterol = 193m;
                                if (S.Colesterol <= 155m) Colesterol = 155m;






                            }
                            if (S != null)
                            {




                                if (S.PASistolica > 180m) PAS = 180;
                                if (S.PASistolica <= 180m) PAS = 180;
                                if (S.PASistolica<= 160m) PAS = 160;
                                if (S.PASistolica <= 140m) PAS = 140;
                                if (S.PASistolica <= 120) PAS = 120;
                            }

                            Boolean Tabaquismo = false;
                            Boolean Diabetes = false;
                            String Sexo = "H";

                            if (S!=null && S.PASistolica != null && S.Colesterol != null)
                            {
                                if (P.SEXO == "Masculino") { Sexo = "H"; } else { Sexo = "M"; };
                                List<Toxicologia> T = Toxicologia.GetToxicologiaByIdPaciente(P.ID);
                                if (T != null && T.Count > 0)
                                {
                                    foreach (Toxicologia t in T)
                                    {
                                        if (t.NameToxicologia.ToLower().Contains("tabaquismo") || t.NameToxicologia.ToLower().Contains("fumador"))
                                        {
                                            Tabaquismo = true;
                                            break;
                                        }
                                    }
                                }

                                List<APP> D = APP.GetAntecedentesByIdPaciente(P.ID);
                                if (D != null && D.Count > 0)
                                {
                                    foreach (APP d in D)
                                    {
                                        if (d.Patologia.ToLower().Contains("diab"))
                                        {
                                            Diabetes = true;
                                            break;
                                        }
                                    }
                                }

                                Riesgo _R = new Riesgo();
                                List<Riesgo> LR = _R.GetRiesgo(Diabetes, Sexo, Edad, Tabaquismo);
                                int indexLR = -1;
                                int pointer = 0;
                                if (LR != null)
                                {

                                    for (int b = 0; b < 4; b++)
                                    {
                                        Response.Write("<tr>");

                                        for (int a = 0; a < 5; a++)
                                        {
                                            if (LR[pointer].RiesgoCV == "V") Response.Write("<td style=\"Color:White;Background-Color:Green !important\">");
                                            if (LR[pointer].RiesgoCV == "A") Response.Write("<td style=\"Color:Black;Background-Color:Yellow !important\">");
                                            if (LR[pointer].RiesgoCV == "N") Response.Write("<td style=\"Color:Black;Background-Color:Orange !important\">");
                                            if (LR[pointer].RiesgoCV == "R") Response.Write("<td style=\"Color:White;Background-Color:Red !important\">");
                                            if (LR[pointer].RiesgoCV == "B") Response.Write("<td style=\"Color:White;Background-Color:Brown !important\">");

                                            if (LR[pointer].PAS == PAS && LR[pointer].Colesterol == Colesterol)
                                            {
                                                Response.Write("+");
                                                indexLR = pointer;
                                            }


                                            Response.Write("</td>");
                                            if (a == 4) {
                                                Response.Write("<td class=graduacionPAS style=\"font-size:10px !important\">");
                                                if (b == 0) Response.Write("180");
                                                if (b == 1) Response.Write("160");
                                                if (b == 2) Response.Write("140");
                                                if (b == 3) Response.Write("120");
                                                Response.Write("</td>");

                                            }
                                            if (b == 0 && a==4)
                                            {
                                                Response.Write("<td rowspan=4 style=\"font-size:10px !important\">PAS</td>");
                                            }


                                            pointer++;
                                        }

                                        Response.Write("</tr>");
                                    }
                                    Response.Write("<tr class=\"graduacion\">");
                                    Response.Write("<td>155</td>");
                                    Response.Write("<td>193</td>");
                                    Response.Write("<td>232</td>");
                                    Response.Write("<td>270</td>");
                                    Response.Write("<td>309</td>");
                                    Response.Write("</tr>");
                                    Response.Write("<tr><td colspan=5 style=\"font-size:10px !important\">colesterol mg/dl</td></tr>");

                                    if (indexLR != -1)
                                    {

                                        Response.Write("Riesgo estimado ");
                                        if (LR[indexLR].RiesgoCV == "V") Response.Write("menor a 10%");
                                        if (LR[indexLR].RiesgoCV == "A") Response.Write("10% a 20%");
                                        if (LR[indexLR].RiesgoCV == "N") Response.Write("20% a 30%");
                                        if (LR[indexLR].RiesgoCV == "R") Response.Write("30% a 40%");
                                        if (LR[indexLR].RiesgoCV == "B") Response.Write("mayor a 40%");
                                    }
                                }
                                else
                                {

                                }

                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <asp:Button runat="server" Text="Guardar" ID="btnSaveSomatometria" OnClick="btnSaveSomatometria_Click" />
        <%


        %>
    </div>
</div>

<div></div>
<br />



<div runat="server" id="divHerramientas" style="display: inline-flex; clear: both; width: 100%; height: 10px">
    <input type="button" onclick="EsconderTodasLasFichasDeEnfermeria()" class="DispensarioButton2 DispensarioNormalButton" value="Mostrar Consultas" />
    <input type="button" onclick="EsconderTodasLasFichasDeMedico()" class="DispensarioButton2 DispensarioNormalButton" value="Mostrar Enfermeria" />
    <input type="button" onclick="MostrarTodasLasMinimizadas()" class="DispensarioButton2 DispensarioNormalButton" value="Mostrar Todo" />
</div>
<div id="HistorialClinico" style="padding-bottom: 10px; padding-top: 10px">

    <% if (Session["Paciente"] != null)
        {
            ConnectionDispensario.Modelos.Paciente P = (ConnectionDispensario.Modelos.Paciente)Session["Paciente"];
            if (P != null)
            {
                List<ConnectionDispensario.Modelos.Historial> HP = P.Get_Historial();
                if (HP != null)
                {

                    for (int a = 0; a < HP.Count; a++)
                    {
                        List<ConnectionDispensario.Modelos.ProfileUser> Profile = HP[a].GetProfileUser((int)Session["IdPortal"]);

                        String classmedico = "";
                        String classenfermero = "";
                        String classmedicoprofesional = "";
                        String classenfermeroprofesional = "";

                        for (int pp = 0; pp < Profile.Count; pp++)
                        {
                            if (Profile[pp].KEY == "Medico") { classmedico = "classmedico"; classenfermeroprofesional = "classmedicoprofesional"; }
                            if (Profile[pp].KEY == "Enfermero") { classenfermero = "classenfermero"; classenfermeroprofesional = "classenfermeroprofesional"; }
                        }

                        if (classenfermeroprofesional == "" && classenfermeroprofesional == "")
                        {
                            classenfermeroprofesional = "classneutral";
                            classmedicoprofesional = "classneutral";
                        }




                        Response.Write("<div class=\"ContenedorFichaMinimizada " + classmedico + " " + classenfermero + "\"" + "id=\"FichaMinimizada" + a.ToString() + "\">");


                        Response.Write("<div class=\"MaximizeButton\" onclick=\"MaximizarFicha(" + a.ToString() + ")\">+</div>");
                        string Puesto = "No establecido";
                        string MP = "No establecido";
                        string ME = "No establecido";



                        if (Profile != null && Profile.Count > 0)
                        {
                            for (int b = 0; b < Profile.Count; b++)
                            {
                                if (Profile[b].KEY == "Puesto")
                                {
                                    Puesto = Profile[b].VALUE;
                                }
                            }
                        }

                        Response.Write("(" + Puesto + ")" + " " + HP[a].FECHA.ToLongDateString());

                        if (HP[a].ISODONTOGRAMA == true)
                        {
                            Response.Write("<img src=\" /DesktopModules/HistoriaClinica/images/Tooth.png\" style=\"width:32px;height:32px\">");
                        }

                        Response.Write("</div>");

                        Response.Write("<div class=\"ContenedorFicha\" id=\"Ficha" + a.ToString() + "\">");
                        Response.Write("<div class=\"ProfesionalContainer " + classmedicoprofesional + " " + classenfermeroprofesional + "\">");
                        Response.Write("<div class=\"MinimizeButton\" onclick=\"MinimizarFicha(" + a.ToString() + ")\">-</div>");
                        Response.Write("<img class=\"profilePicture\" src=\"/DnnImageHandler.ashx?mode=profilepic&userId=" + HP[a].IDUSER.ToString() + "&h=100&w=100\"></br>");



                        if (Profile != null && Profile.Count > 0)
                        {
                            for (int b = 0; b < Profile.Count; b++)
                            {
                                if (Profile[b] != null && Profile[b].VALUE != null && Profile[b].VALUE.Trim() != "" && Profile[b].VALUE != "si")
                                {
                                    Response.Write(Profile[b].KEY + ":<b>" + Profile[b].VALUE + "</b></br>");
                                }

                            }
                        }




                        Response.Write("</div>");
                        Response.Write("<div class=\"DiagnosticoContainer\">");
                        Response.Write("<div>");
                        Response.Write("<b>" + HP[a].FECHA.ToLongDateString() + "</b>");

                        Response.Write("</div>");
                        if (HP[a].ISODONTOGRAMA == true)
                        {
                            Odontograma O = HP[a].ODONTOGRAMA;
                            if (O.DIENTES != null && O.DIENTES.Count > 0)
                            {
                                for (int d = 0; d < O.DIENTES.Count; d++)
                                {
                                    Diente MyD = O.DIENTES[d];
                                    Tooth T = LoadControl("/DesktopModules/HistoriaClinica/Tooth.ascx") as Tooth;
                                    T.SetTooth(MyD.Iddiente);
                                    T.SetState(MyD);

                                    string CR = "";
                                    CR = ControlRender.LoadMyControl(T);
                                    Response.Write(CR);


                                }
                            }
                        }
                        else
                        {
                            if (Session["administrativo"] == null)
                            {
                                Response.Write(HP[a].DIAGNOSTICO);
                            }
                            else
                            {
                                Response.Write(HP[a].DIAGNOSTICOCENSURADO);
                            }
                            Response.Write("</br>");
                            Response.Write("<Input ID=\"H" + HP[a].ID + "\" type=\"button\" value=\"Imprimir Informe de guardia\" onclick=\"imprimirHistoria(this)\" />");
                        }

                        Response.Write("</div>");
                        Response.Write("</div>");
                    }
                }
            }


        }


    %>
    <div id="Muestra" style="height: 150px; display: none">
        <div style="float: left; width: 30%; height: 100%"></div>
        <div style="width: 70%; float: right; height: 100%"></div>
    </div>
</div>
<div></div>

<div>
    <%

        if (Session["Paciente"] != null && Session["administrativo"] == null)
        {

            Response.Write("<input id=\"btnTexto\" onclick=\"MostrarTexto()\" type=\"button\" value=\"Redactar Texto\" class=\"DispensarioButton2 DispensarioNormalButton\" />");

            Response.Write("<input id=\"btnOdontograma\" onclick=\"MostrarOdontograma()\" type=\"button\" value=\"Crear Odontograma\" class=\"DispensarioButton2 DispensarioNormalButton\" />");
        }
    %>
</div>



<div id="OdontogramaConstructor" runat="server">
    <div style="height: 20px; width: 50%; background-color: #FFFFFF; border-color: #000000; border-radius: 20px; border-width: 2px; border-style: solid">
        <div style="height: 5px; width: 100%; background-color: red">
        </div>
    </div>
    <div style="margin-top: 10px">
        <div id="Grupo1" style="display: inline-block" runat="server"></div>

        <div id="Grupo2" style="display: inline-block" runat="server"></div>
    </div>

    <div style="margin-top: 10px">
        <div id="Grupo3" style="display: inline-block" runat="server"></div>

        <div id="Grupo4" style="display: inline-block" runat="server"></div>
    </div>
    <div style="width: 100%">
        <input type="button" class="DispensarioButton2 DispensarioNormalButton" onclick="InsertOdontograma()" value="Guardar Odontograma" />

    </div>
</div>

<div id="EditorDeHistorial" runat="server">
    <div>1) Redacte su diagnostico clínico en la caja de texto verde</div>
    <div id="ContainerCajaTexto">
        <textarea class="HistorialEditor"
            style="width: 100%; height: 300px; border: solid; border-color: #808080; resize: none; background-color: #e8f5e9; border-radius: 8px"
            id="CajaTexto"></textarea>
    </div>
    <asp:Button runat="server" Text="Guardar Diagnostico" CssClass="DispensarioButton2 DispensarioNormalButton" ID="btnGuardarDiagnostico" ClientIDMode="Static" OnClientClick="POSTHISTORIAL();return false;" />
    <input type="button" onclick="AumentarTTexto()" class="DispensarioButton2 DispensarioNormalButton" value="Aumentar Texto" />
    <input type="button" onclick="ReducirTTexto()" class="DispensarioButton2 DispensarioNormalButton" value="Reducir Texto" />
    <input type="button" onclick="ResetTTexto()" class="DispensarioButton2 DispensarioNormalButton" value="Normalizar Texto" />

</div>

<div id="Confirmation">
    <div>
        Desea borrar la medicación habitual?
    </div>
    <div>
        <input type="button" value="Si" onclick="ConfirmMed()" />
        <input type="button" value="No" onclick="CancelMed()" />

    </div>
</div>

<div id="ConfirmationTox">
    <div>
        Desea borrar este habito del paciente?
    </div>
    <div>
        <input type="button" value="Si" onclick="ConfirmTox()" />
        <input type="button" value="No" onclick="CancelTox()" />

    </div>
</div>

<div id="DialogGuardia" title="Informe de guardia">
    <span>Diagnostico:</span><input type="text" id="GuardiaDiagnostico" style="width: 200PX" /><br />
    <span>Observacion en guardia:</span><input id="GuardiaObservacion" type="checkbox" /><br />
    <span>Provision de medicamento:</span><input id="GuardiaProvision" type="checkbox" /><br />
    <input type="button" value="Imprimir Informe de Guardia" onclick="ImprimirInforme()" />
    <span id="txtwait">Aguarde un momento...</span>

</div>

<input type="hidden" id="IDP" value="<%= ((int)Session["IdPortal"]).ToString() %>" />
<input type="hidden" id="IDU" value="<%= ((int)Session["IdUser"]).ToString() %>" />
<input type="hidden" id="UIP" value="<%= (Session["Paciente"]!=null) ? ((ConnectionDispensario.Modelos.Paciente) Session["Paciente"]).GUID : "0" %>" />
<input type="hidden" id="IDPP" value="<%= (Session["Paciente"]!=null) ? ((ConnectionDispensario.Modelos.Paciente) Session["Paciente"]).ID.ToString() : "0" %>">
<input type="hidden" id="Med" value="" />
<input type="hidden" id="Tox" value="" />
<input type="hidden" id="CurrentOdontograma" value="" />
<input type="hidden" id="CurrentHistorial" value="" />
<script>

    $("#OdontogramaConstructor").hide();
    $("#EditorDeHistorial").hide();
    $("#txtwait").hide();
    function Replaceme(cadena, index, replacement) {
        return cadena.substr(0, index) + replacement + cadena.substr(index + replacement.length);
    };

    var keydiente;

    function ImprimirInforme() {
        var Diagnostico = $('#GuardiaDiagnostico').val();
        var Observacionenguardia = "No";
        var Provisiondemedicamento = "No";
        if ($('#GuardiaObservacion').is(":checked") == true) Observacionenguardia = "Si";
        if ($('#GuardiaProvision').is(":checked") == true) Provisiondemedicamento = "Si";

        $("#txtwait").show();
        window.location.href = "/DesktopModules/HistoriaClinica/Reports/InformeGuardia.aspx?hid="
            + $('#CurrentHistorial').val()
            + "&Diag="
            + Diagnostico
            + "&obs="
            + Observacionenguardia
            + "&med="
            + Provisiondemedicamento;

    }

    function interpretarDiente(pdiente) {
        var containerpadre = $(pdiente).parent().parent().parent();
        var containerdiente = $(pdiente).parent().parent();
        var datadiente = $(containerdiente).children("svg").children("input");
        var inputdeldiente = $(datadiente).attr("value");
        $(containerpadre).children("div[onclick]").remove();
        $(containerpadre).children("br").remove();
        $(containerdiente).children("svg").children("polygon").removeAttr("onclick");

        var t = $(containerdiente).children("svg").children("polygon[id=T]");
        var b = $(containerdiente).children("svg").children("polygon[id=B]");
        var l = $(containerdiente).children("svg").children("polygon[id=L]");
        var r = $(containerdiente).children("svg").children("polygon[id=R]");
        var c = $(containerdiente).children("svg").children("polygon[id=C]");
        var o = $(containerdiente).children("svg").children("circle");
        var x = $(containerdiente).children("svg").children("g");

        loadState(t, inputdeldiente.charAt(0));
        loadState(b, inputdeldiente.charAt(1));
        loadState(l, inputdeldiente.charAt(2));
        loadState(r, inputdeldiente.charAt(3));
        loadState(c, inputdeldiente.charAt(4));
        loadmark(x, inputdeldiente.charAt(5));
        loadmark(o, inputdeldiente.charAt(6));


    }

    function LoadTooths() {
        var arrayToothsLoaded = $("toothstate");
        for (a = 0; a < arrayToothsLoaded.length; a++) {
            diente = arrayToothsLoaded[a];
            if ($(diente).attr("value") == "loaded") {
                interpretarDiente(diente);
            }

        }




    }
    LoadTooths();
    function SaveTooths() {
        var arrayTooths;
        if (keydiente != "null") {

            arrayTooths = $("div[id='ContainerTooth']");
            if (arrayTooths.length > 0) {
                for (a = 0; a < arrayTooths.length; a++) {
                    var toothpointer = $(arrayTooths[a]);
                    var numeroElemento = toothpointer.children("#numeroElemento");
                    var dataelemento = toothpointer.children("#diente").children("#VB").children("input");
                    var numerovalor = numeroElemento.text();
                    var datavalor = dataelemento.attr("value");
                    $.ajax(
                        {
                            url: "/DesktopModules/HistoriaClinica/WSHistoriaClinica.aspx?" + "MOD=insertTooth&KEY=" + keydiente + "&TID=" + numerovalor + "&data=" + datavalor,
                            type: "GET",
                            async: false,
                            success: function (result) {
                                if (result == "ok") {
                                    numeroElemento.attr("style", "color:#AAFFAA;background-color:#555555");
                                } else {
                                    numeroElemento.attr("style", "color:#FF8888;background-color:#555555");
                                }
                            },
                            error: function (jqXHR, TextStatus, errorThrown) {
                                numeroElemento.attr("style", "color:#RR8888;background-color:#555555");
                            }


                        });

                }

            }
            redirecttome();
        }
    }

    function imprimirHistoria(obj) {
        IDH = $(obj).attr("ID");
        $("#CurrentHistorial").val(IDH);
        $("#DialogGuardia").dialog('open');

    }



    function InsertOdontograma() {
        IDP = $("#IDPP").val();
        IDU = $("#IDU").val();
        UIP = $("#UIP").val();
        MED = $("#Med").val();
        keydiente = "null";

        $.ajax({
            url: "/DesktopModules/HistoriaClinica/WSHistoriaClinica.aspx?" + "MOD=getuidodontograma&UID=" + IDU + "&PID=" + UIP,
            type: "GET",
            success: function (result) {
                keydiente = result;
                SaveTooths();
            },
        })

    }

    function MostrarTexto() {
        $("#EditorDeHistorial").show();
        $("#OdontogramaConstructor").hide();
    }

    function MostrarOdontograma() {
        $("#EditorDeHistorial").hide();
        $("#OdontogramaConstructor").show();
    }

    function ConfirmMed() {
        Med = $("#Med").val();
        window.location.href = "/Historia-Clinica?delmed=" + Med;
    }
    function ConfirmTox() {
        Tox = $("#Tox").val();
        window.location.href = "/Historia-Clinica?deltox=" + Tox;
    }

    function CancelMed() {
        $("#Confirmation").dialog('close');
    }

    function CancelTox() {
        $("#ConfirmationTox").dialog('close');
    }

    function DelMed(MedID) {
        $("#Med").val(MedID);
        $("#Confirmation").dialog('open');

    }

    function DelTox(ToxID) {
        $("#Tox").val(ToxID);
        $("#ConfirmationTox").dialog('open');

    }


    function resetMarks(object) {
        var valcontainer;
        var preval;
        var newval;
        tobjeto = $(object).parent().children("#diente").children("#VB").children("#Cros");
        tobjeto.attr("visibility", "hidden");
        tobjeto = $(object).parent().children("#diente").children("#VB").children("#Circ");
        tobjeto.attr("visibility", "hidden");
        valcontainer = $(object).parent().children("#diente").children("#VB").children("input");
        preval = valcontainer.attr("value");
        newval = Replaceme(preval, 5, "x");
        newval = Replaceme(newval, 6, "x");
        valcontainer.attr("value", newval);
    }

    function changeCrosstoRed(object) {

        tobjeto = $(object).parent().children("#diente").children("#VB").children("#Cros");
        tobjeto.attr("visibility", "visible");
        tobjeto.attr("stroke", "red");
        var valcontainer;
        var preval;
        var newval;
        valcontainer = $(object).parent().children("#diente").children("#VB").children("input");
        preval = valcontainer.attr("value");
        newval = Replaceme(preval, 5, "r");
        valcontainer.attr("value", newval);
    }

    function changeCrosstoBlue(object) {
        tobjeto = $(object).parent().children("#diente").children("#VB").children("#Cros");
        tobjeto.attr("visibility", "visible");
        tobjeto.attr("stroke", "blue");
        var valcontainer;
        var preval;
        var newval;
        valcontainer = $(object).parent().children("#diente").children("#VB").children("input");
        preval = valcontainer.attr("value");
        newval = Replaceme(preval, 5, "b");
        valcontainer.attr("value", newval);
    }



    function changeCircletoRed(object) {
        tobjeto = $(object).parent().children("#diente").children("#VB").children("#Circ");
        tobjeto.attr("visibility", "visible");
        tobjeto.attr("stroke", "red");
        var valcontainer;
        var preval;
        var newval;
        valcontainer = $(object).parent().children("#diente").children("#VB").children("input");
        preval = valcontainer.attr("value");
        newval = Replaceme(preval, 6, "r");
        valcontainer.attr("value", newval);
    }
    function changeCircletoBlue(object) {
        tobjeto = $(object).parent().children("#diente").children("#VB").children("#Circ");
        tobjeto.attr("visibility", "visible");
        tobjeto.attr("stroke", "blue");
        var valcontainer;
        var preval;
        var newval;
        valcontainer = $(object).parent().children("#diente").children("#VB").children("input");
        preval = valcontainer.attr("value");
        newval = Replaceme(preval, 6, "b");
        valcontainer.attr("value", newval);
    }


    function loadState(pobject, value) {
        if (value == "r") {
            $(pobject).attr('fill', "red");
        }

        if (value == "b") {
            $(pobject).attr('fill', "blue");
        }

    }



    function loadmark(object, value) {
        if (value == "r") {
            $(object).attr("visibility", "visible");
            $(object).attr("stroke", "red");
        }
        if (value == "b") {
            $(object).attr("visibility", "visible");
            $(object).attr("stroke", "blue");
        }
    }

    function changeState(object) {


        if ($(object).attr('fill') == "white") {
            $(object).attr('fill', 'blue');
            var idobject = $(object).attr("id");
            var hiddenfield = $(object).parent().children("input");
            var hiddenvalue = hiddenfield.attr("value");
            if (idobject == "T") { hiddenvalue = Replaceme(hiddenvalue, 0, "b"); }
            if (idobject == "B") { hiddenvalue = Replaceme(hiddenvalue, 1, "b"); }
            if (idobject == "L") { hiddenvalue = Replaceme(hiddenvalue, 2, "b"); }
            if (idobject == "R") { hiddenvalue = Replaceme(hiddenvalue, 3, "b"); }
            if (idobject == "C") { hiddenvalue = Replaceme(hiddenvalue, 4, "b"); }
            hiddenfield.attr("value", hiddenvalue);
            return 0;
        }

        if ($(object).attr('fill') == "blue") {
            $(object).attr('fill', 'red');
            var idobject = $(object).attr("id");
            var hiddenfield = $(object).parent().children("input");
            var hiddenvalue = hiddenfield.attr("value");
            if (idobject == "T") { hiddenvalue = Replaceme(hiddenvalue, 0, "r"); }
            if (idobject == "B") { hiddenvalue = Replaceme(hiddenvalue, 1, "r"); }
            if (idobject == "L") { hiddenvalue = Replaceme(hiddenvalue, 2, "r"); }
            if (idobject == "R") { hiddenvalue = Replaceme(hiddenvalue, 3, "r"); }
            if (idobject == "C") { hiddenvalue = Replaceme(hiddenvalue, 4, "r"); }
            hiddenfield.attr("value", hiddenvalue);

            return 0;
        }

        if ($(object).attr('fill') == "red") {
            $(object).attr('fill', 'white');
            var idobject = $(object).attr("id");
            var hiddenfield = $(object).parent().children("input");
            var hiddenvalue = hiddenfield.attr("value");
            if (idobject == "T") { hiddenvalue = Replaceme(hiddenvalue, 0, "x"); }
            if (idobject == "B") { hiddenvalue = Replaceme(hiddenvalue, 1, "x"); }
            if (idobject == "L") { hiddenvalue = Replaceme(hiddenvalue, 2, "x"); }
            if (idobject == "R") { hiddenvalue = Replaceme(hiddenvalue, 3, "x"); }
            if (idobject == "C") { hiddenvalue = Replaceme(hiddenvalue, 4, "x"); }
            hiddenfield.attr("value", hiddenvalue);
            return 0;
        }
    }

    var NormalText = 16;

    function AumentarTTexto() {
        NormalText++;
        ChangeTextSize(NormalText);
    }

    function ReducirTTexto() {
        NormalText--;
        ChangeTextSize(NormalText);
    }

    function ResetTTexto() {
        NormalText = 16;
        ChangeTextSize(NormalText);
    }

    function ChangeTextSize(textsize) {
        var nts = textsize + 'px';
        $("#CajaTexto").css({
            'fontSize': nts, 'line-height': nts
        });
    }

    var M;

    function MinimizarFicha(idficha) {
        $("#Ficha" + idficha).hide();
        $("#FichaMinimizada" + idficha).show();
    }

    function MaximizarFicha(idficha) {
        $("#Ficha" + idficha).show();
        $("#FichaMinimizada" + idficha).hide();
    }

    function CreateDialog() {
        var dlg = $('#DialogPacienteSearch').dialog(
            {
                closeOnEscape: true,
                autoOpen: false,
                draggable: false,
                modal: true,
                resizable: false,
                autoResize: true,
                dialogClass: 'dnnFormPopup',
                width: 'auto'

            });
        dlg.parent().appendTo($("form:first"));
        dlg.parent().css('z-index', '1005');
    }

    function CreateDialogGuardia() {
        var dlg = $('#DialogGuardia').dialog(
            {
                closeOnEscape: true,
                autoOpen: false,
                draggable: false,
                modal: true,
                resizable: false,
                autoResize: true,
                dialogClass: 'dnnFormPopup',
                width: 'auto'

            });
        dlg.parent().appendTo($("form:first"));
        dlg.parent().css('z-index', '1005');
    }

    function CreateDialogMed() {
        var dlg = $('#Confirmation').dialog(
            {
                closeOnEscape: true,
                autoOpen: false,
                draggable: false,
                modal: true,
                resizable: false,
                autoResize: true,
                dialogClass: 'dnnFormPopup',
                width: 'auto'

            });
        dlg.parent().appendTo($("form:first"));
        dlg.parent().css('z-index', '1005');
    }

    function CreateDialogTox() {
        var dlg = $('#ConfirmationTox').dialog(
            {
                closeOnEscape: true,
                autoOpen: false,
                draggable: false,
                modal: true,
                resizable: false,
                autoResize: true,
                dialogClass: 'dnnFormPopup',
                width: 'auto'

            });
        dlg.parent().appendTo($("form:first"));
        dlg.parent().css('z-index', '1005');
    }


    function ShowDialog() {
        $('#DialogPacienteSearch').dialog('open');
    }
    function HideDialog() {
        $('#DialogPacienteSearch').dialog('close');
    }
    CreateDialog();
    CreateDialogMed();
    CreateDialogTox();
    CreateDialogGuardia();


    if ($("#<%=show_search.ClientID%>").val() == "1") {
        ShowDialog();
    }

    function OpenWindow(path) {
        window.open(path);
    }

    function POSTHISTORIAL() {

        $.ajax({
            url: "/DesktopModules/HistoriaClinica/Pacientes.asmx/InsertHistory",
            data: { "Historial": $("#CajaTexto").val(), "IdUser": $('#IDU').val(), "IdPortal": $('#IDP').val(), "UIPaciente": $('#UIP').val() },
            method: "POST",
            cache: false,

            success: function (data) {
                alert("Datos Guardados con exito");
                $("#CajaTexto").val("");
                redirecttome();
            }
        });

    }
    function redirecttome() {
        window.location.href = "/Historia-Clinica";
    }
    function ShowHistorial(GUI) {
        window.location.href = "/Historia-Clinica?m=s&gui=" + GUI;
    }

    function EsconderTodasLasFichasDeEnfermeria() {
        EsconderTodasLasFichas();
        MostrarTodasLasMinimizadas();
        $(".classenfermero").hide();



    }

    function EsconderTodasLasFichasDeMedico() {
        EsconderTodasLasFichas();
        MostrarTodasLasMinimizadas();
        $(".classmedico").hide();

    }

    function MostrarTodasLasMinimizadas() {
        EsconderTodasLasFichas();
        $(".ContenedorFichaMinimizada").show();
    }
    function EsconderTodasLasFichas() {
        $(".ContenedorFicha").hide();
    }

    $(function () { EsconderTodasLasFichas(); })

</script>

<p>
    &nbsp;
</p>
<p>
    &nbsp;
</p>


