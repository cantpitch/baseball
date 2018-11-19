# Tools of Ignorance

A collection of Bash, Python, and SQL scripts for building and maintaining a MySQL baseball research database.

## Directory Layout

* __etl__ - scripts for loading data into the database (extract, transform, load).
* __fetch__ - scripts for downloading data from various internet sources.
* __lib__ - Python libraries
* __misc__ - various scripts for research

## Installation and Setup

This project requires a few different things to be setup before it's useful.

* Python 3 installed (development is done with Python 3.6+). This
can be installed in many different ways and is outside of the scope of this document 
to explain.
* A set of MySQL databases (currently called _baseball_, _retrosheet_, _lahman_, _mlbam_) created. This can be
a non-trivial undertaking, but on macOS it is recommended that you use __brew install mysql__
from [Homebrew](https://brew.sh/) to get up and running quickly.
* Chadwick tools for processing the Retrosheet files http://chadwick.sourceforge.net/doc/index.html
* dos2unix (from Homebrew)
* gsed (from Homebrew on macOS. Should be available as _sed_ on Linux)

Once that is all setup, it's recommended that you create a virtualenv environment for
development using [pipenv](https://pipenv.readthedocs.io/en/latest/):

    brew install pipenv
    cd [your project directory]
    pipenv --python 3.7 --site-packages
    pipenv shell

In order to use the local libraries add a `.pth` file in 
`$HOME/.local/share/virtualenvs/toolsofignorance-[random number]/lib/python3.6/site-packages` called `baseball.pth` with the path
to the `toolsofignorance/lib` directory:

    /Users/hvs/Projects/toolsofignorance/lib