<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminAnaSayfa.Master" AutoEventWireup="true" CodeBehind="UrunEkle.aspx.cs" Inherits="E_ticaret.Admin.MasaEkle" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row">
                    <div class="col-12" style="text-align: center;">
                        <h2>Ürün ekle</h2>
                    </div>
                    <hr />
                    <div class="col-2">
                    </div>
                    <div class="col-md-8">
                        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                        <br />
                        <h5>Ürün ismi</h5>
                        <asp:TextBox ID="txtUrunismi" runat="server" placeholder="" CssClass="form-control" Required="true"></asp:TextBox>
                        <br />
                        <h5>Ürün fiyatı</h5>
                        <asp:TextBox ID="txtUrunFiyat" runat="server" placeholder="" CssClass="form-control" Required="true"></asp:TextBox>
                        <br />
                        <h5>Ürün Resim Yükle</h5>
                        <asp:TextBox ID="txtUrunResim" runat="server" placeholder="" CssClass="form-control" Required="true"></asp:TextBox>
                        <br />
                        <h5>Ürün kategori</h5>
                        <asp:DropDownList ID="ddlKategoriler" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlKategoriler_SelectedIndexChanged">
                        </asp:DropDownList>
                        <br />
                        <h5>Ürün stok adet</h5>
                        <asp:TextBox ID="txtStokAdet" runat="server" placeholder="" CssClass="form-control" Required="true"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Button ID="btnUrunekle" runat="server" Text="Ürünü ekle" CssClass="btn btn-primary" OnClick="btnUrunekle_Click" />
                    </div>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
