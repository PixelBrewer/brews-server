# Multi-stage build for .NET 9 Web API with tests
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
# App Platform forwards traffic to your container over HTTP; listen on 8080
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy solution and project files first for better layer caching
COPY ["BrewsServer.sln", "./"]
COPY ["BrewsApi/BrewsApi.csproj", "BrewsApi/"]
COPY ["BrewsCore/BrewsCore.csproj", "BrewsCore/"]
COPY ["BrewsTests/BrewsTests.csproj", "BrewsTests/"]

# Restore all projects
RUN dotnet restore "BrewsServer.sln"

# Copy the rest of the source
COPY . .

# Build entire solution
RUN dotnet build "BrewsServer.sln" -c Release --no-restore

# Optional: run tests during image build (fails build if tests fail)
RUN dotnet test "BrewsTests/BrewsTests.csproj" -c Release --no-build --verbosity normal

# Publish only the Web API
FROM build AS publish
RUN dotnet publish "BrewsApi/BrewsApi.csproj" -c Release -o /app/publish --no-restore

# Final runtime image contains only the published API
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BrewsApi.dll"]