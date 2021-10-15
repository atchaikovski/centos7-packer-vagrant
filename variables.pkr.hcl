variable "iso_url" {
  type    = string
  default = "[flash] ISO/CentOS-7-x86_64-Minimal-2009.iso"
}

variable "vm-cpu-num" {
  type    = string
  default = "2"
}

variable "vm-disk-size" {
  type    = string
  default = "16384"
}

variable "vm-mem-size" {
  type    = string
  default = "4096"
}

variable "vm-name" {
  type    = string
  default = "c7-empty"
}

variable "vsphere-cluster" {
  type    = string
  default = "AlexCluster"
}

variable "vsphere-datacenter" {
  type    = string
  default = "AlexDC"
}

variable "vsphere-datastore" {
  type    = string
  default = "flash"
}

variable "vsphere-network" {
  type    = string
  default = "VM_Lab"
}

variable "vsphere-password" {
  type    = string
  default = "P@sw0rd1"
}

variable "vsphere-server" {
  type    = string
  default = "192.168.0.46"
}

variable "vsphere-user" {
  type    = string
  default = "Administrator@alex.local"
}

