#!/usr/bin/env python

# This script builds the SWIG source tarball, creates the Windows executable and the Windows zip package
# and uploads them both to SF ready for release. Also uploaded are the release notes.
import sys
import os

def execute(command):
    exit_code = os.system(command)
    if exit_code != 0:
        print("{}: command failed: {}".format(os.path.basename(__file__), command))
        sys.exit(2)

try:
   version = sys.argv[1]
   branch = sys.argv[2]
   username = sys.argv[3]
except IndexError:
   print "Usage: python mkrelease.py version branch username"
   print "where version should be x.y.z and username is your SF username"
   sys.exit(1)

print "Looking for rsync"
execute("which rsync")

print "Making source tarball"
execute("python ./mkdist.py " + version + " " + branch)

print "Build Windows package"
execute("./mkwindows.sh " + version)

print "Uploading to SourceForge"

swig_dir_sf = username + ",swig@frs.sourceforge.net:/home/frs/project/s/sw/swig/swig/swig-" + version + "/"
swigwin_dir_sf = username + ",swig@frs.sourceforge.net:/home/frs/project/s/sw/swig/swigwin/swigwin-" + version + "/"

# If a file with 'readme' in the name exists in the same folder as the zip/tarball, it gets automatically displayed as the release notes by SF
full_readme_file = "readme-" + version + ".txt"
execute("rm -f " + full_readme_file)
execute("cat swig-" + version + "/README " + "swig-" + version + "/CHANGES.current " + "swig-" + version + "/RELEASENOTES " + "> " + full_readme_file)

execute("rsync --archive --verbose -P --times -e ssh " + "swig-" + version + ".tar.gz " + full_readme_file + " " + swig_dir_sf)
execute("rsync --archive --verbose -P --times -e ssh " + "swigwin-" + version + ".zip " + full_readme_file + " " + swigwin_dir_sf)

print "Finished"

print "Now log in to SourceForge and set the operating systems applicable to the newly uploaded tarball and zip file. Also remember to do a 'git push --tags'."
