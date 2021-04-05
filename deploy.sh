docker build -t gavsum/multi-client:latest -t gavsum/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t gavsum/multi-server:latest -t gavsum/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t gavsum/multi-worker:latest -t gavsum/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push gavsum/multi-client:latest
docker push gavsum/multi-server:latest
docker push gavsum/multi-worker:latest

docker push gavsum/multi-client:$GIT_SHA
docker push gavsum/multi-server:$GIT_SHA
docker push gavsum/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=gavsum/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=gavsum/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=gavsum/multi-worker:$GIT_SHA
