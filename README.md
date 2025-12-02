# Docker mdbook

A lightweight Docker image with mdbook and commonly used plugins pre-installed.

## Included Tools

| Tool               | Version | Description                  |
| ------------------ | ------- | ---------------------------- |
| `mdbook`           | 0.5.1   | Core book generator          |
| `mdbook-toc`       | 0.15.0  | Table of contents generation |
| `mdbook-linkcheck` | 0.7.7   | Check for broken links       |
| `mdbook-epub`      | 0.4.48  | Generate EPUB output         |
| `mdbook-mermaid`   | 0.16.0  | Mermaid diagram support      |
| `mdbook-open-on-gh`| 2.4.3   | Add "Edit on GitHub" links   |

## Usage

Build your book:

```bash
docker run --rm --user $(id -u):$(id -g) -v $(pwd):/book mdbook:0.5.1 build
```

Serve your book locally with live reload:

```bash
docker run --rm --user $(id -u):$(id -g) -v $(pwd):/book -p 3000:3000 mdbook:0.5.1 serve -n 0.0.0.0
```

Run link checking:

```bash
docker run --rm --user $(id -u):$(id -g) -v $(pwd):/book mdbook:0.5.1 test
```

The `--user $(id -u):$(id -g)` flag ensures generated files are owned by your user instead of root.

## Building the Image

```bash
docker build -t mdbook:0.5.1 .
```

## Publishing to GitHub Container Registry

Tag and push the image to the Simple IoT GitHub registry:

```bash
docker tag mdbook:0.5.1 ghcr.io/simpleiot/mdbook:0.5.1
docker push ghcr.io/simpleiot/mdbook:0.5.1
```

To authenticate with the registry, [create a GitHub personal access token](https://github.com/settings/tokens) with `write:packages` scope and run:

```bash
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
```
