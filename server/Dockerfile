
FROM golang:1.22-alpine3.20 AS build
WORKDIR /go/src/app

COPY go.mod go.sum ./
RUN go mod download


COPY *.go ./
COPY generated ./generated

RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/app .
RUN echo "appuser:x:10001:10001:App User:/:/sbin/nologin" > /etc/minimal-passwd


FROM scratch

COPY --from=build /go/bin/app /go/bin/app

COPY --from=build /etc/minimal-passwd /etc/passwd
USER appuser

EXPOSE 50051
ENTRYPOINT [ "/go/bin/app" ]