using E_ticaret.classlar;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_ticaret.Giris_Yapilmadan
{
    public partial class AnaSayfa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Kategoriler();
                urunler();
                Kampanyalar();
            }
        }

        protected void Kategoriler()
        {
            // Kategori veri kaynağını oluştur
            DataTable categoriesTable = new DataTable();
            categoriesTable.Columns.Add("KategoriID", typeof(int));
            categoriesTable.Columns.Add("KategoriAdi", typeof(string));
            categoriesTable.Columns.Add("KategoriResim", typeof(string));

            // "Tüm Kategoriler" kategorisini ekle
            categoriesTable.Rows.Add(0, "Tüm Ürünler", "https://www.guvendikmarket.com/wp-content/uploads/2020/08/ekmek-tekli.png");

            // Veritabanından kategorileri al
            SqlCommand commandList = new SqlCommand("SELECT KategoriID, KategoriAdi, KategoriResim FROM Kategoriler", SqlConnectionClass.connection);
            SqlConnectionClass.CheckConnection();

            SqlDataReader dr = commandList.ExecuteReader();

            // Veritabanı verilerini tabloya ekle
            categoriesTable.Load(dr);
            dr.Close();

            // Repeater'ı veri kaynağına bağla
            Repeater1.DataSource = categoriesTable;
            Repeater1.DataBind();
        }
        private void urunler()
        {
            SqlCommand commandList = new SqlCommand("SELECT UrunID, Urun_Adi, Urun_Fiyat, Urun_Resmi, Urun_Aciklamasi, Urun_Stok_Durum, Urun_KategoriID, Urun_Pasif_Durumu, KampanyaID, Eski_Fiyat FROM Urunler WHERE Urun_Stok_Durum = 1 AND Urun_Pasif_Durumu = 0", SqlConnectionClass.connection);

            SqlConnectionClass.CheckConnection();

            SqlDataReader dr = commandList.ExecuteReader();

            Repeater2.DataSource = dr;
            Repeater2.DataBind();
            dr.Close(); // SqlDataReader'ı kapat
        }
        protected void Kampanya_Click(object sender, EventArgs e)
        {
            ImageButton clickedButton = (ImageButton)sender;
            int kampanyaID = Convert.ToInt32(clickedButton.CommandArgument);
        }


        private void Kampanyalar()
        {
            SqlCommand commandList = new SqlCommand("SELECT * FROM Kampanyalar", SqlConnectionClass.connection);

            SqlConnectionClass.CheckConnection();

            SqlDataReader dr = commandList.ExecuteReader();

            Repeater3.DataSource = dr;
            Repeater3.DataBind();
            dr.Close(); // SqlDataReader'ı kapat
        }





    }
}