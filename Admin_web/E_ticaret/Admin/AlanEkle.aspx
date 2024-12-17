<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminAnaSayfa.Master" AutoEventWireup="true" CodeBehind="AlanEkle.aspx.cs" Inherits="E_ticaret.Admin.AlanEkle" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row">
                    <div class="col-12" style="text-align: center;">
                        <h2>Alan ekle</h2>
                    </div>
                    <hr />
                    <div class="col-2">
                    </div>
                    <div class="col-md-8">
                        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                        <br />
                        <h5>Alan ismi</h5>
                        <asp:TextBox ID="txtAlanIsmı" runat="server" placeholder="" CssClass="form-control" Required="true"></asp:TextBox>
                        <br />
                        <asp:Button ID="btnUrunekle" runat="server" Text="Alan ekle" CssClass="btn btn-primary" OnClick="btnUrunekle_Click" />
                    </div>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
