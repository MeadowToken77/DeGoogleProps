# Out of scope features for this project

## Firewall/Adblocking:
- there are already a lot of good Adblocking/firewall modules available
- there are different solutions that all have their advantages and disadvantages
- the user should look into a solution that works for them

## Debloating of other Bloatware:
- would make the codebase of this module too large
- is another complex part to maintain and debug
- there are a lot of such modules/Apps available

## Changing/disabling SUPL:
- currently out of scope because it exists already
- might look into it in the future but will not be high priority

## Installing MicroG/Sandboxed Google Play
- On most ROMS, you can install MicroG as a user app and grant it its permissions, it doesn't need to be installed as a priv-app
- MicroG only works with Signature Spoofing enabled, solutions vary
- Sandboxed Google Play is almost impossible to implement, even for custom ROMs and would likely require Xposed to make changes to the system framework, which is a **MASSIVE Security Risk**

  
