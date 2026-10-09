Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6E0CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D2810E1BD;
	Fri,  9 Oct 2026 20:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sr8fhObQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD7310E1BD
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A4DFF4346E
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83B7CC2BCF4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791577701;
 bh=X1l0tG1xvOAndde772CD3/p0H45F+lqKORyXIVoF0xk=;
 h=From:To:Subject:Date:From;
 b=Sr8fhObQv/Ib2MAA+42nrdgl7WMfkImmjbw5b6EvUNZLhD8iuYKl8s8qujNOMVLpl
 x43EvJd/SY07jsZCDuWDr8HwFotNlvFF9cQe5B8M7HlzHIl8AiBcTm61YBko4s+JA2
 GCcMYGlIShomj3MUQnbnZczwQo4Mz+hWaC7Vk302owLbjHefS1yGZDH83bl0aqRemY
 SCzpfbfZ4RVap8Ve0Ew+8uQphfelC27/4721E4Lf3wk1cE8stcZgimFR8rjVYxo6dx
 BcDMnVDEzEblXKo5G7CJ21qRZKn4pIUKr9coNzyCVYp08C9vzJzsdviawSq3gXu9MH
 699CgtK39Kwmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 65450C433E1; Fri,  9 Oct 2026 20:28:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222109] New: [amdgpu Picasso 1002:15d8] gfxhub UTCL2 SQC
 permission fault -> ring gfx timeout when DPM forced high (repro on LTS 6.18
 too)
Date: Fri, 09 Oct 2026 20:28:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aleksey16.11.2000@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222109-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222109

            Bug ID: 222109
           Summary: [amdgpu Picasso 1002:15d8] gfxhub UTCL2 SQC permission
                    fault -> ring gfx timeout when DPM forced high (repro
                    on LTS 6.18 too)
           Product: Drivers
           Version: 2.5
          Hardware: x86-64
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: aleksey16.11.2000@gmail.com
        Regression: No

Summary:
amdgpu Picasso/Raven2 [1002:15d8] wedges with gfxhub UTCL2 SQC permission f=
ault
followed by ring gfx timeout when DPM forced to high. Deterministic on cold
boot + immediate GUI. Also reproduces on Arch LTS 6.18.55, not
CachyOS-specific. TLP/manual `high` is only the trigger, kernel should not
wedge.

Hardware:
- Laptop QUANTA, BIOS 3.07 09/14/2021
- CPU AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx (Picasso/Raven2)
- GPU 03:00.0 VGA [1002:15d8] rev c2, amdgpu, VBIOS 113-PICASSO-115 2019/04=
/25,
DCN 1.0, PSP v10, SMU10, VCN 1.15, TMZ enabled
- VRAM 1024M BAR 1024M (0xF400000000-0xF43FFFFFFF), GART 1024M, vm 4-level
262144GB
- RAM 2x4GB Hynix DDR4-2667MT/s @2400MT/s (shared with VRAM/GTT)
- NVMe Toshiba KXG60ZNV256G (SMART PASSED, media errors 0), btrfs 0 errors
- No MCE/MCA, HardwareCorrupted 0, EDAC N/A (no ECC on this APU)

Software (both affected):
- BAD: linux-cachyos 7.2.9-1 (DRM 3.64, DC 3.2.384) AND arch linux-lts
6.18.55-1 (reporter confirms same fault on LTS)
- Mesa 26.2.4-arch3.1 radeonsi raven ACO OpenGL 4.6, vulkan-radeon RADV pre=
sent
but NOT involved
- linux-firmware 20260916 (picasso_* present), kwin 6.7.5 Wayland, kitty
0.49.2, plasma-desktop 6.7.5, TLP 1.10.2
- Kernel cmdline: BOOT_IMAGE=3D/@/boot/vmlinuz-linux-cachyos
root=3D/dev/mapper/vg0-notebook rw rootflags=3Dsubvol=3D@ loglevel=3D3 quie=
t splash
- Taint 0. Note: sched_ext lavd present on CachyOS but LTS without it also
fails. Broken BIOS warnings: TSC unstable, ccp psp unable to access device.

Reproducer (99% on cold boot):
1. Set `power_dpm_force_performance_level=3Dhigh` (e.g. TLP
RADEON_DPM_PERF_LEVEL_ON_AC=3Dhigh on AC, or `echo high >
/sys/class/drm/card1/device/power_dpm_force_performance_level`). This locks
sclk ~1200MHz / mclk 1200MHz. CPU governor performance + boost 1 in paralle=
l.
2. Boot cold, login to Plasma Wayland, immediately start any GUI GL app (ki=
tty,
kwin compositing itself).
3. Within seconds: 10x gfxhub faults, then ring timeout.
Workaround: `auto` (sclk drops to ~210MHz idle) =3D> 0 faults. If boot in
powersave, wait for DE to settle, then switch to high =3D> usually survives=
. So
early-first-CS + locked-high is the window.

Expected: high DPM may use more power/heat but must not wedge GPU VM.
Actual: GPU wedged, needs MODE2 reset. Desktop freezes 2-5s+, journal
corruption on hard poweroff (555 unsafe shutdowns total on this drive from a
week of hangs).

Fault log (journal -k -b -1, 23:06:55-23:07:00):
```
amdgpu 0000:03:00.0: [gfxhub0] no-retry page fault (src_id:0 ring:153 vmid:0
pasid:0)
amdgpu 0000:03:00.0:   in page starting at address 0x00000016c4080000 from =
IH
client 0x1b (UTCL2)
amdgpu 0000:03:00.0: VM_L2_PROTECTION_FAULT_STATUS:0x00601431
amdgpu 0000:03:00.0:          Faulty UTCL2 client ID: SQC (data) (0xa)
amdgpu 0000:03:00.0:          MORE_FAULTS: 0x1
amdgpu 0000:03:00.0:          WALKER_ERROR: 0x0
amdgpu 0000:03:00.0:          PERMISSION_FAULTS: 0x3
amdgpu 0000:03:00.0:          MAPPING_ERROR: 0x0
amdgpu 0000:03:00.0:          RW: 0x0
... repeats for 0x16c4090000, 0x16c4020000, 0x16c4030000, 0x16c40e0000,
0x16c40f0000, 0x16c40c0000, 0x16c40d0000, 0x16c4100000, 0x16c4060000
(contiguous ~896KB range)
amdgpu 0000:03:00.0: Dumping IP State / Dumping IP State Completed
amdgpu 0000:03:00.0: [drm] AMDGPU device coredump file has been created
amdgpu 0000:03:00.0: ring gfx timeout, signaled seq=3D62433, emitted seq=3D=
62434
amdgpu 0000:03:00.0:  Process kitty pid 2202 thread kitty:cs0 pid 2236
amdgpu 0000:03:00.0: Starting gfx ring reset
amdgpu 0000:03:00.0: Ring gfx reset failed
amdgpu 0000:03:00.0: GPU reset begin!. Source: 1
amdgpu 0000:03:00.0: MODE2 reset
amdgpu 0000:03:00.0: GPU reset succeeded, trying to resume
amdgpu 0000:03:00.0: GPU reset(1) succeeded!
amdgpu 0000:03:00.0: ring gfx timeout, signaled seq=3D62434, emitted seq=3D=
62437
amdgpu 0000:03:00.0:  Process kwin_wayland pid 1510 thread kwin_wayla:cs0 p=
id
1522
amdgpu 0000:03:00.0: Starting gfx ring reset
amdgpu 0000:03:00.0: Ring gfx reset succeeded
```
Full `journal-k` and `journal-full` of faulty boot attached. Current `auto`
boot has 0 such lines.

Analysis for developers:
- PERMISSION_FAULTS 0x3 with MAPPING_ERROR 0x0 and RW 0x0 (read): PTE exists
but access denied. Not missing memory. SQC =3D shader instruction/data cache
fetch path via UTCL2. vmid 0 pasid 0 ring 153. Points to shader BO
use-after-free / wrong permissions / VM-update race in radeonsi+amdgpu, or =
TMZ
secure mismatch, exposed by timing change under locked-high clocks. Same SQC
0xa class seen widely (RX6700XT, 9070XT, Iris, games) and TCP 0x8 variant in
cosmic-comp#2149, so not Picasso-only.
- TLP is innocent: it only writes `high` to sysfs as configured. Driver must
handle `high`.
- Not proven hardware: no ECC errors possible here, but MCE 0, mem
HardwareCorrupted 0, NVMe media 0, btrfs 0, GPU recovers via MODE2. Shared =
RAM
still needs memtest86+ for 100% exclusion, will run if requested.
- Confounders: old VBIOS 2019 vs 2025 firmware, PSP LOAD_TA 0x7 (normally
missing RAS TA on Picasso), PSP TMR reserve, broken BIOS (TSC, ccp psp), BI=
OS
CPU limit 2.1GHz vs 3.7GHz max.

Attachments to follow: journal-k faulty, fault extract, lspci,
versions/uname/cmdline, gpu-init, tlp-stat, pp_dpm. devcoredump was created=
 but
is RAM-only and lost after reboot; reporter can re-capture with udev rule on
next `high` repro if needed. No RADV involvement (OpenGL radeonsi path).

Request: please advise if `amdgpu.vm_update_mode`, `cwsr_enable`, or DPM de=
bug
needed, will test.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
