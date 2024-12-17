using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static E_ticaret.Admin_paneli;

namespace E_ticaret.Admin
{
    public partial class AlanEkle : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                
            }

        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }

        protected async void btnUrunekle_Click(object sender, EventArgs e)
        {
            var Alan = new
            {
                alanIsmi = txtAlanIsmı.Text,
            };

            // API'ye gönder
            await Alan_Ekle(Alan);
        }

        // API'ye ürün ekleme işlemi
        private async Task Alan_Ekle(object Alan)
        {
            string token = GetToken();

            string apiUrl = "http://localhost:8080/api/alan/kaydet"; // API URL'sini buraya yerleştirin

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            string jsonData = JsonConvert.SerializeObject(Alan);
            StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    // Başarılı olursa kullanıcıyı bilgilendir
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Başarılı!', 'Alan başarıyla eklendi.', 'success');", true);
                }
                else
                {
                    // Hata durumunda bilgilendirme
                    Console.WriteLine($"Hata: {response.StatusCode}");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Hata!', 'Alan eklenemedi.', 'error');", true);
                }
            }
            catch (Exception ex)
            {
                // Hata loglama
                Console.WriteLine($"İstek sırasında bir hata oluştu: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Hata!', 'Bir hata oluştu.', 'error');", true);
            }
        }
    }
}