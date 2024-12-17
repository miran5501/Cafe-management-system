using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using E_ticaret.classlar;
using Newtonsoft.Json;
using System.Net.Http;

namespace E_ticaret
{
    public partial class Kayit_ol : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected async void btnKayitOl_Click(object sender, EventArgs e)
        {
            string apiUrl = "http://localhost:8080/register"; // API URL'nizi buraya yazın
            string kullaniciAdi = txtKullaniciAdi_kayit.Text;
            string sifre = txtSifre_kayit.Text;
            string adSoyad = txtAdSoyad.Text;

            try
            {
                var loginData = new
                {
                    username = kullaniciAdi,
                    password = sifre,
                    isimSoyisim = adSoyad
                };

                string jsonData = JsonConvert.SerializeObject(loginData);

                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

                StringContent content = new StringContent(jsonData, System.Text.Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    string responseContent = await response.Content.ReadAsStringAsync();

                    // Yanıtı ekrana yazdırarak inceleyebilirsiniz (debugging için)
                    Response.Write(responseContent);

                    // API'den dönen JSON verisini çözümleme
                    JsonConvert.DeserializeObject<dynamic>(responseContent);

                   
                        Response.Redirect("/Giris_Kayit/GirisYap.aspx", false);

                }
                else
                {
                    // API isteği başarısız
                    ShowErrorMessage("Giriş işlemi başarısız. Hata: " + response.StatusCode);
                }
            }
            catch (Exception ex)
            {
                // Hata yönetimi
                ShowErrorMessage("Bir hata oluştu: " + ex.Message);
            }
        }

        private void ShowErrorMessage(string message)
        {
            pnlError.Visible = true;
            ltlErrorMessage.Text = message;
        }
    }
}
