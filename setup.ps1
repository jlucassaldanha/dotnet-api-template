$PROJECT_NAME = "NomeDoProjeto"

Write-Host "1. Criando Solução..."
dotnet new sln -n $PROJECT_NAME

Write-Host "2. Criando Projetos (Apresentação, Domínio, Casos de Uso e Infraestrutura)..."
dotnet new webapi -n "$PROJECT_NAME.Api"
dotnet new classlib -n "$PROJECT_NAME.Domain"
dotnet new classlib -n "$PROJECT_NAME.Application"
dotnet new classlib -n "$PROJECT_NAME.Infrastructure"

Write-Host "3. Adicionando projetos à Solução..."
dotnet sln add "$PROJECT_NAME.Api/$PROJECT_NAME.Api.csproj"
dotnet sln add "$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj"
dotnet sln add "$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj"
dotnet sln add "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj"

Write-Host "4. Configurando Referências (Dependency Inversion)..."
dotnet add "$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj" reference "$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj"

dotnet add "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj" reference "$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj"
dotnet add "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj" reference "$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj"

dotnet add "$PROJECT_NAME.Api/$PROJECT_NAME.Api.csproj" reference "$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj"
dotnet add "$PROJECT_NAME.Api/$PROJECT_NAME.Api.csproj" reference "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj"

Write-Host "5. Instalando Dependências do Entity Framework e PostgreSQL..."
dotnet add "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj" package Microsoft.EntityFrameworkCore
dotnet add "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj" package Npgsql.EntityFrameworkCore.PostgreSQL
dotnet add "$PROJECT_NAME.Api/$PROJECT_NAME.Api.csproj" package Microsoft.EntityFrameworkCore.Design

Write-Host "6. Adicionando .gitignore e iniciando repositório git"
dotnet new gitignore
git init

Write-Host "Configuração concluída com sucesso. O projeto $PROJECT_NAME está pronto."