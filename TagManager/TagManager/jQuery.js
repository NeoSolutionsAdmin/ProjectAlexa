


//Abre/cierra los div de creación/eliminación de tags
function AbrirCerrar(orden) {

    console.log(orden);

    if (orden == "crear") {

        if ($('#crearTagDiv').is(':hidden')) {

            $('#crearTagDiv').show('slow');

        }
        else {

            $('#crearTagDiv').hide('slow');

        }

    }
    if (orden == "eliminar") {

        if ($('#eliminarTagDiv').is(':hidden')) {

            $('#eliminarTagDiv').show('slow');

        }
        else {

            $('#eliminarTagDiv').hide('slow');

        }
    }
}


function LogChar(char) {

    console.log(char)


}


//AJAX para recuperar la lista de tags ya creados
//function GetTagsCreados() {
//    $.ajax({
//        url: "/DesktopModules/TransferenciaStock/WebService.aspx",
//        success: function (data)
//        {
//            $('#tablaTagsCreados').empty();
//            $('#tablaTagsCreados').append('')
//            for (a = 0; a < data.length; a++) {
//                $('#tablaTagsCreados').append('<tr></tr>');
//            }
//        },
//        dataType: 'json',
//        data: {
//            tag: $('#buscadorTagsCreados').val()
//        }
//    })
//}


