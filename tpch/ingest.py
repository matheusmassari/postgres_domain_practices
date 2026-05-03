import time
import psycopg
from pathlib import Path

CONN = "host=localhost port=54321 dbname=tpch_practice_db user=admin password=admin123"

DATASETS_DIR = Path(__file__).parent.parent / "datasets" / "tpch"

# Order respects dependency chain: referenced tables before referencing ones
TABLES = [
    "region",
    "nation",
    "part",
    "supplier",
    "partsupp",
    "customer",
    "orders",
    "lineitem",
]


def load_table(cur: psycopg.Cursor, table: str) -> None:
    filepath = DATASETS_DIR / f"{table}.tbl"
    with cur.copy(f"COPY {table} FROM STDIN WITH (FORMAT text, DELIMITER '|')") as copy:
        with open(filepath) as f:
            for line in f:
                # .tbl files have a trailing pipe that must be stripped before COPY
                copy.write(line.rstrip("|\n") + "\n")


def main() -> None:
    with psycopg.connect(CONN) as conn:
        for table in TABLES:
            print(f"Loading {table}...", end=" ", flush=True)
            start = time.perf_counter()
            with conn.cursor() as cur:
                load_table(cur, table)
            conn.commit()
            elapsed = time.perf_counter() - start
            print(f"done ({elapsed:.1f}s)")


if __name__ == "__main__":
    main()
