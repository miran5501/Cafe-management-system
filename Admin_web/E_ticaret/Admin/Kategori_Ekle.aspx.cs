using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json; // Newtonsoft.Json kütüphanesini kullanıyoruz, NuGet'ten ekleyin.

namespace E_ticaret.Admin
{
    public partial class Kategori_Ekle : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {
                int kullaniciID = (int)Session["KullaniciID"];
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetNoStore();
                Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            }
            else
            {
                
            }

            if (!IsPostBack)
            {
                LoadCategories();
            }
        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }

        private async void LoadCategories()
        {
            string token=GetToken();
            // API URL'sini tanımlıyoruz
            string apiUrl = "http://localhost:8080/api/kategori/getir";

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            try
            {
                // API'den kategorileri alıyoruz
                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string content = await response.Content.ReadAsStringAsync();
                    var categories = JsonConvert.DeserializeObject<List<Category>>(content);

                    // Dropdown listesine kategorileri bindiriyoruz
                    ddlKategoriler.DataTextField = "kategoriIsmi";
                    ddlKategoriler.DataValueField = "id";
                    ddlKategoriler.DataSource = categories;
                    ddlKategoriler.DataBind();
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


        protected void BtnKategori_Click(object sender, EventArgs e)
        {
            var newCategory = new
            {
                kategoriIsmi = txtkategori.Text
            };

            SendCategoryToApi(newCategory);
        }
        private async Task SendCategoryToApi(object categoryData)
        {
            string token = GetToken();

            string apiUrl = "http://localhost:8080/api/kategori/kaydet"; // API URL'sini buraya yerleştirin

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            string jsonData = JsonConvert.SerializeObject(categoryData);
            StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    Console.WriteLine("Kategori başarıyla gönderildi.");
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

        protected void btnGuncelle_Click(object sender, EventArgs e)
        {
            string selectedCategoryId = ddlKategoriler.SelectedValue;
            string updatedCategoryName = txtKategoriAdi.Text;

            var updatedCategory = new
            {
                kategoriIsmi = updatedCategoryName
            };

            UpdateCategoryInApi(selectedCategoryId, updatedCategory);
        }



        private async Task UpdateCategoryInApi(string categoryId, object categoryData)
        {
            string token = GetToken();

            string apiUrl = $"http://localhost:8080/api/kategori/guncelle/{categoryId}"; // API URL'sini buraya yerleştirin

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            string jsonData = JsonConvert.SerializeObject(categoryData);
            StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PutAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    Console.WriteLine("Kategori başarıyla güncellendi.");
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

    }

    // Kategori model sınıfı
    public class Category
    {
        public string id { get; set; }
        public string kategoriIsmi { get; set; }
    }
}
