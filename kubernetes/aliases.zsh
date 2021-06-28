alias k='kubectl $*'
alias kr='kubectl -n renderer $*'
alias kl='kubectl -n logging $*'

function kapp() {
  kubectl exec -it $(kubectl get pods -lapp=demodesk-app --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | head -n 1) -- bash
}

function krails() {
  kubectl exec -it $(kubectl get pods -lapp=demodesk-app --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | head -n 1) -- rails console -- --nomultiline
}
