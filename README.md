# gemini_survival

## github page 배포 순서
- master branch
flutter build web
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Initialize gh-pages branch"
git push origin gh-pages
git checkout master

git add build/web -f
git commit -m "Add web build files"
git subtree push --prefix build/web origin gh-pages