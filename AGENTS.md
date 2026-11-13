# Project instructions

- Preserve the packaged API and the `python downloader.py` entry point,
  per-row error reporting, PubChem lookup semantics, and no-overwrite behavior.
- Use `molecular_utilities.logging` through `logging_config.py` with the
  `sdf_downloader` namespace; configure logging at the CLI entry point only.
- Update tests, examples, and the [README](README.md) for behavior changes.
  Run `./test.sh` in an installed environment; tests mock PubChem.
- Live example downloads need network access and should use a new output
  directory rather than replacing existing results.
