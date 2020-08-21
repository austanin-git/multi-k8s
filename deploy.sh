docker build -t austanin/multi-client:latest -t austanin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t austanin/multi-server:latest -t austanin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t austanin/multi-worker:latest -t austanin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#docker push austanin/multi-client:latest
#docker push austanin/multi-server:latest
#docker push austanin/multi-worker:latest

docker push austanin/multi-client:$SHA
docker push austanin/multi-server:$SHA
docker push austanin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=austanin/multi-server:$SHA
kubectl set image deployments/client-deployment client=austanin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=austanin/multi-worker:$SHA

###
