'use strict';

var idUser = $("#MainContent_hddnIdUsuario").val();
var idRolUser = $("#MainContent_hddnPage").val();
var cveOSd = $("#MainContent_hddnOS").val().trim();
var cveUPd = $("#MainContent_hddnUP").val().trim();
var cveEfiscald = $("#MainContent_hddnEfiscal").val().trim();

const d = new Date();
let startTime = new Date().getTime();
const numberMonth = parseInt(d.getMonth()) + 1;

const s03 = $("#alertSpin");
const divNombreArchivo = $("#divNombreArchivo");
let uploadedBytes = 0;

var selectedUrl = "";

function verificarTexto(input) {
    const val = input.value;
    const espacios = val.match(/\s+/g);
    const signosPuntuacion = val.match(/[.,¿?¡!;:]/g);

    if (espacios !== null) {
        if (espacios.length > 0) {
            showMsg("Favor de evitar espacios en el nombre de la evidencia.", 'error');
            input.value = "";
            return;
        }
    }

    if (signosPuntuacion !== null) {
        if (signosPuntuacion.length > 0) {
            showMsg("Favor de evitar signos de puntuación en el nombre de la evidencia.", 'error');
            input.value = "";
            return;
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var obtenerSelectDatosEfiscal = function () {
    fetchDataArr(0, {}, 11, function (response) {
        if (response) {
            const select = $("#cboEfiscal");
            select.empty();
            select.append($("<option>", { value: "0", text: "SELECCIONE" }));
            response.forEach(function (item) { select.append($("<option>", { value: item.id_efiscal, text: item.efiscal })); });
            select.val(cveEfiscald);
        } else if (response === "error") {
            showMsg("Error al cargar datos", 'error');
        }
    });
}

var obtenerSelectDatosOS = function (txtEfiscal) {
    fetchDataArr(1, { _txtEfiscal: txtEfiscal }, 11, function (response) {
        if (response) {
            const select = $("#cboOs");
            select.empty();
            select.append($("<option>", { value: "0", text: "SELECCIONE" }));
            response.forEach(function (item) { select.append($("<option>", { value: item.Cve_Organo_Superior, text: item.Txt_Organo_Superior })); });
            select.val(cveOSd);
        } else if (response === "error") {
            showMsg("Error al cargar datos", 'error');
        }
    })
}

var obtenerSelectDatosUP = function (txtEfiscal, txtOS, tipo) {
    fetchDataArr(2, { _txtEfiscal: txtEfiscal, _txtOS: txtOS }, 11, function (response) {
        if (response) {
            const select = $("#cboUp");
            select.empty();
            select.append($("<option>", { value: "0", text: "SELECCIONE" }));
            response.forEach(function (item) { select.append($("<option>", { value: item.Cve_Unidad_Presupuestal, text: item.Txt_Unidad_Presupuestal })); });

            if (cveUPd === '') {
                select.val(0);
            } else {
                if (tipo === 'cambio') {
                    if (txtOS === cveOSd) {
                        select.val(cveUPd);
                    } else {
                        select.val(0);

                    }
                } else {
                    select.val(cveUPd);
                }
            }
        } else if (response === "error") {
            showMsg("Error al cargar datos", 'error');
        }
    });
}

var obtenerSelectDatosArchivo = function () {
    fetchDataArr(7, {}, 11, function (response) {
        if (response) {
            const select = $("#cboArchivo");
            const select2 = $("#cboArchivoFilter");
            select.empty();
            select.append($("<option>", { value: "0", text: "SELECCIONE" }));

            select2.empty();
            select2.append($("<option>", { value: "0", text: "TODO" }));

            response.listData.forEach(function (item) {
                select.append($("<option>", { value: item.ID_ARCHIVO, text: item.DESC_ARCHIVO, 'data-ctrl-url': item.URL_RAIZ_CORTA }));
                select2.append($("<option>", { value: item.ID_ARCHIVO, text: item.DESC_ARCHIVO }));
            });
        } else if (response === "error") {
            showMsg("Error al cargar datos", 'error');
        }
    });
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function getArchivero(eFiscal, idArchivo) {
    var html = '';
    blockUICustom();
    fetchDataArr(3, { _eFiscal: eFiscal, _idArchivo: idArchivo }, 11, function (response) {
        if (response) {
            logger.log("%cDatos devueltos sobre archivos", "color: rgba(255, 50, 50, 0.2); font-weight: bold; background: #111; padding: 4px;");
            logger.table(response);
            if (response !== 'error') {
                if (response.length !== 0) {
                    response.forEach(function (item) {
                        var sumHtml = "";
                        var disabledBtn = "";

                        const nDI = new Date(+item.FECHA_INSERTA.replace(/\D/g, '')).toISOString();
                        const nDF = item.FECHA_ACTUALIZA === null ? 'Sin modificaciones' : new Date(+item.FECHA_ACTUALIZA.replace(/\D/g, '')).toISOString();

                        html += `<tr>
                                    <td class='text-1000'>${item.ID_CTRL_ARCHIVO}</td>
                                    <td class='text-1000'>${item.EFISCAL}</td>
                                    <td class='text-1000'>${item.DESC_ARCHIVO}</td>
                                    <td class='text-1000'>
                                        <span class='badge badge-subtle-primary d-block p-2 fs-10-5 m-1'>Inserto: ${nDI}</span>
                                        <span class='badge badge-subtle-primary d-block p-2 fs-10-5 m-1'>Actualizo: ${nDF}</span>
                                    </td>
                                    <td class='text-1000'><span class='badge bg-indigo d-block p-2 fs-10-5 m-1'>${item.NOMBRE_ARCHIVO}</span></td>
                                    <td class='text-end'>
                                        <div>
                                            <button class='btn btn-sm btn-falcon-primary btnDownloadDoc customButton m-1 ${disabledBtn}' type='button' 
                                                data-ctrl-archivero='${item.ID_CTRL_ARCHIVO}'>Ver / descargar archivo</button>
                                        </div>
                                    </td>
                                </tr>`
                    });
                    recargarTabla("tableArchivero", html);
                } else {
                    recargarTabla("tableArchivero", null);
                    showMsg("Registre al menos un archivo.", 'info');
                }
            } else {
                showMsg("Ocurrio un error al mostrar resultados.", 'error');
            }
        } else if (response === "error") {
            showMsg("Error al cargar datos", 'error');
        }
        Swal.close();
    });
}

function seeHistorico(eFiscal) {
    var html = '';
    blockUICustom();
    fetchDataArr(5, { _eFiscal: eFiscal }, 11, function (response) {
        if (response) {
            logger.log("%cDatos sobre el Historico", "color: rgba(255, 50, 50, 0.2); font-weight: bold; background: #111; padding: 4px;");
            logger.table(response);
            if (response !== 'error') {
                if (response.length !== 0) {
                    response.forEach(function (item) {
                        var sumHtml = "";
                        var iconSet = "";
                        var timeLine = "";

                        const nDI = new Date(+item.FECHA.replace(/\D/g, '')).toISOString();

                        iconSet += item.ACCION === 'Insertó' ? 'far fa-folder-open' : 'fas fa-file-signature';

                        if (item.row_index === 1) {
                            timeLine = `timeline-warning timeline-current`;
                        } else {
                            timeLine = `timeline-secondary timeline-past`;
                        }

                        html += `<div class='row g-3 timeline ${timeLine} pb-x1'>
                                    <div class='col-auto ps-4 ms-2'>
                                        <div class='ps-2'>
                                            <div class='icon-item icon-item-sm rounded-circle bg-200 shadow-none'><span class='text-primary fa ${iconSet}'></span></div>
                                        </div>
                                    </div>
                                    <div class='col'>
                                        <div class='row gx-0 border-bottom pb-x1'>
                                            <div class='col'>
                                                <h6 class='text-800 mb-1'>${item.NOMBRE} ${item.ACCION} un archivo</h6>
                                                <p class='fs-11 text-600 mb-0'>${item.NOMBRE_ARCHIVO}</p>
                                            </div>
                                            <div class='col-auto'>
                                                <p class='fs-11 text-500 mb-0'>${nDI}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>`
                    });
                    $("#innerHistorico").html(html);
                } else {
                    html += `<div class='row g-3 timeline timeline-secondary timeline-past pb-x1'>
                                    <div class='col-auto ps-4 ms-2'>
                                        <div class='ps-2'>
                                            <div class='icon-item icon-item-sm rounded-circle bg-200 shadow-none'><span class='text-primary fa fa-xmark'></span></div>
                                        </div>
                                    </div>
                                    <div class='col'>
                                        <div class='row gx-0 border-bottom pb-x1'>
                                            <div class='col'>
                                                <h6 class='text-800 mb-1'>Sin archivos registrados</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>`
                    $("#innerHistorico").html(html);
                }
            } else {
                showMsg("Ocurrio un error al mostrar resultados.", 'error');
            }
        } else if (response === "error") {
            showMsg("Error al cargar datos", 'error');
        }
        Swal.close();
    });
}

function gDeById(idArc) {
    blockUICustom({
        title: 'Descargando archivo',
        html: '<div class="text-center"><div class="spinner-border text-primary" role="status"></div><div class="mt-2">Por favor espere...</div></div>'
    });
    fetchDataArr(6, { _idCtrlArchivo: idArc }, 11, function (response) {
        if (response) {
            logger.log(`%cDatos recibidos de Descarga de Evidencias ${response}`, "color: rgba(255, 50, 50, 0.2); font-weight: bold; background: #111; padding: 4px;");
            var responseS = response.split("|");
            if (responseS[1] === '1') {
                showMsg('Respuesta del servidor: ' + responseS[0] + '', 'success');
                mostrarFichero(responseS[2]);
            } else if (responseS[1] === '2') {
                showMsg('No existe el archivo.', 'error');
            } else {
                showMsg('Respuesta del servidor: ' + responseS[0] + '', 'error');
            }
            Swal.close();
        } else if (response === "error") {
            showMsg("Error al cargar datos", 'error');
        }
    });
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// PENDIENTE DE REVISAR ENVIO DE DE ARCHIVOS AL SERVIDOR 3. NO SE ENLAZAN PARTES
async function uploadFileInChunks(file, idUsuario, txtDesc, idDocumento, fileExt, txtUrl, confirmNewName, txtNewName, eFiscal) {
    blockUICustom({
        title: 'Guardando documento...',
        html: '<div class="text-center"><div class="spinner-border text-primary" role="status"></div><div class="mt-2">Por favor espere...<progress id="progressBar" value="0" max="100"></progress><span id="progressText"></span><span id="timeRemaining"></span></div></div>',
        allowOutsideClick: false,
        // didOpen: () => {
        //     window.progressBar = document.getElementById("progressBar");
        //     window.progressText = document.getElementById("progressText");
        //     window.timeRemaining = document.getElementById("timeRemaining");
        // }
    });
    const CHUNK_SIZE = 2 * 1024 * 1024; // 2MB
    const MAX_SIZE = 100 * 1024 * 1024; // 2MB
    const totalChunks = Math.ceil(file.size / CHUNK_SIZE);
    const uploadId = crypto.randomUUID();

    logger.log("Subiendo:", file.name);
    logger.log("Tamaño:", file.size);
    logger.log("Chunks:", totalChunks);

    if (file && file.size > MAX_SIZE) {
        showMsg("El archivo es demasiado grande. Máximo 100MB.", 'error');
        Swal.close();
        $("#btnS_Archivo").removeAttr("disabled");
        return;
    }

    for (let chunkIndex = 0; chunkIndex < totalChunks; chunkIndex++) {
        const start = chunkIndex * CHUNK_SIZE;
        const end = Math.min(start + CHUNK_SIZE, file.size);
        const chunk = file.slice(start, end);

        const formData = new FormData();
        formData.append("file", chunk);
        formData.append("uploadId", uploadId);
        formData.append("chunkIndex", chunkIndex);
        formData.append("totalChunks", totalChunks);
        formData.append("fileName", file.name);
        formData.append("toServer", 3);

        formData.append("_idUsuario", idUsuario);
        formData.append("_txtDesc", txtDesc);
        formData.append("_idDocumento", idDocumento);
        formData.append("_fileExt", fileExt);
        formData.append("_txtUrl", txtUrl);
        formData.append("_confirmNewName", confirmNewName);
        formData.append("_txtNewName", txtNewName);
        formData.append("_eFiscal", eFiscal);
        await sendChunk(formData,
            function (response) {
                logger.error("RESPUESTA DEVUELTA A SERVIDOR LINEA 3: ", response);
                let objetoJS = JSON.parse(response);
                logger.error("DESPUES DE PARSE JSON: ", objetoJS);
                if (objetoJS.ok) {
                    showMsg(objetoJS.msg, 'success');
                    getArchivero(eFiscal, idDocumento);
                    seeHistorico(eFiscal);
                    clearForms(1);
                    Swal.close();
                } else {
                    if (objetoJS.msg === "Procesando") {
                    } else {
                        showMsg(objetoJS.msg, 'error');
                        Swal.close();
                    }
                }
            }
        );
        // await uploadChunkWithProgress(formData, function (progress) { },
        //     function (response) {
        //         logger.log("Carga completa", response);
        //         Swal.close();
        //         showMsg("El archivo fue ingresado correctamente.", 'info');
        //         getArchivero(eFiscal, idDocumento);
        //         seeHistorico(eFiscal);
        //         clearForms(1);
        //         $("#modalArchiveroForm").modal("hide");
        //         $("#btnS_Archivo").removeAttr("disabled");
        //     }
        // );
    }
}

function formatTime(seconds) {
    seconds = Math.round(seconds);

    if (seconds < 60) return `${seconds} seg`;
    if (seconds < 3600) return `${Math.floor(seconds / 60)} min ${seconds % 60} seg`;

    return `${Math.floor(seconds / 3600)} h ${Math.floor((seconds % 3600) / 60)} min`;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function () {
    s03.hide();
    autoValidateContainer("#formArchiveroForm");
    loadEndpoints(11);
    obtenerSelectDatosEfiscal();
    obtenerSelectDatosOS(cveEfiscald);
    obtenerSelectDatosUP(cveEfiscald, cveOSd, '')
    obtenerSelectDatosArchivo();
    if (idRolUser === '101') {
        logger.log("Usuario Isra");
        getArchivero(cveEfiscald, 0);
        seeHistorico(cveEfiscald);
    } else if (idRolUser === '102') {
        logger.log("Usuario Leo");
    } else if (idRolUser === '103') {
        logger.log("Usuario Esther");
        $("#btnGroupVerticalDrop1").hide();
    }

    $(document).on("change", "#cboEfiscal, #cboArchivoFilter", async function () {
        var cboArchivo = $("#cboArchivoFilter").val();
        var eFiscal = $("#cboEfiscal").val();
        if (idRolUser === '101') {
            if (await verifyInitialDataE(eFiscal)) {
                getArchivero(eFiscal, cboArchivo);
                seeHistorico(eFiscal);
            }
        } else if (idRolUser === '102') {

        } else if (idRolUser === '103') {

        }
    });

    $(document).on("click", "#btnSearch", async function () {
        var cboArchivo = $("#cboArchivoFilter").val();
        var eFiscal = $("#cboEfiscal").val();
        if (idRolUser === '101') {
            if (await verifyInitialDataE(eFiscal)) {
                getArchivero(eFiscal, cboArchivo);
                seeHistorico(eFiscal);
            }
        } else if (idRolUser === '102') {

        } else if (idRolUser === '103') {

        }
    });

    $(document).on("click", "#btnN_Archivo", async function () {
        // const confirmado = await alertConfirmMessage("¿Deseas crear un nuevo archivo?");
        // logger.warn(confirmado)
        // if (!confirmado) { return }
        var eFiscal = $("#cboEfiscal").val();
        if (await verifyInitialDataE(eFiscal)) {
            $("#cboArchivo").val(0);
            $("#setLinked").hide();
            divNombreArchivo.hide();
            $("#modalArchiveroForm").modal("show");
        }
    });

    $(document).on("click", "#btnS_Archivo", async function () {
        const confirmado = await alertConfirmMessage("¿Esta seguro de guardar el archivo?");
        if (!confirmado) { return }
        const $btn = $("#btnS_Archivo");
        $btn.prop("disabled", true);
        try {
            const cveEfiscal = $("#cboEfiscal").val();
            const okInitial = await verifyInitialDataE(cveEfiscal);
            if (!okInitial) return;
            if (!validarFormularioEvidencia()) return;
            const file = $("#customFile")[0].files[0];
            if (!file) {
                showMsg("No ha insertado ningún archivo, favor de ingresarlo.", "error");
                return;
            }
            const data = {
                txtDesc: $("#txtDesc").val().trim(),
                cboArchivo: $("#cboArchivo").val(),
                txtUrlConfirm: $("#setLinked").text(),
                confirmNewName: $("#forCheckName").is(":checked") ? 1 : 0,
                txtNombreCustom: $("#forCheckName").is(":checked") ? $("#txtNombreCustom").val().trim() : "",
                cveEfiscal,
                ext: getFileExtension(file.name)
            };
            uploadFileInChunks(file, idUser, data.txtDesc, data.cboArchivo, data.ext, data.txtUrlConfirm, data.confirmNewName, data.txtNombreCustom, data.cveEfiscal);
        } catch (err) {
            logger.error(err);
            showMsg("Ocurrió un error inesperado.", "error");
        } finally {
            // 🔥 SIEMPRE se ejecuta
            $btn.prop("disabled", false);
        }
    });


    $(document).on("click", ".btnDownloadDoc", function () {
        var idReturn = $(this)[0].dataset.ctrlArchivero;
        gDeById(idReturn);
    });

    $(document).on("change", "#cboArchivo", function () {
        var selectedValue = $(this).val();
        var cveEfiscal = $("#cboEfiscal").val();
        if (selectedValue !== '0') {
            selectedUrl = $(this)[0][selectedValue].dataset.ctrlUrl + cveEfiscal + "/";
            $("#setLinked").html('Ruta de almacenamiento: <strong>' + selectedUrl + '</strong>').show();
        } else {
            selectedUrl = "";
            $("#setLinked").hide();
        }
    });

    $(document).on("change", "#customFile", function () {
        let file = $(this)[0].files[0];
        if (file !== undefined) {
            $("#setLinked").html('Ruta de almacenamiento: <strong>' + selectedUrl + file.name + '</strong>').show();
        } else {
            if (selectedUrl === "") {
                $("#setLinked").hide();
            } else {
                $("#setLinked").html('Ruta de almacenamiento: <strong>' + selectedUrl + '</strong>').show();
            }
        }
    });

    $(document).on("change", "#forCheckName", function () {
        if ($(this).is(':checked')) {
            divNombreArchivo.show();
        } else {
            divNombreArchivo.hide();
        }
    });
});

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function validarFormularioEvidencia() {
    const $container = $("#formArchiveroForm");
    const invalid = $container
        .find("[data-required], [data-required-if]")
        .filter(function () {
            const $el = $(this);
            const value = ($el.val() ?? "").toString().trim();
            const required = $el.data("required");
            const requiredIf = $el.data("required-if");
            if (required && (!value || value === "0")) {
                return true;
            }
            if (requiredIf) {
                const isChecked = $(requiredIf).is(":checked");
                if (isChecked && !value) {
                    return true;
                }
                if (!isChecked) {
                    $el.val("");
                    return false;
                }
            }
            return false;
        })
        .first();

    if (invalid.length) {
        showMsgForm(
            invalid.attr("id"),
            invalid.data("msg") || "Campo inválido",
            "error"
        );
        return false;
    }

    return true;
}


function clearForms(type) {
    if (type === 1) {
        $("#txtDesc").val('');
        $("#txtNombreCustom").val('');
        $("#customFile").val('');
        $("#cboArchivo").val(0);
        $('#forCheckName').prop('checked', false);
    } else if (type === 2) {
    } else if (type === 3) {
    } else if (type === 4) {
    } else if (type === 5) {
    } else if (type === 6) {
    }
}
