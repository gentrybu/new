Service Discovery
https://prometheus.io/     similar to Borgmon (internal to Google)
Book: Site Reliability Engineering: How Google Runs Production Systems (O'Reilly Media)
Live: http://demo.robustperception.io
Brian Brazil (Irish) - long-term storage solution later... by others? InfluxDB, others?

monitoring and alerting with timeseries at scale, with Prometheus
https://www.youtube.com/watch?v=gNmWzkGViAY

use Docker to deploy https://prometheus.io/docs/introduction/getting_started/
     also can use Swarm and Consul
(get docker image: $ docker run -p 9090:9090 prom/prometheus)
$ docker run -d --name prom -p 9090:9090 prom/prometheus
url is http://192.168.99.100:9090/graph 
note: may need to run in other networks (bridged, etc.)
$ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' {name}
# gets IP address -> e.g. 172.17.0.2

# Start Prometheus.# By default, Prometheus stores its database in ./data (flag -storage.local.path).
./prometheus -config.file=prometheus.yml

PC: docker run --name prom -p 9090:9090 -v ~/developer/docker/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
Mac:  docker run -d --name prom -p 9090:9090 -v ~/Developer/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
Download the Go client library for Prometheus and run three of these example processes:
# Fetch the client library code and compile example.
git clone https://github.com/prometheus/client_golang.git
cd client_golang/examples/random
go get -d
go build

# Start 3 example targets in separate terminals:
./random -listen-address=:8080
./random -listen-address=:8081
./random -listen-address=:8082
mac: /Users/gentry/Developer/go/src/github.com/prometheus/client_golang/examples/random
     note: had to add -p port forwarding for each (or multiple in another Docker container)
You should now have example targets listening on http://localhost:8080/metrics,http://localhost:8081/metrics, and http://localhost:8082/metrics.

the Node Exporter exposes an extensive set of machine-level metrics on Linux and other Unix systems such as CPU usage, memory, disk utilization, filesystem fullness and network bandwidth.
the SNMP Exporter allows monitoring of devices that support SNMP.

docker run -d -p 9115:9115 --name blackbox_exporter -v `pwd`:/config prom/blackbox-exporter -config.file=/config/blackbox.yml



Prometheus is an open-source systems monitoring and alerting toolkit originally built at SoundCloud. Since its inception in 2012, many companies and organizations have adopted Prometheus, and the project has a very active developer and user community. It is now a standalone open source project and maintained independently of any company.
For a more elaborate overview, see the resources linked from the media section.
FeaturesPrometheus's main features are:

	* a multi-dimensional data model (time series identified by metric name and key/value pairs)
	* a flexible query language to leverage this dimensionality
	* no reliance on distributed storage; single server nodes are autonomous
	* time series collection happens via a pull model over HTTP
	* pushing time series is supported via an intermediary gateway
	* targets are discovered via service discovery or static configuration
	* multiple modes of graphing and dashboarding support

ComponentsThe Prometheus ecosystem consists of multiple components, many of which are optional:

	* the main Prometheus server which scrapes and stores time series data
	* client libraries for instrumenting application code
	* a push gateway for supporting short-lived jobs
	* a GUI-based dashboard builder based on Rails/SQL
	* special-purpose exporters (for HAProxy, StatsD, Ganglia, etc.)
	* an (experimental) alertmanager
	* a command-line querying tool
	* various support tools

Most Prometheus components are written in Go, making them easy to build and deploy as static binaries.
Architecture
This diagram illustrates the overall architecture of Prometheus and some of its ecosystem components:

Prometheus scrapes metrics from instrumented jobs, either directly or via an intermediary push gateway for short-lived jobs. It stores all scraped samples locally and runs rules over this data to either record new time series from existing data or generate alerts. PromDash or other API consumers can be used to visualize the collected data.

