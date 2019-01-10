<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.TagManager.View" %>


<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<script src="/DesktopModules/TagManager/jQuery.js"></script>

<div>

    <h1>TAG MANAGER</h1>
    <i class="fas fa-address-book "></i>

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

        </div>

    </div>

</div>