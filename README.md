To download the entire repository: 




**To download indivivual packages using git:**

(see also: https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository)

mkdir mozbc

cd mozbc

git init

git remote add -f origin git@github.com:NCAR/WRF-Chem-Preprocessing-Tools.git

git config core.sparseCheckout true

echo "mozbc" >> .git/info/sparse-checkout 

git pull origin main


