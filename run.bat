@echo off
rmdir /s /q .\robotframework\reports\1-search_function
python -m robot -d .\robotframework\reports\1-search_function .\robotframework\integrations\1-search_function