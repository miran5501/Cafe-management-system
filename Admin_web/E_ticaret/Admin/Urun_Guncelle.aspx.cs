using E_ticaret.classlar;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_ticaret.Admin
{
    public partial class Urun_Guncelle : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["UrunID"] != null)
                {
                    string urunID = Request.QueryString["UrunID"];
                    LoadCategories();
                    LoadUrunler(urunID);
                    
                }
            }
        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }
        private async void LoadUrunler(string urunID)
        {
            string token = GetToken();

            string apiUrl = $"http://localhost:8080/api/urun/getir/{urunID}";
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            try
            {
                // API'den ürün bilgilerini al
                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string content = await response.Content.ReadAsStringAsync();
                    Urun urun = JsonConvert.DeserializeObject<Urun>(content);

                    // Ürün bilgilerini form elemanlarına yerleştir
                    txtUrunismi.Text = urun.urunAdi;
                    txtUrunFiyat.Text = urun.fiyat?.ToString("0.00");
                    txtUrunResim.Text = urun.resim;
                    txtStokAdet.Text = urun.stok.ToString();
                    ddlKategoriler.SelectedValue = urun.kategoriId;
                }
                else
                {
                    // Hata durumu
                    Response.Write("Ürün bilgileri alınırken hata oluştu.");
                }
            }
            catch (Exception ex)
            {
                // Hata loglama
                Response.Write($"Hata: {ex.Message}");
            }
        }
        private async void LoadCategories()
        {
            string token = GetToken();

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

        protected async void btnUrunGuncelle_Click(object sender, EventArgs e)
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
            string urunID = Request.QueryString["UrunID"];
            // API'ye gönder
            await UrunGuncelle(urun, urunID);
        }
        private async Task UrunGuncelle(object urunData, string id)
        {
            string token = GetToken();

            string apiUrl = $"http://localhost:8080/api/urun/guncelle/{id}"; // API URL'sini buraya yerleştirin

            // Token eklemek için Authorization başlığı ayarlanıyor
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            string jsonData = JsonConvert.SerializeObject(urunData);
            StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PutAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    // Başarılı olursa kullanıcıyı bilgilendir
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Başarılı!', 'Ürün başarıyla güncellendi.', 'success');", true);
                }
                else
                {
                    // Hata durumunda bilgilendirme
                    Console.WriteLine($"Hata: {response.StatusCode}");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Hata!', 'Ürün güncellenemedi.', 'error');", true);
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
