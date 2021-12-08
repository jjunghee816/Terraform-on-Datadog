# Terraform-on-Datadog

### Index
- [1. Monitor](https://github.com/jjunghee816/Terraform-on-Datadog#monitor)
- [2. Monitoring Board](https://github.com/jjunghee816/Terraform-on-Datadog#monitoring-board)
- [3. Report Board](https://github.com/jjunghee816/Terraform-on-Datadog#report-board)
---

## Monitor
1. **Host Monitors from Datadog Agent**
    - CPU, Memory, Disk Usage
    - Log
    - Port
    - Process
    - Agent and VM Status
    - URL

2. **Azure Monitors activated via Azure Integration**
    - CDN
    - Disk IOps
    - IoT Hub
    - Load Balancer Health Probe
    - Azure Databases for MySQL
    - Azure Databases for PostgreSQL
    - SQL MI
    - Traffic Manager

3. **Synthetics for URL Monitoring**
    - URL API Test
---

## Monitoring Board
- Multiple Linux VM
    ![Multiple Linux VM](https://github.com/jjunghee816/Terraform-on-Datadog/blob/main/images/monitoring_multiple_linux.png)
- Single Windows SQL VM
    ![Single Windows SQL VM](https://github.com/jjunghee816/Terraform-on-Datadog/blob/main/images/monitoring_single_windows.png)
---

## Report Board
- Monthly VM and Azure Databases for MySQL Usage
    ![VM and MySQL Usage](https://github.com/jjunghee816/Terraform-on-Datadog/blob/main/images/report_vm_azuresql.png)
- Monthly VM and AzureSQL Usage
    ![VM and AzureSQL Usage](https://github.com/jjunghee816/Terraform-on-Datadog/blob/main/images/report_vm_mysql.png)
---

### Docs and Reference
- [Datadog Terraform Registry](https://registry.terraform.io/providers/DataDog/datadog/latest/docs)
- [Datadog API Monitor Type](https://docs.datadoghq.com/api/latest/monitors/#create-a-monitor)
- [Terraform Cloud](https://app.terraform.io/app/MSP_Works/workspaces)
---