import csv
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def test_config_paths_has_no_hardcoded_user_profile():
    text = (ROOT / "config_paths.R").read_text(encoding="utf-8")
    forbidden = [
        "C:" + "/Users/",
        "C:" + "\\Users\\",
        "OneDrive - NHS" + "/Documents/Pairwise70",
    ]
    assert [item for item in forbidden if item in text] == []
    assert 'Sys.getenv("PAIRWISE70_ROOT"' in text
    assert "candidate_path" in text


def test_review_level_output_has_transportability_columns():
    path = ROOT / "transportability_review_level.csv"
    with path.open(newline="", encoding="utf-8-sig") as handle:
        reader = csv.DictReader(handle)
        header = reader.fieldnames or []
        first = next(reader)
    required = {
        "review_id",
        "dataset",
        "analysis_key",
        "effect_class",
        "k",
        "yi",
        "se",
        "mean_total_n",
    }
    assert required.issubset(set(header))
    assert re.match(r"CD\d+", first["review_id"])
    assert int(first["k"]) > 0
    assert float(first["se"]) > 0
