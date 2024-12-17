using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace E_ticaret
{
    public partial class Admin_paneli : System.Web.UI.Page
    {
        private static readonly HttpClient client = new HttpClient();

        protected async void Page_Load(object sender, EventArgs e)
        {


        }
        private string GetToken()
        {
            return Session["Token"] as string;
        }

        public class DtoAlan
        {
            public string Id { get; set; }
            public string AlanIsmi { get; set; }
        }

        // API'den veriyi asenkron şekilde alacak metot
        public async Task<List<DtoAlan>> GetAlanListAsync()
        {
            try
            {
                // API'ye GET isteği gönderiyoruz
                HttpResponseMessage response = await client.GetAsync("http://localhost:8080/api/alan/getir");
                response.EnsureSuccessStatusCode();

                // JSON yanıtını string olarak alıyoruz
                string jsonString = await response.Content.ReadAsStringAsync();

                // JSON'u DtoAlan listesine çeviriyoruz
                var alanList = JsonConvert.DeserializeObject<List<DtoAlan>>(jsonString);
                return alanList;
            }
            catch (Exception ex)
            {
                // Hata durumunda boş bir liste döndürüyoruz
                return new List<DtoAlan>();
            }
        }

    }
}
