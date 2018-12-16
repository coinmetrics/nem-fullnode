FROM openjdk:8-jre

ARG VERSION

RUN curl -L https://bob.nem.ninja/nis-${VERSION}.tgz | tar -xz --strip-components=1 -C /opt

RUN useradd -m -u 1000 -s /bin/bash runner
USER runner

# WORKDIR /opt
# CMD ["./nix.runNis.sh"]

# took from nix.runNis.sh, increased maximum allocation
WORKDIR /opt/nis
CMD ["java", "-Xms512M", "-Xmx4G", "-cp", ".:./*:../libs/*", "org.nem.deploy.CommonStarter"]
