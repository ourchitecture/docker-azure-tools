FROM ubuntu:20.04

ENV CI true

ENV AZURE_CORE_COLLECT_TELEMETRY false
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT 1

# https://github.com/dotnet/core/blob/master/Documentation/build-and-install-rhel6-prerequisites.md#required-packages
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT true

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
  curl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
  && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
  && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list' \
  && apt-get update \
  && apt-get install azure-functions-core-tools-3
