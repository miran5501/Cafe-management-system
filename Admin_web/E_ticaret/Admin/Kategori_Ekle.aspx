<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminAnaSayfa.Master" AutoEventWireup="true" CodeBehind="Kategori_Ekle.aspx.cs" Inherits="E_ticaret.Admin.Kategori_Ekle" Async="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">

            <div class="row">
                <div class="col-xl-2">
                </div>
                <div class="col-md-6 col-xl-4 mb-3">
                    <div class="p-3 Kartlar">
                        <h2>Kategori Ekle</h2>
                        <hr />
                        <h5>Kategori İsmi</h5>
                        <asp:TextBox ID="txtkategori" runat="server" CssClass="form-control"></asp:TextBox>
                        <br />
                        <asp:Button ID="BtnKategori" runat="server" Text="Kategori Ekle" CssClass="btn btn-primary" OnClick="BtnKategori_Click" />
                    </div>
                </div>
                <div class="col-md-6 col-xl-4 mb-3">
                    <div class="p-3 Kartlar">
                        <h2>Kategori Güncelle</h2>
                        <hr />
                        <h5>Kategori Seç</h5>
                        <asp:DropDownList ID="ddlKategoriler" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlKategoriler_SelectedIndexChanged">
                        </asp:DropDownList>
                        <br />
                        <asp:TextBox ID="txtKategoriAdi" runat="server" CssClass="form-control" />
                        <br />
                        <asp:Button ID="btnGuncelle" runat="server" Text="Güncelle" CssClass="btn btn-primary" OnClick="btnGuncelle_Click" />
                    </div>
                </div>
                <div class="col-xl-2">
                </div>
            </div>

    </form>
</asp:Content>
