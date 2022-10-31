FROM openjdk:8-jre

ARG VERSION

RUN curl -L https://bob.nem.ninja/nis-${VERSION}.tgz | tar -xz --strip-components=1 -C /opt
# reduce amount of logging
RUN sed -i 's/level = INFO/level = WARNING/' /opt/nis/logalpha.properties

RUN useradd -m -u 1000 -s /bin/bash runner
USER runner

WORKDIR /opt/nis

# took from nix.runNis.sh, increased minimum and maximum allocation
# increased memory further as the node sometimes gets stuck
# see https://github.com/NemProject/nem.core/issues/45
CMD ["java", "-Xms4G", "-Xmx8G", "-XX:+UseG1GC", "-cp", ".:./*:../libs/*", "org.nem.deploy.CommonStarter"]
