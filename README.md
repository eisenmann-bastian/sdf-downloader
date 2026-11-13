# SDF Downloader

Download molecular structures from [PubChem](https://pubchem.ncbi.nlm.nih.gov/)
as SDF files using identifiers in a CSV file. The command processes each row,
reports failures, and continues with subsequent rows.

## Installation

Requires Python 3.10 or later and network access to PubChem for downloads.
From the repository root:

```sh
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
```

On Windows, activate the environment using `.venv\Scripts\activate` instead.
Alternatively, install this repository as a Python package with
`python -m pip install .`. This provides the `sdf-downloader` command and
the `sdf_downloader.downloader.download_csv` Python API. The existing
`python downloader.py` interface remains available.

## Quick start

```sh
python downloader.py examples/sample.csv --output-dir sdf
```

The CSV needs a header and at least one of these case-insensitive columns:
`cid`, `name`, `inchi`, `smiles`, or `formula`. Other columns are ignored.
For each row, the first nonempty value in that order is used. Lower-priority
identifiers are not fallback searches.

```csv
cid,name,inchi,smiles,formula
241,,,,
,benzene,,,
,,,CCO,
```

See [sample.csv](examples/sample.csv) for rows containing all identifier types,
and [sample-mixed.csv](examples/sample-mixed.csv) for different identifiers in
different rows. [sample-usage.sh](examples/sample-usage.sh) demonstrates both
files; it makes network requests and does not remove existing output.

## Options and behavior

```sh
python downloader.py compounds.csv \
  --output-dir structures \
  --record-type 3d \
  --filter-mode identity \
  --result-selection exact
python downloader.py --help
```

| Option | Description |
| --- | --- |
| `-o`, `--output-dir` | Output directory; defaults to `sdf`. Created if necessary. |
| `--delimiter` | Single-character input delimiter; defaults to a comma. |
| `--record-type` | `3d` (default) or `2d`. A missing 3D record is an error, not an automatic 2D fallback. |
| `--filter-mode` | SMILES search type: `identity` (default), `substructure`, `superstructure`, or `similarity`. |
| `--result-selection` | For SMILES and formula searches: `exact` (default), `first`, or `all`. |

`exact` requires exactly one distinct CID, `first` selects the first returned
CID, and `all` downloads every distinct returned CID. SMILES searches other
than identity and formula searches may return many different compounds.
CID, name, and InChI rows are fetched directly; result selection does not apply
to them.

Each successful download is saved as `row-<CSV line>-cid-<CID>.sdf`. Existing
files are never overwritten. Each returned SDF must contain exactly one complete
record with a unique PubChem CID. Missing, ambiguous, malformed, or failed
results are logged as errors. With `all`, a failed CID does not prevent attempts
for the remaining CIDs. The command exits nonzero if any row fails.

## Tests

Tests use mocked PubChem calls and do not require network access. Install the
dependencies first, then run:

```sh
./test.sh
```

Set `PYTHON` to select an interpreter, for example `PYTHON=.venv/bin/python
./test.sh`. Alternatively, use `python -m unittest discover -s tests -t . -v`
from the repository root.

## Repository layout

```text
downloader.py       CSV processing and CLI
logging_config.py   Console logging
requirements.txt    Runtime dependency
examples/           Sample CSV files and usage script
tests/              Offline unit and CLI tests
test.sh             Test runner
```

## License

[BSD 3-Clause License](LICENSE).
