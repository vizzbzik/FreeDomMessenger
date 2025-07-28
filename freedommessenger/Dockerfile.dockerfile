# Используем SDK-образ для сборки проекта
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Копируем все файлы проекта
COPY . ./

# Публикуем сборку
RUN dotnet publish -c Release -o out

# Используем легковесный рантайм-образ
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Копируем опубликованные файлы из этапа build
COPY --from=build /app/out ./

# Запуск приложения
ENTRYPOINT ["dotnet", "freedommessenger.dll"]

# Используй порт 10000 (Render задаст PORT)
ENV ASPNETCORE_URLS=http://*:${PORT:-10000}
EXPOSE 10000

ENTRYPOINT ["dotnet", "freedommessenger.dll"]