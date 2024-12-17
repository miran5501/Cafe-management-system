<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminAnaSayfa.Master" AutoEventWireup="true" CodeBehind="Gecmis_Siparisler.aspx.cs" Inherits="E_ticaret.Admin.Gecmis_Siparisler" Async="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" class="container mt-4">
        <div class="container mt-5">
            <h2>Siparişler</h2>
            <br />
            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th class="show">Bilgiler</th>
                                <th class="show"></th>
                                <th class="tablo">#</th>
                                <th class="tablo">Masa Açılış Tarihi</th>
                                <th class="tablo">Masa Kapanış Tarihi</th>
                                <th class="tablo">Toplam Tutar</th>
                                <th class="tablo">Sipariş Durumu</th>
                                <th class="tablo"></th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td class="show">
                            <strong>Sipariş Tarihi: </strong><%# Eval("id") %><br />
                            <strong>Sipariş Tarihi: </strong><%# Eval("MasaMusteriGelmeTarihi", "{0:dd/MM/yyyy}") %><br />
                            <strong>Sipariş Bitiş Tarihi: </strong><%# Eval("MasaMusteriGitmeTarihi", "{0:dd/MM/yyyy}") %><br />
                            <strong>Sipariş Tutarı: </strong>₺<%# string.Format("{0:F2}", Eval("ToplamTutar")) %><br />
                        </td>
                        <td class="show">
                            <asp:Button ID="Button1" runat="server" Text="Sipariş Detayları" CssClass="btn btn-primary btn-sm" OnClick="BtnSepetDetay_Click" CommandArgument='<%# Eval("id") ?? String.Empty %>' />
                        </td>
                        <th scope="col" class="tablo"><%# Container.ItemIndex + 1 %></th>
                        <td class="tablo"><%# Eval("MasaMusteriGelmeTarihi", "{0:dd/MM/yyyy}") %></td>
                        <td class="tablo"><%# Eval("MasaMusteriGitmeTarihi", "{0:dd/MM/yyyy}") %></td>
                        <td class="tablo">₺<%# string.Format("{0:F2}", Eval("ToplamTutar")) %></td>
                        <td class="tablo">
                            <asp:Button ID="btnSepetDetay" runat="server" Text="Sipariş Detayları" CssClass="btn btn-primary btn-sm" OnClick="BtnSepetDetay_Click" CommandArgument='<%# Eval("id") ?? String.Empty %>' />
                        </td>
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
