# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Копируем csproj и восстанавливаем зависимости
COPY freedommessenger.csproj .
RUN dotnet restore

# Копируем остальные файлы и билдим
COPY . .
RUN dotnet publish -c Release -o out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .

# Используй порт 10000 (Render задаст PORT)
ENV ASPNETCORE_URLS=http://*:${PORT:-10000}
EXPOSE 10000

ENTRYPOINT ["dotnet", "freedommessenger.dll"]