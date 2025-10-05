import sys, requests

def main(url: str):
    try:
        r = requests.get(url, timeout=5)
        if r.status_code == 200:
            print("HEALTHCHECK: OK")
            return 0
        print(f"HEALTHCHECK: BAD STATUS {r.status_code}")
        return 1
    except Exception as e:
        print(f"HEALTHCHECK: ERROR {e}")
        return 1

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python scripts/healthcheck.py http://localhost:5000/healthz")
        sys.exit(2)
    sys.exit(main(sys.argv[1]))
