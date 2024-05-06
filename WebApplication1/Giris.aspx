<%@ Page Title="" Language="C#" MasterPageFile="~/AltSayfa.Master" AutoEventWireup="true" CodeBehind="Giris.aspx.cs" Inherits="WebApplication1.Giris" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Yönetici Giriş</h2>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="row">
        <div class="col-lg-8">
            <form id="form1" runat="server">
                <div class="row">
                    <asp:Label ID="LblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                    <div class="col-12">
                        <div class="form-group">
                           <asp:Label runat="server">Username</asp:Label>
                            <asp:TextBox ID="TxtUsername" CssClass="form-control valid" runat="server"></asp:TextBox>
                        </div>
                    </div> 
                    
                     <div class="col-12">
                         <div class="form-group">
                            <asp:Label runat="server">Şifre</asp:Label>
                             <asp:TextBox ID="TxtPassword" runat="server" CssClass="form-control valid" TextMode="Password"></asp:TextBox>
                         </div>
                     </div>
                    
                    <div class="col-12">
                        <div class="form-group">
                            <asp:Button ID="BtnLogin" runat="server" Text="Login" CssClass="button button-contactForm boxed-btn" OnClick="BtnLogin_Click" />
                        </div>
                    </div>
                    
                </div>
                </form>
        </div>
    </div>
</asp:Content>
