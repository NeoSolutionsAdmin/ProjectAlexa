


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
    if (orden == "admin") {

        if ($('#adminTagDiv').is(':hidden')) {

            $('#adminTagDiv').show('slow');

        }
        else {

            $('#adminTagDiv').hide('slow');

        }
    }
    if (orden == "listaTags") {

        if ($('#TagContainerDiv').is(':hidden')) {

            $('#TagContainerDiv').show('slow');

        }
        else {

            $('#TagContainerDiv').hide('slow');

        }
    }
}


function LogChar(char) {

    console.log(char)

}




////AJAX para recuperar la lista de tags ya creados
//function GetTagsCreados() {
//    $.ajax({
//        url: "/DesktopModules/TransferenciaStock/WebService.aspx",
//        success: function (data)
//        {
//            $('#tablaTagsCreados').empty();
//            $('#tablaTagsCreados').append('')
//            for (a = 0; a < data.length; a++) {
//                $('#tablaTagsCreados').append('<tr><td>' + data.NOMBRE + '</td><td>' + data.ICONO + '</td></tr>');
//            }
//        },
//        dataType: 'json',
//        data: {
//            tag: SearchTag(),
//        }
//    })
//}
//function SearchTag() {

//    var searchString = '%';

//    if ($('#buscadorTagsCreados').val() == "") {

//        searchString = '%';
//    }
//    else {

//        searchString = $('#buscadorTagsCreados').val();

//    }
//    return searchString;
//}


