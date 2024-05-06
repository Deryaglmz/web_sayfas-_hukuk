<%@ Page Title="" Language="C#" MasterPageFile="~/Yonetim/Admin.Master" AutoEventWireup="true" CodeBehind="Blog.aspx.cs" Inherits="WebApplication1.Yonetim.Blog" %>

<asp:Content ID="StyleContent" ContentPlaceHolderID="StyleContent" runat="server">
    <!-- Styles start -->
    <link href="css/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="css/quill.snow.css" rel="stylesheet">
    <link href="css/dropzone.css" rel="stylesheet">
    <link href="css/bootstrap-datepicker.css" rel="stylesheet">
    <link href="css/toastr.min.css" rel="stylesheet">
    <!-- Styles end -->
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainHeader" runat="server">
    <!-- Header Text start -->
    Yazılar
    <!-- Header End -->
</asp:Content>

<asp:Content ID="PageActions" ContentPlaceHolderID="PageActions" runat="server">
    <!-- Page Actions start -->
    <button class="btn btn-primary" 
            data-target="#addModal"
            data-toggle="modal"
            data-whatever="@mdo"
            type="button"
            >
        <span class="fe fe-plus fe-12 mr-2"></span>Create
    </button>
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
                             <th>Title</th>
                             <th>Publish Date</th>
                             <th>Status</th>
                             <th>Image</th>
                             <th>Action</th>
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
    <!-- Add Modal -->
    <div aria-hidden="true" aria-labelledby="addModalLabel" class="modal fade bd-example-modal-lg" id="addModal" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="varyModalLabel">New Blog Post</h5>
                    <button aria-label="Close" class="close" data-dismiss="modal"
                            type="button">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="formBlogPost" runat="server" class="needs-validation" novalidate>
                        <div class="form-group">
                            <label class="col-form-label" for="post-title">Post Title:</label>
                            <asp:TextBox ID="txtPostTitle" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="txtPostTitle" ErrorMessage="Post title is required" runat="server" CssClass="invalid-feedback" Display="Dynamic" />
                        </div>
                        <div class="form-group mb-3">
                            <label for="published-date">Published Date</label>
                            <asp:TextBox ID="txtPublishedDate" runat="server" CssClass="form-control datepicker" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="post-status">Post Status:</label>
                            <select id="postStatus" class="form-control">
                                <option value="0">Unpublished</option>
                                <option value="1">Published</option>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label for="post-image">Post Image</label>
                            <div class="dropzone needsclick" id="post-image-dropzone">
                                <div class="dz-message needsclick">
                                    Drop files here or click to upload.<br>
                                </div>
                            </div>
                            <asp:HiddenField ID="hfImagePath" runat="server" />
                        </div>
                        <div class="form-group">
                            <label class="col-form-label" for="post-content">Post Content:</label>
                            <asp:HiddenField ID="hfPostContent" runat="server" />
                            <div id="editor" style="min-height:100px;"></div>
                        </div>
                        <button class="btn btn-secondary" data-dismiss="modal" type="button">Cancel</button>
                        <asp:Button ID="btnCreate" runat="server" CssClass="btn btn-primary" Text="Create" OnClientClick="submitForm(); return false;" UseSubmitBehavior="false" />
                    </form>
                    
                    <!-- Preview -->
                    <!-- file preview template -->
                    <div class="d-none" id="uploadPreviewTemplate">
                        <div class="card mt-1 mb-0 shadow-none border">
                            <div class="p-2">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <img alt="" class="avatar-sm rounded bg-light"
                                             data-dz-thumbnail src="#">
                                    </div>
                                    <div class="col pl-0">
                                        <a class="text-muted font-weight-bold"
                                           data-dz-name href="javascript:void(0);"></a>
                                        <p class="mb-0" data-dz-size></p>
                                    </div>
                                    <div class="col-auto">
                                        <!-- Button -->
                                        <a class="btn btn-link btn-lg text-muted" data-dz-remove
                                           href="">
                                            <i class="dripicons-cross"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Blog Post</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="formEditBlogPost" runat="server" class="needs-validation" novalidate>
                        <asp:HiddenField ID="hfEditPostId" runat="server" />
                        <div class="form-group">
                            <label for="editPostTitle">Post Title:</label>
                            <asp:TextBox ID="txtEditPostTitle" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="editPublishedDate">Published Date:</label>
                            <asp:TextBox ID="txtEditPublishedDate" runat="server" CssClass="form-control datepicker"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="editPostStatus">Post Status:</label>
                            <select id="editPostStatus" class="form-control" required="required">
                                <option value="0">Unpublished</option>
                                <option value="1">Published</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="editPostImage">Post Image:</label>
                            <div class="dropzone needsclick" id="edit-post-image-dropzone">
                                <div class="dz-message needsclick">
                                    Drop files here or click to upload.<br>
                                </div>
                            </div>
                            <asp:HiddenField ID="hfEditImagePath" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="editPostContent">Post Content:</label>
                            <asp:HiddenField ID="hfEditPostContent" runat="server" />
                            <div id="editEditor" style="min-height:100px;"></div>
                        </div>
                        <button class="btn btn-secondary" data-dismiss="modal" type="button">Cancel</button>
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClientClick="submitEditForm(); return false;" UseSubmitBehavior="false" />
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this post?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="confirmDelete()">Delete</button>
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
    <script src='js/quill.min.js'></script>
    <script src='js/dropzone.min.js'></script>
    <script src='js/bootstrap-datepicker.min.js'></script>
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
       // Disable Dropzone auto-discovery
       Dropzone.autoDiscover = false;
       
       // Initialize Bootstrap Datepicker
       $('input.datepicker').datepicker({
           format: 'mm/dd/yyyy',
           autoclose: true
       });
       
       // get datatable data
       initializeDataTable();
    });
    
    // Initialize Dropzone
    Dropzone.options.postImageDropzone = {
       url: '<%= ResolveUrl("Handlers/FileUploadHandler.ashx") %>',
       maxFiles: 1,
       acceptedFiles: 'image/*',
       addRemoveLinks: true,
       init: function() {
           this.on("success", function(file, responseText) {
               // Assuming the server returns the path to the uploaded file
               console.log("File uploaded: ", responseText);
               document.getElementById('<%= hfImagePath.ClientID %>').value = responseText.trim();
           });
           this.on("error", function(file, response) {
               console.error("Error uploading: ", response);
               toastr.error('Error uploading image: ' + response);
           });
           this.on("removedfile", function(file) {
               document.getElementById('<%= hfImagePath.ClientID %>').value = '';
               console.log("File removed: ", file.name);
           });
       }
    };
    
    Dropzone.options.editPostImageDropzone = {
      url: '<%= ResolveUrl("Handlers/FileUploadHandler.ashx") %>',
      maxFiles: 1,
      acceptedFiles: 'image/*',
      addRemoveLinks: true,
      init: function() {
          this.on("success", function(file, responseText) {
              // Assuming the server returns the path to the uploaded file
              console.log("File uploaded: ", responseText);
              document.getElementById('<%= hfEditImagePath.ClientID %>').value = responseText.trim();
          });
          this.on("error", function(file, response) {
              console.error("Error uploading: ", response);
              toastr.error('Error uploading image: ' + response);
          });
          this.on("removedfile", function(file) {
              document.getElementById('<%= hfEditImagePath.ClientID %>').value = '';
              console.log("File removed: ", file.name);
          });
      }
    };
    
    // editor
    var quill = new Quill('#editor', {
        theme: 'snow',
        modules: {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'],
                [{'list': 'ordered'}, {'list': 'bullet'}],
                ['clean']
            ]
        }
    });
    
    var editQuill = new Quill('#editEditor', {
        theme: 'snow',
        modules: {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'],
                [{'list': 'ordered'}, {'list': 'bullet'}],
                ['clean']
            ]
        }
    });
    
    quill.on('text-change', () => {
        var content = JSON.stringify(quill.root.innerHTML);
        $('#<%= hfPostContent.ClientID %>').val(content);
    });
    editQuill.on('text-change', () => {
        var editContent = JSON.stringify(editQuill.root.innerHTML);
        $('#<%= hfEditPostContent.ClientID %>').val(editContent);
    });
    
    function initializeDataTable() {
        $('#dataTable-1').DataTable({
            autoWidth: true,
            ajax: {
                url: '<%= ResolveUrl("~/Yonetim/Blog.aspx/GetPosts") %>',
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
                    console.error("Failed to load posts:", error);
                }
            },
            columns: [
                { data: "id" },
                { data: "title" },
                { data: "published_at", render: function (data, type, row) {
                    return data || 'Not specified';
                }},
                { data: "status" },
                { data: "image", render: function (data, type, row) {
                    return `<img src="${data}" alt="Post Image" style="width:50px; height:auto;">`;
                }},
                { data: null, render: function (data, type, row) {
                    return `<button onclick="editPost(${row.id})" class="btn btn-sm btn-primary">Edit</button>
                            <button onclick="deletePost(${row.id})" class="btn btn-sm btn-danger">Delete</button>`;
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
        table.ajax.reload(null, false); // false means do not reset pagination
    }
    
    function CloseAndRefresh() {
        $('#addModal').modal('hide'); // Hide the modal
        location.reload(); // Reload the page to update the content or redirect as necessary
    }
    
    function submitForm() {
        var form = document.getElementById('<%= formBlogPost.ClientID %>'); // Ensure this is the correct ID
        if (!form) {
            console.error("Form not found!");
            return;
        }
    
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            toastr.error('Please correct the errors in the form.');
            return;
        }
    
        // If the form is valid, proceed with AJAX submission
        var title = $('#<%= txtPostTitle.ClientID %>').val();
        var publishedDate = $('#<%= txtPublishedDate.ClientID %>').val();
        var imagePath = $('#<%= hfImagePath.ClientID %>').val();
        var content = $('#<%= hfPostContent.ClientID %>').val();
        var status = $('#postStatus').val();
    
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/Yonetim/Blog.aspx/CreatePost") %>',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ title: title, publishedDate: publishedDate, imagePath: imagePath, content: content, status: status }),
            dataType: "json",
            success: function(response) {
                toastr.success('Post created successfully.');
                $('#addModal').modal('hide');
                
                refreshTable();
            },
            error: function() {
                toastr.error('An error occurred while submitting the form. Please try again.');
            }
        });
    }
    
    function editPost(postId) {
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/Yonetim/Blog.aspx/GetPostById") %>',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ postId: postId }),
            dataType: "json",
            success: function(response) {
                var post = JSON.parse(response.d);
                $('#<%= txtEditPostTitle.ClientID %>').val(post.title);
                $('#<%= txtEditPublishedDate.ClientID %>').datepicker('update', post.published_at);
                $('#editPostStatus').val(post.status);
                $('#hfEditImagePath').val(post.image);
                $('#<%= hfEditPostId.ClientID %>').val(post.id);
  
 
                editQuill.root.innerHTML = post.content.replace(/["']/g, "");
                $('#editModal').modal('show');
            },
            error: function(error) {
                console.error("Failed to load post data:", error);
                toastr.error('Failed to load post data.');
            }
        });
    }
    
    function submitEditForm() {
        var form = document.getElementById('<%= formEditBlogPost.ClientID %>');
        if (!form) {
            console.error("Form not found!");
            return;
        }
    
        var postId = $('#<%= hfEditPostId.ClientID %>').val(); // Ensure you have a hidden field for postId
        var title = $('#<%= txtEditPostTitle.ClientID %>').val() || null;
        var publishedDate = $('#<%= txtEditPublishedDate.ClientID %>').val() || null;
        var imagePath = $('#<%= hfEditImagePath.ClientID %>').val() || null;
        var content = $('#<%= hfEditPostContent.ClientID %>').val() || null;
        var status = $('#editPostStatus').val() || null;
    
        var data = JSON.stringify({
            postId: postId,
            title: title,
            publishedDate: publishedDate,
            imagePath: imagePath,
            content: content,
            status: status ? parseInt(status) : null
        });
    
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/Yonetim/Blog.aspx/UpdatePost") %>',
            contentType: "application/json; charset=utf-8",
            data: data,
            dataType: "json",
            success: function(response) {
                toastr.success('Post updated successfully.');
                $('#editModal').modal('hide');
                
                refreshTable();
            },
            error: function() {
                toastr.error('An error occurred while updating the post. Please try again.');
            }
        });
    }

    var currentDeletingPostId = 0;
    function deletePost(postId) {
        currentDeletingPostId = postId;
        $('#deleteModal').modal('show');
    }
    
    function confirmDelete() {
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/Yonetim/Blog.aspx/DeletePost") %>',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ postId: currentDeletingPostId }),
            success: function(response) {
                if (response) {
                    toastr.success('Post deleted successfully.');
                    $('#deleteModal').modal('hide');
                    
                    refreshTable();
                } else {
                    toastr.error('Failed to delete post.');
                }
            },
            error: function() {
                toastr.error('An error occurred while deleting the post.');
            }
        });
    }

    </script>
    <!-- Script Content End -->
</asp:Content>
