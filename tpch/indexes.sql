-- Foreign keys
ALTER TABLE nation   ADD CONSTRAINT fk_nation_region       FOREIGN KEY (n_regionkey)            REFERENCES region   (r_regionkey);
ALTER TABLE supplier ADD CONSTRAINT fk_supplier_nation     FOREIGN KEY (s_nationkey)            REFERENCES nation   (n_nationkey);
ALTER TABLE customer ADD CONSTRAINT fk_customer_nation     FOREIGN KEY (c_nationkey)            REFERENCES nation   (n_nationkey);
ALTER TABLE partsupp ADD CONSTRAINT fk_partsupp_part       FOREIGN KEY (ps_partkey)             REFERENCES part     (p_partkey);
ALTER TABLE partsupp ADD CONSTRAINT fk_partsupp_supplier   FOREIGN KEY (ps_suppkey)             REFERENCES supplier (s_suppkey);
ALTER TABLE orders   ADD CONSTRAINT fk_orders_customer     FOREIGN KEY (o_custkey)              REFERENCES customer (c_custkey);
ALTER TABLE lineitem ADD CONSTRAINT fk_lineitem_orders     FOREIGN KEY (l_orderkey)             REFERENCES orders   (o_orderkey);
ALTER TABLE lineitem ADD CONSTRAINT fk_lineitem_partsupp   FOREIGN KEY (l_partkey, l_suppkey)   REFERENCES partsupp (ps_partkey, ps_suppkey);

-- Performance indexes
CREATE INDEX idx_lineitem_shipdate        ON lineitem (l_shipdate);
CREATE INDEX idx_lineitem_returnflag      ON lineitem (l_returnflag, l_linestatus);
CREATE INDEX idx_orders_orderdate         ON orders   (o_orderdate);
CREATE INDEX idx_orders_custkey           ON orders   (o_custkey);
CREATE INDEX idx_partsupp_partkey         ON partsupp (ps_partkey);
CREATE INDEX idx_partsupp_suppkey         ON partsupp (ps_suppkey);
