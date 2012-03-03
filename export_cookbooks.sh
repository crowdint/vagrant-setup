#!/bin/bash

tar -cf cookbooks.tar.gz cookbooks/;
mv cookbooks.tar.gz downloads/;

echo " * Cookbooks exported to downloads/ folder.";
ls -lh downloads/;
