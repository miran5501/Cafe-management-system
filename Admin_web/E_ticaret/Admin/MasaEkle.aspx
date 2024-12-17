<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminAnaSayfa.Master" AutoEventWireup="true" CodeBehind="MasaEkle.aspx.cs" Inherits="E_ticaret.Admin.MasaEkle1" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
                <div class="row">
                    <div class="col-xl-2">
                    </div>
                    <div class="col-md-6 col-xl-4 mb-3">
                        <div class="p-3 Kartlar">
                            <h2>Masa ekle</h2>
                            <hr />
                            <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                            <br />
                            <h5>Masa ismi</h5>
                            <asp:TextBox ID="txtMasaismi" runat="server" placeholder="" CssClass="form-control"></asp:TextBox>
                            <br />
                            <h5>Alan</h5>
                            <asp:DropDownList ID="ddlAlan" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlKategoriler_SelectedIndexChanged">
                            </asp:DropDownList>
                            <br />
                            <asp:Button ID="btnMasaEkle" runat="server" Text="Masa ekle" CssClass="btn btn-primary" OnClick="btnMasaEkle_Click" />
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-4 mb-3">
                        <div class="p-3 Kartlar">
                            <h2>Masa Güncelle</h2>
                            <hr />
                            <h5>Masa Seç</h5>
                            <asp:DropDownList ID="ddlMasalar" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlKategoriler_SelectedIndexChanged">
                            </asp:DropDownList>
                            <br />
                            <asp:TextBox ID="txtMasaAdi" runat="server" CssClass="form-control" />
                            <br />
                            <h5>Alan Seç</h5>
                            <asp:DropDownList ID="ddlAlanlar" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlKategoriler_SelectedIndexChanged">
                            </asp:DropDownList>
                            <br />
                            <asp:Button ID="btnGuncelle" runat="server" Text="Güncelle" CssClass="btn btn-primary" OnClick="btnGuncelle_Click" />
                        </div>
                    </div>
                    <div class="col-xl-2">
                    </div>
                </div>
    </form>
</asp:Content>
