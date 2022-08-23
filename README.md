# tor-infra

## 01_kubernetes
```
        // install Docker & k8s
        // add kubectl auth for user & init k8s & init cni
	sudo bash install_kubernetes_1.sh
        // remove master taint for deploy in master node
        // create & set default tor ns
	sudo bash install_kubernetes_2.sh
        // make sa & context for github action
        // kubectl get secrets & add your secrets in yamls/tor_sa.yaml
        // create user by sa & create context by sa & user
	sudo bash install_kubernetes_3.sh
        // after make sa, make context & copy ~/.kube/config & add github action secrets    
```
## 02_metric-server
```
        // install metrics-server for hpa
        bash install_metrics-server.sh
```
## 03_mariadb
```
        // install mariadb
        bash install_mariadb.sh
        // init setting
        // inside db pod
        kubectl exec -it mysql-0 bash
        // login mysql
        mysql -u root -p
        // copy & paste init_setting.sql
```
## 04_elk
```
        // install elastic search
        bash install_elk_1.sh
        // install logstash
        bash install_elk_2.sh
        // install kibana (Optional)
        bash install_elk_3.sh
```
## 05_ingress
```
        // install ingress
        // insert your ip in yamls/ingress-deploy, line 291
        bash install_ingress.sh
```
