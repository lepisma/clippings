#!/usr/bin/env hy

(import [os [path]])
(import [yaml [load]])

(setv highlights-file "highlights")
(setv index-file "index.html")

(setv page-header
      "<!DOCTYPE html>
       <html lang=\"en\">
         <head>
           <meta charset=\"utf-8\"/>
           <title>Clippings | Abhinav Tushar</title>
           <link rel=\"stylesheet\" href=\"tufte.css\"/>
           <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
           <link rel=\"apple-touch-icon-precomposed\" sizes=\"57x57\" href=\"https://lepisma.github.io/assets/images/favicons/apple-touch-icon-57x57.png\" />
           <link rel=\"apple-touch-icon-precomposed\" sizes=\"114x114\" href=\"https://lepisma.github.io/assets/images/favicons/apple-touch-icon-114x114.png\" />
           <link rel=\"apple-touch-icon-precomposed\" sizes=\"72x72\" href=\"https://lepisma.github.io/assets/images/favicons/apple-touch-icon-72x72.png\" />
           <link rel=\"apple-touch-icon-precomposed\" sizes=\"144x144\" href=\"https://lepisma.github.io/assets/images/favicons/apple-touch-icon-144x144.png\" />
           <link rel=\"apple-touch-icon-precomposed\" sizes=\"60x60\" href=\"https://lepisma.github.io/assets/images/favicons/apple-touch-icon-60x60.png\" />
           <link rel=\"apple-touch-icon-precomposed\" sizes=\"120x120\" href=\"https://lepisma.github.io/assets/images/favicons/apple-touch-icon-120x120.png\" />
           <link rel=\"apple-touch-icon-precomposed\" sizes=\"76x76\" href=\"https://lepisma.github.io/assets/images/favicons/apple-touch-icon-76x76.png\" />
           <link rel=\"apple-touch-icon-precomposed\" sizes=\"152x152\" href=\"https://lepisma.github.io/assets/images/favicons/apple-touch-icon-152x152.png\" />
           <link rel=\"icon\" type=\"image/png\" href=\"https://lepisma.github.io/assets/images/favicons/favicon-196x196.png\" sizes=\"196x196\" />
           <link rel=\"icon\" type=\"image/png\" href=\"https://lepisma.github.io/assets/images/favicons/favicon-96x96.png\" sizes=\"96x96\" />
           <link rel=\"icon\" type=\"image/png\" href=\"https://lepisma.github.io/assets/images/favicons/favicon-32x32.png\" sizes=\"32x32\" />
           <link rel=\"icon\" type=\"image/png\" href=\"https://lepisma.github.io/assets/images/favicons/favicon-16x16.png\" sizes=\"16x16\" />
           <link rel=\"icon\" type=\"image/png\" href=\"https://lepisma.github.io/assets/images/favicons/favicon-128.png\" sizes=\"128x128\" />
           <meta name=\"application-name\" content=\"&nbsp;\"/>
           <meta name=\"msapplication-TileColor\" content=\"#FFFFFF\" />
           <meta name=\"msapplication-TileImage\" content=\"https://lepisma.github.io/assets/images/favicons/mstile-144x144.png\" />
           <meta name=\"msapplication-square70x70logo\" content=\"https://lepisma.github.io/assets/images/favicons/mstile-70x70.png\" />
           <meta name=\"msapplication-square150x150logo\" content=\"https://lepisma.github.io/assets/images/favicons/mstile-150x150.png\" />
           <meta name=\"msapplication-wide310x150logo\" content=\"https://lepisma.github.io/assets/images/favicons/mstile-310x150.png\" />
           <meta name=\"msapplication-square310x310logo\" content=\"https://lepisma.github.io/assets/images/favicons/mstile-310x310.png\" />
         </head>")

(setv page-body-start
      "<body>
         <article>
           <h1>Clippings</h1>
           <p class=\"subtitle\">
             <a href=\"https://lepisma.github.io/about\">Abhinav Tushar</a></p>
           <section>
             <p><em>This list now lives <a href=\"https://lepisma.github.io/pile/readings/books\"></here></em></p>
             <p>
                Hello, this is a <em>randomized</em> listing of clippings from
                my readings. This page uses
                <a href=\"https://edwardtufte.github.io/tufte-css/\">tufte-css</a>.
                Source is
                <a href=\"https://github.com/lepisma/kindle-highlights\">here</a>.
             </p>
           </section>
           <section>
             <div class=\"epigraph\">")

(setv page-items [])

(setv page-body-end
      "      </div>
           </section>
         </article>
         <script src=\"reorder.js\">
         </script>
       </body></html>")

(with [fi (open highlights-file)]
      (let [items (load fi)]
        (for [item items]
          (.append
           page-items
           (+ "<blockquote>"
                "<p>" (second item) "</p>"
                "<footer>" (first item) "</footer>"
              "</blockquote>")))))

(with [fo (open index-file "w")]
      (.write fo page-header)
      (.write fo page-body-start)
      (for [page-item page-items]
        (.write fo page-item))
      (.write fo page-body-end))
