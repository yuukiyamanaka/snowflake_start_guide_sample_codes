#!/bin/bash
POETRY_VERSION=$(cat .poetry-version)
pip install poetry==$POETRY_VERSION
