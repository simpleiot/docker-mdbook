# Plan: Docker mdbook Dockerfile

## Overview

Create a Dockerfile that packages mdbook with commonly used plugins as described in README.md.

## Requirements from README.md

The Dockerfile needs to include:

- `mdbook` (v0.5.1)
- `mdbook-toc`
- `mdbook-linkcheck`
- `mdbook-epub`
- `mdbook-mermaid`
- `mdbook-open-on-gh`

## Implementation Plan

### Step 1: Create Dockerfile

Create a multi-stage Dockerfile:

1. **Builder stage**: Use Rust Alpine image to compile mdbook and plugins from source

   - Use `rust:alpine3.21` as base image for building
   - Install musl-dev and required build dependencies
   - Install mdbook v0.5.1 specifically
   - Install all plugins via cargo install

2. **Runtime stage**: Use minimal Alpine base image
   - Use `alpine:3.21` as runtime base
   - Copy compiled binaries from builder stage
   - Set up working directory and entrypoint

**Fallback**: If Alpine has compatibility issues with any plugins, fall back to Debian-based images.

### Step 2: Plugins to Install

| Plugin            | Purpose                      |
| ----------------- | ---------------------------- |
| mdbook            | Core book generator (v0.5.1) |
| mdbook-toc        | Table of contents generation |
| mdbook-linkcheck  | Check for broken links       |
| mdbook-epub       | Generate EPUB output         |
| mdbook-mermaid    | Mermaid diagram support      |
| mdbook-open-on-gh | Add "Edit on GitHub" links   |

### Step 3: Dockerfile Structure

```dockerfile
# Stage 1: Builder
FROM rust:alpine3.21 AS builder
# Install build dependencies (musl-dev, etc.)
# Install mdbook and plugins

# Stage 2: Runtime
FROM alpine:3.21
# Copy binaries
# Set entrypoint
```

## Files to Create

- `Dockerfile` - Main dockerfile with all mdbook tools

## Notes

- Using multi-stage build to minimize final image size
- mdbook-toc is listed twice in README - will install once
- Need to verify all plugins are compatible with mdbook 0.5.1
