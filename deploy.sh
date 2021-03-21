docker build -t om21/multi-client:latest -t om21/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t om21/multi-server:latest -t om21/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t om21/multi-worker:latest -t om21/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push om21/multi-client:latest
docker push om21/multi-server:latest
docker push om21/multi-worker:latest

docker push om21/multi-client:$SHA
docker push om21/multi-server:$SHA
docker push om21/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=om21/multi-server:$SHA
kubectl set image deployment/client-deployment client=om21/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=om21/multi-worker:$SHA
