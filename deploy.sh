docker build -t systemsvs/multi-client:latest -t systemsvs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t systemsvs/multi-server:latest -t systemsvs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t systemsvs/multi-worker:latest -t systemsvs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push systemsvs/multi-client:latest
docker push systemsvs/multi-server:latest
docker push systemsvs/multi-worker:latest
docker push systemsvs/multi-client:$SHA
docker push systemsvs/multi-server:$SHA
docker push systemsvs/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=systemsvs/multi-server:$SHA
kubectl set image deployments/client-deployment client=systemsvs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=systemsvs/multi-worker:$SHA
