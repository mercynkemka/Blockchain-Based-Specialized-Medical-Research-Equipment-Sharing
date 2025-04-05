;; Scheduling Contract
;; Manages equipment sharing schedules

;; Define data variables
(define-map bookings
  { id: (string-ascii 36) }
  {
    equipment-id: (string-ascii 36),
    user: principal,
    start-time: uint,
    end-time: uint,
    status: (string-ascii 20)
  }
)

;; Define error codes
(define-constant err-not-authorized u1)
(define-constant err-not-found u2)
(define-constant err-already-exists u3)
(define-constant err-invalid-time u4)

;; Book equipment
(define-public (book-equipment
    (booking-id (string-ascii 36))
    (equipment-id (string-ascii 36))
    (start-time uint)
    (end-time uint))
  (let ((exists (map-get? bookings { id: booking-id })))
    (asserts! (is-none exists) (err err-already-exists))
    (asserts! (> end-time start-time) (err err-invalid-time))
    (asserts! (> start-time block-height) (err err-invalid-time))

    (ok (map-set bookings
      { id: booking-id }
      {
        equipment-id: equipment-id,
        user: tx-sender,
        start-time: start-time,
        end-time: end-time,
        status: "confirmed"
      }
    ))
  )
)

;; Cancel booking
(define-public (cancel-booking (booking-id (string-ascii 36)))
  (let ((booking (map-get? bookings { id: booking-id })))
    (asserts! (is-some booking) (err err-not-found))
    (asserts! (is-eq tx-sender (get user (unwrap! booking (err err-not-found)))) (err err-not-authorized))

    (ok (map-set bookings
      { id: booking-id }
      (merge (unwrap! booking (err err-not-found)) { status: "cancelled" })
    ))
  )
)

;; Get booking details
(define-read-only (get-booking (booking-id (string-ascii 36)))
  (let ((booking (map-get? bookings { id: booking-id })))
    (asserts! (is-some booking) (err err-not-found))
    (ok (unwrap! booking (err err-not-found)))
  )
)
