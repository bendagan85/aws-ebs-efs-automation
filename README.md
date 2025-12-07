# AWS Hybrid Storage Automation (EBS + EFS) ☁️

This project demonstrates Infrastructure as Code (IaC) principles using AWS CLI and Bash scripting.
It automatically provisions an EC2 instance with two types of storage attached and configured upon boot:
1. **Block Storage (EBS):** A dedicated 10GB volume formatted and mounted persistently.
2. **Network Storage (EFS):** A shared file system mounted via NFS protocol.

## 🛠️ Tech Stack
* **AWS CLI:** For infrastructure provisioning.
* **Bash / User Data:** For configuration management and automation.
* **Linux (Ubuntu):** OS configuration, package management (apt), and fstab manipulation.
* **NFS:** Used for connecting EFS to Ubuntu instances.

## 🚀 How it works
1. The `deploy_server.sh` script launches an EC2 instance and creates a custom 10GB EBS volume.
2. The `userdata.sh` script runs automatically on first boot:
   * **Detects** the new block device (`nvme` or `xvd`).
   * **Formats** the volume to `ext4` if needed.
   * **Installs** `nfs-common` to allow EFS connection (overcoming Ubuntu compatibility issues with standard EFS utils).
   * **Mounts** both volumes and updates `/etc/fstab` for persistence across reboots.

## 📸 Outcome
Server running with both Block and Network storage attached:
<img width="941" height="207" alt="image" src="https://github.com/user-attachments/assets/f18cfebb-4e32-4a71-a023-3f0a7a1fff17" />

