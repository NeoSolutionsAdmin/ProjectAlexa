<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Pizarra.View" %>


<div>

    <h1 style="margin-bottom: 50px;">PIZARRA</h1>

    <input type="button" id="ButtonCrearPost" onclick="AbrirCerrarCreatePost()" class="FormButton" value="Crear post" style="display: inline-block;" />

    <div style="display: none;" id="CrearNuevoPost">
        <input type="button" class="fakeButton" value="TITULO" />
        <input type="text" id="NewTituloPostText" /> <br />
        <input type="button" class="FormButton" onclick="AbrirBuscarPacientePopUp()" value="BUSCAR PACIENTE" />

        <span onclick="UndoSelectPaciente()" id="PacienteSeleccionado"></span> <br />

        <input type="button" onclick="GuardarPost()" value="GUARDAR" />

    </div>

    <!-- PACIENTE 1 -->
    <div style="background: #767676;">

        <!-- Nombre Paciente -->
        <div>
            <h2>LUCIANO LAPENNA</h2>
        </div>
        

        <!-- Sprints -->
        <div style="padding: 20px;">
            <h3>Administrar 2mg de x</h3>
            
            <p>Dr. Juan Bolainas - 22/02/2019 23:14 - ESTADO: <span style="color:green;">FINALIZADO</span></p>

            <!-- Comentarios -->
            <div style="padding: 20px;">
                
                <!-- Comentario -->
                <div>
                    <p>Dra. Fernanda Pérez - 23/02/2019 0:21</p>
                    <p>Administrados con éxito los 2mg de X</p>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- POP UPS -->
<div>
    <!-- Buscar Pacientes -->
    <div title="Buscar Paciente" id="BuscarPacientePopUp">
        <input type="button" value="Nombre" />
        <input type="text" id="ParametroBuscadorPacientes" /> <br />
        <input type="button" onclick="BuscarPaciente('1')" value="BUSCAR por APELLIDO" />
        <input type="button" onclick="BuscarPaciente('2')" value="BUSCAR por DOCUMENTO" />

        <table id="TablaResultadosPacientes">
            <tr>
                <th>APELLIDO</th>
                <th>NOMBRE</th>
                <th>NRO. DOCUMENTO</th>
            </tr>
        </table>
    </div>
</div>

<!-- HIDDENS -->
<div>
    
    <input type="hidden" id="IdPacienteHidden" />    
    <asp:HiddenField runat="server" ClientIDMode="Static" ID="IdProfesional" />
    
</div>

<script>


    // POP UP BUSCAR PACIENTE
    //
    var BuscarPacientePopUp = $('#BuscarPacientePopUp').dialog(
        {
            autoOpen: false,
            closeOnEscape: false,
            modal: true,
            dialogClass: 'dnnFormPopup',
            resizable: false,
            draggable: false,
            width: 'auto',
            show: 'blind',
            hide: 'blind',
        })
    //
    function AbrirBuscarPacientePopUp() {
        ReconstruirTabla();
        BuscarPacientePopUp.dialog('open');
    }
    function CerrarBuscarPacientePopUp() {
        BuscarPacientePopUp.dialog('close');
    }
    //
    function BuscarPaciente(tipoDeDatos) {

        var paramBusqueda = $('#ParametroBuscadorPacientes').val()
        if (paramBusqueda == "") {
            alert("Falta rellenar el campo de texto");
        }
        else {
            SearchPacientes(tipoDeDatos, paramBusqueda)
        }
        
    }
    //
    function SearchPacientes(tipoDeDatos, data) {
            $.ajax({

            url: "DesktopModules/Pizarra/WebService.aspx",
            dataType: 'json',
            data:
            {
                tipoDeDatos: tipoDeDatos,
                busquedaPaciente: data               
            },
            success: function (data)
            {
                ReconstruirTabla();
                for (a = 0; a < data.length; a++) {
                    $('#TablaResultadosPacientes').append(
                        "<tr>" +
                            "<td>" + data[a].APELLIDO + "</td>" +
                            "<td>" + data[a].NOMBRE + "</td>" +
                            "<td>" + data[a].NRODOCUMENTO + "</td>" +
                            "<td> <input type='button' value='SELECCIONAR' onclick='SelectPaciente(\"" + data[a].ID + "\",\"" + data[a].NOMBRE + "\")' /> </td>" + 
                        "</tr>"
                        );
                    }
                }
            })          
    }
    //
    function ReconstruirTabla() {
        $('#TablaResultadosPacientes').empty();
        $('#TablaResultadosPacientes').append
            (
            "<tr>" +
                "<th>APELLIDO</th>" +
                "<th>NOMBRE</th>" +
                "<th>DNI</th>" +
            "<tr>");
    }

    function SelectPaciente(Id, Nombre) {
        CerrarBuscarPacientePopUp();
        $('#PacienteSeleccionado').text("Paciente seleccionado: " + Nombre);
        $('#PacienteSeleccionado').show('slow');
        $('#IdPacienteHidden').val(Id);
    }
    function UndoSelectPaciente() {
        $('#PacienteSeleccionado').hide('slow');
        $('#PacienteSeleccionado').text('');
        $('#IdPacienteHidden').val('');
    }

    function AbrirCerrarCreatePost() {
        var div = $('#CrearNuevoPost');
        var button = $('#ButtonCrearPost')

        if (div.is(":hidden")) {
            div.show('slow');
            button.val("CERRAR")
        }
        else {
            div.hide('slow');
            button.val("CREAR POST")
        }
    }

    function GuardarPost() {
        var titulo = $('#NewTituloPostText').val();
        var idPaciente = $('#IdPacienteHidden').val();
        var idProfesional = $('#IdProfesional').val();

        console.log(titulo + " " + idPaciente + " " + idProfesional);

        if (titulo != "" && idPaciente != "") {
            $.ajax({
                url: "DesktopModules/Pizarra/WebService.aspx",
                dataType: 'text',
                data:
                {
                    newPost: 'true',
                    idPaciente: idPaciente,
                    titulo: titulo,
                    idProfesional: idProfesional,
                },
                success: function (data) {
                    if (data == "True") {
                        alert("Post agregado con éxito.");
                    }
                    else {
                        alert("Hubo un error inesperado y no se agregó el post.")
                    }
                }
            })
        }
        else {
            alert("Falta completar un campo.");
        }
    }


</script>