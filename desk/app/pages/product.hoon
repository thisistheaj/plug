::  global imports
::
/-  plug
::  sail imports
::
/=  styles  /app/components/styles
/=  page-content  /app/components/page-content
::  product page component
::
|=  [=bowl:gall store=store:plug product=product:plug]
|^  ^-  octs
%-  as-octs:mimes:html
%-  crip
%-  en-xml:html
^-  manx
:: Sail Page
::
;html
  ;head
    ;script(src "https://unpkg.com/@urbit/http-api");
    ;script(src "/session.js");
    ;link/"https://cdn.jsdelivr.net/npm/purecss@2.1.0/build/pure-min.css"(rel "stylesheet", crossorigin "anonymous", integrity "sha384-yHIFVG6ClnONEA5yB5DJXfW2/KC173DIQrYoZMEtBvGzmf0PKiGyNEqe9N6BNDBH");
    ;meta(charset "utf-8");
    ;style: {styles}
    ;script: {(snipcart api-key.store)}
    ;meta
      =name  "viewport"
      =content  "width=device-width, initial-scale=1";
  ==
  ;body
    ;div#app
      ;+  product-page
    ==
  ==
==
++  product-page
  ^-  manx
  |^
  ;div
    ;+  (page-content content)
  ==
  ++  content
    ^-  manx
    ;div
      ;+  store-header
      ;div.product-wrapper
        ;div.product-content.preview-mobile-title
          ;h1: {title.product}
        ==
        ;div.product-images-slider
          ;*  %+  turn  
            images.product
            |=  image=tape
            ^-  manx
            ;img(src image);
        ==
        ;div.product-content
          ;h1: {title.product}
          {description.product}
          ;h3
            ;+  ;/  "${(price price.product)}"
          ==
          ;button.pure-button.pure-button-primary.snipcart-add-item
            =data-item-id  "{<id.product>}"
            =data-item-price  "{(price price.product)}"
            =data-item-description  description.product
            =data-item-image  "{`tape`(head images.product)}"
            =data-item-name  title.product
            ; Add To Cart
          ==
        ==
      ==
    ==
  ++  price
    |=  n=@ud
    ^-  tape
    |^
    (insert-decimal (strip-dots (ud-to-tape n)))
    ++  insert-decimal
      |=  t=tape
      ^-  tape
      ?:  (gth (lent t) 2)
        `tape`(into t (sub (lent t) 2) '.')
      ?:  (gth (lent t) 1)
        "0.{t}"
      ?:  (gth (lent t) 0)
        "0.0{t}"
      "0.00"
    ++  strip-dots
      |=  t=tape
      ^-  tape
      %-  tail  
      %+  skid  
        t  
      |=(c=cord =(c '.'))
    ++  ud-to-tape
      |=  m=@ud
      ^-  tape
      "{<n>}"
    --
  --
++  store-header
  ^-  manx
  ;div.preview-header
    ;div.header-avatar
      ;img(src avatar.store);
    ==
    ;div.preview-header-title
      ;h1: {title.store}
    ==
  ==
++  snipcart
  |=  key=tape
  |^
    "{before}{key}{after}"
  ++  before
    %-  trip
    '''
      window.SnipcartSettings = {
        publicApiKey: "
    '''
  ++  after
    %-  trip
    '''
    ",
        loadStrategy: "on-user-interaction",
      };

      (()=>{var c,d;(d=(c=window.SnipcartSettings).version)!=null||(c.version="3.0");var s,S;(S=(s=window.SnipcartSettings).timeoutDuration)!=null||(s.timeoutDuration=2750);var l,p;(p=(l=window.SnipcartSettings).domain)!=null||(l.domain="cdn.snipcart.com");var w,u;(u=(w=window.SnipcartSettings).protocol)!=null||(w.protocol="https");var f=window.SnipcartSettings.version.includes("v3.0.0-ci")||window.SnipcartSettings.version!="3.0"&&window.SnipcartSettings.version.localeCompare("3.4.0",void 0,{numeric:!0,sensitivity:"base"})===-1,m=["focus","mouseover","touchmove","scroll","keydown"];window.LoadSnipcart=o;document.readyState==="loading"?document.addEventListener("DOMContentLoaded",r):r();function r(){window.SnipcartSettings.loadStrategy?window.SnipcartSettings.loadStrategy==="on-user-interaction"&&(m.forEach(t=>document.addEventListener(t,o)),setTimeout(o,window.SnipcartSettings.timeoutDuration)):o()}var a=!1;function o(){if(a)return;a=!0;let t=document.getElementsByTagName("head")[0],e=document.querySelector("#snipcart"),i=document.querySelector(`src[src^="${window.SnipcartSettings.protocol}://${window.SnipcartSettings.domain}"][src$="snipcart.js"]`),n=document.querySelector(`link[href^="${window.SnipcartSettings.protocol}://${window.SnipcartSettings.domain}"][href$="snipcart.css"]`);e||(e=document.createElement("div"),e.id="snipcart",e.setAttribute("hidden","true"),document.body.appendChild(e)),v(e),i||(i=document.createElement("script"),i.src=`${window.SnipcartSettings.protocol}://${window.SnipcartSettings.domain}/themes/v${window.SnipcartSettings.version}/default/snipcart.js`,i.async=!0,t.appendChild(i)),n||(n=document.createElement("link"),n.rel="stylesheet",n.type="text/css",n.href=`${window.SnipcartSettings.protocol}://${window.SnipcartSettings.domain}/themes/v${window.SnipcartSettings.version}/default/snipcart.css`,t.prepend(n)),m.forEach(g=>document.removeEventListener(g,o))}function v(t){!f||(t.dataset.apiKey=window.SnipcartSettings.publicApiKey,window.SnipcartSettings.addProductBehavior&&(t.dataset.configAddProductBehavior=window.SnipcartSettings.addProductBehavior),window.SnipcartSettings.modalStyle&&(t.dataset.configModalStyle=window.SnipcartSettings.modalStyle),window.SnipcartSettings.currency&&(t.dataset.currency=window.SnipcartSettings.currency),window.SnipcartSettings.templatesUrl&&(t.dataset.templatesUrl=window.SnipcartSettings.templatesUrl))}})();
    '''
  --
--