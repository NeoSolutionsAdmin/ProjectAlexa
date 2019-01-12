<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.TagManager.View" %>



<script src="/DesktopModules/TagManager/jQuery.js"></script>
<link href="/DesktopModules/TagManager/css/all.css" rel="stylesheet" />
<div>

    <h1>TAG MANAGER</h1>
    <i class="fas fa-address-book "></i>

    <%

        int counter = 0;
        for(int a = 61440; a < 63459; a++)
        {
            List<String> LC = new List<string>();
            LC = ConnectionDispensario.Modelos.Tag.GetCharsDiscriminados();
            for(int z = 0; z < LC.Count; z++)
            {
                if(a == int.Parse(LC[z]))
                {
                    break;
                }
                else
                {
                    string tohex = a.ToString("X");
                    Response.Write("<input class='fas' onclick='LogChar(" + a + ")' type='button' value='" + "&#" + a + "'>");
                    counter++;
                    if (counter == 673)
                    {
                        counter = 0;
                        Response.Write("</br>");
                    }
                }
            }   
        }


                %>

    <div>


        <!-- BOTONES -->
        <div>

            CREAR TAG <input type="button" id="abrirCrearTag" onclick="AbrirCerrar('crear')"/> <br />
            ELIMINAR TAG <input type="button" id="abrirEliminarTag" onclick="AbrirCerrar('eliminar')"/>

        </div>

        <!-- CREAR TAG -->
        <div id="crearTagDiv" style="display:none">
            <h2>CREAR TAG</h2>

            NOMBRE: <input type="text" placeholder="Nombre del tag" /> <br />
            ÍCONO: <!-- LISTA CON LOS ICONOS -->

            


        </div>


        <!-- ELIMINAR TAG -->
        <div id="eliminarTagDiv">

            <!-- Buscador -->
            BUSCAR <input type="text" placeholder="Nombre del tag." id="buscadorTagsCreados" />

            <!-- Tabla con los tags creados -->
            <table id="tablaTagsCreados">

                <tr>
                    <th>NOMBRE</th>
                    <th>ÍCONO</th>
                </tr>

            </table>

        </div>

    </div>

</div>