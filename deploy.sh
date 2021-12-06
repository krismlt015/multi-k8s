docker build -t kfenech2001/multi-client:latest -t kfenech2001/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kfenech2001/multi-server:latest -t kfenech2001/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t kfenech2001/multi-worker:latest -t kfenech2001/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push kfenech2001/multi-client:latest
docker push kfenech2001/multi-server:latest
docker push kfenech2001/multi-worker:latest

docker push kfenech2001/multi-client:$SHA
docker push kfenech2001/multi-server:$SHA
docker push kfenech2001/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=kfenech2001/multi-server:$SHA
kubectl set image deployments/client-deployment client=kfenech2001/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kfenech2001/multi-worker:$SHA
