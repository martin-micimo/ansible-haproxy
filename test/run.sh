#!/bin/bash

source ansible-venv/bin/activate

time molecule test
