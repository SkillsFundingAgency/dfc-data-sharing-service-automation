In a CMD window in the root of the repo:

1. `behave Features -f allure_behave.formatter:AllureFormatter -o Report_Json -D ENV=PP`
2. `allure generate Report_Json -o Report_Html --clean`
3. `allure open Report_Html`