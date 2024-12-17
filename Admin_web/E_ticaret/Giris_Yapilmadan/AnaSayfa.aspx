<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnaSayfa.aspx.cs" Inherits="E_ticaret.Giris_Yapilmadan.AnaSayfa" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="utilities.css" />
    <link rel="stylesheet" href="styles.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
        integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/CSS/UrunlerSayfasi.css" />
    <link rel="stylesheet" type="text/css" href="/CSS/bootstrap.min.css" />
    <link href="https://cdn.lineicons.com/4.0/lineicons.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" />
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!-- Navbar -->
            <%--<section class="navbar">
                <div class="container flex">
                    <nav class="services">
                        <ul>
                            <li><a href="#"><img src="./images/getir-icons/getir-icon.svg" alt="getir" /></a></li>
                            <li><a href="#"><img src="./images/getir-icons/getir-food-icon.svg" alt="getir" /></a></li>
                            <li><a href="#"><img src="./images/getir-icons/getir-more-icon.svg" alt="getir" /></a></li>
                            <li><a href="#"><img src="./images/getir-icons/getir-water-icon.svg" alt="getir" /></a></li>
                            <li><a href="#"><img src="./images/getir-icons/getir-locals-icon.svg" alt="getir" /></a></li>
                        </ul>
                    </nav>
                    <nav class="login">
                        <ul>
                            <li><a class="btn btn-outline"><i class="fa-solid fa-globe fa-lg"></i><span>English (EN)</span></a></li>
                            <li><a class="btn btn-outline"><i class="fa-solid fa-user"></i><span>Login</span></a></li>
                            <li><a class="btn btn-outline"><i class="fa-solid fa-user-plus"></i><span>Sign Up</span></a></li>
                        </ul>
                    </nav>
                </div>
            </section>--%>
            <nav class="navbar navbar-expand-lg navbar-dark" id="navbarid">
                <div class="container-fluid">
                    <a class="navbar-brand" href="/Musteri/Urunler.aspx">Ana Sayfa</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <!-- ms-auto sınıfı sağa hizalamak için -->
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="Sepetim.aspx"><i class="bi bi-bag-check-fill"></i>Sepetim</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <section class="hero">
                <div class="slider">
                    <ul class="slides">
                        <li class="slide">
                            <img src="images/yemek.jpg" alt="hero" /></li>
                    </ul>
                </div>
                <div class="container flex">
                    <div class="hero-left">
                        <img src="./images/hero-getir.svg" alt="" />
                        <p class="">Dakikalar içindde kapında</p>
                    </div>
                    <div class="hero-form card centered">
                        <p>Giriş Yap</p>
                        <div class="telephone">

                            <div class="input-box">
                                <asp:TextBox ID="txtKullaniciAdi_giris" runat="server" placeholder="Kullanıcı Adı" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                            <div class="input-box">
                                <asp:TextBox ID="txtSifre_giris" runat="server" placeholder="Şifre" CssClass="form-control" Required="true" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>
                        <button class="btn btn-warning">Giriş Yap</button>
                    </div>
                </div>
            </section>

            <section class="categories" style="margin-top: 30px;">
                <div class="container">
                    <div class="grid">
                        <!-- Filled with jquery -->
                        <section class="favorites">
                            <div class="container">
                                <h4>Categories</h4>
                                <div class="row">
                                    <asp:Repeater ID="Repeater1" runat="server">
                                        <ItemTemplate>

                                            <div class="favorite-item col-6 col-sm-4 col-md-3 col-lg-2">

                                                <div class="product-img">
                                                    <img src='<%# Eval("KategoriResim") %>' alt='<%# Eval("KategoriAdi") %>' />
                                                </div>
                                                <div class="details">
                                                    <p class="name" style="font-size: 150%; text-align: center;"><%# Eval("KategoriAdi") %></p>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </section>

            <section class="promotions">
                <div class="kutu swiper" id="anasayfaslider">
                    <div class="slider-wrapper kampanya" id="slider-wrapper2">
                        <div class="card-list swiper-wrapper">
                            <asp:Repeater ID="Repeater3" runat="server">
                                <ItemTemplate>
                                    <div class="card-item swiper-slide" id="anasayfaslidercart">
                                        <asp:ImageButton ID="ImageButton1" runat="server"
                                            ImageUrl='<%# Eval("KampanyaResim") %>'
                                            CommandArgument='<%# Eval("KampanyaID") %>'
                                            OnClick="Kampanya_Click"
                                            CssClass="user-image anasayfaresim" />
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>
            </section>

            <section class="favorites">
                <div class="container">
                    <h4>Favorites</h4>
                    <div class="grid">
                        <asp:Repeater ID="Repeater2" runat="server">
                            <ItemTemplate>
                                <div class="favorite-item swiper-slide">
                                    <div class="bg-white" onclick="showProductModal('<%# Eval("Urun_Adi") %>', '<%# string.Format("{0:F2}", Eval("Urun_Fiyat")) %>', '<%# Eval("Urun_Aciklamasi") %>', '<%# Eval("Urun_Resmi") %>', event)">
                                        <div class="product-img">
                                            <img src="<%# Eval("Urun_Resmi") %>" alt="<%# Eval("Urun_Adi") %>">
                                        </div>
                                        <div class="details">
                                            <p class="name">
                                                <%# Eval("Urun_Adi") %>
                                                <asp:HiddenField ID="HiddenFieldUrunAdi" runat="server" Value='<%# Eval("Urun_Adi") %>' />
                                            </p>
                                            <p class="size">
                                                <%# Eval("Urun_Aciklamasi") %>
                                                <asp:HiddenField ID="HiddenFieldUrunAciklamasi" runat="server" Value='<%# Eval("Urun_Aciklamasi") %>' />
                                            </p>
                                            <div class="prices">
                                                <%# Eval("Eski_Fiyat") != DBNull.Value ? 
                                                $"<span class='old-price'>₺{string.Format("{0:F2}", Eval("Eski_Fiyat"))}</span>" : "" %>
                                                <span class="new-price">₺<%# string.Format("{0:F2}", Eval("Urun_Fiyat")) %></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                </div>
            </section>

            <section class="download">
                <div class="container">
                    <div class="bg-image flex">
                        <div class="left">
                            <h2>Download Getir!</h2>
                            <p>Let us deliver your order to your door in minutes.</p>
                            <div class="store flex">
                                <a href="#">
                                    <img src="./images/download/appstore.svg" alt="appstore" style="width: 160px; height: 100%;" /></a>
                                <a href="#">
                                    <img src="./images/download/googleplay.svg" alt="googleplay" style="width: 160px; height: 100%;" /></a>
                                <a href="#">
                                    <img src="./images/download/appgallery.svg" alt="huawei" style="width: 160px; height: 100%;" /></a>
                            </div>
                        </div>
                        <div class="right">
                            <img src="./images/download/download2.png" alt="" style="width: 100%;" />
                        </div>
                    </div>
                </div>
            </section>

            <section class="spot">
                <div class="container grid">
                    <div class="card flex centered">
                        <img src="./images/spot/spot1.svg" alt="" />
                        <p>A promotion for every order</p>
                        <p>At Getir, you can find a promotion for every order.</p>
                    </div>
                    <div class="card flex centered">
                        <img src="./images/spot/spot2.svg" alt="" />
                        <p>At your door in minutes</p>
                        <p>Your order is at your door in minutes with Getir.</p>
                    </div>
                    <div class="card flex centered">
                        <img src="./images/spot/spot3.svg" alt="" />
                        <p>Thousand kinds of happiness</p>
                        <p>At Getir, you can choose from thousands of varieties.</p>
                    </div>
                </div>
            </section>

            <section class="footer">
                <div class="container">
                    <div class="links grid">
                        <div class="flex">
                            <p>Download Getir!</p>
                            <a href="#">
                                <img src="./images/download/appstore.svg" alt="appstore" style="width: 160px; height: 100%;" /></a>
                            <a href="#">
                                <img src="./images/download/googleplay.svg" alt="googleplay" style="width: 160px; height: 100%;" /></a>
                            <a href="#">
                                <img src="./images/download/appgallery.svg" alt="huawei" style="width: 160px; height: 100%;" /></a>
                        </div>
                        <div class="flex">
                            <p>Information</p>
                            <ul>
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">Careers</a></li>
                                <li><a href="#">Contact Us</a></li>
                                <li><a href="#">Terms and Conditions</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                            </ul>
                        </div>
                        <div class="flex">
                            <p>Follow Us</p>
                            <ul>
                                <li><a href="#">
                                    <img src="./images/icons/facebook.svg" alt="facebook" /></a></li>
                                <li><a href="#">
                                    <img src="./images/icons/twitter.svg" alt="twitter" /></a></li>
                                <li><a href="#">
                                    <img src="./images/icons/instagram.svg" alt="instagram" /></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="bottom">
                        <p>&copy; 2024 Getir. All rights reserved.</p>
                    </div>
                </div>
            </section>
        </div>

        <div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="productModalLabel">Ürün Detayları</h5>
                        <button type="button" class="close" onclick="closeProductModal()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Ürün bilgileri burada dinamik olarak yüklenecek -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeProductModal()">Kapat</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>

            function closeProductModal() {
                $('#productModal').modal('hide');
            }
            function showProductModal(productName, productPrice, productDescription, productImage, event) {
                // Eğer tıklanan öğe bir checkbox ise, modalın açılmasını engelle
                if (event.target.type === 'checkbox' || event.target.closest('.custom-checkbox')) {
                    event.stopPropagation(); // Event propagation'ı durdur
                    return;
                }

                // Modal başlığını güncelle
                document.getElementById('productModalLabel').innerText = productName;

                // Modal içeriğini güncelle
                var modalBody = document.querySelector('#productModal .modal-body');
                modalBody.innerHTML = `
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <img src="${productImage}" class="img-fluid" alt="${productName}">
                        </div>
                        <div class="col-md-6">
                            <h5 class="mt-3">₺${productPrice}</h5>
                            <p>${productDescription}</p>
                        </div>
                    </div>
                </div>
                `;

                // Modalı göster
                $('#productModal').modal('show');
            }


            function initializeSwiper() {
                const swiper = new Swiper('.kampanya', {
                    loop: true,
                    grabCursor: true,
                    spaceBetween: 30,
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
                        dynamicBullets: true
                    },
                    breakpoints: {
                        0: {
                            slidesPerView: 1
                        },
                        768: {
                            slidesPerView: 2
                        },
                        1024: {
                            slidesPerView: 3
                        }
                    },
                    simulateTouch: window.innerWidth <= 768, // 768px ve altındaki ekranlarda kaydırmayı aktif tut
                    touchStartPreventDefault: false, // Dokunmatik ekranlarda varsayılan davranışları engelleme
                    autoplay: {
                        delay: 3000, // Otomatik kaydırma süresi (milisaniye cinsinden)
                        disableOnInteraction: false, // Kullanıcı müdahalesinden sonra otomatik kaydırmanın devam etmesini sağlar
                    }
                });
            }

            document.addEventListener('DOMContentLoaded', function () {
                initializeSwiper();
            });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                initializeSwiper();
            });

        </script>
    </form>
</body>
</html>
