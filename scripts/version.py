import sys
import pkg_resources

print(sys.argv[1], pkg_resources.get_distribution(sys.argv[1]).version)
