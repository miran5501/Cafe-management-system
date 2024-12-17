using E_ticaret.classlar;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System;
using System.Data.SqlClient;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace E_ticaret.Admin
{
    public partial class Urunleri_Yonet : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient(); // HTTP istemcisi
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUrunler();            
            }
        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }

        protected void BtnUrunGuncelle_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string UrunID = btn.CommandArgument;

            Response.Redirect($"Urun_Guncelle.aspx?UrunID={UrunID}");
        }


        private async void LoadUrunler()
        {

            string Token = GetToken();
            string apiUrl = $"http://localhost:8080/api/urun/getir";
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", Token);

            try
            {
                // API'den ürün bilgilerini al
                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string content = await response.Content.ReadAsStringAsync();
                    var urunler = JsonConvert.DeserializeObject<List<Urun>>(content);

                    // Verileri Repeater'a bağla
                    Repeater1.DataSource = urunler;
                    Repeater1.DataBind();
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
    }
}
