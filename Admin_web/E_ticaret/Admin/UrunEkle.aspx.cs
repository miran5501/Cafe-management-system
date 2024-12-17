using E_ticaret.classlar;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_ticaret.Admin
{
    public partial class MasaEkle : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi
        protected void Page_Load(object sender, EventArgs e)
        {

              if (!IsPostBack)
            {
                LoadCategories();
            }

        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }

        // Kategorileri API'den al
        private async void LoadCategories()
        {
            string Token = GetToken();

            // API URL'sini tanımlıyoruz
            string apiUrl = "http://localhost:8080/api/kategori/getir";

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", Token);

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

                    // "Seçiniz" gibi bir başlangıç seçeneği ekleyelim
                    ddlKategoriler.Items.Insert(0, new ListItem("Seçiniz", ""));
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
        protected async void btnUrunekle_Click(object sender, EventArgs e)
        {
            // Ürün verilerini al
            string selectedCategoryId = ddlKategoriler.SelectedValue;
            var urun = new
            {
                urunAdi = txtUrunismi.Text,
                kategoriId = selectedCategoryId,
                fiyat = decimal.TryParse(txtUrunFiyat.Text, out decimal fiyat) ? fiyat : 0,
                stok = int.TryParse(txtStokAdet.Text, out int stok) ? stok : 0,
                resim = txtUrunResim.Text
            };

            // API'ye gönder
            await UrunEkle(urun);
        }

        // API'ye ürün ekleme işlemi
        private async Task UrunEkle(object urunData)
        {
            string Token = GetToken();

            string apiUrl = "http://localhost:8080/api/urun/kaydet"; // API URL'sini buraya yerleştirin

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", Token);

            string jsonData = JsonConvert.SerializeObject(urunData);
            StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    // Başarılı olursa kullanıcıyı bilgilendir
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Başarılı!', 'Ürün başarıyla eklendi.', 'success');", true);
                }
                else
                {
                    // Hata durumunda bilgilendirme
                    Console.WriteLine($"Hata: {response.StatusCode}");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Hata!', 'Ürün eklenemedi.', 'error');", true);
                }
            }
            catch (Exception ex)
            {
                // Hata loglama
                Console.WriteLine($"İstek sırasında bir hata oluştu: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Hata!', 'Bir hata oluştu.', 'error');", true);
            }
        }
        protected void ddlKategoriler_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
