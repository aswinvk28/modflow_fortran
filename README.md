## **Run the Box**

```bash

docker-compose up -d --build

docker exec -it modflow_fortran /bin/bash

```

## **Compile Hello World Application**

```bash

nonprivuser@d6baeca63141:/home/project$ gfortran -o hello_world hello_world.f90
nonprivuser@d6baeca63141:/home/project$ ./hello_world
output:
 hello from GCC version 7.5.0

```

```bash

gfortran -fcoarray=lib coarray_hello.f90 -lcaf_mpi
./coarray_hello
output: 
 number of Fortran coarray images:           1
 Process            1
 Elapsed wall clock time   4.1199999999999999E-005  seconds.

```

## **Relevant Software**

**ModelMuse**

[https://www.usgs.gov/software/modelmuse-a-graphical-user-interface-groundwater-models](https://www.usgs.gov/software/modelmuse-a-graphical-user-interface-groundwater-models)

**Model Viewer**

[https://www.usgs.gov/software/model-viewer-a-program-three-dimensional-visualization-ground-water-model-results](https://www.usgs.gov/software/model-viewer-a-program-three-dimensional-visualization-ground-water-model-results)

## **Tutorial on ModFlow**

[https://www.youtube.com/watch?v=dE5RCUElIu4](https://www.youtube.com/watch?v=dE5RCUElIu4)
