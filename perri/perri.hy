;
; Perri: Experimental SQL DSL in Hy
;

(import itertools)

(defn first [coll]
  (nth coll 0))

(defn rest [coll]
  (itertools.islice coll 1 None))

(defn nth [coll index &optional default]
  (if (not (neg? index))
    (next (itertools.islice coll index None) default)
    default))

(defn sep-by-comma [items]
  (if (string? items)
    (items)
    (.join ", " items)))

(defn expand-select [columns clauses]
  (+ "SELECT"
     " "
     (sep-by-comma columns)
     (expand-clause clauses)))

(defn expand-from [tables clauses]
  (+ " "
     "FROM"
     " "
     (sep-by-comma tables)
     (expand-clause clauses)))

(defn expand-where [exprs clauses]
  "")

(def clause-map {'SELECT expand-select
                 'FROM expand-from
                 'WHERE expand-where})

(defn expand-clause [clauses]
  (let [[func (get clause-map (-> clauses first first))]
        [args (-> clauses first rest)]
        [next-clauses (rest clauses)]]
    (print "-----")
    (print "clauses: " clauses)
    (print "func: " func ", " (type func))
    (print "args: " (list args) ", " (type (list args)))
    (print "next: " (list next-clauses) ", " (type (list next-clauses)))
    (func (list args) (list next-clauses))))

(defmacro SELECT [columns &rest clauses]
  (+ (expand-clause (cons (cons 'SELECT columns) clauses))
     ";"))
