# Repository Guidelines

## Project Structure & Module Organization
- `Dockerfile` builds the Python image from `kernel528/alpine`.
- `README.md` documents usage; `VERSION.md` tracks release history.
- CI/CD config is in `.drone.yml`.

## Build, Test, and Development Commands
- Build locally:
  ```sh
  docker build -t kernel528/python:3.14.6 -f Dockerfile .
  ```
- Run a quick smoke test:
  ```sh
  docker run -it --rm --name python3 kernel528/python:3.14.6 python --version
  ```

## Coding Style & Naming Conventions
- Keep the Dockerfile aligned with upstream `docker-library/python` Alpine templates.
- Prefer explicit tags in docs (avoid `latest` unless necessary).
- Update tags consistently across `Dockerfile`, `.drone.yml`, `README.md`, and `VERSION.md`.

## Testing Guidelines
- No automated tests are included; validate with `python --version` and a short REPL run.
- If build deps change, confirm import of common modules (e.g., `ssl`, `sqlite3`).

## Commit & Pull Request Guidelines
- Commit messages should be concise and descriptive (e.g., “Update base image to 3.23.3.”).
- Version branch → `3.14` → `main`, then tag from `main`.
- PRs should update `VERSION.md` and any README examples affected by tag changes.

## Security & Configuration Tips
- Keep `PYTHON_SHA256` in sync with the downloaded tarball.
- Maintain `ca-certificates` and `tzdata` for TLS and correct time handling.
