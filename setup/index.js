const inquirer = require('inquirer');
const fs = require('fs');

(async () => {
    const OS = process.platform;

    if (OS !== 'linux') {
        const res = inquirer.prompt([
            {
                type: 'confirm',
                name: 'continue',
                message: 'This setup is only for Linux. Do you want to continue anyway?',
                default: false
            }
        ])

        if (!res.continue) {
            console.log('Exiting...');
            process.exit();
        }
    }

    const osRelease = fs.readFileSync('/etc/os-release', 'utf8');
    // eg. [ubuntu, debian, linuxmint] or [arch]
    const distros = osRelease.split('\n').find(line => line.startsWith('ID_LIKE=')).split('=')[1].split(' ').push(osRelease.split('\n').find(line => line.startsWith('ID=')).split('=')[1]);

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

    // Check if the system is debian based
    if (distros.includes('debian')) {
        // Show select menu for useful packages (default: all)
        console.log('Hey, it seems you are using a Debian-based system. Heres some useful packages you might want to install:')

        const usefulPackages = [
            'ffmpeg'
        ]

        answers = await inquirer.prompt([
            {
                type: 'checkbox',
                name: 'packages',
                message: 'Which useful packages do you want to install?',
                choices: usefulPackages,
                default: usefulPackages,
            },
        ]);

        answers.packages.forEach(package => {
            console.log(`Installing ${package}...`);
            require('child_process').execSync(`apt install ${package} -y`, {
                stdio: 'inherit'
            });
        });

        const programs = [
            'Brave Browser',
            'Visual Studio Code',
            'Discord Canary',
            'GDLauncher',
            'Insomnia',
            'FileZilla',
            'OBS Studio',
            'Notesnook',
            'Proton VPN'
        ]
    
        answers = await inquirer.prompt([
            {
                type: 'checkbox',
                name: 'programs',
                message: 'Which programs do you want to install?',
                choices: programs,
                default: programs,
            },
        ]);

        const programsToInstall = {
            'Brave Browser': 'brave-browser',
            'Visual Studio Code': 'code',
            'Discord (Canary)': 'discord-canary',
            'Discord (Stable)': 'discord',
            'GDLauncher': 'gdlauncher',
            // 'Insomnia': 'insomnia',
            // 'FileZilla': 'filezilla',
            // 'OBS Studio': 'obs-studio',
            // 'Notesnook': 'notesnook',
            // 'Proton VPN': 'protonvpn'
        }

        answers.programs.forEach(program => {
            console.log(`Installing ${program}...`);
            // Run the install script in ../scripts/install/program.sh
            require('child_process').execSync(`../scripts/install/${programsToInstall[program]}.sh`, {
                stdio: 'inherit'
            });
        });

        console.log('Finished installing programs!');
    }

    // Exit the process
    process.exit(0);
})();