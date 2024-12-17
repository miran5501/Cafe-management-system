<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminAnaSayfa.Master" AutoEventWireup="true" CodeBehind="Admin_paneli.aspx.cs" Inherits="E_ticaret.Admin_paneli" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Form etiketini buraya ekliyoruz -->
    <form id="form1" runat="server">
        <div style="height: 90vh; width: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center;">
            <a href="AlanEkle.aspx">
                <i class="lni lni-cart-full"></i>
                <span>Alan Ekle</span>
            </a>
            <br />
            <a href="Gecmis_Siparisler.aspx">
                <i class="lni lni-cart-full"></i>
                <span>Geçmiş Siparişler</span>
            </a>
            <br />
            <a href="MasaEkle.aspx">
                <i class="lni lni-users"></i>
                <span>Masa Ekle</span>
            </a>
            <br />
            <a href="Urunleri_Yonet.aspx">
                <i class="lni lni-fresh-juice"></i>
                <span>Ürünler</span>
            </a>
            <br />
            <a href="UrunEkle.aspx">
                <i class="lni lni-fresh-juice"></i>
                <span>Ürün Ekle</span>
            </a>
            <br />
            <a href="Kategori_Ekle.aspx">
                <i class="lni lni-agenda"></i>
                <span>Kategoriler</span>
            </a>
        </div>

    </form>

</asp:Content>
