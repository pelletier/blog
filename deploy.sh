#!/bin/bash
nanoc compile
scp -r output/* ssh.pelletier.im:www/thomas
