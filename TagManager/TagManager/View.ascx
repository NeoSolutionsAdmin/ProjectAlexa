<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.TagManager.View" %>

<script src="/DesktopModules/TagManager/jQuery.js"></script>
<link href="/DesktopModules/TagManager/css/all.css" rel="stylesheet" />
<link href="/DesktopModules/TagManager/module.css" rel="stylesheet" />


<div>

    <h1>TAG MANAGER</h1>
    
    <!-- TABLA DE LOS TAGS -->
    <div>

    </div>

    <!-- Tabla con los tags creados -->
            <table id="tablaTagsCreados">

                <tr>
                    <th>NOMBRE</th>
                    <th>ÍCONO</th>
                </tr>
                <%--<%
                    List<ConnectionDispensario.Modelos.Tag> LT =
                        ConnectionDispensario.Modelos.Tag.GetTags();

                    for(int a = 0; a < LT.Count; a++)
                    {
                        Response.Write("<tr>" +
                                            "<td>" + LT[a].NOMBRE + "</td>" +

                                            "<td>" +
                                                "<span style='font-family: \"Font Awesome 5 Pro\"; font-weight: 900;'>&#" + LT[a].ICONO + "</span>" +
                                            "</td>" +

                                            "<td>" +
                                                "<input type='button' value='ELIMINAR' onclick='DeleteTag(" + LT[a].ID + ")'" +
                                            "</td>" +
                                       "</tr>");
                    }
                    %>   --%>             
            </table>

    <div>


        <!-- BOTONES -->
        <div>

            <input style="margin-top:40px" class="FormButton" value="CREAR TAG" type="button" id="abrirCrearTag" onclick="AbrirCerrar('crear')"/>            

        </div>

        <!-- CREAR TAG -->
        <div id="crearTagDiv" style="margin-top:50px;display:none">
            <h2>CREAR TAG</h2>

            <input type="button" value="NOMBRE" class="fakeButton"/> 
            <input type="text" style="margin-bottom:50px; height: 39.5px;" id="newTagNameText" placeholder="Nombre del tag" />
            <input type="button" value="CREAR" onclick="GetAndSave()" /><br />

            <div style="display:none" id="iconoSeleccionadoDiv">

                ICONO SELECCIONADO 
                <input type="button" class="TagButton" id="iconoSeleccionado" />

            </div>

            <input type="button" class="FormButton" value="MOSTRAR LISTA" onclick="AbrirCerrar('listaTags')" /> <br />

            
            

            <!-- LISTA CON LOS ICONOS -->
            <div id="TagContainerDiv" style="display:none">
                <div style="text-align:center">
                    <h3>
                        - ÍCONO -
                    </h3>                
                </div>

                <br />

                <!-- Lista -->
                <div class="TagContainer">
                    <%
                        List<int> LC = new List<int>();
                        LC = ConnectionDispensario.Modelos.Tag.GetCharsDiscriminados();
                        int counter = 0;
                        for(int a = 61440; a < 63459; a++)
                        {
                            bool skip = false;
                            for(int z = 0; z < LC.Count; z++)
                            {
                                if(a == LC[z])
                                {
                                    skip = true;
                                    break;
                                }
                                else
                                {
                                    skip = false;
                                }
                            }
                            if (!skip)
                            {
                                Response.Write("<input class='TagButton' onclick='SelectIcon(true," + a + ")' type='button' value='" + "&#" + a + "'>");
                                counter++;
                                //if (counter == 20)
                                //{
                                //    counter = 0;
                                //    Response.Write("</br>");
                                //}
                            }
                        }
                    %>
                </div>
            </div>            
        </div>
    </div>
</div>
