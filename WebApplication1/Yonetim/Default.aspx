<%@ Page Title="" Language="C#" MasterPageFile="~/Yonetim/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Yonetim.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainHeader" runat="server">
    <h1>Dashboard</h1>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- widgets -->
    <div class="row my-4">
        <div class="col-md-4">
            <div class="card shadow mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col">
                            <small class="text-muted mb-1">Blog Posts</small>
                            <h3 class="card-title mb-0" id="lblBlogPostCount" runat="server">Loading...</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col">
                            <small class="text-muted mb-1">Contact Messages</small>
                            <h3 class="card-title mb-0" id="lblMessageCount" runat="server">Loading...</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- end section -->
</asp:Content>