(ns yowsa.quotes)


(def quotes (atom nil))

(defn init [] 
  (let [y   (slurp "yow.lines")
        ys  (clojure.string/split y #"\000")
        ys  (drop 1 ys)]
    (reset! quotes ys)))


(defn get-quote [] (rand-nth @quotes))

