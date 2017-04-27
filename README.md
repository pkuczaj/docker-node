# docker-node
NODE Docker Image Build

Build the image: (Only Once or when you want to refresh the build)

$ docker build -t nodeservice .


Initiate a Docker NODE container: (Running instance ready to be used)

$ docker run --rm -it --name nodeservice -v $PWD:/node -it nodeservice:4.3.1 bash
