#!/bin/bash

# copiando os arquivos para o repositório

# ------------------------------------
# repo_psiu
cp -Rfa /arquivos/repositorio/repo ~/backup
# ------------------------------------

# navegando para o repositório
cd ~/backup

# realizando o dumps nos dbs do mongo
# ------------------------------------
# awesome_db
mongodump --uri "mongodb://user:password@127.0.0.1:27017/awesome_db" --gzip --archive=awesome_backup
# ------------------------------------
# enviando as alterações
git add .
git commit -m 'realizando o backup'
git push

rm -rf awesome_backup repo/
