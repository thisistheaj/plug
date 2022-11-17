/-  *plug
/=  styles  /app/pages/styles
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
    ;style: {styles}
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
++  store-page
  ^-  manx
  =/  store  (tail (rear (flop ~(tap by stores))))
  |^
  ;div
    ;+  (page-content content)
  ==
  ++  content
    ^-  manx
    ;div
      ;+  (store-hero store)
      ;h2: Products
      ;div.product-grid
        ;*  %+  turn  
          ~(tap by catalog.store)
          |=  product-pair=[id product]
          (product-card (tail product-pair))
      ==
    ==
  --
++  store-hero
  |=  =store
  ^-  manx
  ;div.preview-hero
    ;div.hero-avatar
      ;img(src avatar.store);
    ==
    ;div.preview-hero-content
      ;h1: {title.store}
      ;div.store-about-us
        ;p: {description.store}
      ==
    ==
  ==
++  product-card
  |=  =product
  ^-  manx
  ;div.product-card
    =style  "background-image: url('{(rear (flop images.product))}')"
    ;h4.product-title: {title.product}
    ;button.pure-button.view-product-button: View
  ==
:: Shared components
::
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
--