<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Planillas.View" %>

<span>Mes:</span>
<select id="month">
    <option value="00"></option>
    <option value="01">Enero</option>
    <option value="02">Febrero</option>
    <option value="03">Marzo</option>
    <option value="04">Abril</option>
    <option value="05">Mayo</option>
    <option value="06">Junio</option>
    <option value="07">Julio</option>
    <option value="08">Agosto</option>
    <option value="09">Septiembre</option>
    <option value="10">Octubre</option>
    <option value="11">Noviembre</option>
    <option value="12">Diciembre</option>
</select>
<span>Año:</span>
<select id="year">
    <option value="00"></option>
    <option value="2019">2019</option>
    <option value="2020">2020</option>
</select>
<br />
<span>Servicio:</span>
<select id="service">
    <option value="00"></option>
    <%
        List<ConnectionDispensario.Modelos.Servicio> misservicio = ConnectionDispensario.Modelos.Servicio.ObtenerServicios();
        if (misservicio != null)
        {
            foreach (ConnectionDispensario.Modelos.Servicio s in misservicio)
            {
                Response.Write("<option value=\"" + s.ID + "\">" + s.NOMBRE + "</servicio>");

            }
        }
        %>
</select>
<input type="button" value="C2" onclick="GetC2()" /><br />
<input type="button" value="C3" />
<script>
    var year;
    var month;
    var service;
    function SetVars()
    {
        month =  $("#month").children("option:selected").val();
        year = $("#year").children("option:selected").val();
        service = $("#service").children("option:selected").val();
        if (month == "00")
        {
            alert("Debe seleccionar un mes");
            return false;
        }
        if (year == "00")
        {
            alert("Debe seleccionar un año");
            return false;
        }
        if (service == "00")
        {
            alert("Debe seleccionar un servicio");
            return false;
        }
        return true;
    }

    function GetC2()
    {
        if (SetVars() == true)
        {
            window.location.href = "/DesktopModules/Planillas/Reportes.aspx?C2=true&month="+month+"&year="+year+"&service="+service;
        }
    }

</script>