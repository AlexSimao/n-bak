#!/bin/sh

git add .
git commit -m "Atualizando: git push to origin"
git push origin main

exec $SHELL
