#! /bin/bash

# shopt -s extglob
# function foo()
# {
# shopt -s extglob;
# ls !(_)*.sample;
# shopt -u extglob
# }
# shopt -u extglob

# foo


shopt -s extglob
function test {
    shopt -s extglob
    ls -1 !(_*)
    shopt -u extglob
}
shopt -u extglob

test

