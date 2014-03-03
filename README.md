Perri
=====

Experimental SQL DSL in Hy

Examples
--------

```
=> (SELECT c1 (FROM t1))
u'SELECT c1 FROM t1;'
```

```
=> (SELECT [c1 c2] (FROM t1))
u'SELECT c1, c2 FROM t1;'
```

```
=> (SELECT [t1.c1 t2.c2] (FROM [t1 t2]))
u'SELECT t1.c1, t2.c2 FROM t1, t2;'
```
