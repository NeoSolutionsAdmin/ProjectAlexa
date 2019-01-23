<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Servicios.View" %>
<%@ Import Namespace="ConnectionDispensario.Modelos" %>
<div>
<input type="text" id="txtServicio"/>
<input type="button" id="btnServicio" value="Añadir servicio" />
</div>
<div>
    <ul id="ServiceList">
        <%
            List<Servicio> ls = Servicio.ObtenerServicios();
            if (ls != null)
            {
                foreach (Servicio s in ls)
                {
                    Response.Write("<li>" + s.NOMBRE + "</li>");
                }
            }
            %>
    </ul>
</div>

