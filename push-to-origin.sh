#!/bin/sh

git add .
git commit -m "Atualizando n-bak e enviando para o origin"
git push origin main

exec $SHELL
