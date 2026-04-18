output "pod_id" {
  value       = runpod_pod.dlc_remote_swap.id
  description = "RunPod pod id (used in proxy hostname)"
}

output "dlc_remote_swap_url" {
  value       = local.swap_public_url
  description = "Set DLC_REMOTE_SWAP_URL to this value on your Mac"
}

output "env_snippet_for_mac" {
  value = <<-EOT
    export DLC_REMOTE_SWAP_URL="${local.swap_public_url}"
    export DLC_REMOTE_SWAP_API_KEY="<same as swap_service_api_key / TF_VAR_swap_service_api_key>"
  EOT
  description = "Paste into shell or env.remote (replace placeholder with your secret)"
  sensitive   = false
}
