<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.ControlDeJornadas.View" %>


<%@ Import Namespace="ConnectionDispensario.Modelos" %>
<div style="color:red;font-weight:bold"> Recuerde actualizar la página presionando F5 o ingresando nuevamente al mádulo antes de realizar una operación</div>
<%
    if (Session["ListadoUsuarios"] != null)
    {


        List<Usuario> UserList = Session["ListadoUsuarios"] as List<Usuario>;

        if (UserList != null && UserList.Count > 0)
        {
            foreach (Usuario UI in UserList)
            {

                List<Turno> T = Turno.GetTurnosByUser(UI.USERID);
                List<Turno> NT = new List<Turno>();

                int counter = 0;
                bool espera = false;
                bool progreso = false;
                bool diagnostico = false;

                if (T != null && T.Count>0)
                {
                    for (int a = T.Count-1; a > -1; a--)
                    {
                        if (T[a].FechaComienzo.DayOfYear == DateTime.Now.DayOfYear)
                        {
                            if (T[a].Esstado != "Cancelado") {
                                NT.Add(T[a]);
                                if (T[a].Esstado == "Espera") { espera = true; }
                                if (T[a].Esstado == "Progreso") { progreso = true; }
                                if (T[a].DiagnosticoFinal == null) { diagnostico = true; }
                            }
                        }
                    }
                }



                Response.Write("<Div class=\"UserContainer\" id=\"ConteinerUser" + UI.USERID + "\">");
                Response.Write("<div class=\"roundProfilePicture\">");
                Response.Write("<img src=\"/DnnImageHandler.ashx?mode=profilepic&userId=" + UI.USERID.ToString() + "&h=120&w=120\"/>");
                Response.Write("</div>");
                Response.Write("<div class=\"DataProfile\">");
                Response.Write( "<b>" +UI.NAME + " " + UI.LASTNAME + "</b></br>");
                if (espera == false && progreso == false && diagnostico==false)
                {
                    bool jornadaabierta = false;
                    Jornada J = Jornada.GetLast(UI.USERID);
                    if (J != null)
                    {
                        if (J.End != null)
                        {
                            jornadaabierta = false;
                            string C1Function = "ImprimirC1(" +
                                J.End.Value.Year.ToString() + "," +
                                J.Start.Month.ToString() + "," +
                                J.End.Value.Month.ToString() + "," +
                                J.Start.Day.ToString() + "," +
                                J.End.Value.Day.ToString() + "," +
                                J.Start.Hour.ToString() + "," +
                                J.End.Value.Hour.ToString() + "," +
                                J.Start.Minute.ToString() + "," +
                                J.End.Value.Minute.ToString() + "," +
                                UI.USERID.ToString() + ")";


                            Response.Write("<input type=\"button\" value=\"Imprimir última C1 periodo:" +  J.Start.ToString() + "-" + J.End.ToString() + "\" onclick=\" " + C1Function + "\" >");
                        }
                        else
                        {
                            jornadaabierta = true;
                        }


                    }
                    else
                    {
                        jornadaabierta = false;
                    }

                    if (jornadaabierta == true)
                    {
                        Response.Write("<input type=\"button\" value=\"Finalizar Jornada\" onclick=\"ToggleJornada('" + UI.USERID + "')\" />");
                    }
                    else
                    {
                        Response.Write("<input type=\"button\" value=\"Comenzar Jornada\" onclick=\"ToggleJornada('" + UI.USERID + "')\" />");
                    }


                }
                else
                {
                    Response.Write("Este profesional no completo los procedimientos </br>");
                    Response.Write("necesarios para finalizar la jornada: </br>");
                    Response.Write("<Div style=\"color:red\">");
                    if (espera == true) { Response.Write("- Aun tiene pacientes en espera </br>"); }
                    if (progreso == true) { Response.Write("- Aun tiene pacientes en progreso </br>"); }
                    if (diagnostico == true) { Response.Write("- Falta diagnosticar pacientes </br>"); }
                    Response.Write("</Div>");

                }
                Response.Write("</br>");



                Response.Write("</div>");
                Response.Write("</Div>");




                string Estado_Espera = "Espera";
                string Estado_Progreso = "Progreso";
                string Estado_Cancelado = "Cancelado";
                string Estado_Finalizado = "Finalizado";



                if (NT != null && NT.Count > 0)
                {

                    Response.Write("<table class=\"NewTableStyle\" style=\"width:100%\">");
                    Response.Write("<tbody>");
                    Response.Write("<tr>");
                    Response.Write("<th>Paciente</th>");
                    Response.Write("<th>Hora Ingreso a est.</th>");
                    Response.Write("<th>Hora de atención</th>");
                    Response.Write("<th>Hora de finalización</th>");
                    Response.Write("<th>Diagnostico</th>");
                    Response.Write("</tr>");


                    foreach (Turno turno in NT)
                    {
                        if (turno.Pac != null) {

                            Response.Write("<tr>");
                            Response.Write("<td>" + turno.Pac.APELLIDO + ", " +  turno.Pac.NOMBRE  + "</td>");
                            Response.Write("<td>" + turno.FechaRecepcion.ToString() + "</td>");

                            if (turno.Esstado == "Progreso" || turno.Esstado == "Finalizado")
                            {
                                Response.Write("<td>" + turno.FechaComienzo.ToString() + "</td>");
                            }
                            else
                            {
                                Response.Write("<td><div class='NonDataCell'></div></td>");
                            }


                            if (turno.Esstado == "Finalizado")
                            {
                                Response.Write("<td>" + turno.FechaFinal.ToString() + "</td>");
                            }
                            else
                            {
                                Response.Write("<td><div class='NonDataCell'></div></td>");
                            }
                            if (turno.Esstado == "Finalizado" && turno.Esstado != "")
                            {
                                Response.Write("<td>" + turno.DiagnosticoFinal + "</td>");
                            }
                            else
                            {
                                Response.Write("<td> El Diagnostico aun no fue establecido </td>");
                            }
                            Response.Write("</tr>");

                        }

                    }

                    Response.Write("</tbody>");
                    Response.Write("</table>");
                }

            }
        }
    }

    /*
     <div style="width: 100%; overflow: hidden;">
    <div style="width: 600px; float: left;"> Left </div>
    <div style="margin-left: 620px;"> Right </div>
    </div>
     
     
     */

    %>

<asp:HiddenField ID="url" runat="server" ClientIDMode="Static" />
<script>
    //http://dispensario.com/DesktopModules/Turnero/Reportes.aspx?C1=1&IDP=0&UID=6&PID=0&Y=2018&MS=11&ME=11&DS=7&DE=7&HS=7&HE=21&EST=Chazon&MinStart=0&MinEnd=20
    function ImprimirC1(YS, MS, ME, DS, DE, HS, HE, MinS, MinE, UID)
    {
        a_c1 = "C1=1"
        a_portal = "IDP=0&PID=0";
        a_UID = "UID=" + UID;
        a_year = "Y=" + YS;
        a_MonthS = "MS=" + MS;
        a_MonthE = "ME=" + ME;
        a_DayS = "DS=" + DS;
        a_DayE = "DE=" + DE;
        a_HourS = "HS=" + HS;
        a_HourE = "HE=" + HE;
        a_Est = "EST=" + "Chazon";
        a_MinStart = "MinStart=" + MinS;
        a_MinEnd = "MinEnd=" + MinE;
        C1Parameters = a_c1 + "&" + a_portal + "&" + a_UID + "&" + a_year + "&" + a_MonthS + "&" + a_MonthE + "&" + a_DayS + "&" + a_DayE + "&" + a_HourS + "&" + a_HourE + "&" + a_Est + "&" + a_MinStart + "&" + a_MinEnd   
        window.open("/DesktopModules/Turnero/Reportes.aspx?" + C1Parameters);
    }

    function ToggleJornada(idu)
    {
        window.location.href = $("#url").val() + "?idu=" + idu;
    }
</script>