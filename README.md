# smappee-api-script

Basic bash script to trigger mode updates for my Smappee EV Wall Home charger using their API

![Picture of my charger](https://github.com/hanscappelle/smappee-api-script/blob/51c419e830c4151ff91c855e3bde6c52a4cebe86/screenshots/PXL_20240118_110605503.jpg)

## How to use

First you'll need API access, this can be requested with smappee following these instructions 
https://smappee.atlassian.net/wiki/spaces/DEVAPI/overview

With that information you can use the required flags on this script to trigger mode updates:

```
 -i = client_id
 -s = client_secret
 -u = username
 -p = password
 -m = mode to toggle to (NORMAL, SMART or PAUSED)
 -d = device serial (check in Smappee app)
 -c = connector (typically 1 or 2)
```

Example execution to set charger mode to SMART on port 1 (the port on the RIGHT side of the charger)

```
sh smappee-toggle-mode.sh -i YOUR_CLIENT_ID -s CLIENT_SECRET -u USER -p PSW -m SMART -d DEVICE_SERIAL -c 1
```

## How I scheduled it

There are many ways to schedule this script. All you need is a `bash`, `curl` to execute requests and `jq` to parse 
response. I've used my Synology NAS since that is running all the time and meets these requirements. 

From your synology dashboard just go to `Control Panel` > `Task Scheduler` then pick `Create` > `Scheduled Task` > 
`User-defined script` and follow the wizard to get tasks set up.

![Task scheduler on Synology NAS](https://github.com/hanscappelle/smappee-api-script/blob/e7d69c67dd9bbe8e51a1ed23384779d321d5cbd6/screenshots/Screenshot%202024-01-18%20at%2008.57.34.png)

I have 2 set up, one to toggle to `SMART` mode in the morning when electricity gets more expensive. And another one
to toggle to `NORMAL` mode for charging overnight.

![Scheduled Tasks](https://github.com/hanscappelle/smappee-api-script/blob/e7d69c67dd9bbe8e51a1ed23384779d321d5cbd6/screenshots/Screenshot%202024-01-18%20at%2011.30.22.png)

## The result

The result for me is that I now have maximised solar consumption. Which is great since the grid here can't take it 
when I don't.

![smappee app usage example](https://github.com/hanscappelle/smappee-api-script/blob/8dcacad5effba90c413c774c0c64c6ee2f07a72f/screenshots/Screenshot_20240111-103422.png)

## References

Info on Task Scheduler from Synology docs: https://kb.synology.com/en-id/DSM/help/DSM/AdminCenter/system_taskscheduler?version=7
Bash scripts and flags: https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script
Smappee dev docs: https://smappee.atlassian.net/wiki/spaces/DEVAPI/overview