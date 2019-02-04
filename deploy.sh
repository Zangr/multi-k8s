docker build --no-cache -t rzangdocker/multi-client:latest -t rzangdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build --no-cache -t rzangdocker/multi-server:latest -t rzangdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build --no-cache -t rzangdocker/multi-worker:latest -t rzangdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rzangdocker/multi-client:latest
docker push rzangdocker/multi-server:latest
docker push rzangdocker/multi-worker:latest

docker push rzangdocker/multi-client:$SHA
docker push rzangdocker/multi-server:$SHA
docker push rzangdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rzangdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=rzangdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rzangdocker/multi-worker:$SHA