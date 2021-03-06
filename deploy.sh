docker build -t austanin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t austanin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t austanin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#docker push austanin/multi-client:latest
#docker push austanin/multi-server:latest
#docker push austanin/multi-worker:latest

docker push austanin/multi-client:$SHA
docker push austanin/multi-server:$SHA
docker push austanin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server-deployment=austanin/multi-server:$SHA
kubectl set image deployments/client-deployment client-deployment=austanin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker-deployment=austanin/multi-worker:$SHA

###
