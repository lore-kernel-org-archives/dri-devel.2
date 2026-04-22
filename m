Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC986FA1FC5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2801610E2C5;
	Wed, 22 Apr 2026 16:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H06pDuM/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DAB210E2C5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:03:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F23F941B3F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4FD5C2BCB8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776873793;
 bh=cPPEx0zrinEir2JEyw3xH+jrZIcxqSkLJcFsGKi9eaU=;
 h=From:To:Subject:Date:From;
 b=H06pDuM/C8JU6JMChd+vw7jMjnAUmFPwBofo5G83gA3k1ut6nCUHaBxk5+iV7vPLL
 wj3pp7lfW4eyMC+bH+qtxAHhP5oYQJXe6RVFA/AudycgpslyQi1mmb4WmiZRB6+y6y
 c7hXtPcuTM10327YBwjqafudHlglbkKQuqgBup/rbToxnx6MBMn7jc/I0Xc/G09fEa
 aTX/xD/7T/JdcQxJA90ZLcQHljScztp6W6XfrywKZROmOEv1xnJPoTTIMjuatyFIY+
 dgHnKLU+f0Oo0uQE01EQUQkvte+L9d1/BirD92rfwOmMFXq08nrBd6Wr4bQlSWO0ZM
 mjCpKbb8bZdKQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id BE28CC3279F; Wed, 22 Apr 2026 16:03:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: =?UTF-8?B?W0J1ZyAyMjE0MDJdIE5ldzogZUdQVSBicmVha3MgcGVybWFuZW50?=
 =?UTF-8?B?bHkgYWZ0ZXIgaGliZXJuYXRlIHdpdGggVEI0IHR1bm5lbCBhY3RpdmUgb24g?=
 =?UTF-8?B?QU1EIFN0cml4IEhhbG8gKFJ5emVuIEFJIE1heCsgMzk1KSDigJQgTGludXgt?=
 =?UTF-8?B?c3BlY2lmaWM=?=
Date: Wed, 22 Apr 2026 16:03:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: conrad.dobrowolski@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221402-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D221402

            Bug ID: 221402
           Summary: eGPU breaks permanently after hibernate with TB4
                    tunnel active on AMD Strix Halo (Ryzen AI Max+ 395) =E2=
=80=94
                    Linux-specific
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: conrad.dobrowolski@gmail.com
        Regression: No

# eGPU breaks permanently after hibernate with TB4 tunnel active on AMD Str=
ix
Halo (Ryzen AI Max+ 395) =E2=80=94 Linux-specific, Windows unaffected

## Summary

On an ASUS ROG Flow Z13 (GZ302EA) with AMD Ryzen AI Max+ 395 "Strix Halo," =
an
eGPU connected via TB4 works perfectly on first boot but is permanently bro=
ken
at the Linux kernel level after a single hibernate cycle with the eGPU
attached. The failure persists across reboots, EC resets, cable swaps, BIOS
defaults, and multiple distro/kernel combinations.

**Critical finding:** The same hardware (laptop + enclosure + GPU + cable)
works correctly on Windows 11 with AMD drivers. This confirms:
- The hardware is not damaged
- The TB4 controller firmware is not permanently bricked
- The bug is in Linux's handling of amdgpu + Thunderbolt + Strix Halo
specifically

## Hardware

- **Laptop:** ASUS ROG Flow Z13 GZ302EA
- **SoC:** AMD Ryzen AI Max+ 395 (Strix Halo, 16C/32T, Radeon 8060S iGPU
gfx1151)
- **RAM:** 128 GiB unified LPDDR5X
- **BIOS:** GZ302EA.311 (American Megatrends, Sept 19 2025 =E2=80=94 latest=
 available
from ASUS as of Apr 2026)
- **eGPU enclosure:** ADTLINK UT4G (USB4 40 Gb/s)
- **eGPU GPU:** AMD Radeon RX 7900 XTX (Navi 31, 1002:744c) =E2=80=94 repro=
duced with
RX 5700 XT
- **Cable:** Both TB4 and TB5 rated cables tested =E2=80=94 identical failu=
re

## Software

- **OS:** Fedora Linux 43 (KDE Plasma Desktop Edition)
- **Kernel (installed):** 6.19.12-200.fc43.x86_64
- **Kernel (live USB):** 6.17.1-300.fc43.x86_64 =E2=80=94 tested, same fail=
ure
- **Mesa:** 25.3.6
- **ROCm:** 6.4.2
- **fwupd:** 2.0.20

## Reproduction

1. Fresh boot with eGPU attached =E2=80=94 works perfectly. `lspci` shows f=
ull chain
(ASMedia 03:00/04:00 =E2=86=92 Navi 31 at 05:00.0), amdgpu binds, rocminfo =
reports both
`gfx1151` (iGPU) and `gfx1100` (eGPU), monitors on the eGPU display correct=
ly,
ROCm/Ollama/PyTorch all function.
2. `sudo systemctl hibernate` (with eGPU still attached)
3. Wake from hibernate
4. eGPU no longer functions and never recovers

## Failure Modes Observed

After the break, various failure modes appear cycling across reboots:

### Mode A =E2=80=94 Discovery failure (most common, reproduces 100% on cle=
an live USB)
amdgpu 0000:05:00.0: enabling device (0000 -> 0003)
amdgpu 0000:05:00.0: amdgpu: initializing kernel modesetting (IP DISCOVERY
0x1002:0x744C 0x1002:0x744C 0xC8).
amdgpu 0000:05:00.0: amdgpu: register mmio base: 0xBC000000
amdgpu 0000:05:00.0: amdgpu: register mmio size: 1048576
amdgpu 0000:05:00.0: amdgpu: failed to read discovery info from memory, vram
size read: 0
amdgpu 0000:05:00.0: amdgpu: [drm] ERROR discovery failed: -2
amdgpu 0000:05:00.0: amdgpu: Fatal error during GPU init
amdgpu 0000:05:00.0: amdgpu: finishing device.
amdgpu 0000:05:00.0: probe with driver amdgpu failed with error -2

### Mode B =E2=80=94 TB4 port training timeout loop
thunderbolt 0000:c6:00.5: 0:2: failed to reach state TB_PORT_UP. Ignoring
port...
thunderbolt 0000:c6:00.5: 0:2: lost during suspend, disconnecting
Note: "lost during suspend" fires even when no suspend has occurred since b=
oot.

### Mode C =E2=80=94 SR-IOV guest path triggered on physical device (highly=
 unusual)
amdgpu 0000:05:00.0: amdgpu: trn=3D2 ACK should not assert! wait again !
xgpu_nv_mailbox_trans_msg: 2471 callbacks suppressed
The `xgpu_nv_*` codepath is the Navi SR-IOV virtual-function guest driver. =
This
should NOT execute on a physical 7900 XTX. Strongly suggests the TB4 tunnel=
 is
presenting corrupted PCIe capabilities after the hibernate event.

### Mode D =E2=80=94 Partial PCIe enumeration
Upstream ASMedia switch appears but Navi 10 XL downstream switch never prob=
es.
PCIe hot-plug event `Card present / Link Up` fires on the root port, but ch=
ild
enumeration stalls.

### Mode E =E2=80=94 TB4 handshake succeeds but no PCIe tunnel built
`boltctl list` shows `authorized` at 40 Gb/s RX/TX. `/sys/class/thunderbolt=
/`
populates correctly. But `lspci` shows nothing new under the TB4 root port.
Enclosure cycles power every ~60 seconds in a failed retry loop.

## Recovery attempts (all failed on Linux)

1. Soft reboot (`sudo reboot`)
2. EC reset (40-second power button + AC unplugged)
3. Cold boot with eGPU pre-attached (not hot-plugged)
4. `boltctl forget <uuid>` + fresh reauthorize
5. PCIe rescan: `echo 1 > /sys/bus/pci/rescan`
6. PCIe tunnel teardown + rebuild
7. Driver unbind/rebind on Navi 31 endpoint
8. Cable swap (TB4-certified =E2=86=92 TB5-certified, both fail)
9. BIOS "Load Optimized Defaults"
10. `fwupdmgr reinstall <system-firmware-UUID>` =E2=80=94 LVFS reports no r=
eleases
available
11. Fresh Fedora 43 live USB boot (kernel 6.17.1, clean userspace, no prior
state) =E2=80=94 same failure
12. Second GPU tested (RX 5700 XT) =E2=80=94 identical failure modes
13. Both USB4 ports on Z13 tested =E2=80=94 identical

## What conclusively proves this is a Linux software issue

After extensive testing:

1. **Same 7900 XTX + ADTLINK + cable on separate x86 laptop (Linux):** Works
perfectly, full functionality
2. **Same Z13 + ADTLINK + RX 5700 XT on Windows 11 (fresh install + AMD
Adrenalin drivers):** Works correctly =E2=80=94 GPU enumerates in Device Ma=
nager,
displays function normally, no failure modes reproduce
3. **Clean Fedora 43 live USB on Z13 (zero prior userspace state):** Reprod=
uces
the same Mode A `discovery failed: -2` error immediately on first eGPU plug=
-in

This is conclusive: **the hardware is good**, and **the issue is in how Lin=
ux's
amdgpu driver interacts with the AMD Strix Halo TB4 controller state** in a=
 way
that Windows' driver stack handles correctly.

## Working theory

The AMD Strix Halo TB4/USB4 host controller appears to enter a state after
hibernate where:
- The TB4 handshake completes correctly (`boltctl` reports authorized at fu=
ll
40 Gb/s)
- The PCIe tunnel is built and enumerates successfully (full chain visible =
in
`lspci -tv`)
- Memory BARs are assigned correctly by the PCI core
- **But reads from the GPU's discovery ROM return zeros** =E2=80=94 `vram s=
ize read: 0`

Windows' AMD chipset + TB4 driver apparently performs additional
reinitialization of the TB4 host controller on boot that Linux's
amdgpu/thunderbolt drivers do not.

### Possible upstream fixes to investigate

1. **amdgpu_discovery.c** should validate discovery info reads and attempt
retry/reset if returned values are all zero, instead of failing the device
probe immediately
2. **amdgpu_virt.c / mxgpu_nv.c** =E2=80=94 the SR-IOV guest path (Mode C) =
should not
activate on devices whose capability reads are inconsistent; this appears t=
o be
a separate genuine bug where corrupted capability data triggers the virt
codepath on physical hardware
3. **drivers/thunderbolt** =E2=80=94 AMD Strix Halo USB4 host controller ma=
y need an
explicit reinit sequence after system hibernate/resume, which Intel TB4
controllers apparently do not require

## Relevant source files

- `drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c` =E2=80=94 discovery info =
reads (Mode
A origin)
- `drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c` =E2=80=94 SR-IOV detection log=
ic
- `drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c` =E2=80=94 `xgpu_nv_mailbox_trans_=
msg` (Mode C
origin)
- `drivers/thunderbolt/*` =E2=80=94 TB4 host controller handling for AMD US=
B4

## Scope / other affected users

This bug appears specific to AMD Strix Halo platforms with external GPUs ov=
er
TB4. Other users on r/FlowZ13 and egpu.io forums with the same or similar
hardware (ROG Flow Z13 2025, HP ZBook Ultra 14, Framework Desktop) report
comparable issues. The bug does not appear on AMD desktop platforms or Intel
TB4 laptops under the same conditions.

## Environment output
$ uname -a
Linux fedora 6.19.12-200.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Apr 12 15:2=
6:33
UTC 2026 x86_64 GNU/Linux
$ lsb_release -a
Distributor ID: Fedora
Description:    Fedora Linux 43 (KDE Plasma Desktop Edition)
Release:        43
$ cat /sys/class/dmi/id/product_name
ROG Flow Z13 GZ302EA_GZ302EA
$ BIOS Version
GZ302EA.311 (confirmed via ASUS support site =E2=80=94 latest available as =
of
2026-04-22)

## Workaround

None on Linux. Current workaround is dual-boot with Windows 11 for eGPU
workloads. Linux side uses only the Strix Halo iGPU (gfx1151) with unified
memory for AI/compute workloads, which functions correctly.

## Prevention

Never hibernate with eGPU attached. Recommend upstream consideration of a
systemd-sleep hook that detects TB4 GPU passthrough and refuses hibernate, =
or a
kernel-side pre-hibernate TB4 tunnel teardown.

---

Report filed: 2026-04-22

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
