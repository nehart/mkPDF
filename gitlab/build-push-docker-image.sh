#!/bin/sh

cd "${CI_PROJECT_DIR}/tmpl"

docker login -u ${CI_REGISTRY_USER} -p ${CI_JOB_TOKEN} registry.ans.co.at

IMAGEVERSION=$(cat dockerfile | grep ENV.*MKPDF_VERSION | cut -d "=" -f2 | sed -e 's/"//g' | cut -d "-" -f1)

docker build --file dockerfile --tag registry.ans.co.at/templates/mkpdf/mkpdf:V${IMAGEVERSION}-B${CI_COMMIT_TAG} .
docker push registry.ans.co.at/templates/mkpdf/mkpdf:V${IMAGEVERSION}-B${CI_COMMIT_TAG}

docker build --file dockerfile --tag registry.ans.co.at/templates/mkpdf/mkpdf:latest .
docker push registry.ans.co.at/templates/mkpdf/mkpdf:latest

cd "${CI_PROJECT_DIR}"
