AÇIKLAMALI YAPACAKSIN

1. ADIM 
“Running” durumunda ki EC2’ların Instance ID ve Public IP adreslerini çeken bir script yazın.
● Script için stediğiniz dili kullanmakta özgürsünüz. 
 İÇİN ;

Aws cli ndan sistem oluşturup gerekli script yazısıyla “Running” durumunda ki EC2’ların Instance ID ve Public IP adreslerini çekeceğiz

Bu adresde CLI dökümantasyonu var https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html

Instance ID sini çeken komut 
$ aws ec2 describe-instances \
>     --filters Name=instance-type,Values=t2.micro \
>     --query Reservations[*].Instances[*].[InstanceId] \
>     --output text
 i-0c17cdd9d1d491624

Public ip yide çeken komut bu 

$ aws ec2 describe-instances \
>   --query "Reservations[*].Instances[*].PublicIpAddress" \
>   --output=yaml
- - 3.65.12.126

-------------------


AWS CLI kullanarak ölçümleri listeleme
Bulut sunucularınız için CloudWatch ölçümlerini listelemek üzere list-metrics komutunu kullanın.

Amazon EC2 (AWS CLI) için kullanılabilir tüm ölçümleri listelemek için

Aşağıdaki örnek, Amazon EC2 için tüm ölçümlerin görüntüleneceği ad alanını belirtir.AWS/EC2

aws cloudwatch list-metrics --namespace AWS/EC2

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html#list-ec2-metrics-cli

Aşağıdaki örnek, yalnızca belirtilen örneğin sonuçlarını görüntülemek için ad alanını ve boyutu belirtir.AWS/EC2InstanceId

aws cloudwatch list-metrics --namespace AWS/EC2 --dimensions Name=InstanceId,Value=i-1234567890abcdef0

Tüm bulut sunucularında bir ölçüm listelemek için (AWS CLI)

Aşağıdaki örnek, yalnızca belirtilen ölçümün sonuçlarını görüntülemek için ad alanını ve bir ölçüm adını belirtir.AWS/EC2

aws cloudwatch list-metrics --namespace AWS/EC2 --metric-name CPUUtilization




---------------------------------------------------

● Herhangi bir Linux dağıtımı kullanan işletim sisteminde disk kullanımı %90’ı geçtiği takdirde
E-mail ile notification gönderen bir shell script yazın.
● Gönderici mail adresi olarak herhangi bir gmail adresini kullanabilirsiniz

web sitesini halilin gönderdiği aws klasöründeki Cloudwatch hands ondan aldım


https://marbot.io/blog/monitoring-ec2-disk-usage.html 
 Buradaki bütün komutlar cloudwact kurumu için gerekli screplere sahip.
 Alarm oluşturmaya kadar hepsi mevcut sadece SNS yazılmamış onuda kendimiz hallederiz

https://www.youtube.com/watch?v=fEgGRYok1zQ&list=PLvQJ0GG09eIOSoyCb_dtMZCVmBfB8QG4A&index=8&t=209s

burda CPU için yapmış ama yardımcı oldu

https://awswithatiq.com/cloudwatch-to-monitor-memory-disk-and-access-log/

buda videonun yazılı açıklaması

-----------------------------------------------------


2.Altyapı Yönetimi
● 2 adet Public 2 adet Private Subneti olan bir VPC oluşturun.
● IP bloğunu 62 adet kullanılabilir host olacak şekilde seçmelisin.
● Auto Scaling Group içinde çalışan bir EC2 Instance’ı oluşturun.
● Instance’ın önünde Application Load Balancer konumlandırın.
*Not : You can do these operations with the unit IaC tool

TERRAFORM ile yapacağız


--------------------------------

3. AŞAMA 
ec2 ya terrafrom ve docker yükle


--------------------------------------------------





