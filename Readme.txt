This script was made with Halo Script Editor (HSE). It's a brilliant tool which I recommend to EVERYONE


Here's the process (order is reversed in the actual script because code is compiled top-to-bottom):

Run a single continuous script which monitors the number of phantoms in the scene
  Phantoms are assigned to a squad group called "all_phantoms", which is what is checked
  If there are no phantoms, attempt to deploy firefight routine
  This is not the only method. A single boolean variable set and reset in waves would work just as well
Firefight
  If-statements check global variable "wave" and execute waves
  "wave" set to 0 after to prevent messy recursion
Waves
  Place phantom(s)
  Run command scripts for navigation and squad deployment on each phantom
  Sleep until all phantoms have departed and all squads associated with current wave have been eliminated
  Set "wave" to value of next wave or set to first wave value for loop
Phantom Command Scripts
  Randomly select a squad composition and place squads. Squad AI seems to break if not placed by a command script
  Load squad onto phantom
  Enable pathfinding failsafe to prevent confusion
  Fly! Phantoms can "fly_by" multiple points, then "fly_to" destination. Speed can be adjusted
  Unload squads. Wait for all squads to disembark before departing (an empty phantom still has one unit - the pilot - so DO NOT check for 0)
  Fly away! Then disappear...
Phantom Unload
  Set power to TRUE | Not sure if this is necessary
  Unload units
  Set power to FALSE
