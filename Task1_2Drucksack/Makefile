build: format
	env GOOS=linux go build -ldflags="-s -w" -o ./bin *.go

build_mac: format
	env GOOS=darwin go build -ldflags="-s -w" -o ./bin *.go
tidy:
	go mod tidy

format:
	gofmt -w -l ./

import:
	goimports -e -d -w ./

inspect:
	cat -e -t -v Makefile

test:
	go test ./...
