---
layout: math
title: Neutron (Rei)
nav_order: 1
---

## Design

Neutron tries to be as minimal as possible.

The syscalls neutron defines are a very small set of services that allow userspace sparx to regularly authenticate themselves and directly access system resources without kernel intervention. Thus allowing other processes/apps to do so completely in userspace through IPC and zero copy semantics.
