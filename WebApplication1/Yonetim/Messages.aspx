<%@ Page Title="" Language="C#" MasterPageFile="~/Yonetim/Admin.Master" AutoEventWireup="true" CodeBehind="Messaages.aspx.cs" Inherits="WebApplication1.Yonetim.Messages" %>

<asp:Content ID="StyleContent" ContentPlaceHolderID="StyleContent" runat="server">
    <!-- Styles start -->
    <link href="css/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="css/toastr.min.css" rel="stylesheet">
    <!-- Styles end -->
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainHeader" runat="server">
    <!-- Header Text start -->
    Mesajlar
    <!-- Header End -->
</asp:Content>

<asp:Content ID="PageActions" ContentPlaceHolderID="PageActions" runat="server">
    <!-- Page Actions start -->

    <!-- Page Actions End -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Table start -->
     <div class="row my-4">
         <!-- Small table -->
         <div class="col-md-12">
             <div class="card shadow">
                 <div class="card-body">
                     <!-- table -->
                     <table class="table datatables" id="dataTable-1">
                         <thead>
                         <tr>
                             <th>#</th>
                             <th>Name</th>
                             <th>Email</th>
                             <th>Subject</th>
                             <th>Received On</th>
                             <th>Actions</th>
                         </tr>
                         </thead>
                         <tbody>
                         </tbody>
                     </table>
                 </div>
             </div>
         </div> 
        <!-- simple table -->
     </div>
    <!-- Table End -->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HiddenContent" runat="server">
    <!-- Hidden content start -->
    <!-- View Modal -->
    <div aria-hidden="true" aria-labelledby="viewModalLabel" class="modal fade bd-example-modal-lg" id="viewModal" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="varyModalLabel">Contact Message</h5>
                    <button aria-label="Close" class="close" data-dismiss="modal"
                            type="button">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div ID="messageBody"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Hidden Content End -->
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <!-- Script Content start -->
    <script src='js/jquery.dataTables.min.js'></script>
    <script src='js/dataTables.bootstrap4.min.js'></script>
    <script src='js/toastr.min.js'></script>
        <script>
        
        toastr.options = {
          "closeButton": false,
          "debug": false,
          "newestOnTop": false,
          "progressBar": false,
          "positionClass": "toast-top-right",
          "preventDuplicates": false,
          "onclick": null,
          "showDuration": "300",
          "hideDuration": "3000",
          "timeOut": "5000",
          "extendedTimeOut": "1000",
          "showEasing": "swing",
          "hideEasing": "linear",
          "showMethod": "fadeIn",
          "hideMethod": "fadeOut"
        }
    
    
    $(document).ready(function () {
       'use strict';
       
       // get datatable data
       initializeDataTable();
    });
    
    
    function initializeDataTable() {
        $('#dataTable-1').DataTable({
            autoWidth: true,
            ajax: {
                url: '<%= ResolveUrl("~/Yonetim/Messages.aspx/GetMessages") %>',
                dataSrc: '',
                type: 'GET',
                contentType: "application/json; charset=utf-8",
                dataFilter: function(data) {
                    // Parse the JSON data here and transform as necessary
                    var json = JSON.parse(data);
                    // If your data is wrapped under 'd' and further needs to be parsed
                    json = JSON.parse(json.d);
                    // Return the stringified JSON which DataTables will use to render the table
                    return JSON.stringify(json);
                },
                error: function(error) {
                    console.error("Failed to load messages:", error);
                }
            },
            columns: [
                { data: "id" },
                { data: "name" },
                { data: "email" },
                { data: "subject" },
    
                { data: "created_at", render: function (data, type, row) {
                    return data || 'Not specified';
                }},
                { data: null, render: function (data, type, row) {
                    return `<button onclick="viewMessage(${row.id})" class="btn btn-sm btn-primary">View Message</button>`;
                }}
            ],
            "lengthMenu": [
                [16, 32, 64, -1],
                [16, 32, 64, "All"]
            ]
        });
    }
    
    function refreshTable() {
        var table = $('#dataTable-1').DataTable();
        table.ajax.reload(null, false);
    }
  
    function viewMessage(messageId) {
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/Yonetim/Messages.aspx/GetMessageById") %>',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ messageId: messageId }),
            dataType: "json",
            success: function(response) {
                var message = JSON.parse(response.d);
                console.log(message.message);
                $('#messageBody').text(message.message);

                $('#viewModal').modal('show');
            },
            error: function(error) {
                console.error("Failed to load message data:", error);
                toastr.error('Failed to load message data.');
            }
        });
    }

    </script>
    <!-- Script Content End -->
</asp:Content>