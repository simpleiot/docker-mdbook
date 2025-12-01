# Stage 1: Builder
FROM rust:alpine3.21 AS builder

RUN apk add --no-cache musl-dev openssl-dev perl make

RUN cargo install mdbook --version 0.5.1 && \
    cargo install mdbook-toc --version 0.15.0 && \
    cargo install mdbook-linkcheck --version 0.7.7 && \
    cargo install mdbook-epub --version 0.4.48 && \
    cargo install mdbook-mermaid --version 0.16.0 && \
    cargo install mdbook-open-on-gh --version 2.4.3

# Stage 2: Runtime
FROM alpine:3.21

LABEL org.opencontainers.image.source=https://github.com/simpleiot/docker-mdbook

RUN apk add --no-cache libgcc

COPY --from=builder /usr/local/cargo/bin/mdbook /usr/local/bin/
COPY --from=builder /usr/local/cargo/bin/mdbook-toc /usr/local/bin/
COPY --from=builder /usr/local/cargo/bin/mdbook-linkcheck /usr/local/bin/
COPY --from=builder /usr/local/cargo/bin/mdbook-epub /usr/local/bin/
COPY --from=builder /usr/local/cargo/bin/mdbook-mermaid /usr/local/bin/
COPY --from=builder /usr/local/cargo/bin/mdbook-open-on-gh /usr/local/bin/

WORKDIR /book

ENTRYPOINT ["mdbook"]
