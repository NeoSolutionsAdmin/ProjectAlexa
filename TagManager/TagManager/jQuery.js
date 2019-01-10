


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


