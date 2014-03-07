;
; Perri: Experimental SQL DSL in Hy
;

(import itertools)

(defn-alias [perri-first p-first] [coll]
  (p-nth coll 0))

(defn-alias [perri-second p-second] [coll]
  (-> coll rest first))

(defn-alias [perri-rest p-rest] [coll]
  (itertools.islice coll 1 None))

(defn-alias [perri-nth p-nth] [coll index &optional default]
  (if (not (neg? index))
    (next (itertools.islice coll index None) default)
    default))

(defn sep-by-comma [items]
  (.join ", " items))

(defn expand-select [columns clauses]
  (+ "SELECT"
     " "
     (if (string? columns) columns (sep-by-comma columns))
     (expand-clauses clauses)))

(defn expand-from [tables clauses]
  (+ " "
     "FROM"
     " "
     (if (string? tables) tables (sep-by-comma tables))
     (if (empty? clauses) "" (expand-clauses clauses))))

(defn expand-where [exprs clauses]
  (+ " "
     "WHERE"
     " "
     (str exprs)))

(def clause-map {'SELECT expand-select
                 'FROM expand-from
                 'WHERE expand-where})

(defn expand-clauses [clauses]
  (print "-----")
  (print "clauses: " clauses)
  (let [[func (get clause-map (-> clauses p-first p-first))]
        [args (-> clauses p-first p-second)]
        [next-clauses (list (p-rest clauses))]]
    (print "func: " func)
    (print "args: " args (type args))
    (print "next: " next-clauses (type next-clauses))
    (func args next-clauses)))

(defmacro SELECT [columns &rest clauses]
  (+ (expand-clauses (cons ['SELECT columns] clauses))
     ";"))
