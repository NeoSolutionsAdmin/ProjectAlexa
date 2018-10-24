r<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InformeGuardia.aspx.cs" Inherits="Christoc.Modules.HistoriaClinica.Reports.InformeGuardia" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
     <meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager runat="server" ID="MyScriptManager"></asp:ScriptManager>
            
       <rsweb:ReportViewer runat="server" Id="RV" Width="100%" Height="100%" AsyncRendering="true"></rsweb:ReportViewer>
        </div>
    </form>
</body>
</html>
