FROM mcr.microsoft.com/dotnet/sdk:9.0 As build
ADD . /nop
WORKDIR /nop
RUN dotnet build -c Release src/Presentation/Nop.Web/Nop.Web.csproj
RUN mkdir published/bin published/logs

FROM mcr.microsoft.com/dotnet/aspnet:9.0
COPY --from=build /nop/published /nop
WORKDIR /nop
EXPOSE 5000/tcp
CMD ["dotnet", "Nop.Web.dll", "--urls=http://0.0.0.0:5000"]
