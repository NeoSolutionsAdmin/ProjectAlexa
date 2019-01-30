<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Servicios.View" %>
<%@ Import Namespace="ConnectionDispensario.Modelos" %>
<%@ Import Namespace="DotNetNuke.Entities.Users"%>
<div>
<h2>Agregar Servicio</h2>
<input type="text" id="txtServicio"/>
<input type="button" id="btnServicio" value="Añadir servicio" onclick="AddService()" />
</div>
<div id="ContainerService">
    <h2>Listado de servicios</h2>
    <ul id="ServiceList">
        <%
            List<Servicio> ls = Servicio.ObtenerServicios();
            if (ls != null)
            {
                foreach (Servicio s in ls)
                {
                    Response.Write("<li class=\"DroppableService\" id=\"servicio" + s.ID + "\" data-serviceid=\"" + s.ID.ToString() + "\">" + s.NOMBRE + "</br><ul>");
                    List<ProfesionalServicio> tlu = s.GetProfesionales(0);
                    if (tlu != null)
                    {
                        foreach (ProfesionalServicio u in tlu)
                        {
                           
                            string img = "<img src=\"/DnnImageHandler.ashx?mode=profilepic&userId=" + u.user.USERID.ToString() + "&h=32&w=32\"/>";
                            Response.Write("<li class=\"UserInService\" data-userid=\"" + u.user.USERID + "\">" + img + u.user.NAME + " " + u.user.LASTNAME +"<input type=\"button\" onclick=\"deleteuser(this)\" value=\"X\"/></li>");
                           
                        }
                    }
                    Response.Write("</ul></li>");
                }
            }
            %>
    </ul>
</div>
<div>
    <ul id="usersList">
    <%
        List<Usuario> lu = Usuario.GetUsers(0);
        if (lu != null)
        {
            foreach (Usuario u in lu)
            {
                string img = "<img src=\"/DnnImageHandler.ashx?mode=profilepic&userId=" + u.USERID.ToString() + "&h=32&w=32\"/>";
                Response.Write("<li class=\"DraggableUser\" data-userid=\"" + u.USERID + "\">" + img + u.NAME + " " + u.LASTNAME +"</li>");

            }
        }
        %>
        </ul>
</div>

<script>




    $(".DroppableService").droppable(
        {
            accept: ".DraggableUser",
            over: function (event,ui)
            {
                $(this).css("background-color", "gray");
            },
            out: function (event,out)
            {
                $(this).css("background-color", "white");
            },
            drop: function (event, ui)
            {
                iduser = ui.draggable.attr("data-userid");
                idservice = $(this).attr("data-serviceid");
                $(this).css("background-color", "white");
                customdata = InsertServiceUser(iduser, idservice);
                if (customdata != "error" && customdata != "existe") {
                    objetojson = JSON.parse(customdata);
                    identrada = objetojson.id;
                    objeto = $(ui.draggable).clone();
                    objeto.attr("class", "UserInService");
                    objeto.attr("style", "");
                    objeto.appendTo($(this).children("ul"));
                    objeto.append("<input type=\"button\" value=\"X\" onclick=\"deleteuser(" + identrada + ")\"/>");
                } else
                {
                    console.log("no insertado");
                }
            }
        });

    

    $(".DraggableUser").draggable({
        revert: true,
        start: function (ev,ui)
        {
            $(this).css("background-color", "gray");
        },
        stop: function (ev,ui)
        {
            $(this).css("background-color", "white");
        }
    });

    
    function InsertServiceUser(iduser, idservice)
    {
        var MyResult;
        $.ajax(
            {
                url: "/desktopmodules/servicios/WebService.aspx",
                data: { insertuserservicio: 1, userid: iduser, serviceid: idservice },
                method: "GET",
                dataType: "text",
                async: false,
                success: function (data) {
                    if (data != "existe" && data != "error") {
                        console.log("Usuario ya existe en el servicio");
                        MyResult = data;
                    }
                    if (data == "existe") {
                        MyResult = data;
                    }
                    if (data == "error") {

                        console.log("Error al insertar el usuario");
                        MyResult = data;

                    }
                }
            });
        return MyResult;
    }

    function AddService() {
    $.ajax(
        {
            url: "/desktopmodules/servicios/WebService.aspx",
            data: { addservice: 1, name: $("#txtServicio").val() },
            method: "GET",
            dataType: "text",
            success: function (data)
            {
                if (data != "error" ) {
                    addServiceView($("#txtServicio").val(),data);
                    $("#txtServicio").val("");
                    
                } else {
                    alert("Error al guardar el servicio");
                }
            }
            });
    }

    

    function addServiceView(name,id)
    {
        
        $("#ServiceList").append("<li id=\"servicio" + id + "\">" + name + "</li>");
        $("#servicio" + id).hide();
        $("#servicio" + id).show(2000);

    }
</script>