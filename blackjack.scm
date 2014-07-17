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

(define enemy 2)
(define hand 14)
(define stock 7)
(define waste 6)

(define (new-game)
  (initialize-playing-area)
  (set-ace-high)

  (make-standard-deck)
  (shuffle-deck)
  
  (add-blank-slot)
  (add-blank-slot)
  (add-normal-slot '() 'enemy)
  (add-blank-slot)
  (add-blank-slot)
  (add-blank-slot)
  (add-carriage-return-slot)

  (add-normal-slot '() 'waste)
  (add-normal-slot DECK 'stock)
  (add-blank-slot)
  (add-blank-slot)
  (add-blank-slot)
  (add-blank-slot)
  (add-carriage-return-slot)

  (add-blank-slot)
  (add-blank-slot)
  (add-normal-slot '() 'hand)
  (add-blank-slot)
  (add-blank-slot)
  (add-blank-slot)

  (list 6 3)
)

(define (button-pressed slot-id card-list) #f)

(define (droppable? start-slot card-list end-slot) #f )

(define (button-released start-slot card-list end-slot) #f)

(define (button-clicked slot-id)  #f)

(define (button-double-clicked slot-id)  #f)

(define (game-continuable) #t)

(define (game-won) #f)

(define (get-hint)
  (list 0 (_"Place cards on to the Tableau to form poker hands")))

(define (get-options)
  (list (list (_"Shuffle mode") #f)))

(define (apply-options options) #t)

(define (timeout)  #f)

(set-features droppable-feature)

(set-lambda new-game button-pressed button-released button-clicked
button-double-clicked game-continuable game-won get-hint get-options
apply-options timeout droppable?)
