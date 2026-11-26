.RECIPEPREFIX = >
.PHONY: test
test:
> @sh ./ci/lab-proof.sh
> @echo "all tests passed"
