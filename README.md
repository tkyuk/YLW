# Notes Repository

마크다운(.md)으로 노트를 작성하면 GitHub Actions가 자동으로 HTML로 변환해서
`gh-pages` 브랜치에 배포하고, GitHub Pages로 게시합니다.

## 폴더 구조

```
notes/
  _template.md          # 새 노트 작성 시 복사해서 쓰는 템플릿
  erp-개발/
    2026-08-10-erp-프로젝트-개요.md   # 예시 노트
scripts/
  build_notes.py         # notes/**.md -> dist/**.html 변환 스크립트
  requirements.txt
.github/
  workflows/
    build-html.yml        # main push 시 자동 빌드 & gh-pages 배포
```

## 새 노트 작성 방법

1. `notes/_template.md` 파일을 복사해서 원하는 하위 폴더(예: `notes/erp-개발/`)에
   새 파일로 저장합니다. 파일명은 자유롭게 정하되, 날짜를 앞에 붙이는 것을 권장합니다.
   예: `notes/erp-개발/2026-08-11-회의록.md`

2. 파일 상단의 프론트매터(frontmatter)를 채웁니다.

   ```markdown
   ---
   title: 노트 제목
   date: 2026-08-11
   tags: [erp, 회의록]
   ---

   # 노트 제목

   본문 내용을 마크다운으로 작성합니다.
   ```

3. `main` 브랜치에 커밋 & push 하면 GitHub Actions가 자동으로:
   - `notes/` 안의 모든 `.md` 파일을 HTML로 변환
   - 변환 결과를 `gh-pages` 브랜치에 push
   - GitHub Pages가 `gh-pages` 브랜치를 소스로 자동 게시

   > 파일명이 `_`로 시작하는 파일(예: `_template.md`)은 변환 대상에서 제외됩니다.

## GitHub Pages 활성화 (최초 1회 설정)

1. 저장소 GitHub 페이지에서 **Settings → Pages**로 이동합니다.
2. **Source**를 `Deploy from a branch`로 설정합니다.
3. **Branch**를 `gh-pages` / `/(root)`로 선택하고 저장합니다.
4. 워크플로가 처음 실행되어 `gh-pages` 브랜치가 생성된 이후에만 이 옵션이 보입니다.
   (즉, `main`에 최소 한 번 push 해서 워크플로가 성공적으로 돌고 난 뒤 설정하세요.)

## 로컬에서 미리보기 (선택)

```bash
pip install -r scripts/requirements.txt
python scripts/build_notes.py
# dist/index.html 을 브라우저로 열어서 확인
```

## 워크플로 동작 조건

`.github/workflows/build-html.yml`은 다음 경로가 변경된 채로 `main`에 push될 때만 실행됩니다.

- `notes/**`
- `scripts/build_notes.py`
- `.github/workflows/build-html.yml`
