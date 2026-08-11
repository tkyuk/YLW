#!/usr/bin/env python3
"""
notes/ 폴더 안의 모든 .md 파일을 HTML로 변환해서 dist/ 폴더에 출력합니다.
- YAML 프론트매터(title, date, tags)를 읽어 노트 상단에 표시합니다.
- 파일명이 '_'로 시작하는 파일(템플릿 등)은 변환에서 제외합니다.
- 변환된 노트 목록을 모은 index.html을 dist/에 생성합니다.
"""
import re
import shutil
from pathlib import Path

import markdown
import yaml

ROOT = Path(__file__).resolve().parent.parent
NOTES_DIR = ROOT / "notes"
DIST_DIR = ROOT / "dist"

FRONTMATTER_RE = re.compile(r"^---\s*\n(.*?)\n---\s*\n(.*)$", re.DOTALL)

PAGE_TEMPLATE = """<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{title}</title>
<link rel="stylesheet" href="{css_path}style.css">
</head>
<body>
<div class="container">
  <a class="back-link" href="{index_path}index.html">&larr; 목록으로</a>
  <header class="note-header">
    <h1>{title}</h1>
    <div class="meta">
      {date_html}
      {tags_html}
    </div>
  </header>
  <article class="note-body">
    {body_html}
  </article>
</div>
</body>
</html>
"""

INDEX_TEMPLATE = """<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notes</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
  <h1>📒 Notes</h1>
  {sections_html}
</div>
</body>
</html>
"""

CSS = """
* { box-sizing: border-box; }
body {
  font-family: -apple-system, "Segoe UI", "Malgun Gothic", sans-serif;
  background: #f7f7f9;
  color: #222;
  margin: 0;
  padding: 2rem 1rem;
  line-height: 1.7;
}
.container { max-width: 800px; margin: 0 auto; }
h1 { font-size: 1.8rem; }
.back-link { display: inline-block; margin-bottom: 1rem; color: #4a5cff; text-decoration: none; }
.back-link:hover { text-decoration: underline; }
.note-header { border-bottom: 1px solid #ddd; margin-bottom: 1.5rem; padding-bottom: 1rem; }
.meta { color: #666; font-size: 0.9rem; margin-top: 0.5rem; }
.tag {
  display: inline-block;
  background: #eef0ff;
  color: #4a5cff;
  border-radius: 999px;
  padding: 0.1rem 0.7rem;
  margin-right: 0.3rem;
  font-size: 0.8rem;
}
.note-body pre { background: #282c34; color: #eee; padding: 1rem; overflow-x: auto; border-radius: 6px; }
.note-body code { background: #eee; padding: 0.1rem 0.3rem; border-radius: 4px; }
.note-body pre code { background: none; padding: 0; }
.folder-section { margin-bottom: 2rem; }
.folder-section h2 { font-size: 1.2rem; border-bottom: 2px solid #4a5cff; display: inline-block; }
ul.note-list { list-style: none; padding: 0; }
ul.note-list li {
  background: #fff;
  border: 1px solid #e3e3e8;
  border-radius: 8px;
  padding: 0.8rem 1rem;
  margin-bottom: 0.6rem;
}
ul.note-list a { text-decoration: none; color: #222; font-weight: 600; }
ul.note-list a:hover { color: #4a5cff; }
ul.note-list .note-date { color: #888; font-size: 0.85rem; margin-left: 0.5rem; }
"""


def parse_note(md_path: Path):
    text = md_path.read_text(encoding="utf-8")
    match = FRONTMATTER_RE.match(text)
    meta = {}
    body = text
    if match:
        try:
            meta = yaml.safe_load(match.group(1)) or {}
        except yaml.YAMLError:
            meta = {}
        body = match.group(2)

    title = meta.get("title") or md_path.stem
    date = str(meta.get("date") or "")
    tags = meta.get("tags") or []
    if isinstance(tags, str):
        tags = [t.strip() for t in tags.split(",") if t.strip()]

    body_html = markdown.markdown(
        body, extensions=["extra", "tables", "toc", "fenced_code", "sane_lists"]
    )
    return title, date, tags, body_html


def build():
    if DIST_DIR.exists():
        shutil.rmtree(DIST_DIR)
    DIST_DIR.mkdir(parents=True)
    (DIST_DIR / "style.css").write_text(CSS, encoding="utf-8")

    if not NOTES_DIR.exists():
        print("notes/ 폴더가 없습니다.")
        return

    md_files = sorted(
        p for p in NOTES_DIR.rglob("*.md") if not p.name.startswith("_")
    )

    # 노트 안에서 참조하는 이미지 등 정적 파일(예: assets/*)을 dist로 함께 복사
    asset_files = [
        p for p in NOTES_DIR.rglob("*")
        if p.is_file() and p.suffix.lower() != ".md"
    ]
    for asset_path in asset_files:
        rel = asset_path.relative_to(NOTES_DIR)
        dest = DIST_DIR / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(asset_path, dest)
    if asset_files:
        print(f"정적 파일(이미지 등) {len(asset_files)}개 복사 완료")

    sections: dict[str, list[dict]] = {}

    for md_path in md_files:
        rel = md_path.relative_to(NOTES_DIR)
        depth = len(rel.parts)  # notes/<folder>/.../file.md 기준 깊이
        title, date, tags, body_html = parse_note(md_path)

        out_rel = rel.with_suffix(".html")
        out_path = DIST_DIR / out_rel
        out_path.parent.mkdir(parents=True, exist_ok=True)

        css_path = "../" * (depth - 1) if depth > 1 else ""
        index_path = css_path

        date_html = f'<span class="note-date">{date}</span>' if date else ""
        tags_html = "".join(f'<span class="tag">#{t}</span>' for t in tags)

        out_path.write_text(
            PAGE_TEMPLATE.format(
                title=title,
                css_path=css_path,
                index_path=index_path,
                date_html=date_html,
                tags_html=tags_html,
                body_html=body_html,
            ),
            encoding="utf-8",
        )

        folder = str(rel.parent) if str(rel.parent) != "." else "(root)"
        sections.setdefault(folder, []).append(
            {
                "title": title,
                "date": date,
                "href": out_rel.as_posix(),
            }
        )
        print(f"converted: {rel} -> {out_rel}")

    sections_html_parts = []
    for folder in sorted(sections.keys()):
        items = sorted(sections[folder], key=lambda n: n["date"], reverse=True)
        items_html = "\n".join(
            f'<li><a href="{n["href"]}">{n["title"]}</a>'
            f'<span class="note-date">{n["date"]}</span></li>'
            for n in items
        )
        sections_html_parts.append(
            f'<div class="folder-section"><h2>{folder}</h2>'
            f'<ul class="note-list">{items_html}</ul></div>'
        )

    index_html = INDEX_TEMPLATE.format(
        sections_html="\n".join(sections_html_parts)
        or "<p>아직 노트가 없습니다.</p>"
    )
    (DIST_DIR / "index.html").write_text(index_html, encoding="utf-8")
    print(f"\n총 {len(md_files)}개 노트 변환 완료 -> {DIST_DIR}")


if __name__ == "__main__":
    build()
