<%@ Page Title="" Language="C#" MasterPageFile="~/Giris_Yapilmadan/Giris_Yapilmamis_Sayfa.Master" AutoEventWireup="true" CodeBehind="Kayit_ol.aspx.cs" Inherits="E_ticaret.Kayit_ol" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper">
        <form id="form1" runat="server">
            <h1>Yeni Garson Kaydet</h1>

            <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

            <div class="input-box">
                <asp:TextBox ID="txtAdSoyad" runat="server" placeholder="Adınız ve Soyadınız" CssClass="form-control" Required="true" MaxLength="100"></asp:TextBox>
            </div>
            <div class="input-box">
                <asp:TextBox ID="txtKullaniciAdi_kayit" runat="server" placeholder="Kullanıcı Adı" CssClass="form-control" Required="true" MaxLength="100"></asp:TextBox>
            </div>
            <div class="input-box">
                <asp:TextBox ID="txtSifre_kayit" runat="server" placeholder="Şifre" CssClass="form-control" Required="true" TextMode="Password" MaxLength="100"></asp:TextBox>
            </div>
            <asp:Button ID="btnKayitOl" runat="server" Text="Kayıt Ol" CssClass="btn btn-primary" OnClick="btnKayitOl_Click" />
            <div class="register-link">
                <p>Giriş Sayfası İçin-><a href="GirisYap.aspx">Giriş Yap</a></p>
            </div>
            <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger" Visible="false">
                <asp:Literal ID="ltlErrorMessage" runat="server"></asp:Literal>
            </asp:Panel>
        </form>
    </div>
</asp:Content>
