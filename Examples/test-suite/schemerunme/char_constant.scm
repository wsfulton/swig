;; Multicharacter constants have type int, not char.
(if (and (char? (CHAR-CONSTANT))
	 (string? (STRING-CONSTANT))
	 (= (MULTICHAR-AB) (imulti-ab)))
    (exit 0)
    (exit 1))
