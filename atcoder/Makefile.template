COMP = gcc
SRC = main.c
BIN = main

all: test

$(BIN): $(SRC)
	$(COMP) -o $(BIN) $(SRC)

.PHONY: run
run: $(BIN)
	./$(BIN)

.PHONY: test
test: $(BIN)
	oj t -c "./$(BIN)" -d test

.PHONY: clean
clean:
	rm -f $(BIN)
