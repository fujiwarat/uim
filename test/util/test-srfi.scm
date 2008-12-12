;;; Copyright (c) 2003-2008 uim Project http://code.google.com/p/uim/
;;;
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;; 1. Redistributions of source code must retain the above copyright
;;;    notice, this list of conditions and the following disclaimer.
;;; 2. Redistributions in binary form must reproduce the above copyright
;;;    notice, this list of conditions and the following disclaimer in the
;;;    documentation and/or other materials provided with the distribution.
;;; 3. Neither the name of authors nor the names of its contributors
;;;    may be used to endorse or promote products derived from this software
;;;    without specific prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
;;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE
;;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;;; OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;;; LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;;; OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;;; SUCH DAMAGE.
;;;

(define-module test.util.test-srfi
  (use test.unit.test-case)
  (use test.uim-test))
(select-module test.util.test-srfi)

(define (setup)
  (uim-test-setup)
  (uim '(define lst '(1 "2" three (4) 5 six "7" (8 8) -9)))
  (uim '(define lst2 '(1 "2" three (4) 5 six "7" (8 8) -9 #f 11 #f "13")))
  (uim '(define lst3 '("1" "2" "three")))
  (uim '(define lst4 '(1 2 3)))
  (uim '(define lst5 '(1 #f 3 "four")))
  (uim '(define lst6 '(#f #f)))
  (uim '(define lst7 '(#f #f #f)))
  (uim '(define alist-int '((23 "23" twentythree)
                            (1 "1" one)
                            (5 "5" five)
                            (3 "3" three))))
  (uim '(define alist-str '(("23" 23 twentythree)
                            ("1" 1 one)
                            ("5" 5 five)
                            ("3" 3 three))))
  (uim '(define alist-lst '((("23") 23 twentythree)
                            (("1") 1 one)
                            (("5") 5 five)
                            (("3") 3 three))))
  (uim '(define alist-sym '((twentythree "23" 23)
                            (one "1" 1)
                            (five "5" 5)
                            (three "3" 3)))))

(define (teardown)
  (uim-test-teardown))

(define (test-list-tabulate)
  (assert-uim-equal '()
                    '(list-tabulate 0 (lambda (x) x)))
  (assert-uim-equal '(0)
                    '(list-tabulate 1 (lambda (x) x)))
  (assert-uim-equal '(0 1 2 3 4)
                    '(list-tabulate 5 (lambda (x) x)))
  (assert-uim-equal '(0 1 4 9 16)
                    '(list-tabulate 5 (lambda (x) (* x x))))
  (assert-uim-error '(list-tabulate -1 (lambda (x) x)))
  #f)

(define (test-make-list)
  (assert-uim-equal '(fill fill fill)
                    '(make-list 3 'fill))
  (assert-uim-equal '(0 0 0)
                    '(make-list 3 0))
  (assert-uim-equal '("string" "string" "string")
                    '(make-list 3 "string"))
  (assert-uim-equal '((fill "fill") (fill "fill") (fill "fill"))
                    '(make-list 3 '(fill "fill")))
  (assert-uim-equal '(() () ())
                    '(make-list 3 ()))
  (assert-uim-equal '(())
                    '(make-list 1 ()))
  (assert-uim-equal '()
                    '(make-list 0 ()))
  (assert-uim-equal '()
                    '(make-list 0 'fill))
  (assert-uim-error '(make-list -1 'fill))
  #f)

(define (test-iota)
  (assert-uim-equal '()
                    '(iota 0))
  (assert-uim-equal '(0)
                    '(iota 1))
  (assert-uim-equal '(0 1 2 3 4)
                    '(iota 5))
  (assert-uim-error '(iota -1))

  (assert-uim-equal '()
                    '(iota 0 0))
  (assert-uim-equal '(0)
                    '(iota 1 0))
  (assert-uim-equal '(0 1 2 3 4)
                    '(iota 5 0))
  (assert-uim-error '(iota -1 0))

  (assert-uim-equal '()
                    '(iota 0 1))
  (assert-uim-equal '(1)
                    '(iota 1 1))
  (assert-uim-equal '(1 2 3 4 5)
                    '(iota 5 1))
  (assert-uim-error '(iota -1 1))

  (assert-uim-equal '(3)
                    '(iota 1 3))
  (assert-uim-equal '(3 4 5 6 7)
                    '(iota 5 3))
  (assert-uim-error '(iota -1 3))

  (assert-uim-equal '(5 6 7 8 9)
                    '(iota 5 5))
  #f)

(define (test-zip)
  (assert-uim-equal '((1) (2) (3) (4) (5))
                    '(zip '(1 2 3 4 5)))
  (assert-uim-equal '((1 "1" one) (2 "2" two) (3 "3" three)
                      (4 "4" four) (5 "5" five))
                    '(zip '(1 2 3 4 5)
                           '("1" "2" "3" "4" "5")
                           '(one two three four five)))
  (assert-uim-equal '((1 "1" one) (2 "2" two) (3 "3" three))
                    '(zip '(1 2 3 4 5)
                           '("1" "2" "3" "4" "5")
                           '(one two three)))
  (assert-uim-equal '()
                    '(zip '()
                           '("1" "2" "3" "4" "5")
                           '(one two three)))
  (assert-uim-equal '()
                    '(zip '()))
  #f)

(define (test-append-map)
  (assert-uim-equal '()
                    '(append-map car '()))
  (assert-uim-equal '(c)
                    '(append-map car '(((c) (C)))))
  (assert-uim-equal '(c a)
                    '(append-map car '(((c) (C)) ((a) (A)))))
  (assert-uim-equal '(c a r)
                    '(append-map car '(((c) (C)) ((a) (A)) ((r) (R)))))
  #f)

(define (test-append-reverse)
  (assert-uim-equal '("5" "4" "3" "2" "1" six seven eight)
                    '(append-reverse '("1" "2" "3" "4" "5")
                                      '(six seven eight)))
  (assert-uim-equal '(six seven eight)
                    '(append-reverse '()
                                     '(six seven eight)))
  (assert-uim-equal '("5" "4" "3" "2" "1")
                    '(append-reverse '("1" "2" "3" "4" "5")
                                     '()))
  (assert-uim-equal '()
                    '(append-reverse '()
                                     '()))
  #f)

(define (test-find)
  (assert-uim-equal "2"
                    '(find string? lst))
  (assert-uim-equal 'three
                    '(find symbol? lst))
  (assert-uim-equal #f
                    '(find string? '()))
  (assert-uim-equal -9
                    '(find (lambda (x)
                             (and (integer? x)
                                  (< x 0)))
                           lst))
  #f)

(define (test-any)
  (assert-uim-true  '(any string? lst))
  (assert-uim-true  '(any string? lst2))
  (assert-uim-true  '(any string? lst3))
  (assert-uim-false '(any string? lst4))
  (assert-uim-true  '(any proc-or lst2))
  (assert-uim-false '(any proc-or lst6))
  (assert-uim-true  '(any proc-or lst2 lst6))
  (assert-uim-true  '(any proc-or lst6 lst2))
  (assert-uim-false '(any proc-or lst6 lst7))
  (assert-uim-true  '(any proc-or lst5 lst6 lst7))
  (assert-uim-false '(any string? '()))
  #f)

(define (test-every)
  (assert-uim-false '(every string? lst))
  (assert-uim-false '(every string? lst2))
  (assert-uim-true  '(every string? lst3))
  (assert-uim-false '(every string? lst4))
  (assert-uim-true  '(every proc-or lst))
  (assert-uim-false '(every proc-or lst2))
  (assert-uim-false '(every proc-or lst6))
  (assert-uim-true  '(every proc-or lst2 lst6))
  (assert-uim-true  '(every proc-or lst6 lst2))
  (assert-uim-false '(every proc-or lst6 lst7))
  (assert-uim-true  '(every proc-or lst4 lst6 lst7))
  (assert-uim-false '(every proc-or lst5 lst6 lst7))
  (assert-uim-true  '(every string? '()))
  #f)

(define (test-fold)
  (assert-uim-equal '()
                    '(fold cons '() '()))
  (assert-uim-equal '(5 4 3 2 1)
                    '(fold cons '() '(1 2 3 4 5)))
  (assert-uim-equal '(1 2 3 4 5 6 7 8 9)
                    '(fold cons '(6 7 8 9) '(5 4 3 2 1)))
  (assert-uim-equal '(9 8 7 6 5 4 3 2 1)
                    '(fold cons '(5 4 3 2 1) '(6 7 8 9)))
  (assert-uim-equal 24
                    '(fold + 0 '(1 2 3 4 5) '(1 2 1 2 3)))
  (assert-uim-equal 9
                    '(fold + 0 '(1 2 3 4 5) '(1 2 1 2 3) '(7)))
  (assert-uim-equal 0
                    '(fold + 0 '(1 2 3 4 5) '() '(1 2 1 2 3)))
  (assert-uim-equal 120
                    '(fold * 1 '(1 2 3 4 5)))
  (assert-uim-equal 14400
                    '(fold * 1 '(1 2 3 4 5) '(1 2 3 4 5)))
  #f)

(define (test-unfold)
  ;; immediate term
  (assert-uim-equal '()
                    '(unfold (lambda (x)
                               (= x 5))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (- rest 1))
                             5))
  (assert-uim-equal '(5)
                    '(unfold (lambda (x)
                               (= x 5))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (- rest 1))
                             5
                             (lambda (rest)
                               (list rest))))
  (assert-uim-equal '(-1)
                    '(unfold (lambda (x)
                                (= x 5))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (- rest 1))
                             5
                             (lambda (rest)
                               '(-1))))
  ;; 5 times
  (assert-uim-equal '(5 4 3 2 1)
                    '(unfold (lambda (x)
                               (= x 0))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (- rest 1))
                             5))
  (assert-uim-equal '(5 4 3 2 1 0)
                    '(unfold (lambda (x)
                                (= x 0))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (- rest 1))
                             5
                             (lambda (x)
                               (list x))))
  (assert-uim-equal '(5 4 3 2 1 -1)
                    '(unfold (lambda (x)
                               (= x 0))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (- rest 1))
                             5
                             (lambda (x)
                               '(-1))))
  ;; 5 times, reversed
  (assert-uim-equal '(0 1 2 3 4)
                    '(unfold (lambda (x)
                                (= x 5))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (+ rest 1))
                              0))
  (assert-uim-equal '(0 1 2 3 4 5)
                    '(unfold (lambda (x)
                               (= x 5))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (+ rest 1))
                             0
                             (lambda (x)
                               (list x))))
  (assert-uim-equal '(0 1 2 3 4 -1)
                    '(unfold (lambda (x)
                               (= x 5))
                             (lambda (rest)
                               rest)
                             (lambda (rest)
                               (+ rest 1))
                             0
                             (lambda (x)
                               '(-1))))
  ;; restruct same list
  (assert-uim-equal '(0 1 2 3 4 5)
                    '(unfold null?
                             car
                             cdr
                             '(0 1 2 3 4 5)))
  (assert-uim-equal '(0 1 2 3 4 5)
                    '(unfold null?
                             car
                             cdr
                             '(0 1 2 3 4 5)
                             (lambda (x)
                               x)))
  (assert-uim-equal '(0 1 2 3 4 5 . -1)
                    '(unfold null?
                             car
                             cdr
                             '(0 1 2 3 4 5)
                             (lambda (x)
                               -1)))
  #f)

(define (test-filter)
  (assert-uim-equal '()
                    '(filter not '()))
  (assert-uim-equal '(5 6 4)
                    '(filter (lambda (x)
                               (< 3 x))
                             '(3 5 2 6 4 1)))
  (assert-uim-equal '("2" "7")
                    '(filter string?
                             '(one "2" 3 #f (5) six "7" 8 (9) 10)))
  (assert-uim-equal '(3 8 10)
                    '(filter integer?
                             '(one "2" 3 #f (5) six "7" 8 (9) 10)))
  #f)

(define (test-filter-map)
  ;; single list
  (assert-uim-equal '()
                    '(filter-map not '()))
  (assert-uim-equal '(5 6 4)
                    '(filter-map (lambda (x)
                                   (and (< 3 x)
                                        x))
                                 '(3 5 2 6 4 1)))
  (assert-uim-equal '(10 12 8)
                    '(filter-map (lambda (x)
                                   (and (< 3 x)
                                        (* 2 x)))
                                 '(3 5 2 6 4 1)))
  (assert-uim-equal (uim '(list (string? "") (string? "")))
                    '(filter-map string?
                                 '(one "2" 3 #f (5) six "7" 8 (9) 10)))
  (assert-uim-equal (uim '(list (integer? 0) (integer? 0) (integer? 0)))
                    '(filter-map integer?
                                 '(one "2" 3 #f (5) six "7" 8 (9) 10)))
  ;; multiple lists
  (assert-uim-equal '()
                    '(filter-map +
                                 '()
                                 '()))
  (assert-uim-equal '(8 11 10 8)
                    '(filter-map (lambda (x y)
                                   (let ((sum (+ x y)))
                                     (and (< 6 sum)
                                          sum)))
                                 '(3 5 2 6 4 1)
                                 '(1 3 9 4 2 7)))
  (assert-uim-equal '()
                    '(filter-map (lambda (x y)
                                   (let ((sum (+ x y)))
                                     (and (< 6 sum)
                                          sum)))
                                 '()
                                 '(1 3 9 4 2 7)))
  (assert-uim-equal '(8 11 10)
                    '(filter-map (lambda (x y)
                                   (let ((sum (+ x y)))
                                     (and (< 6 sum)
                                          sum)))
                                 '(3 5 2 6 4 1)
                                 '(1 3 9 4)))
  (assert-uim-equal '("aAa1" "bBb2" "cCc3" "dDd4")
                    '(filter-map string-append
                                 '("a" "b" "c" "d")
                                 '("A" "B" "C" "D")
                                 '("a" "b" "c" "d")
                                 '("1" "2" "3" "4" "5")))
  #f)

(define (test-remove)
  (assert-uim-equal '(1 three (4) 5 six (8 8) -9)
                    '(remove string? lst))
  (assert-uim-equal '("2" three (4) six "7" (8 8))
                    '(remove integer? lst))
  (assert-uim-equal '("2" three (4) six "7" (8 8) -9)
                    '(remove (lambda (x)
                               (and (integer? x)
                                    (> x 0)))
                             lst))
  (assert-uim-equal '()
                    '(remove string? '()))
  (assert-uim-equal '()
                    '(remove string? '("1" "2")))
  #f)

(define (test-alist-delete)
  (assert-uim-equal '((23 "23" twentythree)
                      (1 "1" one)
                      (5 "5" five))
                    '(alist-delete 3 alist-int))
  (assert-uim-equal '((23 "23" twentythree)
                      (1 "1" one)
                      (5 "5" five)
                      (3 "3" three))
                    '(alist-delete 0 alist-int))
  (assert-uim-equal '((1 "1" one)
                      (5 "5" five)
                      (3 "3" three))
                    '(alist-delete 23 alist-int))
  (assert-uim-equal '((23 "23" twentythree)
                      (1 "1" one)
                      (5 "5" five)
                      (3 "3" three))
                    '(alist-delete "3" alist-int))
  (assert-uim-equal '(("23" 23 twentythree)
                      ("1" 1 one)
                      ("3" 3 three))
                    '(alist-delete "5" alist-str))
  (assert-uim-error '(alist-delete "5" alist-str =))
  (assert-uim-equal '(("23" 23 twentythree)
                      ("1" 1 one)
                      ("5" 5 five)
                      ("3" 3 three))
                    '(alist-delete "5" alist-str eqv?))
  (assert-uim-equal '(("23" 23 twentythree)
                      ("1" 1 one)
                      ("3" 3 three))
                    '(alist-delete "5" alist-str string=?))
  (assert-uim-equal '((("1") 1 one)
                      (("5") 5 five)
                      (("3") 3 three))
                    '(alist-delete '("23") alist-lst))
  (assert-uim-equal '((("1") 1 one)
                      (("5") 5 five)
                      (("3") 3 three))
                    '(alist-delete '("23") alist-lst equal?))
  (assert-uim-equal '((twentythree "23" 23)
                      (five "5" 5)
                      (three "3" 3))
                    '(alist-delete 'one alist-sym))
  (assert-uim-equal '((twentythree "23" 23)
                      (one "1" 1)
                      (five "5" 5))
                    '(alist-delete 'three alist-sym eq?))
  #f)

(provide "test/util/test-srfi")
