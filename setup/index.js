const inquirer = require('inquirer');
const fs = require('fs');

(async () => {
    // Read the ../bin folder
    const files = fs.readdirSync('../bin');

    // Ask the user which ones they want to install
    let answers = await inquirer.prompt([
        {
            type: 'checkbox',
            name: 'files',
            message: 'Which files do you want to install?',
            choices: files,
        },
    ]);

    // Copy the selected files to the current folder
    for (let i = 0; i < answers.files.length; i++) {
        const file = answers.files[i];
        fs.copyFileSync(`../bin/${file}`, `/usr/bin/${file}`); // Copy the file
    }

    if (answers.files.length > 0) console.log(`Installed ${answers.files.length} binar${answers.files.length == 1 ? 'y' : 'ies'}!`)

    // Exit the process
    process.exit(0);
})();