#!/usr/bin/python3
#
# Support for Apache Libcloud.
# Will setup caching to help speed up lookup times for images/sizes/etc
# Only supported on Linux at the moment
# pass in the platform, the files you are looking for, and the last update check.
# if you all of the parameters are valid, and within the time alottment will pass back the information already collected
# if not will pass back an message stating not available. 
#
import sys,os,time,datetime
from pathlib import Path
from libcloud.compute.types import Provider
from libcloud.compute.providers import get_driver


# initialize variables
home = ""
cache_days = 1 # used to hold the amount of time to cache files for. # measured in day(s)
providers_list = ["ec2","google_cloud","rackspace","linode"]
files = ["node","nodesize","nodeimage","nodelocation"]
region = "us-west-1"

def cache(platform):
	# check to make sure the platform is valid:
	# I should eventually automate this by checking the libcloud Docs since there are so many.
	if not valid_provider(platform):
		sys.exit()

	# should get called from cache to walk through the steps.
	home = get_users_home()
	# run setup check to prevent overwriting.
	check_setup(home, platform)

# You will need to re-write this to handle other providers besides just AWS!
def load_libcloud():
	ACCESS_ID ='<insert here>'
	SECRET_KEY = '<insert here>'
	try:
		cls = get_driver(Provider.EC2)
		return cls(ACCESS_ID,SECRET_KEY,region=region)
	except ValueError:
		print ("Error with Credentials/Connection to cloud resource")


def last_updated(file_path,file):
	# first check if the files are empty... doesn't really matter if they were modified recently if they are empty
	if os.path.getsize(file_path) == 0:
		if file == "node":
			return 0
		print ("file is empty... update now?")
		update_files(file_path,file)
		return 0

	# got times
	orig = datetime.datetime.fromtimestamp(os.path.getmtime(file_path))
	current = datetime.datetime.fromtimestamp(time.time())
	# compare now
	if (orig + datetime.timedelta(days=cache_days)) > orig:
		# call function to read in as variables and return to class calling
		read_files(file_path, file)
	else:
		print ("Want to update the cache?")

def read_files(file_path,file):
	if file == "node":
               	print ("getting node info from cache")
	elif file == "nodesize":
		print ("getting nodesize info from cache")
	elif file == "nodeimage":
		print ("getting nodeimage info from cache")
	elif file == "nodelocation":
		print ("getting nodelocation info from cache")
	else:
		print ("unrecongnized file")

def update_files(file_path,file):
	print ("updating files...")
	driver = load_libcloud()

	if file == "node":
		print ("getting node info")
		try:
			nodes = driver.list_nodes()
		except ValueError:
			print ("Error with Credentials/Connection to cloud resource")
		write_to_file(file_path, nodes)
	elif file == "nodesize":
		print ("getting nodesize info")
		try:
			sizes = driver.list_sizes()
		except ValueError:
			print ("Error with Credentials/Connection to cloud resource")
		write_to_file(file_path,sizes)
	elif file == "nodeimage":
		print ("getting nodeimage info")
		try:
			images = driver.list_images()
		except ValueError:
			print ("Error with Credentials/Connection to cloud resource")
		write_to_file(file_path, images)
	elif file == "nodelocation":
		print ("getting nodelocation info")
		try:
			locs = driver.list_locations()
		except ValueError:
			print ("Error with Credentials/Connection to cloud resource")
		write_to_file(file_path, locs)
	else:
		print ("unrecongnized file")

def write_to_file(file_path,data):
	f = open(file_path, "w")
	for line in data:
		f.write(str(line))
	f.close()

def valid_provider(platform):
	if platform in providers_list:
		return True
	else:
		return False

def get_users_home():
	return str(Path.home())

def check_setup(home, platform):
	# check to see if the file .libcloud is located at the user's home dir
	full_path = (home + "/.libcloud")
	p = Path(full_path)
	if not p.is_dir():
		# does not exist create dir
		print("does not")
		p.mkdir()
		if not p.is_dir():
			print("Something went wrong")
			sys.exit()

	# continue with platform folder check
	full_path = full_path + "/" + platform
	p = Path(full_path)
	if not p.is_dir():
		# does not exist create dir
		p.mkdir()
		if not p.is_dir():
			sys.exit()

	# continue with file checks
	for file in files:
		file_path = full_path + "/" + file
		p = Path(file_path)
		if not p.is_file():
			p.touch()
			if not p.is_file():
				print("something went wrong with file creation")
				sys.exit()
		else:
			last_updated(file_path,file)


if __name__ == "__main__":
	platform = "ec2" # gets passed in when calling the cache function
	cache(platform)
