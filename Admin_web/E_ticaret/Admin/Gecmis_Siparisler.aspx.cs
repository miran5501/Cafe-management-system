using E_ticaret.classlar;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_ticaret.Admin
{
    public partial class Gecmis_Siparisler : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi
        protected async void Page_Load(object sender, EventArgs e)
        {
            await LoadSiparisler();
        }

        // API'den siparişleri yükleyen yöntem
        private async Task LoadSiparisler()
        {
            string token = GetToken();
            string apiUrl = "http://localhost:8080/api/gecmis-masa/getir";
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            try
            {

                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string jsonData = await response.Content.ReadAsStringAsync();
                    var siparisler = JsonConvert.DeserializeObject<List<GecmisMasa>>(jsonData);
                    // Repeater'a veri bağlama
                    Repeater1.DataSource = siparisler;
                    Repeater1.DataBind();
                }
                else
                {

                }

            }
            catch (Exception ex)
            {

            }
        }

        // Sipariş Detayları butonuna tıklama işlemi
        protected void BtnSepetDetay_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string siparisID = btn.CommandArgument;
            Response.Redirect($"Siparis_Detay.aspx?SiparisID={siparisID}",false);
            Context.ApplicationInstance.CompleteRequest();
        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }
    }
    public class Masa_ekle
    {
        public string id {  get; set; }
        public string alanId { get; set; }

        public string masaAdi { get; set; }
    }

    public class Alan
    {
        public string id { get; set; }

        public string alanIsmi { get; set; }
    }

    // GecmisMasa Modeli
    public class GecmisMasa
    {
        public string id { get; set; }
        public string masaId { get; set; }
        public decimal? toplamTutar { get; set; }
        public DateTime? masaMusteriGelmeTarihi { get; set; }
        public DateTime? masaMusteriGitmeTarihi { get; set; }
        public List<GecmisMasaIcerik> gecmisMasaIcerikList { get; set; }
    }

    // GecmisMasaIcerik Modeli
    public class GecmisMasaIcerik
    {
        public string id { get; set; }
        public Urun urun { get; set; }
        public DateTime? urunEklenmeTarihi { get; set; }
        public long? urunAdet { get; set; }
        public DateTime? urunKaldirilmaTarihi { get; set; }
        public bool? odenmeDurumu { get; set; }
    }

    // Urun Modeli
    public class Urun
    {
        public string id { get; set; }
        public string urunAdi { get; set; }
        public decimal? fiyat { get; set; }
        public long? stok { get; set; }
        public string kategoriId { get; set; }

        public string resim { get; set; }
    }
}
