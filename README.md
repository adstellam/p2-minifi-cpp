# Minificpp

Stout nifi endpoint https://nifi.stoutagtech.dev:9443/nifi into the address bar.

minificpp does not build on aarch64. I have submitted a pull request if accepted we can clean up the patching going on in this repo.

If running on anything other than window minificpp builds [ossp-uuid](https://github.com/sean-/ossp-uuid) as a third party library. It is using a very old cgi webserver, it used a file config.guess to determine the host platform. The version of ossp-uuid minificpp is using has not been updated since 2011 and the last time config.guess was updated was in 2008. Aarch64 was not announced until 2011.

The update version of config.guess can be downloaded using the following
`wget http://savannah.gnu.org/cgi-bin/viewcvs/\*checkout\*/config/config/config.guess`

I additionally updated `nifi-minifi-cpp/cmake/BundledOSSPUUID.cmake` to apply the patch stored in `nifi-minifi-cpp/thirdparty/ossp-uuid`

If you want to run minifi in the container on real data in devcontainer.json uncomment the data mount.

## Build instructions

* download vs code
* open this project in a container

Opening in a vscode container will build the docker container.

## run instructions

You run minifi from inside the container using the following commands:
* `cd /opt/nifi-minifi-cpp`
* `MINIFI_HOME=/opt/nifi-minifi-cpp ./build/main/minifi`

