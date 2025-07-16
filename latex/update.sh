#!/bin/bash

# Save manually installed TeX Live packages
sudo tlmgr info --only-installed --data name,category | cut -d',' -f1 > $BLEM/latex/packages
