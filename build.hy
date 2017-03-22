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
           <title>Kindle Clippings | Abhinav Tushar</title>
           <link rel=\"stylesheet\" href=\"tufte.css\"/>
           <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
         </head>")

(setv page-body-start
      "<body>
         <article>
           <h1>Kindle Clippings</h1>
           <p class=\"subtitle\">
             <a href=\"https://lepisma.github.io/about\">Abhinav Tushar</a></p>
           <section>
             <p>
                Hello, this is a <em>randomized</em> listing of lines I have
                highlighted in my Kindle.
                This page uses
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
