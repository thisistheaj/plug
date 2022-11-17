/-  *plug
|=  [=bowl:gall =stores]
|^  ^-  octs
%-  as-octs:mimes:html
%-  crip
%-  en-xml:html
^-  manx
:: HTML PAGE
::
;html
  ;head
    ;script(src "https://unpkg.com/@urbit/http-api");
    ;script(src "/session.js");
    ;link/"https://cdn.jsdelivr.net/npm/purecss@2.1.0/build/pure-min.css"(rel "stylesheet", crossorigin "anonymous", integrity "sha384-yHIFVG6ClnONEA5yB5DJXfW2/KC173DIQrYoZMEtBvGzmf0PKiGyNEqe9N6BNDBH");
    ;meta(charset "utf-8");
    ;style: {style}
    ;meta
      =name  "viewport"
      =content  "width=device-width, initial-scale=1";
  ==
  ;body
    ;div#app
      ;+  store-page
    ==
  ==
==
:: CSS STYLES
::
++  store-page
  ^-  manx
  |^
  ;div
    ;+  (page-content content)
  ==
  ++  content
    ^-  manx
    ;div
      ;+  store-hero
      ;h2: Products
      ;div.product-grid
        ;+  product-card
        ;+  product-card
        ;+  product-card
        ;+  product-card
        ;+  product-card
      ==
    ==
  --
++  page-content
  |=  content=manx
  ^-  manx
    ;div.pure-g
      ;div.pure-u-1-12.mobile-hide;
      ;div.pure-u-5-6.mobile-hide
        ;+  content
      ==         
      ;div.pure-u-5-6.desktop-hide
        ;+  content
      ==         
      ;div.pure-u-1-12.mobile-hide;          
    ==
++  store-hero
  ^-  manx
  ;div.preview-hero
    ;div.hero-avatar
      ;img@"http://random.imagecdn.app/150/150";
    ==
    ;div.preview-hero-content
      ;h1: AJs Cool Store
      ;div.store-about-us
        We are a cool Store where you can buy things
      ==
    ==
  ==
++  store-header
  ^-  manx
  ;div.preview-header
    ;div.header-avatar
      ;img@"http://random.imagecdn.app/150/150";
    ==
    ;div.preview-header-title
      ;h1: AJs Cool Store
    ==
  ==
++  product-card
  ^-  manx
  ;div.product-card
    =style  "background-image: url('http://random.imagecdn.app/360/360')"
    ;h4.product-title: First Product
    ;button.pure-button.view-product-button: View
  ==
++  style
  ^~
  %-  trip
    '''
      .navbar {
        background: #666;
      }
      .navbar .plug-menu-link {
        color: #fff;
      }
      .navbar .plug-menu-link:hover {
        background: #444;
      }
      .nav-right {
        /*text-align: right;*/
      }
      .pad-bottom {
        margin: 0 0 12px 0;
      }
      /* image input */
      .plug-image-input {
        position: relative;
        width: 150px;
      }
      .plug-image-input-button {
        position: absolute;
        right: 8px;
        bottom: 8px;
      }
      /* Product Table Styles */
      .checkbox-field {
        text-align: center;
      }
      /* Alt Button Styles */
      .pure-button.button-danger {
        background-color: rgb(202, 60, 60);
        color: #fff;
      }
      .pure-button.button-secondary {
        background-color: background: rgb(66, 184, 221);
        color: #fff;
      }
      .pure-button.button-warning {
        background-color: rgb(223, 117, 20);
        color: #fff;
      }
      /* Product card */
      .product-card {
        position: relative;
        width: 150px;
        height: 200px;
        background-size: cover;
        /* positioning in grid */
        float: left;
        margin-right: 12px;
      }
      .product-title {
        position: absolute;
        margin: 0;
        background: rgba(256,256,256,0.4);
        top: 0px;
        left: 0px;
        right: 0px;
        padding-top: 4px;
        padding-left: 4px;
      }
      .view-product-button {
        position: absolute;
        margin: 0;
        bottom: 8px;
        right: 8px;
      }
      /* store preview hero */
      .preview-hero {
        margin-top: 48px;
        display: flex;
      }
      .hero-avatar {
        width: 150px;
        height: 150px;
        border-radius: 75px;
        overflow: hidden;
        margin-right: 12px;
      }
      .hero-avatar img {
        width: 100%;
      }
      .preview-hero-content {
        width: calc(100% - 160px);
      }
      /* store preview header */
      .preview-header {
        margin-top: 8px;
        padding-bottom: 8px;
        display: flex;
        border-bottom: solid 4px #444;
      }
      .header-avatar {
        width: 36px;
        height: 36px;
        border-radius: 18px;
        overflow: hidden;
        margin-right: 12px;
      }
      .preview-header-title h1 {
        margin: 0;
      }
      /* Product Page */
      .product-wrapper {
        margin-top: 48px;
        display: flex;
      }
      .product-images-slider {
        width: 50%;
        padding: 12px;
      }
      .product-images-slider img {
        width: 100%;
      }
      .product-content {
        width: 35%;
        padding: 12px;
        position: fixed;
        right: 8.3%;
      }
      .preview-mobile-title {
        padding: 12px;
        display: none;
      }
      .preview-mobile-title h1 {
        margin: 0 12px;
      }
      @media (max-width: 760px) {
        .product-wrapper {
          display: block;
        }
        .product-images-slider {
          width: calc(100% - 24px);
        }
        .product-content {
          width: calc(100% - 24px);
          position: unset;
          margin-bottom: 48px;
        }
        .preview-mobile-title {
          display: unset;
        }
      }
      .end-preview-button {
        position: fixed;
        bottom: 12px;
        right: 12px;
      }
      .back-button {
        position: fixed;
        bottom: 12px;
        left: 12px;
      }
      .desktop-hide {
        display: none;
      }
      @media (max-width: 760px) {
        .mobile-hide {
          display: none;
        }
        .desktop-hide {
          display: unset;
        }
      }   
    '''
--