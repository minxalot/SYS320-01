#!/bin/bash

ip addr | grep "brd" | grep -v "link" | cut -d ' ' -f 6 | cut -d '/' -f 1
