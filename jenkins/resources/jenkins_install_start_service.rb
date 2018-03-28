#chef :: default recipe

provides :jenkins_server

action :create do
    bash 'Jenkins install and start' do
      code <<-EOH
        sudo su
        echo "start process!!"
        yes Y y | sudo apt-get -f install
        echo "curl install!!"
        yes Y y | sudo apt-get install curl
        echo "start java install!!"
        yes Y y | sudo apt-get install python-software-properties
        yes Y y | sudo add-apt-repository ppa:webupd8team/java
        echo "update!!"
        yes Y y | sudo apt-get update
        yes Y y | sudo apt-get install oracle-java8-installer
        echo -ne '\n' | sudo update-alternatives --config java
        sudo echo "JAVA_HOME="/usr/lib/jvm/java-8-oracle"" >> /etc/environment
        source /etc/environment
        echo $JAVA_HOME
        echo "check java !"
        java -version
        echo "download jenkins !!" | sleep 20
        yes y | wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add –
        echo "add in source list!!"
        sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
        echo "update again !!"
        yes y Y | apt-get update | echo "apt install !!"
        yes y Y | apt-get install Jenkins
        echo "start Jenkins !!"
        service jenkins status && service jenkins start
        echo "check UI!!"
        curl -I http://localhost:8080
      EOH
    end
end
action :start do
    bash 'Jenkins install and start' do
      code <<-EOH
        service jenkins status 
        service jenkins start
        curl -I http://localhost:8080
      EOH
    end
    #notifies :start, "jenkins_server[jenkins]", :immediately
end
action :stop do
    bash 'Jenkins install and start' do
      code <<-EOH
        service jenkins status 
        service jenkins stop && service jenkins status
        curl -I http://localhost:4440
      EOH
    end
    notifies :stop, "jenkins_server[jenkins]", :immediately
end
action :restart do
    bash 'Jenkins install and start' do
      code <<-EOH
        service jenkins status 
        service jenkins restart && service jenkins status
        sleep 120 && curl -I http://localhost:4440
      EOH
    end
    notifies :restart, "jenkins_server[jenkins]", :immediately
end
