#!/bin/bash

# Chemin vers le fichier de configuration
WHANOS_CONFIG="whanos.yml"

# Vérification de kubectl
if ! command -v kubectl &> /dev/null; then
    echo "Erreur : kubectl n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Création du namespace Whanos si nécessaire
kubectl get namespace whanos >/dev/null 2>&1 || kubectl create namespace whanos

# Parcours des applications définies dans le fichier whanos.yml
yq eval '.apps[]' $WHANOS_CONFIG | while read -r app; do
  NAME=$(echo "$app" | yq eval '.name' -)
  IMAGE=$(echo "$app" | yq eval '.image' -)
  REPLICAS=$(echo "$app" | yq eval '.replicas' -)
  PORTS=$(echo "$app" | yq eval '.ports | join(",")' -)
  HOST=$(echo "$app" | yq eval '.host' -)

  echo "Déploiement de l'application : $NAME"

  # Déploiement Kubernetes
  kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $NAME
  namespace: whanos
spec:
  replicas: $REPLICAS
  selector:
    matchLabels:
      app: $NAME
  template:
    metadata:
      labels:
        app: $NAME
    spec:
      containers:
      - name: $NAME
        image: $IMAGE
        ports:
        $(for port in $(echo $PORTS | tr "," "\n"); do echo "        - containerPort: $port"; done)
EOF

  # Service Kubernetes
  kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: $NAME-service
  namespace: whanos
spec:
  selector:
    app: $NAME
  ports:
  $(for port in $(echo $PORTS | tr "," "\n"); do echo "  - protocol: TCP\n    port: $port\n    targetPort: $port"; done)
  type: ClusterIP
EOF

  # Ingress Kubernetes
  kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $NAME-ingress
  namespace: whanos
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
  - host: $HOST
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: $NAME-service
            port:
              number: $(echo $PORTS | cut -d"," -f1)
EOF

  echo "Application $NAME déployée avec succès !"
done
