#!/usr/bin/env hy

(import [os [path]])
(import [eep [Searcher]])
(import [sys [argv]])
(import yaml)

(def mounts-path "/proc/mounts")

(setv files-to-look-in (cdr argv))

;; Look for mounted kindle
(with [fi (open mounts-path)]
      (let [s (Searcher (.read fi))]
        (if (.search_forward s "Kindle")
          (.append
           files-to-look-in
           (do
            (setv end s.point)
            (.search_backward s " ")
            (path.join
             (.get_sub s :end end)
             "documents"
             "My Clippings.txt")))
          (print "Kindle not connected"))))

(defn read-highlights [text]
  (map (fn [x] (.strip x))
       (butlast (.split text "=========="))))

(defn read-props [high]
  (let [splits (.splitlines high)]
    (tuple
     [(first splits)
      (last splits)
      (last (.split (second splits) " | "))])))

(defn read-data [text]
  (let [highs (read-highlights text)]
    (map read-props highs)))

;; Read over
(setv highlights [])

(with [fi (open "highlights")]
      (.extend highlights (yaml.load fi)))

(.reverse highlights)

(def old-count (len highlights))

(print (+ "Got " (str old-count) " old highlights"))

(for [file files-to-look-in]
  (with [fi (open file)]
        (.extend highlights (read-data (.read fi)))))

(.reverse highlights)
(setv highlights (list (distinct highlights)))
(print (+ "Adding "
          (str (- (len highlights) old-count))
          " new ones"))

(with [fo (open "highlights" "w")]
      (yaml.dump highlights fo))
