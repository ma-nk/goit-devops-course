# RDS & Aurora Terraform Module

Модуль для розгортання та налаштування AWS RDS (Standard Instance) або кластерів AWS Aurora (PostgreSQL / MySQL) у мережі VPC.

## Функціональність

- Підтримка **Standard RDS** та **Aurora Cluster** (через параметр `use_aurora`).
- Автоматичне створення **DB Subnet Group** (для публічних або приватних підмереж залежно від `publicly_accessible`).
- Створення **Security Group** для керування мережевим доступом до бази даних.
- Налаштування **DB Parameter Group** (для RDS) та **DB Cluster Parameter Group** (для Aurora).

## Оцінка захищеності (Security Evaluation)

Аналіз `aws_security_group.rds` у файлі `modules/rds/shared.tf`:

### Ризики:

- **Відкритий вхідний доступ з Інтернету (`0.0.0.0/0`)**: теперішня конфігурація `ingress` відкриває порт PostgreSQL `5432` для всього Інтернету. Разом із `publicly_accessible = true`, базу даних відкрито до спроб доступу з Інтернету.

### Рекомендації щодо покращення безпеки:

- **Обмежити публічний доступ до кластера**: для ключа `allowed_cidr_blocks` встановити значення за замовчуванням `["10.0.0.0/16"]` (CIDR of VPC), щоб дозволити доступ лише з внутрішньої мережі.
