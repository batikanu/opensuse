#!/bin/bash

function build-glassfish() {
    echo "--------- building glassfish container ---------"
    docker build -t oscm:glassfish glassfish-container/
}

function build-postgres() {
    echo "--------- building postgres container ---------"
    docker build -t oscm:postgres database-container/
}

function build-allinone() {
    echo "--------- building allinone container ---------"
    docker build -t oscm:allinone .
    docker run --rm -i --name allinone oscm:allinone &
    sleep 5
    clean
    docker cp allinone:/opt/glassfish3/glassfish/domains glassfish-container/
    docker cp allinone:/var/lib/pgsql/database database-container/
    docker stop allinone
    docker rm -f allinone
    cleanDomain bes-domain
    cleanDomain master-indexer-domain
}

function clean() {
  rm -rf glassfish-container/domains
  rm -rf database-container/database
}

function cleanDomain() {
  echo "cleaning $1"
  rm -rf glassfish-container/domains/$1/generated/*
  rm -rf glassfish-container/domains/$1/osgi-cache/*
  rm -f glassfish-container/domains/$1/logs/*.log
}

function build {
  build-allinone
  build-glassfish
  build-postgres
}

function run::glassfish() {
  echo "--------- starting glassfish conainer ---------"
  docker run --rm -i --net=host --name oscm-glassfish oscm:glassfish
}

function run::postgres() {
  echo "--------- starting postgres conainer ---------"
  docker run --rm -i --net=host --name oscm-postgres oscm:postgres
}

function run() {
  run::postgres &
  run::glassfish
}

function stop() {
  docker stop oscm-postgres oscm-glassfish
}

if [[ $# -eq 0 ]] ; then
     build
     run
     exit 0
fi

$*
