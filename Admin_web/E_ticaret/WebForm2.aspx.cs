using E_ticaret.classlar;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_ticaret
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            urunler();
        }
        private void urunler()
        {
            SqlCommand commandList = new SqlCommand("SELECT UrunID, Urun_Adi, Urun_Fiyat, Urun_Resmi, Urun_Aciklamasi, Urun_Stok_Durum, Urun_KategoriID, Urun_Pasif_Durumu, KampanyaID, Eski_Fiyat FROM Urunler WHERE Urun_Stok_Durum = 1 AND Urun_Pasif_Durumu = 0", SqlConnectionClass.connection);

            SqlConnectionClass.CheckConnection();

            SqlDataReader dr = commandList.ExecuteReader();

            RepeaterUrunler.DataSource = dr;
            RepeaterUrunler.DataBind();
            dr.Close(); // SqlDataReader'ı kapat
        }
    }
}