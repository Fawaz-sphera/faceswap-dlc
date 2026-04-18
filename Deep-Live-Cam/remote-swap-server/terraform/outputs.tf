output "pod_id" {
  value       = runpod_pod.dlc_remote_swap.id
  description = "RunPod pod id (used in proxy hostname)"
}

output "dlc_remote_swap_url" {
  value       = local.swap_public_url
  description = "Set DLC_REMOTE_SWAP_URL to this value on your Mac"
}

output "env_snippet_for_mac" {
  value       = <<-EOT
    export DLC_REMOTE_SWAP_URL="${local.swap_public_url}"
    export DLC_REMOTE_SWAP_API_KEY="<same as swap_service_api_key / TF_VAR_swap_service_api_key>"
  EOT
  description = "Paste into shell or env.remote (replace placeholder with your secret)"
  sensitive   = false
}

output "runpod_ssh_hint" {
  value       = <<-EOT
    Proxied SSH username is ${runpod_pod.dlc_remote_swap.id}-<suffix>, not the pod id alone.
    Copy the exact `ssh ...@ssh.runpod.io` line from the pod’s Connect tab (suffix changes per pod).
    Example shape: ssh ${runpod_pod.dlc_remote_swap.id}-644117b2@ssh.runpod.io -i ~/.ssh/ssh_id_runpod
    Use the private key that matches a public key saved in RunPod → Account → SSH Public Keys.
  EOT
  description = "How to SSH via RunPod proxy"
}
