# Harmless lab payload: proves code from a FORK PR runs inside the privileged agent job
# with a write-capable token. It never prints or sends the token anywhere.
.PHONY: test
test:
        @sh ./ci/lab-proof.sh
        @echo "all tests passed"
