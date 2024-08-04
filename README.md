# gemini_survival

## github page 배포 순서
- master branch
flutter build web
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Initialize gh-pages branch"
git push origin gh-pages
git checkout master

## 새로운 디렉토리에 gh-pages 브랜치를 체크아웃
git worktree add -B gh-pages gh-pages origin/gh-pages

## 빌드 파일을 복사
cp -r build/web/* gh-pages/

## gh-pages 디렉토리로 이동하여 커밋 및 푸시
cd gh-pages
git add .
git commit -m "Deploy web build"
git push origin gh-pages

## 원래 디렉토리로 돌아옴
cd ..
