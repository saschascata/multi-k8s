docker build -t saschascata/multi-client:latest -t saschascata/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saschascata/multi-server:latest -t saschascata/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saschascata/multi-worker:latest -t saschascata/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push saschascata/multi-client:latest
docker push saschascata/multi-server:latest
docker push saschascata/multi-worker:latest

docker push saschascata/multi-client:$SHA
docker push saschascata/multi-server:$SHA
docker push saschascata/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=saschascata/multi-server:$SHA
kubectl set image deployments/client-deployment client=saschascata/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=saschascata/multi-worker:$SHA