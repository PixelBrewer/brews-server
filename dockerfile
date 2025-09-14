# Runtime base
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy solution and project files for better caching
COPY ["BrewsServer.sln", "./"]
COPY ["BrewsApi/BrewsApi.csproj", "BrewsApi/"]
COPY ["BrewsCore/BrewsCore.csproj", "BrewsCore/"]
COPY ["BrewsTests/BrewsTests.csproj", "BrewsTests/"]

RUN dotnet restore "BrewsServer.sln"

# Copy source
COPY . .

# Build solution
RUN dotnet build "BrewsServer.sln" -c Release --no-restore

# Optional: run tests (comment out if failing while you debug)
# RUN dotnet test "BrewsTests/BrewsTests.csproj" -c Release --no-build --verbosity normal

# Publish only the Web API
FROM build AS publish
RUN dotnet publish "BrewsApi/BrewsApi.csproj" -c Release -o /app/publish --no-restore

# Final runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BrewsApi.dll"]