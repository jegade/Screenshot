# Headless Screenshot Service with Api build on Dancer, PhantomJS and Xvfb

## Build

1. Install Xvfb 
2. Compile PhantomsJS for your system (qmake && make)
3. install Perl-Modules  Dancer, Parallel::Jobs 


## Start

1. ./bin/server.pl 


## Use

GET http://127.0.0.1:3000/api/screenshot?url=YOUR_URL
