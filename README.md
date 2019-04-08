本项目演示如何使用spring mvc framework实现API Server，并在Azure Kubernetes Service上部署运行。<br>

使用说明：

1.代码编译。在build.gradle所在目录下运行：<br>
  `gradle clean build`<br>
  将创建build目录，其中build/libs下生成项目的可部署文件 spring-mvc-ajax.war
  
2.创建Docker镜像。在项目的Dockerfile所在目录下运行：<br>
  `docker build -t aks-api-demo:v1 .`<br>
  命令结束后，使用docker images命令，将可查看到本地新创建的 aks-api-demo:v1 docker镜像，例如：<br>
  λ docker images<br>
	REPOSITORY                              TAG                 IMAGE ID            CREATED             SIZE<br>
	aks-api-demo                            v1                  d566bc710b34        About an hour ago   471MB

	修改此docker镜像tag，之后将其推送到docker hub或其它可访问的容器镜像库，例如：<br>
	`λ docker tag aks-api-demo:v1 kcai74/aks-api-demo:v1`<br>
	`λ docker push kcai74/aks-api-demo:v1`<br>
	等待docker push操作完成，把docker镜像推送到容器镜像仓库<br>
	
3.向AKS集群部署。首先使用kubectl命令，检查确保本地已连接到Azure上的AKS cluster<br>
  在aks-api-demo.yml所在的目录下运行：<br>
  `kubectl create -f aks-api-demo.yml`
  
  之后运行命令 `kubectl get service aks-api-demo --watch`，等待service aks-api-demo的external IP成功获得，例如：<br>
  `λ kubectl get service aks-api-demo --watch`<br>
	NAME           TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE<br>
	aks-api-demo   LoadBalancer   10.0.46.126   <pending>     80:32327/TCP   17s<br>
	aks-api-demo   LoadBalancer   10.0.46.126   40.73.17.217   80:32327/TCP   56s

  按Ctrl-C退出命令，打开浏览器，输入地址 40.73.17.217/spring-mvc-ajax/，查看到以下UI:<br>
  ![](https://github.com/kylercai/spring-mvc-ajax/edit/master/UI.jpg)
  在UI中点击：<br>
  “Get Random Person”: 调用REST API GET /api/person/random<br>
  “Get Person By ID”: 调用REST API GET /api/person/id/{id}<br>
  “Save Person”: 调用REST API POST /api/person/id<br>
