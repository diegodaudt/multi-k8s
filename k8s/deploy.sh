docker build -t diegodaudt/multi-client:latest -t diegodaudt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t diegodaudt/multi-server:latest -t diegodaudt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t diegodaudt/multi-worker:latest -t diegodaudt/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push diegodaudt/multi-client:latest
docker push diegodaudt/multi-server:latest
docker push diegodaudt/multi-worker:latest

diegodaudt/multi-client:$SHA
diegodaudt/multi-server:$SHA
diegodaudt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=diegodaudt/multi-server:$SHA
kubectl set image deployments/client-deployment client=diegodaudt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=diegodaudt/multi-worker:$SHA
