;; Equipment Registry Contract
;; Manages the registration and details of specialized medical research equipment

;; Define data variables
(define-data-var admin principal tx-sender)

;; Simple equipment registry map
(define-map equipments
  { id: (string-ascii 36) }
  {
    name: (string-ascii 100),
    owner: principal,
    available: bool,
    maintenance-date: uint
  }
)

;; Define error codes
(define-constant err-not-authorized u1)
(define-constant err-not-found u2)
(define-constant err-already-exists u3)

;; Register new equipment
(define-public (register-equipment
    (id (string-ascii 36))
    (name (string-ascii 100)))
  (let ((exists (map-get? equipments { id: id })))
    (asserts! (is-none exists) (err err-already-exists))

    (ok (map-set equipments
      { id: id }
      {
        name: name,
        owner: tx-sender,
        available: true,
        maintenance-date: block-height
      }
    ))
  )
)

;; Update equipment availability
(define-public (update-availability (id (string-ascii 36)) (available bool))
  (let ((equipment (map-get? equipments { id: id })))
    (asserts! (is-some equipment) (err err-not-found))
    (asserts! (is-eq tx-sender (get owner (unwrap! equipment (err err-not-found)))) (err err-not-authorized))

    (ok (map-set equipments
      { id: id }
      (merge (unwrap! equipment (err err-not-found)) { available: available })
    ))
  )
)

;; Get equipment details
(define-read-only (get-equipment (id (string-ascii 36)))
  (let ((equipment (map-get? equipments { id: id })))
    (asserts! (is-some equipment) (err err-not-found))
    (ok (unwrap! equipment (err err-not-found)))
  )
)

;; Transfer equipment ownership
(define-public (transfer-ownership (id (string-ascii 36)) (new-owner principal))
  (let ((equipment (map-get? equipments { id: id })))
    (asserts! (is-some equipment) (err err-not-found))
    (asserts! (is-eq tx-sender (get owner (unwrap! equipment (err err-not-found)))) (err err-not-authorized))

    (ok (map-set equipments
      { id: id }
      (merge (unwrap! equipment (err err-not-found)) { owner: new-owner })
    ))
  )
)
