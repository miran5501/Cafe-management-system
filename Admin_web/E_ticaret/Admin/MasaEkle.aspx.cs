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

namespace E_ticaret.Admin
{
    public partial class MasaEkle1 : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                LoadAlan();
                MasalarıYukle();
            }

        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }

        // Kategorileri API'den al
        private async void LoadAlan()
        {
            string token = GetToken();

            // API URL'sini tanımlıyoruz
            string apiUrl = "http://localhost:8080/api/alan/getir";

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            try
            {
                // API'den kategorileri alıyoruz
                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string content = await response.Content.ReadAsStringAsync();
                    var Alan = JsonConvert.DeserializeObject<List<Alan>>(content);

                    // Dropdown listesine kategorileri bindiriyoruz
                    ddlAlan.DataTextField = "alanIsmi";
                    ddlAlan.DataValueField = "id";
                    ddlAlan.DataSource = Alan;
                    ddlAlan.DataBind();

                    // "Seçiniz" gibi bir başlangıç seçeneği ekleyelim
                    ddlAlan.Items.Insert(0, new ListItem("Seçiniz", ""));

                    // Dropdown listesine kategorileri bindiriyoruz
                    ddlAlanlar.DataTextField = "alanIsmi";
                    ddlAlanlar.DataValueField = "id";
                    ddlAlanlar.DataSource = Alan;
                    ddlAlanlar.DataBind();

                    // "Seçiniz" gibi bir başlangıç seçeneği ekleyelim
                    ddlAlanlar.Items.Insert(0, new ListItem("Seçiniz", ""));
                }
                else
                {
                    // Hata durumu
                    Console.WriteLine($"Hata: {response.StatusCode}");
                }
            }
            catch (Exception ex)
            {
                // Hata loglama
                Console.WriteLine($"İstek sırasında bir hata oluştu: {ex.Message}");
            }
        }

        // Ürün ekleme işlemi
        protected async void btnMasaEkle_Click(object sender, EventArgs e)
        {
            // Ürün verilerini al
            string selectedCategoryId = ddlAlan.SelectedValue;
            var Masa = new
            {
                masaAdi = txtMasaismi.Text,
                alanId = selectedCategoryId,
            };

            // API'ye gönder
            await MasaEkle(Masa);
        }

        // API'ye ürün ekleme işlemi
        private async Task MasaEkle(object MasaData)
        {
            string token = GetToken();

            string apiUrl = "http://localhost:8080/api/masa/kaydet"; // API URL'sini buraya yerleştirin

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            string jsonData = JsonConvert.SerializeObject(MasaData);
            StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    // Başarılı olursa kullanıcıyı bilgilendir
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Başarılı!', 'Masa başarıyla eklendi.', 'success');", true);
                }
                else
                {
                    // Hata durumunda bilgilendirme
                    Console.WriteLine($"Hata: {response.StatusCode}");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Hata!', 'Masa eklenemedi.', 'error');", true);
                }
            }
            catch (Exception ex)
            {
                // Hata loglama
                Console.WriteLine($"İstek sırasında bir hata oluştu: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Hata!', 'Bir hata oluştu.', 'error');", true);
            }
        }

        private async void MasalarıYukle()
        {
            string token = GetToken();
            // API URL'sini tanımlıyoruz
            string apiUrl = "http://localhost:8080/api/masa/getir";

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            try
            {
                // API'den kategorileri alıyoruz
                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string content = await response.Content.ReadAsStringAsync();
                    var masalar = JsonConvert.DeserializeObject<List<Masa_ekle>>(content);

                    // Dropdown listesine kategorileri bindiriyoruz
                    ddlMasalar.DataTextField = "masaAdi";
                    ddlMasalar.DataValueField = "id";
                    ddlMasalar.DataSource = masalar;
                    ddlMasalar.DataBind();
                }
                else
                {
                    // Hata durumu
                    Console.WriteLine($"Hata: {response.StatusCode}");
                }
            }
            catch (Exception ex)
            {
                // Hata loglama
                Console.WriteLine($"İstek sırasında bir hata oluştu: {ex.Message}");
            }
        }
        protected void btnGuncelle_Click(object sender, EventArgs e)
        {
            string selectedMasaId = ddlMasalar.SelectedValue;
            string selectedAlanId = ddlAlanlar.SelectedValue;
            string updatedCategoryName = txtMasaAdi.Text;

            var updateMasa = new
            {
                masaIsmi = updatedCategoryName,
                alanId = selectedAlanId
            };

            UpdateCategoryInApi(selectedMasaId, updateMasa);
        }



        private async Task UpdateCategoryInApi(string selectedMasaId, object updateMasa)
        {
            string token = GetToken();

            string apiUrl = $"http://localhost:8080/api/masa/guncelle/{selectedMasaId}"; // API URL'sini buraya yerleştirin

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            string jsonData = JsonConvert.SerializeObject(updateMasa);
            StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PutAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    Console.WriteLine("Masa başarıyla güncellendi.");
                }
                else
                {
                    Console.WriteLine($"Hata: {response.StatusCode}");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"İstek sırasında bir hata oluştu: {ex.Message}");
            }
        }
        protected void ddlKategoriler_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
