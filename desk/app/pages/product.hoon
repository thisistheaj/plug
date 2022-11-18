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
          ;button.pure-button.pure-button-primary
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
--