;
; Perri: Experimental SQL DSL in Hy
;

(defn sep-by-comma [items]
  (.join ", " items))

(defn expand-select [columns clauses]
  (+ "SELECT"
     " "
     (sep-by-comma columns)
     (expand-clause clauses)))

(defn expand-from [tables]
  (+ " "
     "FROM"
     " "
     (if (string? tables) tables (sep-by-comma tables))))

(def clause-map {'SELECT expand-select
                 'FROM expand-from})

(defn expand-clause [clauses]
  (apply (get clause-map (car clauses)) (cdr clauses)))

(defmacro SELECT [&rest clauses]
  (+ (expand-clause (cons 'SELECT clauses))
     ";"))
