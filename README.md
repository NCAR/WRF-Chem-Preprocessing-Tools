To download the entire repository: 



**To download indivivual packages using git:** br /
(see also: https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository) br /
  mkdir mozbc br /
  cd mozbc br /
  git init br /
  git remote add -f origin git@github.com:NCAR/WRF-Chem-Preprocessing-Tools.git br /
  git config core.sparseCheckout true br /
  echo "mozbc" >> .git/info/sparse-checkout  br /
  git pull origin main br /


