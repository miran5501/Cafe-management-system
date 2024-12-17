using E_ticaret.classlar;
using Newtonsoft.Json;
using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;

namespace E_ticaret
{
    public partial class GirisYap : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected async void btnGirisYap_Click(object sender, EventArgs e)
        {
            string apiUrl = "http://localhost:8080/authenticate"; // API URL'nizi buraya yazın
            string kullaniciAdi = txtKullaniciAdi_giris.Text;
            string sifre = txtSifre_giris.Text;

            try
            {
                var loginData = new
                {
                    username = kullaniciAdi,
                    password = sifre
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
                    Token token = JsonConvert.DeserializeObject<Token>(responseContent);

                    // Token nesnesinin null olup olmadığını kontrol et
                    if (token == null || string.IsNullOrEmpty(token.accessToken))
                    {
                        ShowErrorMessage("Geçersiz Token: accessToken alınamadı.");
                        return;
                    }

                    // Token'ı almak
                    string accessToken1 = token.accessToken;

                    // Token'ı oturuma kaydetmek
                    Session["Token"] = accessToken1;
                    if (Session["Token"] == null)
                    {
                        ShowErrorMessage("Token session'a kaydedilemedi.");
                    }
                    else
                    {
                        // Kullanıcıyı yönlendir
                        Response.Redirect("/Admin/Admin_paneli.aspx",false);
                        Context.ApplicationInstance.CompleteRequest();
                    }

                    
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

    public class Token
    {
        public string accessToken { get; set; }
        public string refreshToken { get; set; }
    }
}
