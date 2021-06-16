#!/bin/sh

# IMPORTANT! need to have at least one looping... do not put & at the last command
/usr/local/bin/checker_current_game & 
/usr/local/bin/checker_leaderboard & 
/usr/local/bin/checker_subscriber & 
/usr/local/bin/checker_unclaim
