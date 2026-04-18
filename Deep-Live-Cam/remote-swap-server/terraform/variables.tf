variable "pod_name" {
  type        = string
  description = "RunPod pod display name"
  default     = "dlc-remote-swap"
}

variable "container_image" {
  type        = string
  description = "CUDA-capable image with Python (RunPod PyTorch tags work well)"
  default     = "runpod/pytorch:2.1.0-py3.10-cuda11.8.0-devel-ubuntu22.04"
}

variable "cloud_type" {
  type        = string
  description = "SECURE or COMMUNITY"
  default     = "COMMUNITY"
}

variable "gpu_type_ids" {
  type        = list(string)
  description = "Ordered GPU preferences; first available is used when gpu_type_priority is availability"
  default = [
    "NVIDIA RTX A4000",
    "NVIDIA RTX A4500",
    "NVIDIA RTX A5000",
    "NVIDIA GeForce RTX 4090",
    "NVIDIA GeForce RTX 4080",
  ]
}

variable "data_center_ids" {
  type        = list(string)
  description = "RunPod data center IDs. Extend or change if GPUs are unavailable."
  default = [
    "US-CA-2",
    "US-TX-3",
  ]
}

variable "container_disk_in_gb" {
  type        = number
  description = "Container disk (ephemeral); must fit ONNX + pip cache"
  default     = 50
}

variable "pod_volume_in_gb" {
  type        = number
  description = "Attached /workspace volume (persists across restarts)"
  default     = 20
}

variable "swap_service_api_key" {
  type        = string
  sensitive   = true
  description = "Bearer secret for /v1/swap (same value as DLC_REMOTE_SWAP_API_KEY on your Mac)"
}

variable "swap_code_git_url" {
  type        = string
  description = "Git URL to clone on first boot (must contain remote-swap-server under subpath)"
}

variable "swap_code_repo_subpath" {
  type        = string
  description = "Path from repo root to remote-swap-server directory"
  default     = "Deep-Live-Cam/remote-swap-server"
}
