<%@ Page Title="" Language="C#" MasterPageFile="~/AltSayfa.Master" AutoEventWireup="true" CodeBehind="Blog.aspx.cs" Inherits="WebApplication1.Blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>BLOGLAR</h2>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:Repeater ID="rptBlogPosts" runat="server">
        <ItemTemplate>
            <article class="blog_item">
                <div class="blog_item_img">
                    <img class="card-img rounded-0" src='<%# Eval("image") %>' height="400" alt="">
                    <span href="#" class="blog_item_date">
                        <h3><%# Eval("published_at", "{0:dd}") %></h3>
                        <p><%# Eval("published_at", "{0:MMMM}") %></p>
                    </span>
                </div>

                <div class="blog_details">
                    <h2><%# Eval("title") %></h2>
                    <asp:Literal runat="server" Text='<%# Eval("content") %>' Mode="PassThrough" />
                </div>
            </article>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>

