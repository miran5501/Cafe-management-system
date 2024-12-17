using E_ticaret.classlar;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading.Tasks;

namespace E_ticaret.Admin
{
    public partial class Siparis_Detay : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi

        protected async void Page_Load(object sender, EventArgs e)
        {

            string siparisID = Request.QueryString["SiparisID"];
            await MasaIcerikList(siparisID);

        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }
        private async Task MasaIcerikList(string masaid)
        {
            string token = GetToken();

            string apiUrl = $"http://localhost:8080/api/gecmis-masa/getir/{masaid}";
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            try
            {

                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string jsonData = await response.Content.ReadAsStringAsync();
                    var veri = JsonConvert.DeserializeObject<GecmisMasa>(jsonData);

                    // Repeater'a veri bağlama
                    if (veri != null && veri.gecmisMasaIcerikList != null)
                    {
                        Repeater1.DataSource = veri.gecmisMasaIcerikList;
                        Repeater1.DataBind();
                    }
                    else
                    {
                        // Geçerli veri yoksa kullanıcıya bilgi verebilirsiniz
                        Console.WriteLine("API yanıtı geçerli veri içermiyor.");
                    }
                }
                else
                {
                    // Yanıt başarısızsa, yanıt kodunu yazdırabilirsiniz
                    Console.WriteLine("API'den hata yanıtı geldi: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                // Hata durumunda ayrıntılı bilgi almak için yazdırabilirsiniz
                Console.WriteLine("Hata: " + ex.Message);
                // Opsiyonel: Stack trace de yazdırılabilir
                Console.WriteLine("Stack Trace: " + ex.StackTrace);
            }
        }

        private void SiparisUrunler(int siparisID)
        {
            SqlCommand commandSiparisDetaylari = new SqlCommand("SELECT * FROM Siparis_Urunler_Table INNER JOIN Urunler ON Siparis_urunID=UrunID WHERE SiparisID=@siparisID", SqlConnectionClass.connection);
            SqlConnectionClass.CheckConnection();
            commandSiparisDetaylari.Parameters.AddWithValue("@siparisID", siparisID);
            SqlDataReader dr = commandSiparisDetaylari.ExecuteReader();

            Repeater1.DataSource = dr;
            Repeater1.DataBind();
            dr.Close();
        }

        //private void Labellar()
        //{
        //    int siparisID = Convert.ToInt32(Request.QueryString["SiparisID"]);

        //    string query = @"SELECT s.Siparis_Olusturma_Tarihi, s.Siparis_Durumu, s.Siparis_Tutari, s.Siparis_Teslim_Adresi, s.Siparis_Notu, 
        //                     k.KullaniciAdSoyad
        //              FROM Siparisler s
        //              INNER JOIN Kullanicilar_Table k ON s.Siparis_OlusturanID = k.KullaniciID
        //              WHERE s.SiparislerID = @siparisID";

        //    SqlCommand command = new SqlCommand(query, SqlConnectionClass.connection);
        //    command.Parameters.AddWithValue("@siparisID", siparisID);

        //    SqlConnectionClass.CheckConnection();
        //    SqlDataReader reader = command.ExecuteReader();

        //    if (reader.Read())
        //    {
        //        lblSiparisVeren.Text = "<strong>Sipariş Veren:</strong> " + reader["KullaniciAdSoyad"].ToString();
        //        lblSiparisTarihi.Text = "<strong>Sipariş Tarihi:</strong> " + reader["Siparis_Olusturma_Tarihi"].ToString();
        //        lblSiparisTeslimDurumu.Text = "<strong>Sipariş Durumu:</strong> " + reader["Siparis_Durumu"].ToString();
        //        lblSiparisTutari.Text = "<strong>Sipariş Tutarı:</strong> ₺" + Convert.ToDecimal(reader["Siparis_Tutari"]).ToString("F2");
        //        lblSiparisTeslimAdresi.Text = "<strong>Sipariş Teslim Adresi:</strong> " + reader["Siparis_Teslim_Adresi"].ToString();
        //        lblSiparisNotu.Text = "<strong>Sipariş Notu:</strong> " + reader["Siparis_Notu"].ToString();
        //    }

        //    reader.Close();
        //}

    }
}