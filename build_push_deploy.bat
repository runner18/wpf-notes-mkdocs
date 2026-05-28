set /p "message=Enter Commit Message:"
mkdocs build
mkdocs gh-deploy
git add .
git commit --message "%message%"
git push
pause