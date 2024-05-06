<%@ Page Title="" Language="C#" MasterPageFile="~/AltSayfa.Master" AutoEventWireup="true" CodeBehind="Iletisim.aspx.cs" Inherits="WebApplication1.Iletisim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>İLETİŞİM</h2>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="row">
        <div class="col-12">
            <asp:Label ID="lblStatus" runat="server" CssClass="status-message" Visible="false"></asp:Label>
        </div>
        <div class="col-12">
            <h2 class="contact-title">Bizimle İletişime Geçin</h2>
        </div>
        <div class="col-lg-8">
            <form class="form-contact contact_form" runat="server">
                <div class="row">
                    <div class="col-12 mb-5">
                        <div class="form-group">
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control w-100" TextMode="MultiLine" Rows="9" placeholder="Mesajınızı giriniz"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control valid" placeholder="Adınızı giriniz"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control valid" TextMode="Email" placeholder="Email"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-group">
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Konu"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group mt-3">
                    <asp:Button ID="btnSubmit" runat="server" Text="Gönder" CssClass="button button-contactForm boxed-btn" OnClick="Submit_Click" />
                </div>
            </form>
            
        </div>
        <div class="col-lg-3 offset-lg-1">
            <div class="media contact-info">
                <span class="contact-info__icon">
                    <i class="ti-home"></i>
                </span>
                <div class="media-body">
                    <h3>İstanbul, Türkiye.</h3>
                    <p>Atatürk Mahallesi, Ertuğrul Gazi Sokak, Metropol İstanbul Sitesi No:2E A3 Blok Kat:6 D-79 Ataşehir/İstanbul</p>
                </div>
            </div>
            <div class="media contact-info">
                <span class="contact-info__icon">
                    <i class="ti-tablet"></i>
                </span>
                <div class="media-body">
                    <h3>666 569 025077</h3>
                    <p>Pazartesi'den Cuma'ya sabah 9'dan akşam 6'ya kadar</p>
                </div>
            </div>
            <div class="media contact-info">
                <span class="contact-info__icon">
                    <i class="ti-email"></i>
                </span>
                <div class="media-body">
                    <h3>info@Anoktası.com.tr</h3>
                    <p>istediğiniz zaman yazabilirsiniz!</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
