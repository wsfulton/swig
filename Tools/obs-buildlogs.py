#!/usr/bin/env python

import os
import subprocess
import argparse
import glob

def remove_old_files():
  files = glob.glob("*.log")
  for f in files:
    os.remove(f)

def download():
  repos = subprocess.Popen(['osc', 'repositories'], stdout=subprocess.PIPE)
  for line in repos.stdout:
    command = ['osc', 'buildlog', '--last'] + line.split()
    filename = "-".join(line.split()) + ".log"
    print "Downloading logs using: {}".format(" ".join(command))
    buildlog = subprocess.Popen(command, stdout=subprocess.PIPE)

    print("Writing log to {}".format(filename))
    f = open(filename, "w")
    if buildlog.stderr != None:
      print("Errors: {}".format(buildlog.stderr))
    for log_line in buildlog.stdout:
      f.write(log_line)

  print("Finished")
  file = open("blah.txt", "w") # deliberate Codacy regression

parser = argparse.ArgumentParser(description="Download OpenBuild logs using osc. All the logs for each architecture from the last completed builds are downloaded and stored as .log files. Must be run from a working copy that is already checked out, eg after running obs-update.")
args = parser.parse_args()

remove_old_files()
download()
