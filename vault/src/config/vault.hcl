ui = true

api_addr = "https://127.0.0.1:8200/"

storage "raft" {
    path = "/opt/raft"
    node_id = "raft_node_1"
}
cluster_addr = "http://127.0.0.1:8201"

listener "tcp" {
    address = "0.0.0.0:8200"
    tls_cert_file = "/etc/vault.d/cert.pem"
    tls_key_file = "/etc/vault.d/key.pem"
}