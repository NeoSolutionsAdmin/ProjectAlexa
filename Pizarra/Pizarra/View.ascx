<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Pizarra.View" %>


<div>

    <h1 style="margin-bottom: 50px;">PIZARRA</h1>

    <input type="button" class="FormButton" value="Crear post" style="display: inline-block;" />

    <div>
        <input type="button" class="fakeButton" value="TITULO" />
        <input type="text" /> <br />
        <input type="button" class="FormButton" onclick="AbrirBuscarPacientePopUp()" value="BUSCAR PACIENTE" />

        <span></span>
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
        if ($('#BuscarPacientePopUp').is(':hidden')){
            BuscarPacientePopUp.dialog('open');
        }
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
                        "<tr onclick='SelectPaciente(" + data[a].ID + ")'>" +
                            "<td>" + data[a].APELLIDO + "</td>" +
                            "<td>" + data[a].NOMBRE + "</td>" +
                            "<td>" + data[a].NRODOCUMENTO + "</td>" +
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

    }

</script>