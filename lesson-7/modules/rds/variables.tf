variable "name" {
  description = "Назва екземпляра БД або Aurora-кластера"
  type        = string
}

variable "use_aurora" {
  description = "Використовувати Aurora Cluster (true) чи стандартну RDS (false)"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Engine для стандартної RDS (наприклад, postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_cluster" {
  description = "Engine для Aurora Cluster (наприклад, aurora-postgresql, aurora-mysql)"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version" {
  description = "Версія двигуна для стандартної RDS"
  type        = string
  default     = "14.7"
}

variable "engine_version_cluster" {
  description = "Версія двигуна для Aurora Cluster"
  type        = string
  default     = "15.3"
}

variable "instance_class" {
  description = "Клас EC2 інстансу (наприклад, db.t3.micro, db.t3.medium)"
  type        = string
  default     = "db.t3.micro"
}

variable "aurora_instance_count" {
  description = "Загальна кількість інстансів в Aurora Cluster (primary + replicas)"
  type        = number
  default     = 2
}

variable "aurora_replica_count" {
  description = "Кількість додаткових reader-реплік для Aurora Cluster"
  type        = number
  default     = 1
}

variable "allocated_storage" {
  description = "Обсяг виділеного дискового простору в ГБ (для стандартної RDS)"
  type        = number
  default     = 20
}

variable "storage_encrypted" {
  description = "Чи вмикати шифрування сховища (storage encryption)"
  type        = bool
  default     = true
}

variable "db_name" {
  description = "Ім'я початкової бази даних"
  type        = string
}

variable "username" {
  description = "Ім'я користувача-адміністратора"
  type        = string
}

variable "password" {
  description = "Пароль користувача-адміністратора"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "ID VPC мережі"
  type        = string
}

variable "subnet_private_ids" {
  description = "Список ID приватних підмереж для DB Subnet Group"
  type        = list(string)
}

variable "subnet_public_ids" {
  description = "Список ID публічних підмереж для DB Subnet Group"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Чи робити доступним публічно з Інтернету"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Режим високої доступності Multi-AZ для стандартної RDS"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Період зберігання бэкапів у днях"
  type        = number
  default     = 7
}

variable "parameter_group_family_rds" {
  description = "Сімейство параметрів для стандартного RDS Parameter Group"
  type        = string
  default     = "postgres15"
}

variable "parameter_group_family_aurora" {
  description = "Сімейство параметрів для Aurora Cluster Parameter Group"
  type        = string
  default     = "aurora-postgresql15"
}

variable "parameters" {
  description = "Мапа кастомних параметрів конфігурації СУБД для Parameter Group"
  type        = map(string)
  default = {
    max_connections            = "200"
    log_min_duration_statement = "500"
    work_mem                   = "4096"
  }
}

variable "tags" {
  description = "Теги для ресурсів RDS"
  type        = map(string)
  default     = {}
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access RDS"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
