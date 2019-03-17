docker build -t mikezank/multi-client:latest -t mikezank/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mikezank/multi-server:latest -t mikezank/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mikezank/multi-worker:latest -t mikezank/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mikezank/multi-client:latest
docker push mikezank/multi-server:latest
docker push mikezank/multi-worker:latest
docker push mikezank/multi-client:$SHA
docker push mikezank/multi-server:$SHA
docker push mikezank/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mikezank/multi-server:$SHA
kubectl set image deployments/client-deployment client=mikezank/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mikezank/multi-worker:$SHA