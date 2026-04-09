Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CE4F31E59
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6270210E8E0;
	Thu,  9 Apr 2026 16:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ti182usG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D47C10E8E0
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 16:02:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 237A860121
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 16:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDD11C19424
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775750563;
 bh=HsKWoOrNSmlVSPFDSJ5Ub+UoCimg5Nip7eE/+pBVI0A=;
 h=From:To:Subject:Date:From;
 b=Ti182usGLVDrURbgPgGj/U6bTDYBsSB8mVyGBczbDIVKKM+/GrQJe8tFi4WgiZRyX
 4PFlOojLuVmY8pMs9ePSx81jxBLAh28tK0CHqQxSkclmT06w6NC6+S0DUZ17yIFx9W
 WpIhboPDpHXoBbvXkpS6HdncsDO6WoRB6KrOS+Uz207bqP5MeJ6p4nr20GJAe+9qKr
 KD6+90eEmUCx1kLkDbUO7MCcOZmMllDmWucSvdSzdBHAat0hwIX/Xho5imDxNv/noq
 CbWEJSZQ8DXQ+trVpqyCRVgYjuBwNiHIm40HrCZrrkIRPy+UXI0/cTByRFYqwq5CVD
 qXhqC1xnoG9rg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C51A3C41613; Thu,  9 Apr 2026 16:02:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221338] New: AMDGPU: RDNA2 (RX 6600) Vulkan workload causes gfx
 ring timeout, MODE1 reset,
 and VRAM loss (SMU driver/firmware mismatch)
Date: Thu, 09 Apr 2026 16:02:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tona_kosmicznego_smiecia@interia.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221338-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221338

            Bug ID: 221338
           Summary: AMDGPU: RDNA2 (RX 6600) Vulkan workload causes gfx
                    ring timeout, MODE1 reset, and VRAM loss (SMU
                    driver/firmware mismatch)
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: tona_kosmicznego_smiecia@interia.pl
        Regression: No

disclaimer: AI helped me to investigate the issue and put together the below
bug report, I'm no hardware prodigy, but hope that the below info is accura=
te.

The OS I'm using is Guix System with the nonguix channel that provides
proprietary firmware and drivers. I reported the issue there, but they told=
 me
it is a kernel issue so here I am.

### Problem

On an AMD Radeon RX 6600 PowerColor Fighter, Vulkan workloads consistently
trigger a GPU hang followed by a MODE1 reset. This occurs reliably in Blend=
er=E2=80=99s
Vulkan backend (installed through flatpak) and in Vulkan=E2=80=91based game=
s on Steam
(DXVK/VKD3D). After the reset, VRAM is lost and the session becomes unstabl=
e.

The kernel logs show a persistent **SMU driver/firmware interface mismatch*=
*,
even on newer kernels. Under heavy Vulkan load, this mismatch leads to a **=
gfx
ring timeout** and a full GPU reset.

**Hardware:**

* AMD Radeon RX 6600 (PCI ID 1002:73FF)
* VBIOS: `113-D5340100_100`
* VRAM: 8 GB

**Kernel versions tested:**

* 6.18.20 (nonguix build)
* 6.12.79 (nonguix LTS)\
  Both exhibit identical failures.

**Firmware:**

* `linux-firmware` version **20260309** (amdgpu firmware version 59.50.0)

**Mesa:**

* Mesa 26.0.2 (RADV)

**Key dmesg excerpts:**

```
amdgpu: smu driver if version =3D 0x0000000f, smu fw if version =3D 0x00000=
013
amdgpu: SMU driver if version not matched

amdgpu: ring gfx_0.0.0 timeout, signaled seq=3D..., emitted seq=3D... amdgp=
u: GPU
reset begin! amdgpu: MODE1 reset [drm] VRAM is lost due to GPU reset!
```

**Reproduction:**

1. Start Blender 5.1 with the Vulkan backend enabled
2. Interact with the viewport (add a cube or something) until it crashes
(usually 1-2 minutes)
3. GPU hangs =E2=86=92 gfx ring timeout =E2=86=92 MODE1 reset =E2=86=92 VRA=
M lost

Same behavior occurs in Vulkan games via DXVK/VKD3D.

**Proposed cause:**\
The SMU mismatch appears to be the root cause: firmware 59.50.0 exposes a n=
ewer
SMU interface than the amdgpu driver in 6.12/6.18 expects. Vulkan workloads
reliably trigger the fault path.

TL;DR firmware does not match Linux version.

Full log:

```
$ sudo dmesg -w | grep -iE 'amdgpu|gpu|ring|fault'
Password:=20
[    0.032578] pid_max: default: 32768 minimum: 301
[    0.155176] smp: Bringing up secondary CPUs ...
[    0.200260] ACPI: PM: Registering ACPI NVS region [mem
0x0a200000-0x0a20afff] (45056 bytes)
[    0.200260] ACPI: PM: Registering ACPI NVS region [mem
0xdbe77000-0xdc3cefff] (5603328 bytes)
[    0.288424] iommu: Default domain type: Translated
[    0.288424] NetLabel:  unlabeled traffic allowed by default
[    0.323823] PCI: CLS 64 bytes, default 64
[    0.326715] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.330993] Initialise system trusted keyrings
[    0.356756] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.509760] nvme nvme0: 16/0/0 default/read/poll queues
[    0.553029] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.553921] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.554932] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.555721] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.761212] init[1]: segfault at 3fff00 ip 00000000004d5593 sp
00007ffd93ceeeb0 error 4 in guile[d5593,401000+202000] likely on CPU 1 (cor=
e 1,
socket 0)
[    0.945861] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    1.121123] usb 1-9: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[   27.899089] shepherd[1]: Registering new logger for udev.
[   30.815854] amdgpu: Virtual CRAT table created for CPU
[   30.815878] amdgpu: Topology: Add CPU node
[   30.820511] amdgpu 0000:28:00.0: No more image in the PCI ROM
[   30.820529] amdgpu 0000:28:00.0: amdgpu: Fetched VBIOS from ROM BAR
[   30.820532] amdgpu: ATOM BIOS: 113-D5340100_100
[   30.853724] amdgpu 0000:28:00.0: vgaarb: deactivate vga console
[   30.853728] amdgpu 0000:28:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re
disabled as experimental (default)
[   30.853787] amdgpu 0000:28:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 -
0x00000081FEFFFFFF (8176M used)
[   30.853790] amdgpu 0000:28:00.0: amdgpu: GART: 512M 0x0000000000000000 -
0x000000001FFFFFFF
[   30.854013] [drm] amdgpu: 8176M of VRAM memory ready
[   30.854016] [drm] amdgpu: 11990M of GTT memory ready.
[   30.854037] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   34.489983] amdgpu 0000:28:00.0: amdgpu: STB initialized to 2048 entries
[   34.559736] amdgpu 0000:28:00.0: amdgpu: reserve 0xa00000 from 0x81fd000=
000
for PSP TMR
[   34.662938] amdgpu 0000:28:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot
available
[   34.680515] amdgpu 0000:28:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
ucode is not available
[   34.680542] amdgpu 0000:28:00.0: amdgpu: smu driver if version =3D 0x000=
0000f,
smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3=
200
(59.50.0)
[   34.680552] amdgpu 0000:28:00.0: amdgpu: SMU driver if version not match=
ed
[   34.680588] amdgpu 0000:28:00.0: amdgpu: use vbios provided pptable
[   34.731186] amdgpu 0000:28:00.0: amdgpu: SMU is initialized successfully!
[   34.738403] snd_hda_intel 0000:28:00.1: bound 0000:28:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[   34.786561] [drm] kiq ring mec 2 pipe 1 q 0
[   34.796035] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[   34.796057] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[   34.796288] amdgpu: Virtual CRAT table created for GPU
[   34.796834] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[   34.796836] kfd kfd: amdgpu: added device 1002:73ff
[   34.796858] amdgpu 0000:28:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,
active_cu_number 28
[   34.796863] amdgpu 0000:28:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on
hub 0
[   34.796866] amdgpu 0000:28:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on
hub 0
[   34.796869] amdgpu 0000:28:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4
on hub 0
[   34.796871] amdgpu 0000:28:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5
on hub 0
[   34.796874] amdgpu 0000:28:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6
on hub 0
[   34.796876] amdgpu 0000:28:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7
on hub 0
[   34.796878] amdgpu 0000:28:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8
on hub 0
[   34.796880] amdgpu 0000:28:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9
on hub 0
[   34.796883] amdgpu 0000:28:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10
on hub 0
[   34.796885] amdgpu 0000:28:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11
on hub 0
[   34.796887] amdgpu 0000:28:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12
on hub 0
[   34.796890] amdgpu 0000:28:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on
hub 0
[   34.796892] amdgpu 0000:28:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on
hub 0
[   34.796894] amdgpu 0000:28:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on
hub 8
[   34.796897] amdgpu 0000:28:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1
on hub 8
[   34.796899] amdgpu 0000:28:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4
on hub 8
[   34.796901] amdgpu 0000:28:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on
hub 8
[   34.798313] amdgpu 0000:28:00.0: amdgpu: Using BACO for runtime pm
[   34.799078] [drm] Initialized amdgpu 3.61.0 for 0000:28:00.0 on minor 0
[   34.805500] fbcon: amdgpudrmfb (fb0) is primary device
[   34.860088] amdgpu 0000:28:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[   45.871018] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by
default. Update your scripts to load br_netfilter if you need this.
[ 6230.380965] amdgpu 0000:28:00.0: amdgpu: Dumping IP State
[ 6230.382903] amdgpu 0000:28:00.0: amdgpu: Dumping IP State Completed
[ 6230.393001] amdgpu 0000:28:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled
seq=3D556035, emitted seq=3D556037
[ 6230.393014] amdgpu 0000:28:00.0: amdgpu: Process information: process
blender pid 4958 thread blender pid 4985
[ 6230.654347] amdgpu 0000:28:00.0: amdgpu: GPU reset begin!
[ 6230.876312] amdgpu 0000:28:00.0: amdgpu: MODE1 reset
[ 6230.876317] amdgpu 0000:28:00.0: amdgpu: GPU mode1 reset
[ 6230.876381] amdgpu 0000:28:00.0: amdgpu: GPU smu mode1 reset
[ 6231.401925] amdgpu 0000:28:00.0: amdgpu: GPU reset succeeded, trying to
resume
[ 6231.402230] [drm] VRAM is lost due to GPU reset!
[ 6231.402235] amdgpu 0000:28:00.0: amdgpu: PSP is resuming...
[ 6231.485428] amdgpu 0000:28:00.0: amdgpu: reserve 0xa00000 from 0x81fd000=
000
for PSP TMR
[ 6231.589963] amdgpu 0000:28:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot
available
[ 6231.607384] amdgpu 0000:28:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
ucode is not available
[ 6231.607393] amdgpu 0000:28:00.0: amdgpu: SMU is resuming...
[ 6231.607401] amdgpu 0000:28:00.0: amdgpu: smu driver if version =3D 0x000=
0000f,
smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3=
200
(59.50.0)
[ 6231.607411] amdgpu 0000:28:00.0: amdgpu: SMU driver if version not match=
ed
[ 6231.607448] amdgpu 0000:28:00.0: amdgpu: use vbios provided pptable
[ 6231.660858] amdgpu 0000:28:00.0: amdgpu: SMU is resumed successfully!
[ 6231.661599] [drm] kiq ring mec 2 pipe 1 q 0
[ 6231.726662] amdgpu 0000:28:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on
hub 0
[ 6231.726667] amdgpu 0000:28:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on
hub 0
[ 6231.726669] amdgpu 0000:28:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4
on hub 0
[ 6231.726672] amdgpu 0000:28:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5
on hub 0
[ 6231.726674] amdgpu 0000:28:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6
on hub 0
[ 6231.726677] amdgpu 0000:28:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7
on hub 0
[ 6231.726679] amdgpu 0000:28:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8
on hub 0
[ 6231.726682] amdgpu 0000:28:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9
on hub 0
[ 6231.726684] amdgpu 0000:28:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10
on hub 0
[ 6231.726686] amdgpu 0000:28:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11
on hub 0
[ 6231.726688] amdgpu 0000:28:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12
on hub 0
[ 6231.726691] amdgpu 0000:28:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on
hub 0
[ 6231.726693] amdgpu 0000:28:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on
hub 0
[ 6231.726695] amdgpu 0000:28:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on
hub 8
[ 6231.726698] amdgpu 0000:28:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1
on hub 8
[ 6231.726700] amdgpu 0000:28:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4
on hub 8
[ 6231.726702] amdgpu 0000:28:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on
hub 8
[ 6231.730096] amdgpu 0000:28:00.0: amdgpu: GPU reset(1) succeeded!
[ 6231.770210] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize
parser -125!
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
