(ns clojure-lib-template.core-test
  (:require [clojure.test :as t :refer [deftest is]]
            [clojure-lib-template.core :as c]))

(deftest my-function-test
  (is (= "hello" (c/my-function "hello")))
  (is (= 3 (c/my-function 3))))

