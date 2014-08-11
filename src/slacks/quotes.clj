(ns slacks.quotes)


(def quotes (atom nil))
(def token (atom nil))

(defn init [] 
  (let [y   (slurp "LINES")
        ys  (clojure.string/split y #"\000")
        ys  (drop 1 ys)
        t   (slurp "TOKEN")]
    (println "Read" (count ys) "lines and token" t)
    (reset! quotes ys)
    (reset! token t)))


(defn get-quote [] (rand-nth @quotes))

(defn request-ok? [params] (= (:token params) @token))

