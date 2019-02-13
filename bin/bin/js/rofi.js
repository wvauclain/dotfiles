const { execSync, spawn } = require("child_process");

module.exports.Option = class {
  constructor(name, command) {
    // The name to be seen on the rofi menu
    this.name = name;
    // A `Command` object representing this option's command
    this.command = command;
  }
};

// A Command object holds the name and arguments of a command. This is meant to be used for the first two arguments of
// child_process.spawn()
module.exports.Command = class {
  constructor(name, args) {
    // The name of the command (what is run in the terminal)
    this.name = name;
    // The arguments for the command in a String[]
    this.args = args;
  }
};

module.exports.selectOptionAndRun = function(options) {
  // Execute rofi, passing in the name of each possible option and store the selected option name in
  // `selection`. Note: '|| true' at the end of the command prevents node from throwing an exception on no input.
  const selection = execSync(
    `echo '${options.map(x => x.name).join("\n")}' | rofi -dmenu || true`,
    { encoding: "utf8" }
  ).trim();

  // Get the selected `Option` by filtering through `options` to find the one with the name `selection`
  const selectedOption = options.find(x => x.name == selection);

  if (selectedOption) {
    // Spawn the selected command with its options and name, then detach and unref so that node can exit.
    spawn(selectedOption.command.name, selectedOption.command.args, {
      detached: true,
      stdio: "ignore"
    }).unref();
  } else {
    console.log("No option selected. Terminating...");
  }
};
