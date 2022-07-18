################################
# ta-add-nnbn

images: ta-add-nnbn.img
ta-add-nnbn.img: $T/src/ta-add-nnbn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-nnbn.S -o ta-add-nnbn.img
	$T/checkbin.sh ta-add-nnbn.img

run-tests: ta-add-nnbn.diff
ta-add-nnbn.diff: ta-add-nnbn.log $T/good/ta-add-nnbn.good
	diff -u $T/good/ta-add-nnbn.good ta-add-nnbn.log > ta-add-nnbn.diff || true
ta-add-nnbn.log: $(SYS161) ta-add-nnbn.img
	$(SYS161) $(SYS161FLAGS) ta-add-nnbn.img 2>&1 | $T/cleanlog.sh > ta-add-nnbn.log

good: ta-add-nnbn.good
ta-add-nnbn.good:
	cp ta-add-nnbn.log $T/good/ta-add-nnbn.good

.PHONY: ta-add-nnbn.good

################################
# ta-add-nngn

images: ta-add-nngn.img
ta-add-nngn.img: $T/src/ta-add-nngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-nngn.S -o ta-add-nngn.img
	$T/checkbin.sh ta-add-nngn.img

run-tests: ta-add-nngn.diff
ta-add-nngn.diff: ta-add-nngn.log $T/good/ta-add-nngn.good
	diff -u $T/good/ta-add-nngn.good ta-add-nngn.log > ta-add-nngn.diff || true
ta-add-nngn.log: $(SYS161) ta-add-nngn.img
	$(SYS161) $(SYS161FLAGS) ta-add-nngn.img 2>&1 | $T/cleanlog.sh > ta-add-nngn.log

good: ta-add-nngn.good
ta-add-nngn.good:
	cp ta-add-nngn.log $T/good/ta-add-nngn.good

.PHONY: ta-add-nngn.good

################################
# ta-add-npgn

images: ta-add-npgn.img
ta-add-npgn.img: $T/src/ta-add-npgn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-npgn.S -o ta-add-npgn.img
	$T/checkbin.sh ta-add-npgn.img

run-tests: ta-add-npgn.diff
ta-add-npgn.diff: ta-add-npgn.log $T/good/ta-add-npgn.good
	diff -u $T/good/ta-add-npgn.good ta-add-npgn.log > ta-add-npgn.diff || true
ta-add-npgn.log: $(SYS161) ta-add-npgn.img
	$(SYS161) $(SYS161FLAGS) ta-add-npgn.img 2>&1 | $T/cleanlog.sh > ta-add-npgn.log

good: ta-add-npgn.good
ta-add-npgn.good:
	cp ta-add-npgn.log $T/good/ta-add-npgn.good

.PHONY: ta-add-npgn.good

################################
# ta-add-npgp

images: ta-add-npgp.img
ta-add-npgp.img: $T/src/ta-add-npgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-npgp.S -o ta-add-npgp.img
	$T/checkbin.sh ta-add-npgp.img

run-tests: ta-add-npgp.diff
ta-add-npgp.diff: ta-add-npgp.log $T/good/ta-add-npgp.good
	diff -u $T/good/ta-add-npgp.good ta-add-npgp.log > ta-add-npgp.diff || true
ta-add-npgp.log: $(SYS161) ta-add-npgp.img
	$(SYS161) $(SYS161FLAGS) ta-add-npgp.img 2>&1 | $T/cleanlog.sh > ta-add-npgp.log

good: ta-add-npgp.good
ta-add-npgp.good:
	cp ta-add-npgp.log $T/good/ta-add-npgp.good

.PHONY: ta-add-npgp.good

################################
# ta-add-pngn

images: ta-add-pngn.img
ta-add-pngn.img: $T/src/ta-add-pngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-pngn.S -o ta-add-pngn.img
	$T/checkbin.sh ta-add-pngn.img

run-tests: ta-add-pngn.diff
ta-add-pngn.diff: ta-add-pngn.log $T/good/ta-add-pngn.good
	diff -u $T/good/ta-add-pngn.good ta-add-pngn.log > ta-add-pngn.diff || true
ta-add-pngn.log: $(SYS161) ta-add-pngn.img
	$(SYS161) $(SYS161FLAGS) ta-add-pngn.img 2>&1 | $T/cleanlog.sh > ta-add-pngn.log

good: ta-add-pngn.good
ta-add-pngn.good:
	cp ta-add-pngn.log $T/good/ta-add-pngn.good

.PHONY: ta-add-pngn.good

################################
# ta-add-pngp

images: ta-add-pngp.img
ta-add-pngp.img: $T/src/ta-add-pngp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-pngp.S -o ta-add-pngp.img
	$T/checkbin.sh ta-add-pngp.img

run-tests: ta-add-pngp.diff
ta-add-pngp.diff: ta-add-pngp.log $T/good/ta-add-pngp.good
	diff -u $T/good/ta-add-pngp.good ta-add-pngp.log > ta-add-pngp.diff || true
ta-add-pngp.log: $(SYS161) ta-add-pngp.img
	$(SYS161) $(SYS161FLAGS) ta-add-pngp.img 2>&1 | $T/cleanlog.sh > ta-add-pngp.log

good: ta-add-pngp.good
ta-add-pngp.good:
	cp ta-add-pngp.log $T/good/ta-add-pngp.good

.PHONY: ta-add-pngp.good

################################
# ta-add-ppbp

images: ta-add-ppbp.img
ta-add-ppbp.img: $T/src/ta-add-ppbp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-ppbp.S -o ta-add-ppbp.img
	$T/checkbin.sh ta-add-ppbp.img

run-tests: ta-add-ppbp.diff
ta-add-ppbp.diff: ta-add-ppbp.log $T/good/ta-add-ppbp.good
	diff -u $T/good/ta-add-ppbp.good ta-add-ppbp.log > ta-add-ppbp.diff || true
ta-add-ppbp.log: $(SYS161) ta-add-ppbp.img
	$(SYS161) $(SYS161FLAGS) ta-add-ppbp.img 2>&1 | $T/cleanlog.sh > ta-add-ppbp.log

good: ta-add-ppbp.good
ta-add-ppbp.good:
	cp ta-add-ppbp.log $T/good/ta-add-ppbp.good

.PHONY: ta-add-ppbp.good

################################
# ta-add-ppgp

images: ta-add-ppgp.img
ta-add-ppgp.img: $T/src/ta-add-ppgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-ppgp.S -o ta-add-ppgp.img
	$T/checkbin.sh ta-add-ppgp.img

run-tests: ta-add-ppgp.diff
ta-add-ppgp.diff: ta-add-ppgp.log $T/good/ta-add-ppgp.good
	diff -u $T/good/ta-add-ppgp.good ta-add-ppgp.log > ta-add-ppgp.diff || true
ta-add-ppgp.log: $(SYS161) ta-add-ppgp.img
	$(SYS161) $(SYS161FLAGS) ta-add-ppgp.img 2>&1 | $T/cleanlog.sh > ta-add-ppgp.log

good: ta-add-ppgp.good
ta-add-ppgp.good:
	cp ta-add-ppgp.log $T/good/ta-add-ppgp.good

.PHONY: ta-add-ppgp.good

################################
# ta-add-uubu

images: ta-add-uubu.img
ta-add-uubu.img: $T/src/ta-add-uubu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-uubu.S -o ta-add-uubu.img
	$T/checkbin.sh ta-add-uubu.img

run-tests: ta-add-uubu.diff
ta-add-uubu.diff: ta-add-uubu.log $T/good/ta-add-uubu.good
	diff -u $T/good/ta-add-uubu.good ta-add-uubu.log > ta-add-uubu.diff || true
ta-add-uubu.log: $(SYS161) ta-add-uubu.img
	$(SYS161) $(SYS161FLAGS) ta-add-uubu.img 2>&1 | $T/cleanlog.sh > ta-add-uubu.log

good: ta-add-uubu.good
ta-add-uubu.good:
	cp ta-add-uubu.log $T/good/ta-add-uubu.good

.PHONY: ta-add-uubu.good

################################
# ta-add-uugu

images: ta-add-uugu.img
ta-add-uugu.img: $T/src/ta-add-uugu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-add-uugu.S -o ta-add-uugu.img
	$T/checkbin.sh ta-add-uugu.img

run-tests: ta-add-uugu.diff
ta-add-uugu.diff: ta-add-uugu.log $T/good/ta-add-uugu.good
	diff -u $T/good/ta-add-uugu.good ta-add-uugu.log > ta-add-uugu.diff || true
ta-add-uugu.log: $(SYS161) ta-add-uugu.img
	$(SYS161) $(SYS161FLAGS) ta-add-uugu.img 2>&1 | $T/cleanlog.sh > ta-add-uugu.log

good: ta-add-uugu.good
ta-add-uugu.good:
	cp ta-add-uugu.log $T/good/ta-add-uugu.good

.PHONY: ta-add-uugu.good

################################
# ta-addi-nnbn

images: ta-addi-nnbn.img
ta-addi-nnbn.img: $T/src/ta-addi-nnbn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-nnbn.S -o ta-addi-nnbn.img
	$T/checkbin.sh ta-addi-nnbn.img

run-tests: ta-addi-nnbn.diff
ta-addi-nnbn.diff: ta-addi-nnbn.log $T/good/ta-addi-nnbn.good
	diff -u $T/good/ta-addi-nnbn.good ta-addi-nnbn.log > ta-addi-nnbn.diff || true
ta-addi-nnbn.log: $(SYS161) ta-addi-nnbn.img
	$(SYS161) $(SYS161FLAGS) ta-addi-nnbn.img 2>&1 | $T/cleanlog.sh > ta-addi-nnbn.log

good: ta-addi-nnbn.good
ta-addi-nnbn.good:
	cp ta-addi-nnbn.log $T/good/ta-addi-nnbn.good

.PHONY: ta-addi-nnbn.good

################################
# ta-addi-nngn

images: ta-addi-nngn.img
ta-addi-nngn.img: $T/src/ta-addi-nngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-nngn.S -o ta-addi-nngn.img
	$T/checkbin.sh ta-addi-nngn.img

run-tests: ta-addi-nngn.diff
ta-addi-nngn.diff: ta-addi-nngn.log $T/good/ta-addi-nngn.good
	diff -u $T/good/ta-addi-nngn.good ta-addi-nngn.log > ta-addi-nngn.diff || true
ta-addi-nngn.log: $(SYS161) ta-addi-nngn.img
	$(SYS161) $(SYS161FLAGS) ta-addi-nngn.img 2>&1 | $T/cleanlog.sh > ta-addi-nngn.log

good: ta-addi-nngn.good
ta-addi-nngn.good:
	cp ta-addi-nngn.log $T/good/ta-addi-nngn.good

.PHONY: ta-addi-nngn.good

################################
# ta-addi-npgn

images: ta-addi-npgn.img
ta-addi-npgn.img: $T/src/ta-addi-npgn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-npgn.S -o ta-addi-npgn.img
	$T/checkbin.sh ta-addi-npgn.img

run-tests: ta-addi-npgn.diff
ta-addi-npgn.diff: ta-addi-npgn.log $T/good/ta-addi-npgn.good
	diff -u $T/good/ta-addi-npgn.good ta-addi-npgn.log > ta-addi-npgn.diff || true
ta-addi-npgn.log: $(SYS161) ta-addi-npgn.img
	$(SYS161) $(SYS161FLAGS) ta-addi-npgn.img 2>&1 | $T/cleanlog.sh > ta-addi-npgn.log

good: ta-addi-npgn.good
ta-addi-npgn.good:
	cp ta-addi-npgn.log $T/good/ta-addi-npgn.good

.PHONY: ta-addi-npgn.good

################################
# ta-addi-npgp

images: ta-addi-npgp.img
ta-addi-npgp.img: $T/src/ta-addi-npgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-npgp.S -o ta-addi-npgp.img
	$T/checkbin.sh ta-addi-npgp.img

run-tests: ta-addi-npgp.diff
ta-addi-npgp.diff: ta-addi-npgp.log $T/good/ta-addi-npgp.good
	diff -u $T/good/ta-addi-npgp.good ta-addi-npgp.log > ta-addi-npgp.diff || true
ta-addi-npgp.log: $(SYS161) ta-addi-npgp.img
	$(SYS161) $(SYS161FLAGS) ta-addi-npgp.img 2>&1 | $T/cleanlog.sh > ta-addi-npgp.log

good: ta-addi-npgp.good
ta-addi-npgp.good:
	cp ta-addi-npgp.log $T/good/ta-addi-npgp.good

.PHONY: ta-addi-npgp.good

################################
# ta-addi-pngn

images: ta-addi-pngn.img
ta-addi-pngn.img: $T/src/ta-addi-pngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-pngn.S -o ta-addi-pngn.img
	$T/checkbin.sh ta-addi-pngn.img

run-tests: ta-addi-pngn.diff
ta-addi-pngn.diff: ta-addi-pngn.log $T/good/ta-addi-pngn.good
	diff -u $T/good/ta-addi-pngn.good ta-addi-pngn.log > ta-addi-pngn.diff || true
ta-addi-pngn.log: $(SYS161) ta-addi-pngn.img
	$(SYS161) $(SYS161FLAGS) ta-addi-pngn.img 2>&1 | $T/cleanlog.sh > ta-addi-pngn.log

good: ta-addi-pngn.good
ta-addi-pngn.good:
	cp ta-addi-pngn.log $T/good/ta-addi-pngn.good

.PHONY: ta-addi-pngn.good

################################
# ta-addi-pngp

images: ta-addi-pngp.img
ta-addi-pngp.img: $T/src/ta-addi-pngp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-pngp.S -o ta-addi-pngp.img
	$T/checkbin.sh ta-addi-pngp.img

run-tests: ta-addi-pngp.diff
ta-addi-pngp.diff: ta-addi-pngp.log $T/good/ta-addi-pngp.good
	diff -u $T/good/ta-addi-pngp.good ta-addi-pngp.log > ta-addi-pngp.diff || true
ta-addi-pngp.log: $(SYS161) ta-addi-pngp.img
	$(SYS161) $(SYS161FLAGS) ta-addi-pngp.img 2>&1 | $T/cleanlog.sh > ta-addi-pngp.log

good: ta-addi-pngp.good
ta-addi-pngp.good:
	cp ta-addi-pngp.log $T/good/ta-addi-pngp.good

.PHONY: ta-addi-pngp.good

################################
# ta-addi-ppbp

images: ta-addi-ppbp.img
ta-addi-ppbp.img: $T/src/ta-addi-ppbp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-ppbp.S -o ta-addi-ppbp.img
	$T/checkbin.sh ta-addi-ppbp.img

run-tests: ta-addi-ppbp.diff
ta-addi-ppbp.diff: ta-addi-ppbp.log $T/good/ta-addi-ppbp.good
	diff -u $T/good/ta-addi-ppbp.good ta-addi-ppbp.log > ta-addi-ppbp.diff || true
ta-addi-ppbp.log: $(SYS161) ta-addi-ppbp.img
	$(SYS161) $(SYS161FLAGS) ta-addi-ppbp.img 2>&1 | $T/cleanlog.sh > ta-addi-ppbp.log

good: ta-addi-ppbp.good
ta-addi-ppbp.good:
	cp ta-addi-ppbp.log $T/good/ta-addi-ppbp.good

.PHONY: ta-addi-ppbp.good

################################
# ta-addi-ppgp

images: ta-addi-ppgp.img
ta-addi-ppgp.img: $T/src/ta-addi-ppgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-ppgp.S -o ta-addi-ppgp.img
	$T/checkbin.sh ta-addi-ppgp.img

run-tests: ta-addi-ppgp.diff
ta-addi-ppgp.diff: ta-addi-ppgp.log $T/good/ta-addi-ppgp.good
	diff -u $T/good/ta-addi-ppgp.good ta-addi-ppgp.log > ta-addi-ppgp.diff || true
ta-addi-ppgp.log: $(SYS161) ta-addi-ppgp.img
	$(SYS161) $(SYS161FLAGS) ta-addi-ppgp.img 2>&1 | $T/cleanlog.sh > ta-addi-ppgp.log

good: ta-addi-ppgp.good
ta-addi-ppgp.good:
	cp ta-addi-ppgp.log $T/good/ta-addi-ppgp.good

.PHONY: ta-addi-ppgp.good

################################
# ta-addi-uubu

images: ta-addi-uubu.img
ta-addi-uubu.img: $T/src/ta-addi-uubu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-uubu.S -o ta-addi-uubu.img
	$T/checkbin.sh ta-addi-uubu.img

run-tests: ta-addi-uubu.diff
ta-addi-uubu.diff: ta-addi-uubu.log $T/good/ta-addi-uubu.good
	diff -u $T/good/ta-addi-uubu.good ta-addi-uubu.log > ta-addi-uubu.diff || true
ta-addi-uubu.log: $(SYS161) ta-addi-uubu.img
	$(SYS161) $(SYS161FLAGS) ta-addi-uubu.img 2>&1 | $T/cleanlog.sh > ta-addi-uubu.log

good: ta-addi-uubu.good
ta-addi-uubu.good:
	cp ta-addi-uubu.log $T/good/ta-addi-uubu.good

.PHONY: ta-addi-uubu.good

################################
# ta-addi-uugu

images: ta-addi-uugu.img
ta-addi-uugu.img: $T/src/ta-addi-uugu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addi-uugu.S -o ta-addi-uugu.img
	$T/checkbin.sh ta-addi-uugu.img

run-tests: ta-addi-uugu.diff
ta-addi-uugu.diff: ta-addi-uugu.log $T/good/ta-addi-uugu.good
	diff -u $T/good/ta-addi-uugu.good ta-addi-uugu.log > ta-addi-uugu.diff || true
ta-addi-uugu.log: $(SYS161) ta-addi-uugu.img
	$(SYS161) $(SYS161FLAGS) ta-addi-uugu.img 2>&1 | $T/cleanlog.sh > ta-addi-uugu.log

good: ta-addi-uugu.good
ta-addi-uugu.good:
	cp ta-addi-uugu.log $T/good/ta-addi-uugu.good

.PHONY: ta-addi-uugu.good

################################
# ta-addiu-nnbn

images: ta-addiu-nnbn.img
ta-addiu-nnbn.img: $T/src/ta-addiu-nnbn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-nnbn.S -o ta-addiu-nnbn.img
	$T/checkbin.sh ta-addiu-nnbn.img

run-tests: ta-addiu-nnbn.diff
ta-addiu-nnbn.diff: ta-addiu-nnbn.log $T/good/ta-addiu-nnbn.good
	diff -u $T/good/ta-addiu-nnbn.good ta-addiu-nnbn.log > ta-addiu-nnbn.diff || true
ta-addiu-nnbn.log: $(SYS161) ta-addiu-nnbn.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-nnbn.img 2>&1 | $T/cleanlog.sh > ta-addiu-nnbn.log

good: ta-addiu-nnbn.good
ta-addiu-nnbn.good:
	cp ta-addiu-nnbn.log $T/good/ta-addiu-nnbn.good

.PHONY: ta-addiu-nnbn.good

################################
# ta-addiu-nngn

images: ta-addiu-nngn.img
ta-addiu-nngn.img: $T/src/ta-addiu-nngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-nngn.S -o ta-addiu-nngn.img
	$T/checkbin.sh ta-addiu-nngn.img

run-tests: ta-addiu-nngn.diff
ta-addiu-nngn.diff: ta-addiu-nngn.log $T/good/ta-addiu-nngn.good
	diff -u $T/good/ta-addiu-nngn.good ta-addiu-nngn.log > ta-addiu-nngn.diff || true
ta-addiu-nngn.log: $(SYS161) ta-addiu-nngn.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-nngn.img 2>&1 | $T/cleanlog.sh > ta-addiu-nngn.log

good: ta-addiu-nngn.good
ta-addiu-nngn.good:
	cp ta-addiu-nngn.log $T/good/ta-addiu-nngn.good

.PHONY: ta-addiu-nngn.good

################################
# ta-addiu-npgn

images: ta-addiu-npgn.img
ta-addiu-npgn.img: $T/src/ta-addiu-npgn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-npgn.S -o ta-addiu-npgn.img
	$T/checkbin.sh ta-addiu-npgn.img

run-tests: ta-addiu-npgn.diff
ta-addiu-npgn.diff: ta-addiu-npgn.log $T/good/ta-addiu-npgn.good
	diff -u $T/good/ta-addiu-npgn.good ta-addiu-npgn.log > ta-addiu-npgn.diff || true
ta-addiu-npgn.log: $(SYS161) ta-addiu-npgn.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-npgn.img 2>&1 | $T/cleanlog.sh > ta-addiu-npgn.log

good: ta-addiu-npgn.good
ta-addiu-npgn.good:
	cp ta-addiu-npgn.log $T/good/ta-addiu-npgn.good

.PHONY: ta-addiu-npgn.good

################################
# ta-addiu-npgp

images: ta-addiu-npgp.img
ta-addiu-npgp.img: $T/src/ta-addiu-npgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-npgp.S -o ta-addiu-npgp.img
	$T/checkbin.sh ta-addiu-npgp.img

run-tests: ta-addiu-npgp.diff
ta-addiu-npgp.diff: ta-addiu-npgp.log $T/good/ta-addiu-npgp.good
	diff -u $T/good/ta-addiu-npgp.good ta-addiu-npgp.log > ta-addiu-npgp.diff || true
ta-addiu-npgp.log: $(SYS161) ta-addiu-npgp.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-npgp.img 2>&1 | $T/cleanlog.sh > ta-addiu-npgp.log

good: ta-addiu-npgp.good
ta-addiu-npgp.good:
	cp ta-addiu-npgp.log $T/good/ta-addiu-npgp.good

.PHONY: ta-addiu-npgp.good

################################
# ta-addiu-pngn

images: ta-addiu-pngn.img
ta-addiu-pngn.img: $T/src/ta-addiu-pngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-pngn.S -o ta-addiu-pngn.img
	$T/checkbin.sh ta-addiu-pngn.img

run-tests: ta-addiu-pngn.diff
ta-addiu-pngn.diff: ta-addiu-pngn.log $T/good/ta-addiu-pngn.good
	diff -u $T/good/ta-addiu-pngn.good ta-addiu-pngn.log > ta-addiu-pngn.diff || true
ta-addiu-pngn.log: $(SYS161) ta-addiu-pngn.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-pngn.img 2>&1 | $T/cleanlog.sh > ta-addiu-pngn.log

good: ta-addiu-pngn.good
ta-addiu-pngn.good:
	cp ta-addiu-pngn.log $T/good/ta-addiu-pngn.good

.PHONY: ta-addiu-pngn.good

################################
# ta-addiu-pngp

images: ta-addiu-pngp.img
ta-addiu-pngp.img: $T/src/ta-addiu-pngp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-pngp.S -o ta-addiu-pngp.img
	$T/checkbin.sh ta-addiu-pngp.img

run-tests: ta-addiu-pngp.diff
ta-addiu-pngp.diff: ta-addiu-pngp.log $T/good/ta-addiu-pngp.good
	diff -u $T/good/ta-addiu-pngp.good ta-addiu-pngp.log > ta-addiu-pngp.diff || true
ta-addiu-pngp.log: $(SYS161) ta-addiu-pngp.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-pngp.img 2>&1 | $T/cleanlog.sh > ta-addiu-pngp.log

good: ta-addiu-pngp.good
ta-addiu-pngp.good:
	cp ta-addiu-pngp.log $T/good/ta-addiu-pngp.good

.PHONY: ta-addiu-pngp.good

################################
# ta-addiu-ppbp

images: ta-addiu-ppbp.img
ta-addiu-ppbp.img: $T/src/ta-addiu-ppbp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-ppbp.S -o ta-addiu-ppbp.img
	$T/checkbin.sh ta-addiu-ppbp.img

run-tests: ta-addiu-ppbp.diff
ta-addiu-ppbp.diff: ta-addiu-ppbp.log $T/good/ta-addiu-ppbp.good
	diff -u $T/good/ta-addiu-ppbp.good ta-addiu-ppbp.log > ta-addiu-ppbp.diff || true
ta-addiu-ppbp.log: $(SYS161) ta-addiu-ppbp.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-ppbp.img 2>&1 | $T/cleanlog.sh > ta-addiu-ppbp.log

good: ta-addiu-ppbp.good
ta-addiu-ppbp.good:
	cp ta-addiu-ppbp.log $T/good/ta-addiu-ppbp.good

.PHONY: ta-addiu-ppbp.good

################################
# ta-addiu-ppgp

images: ta-addiu-ppgp.img
ta-addiu-ppgp.img: $T/src/ta-addiu-ppgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-ppgp.S -o ta-addiu-ppgp.img
	$T/checkbin.sh ta-addiu-ppgp.img

run-tests: ta-addiu-ppgp.diff
ta-addiu-ppgp.diff: ta-addiu-ppgp.log $T/good/ta-addiu-ppgp.good
	diff -u $T/good/ta-addiu-ppgp.good ta-addiu-ppgp.log > ta-addiu-ppgp.diff || true
ta-addiu-ppgp.log: $(SYS161) ta-addiu-ppgp.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-ppgp.img 2>&1 | $T/cleanlog.sh > ta-addiu-ppgp.log

good: ta-addiu-ppgp.good
ta-addiu-ppgp.good:
	cp ta-addiu-ppgp.log $T/good/ta-addiu-ppgp.good

.PHONY: ta-addiu-ppgp.good

################################
# ta-addiu-uubu

images: ta-addiu-uubu.img
ta-addiu-uubu.img: $T/src/ta-addiu-uubu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-uubu.S -o ta-addiu-uubu.img
	$T/checkbin.sh ta-addiu-uubu.img

run-tests: ta-addiu-uubu.diff
ta-addiu-uubu.diff: ta-addiu-uubu.log $T/good/ta-addiu-uubu.good
	diff -u $T/good/ta-addiu-uubu.good ta-addiu-uubu.log > ta-addiu-uubu.diff || true
ta-addiu-uubu.log: $(SYS161) ta-addiu-uubu.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-uubu.img 2>&1 | $T/cleanlog.sh > ta-addiu-uubu.log

good: ta-addiu-uubu.good
ta-addiu-uubu.good:
	cp ta-addiu-uubu.log $T/good/ta-addiu-uubu.good

.PHONY: ta-addiu-uubu.good

################################
# ta-addiu-uugu

images: ta-addiu-uugu.img
ta-addiu-uugu.img: $T/src/ta-addiu-uugu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addiu-uugu.S -o ta-addiu-uugu.img
	$T/checkbin.sh ta-addiu-uugu.img

run-tests: ta-addiu-uugu.diff
ta-addiu-uugu.diff: ta-addiu-uugu.log $T/good/ta-addiu-uugu.good
	diff -u $T/good/ta-addiu-uugu.good ta-addiu-uugu.log > ta-addiu-uugu.diff || true
ta-addiu-uugu.log: $(SYS161) ta-addiu-uugu.img
	$(SYS161) $(SYS161FLAGS) ta-addiu-uugu.img 2>&1 | $T/cleanlog.sh > ta-addiu-uugu.log

good: ta-addiu-uugu.good
ta-addiu-uugu.good:
	cp ta-addiu-uugu.log $T/good/ta-addiu-uugu.good

.PHONY: ta-addiu-uugu.good

################################
# ta-addu-nnbn

images: ta-addu-nnbn.img
ta-addu-nnbn.img: $T/src/ta-addu-nnbn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-nnbn.S -o ta-addu-nnbn.img
	$T/checkbin.sh ta-addu-nnbn.img

run-tests: ta-addu-nnbn.diff
ta-addu-nnbn.diff: ta-addu-nnbn.log $T/good/ta-addu-nnbn.good
	diff -u $T/good/ta-addu-nnbn.good ta-addu-nnbn.log > ta-addu-nnbn.diff || true
ta-addu-nnbn.log: $(SYS161) ta-addu-nnbn.img
	$(SYS161) $(SYS161FLAGS) ta-addu-nnbn.img 2>&1 | $T/cleanlog.sh > ta-addu-nnbn.log

good: ta-addu-nnbn.good
ta-addu-nnbn.good:
	cp ta-addu-nnbn.log $T/good/ta-addu-nnbn.good

.PHONY: ta-addu-nnbn.good

################################
# ta-addu-nngn

images: ta-addu-nngn.img
ta-addu-nngn.img: $T/src/ta-addu-nngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-nngn.S -o ta-addu-nngn.img
	$T/checkbin.sh ta-addu-nngn.img

run-tests: ta-addu-nngn.diff
ta-addu-nngn.diff: ta-addu-nngn.log $T/good/ta-addu-nngn.good
	diff -u $T/good/ta-addu-nngn.good ta-addu-nngn.log > ta-addu-nngn.diff || true
ta-addu-nngn.log: $(SYS161) ta-addu-nngn.img
	$(SYS161) $(SYS161FLAGS) ta-addu-nngn.img 2>&1 | $T/cleanlog.sh > ta-addu-nngn.log

good: ta-addu-nngn.good
ta-addu-nngn.good:
	cp ta-addu-nngn.log $T/good/ta-addu-nngn.good

.PHONY: ta-addu-nngn.good

################################
# ta-addu-npgn

images: ta-addu-npgn.img
ta-addu-npgn.img: $T/src/ta-addu-npgn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-npgn.S -o ta-addu-npgn.img
	$T/checkbin.sh ta-addu-npgn.img

run-tests: ta-addu-npgn.diff
ta-addu-npgn.diff: ta-addu-npgn.log $T/good/ta-addu-npgn.good
	diff -u $T/good/ta-addu-npgn.good ta-addu-npgn.log > ta-addu-npgn.diff || true
ta-addu-npgn.log: $(SYS161) ta-addu-npgn.img
	$(SYS161) $(SYS161FLAGS) ta-addu-npgn.img 2>&1 | $T/cleanlog.sh > ta-addu-npgn.log

good: ta-addu-npgn.good
ta-addu-npgn.good:
	cp ta-addu-npgn.log $T/good/ta-addu-npgn.good

.PHONY: ta-addu-npgn.good

################################
# ta-addu-npgp

images: ta-addu-npgp.img
ta-addu-npgp.img: $T/src/ta-addu-npgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-npgp.S -o ta-addu-npgp.img
	$T/checkbin.sh ta-addu-npgp.img

run-tests: ta-addu-npgp.diff
ta-addu-npgp.diff: ta-addu-npgp.log $T/good/ta-addu-npgp.good
	diff -u $T/good/ta-addu-npgp.good ta-addu-npgp.log > ta-addu-npgp.diff || true
ta-addu-npgp.log: $(SYS161) ta-addu-npgp.img
	$(SYS161) $(SYS161FLAGS) ta-addu-npgp.img 2>&1 | $T/cleanlog.sh > ta-addu-npgp.log

good: ta-addu-npgp.good
ta-addu-npgp.good:
	cp ta-addu-npgp.log $T/good/ta-addu-npgp.good

.PHONY: ta-addu-npgp.good

################################
# ta-addu-pngn

images: ta-addu-pngn.img
ta-addu-pngn.img: $T/src/ta-addu-pngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-pngn.S -o ta-addu-pngn.img
	$T/checkbin.sh ta-addu-pngn.img

run-tests: ta-addu-pngn.diff
ta-addu-pngn.diff: ta-addu-pngn.log $T/good/ta-addu-pngn.good
	diff -u $T/good/ta-addu-pngn.good ta-addu-pngn.log > ta-addu-pngn.diff || true
ta-addu-pngn.log: $(SYS161) ta-addu-pngn.img
	$(SYS161) $(SYS161FLAGS) ta-addu-pngn.img 2>&1 | $T/cleanlog.sh > ta-addu-pngn.log

good: ta-addu-pngn.good
ta-addu-pngn.good:
	cp ta-addu-pngn.log $T/good/ta-addu-pngn.good

.PHONY: ta-addu-pngn.good

################################
# ta-addu-pngp

images: ta-addu-pngp.img
ta-addu-pngp.img: $T/src/ta-addu-pngp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-pngp.S -o ta-addu-pngp.img
	$T/checkbin.sh ta-addu-pngp.img

run-tests: ta-addu-pngp.diff
ta-addu-pngp.diff: ta-addu-pngp.log $T/good/ta-addu-pngp.good
	diff -u $T/good/ta-addu-pngp.good ta-addu-pngp.log > ta-addu-pngp.diff || true
ta-addu-pngp.log: $(SYS161) ta-addu-pngp.img
	$(SYS161) $(SYS161FLAGS) ta-addu-pngp.img 2>&1 | $T/cleanlog.sh > ta-addu-pngp.log

good: ta-addu-pngp.good
ta-addu-pngp.good:
	cp ta-addu-pngp.log $T/good/ta-addu-pngp.good

.PHONY: ta-addu-pngp.good

################################
# ta-addu-ppbp

images: ta-addu-ppbp.img
ta-addu-ppbp.img: $T/src/ta-addu-ppbp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-ppbp.S -o ta-addu-ppbp.img
	$T/checkbin.sh ta-addu-ppbp.img

run-tests: ta-addu-ppbp.diff
ta-addu-ppbp.diff: ta-addu-ppbp.log $T/good/ta-addu-ppbp.good
	diff -u $T/good/ta-addu-ppbp.good ta-addu-ppbp.log > ta-addu-ppbp.diff || true
ta-addu-ppbp.log: $(SYS161) ta-addu-ppbp.img
	$(SYS161) $(SYS161FLAGS) ta-addu-ppbp.img 2>&1 | $T/cleanlog.sh > ta-addu-ppbp.log

good: ta-addu-ppbp.good
ta-addu-ppbp.good:
	cp ta-addu-ppbp.log $T/good/ta-addu-ppbp.good

.PHONY: ta-addu-ppbp.good

################################
# ta-addu-ppgp

images: ta-addu-ppgp.img
ta-addu-ppgp.img: $T/src/ta-addu-ppgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-ppgp.S -o ta-addu-ppgp.img
	$T/checkbin.sh ta-addu-ppgp.img

run-tests: ta-addu-ppgp.diff
ta-addu-ppgp.diff: ta-addu-ppgp.log $T/good/ta-addu-ppgp.good
	diff -u $T/good/ta-addu-ppgp.good ta-addu-ppgp.log > ta-addu-ppgp.diff || true
ta-addu-ppgp.log: $(SYS161) ta-addu-ppgp.img
	$(SYS161) $(SYS161FLAGS) ta-addu-ppgp.img 2>&1 | $T/cleanlog.sh > ta-addu-ppgp.log

good: ta-addu-ppgp.good
ta-addu-ppgp.good:
	cp ta-addu-ppgp.log $T/good/ta-addu-ppgp.good

.PHONY: ta-addu-ppgp.good

################################
# ta-addu-uubu

images: ta-addu-uubu.img
ta-addu-uubu.img: $T/src/ta-addu-uubu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-uubu.S -o ta-addu-uubu.img
	$T/checkbin.sh ta-addu-uubu.img

run-tests: ta-addu-uubu.diff
ta-addu-uubu.diff: ta-addu-uubu.log $T/good/ta-addu-uubu.good
	diff -u $T/good/ta-addu-uubu.good ta-addu-uubu.log > ta-addu-uubu.diff || true
ta-addu-uubu.log: $(SYS161) ta-addu-uubu.img
	$(SYS161) $(SYS161FLAGS) ta-addu-uubu.img 2>&1 | $T/cleanlog.sh > ta-addu-uubu.log

good: ta-addu-uubu.good
ta-addu-uubu.good:
	cp ta-addu-uubu.log $T/good/ta-addu-uubu.good

.PHONY: ta-addu-uubu.good

################################
# ta-addu-uugu

images: ta-addu-uugu.img
ta-addu-uugu.img: $T/src/ta-addu-uugu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-addu-uugu.S -o ta-addu-uugu.img
	$T/checkbin.sh ta-addu-uugu.img

run-tests: ta-addu-uugu.diff
ta-addu-uugu.diff: ta-addu-uugu.log $T/good/ta-addu-uugu.good
	diff -u $T/good/ta-addu-uugu.good ta-addu-uugu.log > ta-addu-uugu.diff || true
ta-addu-uugu.log: $(SYS161) ta-addu-uugu.img
	$(SYS161) $(SYS161FLAGS) ta-addu-uugu.img 2>&1 | $T/cleanlog.sh > ta-addu-uugu.log

good: ta-addu-uugu.good
ta-addu-uugu.good:
	cp ta-addu-uugu.log $T/good/ta-addu-uugu.good

.PHONY: ta-addu-uugu.good

################################
# ta-sub-nngn

images: ta-sub-nngn.img
ta-sub-nngn.img: $T/src/ta-sub-nngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-nngn.S -o ta-sub-nngn.img
	$T/checkbin.sh ta-sub-nngn.img

run-tests: ta-sub-nngn.diff
ta-sub-nngn.diff: ta-sub-nngn.log $T/good/ta-sub-nngn.good
	diff -u $T/good/ta-sub-nngn.good ta-sub-nngn.log > ta-sub-nngn.diff || true
ta-sub-nngn.log: $(SYS161) ta-sub-nngn.img
	$(SYS161) $(SYS161FLAGS) ta-sub-nngn.img 2>&1 | $T/cleanlog.sh > ta-sub-nngn.log

good: ta-sub-nngn.good
ta-sub-nngn.good:
	cp ta-sub-nngn.log $T/good/ta-sub-nngn.good

.PHONY: ta-sub-nngn.good

################################
# ta-sub-nngp

images: ta-sub-nngp.img
ta-sub-nngp.img: $T/src/ta-sub-nngp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-nngp.S -o ta-sub-nngp.img
	$T/checkbin.sh ta-sub-nngp.img

run-tests: ta-sub-nngp.diff
ta-sub-nngp.diff: ta-sub-nngp.log $T/good/ta-sub-nngp.good
	diff -u $T/good/ta-sub-nngp.good ta-sub-nngp.log > ta-sub-nngp.diff || true
ta-sub-nngp.log: $(SYS161) ta-sub-nngp.img
	$(SYS161) $(SYS161FLAGS) ta-sub-nngp.img 2>&1 | $T/cleanlog.sh > ta-sub-nngp.log

good: ta-sub-nngp.good
ta-sub-nngp.good:
	cp ta-sub-nngp.log $T/good/ta-sub-nngp.good

.PHONY: ta-sub-nngp.good

################################
# ta-sub-npbn

images: ta-sub-npbn.img
ta-sub-npbn.img: $T/src/ta-sub-npbn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-npbn.S -o ta-sub-npbn.img
	$T/checkbin.sh ta-sub-npbn.img

run-tests: ta-sub-npbn.diff
ta-sub-npbn.diff: ta-sub-npbn.log $T/good/ta-sub-npbn.good
	diff -u $T/good/ta-sub-npbn.good ta-sub-npbn.log > ta-sub-npbn.diff || true
ta-sub-npbn.log: $(SYS161) ta-sub-npbn.img
	$(SYS161) $(SYS161FLAGS) ta-sub-npbn.img 2>&1 | $T/cleanlog.sh > ta-sub-npbn.log

good: ta-sub-npbn.good
ta-sub-npbn.good:
	cp ta-sub-npbn.log $T/good/ta-sub-npbn.good

.PHONY: ta-sub-npbn.good

################################
# ta-sub-npgn

images: ta-sub-npgn.img
ta-sub-npgn.img: $T/src/ta-sub-npgn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-npgn.S -o ta-sub-npgn.img
	$T/checkbin.sh ta-sub-npgn.img

run-tests: ta-sub-npgn.diff
ta-sub-npgn.diff: ta-sub-npgn.log $T/good/ta-sub-npgn.good
	diff -u $T/good/ta-sub-npgn.good ta-sub-npgn.log > ta-sub-npgn.diff || true
ta-sub-npgn.log: $(SYS161) ta-sub-npgn.img
	$(SYS161) $(SYS161FLAGS) ta-sub-npgn.img 2>&1 | $T/cleanlog.sh > ta-sub-npgn.log

good: ta-sub-npgn.good
ta-sub-npgn.good:
	cp ta-sub-npgn.log $T/good/ta-sub-npgn.good

.PHONY: ta-sub-npgn.good

################################
# ta-sub-pnbp

images: ta-sub-pnbp.img
ta-sub-pnbp.img: $T/src/ta-sub-pnbp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-pnbp.S -o ta-sub-pnbp.img
	$T/checkbin.sh ta-sub-pnbp.img

run-tests: ta-sub-pnbp.diff
ta-sub-pnbp.diff: ta-sub-pnbp.log $T/good/ta-sub-pnbp.good
	diff -u $T/good/ta-sub-pnbp.good ta-sub-pnbp.log > ta-sub-pnbp.diff || true
ta-sub-pnbp.log: $(SYS161) ta-sub-pnbp.img
	$(SYS161) $(SYS161FLAGS) ta-sub-pnbp.img 2>&1 | $T/cleanlog.sh > ta-sub-pnbp.log

good: ta-sub-pnbp.good
ta-sub-pnbp.good:
	cp ta-sub-pnbp.log $T/good/ta-sub-pnbp.good

.PHONY: ta-sub-pnbp.good

################################
# ta-sub-pngp

images: ta-sub-pngp.img
ta-sub-pngp.img: $T/src/ta-sub-pngp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-pngp.S -o ta-sub-pngp.img
	$T/checkbin.sh ta-sub-pngp.img

run-tests: ta-sub-pngp.diff
ta-sub-pngp.diff: ta-sub-pngp.log $T/good/ta-sub-pngp.good
	diff -u $T/good/ta-sub-pngp.good ta-sub-pngp.log > ta-sub-pngp.diff || true
ta-sub-pngp.log: $(SYS161) ta-sub-pngp.img
	$(SYS161) $(SYS161FLAGS) ta-sub-pngp.img 2>&1 | $T/cleanlog.sh > ta-sub-pngp.log

good: ta-sub-pngp.good
ta-sub-pngp.good:
	cp ta-sub-pngp.log $T/good/ta-sub-pngp.good

.PHONY: ta-sub-pngp.good

################################
# ta-sub-ppgn

images: ta-sub-ppgn.img
ta-sub-ppgn.img: $T/src/ta-sub-ppgn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-ppgn.S -o ta-sub-ppgn.img
	$T/checkbin.sh ta-sub-ppgn.img

run-tests: ta-sub-ppgn.diff
ta-sub-ppgn.diff: ta-sub-ppgn.log $T/good/ta-sub-ppgn.good
	diff -u $T/good/ta-sub-ppgn.good ta-sub-ppgn.log > ta-sub-ppgn.diff || true
ta-sub-ppgn.log: $(SYS161) ta-sub-ppgn.img
	$(SYS161) $(SYS161FLAGS) ta-sub-ppgn.img 2>&1 | $T/cleanlog.sh > ta-sub-ppgn.log

good: ta-sub-ppgn.good
ta-sub-ppgn.good:
	cp ta-sub-ppgn.log $T/good/ta-sub-ppgn.good

.PHONY: ta-sub-ppgn.good

################################
# ta-sub-ppgp

images: ta-sub-ppgp.img
ta-sub-ppgp.img: $T/src/ta-sub-ppgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-ppgp.S -o ta-sub-ppgp.img
	$T/checkbin.sh ta-sub-ppgp.img

run-tests: ta-sub-ppgp.diff
ta-sub-ppgp.diff: ta-sub-ppgp.log $T/good/ta-sub-ppgp.good
	diff -u $T/good/ta-sub-ppgp.good ta-sub-ppgp.log > ta-sub-ppgp.diff || true
ta-sub-ppgp.log: $(SYS161) ta-sub-ppgp.img
	$(SYS161) $(SYS161FLAGS) ta-sub-ppgp.img 2>&1 | $T/cleanlog.sh > ta-sub-ppgp.log

good: ta-sub-ppgp.good
ta-sub-ppgp.good:
	cp ta-sub-ppgp.log $T/good/ta-sub-ppgp.good

.PHONY: ta-sub-ppgp.good

################################
# ta-sub-uubu

images: ta-sub-uubu.img
ta-sub-uubu.img: $T/src/ta-sub-uubu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-uubu.S -o ta-sub-uubu.img
	$T/checkbin.sh ta-sub-uubu.img

run-tests: ta-sub-uubu.diff
ta-sub-uubu.diff: ta-sub-uubu.log $T/good/ta-sub-uubu.good
	diff -u $T/good/ta-sub-uubu.good ta-sub-uubu.log > ta-sub-uubu.diff || true
ta-sub-uubu.log: $(SYS161) ta-sub-uubu.img
	$(SYS161) $(SYS161FLAGS) ta-sub-uubu.img 2>&1 | $T/cleanlog.sh > ta-sub-uubu.log

good: ta-sub-uubu.good
ta-sub-uubu.good:
	cp ta-sub-uubu.log $T/good/ta-sub-uubu.good

.PHONY: ta-sub-uubu.good

################################
# ta-sub-uugu

images: ta-sub-uugu.img
ta-sub-uugu.img: $T/src/ta-sub-uugu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-sub-uugu.S -o ta-sub-uugu.img
	$T/checkbin.sh ta-sub-uugu.img

run-tests: ta-sub-uugu.diff
ta-sub-uugu.diff: ta-sub-uugu.log $T/good/ta-sub-uugu.good
	diff -u $T/good/ta-sub-uugu.good ta-sub-uugu.log > ta-sub-uugu.diff || true
ta-sub-uugu.log: $(SYS161) ta-sub-uugu.img
	$(SYS161) $(SYS161FLAGS) ta-sub-uugu.img 2>&1 | $T/cleanlog.sh > ta-sub-uugu.log

good: ta-sub-uugu.good
ta-sub-uugu.good:
	cp ta-sub-uugu.log $T/good/ta-sub-uugu.good

.PHONY: ta-sub-uugu.good

################################
# ta-subu-nngn

images: ta-subu-nngn.img
ta-subu-nngn.img: $T/src/ta-subu-nngn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-nngn.S -o ta-subu-nngn.img
	$T/checkbin.sh ta-subu-nngn.img

run-tests: ta-subu-nngn.diff
ta-subu-nngn.diff: ta-subu-nngn.log $T/good/ta-subu-nngn.good
	diff -u $T/good/ta-subu-nngn.good ta-subu-nngn.log > ta-subu-nngn.diff || true
ta-subu-nngn.log: $(SYS161) ta-subu-nngn.img
	$(SYS161) $(SYS161FLAGS) ta-subu-nngn.img 2>&1 | $T/cleanlog.sh > ta-subu-nngn.log

good: ta-subu-nngn.good
ta-subu-nngn.good:
	cp ta-subu-nngn.log $T/good/ta-subu-nngn.good

.PHONY: ta-subu-nngn.good

################################
# ta-subu-nngp

images: ta-subu-nngp.img
ta-subu-nngp.img: $T/src/ta-subu-nngp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-nngp.S -o ta-subu-nngp.img
	$T/checkbin.sh ta-subu-nngp.img

run-tests: ta-subu-nngp.diff
ta-subu-nngp.diff: ta-subu-nngp.log $T/good/ta-subu-nngp.good
	diff -u $T/good/ta-subu-nngp.good ta-subu-nngp.log > ta-subu-nngp.diff || true
ta-subu-nngp.log: $(SYS161) ta-subu-nngp.img
	$(SYS161) $(SYS161FLAGS) ta-subu-nngp.img 2>&1 | $T/cleanlog.sh > ta-subu-nngp.log

good: ta-subu-nngp.good
ta-subu-nngp.good:
	cp ta-subu-nngp.log $T/good/ta-subu-nngp.good

.PHONY: ta-subu-nngp.good

################################
# ta-subu-npbn

images: ta-subu-npbn.img
ta-subu-npbn.img: $T/src/ta-subu-npbn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-npbn.S -o ta-subu-npbn.img
	$T/checkbin.sh ta-subu-npbn.img

run-tests: ta-subu-npbn.diff
ta-subu-npbn.diff: ta-subu-npbn.log $T/good/ta-subu-npbn.good
	diff -u $T/good/ta-subu-npbn.good ta-subu-npbn.log > ta-subu-npbn.diff || true
ta-subu-npbn.log: $(SYS161) ta-subu-npbn.img
	$(SYS161) $(SYS161FLAGS) ta-subu-npbn.img 2>&1 | $T/cleanlog.sh > ta-subu-npbn.log

good: ta-subu-npbn.good
ta-subu-npbn.good:
	cp ta-subu-npbn.log $T/good/ta-subu-npbn.good

.PHONY: ta-subu-npbn.good

################################
# ta-subu-npgn

images: ta-subu-npgn.img
ta-subu-npgn.img: $T/src/ta-subu-npgn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-npgn.S -o ta-subu-npgn.img
	$T/checkbin.sh ta-subu-npgn.img

run-tests: ta-subu-npgn.diff
ta-subu-npgn.diff: ta-subu-npgn.log $T/good/ta-subu-npgn.good
	diff -u $T/good/ta-subu-npgn.good ta-subu-npgn.log > ta-subu-npgn.diff || true
ta-subu-npgn.log: $(SYS161) ta-subu-npgn.img
	$(SYS161) $(SYS161FLAGS) ta-subu-npgn.img 2>&1 | $T/cleanlog.sh > ta-subu-npgn.log

good: ta-subu-npgn.good
ta-subu-npgn.good:
	cp ta-subu-npgn.log $T/good/ta-subu-npgn.good

.PHONY: ta-subu-npgn.good

################################
# ta-subu-pnbp

images: ta-subu-pnbp.img
ta-subu-pnbp.img: $T/src/ta-subu-pnbp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-pnbp.S -o ta-subu-pnbp.img
	$T/checkbin.sh ta-subu-pnbp.img

run-tests: ta-subu-pnbp.diff
ta-subu-pnbp.diff: ta-subu-pnbp.log $T/good/ta-subu-pnbp.good
	diff -u $T/good/ta-subu-pnbp.good ta-subu-pnbp.log > ta-subu-pnbp.diff || true
ta-subu-pnbp.log: $(SYS161) ta-subu-pnbp.img
	$(SYS161) $(SYS161FLAGS) ta-subu-pnbp.img 2>&1 | $T/cleanlog.sh > ta-subu-pnbp.log

good: ta-subu-pnbp.good
ta-subu-pnbp.good:
	cp ta-subu-pnbp.log $T/good/ta-subu-pnbp.good

.PHONY: ta-subu-pnbp.good

################################
# ta-subu-pngp

images: ta-subu-pngp.img
ta-subu-pngp.img: $T/src/ta-subu-pngp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-pngp.S -o ta-subu-pngp.img
	$T/checkbin.sh ta-subu-pngp.img

run-tests: ta-subu-pngp.diff
ta-subu-pngp.diff: ta-subu-pngp.log $T/good/ta-subu-pngp.good
	diff -u $T/good/ta-subu-pngp.good ta-subu-pngp.log > ta-subu-pngp.diff || true
ta-subu-pngp.log: $(SYS161) ta-subu-pngp.img
	$(SYS161) $(SYS161FLAGS) ta-subu-pngp.img 2>&1 | $T/cleanlog.sh > ta-subu-pngp.log

good: ta-subu-pngp.good
ta-subu-pngp.good:
	cp ta-subu-pngp.log $T/good/ta-subu-pngp.good

.PHONY: ta-subu-pngp.good

################################
# ta-subu-ppgn

images: ta-subu-ppgn.img
ta-subu-ppgn.img: $T/src/ta-subu-ppgn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-ppgn.S -o ta-subu-ppgn.img
	$T/checkbin.sh ta-subu-ppgn.img

run-tests: ta-subu-ppgn.diff
ta-subu-ppgn.diff: ta-subu-ppgn.log $T/good/ta-subu-ppgn.good
	diff -u $T/good/ta-subu-ppgn.good ta-subu-ppgn.log > ta-subu-ppgn.diff || true
ta-subu-ppgn.log: $(SYS161) ta-subu-ppgn.img
	$(SYS161) $(SYS161FLAGS) ta-subu-ppgn.img 2>&1 | $T/cleanlog.sh > ta-subu-ppgn.log

good: ta-subu-ppgn.good
ta-subu-ppgn.good:
	cp ta-subu-ppgn.log $T/good/ta-subu-ppgn.good

.PHONY: ta-subu-ppgn.good

################################
# ta-subu-ppgp

images: ta-subu-ppgp.img
ta-subu-ppgp.img: $T/src/ta-subu-ppgp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-ppgp.S -o ta-subu-ppgp.img
	$T/checkbin.sh ta-subu-ppgp.img

run-tests: ta-subu-ppgp.diff
ta-subu-ppgp.diff: ta-subu-ppgp.log $T/good/ta-subu-ppgp.good
	diff -u $T/good/ta-subu-ppgp.good ta-subu-ppgp.log > ta-subu-ppgp.diff || true
ta-subu-ppgp.log: $(SYS161) ta-subu-ppgp.img
	$(SYS161) $(SYS161FLAGS) ta-subu-ppgp.img 2>&1 | $T/cleanlog.sh > ta-subu-ppgp.log

good: ta-subu-ppgp.good
ta-subu-ppgp.good:
	cp ta-subu-ppgp.log $T/good/ta-subu-ppgp.good

.PHONY: ta-subu-ppgp.good

################################
# ta-subu-uubu

images: ta-subu-uubu.img
ta-subu-uubu.img: $T/src/ta-subu-uubu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-uubu.S -o ta-subu-uubu.img
	$T/checkbin.sh ta-subu-uubu.img

run-tests: ta-subu-uubu.diff
ta-subu-uubu.diff: ta-subu-uubu.log $T/good/ta-subu-uubu.good
	diff -u $T/good/ta-subu-uubu.good ta-subu-uubu.log > ta-subu-uubu.diff || true
ta-subu-uubu.log: $(SYS161) ta-subu-uubu.img
	$(SYS161) $(SYS161FLAGS) ta-subu-uubu.img 2>&1 | $T/cleanlog.sh > ta-subu-uubu.log

good: ta-subu-uubu.good
ta-subu-uubu.good:
	cp ta-subu-uubu.log $T/good/ta-subu-uubu.good

.PHONY: ta-subu-uubu.good

################################
# ta-subu-uugu

images: ta-subu-uugu.img
ta-subu-uugu.img: $T/src/ta-subu-uugu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/ta-subu-uugu.S -o ta-subu-uugu.img
	$T/checkbin.sh ta-subu-uugu.img

run-tests: ta-subu-uugu.diff
ta-subu-uugu.diff: ta-subu-uugu.log $T/good/ta-subu-uugu.good
	diff -u $T/good/ta-subu-uugu.good ta-subu-uugu.log > ta-subu-uugu.diff || true
ta-subu-uugu.log: $(SYS161) ta-subu-uugu.img
	$(SYS161) $(SYS161FLAGS) ta-subu-uugu.img 2>&1 | $T/cleanlog.sh > ta-subu-uugu.log

good: ta-subu-uugu.good
ta-subu-uugu.good:
	cp ta-subu-uugu.log $T/good/ta-subu-uugu.good

.PHONY: ta-subu-uugu.good

################################
# tb-and

images: tb-and.img
tb-and.img: $T/src/tb-and.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tb-and.S -o tb-and.img
	$T/checkbin.sh tb-and.img

run-tests: tb-and.diff
tb-and.diff: tb-and.log $T/good/tb-and.good
	diff -u $T/good/tb-and.good tb-and.log > tb-and.diff || true
tb-and.log: $(SYS161) tb-and.img
	$(SYS161) $(SYS161FLAGS) tb-and.img 2>&1 | $T/cleanlog.sh > tb-and.log

good: tb-and.good
tb-and.good:
	cp tb-and.log $T/good/tb-and.good

.PHONY: tb-and.good

################################
# tb-andi

images: tb-andi.img
tb-andi.img: $T/src/tb-andi.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tb-andi.S -o tb-andi.img
	$T/checkbin.sh tb-andi.img

run-tests: tb-andi.diff
tb-andi.diff: tb-andi.log $T/good/tb-andi.good
	diff -u $T/good/tb-andi.good tb-andi.log > tb-andi.diff || true
tb-andi.log: $(SYS161) tb-andi.img
	$(SYS161) $(SYS161FLAGS) tb-andi.img 2>&1 | $T/cleanlog.sh > tb-andi.log

good: tb-andi.good
tb-andi.good:
	cp tb-andi.log $T/good/tb-andi.good

.PHONY: tb-andi.good

################################
# tb-nor

images: tb-nor.img
tb-nor.img: $T/src/tb-nor.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tb-nor.S -o tb-nor.img
	$T/checkbin.sh tb-nor.img

run-tests: tb-nor.diff
tb-nor.diff: tb-nor.log $T/good/tb-nor.good
	diff -u $T/good/tb-nor.good tb-nor.log > tb-nor.diff || true
tb-nor.log: $(SYS161) tb-nor.img
	$(SYS161) $(SYS161FLAGS) tb-nor.img 2>&1 | $T/cleanlog.sh > tb-nor.log

good: tb-nor.good
tb-nor.good:
	cp tb-nor.log $T/good/tb-nor.good

.PHONY: tb-nor.good

################################
# tb-or

images: tb-or.img
tb-or.img: $T/src/tb-or.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tb-or.S -o tb-or.img
	$T/checkbin.sh tb-or.img

run-tests: tb-or.diff
tb-or.diff: tb-or.log $T/good/tb-or.good
	diff -u $T/good/tb-or.good tb-or.log > tb-or.diff || true
tb-or.log: $(SYS161) tb-or.img
	$(SYS161) $(SYS161FLAGS) tb-or.img 2>&1 | $T/cleanlog.sh > tb-or.log

good: tb-or.good
tb-or.good:
	cp tb-or.log $T/good/tb-or.good

.PHONY: tb-or.good

################################
# tb-ori

images: tb-ori.img
tb-ori.img: $T/src/tb-ori.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tb-ori.S -o tb-ori.img
	$T/checkbin.sh tb-ori.img

run-tests: tb-ori.diff
tb-ori.diff: tb-ori.log $T/good/tb-ori.good
	diff -u $T/good/tb-ori.good tb-ori.log > tb-ori.diff || true
tb-ori.log: $(SYS161) tb-ori.img
	$(SYS161) $(SYS161FLAGS) tb-ori.img 2>&1 | $T/cleanlog.sh > tb-ori.log

good: tb-ori.good
tb-ori.good:
	cp tb-ori.log $T/good/tb-ori.good

.PHONY: tb-ori.good

################################
# tb-xor

images: tb-xor.img
tb-xor.img: $T/src/tb-xor.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tb-xor.S -o tb-xor.img
	$T/checkbin.sh tb-xor.img

run-tests: tb-xor.diff
tb-xor.diff: tb-xor.log $T/good/tb-xor.good
	diff -u $T/good/tb-xor.good tb-xor.log > tb-xor.diff || true
tb-xor.log: $(SYS161) tb-xor.img
	$(SYS161) $(SYS161FLAGS) tb-xor.img 2>&1 | $T/cleanlog.sh > tb-xor.log

good: tb-xor.good
tb-xor.good:
	cp tb-xor.log $T/good/tb-xor.good

.PHONY: tb-xor.good

################################
# tb-xori

images: tb-xori.img
tb-xori.img: $T/src/tb-xori.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tb-xori.S -o tb-xori.img
	$T/checkbin.sh tb-xori.img

run-tests: tb-xori.diff
tb-xori.diff: tb-xori.log $T/good/tb-xori.good
	diff -u $T/good/tb-xori.good tb-xori.log > tb-xori.diff || true
tb-xori.log: $(SYS161) tb-xori.img
	$(SYS161) $(SYS161FLAGS) tb-xori.img 2>&1 | $T/cleanlog.sh > tb-xori.log

good: tb-xori.good
tb-xori.good:
	cp tb-xori.log $T/good/tb-xori.good

.PHONY: tb-xori.good

################################
# tc-slt

images: tc-slt.img
tc-slt.img: $T/src/tc-slt.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tc-slt.S -o tc-slt.img
	$T/checkbin.sh tc-slt.img

run-tests: tc-slt.diff
tc-slt.diff: tc-slt.log $T/good/tc-slt.good
	diff -u $T/good/tc-slt.good tc-slt.log > tc-slt.diff || true
tc-slt.log: $(SYS161) tc-slt.img
	$(SYS161) $(SYS161FLAGS) tc-slt.img 2>&1 | $T/cleanlog.sh > tc-slt.log

good: tc-slt.good
tc-slt.good:
	cp tc-slt.log $T/good/tc-slt.good

.PHONY: tc-slt.good

################################
# tc-slti

images: tc-slti.img
tc-slti.img: $T/src/tc-slti.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tc-slti.S -o tc-slti.img
	$T/checkbin.sh tc-slti.img

run-tests: tc-slti.diff
tc-slti.diff: tc-slti.log $T/good/tc-slti.good
	diff -u $T/good/tc-slti.good tc-slti.log > tc-slti.diff || true
tc-slti.log: $(SYS161) tc-slti.img
	$(SYS161) $(SYS161FLAGS) tc-slti.img 2>&1 | $T/cleanlog.sh > tc-slti.log

good: tc-slti.good
tc-slti.good:
	cp tc-slti.log $T/good/tc-slti.good

.PHONY: tc-slti.good

################################
# tc-sltiu

images: tc-sltiu.img
tc-sltiu.img: $T/src/tc-sltiu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tc-sltiu.S -o tc-sltiu.img
	$T/checkbin.sh tc-sltiu.img

run-tests: tc-sltiu.diff
tc-sltiu.diff: tc-sltiu.log $T/good/tc-sltiu.good
	diff -u $T/good/tc-sltiu.good tc-sltiu.log > tc-sltiu.diff || true
tc-sltiu.log: $(SYS161) tc-sltiu.img
	$(SYS161) $(SYS161FLAGS) tc-sltiu.img 2>&1 | $T/cleanlog.sh > tc-sltiu.log

good: tc-sltiu.good
tc-sltiu.good:
	cp tc-sltiu.log $T/good/tc-sltiu.good

.PHONY: tc-sltiu.good

################################
# tc-sltu

images: tc-sltu.img
tc-sltu.img: $T/src/tc-sltu.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/tc-sltu.S -o tc-sltu.img
	$T/checkbin.sh tc-sltu.img

run-tests: tc-sltu.diff
tc-sltu.diff: tc-sltu.log $T/good/tc-sltu.good
	diff -u $T/good/tc-sltu.good tc-sltu.log > tc-sltu.diff || true
tc-sltu.log: $(SYS161) tc-sltu.img
	$(SYS161) $(SYS161FLAGS) tc-sltu.img 2>&1 | $T/cleanlog.sh > tc-sltu.log

good: tc-sltu.good
tc-sltu.good:
	cp tc-sltu.log $T/good/tc-sltu.good

.PHONY: tc-sltu.good

################################
# td-div-nn

images: td-div-nn.img
td-div-nn.img: $T/src/td-div-nn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-div-nn.S -o td-div-nn.img
	$T/checkbin.sh td-div-nn.img

run-tests: td-div-nn.diff
td-div-nn.diff: td-div-nn.log $T/good/td-div-nn.good
	diff -u $T/good/td-div-nn.good td-div-nn.log > td-div-nn.diff || true
td-div-nn.log: $(SYS161) td-div-nn.img
	$(SYS161) $(SYS161FLAGS) td-div-nn.img 2>&1 | $T/cleanlog.sh > td-div-nn.log

good: td-div-nn.good
td-div-nn.good:
	cp td-div-nn.log $T/good/td-div-nn.good

.PHONY: td-div-nn.good

################################
# td-div-np

images: td-div-np.img
td-div-np.img: $T/src/td-div-np.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-div-np.S -o td-div-np.img
	$T/checkbin.sh td-div-np.img

run-tests: td-div-np.diff
td-div-np.diff: td-div-np.log $T/good/td-div-np.good
	diff -u $T/good/td-div-np.good td-div-np.log > td-div-np.diff || true
td-div-np.log: $(SYS161) td-div-np.img
	$(SYS161) $(SYS161FLAGS) td-div-np.img 2>&1 | $T/cleanlog.sh > td-div-np.log

good: td-div-np.good
td-div-np.good:
	cp td-div-np.log $T/good/td-div-np.good

.PHONY: td-div-np.good

################################
# td-div-nz

images: td-div-nz.img
td-div-nz.img: $T/src/td-div-nz.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-div-nz.S -o td-div-nz.img
	$T/checkbin.sh td-div-nz.img

run-tests: td-div-nz.diff
td-div-nz.diff: td-div-nz.log $T/good/td-div-nz.good
	diff -u $T/good/td-div-nz.good td-div-nz.log > td-div-nz.diff || true
td-div-nz.log: $(SYS161) td-div-nz.img
	$(SYS161) $(SYS161FLAGS) td-div-nz.img 2>&1 | $T/cleanlog.sh > td-div-nz.log

good: td-div-nz.good
td-div-nz.good:
	cp td-div-nz.log $T/good/td-div-nz.good

.PHONY: td-div-nz.good

################################
# td-div-pn

images: td-div-pn.img
td-div-pn.img: $T/src/td-div-pn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-div-pn.S -o td-div-pn.img
	$T/checkbin.sh td-div-pn.img

run-tests: td-div-pn.diff
td-div-pn.diff: td-div-pn.log $T/good/td-div-pn.good
	diff -u $T/good/td-div-pn.good td-div-pn.log > td-div-pn.diff || true
td-div-pn.log: $(SYS161) td-div-pn.img
	$(SYS161) $(SYS161FLAGS) td-div-pn.img 2>&1 | $T/cleanlog.sh > td-div-pn.log

good: td-div-pn.good
td-div-pn.good:
	cp td-div-pn.log $T/good/td-div-pn.good

.PHONY: td-div-pn.good

################################
# td-div-pp

images: td-div-pp.img
td-div-pp.img: $T/src/td-div-pp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-div-pp.S -o td-div-pp.img
	$T/checkbin.sh td-div-pp.img

run-tests: td-div-pp.diff
td-div-pp.diff: td-div-pp.log $T/good/td-div-pp.good
	diff -u $T/good/td-div-pp.good td-div-pp.log > td-div-pp.diff || true
td-div-pp.log: $(SYS161) td-div-pp.img
	$(SYS161) $(SYS161FLAGS) td-div-pp.img 2>&1 | $T/cleanlog.sh > td-div-pp.log

good: td-div-pp.good
td-div-pp.good:
	cp td-div-pp.log $T/good/td-div-pp.good

.PHONY: td-div-pp.good

################################
# td-div-pz

images: td-div-pz.img
td-div-pz.img: $T/src/td-div-pz.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-div-pz.S -o td-div-pz.img
	$T/checkbin.sh td-div-pz.img

run-tests: td-div-pz.diff
td-div-pz.diff: td-div-pz.log $T/good/td-div-pz.good
	diff -u $T/good/td-div-pz.good td-div-pz.log > td-div-pz.diff || true
td-div-pz.log: $(SYS161) td-div-pz.img
	$(SYS161) $(SYS161FLAGS) td-div-pz.img 2>&1 | $T/cleanlog.sh > td-div-pz.log

good: td-div-pz.good
td-div-pz.good:
	cp td-div-pz.log $T/good/td-div-pz.good

.PHONY: td-div-pz.good

################################
# td-divu-nn

images: td-divu-nn.img
td-divu-nn.img: $T/src/td-divu-nn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-divu-nn.S -o td-divu-nn.img
	$T/checkbin.sh td-divu-nn.img

run-tests: td-divu-nn.diff
td-divu-nn.diff: td-divu-nn.log $T/good/td-divu-nn.good
	diff -u $T/good/td-divu-nn.good td-divu-nn.log > td-divu-nn.diff || true
td-divu-nn.log: $(SYS161) td-divu-nn.img
	$(SYS161) $(SYS161FLAGS) td-divu-nn.img 2>&1 | $T/cleanlog.sh > td-divu-nn.log

good: td-divu-nn.good
td-divu-nn.good:
	cp td-divu-nn.log $T/good/td-divu-nn.good

.PHONY: td-divu-nn.good

################################
# td-divu-np

images: td-divu-np.img
td-divu-np.img: $T/src/td-divu-np.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-divu-np.S -o td-divu-np.img
	$T/checkbin.sh td-divu-np.img

run-tests: td-divu-np.diff
td-divu-np.diff: td-divu-np.log $T/good/td-divu-np.good
	diff -u $T/good/td-divu-np.good td-divu-np.log > td-divu-np.diff || true
td-divu-np.log: $(SYS161) td-divu-np.img
	$(SYS161) $(SYS161FLAGS) td-divu-np.img 2>&1 | $T/cleanlog.sh > td-divu-np.log

good: td-divu-np.good
td-divu-np.good:
	cp td-divu-np.log $T/good/td-divu-np.good

.PHONY: td-divu-np.good

################################
# td-divu-nz

images: td-divu-nz.img
td-divu-nz.img: $T/src/td-divu-nz.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-divu-nz.S -o td-divu-nz.img
	$T/checkbin.sh td-divu-nz.img

run-tests: td-divu-nz.diff
td-divu-nz.diff: td-divu-nz.log $T/good/td-divu-nz.good
	diff -u $T/good/td-divu-nz.good td-divu-nz.log > td-divu-nz.diff || true
td-divu-nz.log: $(SYS161) td-divu-nz.img
	$(SYS161) $(SYS161FLAGS) td-divu-nz.img 2>&1 | $T/cleanlog.sh > td-divu-nz.log

good: td-divu-nz.good
td-divu-nz.good:
	cp td-divu-nz.log $T/good/td-divu-nz.good

.PHONY: td-divu-nz.good

################################
# td-divu-pn

images: td-divu-pn.img
td-divu-pn.img: $T/src/td-divu-pn.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-divu-pn.S -o td-divu-pn.img
	$T/checkbin.sh td-divu-pn.img

run-tests: td-divu-pn.diff
td-divu-pn.diff: td-divu-pn.log $T/good/td-divu-pn.good
	diff -u $T/good/td-divu-pn.good td-divu-pn.log > td-divu-pn.diff || true
td-divu-pn.log: $(SYS161) td-divu-pn.img
	$(SYS161) $(SYS161FLAGS) td-divu-pn.img 2>&1 | $T/cleanlog.sh > td-divu-pn.log

good: td-divu-pn.good
td-divu-pn.good:
	cp td-divu-pn.log $T/good/td-divu-pn.good

.PHONY: td-divu-pn.good

################################
# td-divu-pp

images: td-divu-pp.img
td-divu-pp.img: $T/src/td-divu-pp.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-divu-pp.S -o td-divu-pp.img
	$T/checkbin.sh td-divu-pp.img

run-tests: td-divu-pp.diff
td-divu-pp.diff: td-divu-pp.log $T/good/td-divu-pp.good
	diff -u $T/good/td-divu-pp.good td-divu-pp.log > td-divu-pp.diff || true
td-divu-pp.log: $(SYS161) td-divu-pp.img
	$(SYS161) $(SYS161FLAGS) td-divu-pp.img 2>&1 | $T/cleanlog.sh > td-divu-pp.log

good: td-divu-pp.good
td-divu-pp.good:
	cp td-divu-pp.log $T/good/td-divu-pp.good

.PHONY: td-divu-pp.good

################################
# td-divu-pz

images: td-divu-pz.img
td-divu-pz.img: $T/src/td-divu-pz.S
	$(TARGETCC) $(TARGETFLAGS) $T/src/td-divu-pz.S -o td-divu-pz.img
	$T/checkbin.sh td-divu-pz.img

run-tests: td-divu-pz.diff
td-divu-pz.diff: td-divu-pz.log $T/good/td-divu-pz.good
	diff -u $T/good/td-divu-pz.good td-divu-pz.log > td-divu-pz.diff || true
td-divu-pz.log: $(SYS161) td-divu-pz.img
	$(SYS161) $(SYS161FLAGS) td-divu-pz.img 2>&1 | $T/cleanlog.sh > td-divu-pz.log

good: td-divu-pz.good
td-divu-pz.good:
	cp td-divu-pz.log $T/good/td-divu-pz.good

.PHONY: td-divu-pz.good

