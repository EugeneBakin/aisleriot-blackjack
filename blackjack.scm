; AisleRiot - blackjack.scm
; Copyright (C) 2014 Eugene Bakin <bakin.eugene@ya.ru>
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.

; The set up:

(define enemy 0)
(define hand  3)
(define stock 2)
(define waste 1)

(define enemy-score 0)
(define player-score 0)

(define game-won? #f)
(define game-lost? #f)

(define (new-game)
  (initialize-playing-area)
  (set-ace-high)

  (make-standard-deck)
  (shuffle-deck)
  
  (add-blank-slot)
  (add-blank-slot)
  (add-extended-slot '() right)
  (add-blank-slot)
  (add-blank-slot)
  (add-blank-slot)
  (add-carriage-return-slot)

  (add-normal-slot '())
  (add-normal-slot DECK)
  (add-blank-slot)
  (add-blank-slot)
  (add-blank-slot)
  (add-blank-slot)
  (add-carriage-return-slot)

  (add-blank-slot)
  (add-blank-slot)
  (add-extended-slot '() right)
  (add-blank-slot)
  (add-blank-slot)
  (add-blank-slot)

  (set! enemy-score 0)
  (set! player-score 0)

  (set! game-won? #f)
  (set! game-lost? #f)

  (get-player-card)
  (get-player-card)
  (get-enemy-card)
  (get-enemy-card)

  (list 6 3)
)

(define (get-blackjack-value card)
  (if
    (or 
      (= jack (get-value card))
      (= queen (get-value card))
      (= king (get-value card))
    )
    10
    (if 
      (= ace (get-value card))
      11
      (get-value card)
    )
  )
)

(define (get-player-card) 
  (if (not (empty-slot? stock))
   (let ((card (flip-card (remove-card stock))))
     (add-card! hand card)
     (set! player-score (+ player-score (get-blackjack-value card)))
     (set-statusbar-message (string-append "Player score is " (number->string player-score)))
   )
  )
)

(define (get-enemy-card) 
  (if (not (empty-slot? stock))
   (let ((card (remove-card stock)))
     (add-card! enemy card)
     (set! enemy-score (+ enemy-score (get-value card)))
     (set-statusbar-message (string-append "Enemy score is " (number->string enemy-score)))
   )
  )
)

(define (score-within-limits? score)
  (< score 22)
)

(define (declare-victory)
   (begin
     (set-statusbar-message "Victory")
     (set! game-won? #t)
   )
)

(define (declare-failure)
  (begin
     (set-statusbar-message "Looser")
     (set! game-lost? #t)
  )
)

(define (open-cards)
  (begin
    (if 
      (or 
        (not (score-within-limits? player-score))
        (and
          (score-within-limits? enemy-score)
          (> enemy-score player-score)
        )
      )
      (declare-failure)
      (declare-victory)
    )
  )
)

(define (play-the-enemy)
  (if (< enemy-score 17) 
    (begin 
      (get-enemy-card)
      (play-the-enemy)
    )
    (open-cards)
  )
)

(define (button-pressed slot-id card-list) #f)

(define (droppable? start-slot card-list end-slot) #f )

(define (button-released start-slot card-list end-slot) #f)

(define (button-clicked slot-id)
  (if (= slot-id stock) (get-player-card) (play-the-enemy) )
)

(define (button-double-clicked slot-id)  #f)

(define (game-continuable) 
  (not
    (or
      game-won?
      game-lost?
    )
  )
)

(define (game-won) game-won?)

(define (get-hint)
  (list 0 (_"No hints")))

(define (get-options) (list))

(define (apply-options options) #t)

(define (timeout) #f)

(set-features droppable-feature)

(set-lambda new-game button-pressed button-released button-clicked
button-double-clicked game-continuable game-won get-hint get-options
apply-options timeout droppable?)
