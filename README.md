# Data Sharing Service API Automation Testing - Behave & Allure

## Pre-reqs

1. Python

   - Download and install Python ([here](https://www.python.org/downloads/))

2. Java JDK

   - Install the Java JDK from the [Oracle Website](https://www.oracle.com/java/technologies/downloads/?er=221886).

3. Modify Windows Environment Variables

   - Access the Windows Environment Variables
   - Add a new entry under 'system variables' for `JAVA_HOME` - for the valuue, you should use the directory path for the JDK (ie `C:\Program Files\Java\jdk-24`)
   - Save and apply the changes

4. Allure

   - Launch PowerShell (not as an administrator)
   - Paste and execute the following commands, one after another, to allow external installations:
  
     `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
  
     `Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression`
   - Next, install Allure:
  
     `scoop install allure`
   - To confirm installation, run:
  
     `allure --version`

5. Package dependencies

   - Open a CMD window at the root of the repo
   - Execute the following command to install package dependencies:

     `pip install -r requirement.txt`

## Execution

1. Update environment configuration

   - Open the [settings.json](utilities/env-config/settings.json) file
   - Replace the `<replace me>` holding text with valid values for the various different data items

2. Execute tests

   - Open a CMD window at the root of the repo
   - Execute the following command to run the test cases (valid 'ENV' values include; `AT`, `TEST`, `OAT`, `PP`, `PRD`):

     `behave Features -f allure_behave.formatter:AllureFormatter -o Report_Json -D ENV=<REPLACE ME>`
   - You can run specific tests with tags by adding `--tags=<REPLACE ME>` to the end of the above line
3. Generate report

   - Execute the following command to convert the JSON test execution output into a HTML report:

     `allure generate Report_Json -o Report_Html --clean`

4. Launch report

   - Execute the following command to launch the HTML report:

     `allure open Report_Html`

> [!NOTE]  
> Launching the HTML file on it's own (ie without this command) will not work due to a local CORS error

## Useful information
- Environment specific configuration can be found within the [settings.json](utilities/env-config/settings.json) file - you will need to keep this up-to-date

> [!CAUTION]
> You **MUST NOT** commit changes to this file which contain valid values as this risks revealing secrets in plain text in GIT

- If you'd like to debug test steps using logging, you need to:
  1. Add `import logging` at the top of the file
  2. Write desired logs - ie `logging.warning('this is a warning')`
  3. Add the `--no-logcapture` argument to the execution command - _by default logs are only shown in the event of failure_

## Useful links
- [Command-Line Arguments - Behave Docs](https://behave.readthedocs.io/en/stable/behave.html)