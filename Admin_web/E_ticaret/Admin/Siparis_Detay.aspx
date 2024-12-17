<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminAnaSayfa.Master" AutoEventWireup="true" CodeBehind="Siparis_Detay.aspx.cs" Inherits="E_ticaret.Admin.Siparis_Detay" Async="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" class="container mt-4">
        <div class="container mt-5">
            <h2>Siparişteki Ürünler</h2>
            <br />
            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th class="show">Bilgiler</th>
                                <th class="show"></th>
                                <th scope="col" class="tablo">#</th>
                                <th scope="col" class="tablo">Ürün Fotoğrafı</th>
                                <th scope="col" class="tablo">Ürün Adı</th>
                                <th scope="col" class="tablo">Ürün Alınma Tarihi</th>
                                <th scope="col" class="tablo">Ürün Ödenme Tarihi</th>
                                <th scope="col" class="tablo">Adedi</th>
                                <th scope="col" class="tablo">Birim Fiyatı</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>


                    <tr>
                        <%--<td class="show"><img class="card-img-top" src='<%# Eval("Urun_Resmi") %>' alt="Ürün Resmi" style="object-fit: contain; max-height: 80px;" /></td>
                        <td class="show">
                            <strong>Ürün Adı: </strong><%# Eval("Urun_Adi") %><br />
                            <strong>Açıklaması: </strong><%# Eval("Urun_Aciklamasi") %><br />
                            <strong>Ürün Birim Fiyatı: </strong>₺<%# string.Format("{0:F2}", Eval("Siparis_urun_fiyat")) %>
                        </td>--%>
                        <th scope="col" class="tablo"><%# Container.ItemIndex + 1 %></th>
                        <td class="tablo">
                            <img class="card-img-top" style="max-height:100px; max-width:100px;" src='<%# Eval("urun.resim") %>' />
                        <td class="tablo"><%# Eval("urun.urunAdi") %></td>
                        <td class="tablo"><%# Eval("urunEklenmeTarihi") %></td>
                        <td class="tablo"><%# Eval("urunKaldirilmaTarihi") %></td>
                        <td class="tablo"><%# Eval("urunAdet") %></td>
                        <td class="tablo">₺<%# string.Format("{0:F2}", Eval("urun.fiyat")) %></td>

                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
    </table>
                </FooterTemplate>
            </asp:Repeater>

        </div>
    </form>
</asp:Content>
