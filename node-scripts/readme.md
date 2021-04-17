# Writing & building a node script

1. Create the script in `src/` (ie: `touch src/new-script.js`)
2. Write your script
3. Add the script name (without `.js` file extension) into `script-list`
4. Run `yarn build` to build into `dist/`

If using the root directory `install.sh` script - use with `RUN_BUILD=true` to force the build to occur
from scratch.

# Adding the script into `.bin`

The `install.sh` script handles the work for this, as long as the script name exists in `script-list`
_and_ is built out and available in `dist/`.

