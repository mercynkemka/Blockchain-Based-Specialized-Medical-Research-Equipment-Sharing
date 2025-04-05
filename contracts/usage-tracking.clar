;; Usage Tracking Contract
;; Monitors equipment utilization and research outcomes

;; Define data variables
(define-map usage-records
  { booking-id: (string-ascii 36) }
  {
    equipment-id: (string-ascii 36),
    user: principal,
    start-time: uint,
    end-time: uint,
    outcome: (optional (string-utf8 500))
  }
)

;; Define error codes
(define-constant err-not-authorized u1)
(define-constant err-not-found u2)
(define-constant err-already-exists u3)

;; Record usage
(define-public (record-usage
    (booking-id (string-ascii 36))
    (equipment-id (string-ascii 36))
    (start-time uint)
    (end-time uint))
  (let ((exists (map-get? usage-records { booking-id: booking-id })))
    (asserts! (is-none exists) (err err-already-exists))

    (ok (map-set usage-records
      { booking-id: booking-id }
      {
        equipment-id: equipment-id,
        user: tx-sender,
        start-time: start-time,
        end-time: end-time,
        outcome: none
      }
    ))
  )
)

;; Record research outcome
(define-public (record-outcome
    (booking-id (string-ascii 36))
    (outcome (string-utf8 500)))
  (let ((record (map-get? usage-records { booking-id: booking-id })))
    (asserts! (is-some record) (err err-not-found))
    (asserts! (is-eq tx-sender (get user (unwrap! record (err err-not-found)))) (err err-not-authorized))

    (ok (map-set usage-records
      { booking-id: booking-id }
      (merge (unwrap! record (err err-not-found))
        { outcome: (some outcome) }
      )
    ))
  )
)

;; Get usage record
(define-read-only (get-usage (booking-id (string-ascii 36)))
  (let ((record (map-get? usage-records { booking-id: booking-id })))
    (asserts! (is-some record) (err err-not-found))
    (ok (unwrap! record (err err-not-found)))
  )
)
