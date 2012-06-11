#!/bin/bash
nanoc compile
scp -r output/* pelletier.im:www/thomas
