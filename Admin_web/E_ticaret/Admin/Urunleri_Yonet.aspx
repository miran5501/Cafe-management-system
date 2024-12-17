<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminAnaSayfa.Master" AutoEventWireup="true" CodeBehind="Urunleri_Yonet.aspx.cs" Inherits="E_ticaret.Admin.Urunleri_Yonet" async="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" class="container mt-4">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="row row-cols-1 row-cols-md-3 g-4 justify-content-center">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <div class="card Kartlar" style="width: 16rem;">
                                <img class="card-img-top" src='<%# Eval("resim") %>' alt="Ürün Resmi" style="object-fit: contain; max-height: 120px;" />
                                <hr>
                                <div class="card-body Kartlar">
                                    <ul class="list-group list-group-flush Kartlar">
                                        <li class="list-group-item Kartlar" style="font-size: 14px;">
                                            <strong>
                                                <asp:Label ID="LabelUrunAdi" runat="server" Text='<%# Eval("urunAdi") %>'></asp:Label>
                                            </strong>
                                        </li>
                                        <li class="list-group-item Kartlar" style="font-size: 14px;">
                                            <strong>Fiyat:</strong>
                                            <asp:Label ID="LabelFiyat" runat="server" Text='<%# "₺" + Eval("fiyat") %>'></asp:Label>
                                        </li>
                                        <li class="list-group-item Kartlar" style="font-size: 14px;">
                                            <strong>Stok:</strong>
                                            <asp:Label ID="LabelStok" runat="server" Text='<%# Eval("stok") %>'></asp:Label>
                                        </li>
                                        <li class="list-group-item Kartlar">
                                            <asp:Button ID="btnUrunGuncelle" runat="server" Text="Güncelle" CssClass="btn btn-primary btn-sm" CommandArgument='<%# Eval("id") %>' OnClick="BtnUrunGuncelle_Click" />
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
