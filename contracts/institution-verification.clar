;; Institution Verification Contract
;; Validates legitimate research entities

;; Define data variables
(define-data-var admin principal tx-sender)

;; Simple institutions map
(define-map institutions
  { id: principal }
  {
    name: (string-ascii 100),
    verified: bool,
    score: uint
  }
)

;; Define error codes
(define-constant err-not-authorized u1)
(define-constant err-not-found u2)
(define-constant err-already-exists u3)

;; Check if caller is admin
(define-private (is-admin)
  (is-eq tx-sender (var-get admin))
)

;; Verify a new institution
(define-public (verify-institution
    (institution principal)
    (name (string-ascii 100)))
  (let ((exists (map-get? institutions { id: institution })))
    (asserts! (is-admin) (err err-not-authorized))
    (asserts! (is-none exists) (err err-already-exists))

    (ok (map-set institutions
      { id: institution }
      {
        name: name,
        verified: true,
        score: u100
      }
    ))
  )
)

;; Check if an institution is verified
(define-read-only (is-verified (institution principal))
  (let ((inst (map-get? institutions { id: institution })))
    (if (is-some inst)
      (get verified (unwrap! inst false))
      false
    )
  )
)

;; Update institution status
(define-public (update-status (institution principal) (verified bool))
  (let ((inst (map-get? institutions { id: institution })))
    (asserts! (is-admin) (err err-not-authorized))
    (asserts! (is-some inst) (err err-not-found))

    (ok (map-set institutions
      { id: institution }
      (merge (unwrap! inst (err err-not-found)) { verified: verified })
    ))
  )
)

;; Get institution details
(define-read-only (get-institution (institution principal))
  (let ((inst (map-get? institutions { id: institution })))
    (asserts! (is-some inst) (err err-not-found))
    (ok (unwrap! inst (err err-not-found)))
  )
)
