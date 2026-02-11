<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="WebFrmPTAR001.aspx.vb" Inherits="PTAR.WebFrmPTAR001" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .customButton {
            --falcon-btn-padding-y: .1rem !important;
            --falcon-btn-padding-x: .4rem !important;
            --falcon-btn-font-size: .8rem !important;
        }

        .customKanbanColumn {
            display: inline-block !important;
            width: 15rem;
            white-space: normal;
            vertical-align: top;
        }

        .customKanbanColumnForTable {
            display: inline-block !important;
            width: 30rem;
            white-space: normal;
            vertical-align: top;
        }

        #divChartMapaF, #divChartMapaI {
            width: 100% !important;
            height: 500px !important;
        }

        /* Responsive para los contenedores */
        /* Extra small devices (phones, 576px and down) */
        @media (max-width: 576px) {
            #divChartMapaF, #divChartMapaI {
                height: 300px !important;
            }
        }

        /* Small devices (phones landscape, 576px and up) */
        @media (min-width: 576px) and (max-width: 767.98px) {
            #divChartMapaF, #divChartMapaI {
                height: 400px !important;
            }
        }

        /* Medium devices (tablets, 768px and up) */
        @media (min-width: 768px) and (max-width: 991.98px) {
            #divChartMapaF, #divChartMapaI {
                height: 450px !important;
            }
        }

        /* Large devices (desktops, 992px and up) */
        @media (min-width: 992px) and (max-width: 1199.98px) {
            #divChartMapaF, #divChartMapaI {
                height: 500px !important;
            }
        }

        /* Extra large devices (large desktops, 1200px and up) */
        @media (min-width: 1200px) and (max-width: 1399.98px) {
            #divChartMapaF, #divChartMapaI {
                height: 550px !important;
            }
        }

        /* Extra extra large devices (1440px and up) */
        @media (min-width: 1400px) and (max-width: 1599.98px) {
            #divChartMapaF, #divChartMapaI {
                height: 600px !important;
            }
        }

        /* Para MacBook Pro y pantallas grandes (1600px and up) */
        @media (min-width: 1600px) and (max-width: 1919.98px) {
            #divChartMapaF, #divChartMapaI {
                height: 650px !important;
            }
        }

        /* Para pantallas muy grandes (1920px and up) - Full HD */
        @media (min-width: 1920px) {
            #divChartMapaF, #divChartMapaI {
                height: 700px !important;
            }
        }
    </style>
    <style>
        /*body {
            font-family: Arial, sans-serif;
            color: #fff;*/
        /*background-color: #1C1F2B;*/
        /*padding: 0;
            margin: 0;
        }*/

        *, *:after, *:before {
            box-sizing: border-box;
        }

        .card-list {
            height: 70vh;
            display: flex;
            margin: 0;
            padding: 0;
        }

            .card-list input {
                position: absolute;
                top: 0;
                left: 0;
                height: 0;
                width: 0;
                opacity: 0;
            }

            .card-list label {
                display: block;
                float: left;
                height: 70vh;
                width: 40px;
                min-width: 40px;
                overflow: hidden;
                background: #808080;
                text-align: center;
                font-size: 14px;
                line-height: 50px;
                transition: background 300ms ease;
                color: #fff;
            }

                .card-list label:nth-child(odd) {
                    background: #b4b4b4;
                }

                .card-list label:hover,
                .card-list input:checked + label {
                    background: #5f2132;
                    /*color: #fff;*/
                    cursor: pointer;
                }

                .card-list label span {
                    padding-left: 7px;
                    font-size: 1.2em;
                    white-space: nowrap;
                    display: block;
                    -webkit-transform: rotate(90deg);
                    transform: rotate(90deg);
                }

            .card-list .card-content {
                display: block;
                height: 100%;
                width: 0px;
                overflow-x: hidden;
                line-height: 1.5;
                transition: all 700ms ease;
            }

            .card-list input:checked + label + .card-content {
                width: calc(100% - 40px);
            }

            .card-list .content-inner {
                padding: 20px;
            }
    </style>

    <div class="row gx-0 kanban-header rounded-2 px-x1 py-2 mt-2 mb-3">
        <div class="col d-flex align-items-center">
            <select id="cboEfiscal" class="form-control form-control-sm"></select>
            <div class="vertical-line vertical-line-400 position-relative h-100 mx-3"></div>
            <select id="cboOs" class="form-control form-control-sm"></select>
            <div class="vertical-line vertical-line-400 position-relative h-100 mx-3"></div>
            <select id="cboUp" class="form-control form-control-sm"></select>
            <div class="vertical-line vertical-line-400 position-relative h-100 mx-3"></div>
        </div>
        <div class="col-auto d-flex align-items-center">
            <button class="btn btn-sm btn-falcon-default customButton me-2" id="btnSearch" type="button"><span class="fas fa-search me-2" data-fa-transform="shrink-3"></span>Buscar</button>
            <div class="" role="group">
                <button class="btn btn-falcon-danger btn-sm customButton" type="button" id="btnN_Alineacion2">
                    <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Nueva alineación
                </button>
                <button class="btn btn-falcon-default dropdown-toggle customButton" id="btnGroupVerticalDrop1" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Generar reportes
                </button>
                <div class="dropdown-menu" aria-labelledby="btnGroupVerticalDrop1">
                    <button class="dropdown-item" type="button" id="btnGetMatriz">
                        <span class="fas fa-file-pdf me-2" data-fa-transform="shrink-3"></span>Generar matriz
                    </button>
                    <button class="dropdown-item" type="button" id="btnGetPtar">
                        <span class="fas fa-file-pdf me-2" data-fa-transform="shrink-3"></span>Generar PTAR
                    </button>
                    <button class="dropdown-item" type="button" id="btnGetMapa">
                        <span class="fas fa-file-pdf me-2" data-fa-transform="shrink-3"></span>Generar mapa
                    </button>
                    <button class="dropdown-item" type="button" id="btnGetConcentrado">
                        <span class="fas fa-file-pdf me-2" data-fa-transform="shrink-3"></span>Generar concentrado
                    </button>
                </div>
                <button class="btn btn-falcon-warning btn-sm customButton" type="button" id="btnSendToValidate"
                    data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Envie su información a validación">
                    <span class="fas fa-send me-2" data-fa-transform="shrink-3"></span>Enviar riesgos
                </button>
            </div>
        </div>
    </div>

    <div class="row flex-center g-3">
        <div class="col-sm-12 col-md-12 col-lg-7 col-xxl-7" id="x">
            <div class="card mb-3">
                <div class="card-header">
                    <h6>Resumen de riesgos</h6>
                </div>
                <div class="card-body position-relative">
                    <div class="table-responsive scrollbar">
                        <table class="text-black table table-striped table-sm table-hover fs-10 dataTable overflow-hidden" id="tableRiesgosXAlineacion">
                            <thead>
                                <tr>
                                    <th scope="col">No. Riesgo</th>
                                    <th scope="col">Descripción de alineación</th>
                                    <th scope="col">Descripción de proceso</th>
                                    <th scope="col">Valoración inicial</th>
                                    <th scope="col">Valoración final</th>
                                    <th scope="col">Estados</th>
                                    <th class="text-end" scope="col">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-12 col-md-12 col-lg-5 col-xxl-5">
            <div class="row g-0">
                <div class="col-md-6 mb-1">
                    <div class="card">
                        <div class="card-body">
                            <div class="row g-0 d-flex align-items-center px-0">
                                <div class="col-2">
                                    <div class="mt-1 text-warning-emphasis fa-solid fa-2xl fa-warning fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" alt="" width="100"></div>
                                </div>
                                <div class="col-3">
                                    <h2 class="mt-2 mb-1 text-700 fw-bolder ms-3" id="cRd">0</h2>
                                </div>
                                <div class="col-7">
                                    <h4 class="mb-0 mt-1">Riesgos</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-1">
                    <div class="card">
                        <div class="card-body">
                            <div class="row g-0 d-flex align-items-center px-0">
                                <div class="col-2">
                                    <div class="mt-1 text-danger-emphasis fa-solid fa-2xl fa-explosion fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" alt="" width="100"></div>
                                </div>
                                <div class="col-3">
                                    <h2 class="mt-2 mb-1 text-700 fw-bolder ms-3" id="cFd">0</h2>
                                </div>
                                <div class="col-7">
                                    <h4 class="mb-0 mt-1">Factores</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-1">
                    <div class="card">
                        <div class="card-body">
                            <div class="row g-0 d-flex align-items-center px-0">
                                <div class="col-2">
                                    <div class="mt-1 text-secondary-emphasis fa-solid fa-2xl fa-gears fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" alt="" width="100"></div>
                                </div>
                                <div class="col-3">
                                    <h2 class="mt-2 mb-1 text-700 fw-bolder ms-3" id="cCd">0</h2>
                                </div>
                                <div class="col-7 m-0">
                                    <h4 class="mb-0 mt-1">Controles</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-1">
                    <div class="card">
                        <div class="card-body">
                            <div class="row g-0 d-flex align-items-center px-0">
                                <div class="col-2">
                                    <div class="mt-1 text-success-emphasis fa-solid fa-2xl fa-layer-group fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" alt="" width="100"></div>
                                </div>
                                <div class="col-3">
                                    <h2 class="mt-2 mb-1 text-700 fw-bolder ms-3" id="cAd">0</h2>
                                </div>
                                <div class="col-7">
                                    <h4 class="mb-0 mt-1">Acciones</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-1">
                    <div class="card">
                        <div class="card-body">
                            <div class="row g-0 d-flex align-items-center px-0">
                                <div class="col-2">
                                    <div class="mt-1 text-info-emphasis fa-solid fa-2xl fa-clipboard fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" alt="" width="100"></div>
                                </div>
                                <div class="col-3">
                                    <h2 class="mt-2 mb-1 text-700 fw-bolder ms-3" id="cAcd">0</h2>
                                </div>
                                <div class="col-7">
                                    <h4 class="mb-0 mt-1">Actividades</h4>
                                </div>
                            </div>
                            <div class="row g-0 d-flex align-items-center px-0">
                                <div class="col-2"></div>
                                <div class="col-3">
                                    <h4 class="mt-2 mb-1 text-700 fw-bolder ms-3" id="cEd">0</h4>
                                </div>
                                <div class="col-7">
                                    <h5 class="mb-0 mt-1">Evidencias</h5>
                                </div>
                            </div>
                            <div class="row g-0 d-flex align-items-center px-0">
                                <div class="col-2"></div>
                                <div class="col-3">
                                    <h4 class="mt-2 mb-1 text-700 fw-bolder ms-3" id="cARd">0</h4>
                                </div>
                                <div class="col-7">
                                    <h5 class="mb-0 mt-1">Actividades reportadas</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid mb-3">
        <div class="card-list">
            <input type="radio" name="card" id="check1">
            <label for="check1"><span>Alineación</span></label>
            <div class="card-content">
                <div class="content-inner">
                    <div class="row flex-between-center">
                        <div class="col-3 col-sm-auto d-flex align-items-center pe-0">
                            <h2 class="mb-0 text-nowrap py-2 py-xl-0">Alineación </h2>
                        </div>
                        <div class="col-3 col-sm-auto ms-auto text-end ps-0">
                            <button class="btn btn-falcon-default btn-sm" type="button" id="btnN_Alineacion">
                                <span class="fas fa-plus" data-fa-transform="shrink-3 down-1"></span>
                                <span class="d-none d-sm-inline-block ms-1">Agregar nueva alineación</span>
                            </button>
                        </div>
                    </div>
                    <div id="containerDataAlineacion"></div>
                </div>
            </div>
            <input type="radio" name="card" id="check2">
            <label for="check2"><span>Riesgo</span></label>
            <div class="card-content">
                <div class="content-inner">
                    <div class="row flex-between-center">
                        <div class="col-3 col-sm-auto d-flex align-items-center pe-0">
                            <h2 class="mb-0 text-nowrap py-2 py-xl-0">Riesgo </h2>
                        </div>
                        <div class="col-3 col-sm-auto ms-auto text-end ps-0">
                            <button class="btn btn-falcon-default btn-sm" type="button" id="btnN_Riesgo">
                                <span class="fas fa-plus" data-fa-transform="shrink-3 down-1"></span>
                                <span class="d-none d-sm-inline-block ms-1">Agregar nuevo riesgo</span>
                            </button>
                        </div>
                    </div>
                    <div id="containerDataRiesgo_x_Alineacion"></div>
                    <div id="containerDataRiesgo"></div>
                </div>
            </div>
            <input type="radio" name="card" id="check3">
            <label for="check3"><span>Factores</span></label>
            <div class="card-content">
                <div class="content-inner">
                    <div class="row flex-between-center">
                        <div class="col-3 col-sm-auto d-flex align-items-center pe-0">
                            <h2 class="mb-0 text-nowrap py-2 py-xl-0">Factor </h2>
                        </div>
                        <div class="col-auto col-sm-auto ms-auto text-end ps-0">
                            <button class="btn btn-falcon-default btn-sm" type="button" id="btnN_Factor">
                                <span class="fas fa-plus" data-fa-transform="shrink-3 down-1"></span>
                                <span class="d-none d-sm-inline-block ms-1">Agregar nuevo factor</span>
                            </button>
                            <button class="btn btn-falcon-default btn-sm" type="button" id="btnE_ValorInicial">
                                <span class="fas fa-plus" data-fa-transform="shrink-3 down-1"></span>
                                <span class="d-none d-sm-inline-block ms-1">Insertar valor inicial</span>
                            </button>
                        </div>
                    </div>
                    <div id="containerDataFactor_x_Riesgo"></div>
                    <div id="containerDataFactor"></div>
                </div>
            </div>
            <input type="radio" name="card" id="check4">
            <label for="check4"><span>Control</span></label>
            <div class="card-content">
                <div class="content-inner">
                    <div class="row flex-between-center">
                        <div class="col-3 col-sm-auto d-flex align-items-center pe-0">
                            <h2 class="mb-0 text-nowrap py-2 py-xl-0">Control </h2>
                        </div>
                        <div class="col-auto col-sm-auto ms-auto text-end ps-0">
                            <button class="btn btn-falcon-default btn-sm" type="button" id="btnN_Control">
                                <span class="fas fa-plus" data-fa-transform="shrink-3 down-1"></span>
                                <span class="d-none d-sm-inline-block ms-1">Agregar nuevo control</span>
                            </button>
                            <button class="btn btn-falcon-danger btn-sm" type="button" id="btnU_Control">
                                <span class="d-none d-sm-inline-block ms-1">¿Riesgo controlado?</span>
                            </button>
                            <button class="btn btn-falcon-default btn-sm" type="button" id="btnE_ValorFinal">
                                <span class="fas fa-plus" data-fa-transform="shrink-3 down-1"></span>
                                <span class="d-none d-sm-inline-block ms-1">Insertar valor final</span>
                            </button>
                        </div>
                    </div>
                    <div id="containerDataControl_x_Factor"></div>
                    <div id="containerDataControl"></div>
                </div>
            </div>
            <input type="radio" name="card" id="check5">
            <label for="check5"><span>Acción</span></label>
            <div class="card-content">
                <div class="content-inner">
                    <div class="row flex-between-center">
                        <div class="col-3 col-sm-auto d-flex align-items-center pe-0">
                            <h2 class="mb-0 text-nowrap py-2 py-xl-0">Acción </h2>
                        </div>
                        <div class="col-auto col-sm-auto ms-auto text-end ps-0">
                            <button class="btn btn-falcon-default btn-sm" type="button" id="btnN_Accion">
                                <span class="fas fa-plus" data-fa-transform="shrink-3 down-1"></span>
                                <span class="d-none d-sm-inline-block ms-1">Agregar nueva acción</span>
                            </button>
                        </div>
                    </div>
                    <div id="containerDataAccion_x_Control"></div>
                    <div id="containerDataAccion"></div>
                </div>
            </div>
            <input type="radio" name="card" id="check6">
            <label for="check6"><span>Actividad</span></label>
            <div class="card-content">
                <div class="content-inner">
                    <div class="row flex-between-center">
                        <div class="col-3 col-sm-auto d-flex align-items-center pe-0">
                            <h2 class="mb-0 text-nowrap py-2 py-xl-0">Actividad </h2>
                        </div>
                        <div class="col-auto col-sm-auto ms-auto text-end ps-0">
                            <button class="btn btn-falcon-default btn-sm" type="button" id="btnN_Actividad">
                                <span class="fas fa-plus" data-fa-transform="shrink-3 down-1"></span>
                                <span class="d-none d-sm-inline-block ms-1">Agregar nueva(s) actividad(es)</span>
                            </button>
                        </div>
                    </div>
                    <div id="containerDataActividad_x_Accion"></div>
                    <div id="containerDataActividad"></div>
                    <div class="mt-3">
                        <div class='card sortable-item kanban-item-card hover-actions-trigger'>
                            <div class='card-body'>
                                <div class="mb-2">
                                    <span class="badge rounded-pill badge-subtle-success fs-10">Meta anual programada: <span id="metaAnualProgramada"></span></span>
                                    <span class="badge rounded-pill badge-subtle-warning fs-10">Meta anual alcanzada: <span id="metaAnualAlcanzada"></span></span>
                                </div>
                            </div>
                        </div>

                        <div class='card sortable-item kanban-item-card hover-actions-trigger'>
                            <div class='card-body'>
                                <div class='position-relative'>
                                    <div class="table-responsive scrollbar">
                                        <table class="table table-hover table-striped overflow-hidden table-sm fs-10 dataTable" id="containerDataActividad_x_Trimestre">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Trimestre</th>
                                                    <th scope="col">No. de actividades</th>
                                                    <th scope="col">Sumatoria de meta programada</th>
                                                    <th scope="col">Sumatoria de meta alcanzada</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <%-- flex-center py-1 --%>
    <div class="row flex-center" runat="server" id="divRegistroDatos" style="align-items: normal !important;">
        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-11 col-xxl-10">
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 col-xxl-6" id="divValoresInicial">
                    <div class="row">
                        <div class="col-12">
                            <div class="card mb-3">
                                <div class="card-header">
                                    <h6>Mapa de riesgos (valor inicial)</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="chart-container" id="matriz-riesgo-container">
                                                <div id="divChartMapaI"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 col-xxl-6" id="divValoresFinales">
                    <div class="row">
                        <div class="col-12">
                            <div class="card mb-3">
                                <div class="card-header">
                                    <h6>Mapa de riesgos (valor final)</h6>
                                </div>
                                <div class="card-body position-relative">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="chart-container" id="matriz-riesgo2-container">
                                            <div id="divChartMapaF""></div>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hddnIdUsuario" runat="server" />
    <asp:HiddenField ID="hddnPage" runat="server" />
    <asp:HiddenField ID="hddnOS" runat="server" />
    <asp:HiddenField ID="hddnUP" runat="server" />
    <asp:HiddenField ID="hddnEfiscal" runat="server" />

    <div class="modal fade" id="modalAlineacionForm" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Formulario de alineación
                    </h5>
                    <%--<button type="button" class="btn btn-sm btn-circle btn-close transition-base" id="backSeeMisDocumentos" style="--falcon-btn-close-bg: url() !important;">
                    <span aria-hidden="true"><span class="fas fa-arrow-left"></span></span>
                </button>--%>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-3">
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12">
                                <div class="row g-3">
                                    <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative mb-1">
                                        <label class="form-label" for="exampleFormControlInput1">Número de riesgo</label>
                                        <input class="form-control form-control-sm" id="txtNoFolio" type="text" placeholder="0" disabled="" />
                                    </div>
                                    <div class="col-sm-12 col-md-12 col-lg-8 col-xxl-8 position-relative">
                                        <label class="form-label">Alineación</label>
                                        <select id="cboAlineacion" class="form-control form-control-sm"></select>
                                    </div>
                                    <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                        <label class="form-label">Descripción de la alineacion</label>
                                        <textarea class="form-control form-control-sm" id="txtAlineacion" rows="3"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_Alineacion">
                                <span class="far fa-save me-2" data-fa-transform="shrink-3"></span>Guardar alineacion
                            </button>
                            <button class="btn btn-falcon-danger btn-sm customButton" type="button" id="btnCancel_Alineacion">
                                <span class="fas fa-times-circle me-2" data-fa-transform="shrink-3"></span>Cerrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalRiesgoForm" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Formulario de riesgo
                    </h5>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">

                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <label class="form-label">Descripción del riesgo</label>
                                <textarea class="form-control form-control-sm" id="txtRiesgo" rows="3"></textarea>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <label class="form-label">Proceso</label>
                                <select id="cboProceso" class="form-control form-control-sm"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label">Nivel de riesgo</label>
                                <select id="cboNivelRiesgo" class="form-control form-control-sm"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label">Clasificación de riesgo</label>
                                <select id="cboClasRiesgo" class="form-control form-control-sm"></select>
                            </div>

                            <div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">Organo superior responsable</label>
                                <input class="form-control form-control-sm" id="txtOSProceso" type="text" placeholder="0" disabled="disabled" />
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">Unidad presupuestal responsable</label>
                                <input class="form-control form-control-sm" id="txtUPProceso" type="text" placeholder="0" disabled="disabled" />
                            </div>


                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_Riesgo">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Guardar riesgo
                            </button>
                            <button class="btn btn-falcon-danger btn-sm customButton" type="button" id="btnCancel_Riesgo">
                                <span class="fas fa-times-circle me-2" data-fa-transform="shrink-3"></span>Cerrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalFactorForm" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Formulario de factor
                    </h5>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <%--<div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <div class="fs-9">
                                    <a class="notification text-bg-dark border h-100 border-light" href="#">
                                        <div class="">
                                            <div id="divTxtRiesgo"></div>
                                        </div>
                                    </a>
                                </div>
                            </div>--%>
                            <div class="col-sm-12 col-md-12 col-lg-3 col-xxl-3 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">No. de Factor</label>
                                <input class="form-control form-control-sm" id="txtFolioFactor" type="text" placeholder="X.X" disabled="" />
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-9 col-xxl-9 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">Descripción del factor</label>
                                <textarea class="form-control form-control-sm" id="txtFactorRiesgo" rows="3"></textarea>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <label class="form-label">Posibles efectos de riesgos</label>
                                <textarea class="form-control form-control-sm" id="txtPosibleRiesgo" rows="3"></textarea>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label">Clasificación del factor</label>
                                <select id="cboClasFactor" class="form-control form-control-sm"></select>
                            </div>
                            <%--<div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                <label class="form-label">¿Tiene control el factor?</label>
                                <select id="cboControlFactor" class="form-control form-control-sm"></select>
                            </div>--%>
                            <div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label">Tipo de factor</label>
                                <select id="cboTipoFactor" class="form-control form-control-sm"></select>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <%--<button class="btn btn-falcon-info btn-sm customButton" type="button" id="btnE_ValorInicial">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Insertar valor inicial sobre el riesgo
                            </button>--%>
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_Factor">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Guardar factor
                            </button>
                            <button class="btn btn-falcon-danger btn-sm customButton" type="button" id="btnCancel_Factor">
                                <span class="fas fa-times-circle me-2" data-fa-transform="shrink-3"></span>Cerrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalVInicialForm" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Insertar valores iniciales del riesgo
                    </h5>
                    <%--<button type="button" class="btn btn-sm btn-circle btn-close transition-base" id="backSeeMisDocumentos" style="--falcon-btn-close-bg: url() !important;">
                        <span aria-hidden="true"><span class="fas fa-arrow-left"></span></span>
                    </button>--%>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <%--<div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <label class="form-label">Posibles efectos de riesgos</label>
                                <textarea class="form-control form-control-sm" id="txtPosibleRiesgo" rows="3"></textarea>
                            </div>--%>
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <div class="border border-1 border-300 rounded-2 p-3 position-relative mb-3">
                                    <div class="d-felx align-items-center mb-3 fw-bold text-1000 form-label">Valoración inicial</div>

                                    <div class="row flex-center">
                                        <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                            <label class="form-label">Probabilidad de ocurrencia</label>
                                            <select id="cboProbabilidadInicio" class="form-control form-control-sm" data-grupo="Inicio"></select>
                                        </div>
                                        <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                            <label class="form-label">Impacto</label>
                                            <select id="cboImpactoInicio" class="form-control form-control-sm" data-grupo="Inicio"></select>
                                        </div>
                                        <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                            <label class="form-label">Cuadrante</label>
                                            <select id="cboCuadranteInicio" class="form-control form-control-sm" disabled="disabled"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-warning btn-sm customButton" type="button" id="btnUpdateValoresRiesgoInicio">
                                <span class="far fa-send me-2" data-fa-transform="shrink-3"></span>Guardar valores
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalControlForm" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Formulario del control
                    </h5>
                    <%--<button type="button" class="btn btn-sm btn-circle btn-close transition-base" id="backSeeMisDocumentos" style="--falcon-btn-close-bg: url() !important;">
                        <span aria-hidden="true"><span class="fas fa-arrow-left"></span></span>
                    </button>--%>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <div class="col-sm-12 col-md-12 col-lg-3 col-xxl-3 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">No. de control</label>
                                <input class="form-control form-control-sm" id="txtFolioControlFactor" type="text" placeholder="X.X" disabled="" />
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-9 col-xxl-9 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">Descripción del control</label>
                                <textarea class="form-control form-control-sm" id="txtDescControlFactor" rows="3"></textarea>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label">Tipo de control</label>
                                <select id="cboTipoControl" class="form-control form-control-sm"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label">Resultado de la determinación de control</label>
                                <select id="cboDeterminacion" class="form-control form-control-sm" disabled="disabled"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-3 col-xxl-3 position-relative">
                                <label class="form-label">Está documentado</label>
                                <select id="cboControlDocumentado" class="form-control form-control-sm"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-3 col-xxl-3 position-relative">
                                <label class="form-label">Está formalizado</label>
                                <select id="cboControlFormalizado" class="form-control form-control-sm"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-3 col-xxl-3 position-relative">
                                <label class="form-label">Se aplica</label>
                                <select id="cboControlAplica" class="form-control form-control-sm"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-3 col-xxl-3 position-relative">
                                <label class="form-label">Es efectivo</label>
                                <select id="cboControlEfectivo" class="form-control form-control-sm"></select>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <%--<button class="btn btn-falcon-info btn-sm customButton" type="button" id="btnE_ValorFinal">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Insertar valor final sobre el riesgo
                            </button>--%>
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_Control">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Guardar control
                            </button>
                            <button class="btn btn-falcon-danger btn-sm customButton" type="button" id="btnCancel_Control">
                                <span class="fas fa-times-circle me-2" data-fa-transform="shrink-3"></span>Cerrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalVFinForm" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Insertar valores finales del riesgo
                    </h5>
                    <%--<button type="button" class="btn btn-sm btn-circle btn-close transition-base" id="backSeeMisDocumentos" style="--falcon-btn-close-bg: url() !important;">
                    <span aria-hidden="true"><span class="fas fa-arrow-left"></span></span>
                </button>--%>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <label class="form-label">Probabilidad inicial: <span class="badge bg-primary" id="probabilidadLocal"></span></label>
                                <label class="form-label">Impacto inicial: <span class="badge bg-primary" id="impactoLocal"></span></label>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <div class="border border-1 border-300 rounded-2 p-3 position-relative mb-3">
                                    <div class="d-felx align-items-center mb-3 fw-bold text-1000 form-label">Valoración final</div>

                                    <div class="row flex-center">
                                        <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                            <label class="form-label">Probabilidad de ocurrencia</label>
                                            <select id="cboProbabilidadFin" class="form-control form-control-sm" data-grupo="Fin"></select>
                                        </div>
                                        <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                            <label class="form-label">Impacto</label>
                                            <select id="cboImpactoFin" class="form-control form-control-sm" data-grupo="Fin"></select>
                                        </div>
                                        <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                            <label class="form-label">Cuadrante</label>
                                            <select id="cboCuadranteFin" class="form-control form-control-sm" disabled="disabled"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--<div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label">Riesgo controlado suficientemente</label>
                                <select id="cboControl" class="form-control form-control-sm"></select>
                            </div>--%>
                            <%--<div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label">Estrategia</label>
                                <select id="cboEstrategia" class="form-control form-control-sm"></select>
                            </div>--%>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-warning btn-sm customButton" type="button" id="btnUpdateValoresRiesgoFin">
                                <span class="far fa-send me-2" data-fa-transform="shrink-3"></span>Guardar valores
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalAccionForm" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Formulario de acción
                    </h5>
                    <%--<button type="button" class="btn btn-sm btn-circle btn-close transition-base" id="backSeeMisDocumentos" style="--falcon-btn-close-bg: url() !important;">
                    <span aria-hidden="true"><span class="fas fa-arrow-left"></span></span>
                </button>--%>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">Descripción de la acción</label>
                                <textarea class="form-control form-control-sm" id="txtDescAccion" rows="3"></textarea>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_Accion">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Guardar acción
                            </button>
                            <button class="btn btn-falcon-danger btn-sm customButton" type="button" id="btnCancel_Accion">
                                <span class="fas fa-times-circle me-2" data-fa-transform="shrink-3"></span>Cerrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalActividadForm" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Formulario de actividad
                    </h5>
                    <%--<button type="button" class="btn btn-sm btn-circle btn-close transition-base" id="backSeeMisDocumentos" style="--falcon-btn-close-bg: url() !important;">
                        <span aria-hidden="true"><span class="fas fa-arrow-left"></span></span>
                    </button>--%>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <%--<div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">Responsable</label>
                                <input class="form-control form-control-sm" id="txtResponsableActividad" type="text"  />
                            </div>--%>
                            <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                <label class="form-label">Responsable</label>
                                <select id="cboResponsable" class="form-control form-control-sm"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-8 col-xxl-8 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">Descripción de la actividad</label>
                                <textarea class="form-control form-control-sm" id="txtDescActividad" rows="3"></textarea>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative mb-1">
                                <label class="form-label" for="exampleFormControlInput1">No. de actividad</label>
                                <input class="form-control form-control-sm" id="txtNoActividad" type="text" placeholder="0" disabled="disabled" />
                            </div>
                            <%--<div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                <label class="form-label  ">Mes</label>
                                <select id="cboMes" class="form-control form-control-sm"></select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-4 col-xxl-4 position-relative">
                                <label class="form-label  ">Trimestre</label>
                                <select id="cboTrimestre" class="form-control form-control-sm"></select>
                            </div>--%>
                            <div class="col-sm-12 col-md-12 col-lg-8 col-xxl-8 position-relative">
                                <label>Meses a reportar</label>
                                <select class="form-select form-select-sm selectpicker" id="cboMes2" multiple="multiple" size="1" data-options='{"placeholder":"Seleccione sus meses...","selectOnClose":false,"closeOnSelect":false}'>
                                    <%--<option value="">Seleccione los meses a reportar</option>
                                    <option value="1">Enero</option>
                                    <option value="2">Febrero</option>
                                    <option value="3">Marzo</option>
                                    <option value="4">Abril</option>
                                    <option value="5">Mayo</option>
                                    <option value="6">Junio</option>
                                    <option value="7">Julio</option>
                                    <option value="8">Agosto</option>
                                    <option value="9">Septiembre</option>
                                    <option value="10">Octubre</option>
                                    <option value="11">Noviembre</option>
                                    <option value="12">Diciembre</option>--%>
                                </select>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative mb-1" id="divUpdateMeta">
                                <label class="form-label">Meta programada</label>
                                <input class="form-control form-control-sm" id="txtNoMeta" type="number" placeholder="0" disabled="disabled" />
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative mb-1" id="divInsertMeta">
                                <div id="contenedorTextboxes"></div>
                            </div>
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative mb-1">
                                <label class="form-label">Evidencia o medio de verificación</label>
                                <input class="form-control form-control-sm" id="txtEvidencia" type="text" />
                            </div>
                            <%--<div class="col-sm-12 col-md-12 col-lg-6 col-xxl-6 position-relative">
                                <label class="form-label  ">Tipo de reporte</label>
                                <select id="cboTipoReporte" class="form-control"></select>
                            </div>--%>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_Actividad">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Guardar actividad
                            </button>
                            <button class="btn btn-falcon-danger btn-sm customButton" type="button" id="btnCancel_Actividad">
                                <span class="fas fa-times-circle me-2" data-fa-transform="shrink-3"></span>Cerrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalResumen" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Resumen de riesgo
                    </h5>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-3">
                    <div id="divResumen"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalFactorXControl" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Evaluación de controles
                    </h5>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <label class="form-label">¿Tiene control el factor?</label>
                                <select id="cboControlFactor" class="form-control form-control-sm"></select>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_FactorXControl">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Guardar respuesta
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalControlXRiesgo" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Riesgo controlado suficientemente
                    </h5>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <label class="form-label">Riesgo controlado suficientemente</label>
                                <select id="cboControl" class="form-control form-control-sm"></select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_ControlXRiesgo">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Guardar respuesta
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalAccionXRiesgo" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Estrategia para reducir el riesgo
                    </h5>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-1">
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                <label class="form-label">Estrategia</label>
                                <select id="cboEstrategia" class="form-control form-control-sm"></select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_AccionXRiesgo">
                                <span class="fas fa-save me-2" data-fa-transform="shrink-3"></span>Guardar respuesta
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalAlineacionObjetivo" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Objetivos y acciones sectoriales
                    </h5>
                    <%--<button type="button" class="btn btn-sm btn-circle btn-close transition-base" id="backSeeMisDocumentos" style="--falcon-btn-close-bg: url() !important;">
                <span aria-hidden="true"><span class="fas fa-arrow-left"></span></span>
            </button>--%>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-3">
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12">
                                <div class="row g-3">
                                    <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative" id="tableObjetivos">
                                        <div class="alert alert-warning border-0 d-flex align-items-center" role="alert">
                                            <div class="bg-warning me-3 icon-item"><span class="fas fa-exclamation-circle text-white fs-6"></span></div>
                                            <p class="mb-0 flex-1">Primero elimine el objetivo y acción, si es que requiere editarlo o no va acorde a su alineación</p>
                                        </div>
                                        <div class="table-responsive scrollbar">
                                            <table class="table table-hover table-striped overflow-hidden table-sm fs-10 dataTable w-100" id="tableObjetivoAcciones">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">No. Objetivo</th>
                                                        <th scope="col">Objetivo sectorial</th>
                                                        <th scope="col">No. Accion</th>
                                                        <th scope="col">Accion sectorial</th>
                                                        <th scope="col">Acciones</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                        <div id="contenedorCheckboxes">
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12 position-relative">
                                        <div id="resumenSelecciones">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-default btn-sm customButton" type="button" id="btnS_AlineacionObjetivo">
                                <span class="far fa-save me-2" data-fa-transform="shrink-3"></span>Guardar objetivos y acciones
                            </button>
                            <button class="btn btn-falcon-danger btn-sm customButton" type="button" id="btnCancel_AlineacionObjetivo">
                                <span class="fas fa-times-circle me-2" data-fa-transform="shrink-3"></span>Cerrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalObservacionesReporte" tabindex="-1" aria-labelledby="tooltippopoversLabel" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg mt-6 modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header">
                    <h5 class="modal-title">Historial de observaciones
                    </h5>
                    <button type="button" class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" style="margin: auto 10px !important;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div class="p-4 pb-0">
                        <div class="row g-3">
                            <div class="col-sm-12 col-md-12 col-lg-12 col-xxl-12" id="divNew">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <div class="col-12 d-flex justify-content-end">
                        <div class="" role="group" aria-label="Basic example">
                            <button class="btn btn-falcon-danger btn-sm customButton" type="button" data-bs-dismiss="modal" aria-label="Close">
                                <span class="fas fa-times-circle me-2" data-fa-transform="shrink-3"></span>Cerrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="<%= ResolveUrl("~\Content\assets\js\modifiers\controllers\doom.js") %>"></script>
    <%--<script type="text/javascript" src="<%= ResolveUrl("~\Content\assets\js\modifiers\controllersApp\01_00.js") %>"></script>--%>
</asp:Content>
