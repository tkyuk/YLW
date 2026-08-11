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

## OneNote에서 일괄 가져오기

기존 OneNote 노트를 한 번에 마크다운으로 옮길 때 사용하는 도구입니다.

1. OneNote 데스크톱 앱에서 섹션 단위로 **파일 → 내보내기 → 범위: 섹션 → 형식: Word(.docx)** 로 내보내
   `C:\WorkSpace\AI\_onenote-export\` 폴더에 저장합니다. (섹션명 그대로 파일명 사용, 여러 섹션 가능)
2. PowerShell에서 변환 스크립트를 실행합니다.

   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts\import-onenote.ps1
   ```

   - pandoc(포터블, `_tools/`에 위치, git에는 미포함)으로 `.docx`를 마크다운으로 변환합니다.
   - OneNote 페이지 구분 패턴(제목 → 날짜 → 시간)을 인식해 페이지별로 노트 파일을 분리합니다.
   - WMF/EMF 이미지는 PNG로 자동 변환합니다.
   - 각 섹션은 `notes/erp-개발/<섹션명>/` 폴더로, 이미지는 `assets/<페이지-slug>/`로 저장됩니다.

3. 변환 후 이미지 참조가 깨지지 않았는지 확인하려면:

   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts\verify-images.ps1
   ```

4. `_onenote-export/`, `_tools/`는 `.gitignore`에 포함되어 있어 커밋되지 않습니다.
   결과물(`notes/**.md`, `notes/**/assets/**`)만 커밋하면 됩니다.

## OneNote 자동 동기화 (매일 1회)

OneNote 데스크톱 앱의 COM 자동화(Interop) API를 이용해, 파일 → 내보내기를 수동으로
하지 않아도 변경된/새 페이지만 감지해서 자동으로 git에 반영합니다.

- **동작 방식**: `scripts/sync-onenote.ps1`이 OneNote 전체 계층(노트북/섹션/페이지)을 조회하고,
  각 페이지의 `lastModifiedTime`을 이전 동기화 기록(`_onenote-export/sync-state.json`, 로컬 전용)과
  비교해서 새 페이지·수정된 페이지만 내보내기(Publish) → pandoc 변환 → 이미지 처리 →
  `notes/erp-개발/<섹션명>/*.md` 로 저장합니다. 변경 사항이 있으면 자동으로 `git commit` & `push`까지 수행합니다.
- **삭제된 페이지**: OneNote에서 삭제된 페이지는 대응하는 노트 파일/이미지도 함께 삭제됩니다.
- **예약 실행**: Windows 작업 스케줄러에 `OneNote-YLW-Sync` 작업으로 등록되어 있으며,
  **매일 오전 9시**에 자동 실행됩니다. (해당 시각에 PC가 켜져 있고 로그인되어 있어야 합니다.)
  - 등록/재등록: `powershell -ExecutionPolicy Bypass -File scripts\register-onenote-sync-task.ps1`
  - 수동 실행: `powershell -ExecutionPolicy Bypass -File scripts\sync-onenote.ps1`
  - 실행 시간 변경: 작업 스케줄러(taskschd.msc)에서 `OneNote-YLW-Sync` 작업의 트리거 시간을 수정
  - 실행 로그: `_onenote-export/sync-logs/`
- **참고**: 실시간 반영이 아니라 하루 1회 폴링 방식입니다. 급하게 반영이 필요하면 수동 실행하면 됩니다.
- **최초 1회**: 이미 수동으로 임포트된 섹션은 `scripts/seed-sync-state.ps1`로 baseline 처리를 해두었습니다.
  (이미 노트 폴더가 존재하는 섹션은 최초 실행 시 건너뛰고, 새 섹션만 처음 동기화됨)
