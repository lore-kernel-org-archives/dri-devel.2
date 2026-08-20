Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F91AC5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE1410EF69;
	Thu, 20 Aug 2026 08:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YspEBRYN";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DC010E146
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:01:07 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-836c4474028so23900477b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 23:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787205666; cv=none;
 d=google.com; s=arc-20260327;
 b=fT1e0dJAOMu1YcA9Ul8Ew4hLMTb8+pdxcP60l7qaBIj8NxHr7mtoEYuOQzyBsd/sxH
 F9/xvKqvBWLfHMgwXl+3a6vzAYkjipE1sRjkiVgKppz5UyWp+mxmyBCoCdpg61fnZJ89
 FN+b0zfACYheNxQdAskqIK/pdHasxKJMLjBS+xK+sDdKmF8Uxi6ysXe+6b6nMO7KDDRR
 v1OiBa33CVcIiLtmEsbRoa1PM5UGgX2VElZFZJmspA6zTj5kYVB76+7XmNV/UUXod2Q4
 nIBtnhVsY2QMGMkIPLxR8jtJwEesU5Okn0FLa/GpPEuob99JemRseeUTyou9bba46GjE
 dVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=Hd3wmXGWWXt+JK4O5xunp/3s9VmCYICTuXs73AdTOME=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=HG+63zywm2/+lcTuai1AfbtOu14nitSzkRN2AZHxmJyim1/OSTM+hDFDWV6RTkoCr8
 nEMQV1GVuo9dOfdX51iiZ5TEhv8SJ+8OwtYN3V3jr/AeaIn6VtAjrp7Gd7Sd2eS9mNF5
 uSJmnAMV0H2ansJw8VL/Ek5UwVAUYWmZwnJDDgzAVoD2flmNxdbFvAj9S3KcK4aLnMOu
 cL34Z5MbfQ6d6gFEmXi8x57BIvCOBATCx9HqNDjYNxW4grYycJuYs/4Zb4z85zelV/X7
 HZpLd6dPmYmOLf05x7X1PYs70Bix8xMinsLn2c7IpAu3MtA38d0+4WJV77dSLtwg0Rt+
 fQBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787205666; x=1787810466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Hd3wmXGWWXt+JK4O5xunp/3s9VmCYICTuXs73AdTOME=;
 b=YspEBRYNxCKMOesRoUAlQk9qXZnrNEwnC5UQezsFQ43epn/LMeVWGKaqJwqAJEOTD4
 ZyGC/koU5/gA4LRRy6Ttl+9CN6S6enClBfINGJdyySqvlYsYikOjtI1RM4xvlboDigNc
 43z3buQTyIJxazFoUDEVu8OBdq1xX5+UkXeXZUJFd+Pt8VMn6DFNqxHHwIoTRgPVSom8
 NFs70fzEb+HK485uLAhEHTXkJv9vz0QObdSIiKPqikXqXY7+hiHiAYjbSpTNHa181sUf
 MeZj3yNC/o1BNLsUvim/s7Ql6IHF5UfV9AqQqAM+k65ryblPZunsCSpqCPtvCs/Lx5Q1
 eoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787205666; x=1787810466;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hd3wmXGWWXt+JK4O5xunp/3s9VmCYICTuXs73AdTOME=;
 b=FEeIiQ4sVv7xq0bt3g3v0eUWru3T2hINY/W4jf+Cr9VPBi9HdCPDJVYTqaJQ7KB4OB
 tXAaftoha6V6sbG5Gtw5M+q6B+oedl19Wz592gMsjmfv0iTBkZiRHFs8cVtleJvKoasP
 9FuckkI4/uMj9qc0z+sVgd8e06bSy8qwp9X16WTTJUq0b7lkfkgbXPsmmegHolFkOYWv
 QDN2rhZ2nEBEftoPMR9ykCvTu5GbECJosv6S7RD4oxE5BYznEppLrieV3MzmAHjL01DE
 hIgF6V8K138vd0CKvlq8Rj4guEBIKpw+1VVkGOOiYTEiE4A0nA03Nsr51Qnw1+7oNHN4
 9M9g==
X-Gm-Message-State: AFuF++kbKbfXpavn+Nk1CFJeOzylA9iA4OEmC07NBphFx+lcws5yJsY6
 EBPfjZ7YOzxwXhAayk57v+uSY9QQk2io1a9vw2oacZSgFmAe4TL0Hs1/6fuF8czjK3y6oLNjd9C
 8g0aoraMpdd9T70YuugNhFMgekWbIj2y5hTrD
X-Gm-Gg: AR+sD10unjE8CawujoX+Mu1bozZoVrUVkdZUEDEtYMr71Tyrp990rU2O25uoEz7itbT
 AoVHMQ5a4yj2ho/2KOWeL/f2h+fptoNMJHZWSRIBl/nE3DEgS40Sef7vuT4ww/whad1wXfnuKgn
 XD0c2bmBDu+xyBKSGBZ00MLdGFKzHcaa/p2vymqJndcFsSW0Qpr1hRwwIWzlAH9ntDHqMiJyfpy
 rURYkVSruPBj51WJ1yUEmgk1WJqpi+A8vF8NVGxpVdoV5mj1+6BkvBeETv54vEljjoJz+1K6NXl
 ErUTsnsm9xcglI0PxmXmx7xqEthPCOIIF//nEekIhML7juzTfMXGuEMIarfppkUBirNS/xtwj0O
 7STbfxCY4Hrps/MCQ+SxCqeOFLmR3yZ0k/pq1/qbr
X-Received: by 2002:a05:690c:38a:b0:81d:29ce:cd7f with SMTP id
 00721157ae682-844e1d53c1dmr37191817b3.24.1787205663900; Wed, 19 Aug 2026
 23:01:03 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 20 Aug 2026 16:00:50 +1000
X-Gm-Features: AcwNN1XbaQxdBk94miAIFd1SqeTiabRzaS72jUHWSV20eIfNOKTDua7etrEbRIQ
Message-ID: <CAPM=9ty-79O4_Cd_cGDTg11ej2sAQgFsjjkn3sd25mUaKwQBLw@mail.gmail.com>
Subject: [git pull] drm for 7.3-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

Hi Linus,

This is the main drm pull request for 7.3-rc1.

This unusally ends with a backmerge, the tree has been sitting on
7.2-rc2 and we didn't do any backmerges and the conflict numbers were
extra high due to code movement, so I decided to do a 7.2 backmerge to
use our drm-tip merges.

On the bright side, this means there are only two minor rust conflicts
with your tree.

This has a shared tree with driver-core for some rust i/o reworks, and
some perf exports.

I'll also note I didn't get an msm pull this round, which makes me
suspect something ate it somewhere, so it might arrive later in the
week.

Highlights:
- dmemcg eviction support is good for low VRAM things like Steam Machine
- AMD adds gfx6-8 modifier support for older GPUs that enables a bunch
of wayland stuff
- i915/xe has some new hw support but also a lot of display refactoring

Let me know if there any problems, or if you really don't like the
backmerge, it just seemed like a lot of conflicts to resolve that we'd
already resolved. We are moving towards a new -next procedure as well
where drm/misc/i915/xe and hopefully amd will start to be merged into
a single for next tree with all out -next/-fixes trees in it, to
lighten the load on others.

Regards,
Dave.

drm-next-2026-08-20:
drm for 7.3-rc1

perf:
- export perf_allow_ APIs for xe

udmabuf:
- remove default size limit of 64MB

rust:
- i/o rework (signed tag from driver-core tree)
- add registration guard and registration data
- fix unbounded lifetimes in ioctl handler args
- fix a drm_dev_register race
- gem_shmem: add DmaResvGuard helper
- gpuvm: require send/sync for driver data
  - implement send/sync for GpuVaAlloc and GpuVmBo
  - add SmContext lifetime
- rename dma_handle to dma_address
- change pci_sriov_get_totalvfs return to unsigned int

core:
- create drm_of_get_panel_orientation
- send per-connector hotplug events
- add thunderbolt UBHR tunneling support

connector:
- add color format property

dmem:
- introduce a peak file
- accept one region per limit
- add dmemcg support for eviction

gpusvm:
- reorg code to give drivers more flexibility

atomic:
- add create_state callback and helper
- add documentation on atomic commit lifetime

buddy:
- add per-order free
- add used block scoreboard
- fix UAF
- test buffer clearance on resume
- add phys_addr->block helper

gem:
- drop DRIVER_GEM_GPUVA flag

ttm:
- be more aggressive allocating below protection limit

sched:
- add test suite for concurrent job submissions

hdmi:
- hook the color format property in helpers

mipi-dsi:
- add MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT

bridge:
- add atomic create callbacks
- drop atomic reset
- display-connector: don't autoenable HPD IRQ
- trigger initial HPD for DP
- ti-sn65dsi83: remove NO_HFP and NO_HBP mode flags
- analogix_dp: switch to DP link training helpers

dp:
- add support for DSC max delta BPP

edid:
- parse panel type from DisplayID 2.x Display Parameters

sysfb:
- improve panel, stride, framebuffer size validation

panel:
- implement ref counting for struct drm_panel
- himax-hx83121a: add backlight regulator support
- novatek-nt36672a: Inline panel init sequences
- visionox-vtdr6130: enable DSC
- novatek-nt37801: Use mipi_dsi_*_multi() functions
- samsung-s6d16d0: Fix prepare error handling
- support Novatek NT36536 plus DT bindings
- sofef00: fix backlight updates
- osd101t2587: use mipi_dsi_*_multi interface
- panel-edp: adjust timing for AUO displays
- panel-lvds: support Opto Logic SCX1001511GGC49
- panel-simple: support Kyocera tcg070wvlq
- panel-edp: quirks
  - AUO B116XAT04.3, CMN N116BCP-EA2, CSW MNB601LS1-8
  - BOE NV116WH2-M30, BOE NT116WHM-N21, BOE NV116FH1-M31
  - BOE NV116FH1-M30, NV140FHM-N5B, TM156VDXP25
  - BOE NE160QDM-NY1, MB116AS01
- new:
  - Samsung ATNA40HQ08-0, Anbernic TD4310
  - Chipone ICNA35XX, Ilitek ILI9488
  - Ilitek ILI7807S, Renesas R63419
  - MNE001BS6-2, MNF601BS4-1, Sharp LQ120P1JX51

virtio:
- add support for save/restore virtio_gpu_objects
- abort vq wait on device removal

amdgpu:
- add color format DRM property
- initial compute pipe reset support
- add GFX 6-8 modifier support
- initial DCN 6.0.0 support
- dmemcg eviction support
- improved boundary checking for bios parsing
- RAS updates and rework
- VCN secure submission fixes
- 8K panel fix
- Display KUNIT tests
- parse panel type from DisplayID
- Align IP discovery to pci device lifetime
- SOC15 register macro cleanups
- UVD memory placement fixes
- GFX9 mode2 reset fixes
- drop unnecessary BUG/BUG_ON
- GFX8 soft reset rework
- enable soft reset on GFX8
- PSP/SMU 15.0.9 update
- VI ASPM fix
- userq fixes
- amdgpu_vm_get_task_info_pasid lifetime fix
- DC CACP support
- change system_unbound_wq with system_dfl_wq
- Loosen VFCT bios parsing to deal with pci=3Drealloc
- SI/SMU7 AC/DC switch fix
- VM fence handling fix
- GEM close optimisation
- Apple Studio Display fixes
- DC FRL fixes

amdkfd:
- initial compute pipe reset support
- allow applications to opt out of sigbus on fatal errors
- improve CRIU boundary checks
- MQD handling rework
- move TBA/TMA from system to device memory
- avoid topology-lock in kfd_mmap
- SVM eviction fixes

radeon:
- fix unset CONFIG_ACPI build

i915:
- Novalake (NVL display version 35) timing generator enabling
- NVL DC3CO enabling
- enable UBHR link rates on thunderbolt tunnels
- Reduce Xe3+ PM demand peak bandwidth
- enable pipe DMC error interrupts for display 30+
- add kunit tests for DP link config selection
- refactor and document DP link recovery
- i915/xe driver display probe/remove/suspend/resume/shutdown cleanup
and unification
- i915/xe display runtime PM unified
- Break i915 and xe panic dependency on struct intel_framebuffer
- Streamline Pre/Post-CSC LUT loops
- drop TGL DC3DO support
- CDCLK santization
- fix HDMI scrambling enable
- fix phys bo pread/pwrite with offset
- add missing nospec on parallel submit slot
- fix some NULL derefs

xe:
- drop force_execlist module param
- gate observation streams with perf_allow_cpu
- skip FORCE_WC and vm_bound check for external dma-bufs
- dmemcg eviction support
- remove unused NVL-S GuC
- TLB invalidation improvements
- NVL-S updated PCI-IDs and w/a
- madvise: optimise invalidation path
- fix infinite gt-reset loop in timeout recovery
- update TTM device benefical_order
- wait on external BO kernel fences in exec ioctl
- add/use more KLV helpers
- sriov: disable display in admin only PF mode
- add RAS GPU health indicator
- optimise TTM populate for DONTNEED BO
- drop force_probe for NVL-s
- add debugfs for pcode info

amdxdna:
- disable device buffer export

nova:
- build nova-core/nova-drm from drivers/gpu
- export nova-core rust symbols (workaround)
- GSP boot process consolidation
- Boot GSP with vGPU enabled
- TLV firmware image format support
- Hopper/Blackwell fixes and cleanups
- I/O projection adoption

tyr:
- firmware loading and MCU boot
- add generic slot manager + MMU
- GPU VM support ARM64 LPAE page tables
- add kernel buffer object for internal allocations
- add parser for Mali CSF
- add MCU booting

nouveau:
- race fixes
- check instmem iomapping at first use
- add dmemcg support
- expose NVDEC channels
- add scanline position/head state support for GSP

qxl:
- convert simple encoder to regular

ethosu:
- add perf counter support

etnaviv:
- force flush on power register ops

msm:
- support DSC configuration with slice_per_pkt > 1

mxsfb:
- fix disable sequence

panthor:
- support sparse mappings

rockchip:
- switch away from simple helpers
- support YUV background color
- fix layer config timeout
- add edp support for rk3576
- add batch command submission function

rocket:
- error handling and NULL ptr deref fixes

sun4i:
- switch away from simple helpers

imagination:
- mark BXM-4-64 MC1 as support

host1x:
- support tegra264

tegra:
- add DSI for tegra 20/30

v3d:
- reduce PM runtime autosuspend delay
- scheduler fixes and refactoring
- deprecate v3d 3.3 and 4.1
- validate CPU job query boundaries

hibmc:
- improve plane format handling
- switch to gem shmem

mediatek:
- cec: correct compat for mt7623-8167?

exynos:
- remove simple dependency
- add error handling to encoder paths
- take i2c adapter module reference
The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f=
:

  Linux 7.2 (2026-08-16 14:32:26 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-08-20

for you to fetch changes up to c44e278ce02efd0c4be79a8eda1ea6885c1ce5ec:

  BackMerge tag 'v7.2' into drm-next (2026-08-20 10:58:44 +1000)

----------------------------------------------------------------
drm for 7.3-rc1

perf:
- export perf_allow_ APIs for xe

udmabuf:
- remove default size limit of 64MB

rust:
- i/o rework (signed tag from driver-core tree)
- add registration guard and registration data
- fix unbounded lifetimes in ioctl handler args
- fix a drm_dev_register race
- gem_shmem: add DmaResvGuard helper
- gpuvm: require send/sync for driver data
  - implement send/sync for GpuVaAlloc and GpuVmBo
  - add SmContext lifetime
- rename dma_handle to dma_address
- change pci_sriov_get_totalvfs return to unsigned int

core:
- create drm_of_get_panel_orientation
- send per-connector hotplug events
- add thunderbolt UBHR tunneling support

connector:
- add color format property

dmem:
- introduce a peak file
- accept one region per limit
- add dmemcg support for eviction

gpusvm:
- reorg code to give drivers more flexibility

atomic:
- add create_state callback and helper
- add documentation on atomic commit lifetime

buddy:
- add per-order free
- add used block scoreboard
- fix UAF
- test buffer clearance on resume
- add phys_addr->block helper

gem:
- drop DRIVER_GEM_GPUVA flag

ttm:
- be more aggressive allocating below protection limit

sched:
- add test suite for concurrent job submissions

hdmi:
- hook the color format property in helpers

mipi-dsi:
- add MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT

bridge:
- add atomic create callbacks
- drop atomic reset
- display-connector: don't autoenable HPD IRQ
- trigger initial HPD for DP
- ti-sn65dsi83: remove NO_HFP and NO_HBP mode flags
- analogix_dp: switch to DP link training helpers

dp:
- add support for DSC max delta BPP

edid:
- parse panel type from DisplayID 2.x Display Parameters

sysfb:
- improve panel, stride, framebuffer size validation

panel:
- implement ref counting for struct drm_panel
- himax-hx83121a: add backlight regulator support
- novatek-nt36672a: Inline panel init sequences
- visionox-vtdr6130: enable DSC
- novatek-nt37801: Use mipi_dsi_*_multi() functions
- samsung-s6d16d0: Fix prepare error handling
- support Novatek NT36536 plus DT bindings
- sofef00: fix backlight updates
- osd101t2587: use mipi_dsi_*_multi interface
- panel-edp: adjust timing for AUO displays
- panel-lvds: support Opto Logic SCX1001511GGC49
- panel-simple: support Kyocera tcg070wvlq
- panel-edp: quirks
  - AUO B116XAT04.3, CMN N116BCP-EA2, CSW MNB601LS1-8
  - BOE NV116WH2-M30, BOE NT116WHM-N21, BOE NV116FH1-M31
  - BOE NV116FH1-M30, NV140FHM-N5B, TM156VDXP25
  - BOE NE160QDM-NY1, MB116AS01
- new:
  - Samsung ATNA40HQ08-0, Anbernic TD4310
  - Chipone ICNA35XX, Ilitek ILI9488
  - Ilitek ILI7807S, Renesas R63419
  - MNE001BS6-2, MNF601BS4-1, Sharp LQ120P1JX51

virtio:
- add support for save/restore virtio_gpu_objects
- abort vq wait on device removal

amdgpu:
- add color format DRM property
- initial compute pipe reset support
- add GFX 6-8 modifier support
- initial DCN 6.0.0 support
- dmemcg eviction support
- improved boundary checking for bios parsing
- RAS updates and rework
- VCN secure submission fixes
- 8K panel fix
- Display KUNIT tests
- parse panel type from DisplayID
- Align IP discovery to pci device lifetime
- SOC15 register macro cleanups
- UVD memory placement fixes
- GFX9 mode2 reset fixes
- drop unnecessary BUG/BUG_ON
- GFX8 soft reset rework
- enable soft reset on GFX8
- PSP/SMU 15.0.9 update
- VI ASPM fix
- userq fixes
- amdgpu_vm_get_task_info_pasid lifetime fix
- DC CACP support
- change system_unbound_wq with system_dfl_wq
- Loosen VFCT bios parsing to deal with pci=3Drealloc
- SI/SMU7 AC/DC switch fix
- VM fence handling fix
- GEM close optimisation
- Apple Studio Display fixes
- DC FRL fixes

amdkfd:
- initial compute pipe reset support
- allow applications to opt out of sigbus on fatal errors
- improve CRIU boundary checks
- MQD handling rework
- move TBA/TMA from system to device memory
- avoid topology-lock in kfd_mmap
- SVM eviction fixes

radeon:
- fix unset CONFIG_ACPI build

i915:
- Novalake (NVL display version 35) timing generator enabling
- NVL DC3CO enabling
- enable UBHR link rates on thunderbolt tunnels
- Reduce Xe3+ PM demand peak bandwidth
- enable pipe DMC error interrupts for display 30+
- add kunit tests for DP link config selection
- refactor and document DP link recovery
- i915/xe driver display probe/remove/suspend/resume/shutdown cleanup
and unification
- i915/xe display runtime PM unified
- Break i915 and xe panic dependency on struct intel_framebuffer
- Streamline Pre/Post-CSC LUT loops
- drop TGL DC3DO support
- CDCLK santization
- fix HDMI scrambling enable
- fix phys bo pread/pwrite with offset
- add missing nospec on parallel submit slot
- fix some NULL derefs

xe:
- drop force_execlist module param
- gate observation streams with perf_allow_cpu
- skip FORCE_WC and vm_bound check for external dma-bufs
- dmemcg eviction support
- remove unused NVL-S GuC
- TLB invalidation improvements
- NVL-S updated PCI-IDs and w/a
- madvise: optimise invalidation path
- fix infinite gt-reset loop in timeout recovery
- update TTM device benefical_order
- wait on external BO kernel fences in exec ioctl
- add/use more KLV helpers
- sriov: disable display in admin only PF mode
- add RAS GPU health indicator
- optimise TTM populate for DONTNEED BO
- drop force_probe for NVL-s
- add debugfs for pcode info

amdxdna:
- disable device buffer export

nova:
- build nova-core/nova-drm from drivers/gpu
- export nova-core rust symbols (workaround)
- GSP boot process consolidation
- Boot GSP with vGPU enabled
- TLV firmware image format support
- Hopper/Blackwell fixes and cleanups
- I/O projection adoption

tyr:
- firmware loading and MCU boot
- add generic slot manager + MMU
- GPU VM support ARM64 LPAE page tables
- add kernel buffer object for internal allocations
- add parser for Mali CSF
- add MCU booting

nouveau:
- race fixes
- check instmem iomapping at first use
- add dmemcg support
- expose NVDEC channels
- add scanline position/head state support for GSP

qxl:
- convert simple encoder to regular

ethosu:
- add perf counter support

etnaviv:
- force flush on power register ops

msm:
- support DSC configuration with slice_per_pkt > 1

mxsfb:
- fix disable sequence

panthor:
- support sparse mappings

rockchip:
- switch away from simple helpers
- support YUV background color
- fix layer config timeout
- add edp support for rk3576
- add batch command submission function

rocket:
- error handling and NULL ptr deref fixes

sun4i:
- switch away from simple helpers

imagination:
- mark BXM-4-64 MC1 as support

host1x:
- support tegra264

tegra:
- add DSI for tegra 20/30

v3d:
- reduce PM runtime autosuspend delay
- scheduler fixes and refactoring
- deprecate v3d 3.3 and 4.1
- validate CPU job query boundaries

hibmc:
- improve plane format handling
- switch to gem shmem

mediatek:
- cec: correct compat for mt7623-8167?

exynos:
- remove simple dependency
- add error handling to encoder paths
- take i2c adapter module reference

----------------------------------------------------------------
Aaron Kling (1):
      dt-bindings: display: panel: Add Chipone ICNA3512 OLED driver binding=
s

Adri=C3=A1n Larumbe (10):
      drm/panthor: Expose GPU page sizes to UM
      drm/panthor: Pass vm_bind_op to vm_prepare_map_op_ctx
      drm/panthor: Delete spurious whitespace from uAPI header
      drm/panthor: Remove unused operation context field
      drm/panthor: Support sparse mappings
      drm/panthor: Bump the driver version to 1.9
      drm/gpuvm: Remove dead code
      drm/gpuvm: Fix comment to reflect remap operation operand status
      drm/panthor: Add vm_bind region with kbo range overlap check
      drm/panthor: Fix comment to reflect actual struct field name

Akash Goel (1):
      drm/panthor: Fix NPD issue on partial unmap of an evicted BO

Akash Sukhavasi (1):
      drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi(); fix minor bugs

Alan Swanson (1):
      drm/amd/display: Silence link_dpms I2C retimer failures

Albert Esteve (4):
      drm/panel: have drm_panel_add/remove manage a list reference
      drm/bridge/panel: hold a reference to the wrapped panel
      drm/panel: of_drm_find_panel() return a counted reference
      drm/panel: find_panel_by_fwnode() return a counted reference

Alberto Ruiz (4):
      drm/solomon: add ssd130x_run_cmd_seq() for batch command execution
      drm/solomon: use ssd130x_run_cmd_seq() in ssd130x_init()
      drm/solomon: use ssd130x_run_cmd_seq() in ssd132x_init()
      drm/solomon: use ssd130x_run_cmd_seq() in ssd133x_init()

Alessandro Rinaldi (1):
      drm/amd/display: Force PWM backlight on Lenovo Legion 5 15ARH05

Alessio Belle (2):
      drm/imagination: Reuse layout check macros for MIPS FW structures
      drm/imagination: Fix repeated typo in KCCB documentation

Alex Deucher (104):
      drm/amdgpu: don't reemit if there is nothing to reemit
      drm/amdgpu: track guilty fence for queue reset
      drm/amdgpu/fence: add helper to extract the guilty fence
      drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit() handle NULL fen=
ce
      drm/amdgpu/vcn: handle pipe reset more gracefully
      drm/amdgpu/sdma: handle pipe reset more gracefully
      drm/amdgpu/mes12: use proper grbm_select function
      drm/amdgpu/gfx11: only need to remap KCQs when reset via MMIO
      drm/amdgpu/gfx12: only need to remap KCQs when reset via MMIO
      drm/amdgpu/mes11: move pipe reset to mes use_mmio patch
      drm/amdgpu/mes12: move pipe reset to mes use_mmio patch
      drm/amdgpu/mes: add userq reset helper
      drm/amdgpu/mes: add a MMIO queue reset helper
      drm/amdgpu/userq: split the queue reset from adapter reset
      drm/amdgpu/userq: add per queue reset callback
      drm/amdgpu/userq: add mes userq reset callback
      drm/amdgpu/userq: switch to per queue reset
      drm/amdgpu/userq: drop detect_and_reset callback
      drm/amdkfd: rework MES queue reset sequence
      drm/amdgpu/gfx: add a helper for MQD restore
      drm/amdgpu/gfx11: use the new MQD helper for queue reset
      drm/amdgpu/gfx12: use the new MQD helper for queue reset
      drm/amdgpu/gfx11: unmap the queue via MES on reset for MMIO path
      drm/amdgpu/gfx12: unmap the queue via MES on reset for MMIO path
      drm/amdgpu: store whether to use MMIO or MES for reset
      drm/amdgpu: Use a common KGQ and KCQ reset helper for gfx11/12
      drm/amdkfd: split out mes queue reset sequence into standalone functi=
on
      drm/amdkfd: plumb a helper to reset a KFD user queue
      drm/amdgpu/userq: add MES userq reset helper
      drm/amdgpu/gfx: add a common helper to handle MES compute resets
      drm/amdgpu: use a single entry point for mes compute reset
      drm/amdgpu/mes11: enable compute MMIO pipe reset
      drm/amdgpu/mes12: enable compute MMIO pipe reset
      drm/amdgpu: remove spurious line in amdgpu_ring_find_guilty_fence()
      drm/amdgpu/jpeg: add flags for disabling KQs/UQs
      drm/amdgpu/jpeg4.0.3: add support for disabling kernel queues
      drm/amdgpu/jpeg5.0.1: add support for disabling kernel queues
      drm/amdgpu/vcn: add flags for disabling KQs/UQs
      drm/amdgpu/vcn4.0.3: add support for disabling kernel queues
      drm/amdgpu/vcn5.0.1: add support for disabling kernel queues
      drm/amdgpu/sdma4.4.2: add support for disabling kernel queues
      drm/amdgpu/gfx9.4.3: add support for disabling kernel queues
      drm/amdgpu/gmc9: make all vmids available to KFD if KQs are disabled
      drm/amdgpu/gfx8: drop unecessary BUG_ON()
      drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx9.4.3: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12.1: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma4.4.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma7.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma7.1: replace BUG_ON() with WARN_ON()
      drm/amdkfd: drop duplicate kfd_queue_acquire_buffers()
      drm/gfx10: Program DB_RING_CONTROL
      drm/gfx11: Program DB_RING_CONTROL
      drm/gfx12: Program DB_RING_CONTROL
      drm/amdgpu/gfx11: enable gfx pipe1 hardware support
      drm/amdgpu: return an error instead of BUG() for CSA bo_va
      drm/amdgpu/gfx11: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/gfx12: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/gfx12.1: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/atomfirmware: WARN() rather than BUG()
      drm/amdgpu/cgs: WARN() rather than BUG()
      drm/amdgpu/ucode: WARN() rather than BUG()
      drm/amdgpu/cik_sdma: replace BUG() with an error
      drm/amdgpu/sdma2.4: replace BUG() with an error
      drm/amdgpu/sdma3.0: replace BUG() with an error
      drm/amdgpu/si: drop BUG()s
      drm/amdgpu/gmc6: replace BUG() with an error
      drm/amdgpu: update mmhub 4.2.0 client list
      drm/amdgpu/gfx12.1: Add ip dump support
      drm/amdgpu/gfx9: fix IP dump alloc ordering
      drm/amdgpu/gfx10: fix IP dump alloc ordering
      drm/amdgpu/gfx11: fix IP dump alloc ordering
      drm/amdgpu/gfx12: fix IP dump alloc ordering
      drm/amdgpu: always emit the job vm fence
      drm/amdgpu: properly account for resets with user queues
      drm/amdgpu/imu11: WARN() rather than BUG()
      drm/amd/display: check if dml21_add_phantom_plane() is successful
      drm/amdgpu/imu12: WARN() rather than BUG()
      drm/amdgpu/mes11: drop all BUG()s
      drm/amdgpu/mes12: drop all BUG()s
      drm/amdgpu/mes12.1: drop all BUG()s
      drm/amdgpu/psp11: replace BUG() with an error
      drm/amdgpu/psp13: replace BUG() with an error
      drm/amdgpu/psp13.0.4: replace BUG() with an error
      drm/amdgpu/psp14: replace BUG() with an error
      drm/amdgpu/gfx6: drop all BUG()s
      drm/amdgpu/gfx7: drop all BUG()s
      drm/amdgpu/gfx8: drop all BUG()s
      drm/amdgpu/gfx9: drop all BUG()s
      drm/amdgpu/gfx9.4.3: drop all BUG()s
      drm/amdgpu/gfx10: drop all BUG()s
      drm/amdgpu/gfx11: drop all BUG()s
      drm/amdgpu/gfx12: drop all BUG()s
      drm/amdgpu/gfx12.1: drop all BUG()s
      drm/amdgpu/gmc12.1: implement tlb inv semaphore
      drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush
      drm/amdgpu: fix missing check in vm_flush()
      drm/amdgpu: handle GDS and SPM without a VM fence

Alex Hung (121):
      drm/amd/display: Fix writeback format loop and variable init
      drm/amd/display: Add KUnit tests for writeback connector
      drm/amd/display: remove redundant code in amdgpu_dm_replay
      drm/amd/display: Enable warnings as errors for KUnit tests
      drm/amd/display: Remove dead code in dm_dp_mst_get_modes
      drm/amd/display: Add KUnit tests for amdgpu_dm_mst_types
      drm/amd/display: Fix incorrect logic in CRC source handling
      drm/amd/display: Extract DPRX CRC transition helpers for KUnit testin=
g
      drm/amd/display: Extract HDCP testable helpers for KUnit
      drm/amd/display: Remove duplicate pp_rn_set_wm_ranges
      drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu
      drm/amd/display: Extract backlight code to amdgpu_dm_backlight
      drm/amd/display: Extract audio code to amdgpu_dm_audio
      drm/amd/display: Extract DMUB code to amdgpu_dm_dmub
      drm/amd/display: Move HPD and IRQ handler code to amdgpu_dm_irq
      drm/amd/display: Extract connector and encoder code to amdgpu_dm_conn=
ector
      drm/amd/display: Add KUnit tests for amdgpu_dm
      drm/amd/display: Add KUnit tests for amdgpu_dm_backlight
      drm/amd/display: Add KUnit tests for amdgpu_dm_audio
      drm/amd/display: Add KUnit tests for amdgpu_dm_dmub
      drm/amd/display: Add KUnit tests for amdgpu_dm_connector
      drm/amd/display: Add KUnit tests for amdgpu_dm_irq
      drm/amd/display: Add KUnit tests for amdgpu_dm_crtc
      drm/amd/display: Add KUnit tests for amdgpu_dm_services
      drm/amd/display: Add KUnit tests for amdgpu_dm_helpers
      drm/amd/display: Add KUnit tests for amdgpu_dm_quirks
      drm/amd/display: Add more KUnit tests for amdgpu_dm_pp_smu
      drm/amd/display: Add more KUnit tests for amdgpu_dm_mst_types
      drm/amd/display: Move backlight macros to backlight header
      drm/amd/display: Remove redundant IPS mode case for DCN 4.2
      drm/amd/display: Extract backlight helpers for KUnit tests
      drm/amd/display: Add more KUnit tests for amdgpu_dm_colorop
      drm/amd/display: Simplify boolean checks
      drm/amd/display: Simplify DMUB notify registration
      drm/amd/display: Fix KUnit test crash after global alpha change
      drm/amd/display: Add KUnit test for amdgpu_dm_wb
      drm/amd/display: Add KUnit tests for amdgpu_dm_replay
      drm/amd/display: Add KUnit tests for amdgpu_dm_psr
      drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu
      drm/amd/display: Add KUnit tests for mst_types
      drm/amd/display: Extract shared KUnit test helpers
      drm/amd/amdgpu: Fix stack frame size warnings in KUnit tests
      drm/amd/display: Fix KUnit backlight tests for CACP
      drm/amd/display: Add KUnit tests for ism
      drm/amd/display: Test EDID and ACPI/VBIOS readers
      drm/amd/display: Test DPCD AUX and Synaptics helpers
      drm/amd/display: Test MST start/stop and panel settings
      drm/amd/display: Test I2C, stubs and MST early returns
      drm/amd/display: Test MCCS FreeSync VCP helpers
      drm/amd/display: Test MST payload and DSC enable helpers
      drm/amd/display: Test irq funcs/suspend/workqueue
      drm/amd/display: Test irq state setters and work
      drm/amd/display: Test HPD init/fini
      drm/amd/display: Test HPD interrupt handling
      drm/amd/display: Test dmub HPD callbacks and handlers
      drm/amd/display: Test high-IRQ and handler registration
      drm/amd/display: Test top-level IRQ handler and vmin/vmax worker
      drm/amd/display: Test format info and blending
      drm/amd/display: Test GFX9/GFX10 plane modifiers
      drm/amd/display: Test GFX11/GFX12 plane modifiers
      drm/amd/display: Test plane scaling info paths
      drm/amd/display: Test plane buffer attributes
      drm/amd/display: Test GFX9 DCC plane attributes
      drm/amd/display: Test GFX12 DCC plane attributes
      drm/amd/display: Test DCC and cursor edge cases
      drm/amd/display: Test helper_check_state rejects
      drm/amd/display: Test plane atomic check and hooks
      drm/amd/display: Add KUnit test for wb jobs
      drm/amd/display: Test MST coverage gaps
      drm/amd/display: Test backlight level programming path
      drm/amd/display: Test backlight level readback path
      drm/amd/display: Test backlight device registration
      drm/amd/display: Test panel power savings sysfs
      drm/amd/display: Test backlight ABM property attach
      drm/amd/display: add dm_dmub_hw_init KUnit coverage
      drm/amd/display: add dm_dmub_hw_resume KUnit coverage
      drm/amd/display: add fused IO KUnit coverage
      drm/amd/display: add DMUB command sync KUnit coverage
      drm/amd/display: add VBIOS bounding box KUnit test
      drm/amd/display: Test color mod init and 3D LUT size
      drm/amd/display: Test plane colorop helper walkers
      drm/amd/display: Test CRTC color management update
      drm/amd/display: Test plane color management update
      drm/amd/display: Test plane colorop pipeline update
      drm/amd/display: add KUnit tests for DM IP-block callbacks
      drm/amd/display: add KUnit tests for DM CRTC vblank/scanout
      drm/amd/display: add KUnit tests for DM atomic state helpers
      drm/amd/display: add KUnit tests for DM stream scaling
      drm/amd/display: add KUnit tests for HDCP state diffing
      drm/amd/display: add KUnit tests for freesync config
      drm/amd/display: add KUnit tests for per-frame master sync
      drm/amd/display: add KUnit tests for stutter quirk
      drm/amd/display: add KUnit tests for DPCD poweroff delay
      drm/amd/display: add CRC source list KUnit coverage
      drm/amd/display: add CRC source verify KUnit coverage
      drm/amd/display: add CRC configure KUnit coverage
      drm/amd/display: add CRC set-source KUnit coverage
      drm/amd/display: add CRC IRQ handler KUnit coverage
      drm/amd/display: Fix missing dc_3dlut forward declaration
      drm/amd/display: Flush IRQ workqueue in schedule-work tests
      drm/amdgpu: Fix __rcu fence pointer accesses
      drm/amdgpu: Pack nested ucode_info struct
      drm/amd/display: Fix writeback completion timing
      drm/amd/display: share common DM KUnit helpers
      drm/amd/display: move scaling helper to connector
      drm/amd/display: move stutter quirk to quirks file
      drm/amd/display: move watermarks table to pp_smu
      drm/amd/display: move GPU mem helpers to services
      drm/amd/display: add FreeSync/VRR module
      drm/amd/display: add cursor module
      drm/amd/display: add KUnit tests for audio component get_eld
      drm/amd/display: add KUnit tests for audio commit path
      drm/amd/display: Add KUnit test for native backlight registration
      drm/amd/display: Add color transfer-function tests
      drm/amd/display: Add atomic transfer-function tests
      drm/amd/display: Add CRTC and plane degamma tests
      drm/amd/display: Add legacy plane LUT tests
      drm/amd/display: Add truncated colorop tests
      drm/amd/display: Add colorop LUT programming tests
      drm/amd/display: Fix wb_info leak and NULL deref in writeback
      drm/amd/display: Fix more KUnit connector use-after-free bugs

Alexander Chechik (2):
      drm/amd/display: enforce UCLK pstate support in mode_support
      drm/amd/display: plumb PMO per-plane pstate methods into mode_support

Alexander Kaplan (2):
      drm/i915/dp: Prefer DSC over 6 bpc uncompressed output for HDMI sinks
      drm/i915/dp: Ignore the sink's DSC max FRL rate without a PCON DSC en=
coder

Alexander Koskovich (1):
      drm/mipi-dsi: add flag for sending all DSC slices in one packet

Alexander Usyskin (1):
      drm/xe/nvm: fix writable override for CRI

Alexandre Courbot (26):
      gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB fails
      gpu: nova-core: move GSP unload state to a pinned Gpu subobject
      gpu: nova-core: move GPU static information acquisition to a GSP meth=
od
      gpu: build nova-core and nova-drm from drivers/gpu/Makefile
      gpu: nova-core: export Rust symbols for nova-drm
      gpu: nova-core: emit Rust metadata for nova-drm
      gpu: drm: nova: depend on nova-core and use its symbols
      gpu: nova-core: convert to kernel bitfield macro
      gpu: nova-core: remove local bitfield macro
      gpu: nova: fix rust-analyzer generation
      gpu: nova-core: gsp: sequencer: use GspBootContext
      gpu: nova-core: gsp: sequencer: do not store sequence into GspSequenc=
er
      gpu: nova-core: gsp: replace BootUnloadGuard with local handlers
      gpu: nova-core: gsp: pass GspBootContext to unload methods
      gpu: nova-core: gsp: centralize missing unload bundle warnings
      gpu: nova-core: gsp: fold TU102 unload bundle construction into HAL m=
ethod
      gpu: nova-core: gsp: turn FWSEC execution into HAL method
      gpu: nova-core: gsp: make use of FWSEC bootloader a property of
the TU102 HAL
      gpu: nova-core: avoid repeated calls to pci::Device::as_ref
      gpu: nova-core: gsp: pass GspBootContext mutably
      gpu: nova-core: gsp: separate context and GPU lifetimes in GspBootCon=
text
      gpu: nova-core: store Fsp instance in Gpu
      gpu: nova-core: fix packed registry table size
      gpu: nova-core: falcon: remove unnecessary check
      rust: dma: rename dma_handle to dma_address
      gpu: nova-core: falcon: use I/O projection to check transfer bounds

Alexandre Hamamdjian (2):
      dt-bindings: display: Add AYANEO Pocket DS lower panel
      drm/panel: st7703: Add AYANEO Pocket DS Lower Panel Support

Alexandru Dadu (3):
      drm/imagination: Reorder some fields in struct pvr_device_features
      drm/imagination: Move all FW interface check macros to pvr_checks.h
      drm/imagination: Update Rogue heap comments

Alvin Lee (2):
      drm/amd/display: Update LSDMA commands to explicitly handle DCC field=
s
      drm/amd/display: Update BW bounding box unconditionally for DCN6

Amber Lin (18):
      drm/amdgpu: Allocate enough space for hpd info on gfx11
      drm/amdgpu: Remove faulty queue before resume
      drm/amdgpu: Expand MES queue/pipe reset support
      drm/amdkfd: Pass known bad queue info to reset
      drm/amdkfd: Clean up suspend_all and resume_all mes
      drm/amdkfd: Fix reset event signal
      drm/amdkfd: Add gfx11 queue/pipe reset support to topology
      Revert "drm/amdkfd: Add gfx11 queue/pipe reset support to topology"
      drm/amdkfd: Add queue reset support on gfx11 dGPU
      drm/amdgpu: Add gfx12.0.1 adev to queue reset support
      drm/amdkfd: Add queue reset support to gfx12.0
      drm/amdkfd: Limit queue reset support on gfx9
      drm/amdkfd: Disable queue reset on gfx11 SR-IOV VF
      drm/amdgpu: Fix mes remove_hw_queue lock
      Revert "drm/amdkfd: Add queue reset support to gfx12.0"
      drm/amdkfd: Add gfx12.0 queue reset support to topology
      drm/amdgpu: Fix false error return to non-KCQ
      drm/amdkfd: Fix signal reset event

Amit Barzilai (5):
      drm/ssd130x: fix column and row end address in partial updates for ss=
d132x
      drm/ssd130x: hoist column and row addresses out of repeated division
      drm/ssd130x: fix column and row end address in partial updates in ssd=
133x
      drm/ssd130x: Scale ssd133x per-channel contrast by brightness on init
      drm/ssd130x: Add per-family update backlight logic

Anas Khan (2):
      drm/xe: remove duplicate <kunit/test-bug.h> include
      drm/amd/display: remove duplicate link_dp_panel_replay.h include

Andi Shyti (1):
      drm/i915/gt: Return bool values from a boolean helper

Andre Eikmeyer (1):
      drm/amdgpu: reset VI ASIC on MacBookPro15,1

Andre Luiz Batista Bueno (1):
      drm/amdgpu: deduplicate JPEG v5.0 interrupt routine

Andreas Kemnade (1):
      drm/omap: dsi: Do not copy isr table

Andrew Lichmanov (1):
      drm/amd/display: Disable mem gating for DCHVM on DCHVM init

Andrew Martin (1):
      drm/amdkfd: Fix SMI event PID reporting for containers

Andriy Korud (1):
      drm/amd/display: dce100: skip non-DP stream encoders for DP MST

Andrzej Kacprowski (1):
      accel/ivpu: Remove unnecessary min_t()/max_t() usage

Animesh Manna (21):
      drm/i915/cmtg: Add intel_cmtg_is_allowed() for CMTG
      drm/i915/cmtg: Set CMTG clock select
      drm/i915/cmtg: Add CMTG transcoder offset in struct _device_info
      drm/i915/display: Pass target transcoder to intel_set_transcoder_timi=
ngs()
      drm/i915/display: Rename cpu_transcoder parameter to transcoder
      drm/i915/display: Skip DP_MIN_HBLANK_CTL programming for CMTG transco=
ders
      drm/i915/display: Pass transcoder to intel_set_transcoder_timings_lrr=
()
      drm/i915/display: Rename cpu_transcoder parameter to transcoder
in LRR path
      drm/i915/cmtg: Set timings for CMTG by using transcoder timing helper=
s
      drm/i915/vrr: Pass transcoder to intel_vrr_set_fixed_rr_timings()
      drm/i915/display: Rename cpu_transcoder parameter to transcoder
in VRR fixed-rr path
      drm/i915/cmtg: Program VRR fixed-rate timings for CMTG transcoder
      drm/i915/cmtg: Program VRR control register for CMTG transcoder
      drm/i915/cmtg: Set link M/N for CMTG transcoder
      drm/i915/cmtg: Add hook to enable CMTG with sync to port
      drm/i915/cmtg: Add a hook to make eDP transcoder secondary
      drm/i915/cmtg: Add trigger to enable/disable cmtg
      drm/i915/cmtg: Restore CMTG after DC6 exit
      drm/i915/cmtg: Add CMTG interrupt handling
      drm/i915/display: Guard CMTG disable with intel_cmtg_is_allowed()
      drm/i915/cmtg: Warn on invalid CMTG transcoder in intel_cmtg_disable(=
)

Ankit Nautiyal (7):
      drm/i915/display: Handle VSYNC timing in LRR path
      drm/i915/panel: Preserve Vtotal-Vsync distance while adjusting vtotal
      drm/i915/alpm: Move the check for PSR and Fixed RR in compute_config_=
late
      drm/i915/dsb: shift delayed-vblank DSL wait start by one scanline
      drm/i915/dsb: Use safe window path when VRR TG is used
      Revert "drm/i915/psr: Allow SCL=3D0 on platforms with always-on VRR T=
G"
      drm/i915/display: Ensure a non-zero safe window from PTL onwards

Antonin Malzieu Ridolfi (5):
      gpu: nova-core: gsp: Move gsp register definition into gsp module
      gpu: nova-core: fb: Move PDISP register definition
      gpu: nova-core: Add function to query WPR2 range
      gpu: nova-core: Move PFB registers definitions
      gpu: nova-core: Move one PBUS register definition

Antonio Quartulli (1):
      drm/amd/display: fix compressed buffer config routine waiting time

Arnd Bergmann (1):
      drm/amd/display: avoid large stack allocation in
commit_planes_do_stream_update_sequence

Arpit Saini (2):
      dt-bindings: display: panel: add Ilitek ILI7807S panel controller
      drm/panel: add Ilitek ILI7807S panel driver

Arunpravin Paneer Selvam (2):
      drm/tests/gpu_buddy: add a new test case for buffer clearance
during resume
      drm/tests/gpu_buddy: fix interleaving in buffer clearance test

Arvind Yadav (3):
      drm/xe/madvise: Skip invalidation for purgeable state updates
      drm/xe/guc: Keep scheduler timeline name alive
      drm/xe/guc: Hold device ref until queue teardown completes

Asad Kamal (18):
      drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
      drm/amd/pm: Validate OD DPM triples before mutating tables
      drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
      drm/amdgpu: validate XCP topology counts before division
      drm/amdgpu: guard zero divisors in soc_v1_0 partition code
      drm/amdgpu: fix aperture mapping leak
      drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop and OOB rea=
d
      drm/amdgpu/pm: add pp_entries_max() helper
      drm/amdgpu/pm/powerplay: clamp Tonga/Polaris PP sub-table ucNumEntrie=
s
      drm/amdgpu/pm/powerplay: clamp Vega10 PP sub-table ucNumEntries
      drm/amdgpu/pm/powerplay: bounds-check voltage index in SMU7 lookup
      drm/amdgpu/pm/powerplay: bounds-check voltage index in Vega10 lookup
      drm/amd/pm: add jpeg/vcn busy to smu_v15_0_8 gpu metrics
      drm/amd/pm: update smu_v13_0_6 acc gpu metrics
      drm/amd/pm: Update smu_v15_0_8 gpu metrics
      drm/amd/pm: Fix pp_entries_max() bios check
      Revert "drm/amdgpu: fix aperture mapping leak"
      drm/amdgpu: fix aperture iounmap skipped on device removal

Ashutosh Dixit (11):
      drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
      drm/xe/rtp: Maintain OA whitelists separately
      drm/xe/rtp: Keep track of non-OA nonpriv slots
      drm/xe/rtp: Generalize whitelist_apply_to_hwe
      drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
      drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
      drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
      drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
      drm/xe/rtp: Ensure locking/ref counting for OA whitelists
      drm/xe/oa: Fix offset alignment for MERT WHITELIST_OA_MERT_MMIO_TRG
      drm/xe/mcr: Take vcs1/vecs1 into account for first media slice

Aurabindo Pillai (5):
      drm/amd/display: Adjust the structure dml2_dchub_watermark_regs
      drm/amd/display: Adjust structure dml2_display_dlg_regs
      drm/amd: Add DCN6 register headers
      drm/amd/display: Add new sources for DCN6
      drm/amd/display: Enable DCN6 sources compilation

Austin Zheng (6):
      drm/amd/display: Deprecate DMUB register offload functionality
      drm/amd/display: Allow Per-DPM De-rates Instead Of A Single Global Va=
lue
      drm/amd/display: Add Debug Option To Enable Per-DPM De-rate Usage
      drm/amd/display: Revert "Add Debug Option To Enable Per-DPM De-rate U=
sage"
      drm/amd/display: Add Debug Option To Enable Per-DPM De-rate Usage
      drm/amd/display: Add Writeback Watermarks and Latency Fields

Ben Dooks (1):
      drm/panfrost: include panfrost_drv.h for panfrost_transparent_hugepag=
e

Bhawanpreet Lakha (46):
      drm/amd/display: Add kunit tests for amdgpu_dm_plane
      drm/amd/display: Add more tests for HDCP
      drm/amd/display: More Kunit tests for audio
      drm/amd/display: Add color space and timing tests for connector
      drm/amd/display: Add subconnector property tests for connector
      drm/amd/display: Add FBC init tests for connector
      drm/amd/display: Add MST link detection tests for connector
      drm/amd/display: Add crtc matching and panel type tests for connector
      drm/amd/display: Add CACP caps tests for connector
      drm/amd/display: Add stream property tests for connector
      drm/amd/display: Replace amdgpu_dm_kunit_helpers.h with dm_helpers.h
      drm/amd/display: Add stream creation tests for connector
      drm/amd/display: Add detect and poll tests for connector
      drm/amd/display: Add register and unregister tests for connector
      drm/amd/display: Add destroy tests for connector
      drm/amd/display: Add encoder helper tests for connector
      drm/amd/display: Add EDID management tests for connector
      drm/amd/display: Add mode helper tests for connector
      drm/amd/display: Add i2c and EDID parsing tests for connector
      drm/amd/display: Add mode validation and CEC tests for connector
      drm/amd/display: Add stream validation tests for connector
      drm/amd/display: Add KUnit tests for link_lock and psp SRM helpers
      drm/amd/display: Add KUnit tests for HDCP display helpers
      drm/amd/display: Add KUnit tests for event_callback
      drm/amd/display: Add KUnit tests for event_property_validate
      drm/amd/display: Add KUnit tests for watchdog and cpirq events
      drm/amd/display: Add KUnit tests for hdcp_destroy
      drm/amd/display: Add KUnit tests for enable_assr
      drm/amd/display: Add KUnit tests for update_config
      drm/amd/display: Add KUnit tests for hdcp_create_workqueue
      drm/amd/display: Add KUnit tests for srm_data_write and srm_data_read
      drm/amd/display: Add KUnit tests for HDCP DDC link adapters
      drm/amd/display: Add initialized-branch test for psp_set_srm
      drm/amd/display: Add deeper event_property_update tests
      drm/amd/display: Add KUnit tests for more crtc functions
      drm/amd/display: Add vblank handling tests for crtc
      drm/amd/display: Add idle worker tests for crtc
      drm/amd/display: Add active plane count tests for crtc
      drm/amd/display: Add KUnit test for crtc vblank event completion
      drm/amd/display: Add KUnit tests for crtc set_vupdate_irq
      drm/amd/display: Add KUnit tests for crtc set_static_screen_optimze
      drm/amd/display: Add KUnit tests for crtc set_vblank
      drm/amd/display: Cover crtc set_vblank workqueue branch
      drm/amd/display: Cover crtc vblank IPS self-refresh restore
      drm/amd/display: Cover crtc vblank restore replay-supported path
      drm/amd/display: Cover crtc destroy_state stream release

Bhuvanachandra Pinninti (3):
      drm/amd/display: Cleaned up headers
      drm/amd/display: Add block sequence support for bandwidth
programming operations
      drm/amd/display: Fix dc_stream_remove_writeback dropping wrong
writeback entries.

Biju Das (3):
      dt-bindings: display: bridge: renesas,dsi: Document RZ/G3L
      dt-bindings: display: renesas,rzg2l-du: Document RZ/G3L SoC
      dt-bindings: display: bridge: Document Renesas RZ/G3L LVDS encoder

Bob Zhou (1):
      drm/amdgpu: skip clearing empty freed VM list on GEM close

Boris Brezillon (4):
      rust: drm: gpuvm: add SmContext lifetime bound
      drm/tyr: add a generic slot manager
      drm/tyr: add Memory Management Unit (MMU) support
      drm/tyr: add GPU virtual memory (VM) support

Boyuan Zhang (5):
      drm/amdgpu: fix division by zero with invalid uvd dimensions
      drm/amdgpu/vcn4: avoid rereading IB param length
      drm/amdgpu/vce: fix integer overflow in image size
      drm/amdgpu/jpeg: fix jpeg_v5_0_1_is_idle detection
      drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection

Brajesh Gupta (1):
      drm/imagination: Set scheduler timeout period higher than Firmware ti=
meout

Brian Nguyen (1):
      drm/xe: Add compact-PT and addr mask handling for page reclaim

Can Peng (1):
      drm/tve200: add OF module alias for autoloading

Candice Li (6):
      drm/amd/ras: sleep on PMFW EEPROM busy in bad page count query
      drm/amd/pm: sleep on PMFW EEPROM busy in bad page count query
      drm/amdgpu: restore UMD profile pstate after runtime resume
      drm/amdgpu: fix userq VA validation for sub-page buffers
      drm/amdgpu: reject oversized IBs with per-ring packet limits
      drm/amdgpu: validate GEM_CREATE domain combinations

Ce Sun (59):
      drm/amdgpu/ras: Parse all deferred errors with UMC aca handle
      drm/amdgpu/ras: added RAS EEPROM device support check
      drm/amdgpu/ras: Add flag to make VBIOS read optional
      drm/amdgpu/ras: Add address sanity check for uniras
      drm/amdgpu/ras: Estimate RAS reservation when report capacity
      drm/amdgpu: fix resource leak on ACP reset timeout
      drm/amdgpu: invoke pm_genpd_remove() before freeing genpd
      drm/amd/ras: add set_debug_mode function for uniras
      drm/amdgpu: Retire legacy page retirement RAS code
      drm/amdgpu: Drop legacy ACA log RAS error data code
      drm/amdgpu: retire ACA support for jpeg v4.0.3
      drm/amdgpu: retire ACA support for vcn v5.0.1
      drm/amdgpu: retire ACA support for jpeg v5.0.1
      drm/amdgpu: retire ACA support for vcn v4.0.3
      drm/amdgpu: retire xgmi v6.4.0 ACA support
      drm/amdgpu: retire gfx v9.4.3 ACA support
      drm/amdgpu: retire sdma v4.4.2 ACA support
      drm/amdgpu: re-set ClearMcaOnRead CE/UE in late init for uniras
      drm/amdgpu: retire umc v12.0 ACA support
      drm/amdgpu: retire funcs for generating legacy cper record
      drm/amdgpu: retire pcs xgmi v6.4.0 legacy ras support
      drm/amd/pm: retire aca smu backend support for smu
      drm/amdgpu: retire mmhub v1.8 ACA support
      drm/amdgpu: retire legacy RAS reset/query operations for sdma v4_4_2
      drm/amd/pm: retire smu_13_0_6 mca dump support
      drm/amdgpu: retire legacy ACA support
      drm/amdgpu: retire MCA support
      drm/amdgpu: retire RAS error count query/reset for gfx_v9_4_3
      drm/amdgpu: retire legacy RAS reset/query operations for XGMI v6_4
      drm/amdgpu: retire legacy RAS reset/query operations for mmhub v1_8
      drm/amdgpu: add the macro definition of UMC_V12_0_PER_CHANNEL_OFFSET
      drm/amdgpu: retire legacy RAS reset/query operations for umc v12.0
      drm/amdgpu: remove interface for updating umc v12_0 ecc
      drm/amdgpu: Remove the legacy bad page retirement
      drm/amdgpu: remove legacy UMC v12_0 error address
      drm/amdgpu: remove operations related to legacy address
      drm/amdgpu: retire legacy PMFW eeprom RAS bad page handling
      drm/amdgpu: retire legacy PMFW bad page loading in page
      drm/amdgpu: retire legacy PMFW RAS eeprom write skip
      drm/amdgpu: retire legacy ras_eeprom_read_idx interface
      drm/amdgpu: retire legacy MCA IPID parse global interface
      drm/amd/pm: retire legacy pmfw eeprom feature check
      drm/amdgpu: retire legacy pmfw eeprom check
      drm/amdgpu: retire legacy pmfw eeprom init
      drm/amdgpu: retire legacy pmfw eeprom reset
      drm/amdgpu: retire legacy pmfw eeprom interface wrapper
      drm/amdgpu: retire legacy pmfw eeprom support check
      drm/amd/pm: retire legacy smu ras driver framework
      drm/amd/pm: retire legacy ras_smu_drv interface for smu v13.0.12
      drm/amdgpu: retire legacy mca umc status check interface
      drm/amdgpu: retire legacy get_retire_flip_bits for UMC
      drm/amdgpu: retire legacy get_retire_flip_bits interface for UMC
      drm/amdgpu: retire legacy deferred error separate logging
      drm/amdgpu: use IP version check in sysfs creation conditional logic
      drm/amdgpu: drop debug_enable_ras_aca debug mask flag
      drm/amdgpu/ras: Add debug mask to disable CE logs for uniras
      drm/amd/ras: add device lost check to early exit psp cmd wait loop
      drm/amdgpu: normalize error return of RAS command wrapper functions
      drm/amdgpu: avoid resource leak on SR-IOV VF with
AMDGIM_FEATURE_RAS_CPER enabled

Chaitanya Kumar Borah (6):
      drm/i915/display: Don=E2=80=99t use atomic state back-pointer to deri=
ve
color pipeline
      drm/i915: Avoid programming color HW blocks for NV12 Y planes
      drm/i915: Fix color blob reference handling in intel_plane_state
      drm/i915/display: expose blend mode on alpha-capable planes
      drm/i915/dp: s/intel_dp_needs_vsc_sdp/intel_dp_needs_vsc_colorimetry
      drm/i915/dp: set VSC_SDP MSA delegation only for capable sinks

Chandana G B (1):
      drm/amd/display: Fix intermittently CRC open failure during
active rendering

Charlene Liu (10):
      drm/amd/display: fix max dispclk_khz/dppclk_khz double 1000
      drm/amd/display: remove dead code related to forcevrr
      drm/amd/display: add null pointer access check
      drm/amd/display: ensure dtbclk clk_src selected before hdmistream_clk=
_en
      drm/amd/display: limit reuse dsc capable bootup timing
      drm/amd/display: enable hdmistreamclk_rcg by default for dcn42
      drm/amd/display: add DST_Y_DELTA_DRQ_LIMIT reg macro for later use
      drm/amd/display: add DST_Y_DELTA_DRQ_LIMIT hw programming
      drm/amd/display: change dcc_rate from 1 to 2 for log use only
      drm/amd/display: Ensure dtbclk is enabled

Chen-Yu Tsai (1):
      drm/sun4i: framebuffer: Set mode_config.normalize_zpos

Chenyu Chen (10):
      Revert "drm/amd/display: Use handle_hpd_irq_helper for HPD RX"
      drm/edid: extract base section header processing into helper
      drm/edid: parse panel type from DisplayID 2.x Display Parameters
      drm/amd/display: use DisplayID panel type in dm_set_panel_type
      drm/edid: extract base section header processing into helper
      drm/edid: parse panel type from DisplayID 2.x Display Parameters
      drm/amd/display: use DisplayID panel type in dm_set_panel_type
      drm/amd/display: Enable CACP on Linux
      drm/amd/display: Fix dead-code panel type detection from DID
      drm/amd/display: Add KUnit tests for CACP on Linux

Chintan Patel (1):
      drm/panel: novatek-nt36672a: Inline panel init sequences

Chris Morgan (2):
      dt-bindings: display: panel: Add Anbernic TD4310 panel
      drm/panel: anbernic-td4310: Add RG Vita Pro panel

Christian K=C3=B6nig (8):
      drm/todo: clarify drm_syncobj error TODOs
      dma-buf: rename dma_fence_enable_sw_signaling
      drm/amdgpu: move suballoc defines into own header
      drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx
      drm/amdgpu: give different sizes for each SA pool type
      drm/amdgpu: add gfp_flags to amdgpu_sa_manager v2
      drm/amdgpu: move job parameter to the end in amdgpu_job_alloc()
and *_with_ib()
      drm/amdgpu: use correct gfp_t for job allocation

ChunTao Tso (1):
      drm/amd/display: TEST_HARNESS FSN could be 0

Clara Wong (1):
      drm/amd/display: Reduce DML reinitialization when params don't change

Clay King (1):
      drm/amd/display: adjust floating point format for gamut remap when ne=
eded

Colin Ian King (4):
      drm/sched: Fix spelling mistake "sumission" -> "submission"
      drm/i915/display: make read-only array rates static const
      drm/i915/bw: Fix spelling mistake "threshod" -> "threshold"
      drm/bridge: lontium-lt8912b: make read-only const array
supply_names static

Cristian Ciocaltea (12):
      drm/rockchip: vop2: Rename CSC_BT2020 to CSC_BT2020L
      drm/rockchip: vop2: Add YUV support to background color
      drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
      drm/rockchip: dw_dp: Add missing newline in dev_err_probe() message
      drm/rockchip: dw_dp: Release core resources
      drm/rockchip: vop2: Fix wrong wait target in layer cfg done check
      drm/rockchip: vop2: Wait for layer cfg done before switching
LAYERSEL_REGDONE_SEL
      drm/rockchip: vop2: Delay old_{layer|port}_sel updates in
setup_layer_mixer()
      drm/rockchip: vop2: Drop redundant zero-init in setup_layer_mixer()
      drm/rockchip: vop2: Use vop2->old_layer_sel directly in
wait_for_layer_cfg_done()
      drm/fb-helper: Remove unused local variable in hotplug_event()
      MAINTAINERS: Track dw-hdmi-qp under Rockchip DRM drivers

C=C3=A9dric Bellegarde (1):
      drm/panel: sofef00: Fix DSI transfer errors on backlight update

Damon Ding (12):
      dt-bindings: display: rockchip: analogix-dp: Fix hclk as third
clock for RK3588
      dt-bindings: display: rockchip: analogix-dp: Add per-clock descriptio=
ns
      drm/rockchip: analogix_dp: Enable hclk for RK3588
      drm/rockchip: analogix_dp: Fix OF node reference leak via auto cleanu=
p
      dt-bindings: display: rockchip: analogix-dp: Add support for RK3576
      drm/bridge: analogix_dp: Rename and simplify is_rockchip()
      drm/bridge: analogix_dp: Add support for RK3576
      drm/rockchip: analogix_dp: Add support for RK3576
      drm/bridge: analogix_dp: Convert status check functions to bool
      drm/bridge: of-display-mode-bridge: Fix missing static const for
the bridge funcs
      drm/panel-edp: Add BOE NE160QDM-NY1 panel
      drm/bridge: analogix_dp: Apply standard DP training delay helpers

Dan Carpenter (1):
      drm/amd/pm: silence uninitialized variable warnings

Daniel Almeida (1):
      drm/tyr: add parser for firmware binary

Daniele Ceraolo Spurio (5):
      Revert "drm/xe/nvls: Define GuC firmware for NVL-S"
      drm/xe/pxp: PXP no longer requires HuC from media 35 onwards
      drm/xe: Add support for WA 22022079272
      drm/xe: Add support for WA 16029897822
      drm/xe/wopcm: fix WOPCM size for LNL+

Danilo Krummrich (23):
      Merge tag 'v7.2-rc1' into drm-rust-next
      rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments
      rust: drm: rename Uninit DeviceContext to Normal
      rust: faux: add Device type with AsBusDevice support
      rust: drm: Add Driver::ParentDevice associated type
      rust: drm: change default DeviceContext to Normal
      rust: drm: restrict AlwaysRefCounted to Normal Device context
      rust: drm: restrict AlwaysRefCounted to Normal GEM Object context
      rust: drm/gem: remove DeviceContext from shmem::Object
      rust: drm: split Deref for Device context typestates
      rust: drm: pin ioctl Device reference to Normal context
      rust: drm: add Ioctl device context typestate
      rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical sect=
ions
      rust: drm: Wrap ioctl dispatch in RegistrationGuard
      rust: drm: return ParentDevice from Device AsRef
      rust: drm: add AsRef<ParentDevice<Bound>> for Device<Registered>
      drm: fix race between partial drm_dev_register() failure and ioctl
      rust: drm: Add RegistrationData to drm::Driver
      rust: drm: Pass registration data to ioctl handlers
      drm: nova: Use drm::Device<Registered> to access the parent bus devic=
e
      Merge patch series "rust: drm: Higher-Ranked Lifetime private data"
      Merge tag 'rust-io-7.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core
into drm-rust-next
      Merge remote-tracking branch 'drm/drm-next' into drm-rust-next

Dave Airlie (28):
      nouveau/gem: reserve the bo in the info ioctl around the vma lookup
      nouveau/vmm: fix another SPT/LPT race
      Merge tag 'drm-misc-next-2026-06-19' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-misc-next-2026-07-02' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-intel-next-2026-07-02' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-xe-next-2026-07-03' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'amd-drm-next-7.3-2026-07-02' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2026-07-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-next-7.3-2026-07-09' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      nouveau/instmem: use iomapping interface for instmem handling
      Merge tag 'amd-drm-next-7.3-2026-07-15' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2026-07-16' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-intel-gt-next-2026-07-16' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-misc-next-2026-07-24' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      drm/nouveau: allow allocating NVDEC channels via abi16
      Merge tag 'amd-drm-next-7.3-2026-07-29' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-2026-07-28' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-xe-next-2026-07-30' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'mediatek-drm-next-20260731' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-next
      Merge tag 'amd-drm-next-7.3-2026-07-31' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'exynos-drm-next-for-v7.3' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-next
      Merge tag 'amd-drm-next-7.3-2026-08-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2026-08-06' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-rust-next-2026-08-08' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
      Merge tag 'amd-drm-next-7.3-2026-08-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2026-08-13' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-xe-next-fixes-2026-08-13' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      BackMerge tag 'v7.2' into drm-next

David Carlier (1):
      drm/panel: novatek-nt36536: Fix panel double-remove on attach failure

David Francis (7):
      drm/amdkfd: Properly acquire queue buffers in CRIU restore
      drm/amdkfd: Use kvcalloc to allocate arrays
      drm/amdkfd: Check bounds on CRIU restore queue type and mqd size
      drm/amdkfd: Don't acquire buffers during CRIU queue restore.
      drm/amdkfd: Check bounds in allocate_event_notification_slot
      drm/amdkfd: Check bounds on CRIU restore event id
      drm/amdkfd: Handle invalid event type in CRIU event restore

David Rosca (6):
      drm/amdgpu: Reject UVD message with dimensions above 4096
      drm/amdgpu: Fix UVD dpb min size calculation for H264
      drm/amdgpu: Fix UVD decode image min size calculation
      drm/amdgpu: Fix UVD min buffer sizes
      drm/amdgpu: Implement insert_end for VCE 3
      drm/amdgpu: Reject UVD message with invalid number of h265 refs

David Weber (1):
      drm/amd/display: allow self-refresh exit while entry is blocked

Deborah Brouwer (5):
      rust: drm: gpuvm: update DriverGpuVm for DeviceContext
      rust: iommu: add device lifetime to IoPageTable
      drm/tyr: add resources to RegistrationData
      drm/tyr: add a kernel buffer object
      drm/tyr: add Microcontroller Unit (MCU) booting

Derek Foreman (1):
      drm: writeback: Document behaviour for framebuffer size mismatch

Dibin Moolakadan Subrahmanian (22):
      drm/i915/cmtg: Modify existing hook to disable CMTG
      drm/i915/cmtg: Add CMTG HWGB programming
      drm/i915/cmtg: Add CMTG scan line programming
      drm/i915/display: Remove TGL DC3CO support
      drm/i915/display: Switch DC3CO enable from standalone bit to DC
level encoding
      drm/i915/display: Use FIELD_PREP() for DC state enable bits
      drm/i915/display: Add DC3CO DC_STATE enable/disable support
      drm/i915/display: Add HAS_DC3CO() macro
      drm/i915/display: Add DC3CO support check
      drm/i915/psr: Add psr2 deep sleep helper API
      drm/i915/display: Add DC3CO compute and set target state in commit ta=
il
      drm/i915/display: Store DC3CO eligibility in PSR state
      drm/i915/display: PSR2: Set idle_frames to 0 for DC3CO
      drm/i915/display: Enable DC3CO idle protocol in ALPM
      drm/i915/display: PSR Add delayed work to exit DC3CO
      drm/i915/display: Add helper to enable DC counter
      drm/i915/display: Add DC3CO count and residency in dmc debugfs
      drm/i915/display: Guard CMTG function calls
      drm/i915/display: Enable DC3CO DC state
      drm/i915/display: Mask RO bits in gen9_write_dc_state()
      drm/i915/psr: Block DC3CO entry during active frame
      drm/i915/dmc: Enable PIPEDMC_ERROR interrupt on display version 30+

Dillon Varone (6):
      drm/amd/display: Generalize DMUB memory flushes from host
      drm/amd/display: Correct pipe usage for populating stream config
      drm/amd/display: Add MCIF ARB programming structures
      drm/amd/display: Add updated MCIF ARB register definitions
      drm/amd/display: Add DWB validation support to DML2.1 wrapper
      drm/amd/display: Port DCN4+ MCIF ARB programming to new format

Dio Zhang (1):
      drm/panel: panel-edp: Adjust T8 timing for AUO B116XAK01.6 and B140XT=
K02.4

Diogo Silva (7):
      drm/sun4i: Remove dependency on DRM simple helpers
      drm/rockchip: Remove dependency on DRM simple helpers
      drm/qxl: remove dependency on DRM simple helpers
      drm/gma500: cdv_intel_dp: fix indentation to use tabs instead of spac=
es
      drm/gma500: Remove dependency on DRM simple helpers
      drm/exynos: Remove dependency on DRM simple helpers
      drm/exynos: Add error handling to drm_encoder_init()

Dmitry Baryshkov (3):
      drm/bridge: split hpd_mutex into two mutexes
      drm/bridge: display-connector: don't autoenable HPD IRQ
      drm/bridge: display-connector: trigger initial HPD event for DP

Dmytro Laktyushkin (4):
      drm/amd/display: update memclk clock table read for dcn42
      drm/amd/display: remove unused dcn42 socbb values
      drm/amd/display: fix dcn42 det allocation order
      drm/amd/display: fix dcn42b det allocation order

Dominik Kaszewski (3):
      drm/amd/display: Remove sink usage from DPMS
      drm/amd/display: Fix indenting of dpms on
      drm/amd/display: Split DPMS ON into parts

Donet Tom (1):
      drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K systems

Dongwon Kim (3):
      drm/virtio: Freeze and restore hooks to support suspend and resume
      drm/virtio: Add support for saving and restoring virtio_gpu_objects
      drm/virtio: Add PM notifier to restore objects after hibernation

Dyllan Kobal (1):
      drm/amd/display: fix wrong register field in
dccg35_set_hdmistreamclk_src_new

Eliot Courtney (14):
      gpu: nova-core: falcon: gsp: move PRIV target mask constants
      gpu: nova-core: fsp: move FMC firmware loading into wait_secure_boot
      gpu: nova-core: move GSP firmware files decision to GSP HAL
      gpu: nova-core: fsp: limit FSP receive message allocation size
      gpu: nova-core: fsp: catch bogus queue pointer issues
      gpu: nova-core: gsp: ensure lifetime for FMC boot DMA allocations
      gpu: nova-core: gsp: ensure LibOS DMA allocation lives long enough
      gpu: nova-core: correct RISC-V HALTED field
      gpu: nova-core: wait for RISC-V HALTED on FSP unload
      gpu: nova-core: correct FRTS vidmem offset calculation
      gpu: nova-core: rename heap size field
      gpu: nova-core: return non-WPR heap size as u64 from HALs
      gpu: nova-core: split FbLayout into FSP and non-FSP versions
      gpu: nova-core: pass WPR metadata ownership to FmcBootArgs

Emre Cecanpunar (1):
      drm/i915/selftests: Fix GT PM sort comparators

Eric Chanudet (1):
      cgroup/dmem: accept only one region per limit write

Eric Engestrom (1):
      drm/doc: update tree setup instructions

Eric Huang (4):
      drm/amdkfd: add sdma queue counter for gfxv9.4.3
      drm/amdkfd: avoid PTL confused warning message
      drm/amdkfd: avoid race condition of mqd when reading sdma counter
      drm/amdkfd: add sanity check in svm_range_is_valid

Ethan Nelson-Moore (2):
      sysfb: correct CONFIG_SYSFB_SIMPLEFB macro name in #endif comment
      drm/amd/display: remove check for nonexistent CONFIG_HAVE_KGDB

Evgenii Burenchev (3):
      drm/amd/display: Fix dangling pointer in plane reset function
      drm/amd/display: Fix dangling pointer in CRTC reset function
      drm/amd/display: Fix dangling pointer in connector reset function

Fangzhi Zuo (7):
      drm/amd/display: Add Support for HDMI Compliance Automation
      drm/amd/display: Fix 8K Mode Not Parsed by EDID
      drm/amd/display: Allocate DCN32/1 dmub memory to GTT
      drm/amd/display: Skip Update HDCP Config In Transition State
      drm/amd/display: Prune per-tile Timing from Apple Studio Display
Primary Tile
      drm/amd/display: dispatch compressed FRL cap check inside
dml1_frl_cap_chk_inter
      drm/amd/display: Gate HDMI FRL status polling on active FRL link rate

Fares Soliman (1):
      drm/amdgpu: Update message IDs to PMFW to correctly gather
GFXOFF residency logs

Francois Dugast (6):
      gpu/buddy: Fix use-after-free in split_block() call sites
      gpu/buddy: Remove redundant condition in alloc_from_freetree() error =
path
      gpu/buddy: Introduce __gpu_buddy_undo_splits() helper
      gpu/buddy: Track per-order free blocks with a scoreboard
      gpu/buddy: Track per-order used blocks with a scoreboard
      drm/xe/pt: Fix NULL pointer dereference in xe_pt_zap_ptes_entry()

Frank Binns (2):
      drm/imagination: update GPU support documentation
      drm/imagination: promote BXM-4-64 MC1 (36.52.104.182) to supported st=
atus

Fran=C3=A7ois Roux (1):
      drm/panel-edp: Add Sharp LQ120P1JX51 (Surface Pro 12in 1st Ed.)

Gabe Teeger (7):
      drm/amd/display: Increase dcn42b uclk value
      drm/amd/display: Enable pstate for DCN4 non-emulation builds
      drm/amd/display: Enable PSR and Replay on DCN4 variant and fix
AUX instance
      drm/amd/display: Enable PSR and Replay on DCN4 variant [Part 2]
      drm/amd/display: Enable IPS support for DCN4 Variant
      drm/amd/display: Enable zstate support and fix seamless boot
      drm/amd/display: add dcn42b specific SMU clock table read

Gang Ba (1):
      drm/amdkfd: Fix missing authorization check in KFD_IOC_DBG_TRAP_DISAB=
LE

Gangliang Xie (2):
      drm/amdgpu: add buf length check
      drm/amdgpu: add check for xcp id

Gary Guo (5):
      gpu: nova-core: remove imports available from prelude
      gpu: nova-core: use `c"literal"` instead of `c_str!()`
      drm/tyr: remove imports available from prelude
      gpu: nova-core: remove `#[allow(non_snake_case)]`
      rust: drm: fix non-const `read8` in unit test

Geert Uytterhoeven (1):
      drm/rcar-du: Drop superfluous spaces after assignments

Geoffrey McRae (8):
      drm/amdkfd: Fix NULL deref during sysfs teardown
      drm/amdgpu,amdkfd: correct setting MES queue type
      drm/amdkfd: use amdgpu ring types for MES queue
      drm/amdgpu/mes: Add NULL check for mes_hung_db_array allocation
      drm/amdgpu/mes: Fix hung_queue_db_array loop limit for multi-XCC
      drm/amd/display: Fix DM I2C teardown race
      drm/amd/display: Fix DM IRQ teardown races
      drm/amd/display: Use unbound workqueues for deferred DM work

George Shen (1):
      drm/amd/display: Add flag to disable dynamic expansion for 12bpc

George Zhang (2):
      drm/amd/display: Fix sign mismatch warning
      drm/amd/display: Fix divide-by-zero in calculate_mcache_setting
on zero viewport

Gerhard Schwanzer (1):
      drm/amdkfd: Use exclusive bounds for SVM split alignment checks

Gleb Markov (1):
      drm/amd/display: Remove unused-but-set variable hubp from

Godswill Onwusilike (2):
      docs: gpu: drm-uapi: fix spelling of "unprivileged"
      docs: gpu: todo: fix spelling of "fucntion"

Granthali Vinodkumar Dhandar (2):
      drm/amdgpu: add support for GC IP version 11.7.0
      drm/amdgpu: add support for GC IP version 11.7.1

Guangshuo Li (5):
      drm/i915: clear CRTC color blob pointers after dropping refs
      drm/xe: free madvise VMA array on L2 flush failure
      drm/amd/display: move connector state dereference after NULL check
      drm/amdkfd: free MQD managers on DQM init failures
      drm/radeon: fix autosuspend cleanup during teardown

Guilherme Ivo Bozi (9):
      drm/amd/display: add GPIO HW translation helpers
      drm/amd/display: convert dcn10 GPIO translation to lookup tables
      drm/amd/display: convert dcn20 GPIO translation to lookup tables
      drm/amd/display: convert dcn21 GPIO translation to lookup tables
      drm/amd/display: convert dcn30 GPIO translation to lookup tables
      drm/amd/display: convert dcn315 GPIO translation to lookup tables
      drm/amd/display: convert dcn32 GPIO translation to lookup tables
      drm/amd/display: convert dcn401 GPIO translation to lookup tables
      drm/amd/display: convert dcn42 GPIO translation to lookup tables

Gustavo Sousa (13):
      drm/xe/rtp: Add struct types for RTP tables
      drm/xe/nvls: Update PCI IDs
      drm/xe/xe3p_lpg: Add missing references to workarounds
      drm/xe: Add framework for info probing
      drm/xe/step: Pass xe_step_info to xe_step_*_get() functions
      drm/xe: Add devid and revid to xe_probed_info
      drm/xe/step: Make xe_step_platform_get() independent from xe->info
      drm/xe: Add platform-level step info to xe_probed_info
      drm/xe/tests: Set non-GMDID graphics step in xe_pci_fake_device_init(=
)
      drm/xe: Add graphics/media IPs and their step info to xe_probed_info
      drm/xe: Don't initialize tile_count in xe_info_init_early()
      drm/xe: Add tile_count to xe_probed_info
      drm/xe/nvls: Drop force_probe requirement

Haikun Zhou (3):
      drm/panel-edp: Support NV140FHM-N5B and TM156VDXP25
      drm/panel-edp: Support MB116AS01'3 edp panel
      drm/panel-edp: Support MNE001BS6-2 and MNF601BS4-1 edp panel

Harish Chegondi (1):
      drm/xe/eustall: Add WA 14027054324 support for graphics IP 35.11

Harish Kasiviswanathan (1):
      drm/amdgpu: Fix kernel panic during driver load failure

Harkirat Gill (1):
      drm/amdgpu: cap GTT size to physical RAM on APUs

Harry VanZyllDeJong (1):
      drm/amd/display: Update VRR info packet to support 12-bit refresh rat=
es

Harry Wentland (7):
      drm/amd/display: drop redundant colorop type and TF checks
      drm/amd/display: split TF/LUT colorop state lookups into
separate upfront phases
      drm/amd/display: clamp DMUB AUX reply length to payload buffer
      drm/amd/display: guard against overflow in HDCP message dump
      drm/amd/display: hold a vblank ref while writeback is pending
      drm/amd/display: Resize MST HDCP per-connector arrays to 32
      drm/amd/display: Bounds-check connector->index in dm_dp_mst_get_modes

Hawking Zhang (1):
      drm/amdgpu: remove obsolete gmc ras helpers

Heiko Schocher (1):
      drm/panel: simple: Add Kyocera tcg070wvlq panel

Henrik Grimler (3):
      drm/lima: call drm_mm_init() with a valid allocation range
      drm/bridge: sii9234: fix some typos in comments and messages
      drm/bridge: sii9234: use dev_err_probe where applicable

Himal Prasad Ghimiray (2):
      drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC
      drm/xe/pt: check no-DMA huge-pte cases before DMA segment test

Honglei Huang (6):
      drm/amd/display: use kvzalloc to allocate struct dc
      drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
      drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
      drm/xe: have xe_svm_range embed one drm_gpusvm_pages
      drm/gpusvm: move struct drm_gpusvm_pages out of struct drm_gpusvm_ran=
ge
      drm/gpusvm: let the drm_gpusvm core context purely MM level

Hsin-Te Yuan (1):
      drm/panel-edp: Add pre_unprepare delay

Huang, Leon (1):
      drm/amd/display: Add get replay residency function

Icenowy Zheng (3):
      dt-bindings: display: panel: himax,hx83121a: add optional bl supply
      drm/panel: himax-hx83121a: pass the panel pointer when creating BL
      drm/panel: himax-hx83121a: add backlight regulator support

Igor Reznichenko (2):
      dt-bindings: display: panel: Add Ilitek ILI9488 panel controller
      drm/panel: Add Ilitek ILI9488 controller driver

Iker Pedrosa (1):
      drm/solomon: remove unneeded variables in blit functions

Ilya Bakoulin (1):
      drm/amd/display: Fix DP LT failure logging

Imre Deak (93):
      drm/i915: Keep display IRQs enabled for encoder suspend/shutdown
      drm/i915/xe: Enable HPD polling later during system resume
      drm/i915/dp_link_training: Introduce link training state struct
      drm/i915/dp_link_training: Factor out link training state reset helpe=
r
      drm/i915/dp_link_training: Flush commits in debugfs entries
      drm/i915/dp_link_training: Move link training helpers to link
training code
      drm/i915/dp_link_training: Use link_training as base pointer in debug=
fs
      drm/i915/dp_link_training: Add helpers to access force retrain state
      drm/i915/dp_link_training: Move link recovery/debug state to link_tra=
ining
      drm/i915/dp_link_training: Prevent repeated autoretrain attempts
      drm/i915/dp_link_training: Clamp sequential link training failure cou=
nter
      drm/i915/dp_link_training: Check for pending autoretrain explicitly
      drm/i915/dp_link_training: Add helper to query pending autoretrain
      drm/i915/dp_link_training: Add helper to query allowed autoretrain
      drm/i915/dp_link_training: Add helper to mark link training failure
      drm/i915/dp_link_training: Add helper to reset link recovery state
      drm/i915/dp_link_training: Track link recovery state with an enum
      drm/i915/dp_link_training: Add no-fallback link recovery state
      drm/i915/display: Factor out a helper to modeset a pipe with atomic s=
tate
      drm/i915/display: Simplify intel_modeset_commit_pipes_for_atomic_stat=
e()
      drm/i915/dp_link_training: Allocate atomic state for autoretrain mode=
set
      drm/i915/dp_link_training: Disallow autoretrains after failed modeset
      drm/i915/dp_link_training: Fix kernel-doc of
intel_dp_init_lttpr_and_dprx_caps()
      drm/i915/dp_link_training: Document DP link recovery logic
      drm/i915/mtl+: Enable PPS before PLL
      drm/i915/dp: Rename intel_dp_link_config to intel_dp_link_config_entr=
y
      drm/i915/dp: Add struct intel_dp_link_config
      drm/i915/dp_link_caps: Introduce DP link capability module
      drm/i915/dp_link_caps: Move common rate helpers to link caps
      drm/i915/dp_link_caps: Move forced link param helpers to link caps
      drm/i915/dp: Simplify querying of forced link parameters
      drm/i915/dp_link_caps: Move forced and max link debugfs entries
to link caps
      drm/i915/dp_link_training: Use helpers to get forced link params
      drm/i915/dp_link_caps: Move forced link params to link_caps
      drm/i915/dp_link_caps: Move link config helpers to link caps
      drm/i915/dp_link_caps: Move link config tracking to link_caps
      drm/i915/dp_link_caps: Rename helper updating the link configurations
      drm/i915/dp: Factor out helper to get link rate capabilities
      drm/i915/dp_link_caps: Pass supported link rates to link caps update
      drm/i915/dp_link_caps: Add helper to print all supported link rates
      drm/i915/dp_link_caps: Add helper to get the number of supported
link rates
      drm/i915/dp_link_caps: Add helper to get common rate index
      drm/i915/dp_link_caps: Move tracking of common rates to link_caps str=
uct
      drm/i915/dp_link_caps: Track max common lane count in link_caps
      drm/i915/dp_link_caps: Use max common lane count from link_caps
      drm/i915/dp_link_caps: Add helpers to get max link limits
      drm/i915/dp_link_caps: Add helpers to set max link limits
      drm/i915/dp_link_caps: Add helper to reset max link limits
      drm/i915/dp_link_caps: Add helper to reset link_caps state
      drm/i915/dp_link_caps: Move max link limits to link_caps
      drm/i915/dp_link_caps: Pass link_caps to static functions
      drm/i915/dp_link_caps: Pass link_caps to config update/lookup helpers
      drm/i915/dp_link_caps: Pass link_caps to common rate helpers
      drm/i915/doc: Document DP link capabilities
      drm/i915/dp_link_caps: Factor out helper to get link config by index
      drm/i915/dp_link_caps: Add support for link rate, lane count
iteration orders
      drm/i915/dp_link_caps: Add link configuration iterator
      drm/i915/dp_link_caps: Add helper to get iteration order for a connec=
tor
      drm/i915/dp_link_caps: Validate max link limits
      drm/i915/dp_link_caps: Add filter for enabled link configurations
      drm/i915/dp_link_caps: Re-enable link configurations after a link res=
et
      drm/i915/dp_link_caps: Re-enable link configurations after sink
caps change
      drm/i915/dp_link_caps: Drop noupdate postfix from max link limit
set helpers
      drm/i915/dp_link_caps: Add debugfs entry showing allowed configuratio=
ns
      drm/i915/dp: Add link configuration filter for modeset computation
      drm/i915/dp_link_caps: Add helper to query max BW link configuration
      drm/i915/dp: Query max BW config via link_caps during mode validation
      drm/i915/dp_tunnel: Query max BW config via link_caps for BW computat=
ion
      drm/i915/dp_test: Use link caps for compliance link configs
      drm/i915/dp: Iterate configurations via link_caps for SST non-DSC
      drm/i915/dp: Iterate configurations via link_caps for SST DSC
      drm/i915/dp: Use link caps for eDP DSC config selection
      drm/i915/dp_mst: Use link caps for non-DSC config selection
      drm/i915/dp_mst: Use link caps for MST DSC config selection
      drm/i915/dp: Remove min/max link config limits
      drm/i915/dp_link_training: Reset the max link limits in the fallback =
code
      drm/i915/dp_link_training: Use config iterator for fallback
      drm/i915/dp_link_training: Disable failed config during fallback
      drm/i915/kunit: Enable KUnit tests
      drm/i915/kunit: Add DP link test stub
      drm/xe/kunit: Add display test config
      drm/xe/kunit: Build DP link display tests
      drm/i915/kunit: Setup DP link test context
      drm/i915/kunit: Export link training and caps funcs for testing
      drm/i915/kunit: DP link: add baseline fixed table reference test
      drm/i915/kunit: DP link: add update config tests
      drm/i915/kunit: DP link: add fallback tests
      drm/dp_tunnel: Add UHBR tunneling support
      drm/i915/dp: End link configuration loops properly
      drm/i915/dp: Enable SST fallback between UHBR and non-UHBR rates
      drm/i915/dp: Remove UHBR dependency from SST fallback kunit test
      drm/i915/dp: Disable UHBR link configs with 1/2 lanes
      drm/i915/dp_tunnel: Add UHBR tunneling support

Iswara Nagulendran (2):
      drm/amd/display: Fix VABC Init and OLED Support
      drm/amd/display: Fix ABM over VABC

Ivan Lipski (5):
      drm/amd/display: Restore periodic detection for DCN35
      drm/amd/display: Reintroduce "Force validation link training on all A=
SICs"
      drm/amd/display: Refactor stream validation
      drm/amd/display: Unify force_yuv debugfs into force_yuv_pixel_format
      drm/amd/display: Relax frame size limit for dcn5/6 DML core funcs fil=
es

Jagmeet Randhawa (1):
      drm/xe/multi_queue: Reject PXP usage on multi-queue exec queues

Jakob Linke (1):
      drm/amdgpu/soc24: reset dGPU if suspend got aborted

James Lin (6):
      drm/amd/display: Add IN_FORMATS_ASYNC support for planes
      drm/amd/display: scale plane global alpha to 12 bits on DCN 4.2
      drm/amd/display: program dither on all OPP heads under ODM combine
      drm/amd/display: Add MALL status readback support for DCN 4.0.1
      drm/amd/display: Re-evaluate cursor mode on plane position/size chang=
e
      drm/amd/display: don't re-evaluate cursor mode on cursor plane moveme=
nt

James Zhu (3):
      drm/amdkfd: Add domain parameter to kernel BO mapping function
      drm/amdkfd: move TBA/TMA from system to device memory
      drm/amdkfd: use iosys_map for CWSR buffer access

Jani Nikula (51):
      drm/i915: add flush_workqueue(display->wq.cleanup) on shutdown
      drm/xe/display: remove intel_display_flush_cleanup_work() calls
on suspend/shutdown
      drm/xe/display: drop duplicate intel_dp_mst_suspend() call
      drm/i915/display: add "pm" to intel_display_driver_{suspend,
resume}() names
      drm/xe/display: rename xe_display_pm_shutdown*() to xe_display_shutdo=
wn*()
      drm/xe/display: relocate the xe_display_shutdown*() functions
      drm/xe/display: relocate the xe_display_pm_runtime_*() functions
      drm/{i915, xe}: move more calls inside intel_display_driver_pm_suspen=
d()
      drm/{i915, xe}: move more calls inside intel_display_driver_pm_resume=
()
      drm/{i915, xe}: add intel_display_driver_pm_{suspend_late, resume_ear=
ly}()
      drm/{i915,xe}: add intel_display_driver_shutdown_late()
      drm/i915: add intel_display_driver_shutdown()
      drm/i915/display: deduplicate suspend and shutdown a bit
      drm/xe/display: use intel_display_driver_pm_shutdown()
      drm/{i915, xe}: move more stuff to __intel_display_driver_pm_suspend(=
)
      drm/i915/color: clean up variables in xelpd_program_plane_pre_csc_lut=
()
      drm/i915/color: clean up variables in xelpd_program_plane_post_csc_lu=
t()
      drm/i915/color: reduce indent in xelpd_program_plane_pre_csc_lut()
      drm/i915/color: reduce indent in xelpd_program_plane_post_csc_lut()
      drm/i915/color: join loops in xelpd_program_plane_pre_csc_lut()
      drm/i915/color: join loops in xelpd_program_plane_post_csc_lut()
      drm/i915/color: deduplicate loops in xelpd_program_plane_pre_csc_lut(=
)
      drm/i915/color: deduplicate loops in xelpd_program_plane_post_csc_lut=
()
      drm/intel: drop driver include from mchbar_regs.h
      drm/i915/panic: split out i915_gem_panic.[ch]
      drm/i915/panic: squash i915_panic.c into i915_gem_panic.c
      drm/i915/panic: remove the extra layer from panic hooks
      drm/{i915,xe}/panic: pass obj to panic setup
      drm/xe/panic: store fb bo in struct intel_panic
      drm/{i915, xe}/panic: drop dependency on struct intel_framebuffer
      drm/i915: move intel_display_device_probe() call a level higher
      drm/i915: remove superfluous checks for pdev->msi_enabled
      drm/{i915, xe}: move opregion/dram/bw init to
intel_display_driver_probe_noirq()
      drm/xe/display: change order of
intel_display_driver_remove_{nogem, noirq}() calls
      drm/{i915, xe}: move opregion cleanup to
intel_display_driver_remove_nogem()
      drm/{i915, xe}: move intel_hpd_cancel_work() to
intel_display_driver_remove_noirq()
      drm/i915/hdcp: check streams[] bounds before overflow
      drm/i915/hdcp: require monotonically increasing seq_num_v
      drm/i915/vrr: require valid min/max vfreq for VRR
      drm/i915/bios: range check LFP Data Block panel_type2
      Merge drm/drm-next into drm-intel-next
      drm/i915: call intel_uncore_runtime_resume() for each gt
      drm/i915: call intel_display_power_runtime_resume() on suspend error =
path
      drm/i915: move some display runtime suspend operations earlier
      drm/i915: add intel_display_driver_pm_runtime*() functions
      drm/{i915, xe}: add new intel_display_driver_runtime_pm_{enable,
disable}()
      drm/xe/display: separate d3cold handling from
xe_display_pm_runtime_suspend_late()
      drm/xe/display: add xe_display_pm_runtime_resume_early()
      drm/xe/display: unify runtime suspend/resume with i915 for non-d3cold
      drm/i915/mst: limit DP MST ESI service loop
      drm/panel: remove accidentally committed .orig file

Jeevana Muthyala (2):
      drm/amdgpu/vcn4.0: enable secure submission on unified ring
      drm/amdgpu/vcn4.0.5: enable secure submission on unified ring

Jernej Skrabec (12):
      drm/sun4i: Fix V3s YUV scanline size
      drm/sun4i: vi scaler: Fix coefficient selection
      drm/sun4i: vi scaler: Restore opaque alpha in video modes
      drm/sun4i: tcon-top: Keep mixer routes distinct
      drm/sun4i: tcon: Set output mux for DSI and LVDS
      drm/sun4i: tcon: Drop TCON TOP device reference
      drm/sun4i: hdmi: Don't leak sync polarity bits into packet control
      drm/sun4i: crtc: Propagate layer initialization error
      drm/sun4i: tcon: Drop remote endpoint reference
      drm/sun4i: dw-hdmi: Drop TCON TOP port reference
      drm/sun4i: Drop node references while building component list
      drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at 594 MHz

Jerome Tollet (1):
      drm/i915/hdmi: Poll for 200 msec for TMDS_Scrambler_Status

Jerry Zuo (1):
      drm/amd/display: hide Apple Studio Display secondary tile

Jesse Zhang (29):
      drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy queues on
unified MES
      drm/amdgpu/mes_v12_1: use mes schedule pipe for legacy queues on
unified MES
      drm/amdgpu/gfx11: Refactor compute pipe reset and add HQD cleanup
      drm/amdgpu/gfx12: Refactor compute pipe reset and add HQD cleanup
      drm/amdgpu/gfx: defer per-queue helper_end until after MES resume
      drm/amdkfd: fix SDMA queue counter read on non-gfx9.4.3 ASICs
      drm/amdgpu/mes12: drop queue state on RESET_QUEUES unmap
      drm/amdkfd: flush MES queue on reset-time queue removal
      drm/amdgpu/userq: add reset helper and identify guilty user queue
      drm/amdgpu/gfx11: handle error interrupts for userqs
      drm/amdgpu: defer KCQ remap until after MES resume in reset flow
      drm/amdgpu/gfx12: handle error interrupts for userqs
      drm/amdgpu/gfx11: fix EOP interrupt routing for KQ and userq
      drm/amdgpu/gfx12: fix EOP interrupt routing for KQ and userq
      Revert "drm/amdgpu: defer KCQ remap until after MES resume in reset f=
low"
      drm/amdgpu: trigger GPU recovery when userq destroy fails to
unmap a hung queue
      drm/amdgpu/userq: fix indefinite fence wait during GPU reset
      drm/amdgpu/mes11: set remove_queue_after_reset for reset unmap path
      drm/amdgpu: fix JPEG v5.0.0 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v4.0.5 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v5.3.0 queue reset failure in DPG mode
      drm/amdgpu: track faulted gfx user-queue slots
      drm/amdgpu/gfx11: add priv-fault user-queue recovery worker
      drm/amdgpu/gfx12: add priv-fault user-queue recovery worker
      drm/amdgpu: recover user queues in the shared priv-fault helper
      drm/amdgpu/userq: mark a queue unmapped after a per-queue reset
      drm/amdgpu/userq: serialize queue map against GPU reset
      drm/amdgpu/mes12: fix dropped dispatches under queue oversubscription
      drm/amdgpu: keep PRT mappings off the vm_bo state lists

Jiqian Chen (1):
      drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2

Jiri Slaby (SUSE) (3):
      drm/imx: Switch to irq_domain_create_linear()
      drm/imx: include dc-drv.h to avoid sparse warning
      drm/amd/display: use proper context for logging

Joel Fernandes (1):
      gpu: nova-core: gsp: Extract and display usable FB regions from GSP

Johan Hovold (5):
      drm/vc4: hdmi: take i2c adapter module reference
      drm/panel-edp: fix i2c adapter leak on probe failure
      drm/panel-edp: take i2c adapter module reference
      drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure
      drm/exynos: hdmi: take i2c adapter module reference

John Harrison (2):
      drm/i915/display: Fix too few bits in transcoder mask variables
      drm/amd/display: Fix use-after-free bugs in KUnit tests

John Hubbard (8):
      perf/core: out-of-line and export perf_allow_cpu/tracepoint()
      drm/xe: gate observation streams with perf_allow_cpu()
      gpu: nova-core: don't declare booter firmware for FSP chipsets
      gpu: nova-core: clean up FSP FRTS comments
      gpu: nova-core: Blackwell: use absolute FBHUB0 flush registers
      gpu: nova-core: Hopper: use correct sysmem flush registers
      gpu: nova-core: fb: fix Blackwell flush address composition
      gpu: nova-core: fb: remove duplicated SysmemFlush doc link

Jonas Karlman (11):
      drm/rockchip: dw_hdmi: Use of_device_get_match_data() to get match da=
ta
      drm/rockchip: dw_hdmi: Use local dev variable consistently in bind()
      drm/rockchip: dw_hdmi: Use drmres helpers for encoder resources
      drm/rockchip: dw_hdmi: Inline resource lookup into bind()
      drm/rockchip: dw_hdmi: Hold a reference to the dw-hdmi bridge
      drm/rockchip: dw_hdmi: Remove empty encoder helper funcs
      drm/rockchip: dw_hdmi: Clean up whitespace
      drm/rockchip: dw_hdmi: Set output_port for RK3568/RK3566
      drm/rockchip: dw_hdmi: Configure HDMI PHY in atomic_mode_set()
      drm/rockchip: dw_hdmi: Propagate bus format to display driver
      drm/rockchip: dw_hdmi: Use resume_early pm ops for system suspend

Jonathan Cavitt (3):
      drm/i915: Refactor generic_handle_irq_safe() error messages
      drm/exec: Use kvmalloc_objs for exec->objects
      drm/syncobj: Use kmalloc_objs for chains

Jonathan Marek (1):
      drm/msm/dsi: support DSC configurations with slice_per_pkt > 1

Joonas Lahtinen (6):
      drm/i915/gem: Fix phys BO pread/pwrite with offset
      drm/i915/gem: Add missing nospec on parallel submit slot
      drm/i915: Return NULL on error in active_instance
      drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
      drm/i915/gt: Fix NULL deref on sched_engine alloc failure
      drm/i915/gem: Do not leak siblings[] on proto context error

Julia Filipchuk (1):
      drm/xe/guc: Define GuC firmware for NVL-S

Jun Nie (1):
      drm/panel: Enable DSC for Visionox VTDR6130 panel

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Justin Chen (2):
      drm/amd/display: Revert Fix DMSS not triggering for HDR to SDR transi=
tion
      drm/amd/display: add DalForceMaxDisplayClock debug option to DML2

Kai Vehmanen (1):
      drm/i915/audio: treat UHBR SST like MST for cpu_transcoder signalling

Kanala Ramalingeswara Reddy (4):
      drm/amdgpu: add support for PSP version 15.0.9
      drm/amdgpu: add support for SMU version 15.0.9
      drm/amdgpu: Update driver if header for SMU V15.0.5
      drm/amdgpu: enable mode2 reset for SMU IP v15.0.5

KancyJoe (1):
      drm: panel: add support for the Renesas R63419 based dual-DSI
video mode Display Panels

Karen Chen (1):
      drm/amd/display: Disable DPPCLK RCG to fix cursor disappearing

Karol Wachowski (3):
      accel/ivpu: Use threaded IRQ for IPC callback processing
      accel/ivpu: use kmem_cache for IPC rx_msg allocations
      accel/ivpu: Drop IRQF_ONESHOT to allow IPC IRQ threading on PREEMPT_R=
T

Karthi Kandasamy (2):
      drm/amd/display: Fix DMSS not triggering for HDR to SDR transition
      drm/amd/display: Fix seamless mode switch not triggering for HDR
to SDR transition

Karthik Poosa (2):
      drm/xe/pcode: Add support to get pcode version from PMT
      drm/xe/debugfs: Add debugfs for pcode information

Ke Zhao (1):
      drm/amdgpu: Fix typo in comment

Kenji Takahashi (1):
      drm/amdgpu: Fix typo in comment

Kenneth Feng (1):
      drm/amd/amdgpu: disable ASPM on VI if pcie dpm is disabled

Kent Russell (4):
      drm/amdkfd: Move mqd_on_vram out of v9 mqd manager
      drm/amdkfd: Extend MQDs in HBM to gfx942
      drm/amdkfd: Extend MQDs in HBM to gfx944
      drm/amdkfd: Clean up debug runlist printing

Konrad Dybcio (1):
      dt-bindings: display: panel: samsung,atna33xc20: Add ATNA40HQ08-0

Krzysztof Niemiec (2):
      gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST
      gpu/tests: Add a dedicated .kunitconfig

Laura Nao (1):
      drm: Remove DRIVER_GEM_GPUVA feature flag

Laurent Pinchart (1):
      drm/bridge: Replace outdated forward declaration

Laxman Acharya Padhya (1):
      drm/panel: samsung-s6d16d0: Power off on prepare failure

Leandro Ribeiro (2):
      drm/drm_blend: allow blend mode property without PREMULTI
      drm: ensure blend mode supported if pixel format with alpha exposed

Leo Chen (7):
      drm/amd/display: Update ONO PG Workaround for DCN42
      drm/amd/display: Remove unnecessary DSCCLK enable during DSC PG
      drm/amd/display: Enable HUBP/DPP power gate for DCN42
      drm/amd/display: Refactor Driver PG's skip PG logic
      drm/amd/display: revert "Enable HUBP/DPP power gate for DCN42"
      drm/amd/display: Enable HUBP/DPP Driver PG for DCN42
      drm/amd/display: Register DCN as a PMFW DF C-state client on DCN42

Leo Li (5):
      drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no=
_lock
      drm/amd/display: check GRPH_FLIP status before sending event
      Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"
      drm/amd/display: Fix flip-done timeouts on mode1 reset
      drm/amd/display: Exit idle optimizations before programming

Leonardo Costa (2):
      dt-bindings: display: panel-lvds: Add compatible for Opto Logic
SCX1001511GGC49
      dt-bindings: vendor-prefixes: Add Opto Logic

Leorize (1):
      drm/amd/display: set MSA MISC1 bit 6 when using VSC SDP for DCE 11.x

Lijo Lazar (25):
      drm/amd/pm: Validate custom profile parameters
      drm/amdxcp: Add more checks to amdxcp
      drm/amdgpu: Fix kobject cleanup in xcp sysfs
      drm/amdgpu: Add checks to vbios fetch through ATRM
      drm/amd/pm: Add helper for parameter parsing
      drm/amd/pm: Add helper functions to fetch pptable
      drm/amd/pm: Use helper to get pptable in SMUv11
      drm/amd/pm: Use helper to get pptable in SMUv13
      drm/amd/pm: Use helper to get pptable in SMUv14
      drm/amd/pm: Use helper to get pptable in SMUv15
      drm/amdgpu: Validate ATIF buffer length before use
      drm/amdgpu: Validate ATPX buffer length before use
      drm/amdgpu: bounds check xcp ip block index
      drm/amd/pm: validate vega10 profile mode inputs
      drm/amdgpu: bounds check xcp_id in release_sched
      drm/amdgpu: Guard reads in pcie state readout
      drm/amdgpu: bounds check ATOM IIO table parsing
      drm/amdgpu: bounds check atom indirect io method
      drm/amdgpu: bounds check VBIOS name extraction
      drm/amdgpu: Prefer default discovery offset
      drm/amdgpu: Use virtual alloc during coredump
      drm/amdgpu: Allocate coredump ring buffers per ring
      drm/amd/pm: Simplify SoC power printing in debugfs
      drm/amd/pm: Keep sub-watt precision in Q10 socket power
      drm/amd/pm: Keep sub-degree precision in Q10 temperatures

Linmao Li (1):
      drm/i915/guc: Return NULL for missing multi-lrc parent

Liu Ying (1):
      drm/bridge: imx: Add i.MX93 parallel display format configuration sup=
port

Lizhi Hou (1):
      accel/amdxdna: Disable device buffer exporting

Lohita Mudimela (1):
      drm/amd/display: Integrate power_helpers.c functionality into power.c=
.

Lu Yao (1):
      drm/xe: Remove redundant exec_queue_suspended() check in
submit_exec_queue()

Luca Ceresoli (5):
      drm/mxsfb/lcdif: don't hide lcdif_attach_bridge() deferral messages
      drm: of: fix wording in comment
      drm/bridge: samsung-dsim: fix wording in comment
      drm/bridge: fix wording in comment
      drm/bridge: rename drm_for_each_bridge_in_chain_scoped() to
drm_for_each_bridge_in_chain()

Luca Leonardo Scorcia (1):
      dt-bindings: mediatek: cec: Correct the compatibles for mt7623-mt8167

Lucas Stach (2):
      drm/etnaviv: check all modules for idle after reset
      drm/etnaviv: check MMUv2 status after reset

Lyude Paul (9):
      rust: drm: gem: shmem: Fix Default implementation for ObjectConfig
      rust: drm: gem: shmem: Add DmaResvGuard helper
      rust: drm: gem: shmem: Add vmap functions
      drm/nouveau/disp/r535: Add scanline position support + head state sup=
port
      rust: drm: gem: Introduce shmem::Object::sg_table()
      rust: faux: Allow retrieving a bound Device
      drm/nouveau/kms/nv50-: Add .blend_modes to nv50_wndw_func
      drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()
      drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for wnd=
ws

Maarten Lankhorst (3):
      drm/i915/display: Fix intel_lpe_audio_irq_handler for PREEMPT-RT
      drm/xe: Fix DPT allocation paths.
      drm/xe/display: Do not allocate into stolen for new framebuffers.

Mallesh Koujalagi (1):
      drm/xe: Consolidate debugfs fault injection functions

Maoyi Xie (1):
      drm/bridge: tc358767: clamp the reported AUX read size to the request

Marc-Olivier Champagne (4):
      drm: panel: jd9365da: Enable LPM mode
      dt-bindings: vendor-prefixes: Add DCLTEK
      dt-bindings: display: panel: add compatible for DCLTek 300250 9.35in =
panel
      drm: panel: jd9365da: Add DCLTek 300250 9.35in display

Marco Crivellari (2):
      drm/gm12u320: Replace system_long_wq with system_dfl_long_wq
      drm/amdgpu: Change system_unbound_wq with system_dfl_wq

Marco Pagani (1):
      drm/sched: Add test suite for concurrent job submissions

Mario Limonciello (17):
      drm/amd/display: Set default backlight without ACPI support
      drm/amdgpu: Export ip_discovery sysfs on probe failure
      drm/amdkfd: fix list_del corruption in kfd_criu_resume_svm
      drm/amdgpu: check amdgpu_vm_bo_find() result in GET_MAPPING_INFO
      drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
      ttm/pool: Use sentinels in debugfs
      drm/amdgpu: don't free standalone ip_discovery sysfs in sysfs_fini
      drm/amd/display: Fix backlight max_brightness to match exported range
      drm/amdgpu: Fix VFCT bus number matching with soft filter
      drm/amdgpu: Release VFCT ACPI table reference
      drm/radeon: Modernize VFCT error handling
      drm/radeon: Fix VFCT bus number matching with soft filter
      drm/radeon: Validate VBIOS signature in VFCT path
      drm/amdgpu/display: Add amdgpu_display.c documentation
      drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen Pinnacle Ri=
dge
      drm/amd: Move dynamic PCIe switching quirks to X86_MATCH_* macros
      drm/amd: Create a device link between APU display and XHCI devices

Markus Elfring (3):
      drm/amd/display: Simplify data output in ips_status_show()
      drm/amd/display: Use seq_putc() in three functions
      drm/nouveau: Omit a redundant pm_runtime_mark_last_busy() call
in nouveau_pmops_runtime_idle()

Matt Coster (8):
      MAINTAINERS: Update imagination details
      MAINTAINERS: Update imagination maintainers
      dt-bindings: gpu: img,powervr-*: Add maintainer entries
      MAINTAINERS, mailmap: Update address for Matt Coster
      dt-bindings: gpu: img,powervr-*: Remove Matt Coster as maintainer
      drm/imagination: Add and use FLEX_ARRAY_CHECK()
      drm/imagination: Use struct_size_t()
      drm/imagination: fixup some docs in pvr_gem.h

Matt Roper (8):
      drm/xe: Reformat xe_rtp_types.h
      drm/xe/rtp: Add FIELD_SET_FUNC RTP action
      drm/xe: Move engines' LRC programming RTP table off the stack
      drm/xe: Move engines' non-LRC programming RTP table off the stack
      drm/xe/rtp: Add kunit tests to exercise FIELD_SET_FUNC action
      drm/xe/tests/rtp: Add kunit test for whitelist upper bounds
      drm/xe: Drop 'force_execlist' module parameter
      drm/xe/xe3p_lpg: Program TR_PTA_MODE

Matthew Auld (15):
      drm/xe/display: skip FORCE_WC and vm_bound check for external dma-buf=
s
      drm/xe: fix NPD in bo_meminfo()
      drm/xe: account for dontneed in fdinfo purgeable
      drm/xe/pt: prevent invalid cursor access for purged BOs
      drm/xe/guc: refactor ads to use guc_class
      drm/xe/guc: refactor to_guc_class() to accept hwe
      drm/xe/guc: add the plumbing for GUC_PAGING_CLASS
      drm/xe/hw_engine: don't open code is_usm_hwe()
      drm/xe: refactor the paging engine setup
      drm/xe/guc: handle guc logical instance for paging engine
      drm/xe/guc: handle submit mask with paging engine
      drm/xe/vf: wire up NUM_PAGING_ENGINE_INSTANCES
      drm/xe/hw_engine: document top-down paging requirement
      drm/xe/guc: toggle paging engine support for NVL-S+
      drm/xe/bo: optimise TT population for DONTNEED BOs

Matthew Brost (8):
      drm/xe: Set TTM device beneficial_order to 9 (2M)
      drm/ttm: Issue direct reclaim at beneficial_order
      drm/ttm/pool: Try harder for beneficial orders
      drm/ttm: Drop tt->restore after successful restore
      drm/xe: Return error on non-migratable faults requiring devmem
      drm/xe: Fix PTE index in xe_vm_populate_pgtable() for chunked binds
      drm/xe: Wait on external BO kernel fences in exec IOCTL
      drm/xe/vf: Fix VF CCS attach/detach race with in-flight BO moves

Matthew Jacob (1):
      drm/amdgpu: Support some Barco AMD based graphics adapters

Matthew Schwartz (1):
      drm/amd/display: Fix mem_type change detection for async flips

Matthew Stewart (11):
      drm/amd/display: Add dcn42b_soc_and_ip_translator
      drm/amd/display: Fix DCN42 null registers & register masks
      drm/amd/display: Rewrite dccg42_init
      drm/amd/display: Remove DCCG registers not needed in DCN42
      drm/amd/display: Fix DCN42B null registers & register masks
      drm/amd/display: Add passive dongle handling in force_to_use_aux case
      drm/amd/display: Add DCN42B VID_CRC_CONTROL and HBLANK_CONTROL regist=
ers
      drm/amd/display: Add DCHUBBUB_HW_DEBUG offset/mask
      drm/amd/display: Fixes for dcn42b_soc_bb.h
      drm/amd/display: Fix rounding errors in CalculatePrefetchSchedule
      drm/amd/display: Add missing DCN42B register defines

Maxime Ripard (134):
      drm/atomic: Document atomic commit lifetime
      drm/colorop: Fix typos in the doc
      drm/atomic: Drop drm_private_obj.state assignment from create_state
      drm/atomic: Expand atomic_create_state expectations for drm_private_o=
bj
      drm/mode-config: Document drm_private_obj exclusion from
drm_mode_config_reset()
      drm/colorop: Rename __drm_colorop_state_reset()
      drm/colorop: Create drm_atomic_helper_colorop_create_state()
      drm/atomic-state-helper: Fix __drm_atomic_helper_plane_reset() doc ty=
po
      drm/atomic-state-helper: Rename __drm_atomic_helper_plane_state_reset=
()
      drm/plane: Add new atomic_create_state callback
      drm/atomic-state-helper: Rename __drm_atomic_helper_crtc_state_reset(=
)
      drm/crtc: Add new atomic_create_state callback
      drm/atomic-state-helper: Rename
__drm_atomic_helper_connector_state_reset()
      drm/hdmi: Rename __drm_atomic_helper_connector_hdmi_reset()
      drm/connector: Add new atomic_create_state callback
      drm/mode-config: Create drm_mode_config_create_initial_state()
      drm/drv: Switch skeleton to drm_mode_config_create_initial_state()
      drm/tidss: Convert to atomic_create_state
      drm/bridge_connector: Convert to atomic_create_state
      drm/bridge: cdns-dsi: Return an error pointer on allocation failure
      drm/bridge: cdns-mhdp8546: Return an error pointer on allocation fail=
ure
      drm/atomic-state-helper: Rename __drm_atomic_helper_bridge_reset()
      drm/atomic-state-helper: Reorder
__drm_atomic_helper_bridge_state_init() arguments
      drm/atomic-state-helper: Drop memset from
__drm_atomic_helper_bridge_state_init()
      drm/bridge: Add new atomic_create_state callback
      drm/atomic-state-helper: Add drm_atomic_helper_bridge_create_state()
      drm/bridge: adv7511: Switch to atomic_create_state
      drm/bridge: analogix_dp: Switch to atomic_create_state
      drm/bridge: anx7625: Switch to atomic_create_state
      drm/bridge: chipone-icn6211: Switch to atomic_create_state
      drm/bridge: display-connector: Switch to atomic_create_state
      drm/bridge: fsl-ldb: Switch to atomic_create_state
      drm/bridge: imx8mp-hdmi-pvi: Switch to atomic_create_state
      drm/bridge: imx8qm-ldb: Switch to atomic_create_state
      drm/bridge: imx8qxp-ldb: Switch to atomic_create_state
      drm/bridge: imx8qxp-pixel-combiner: Switch to atomic_create_state
      drm/bridge: imx8qxp-pixel-link: Switch to atomic_create_state
      drm/bridge: imx8qxp-pxl2dpi: Switch to atomic_create_state
      drm/bridge: inno-hdmi: Switch to atomic_create_state
      drm/bridge: ite-it6263: Switch to atomic_create_state
      drm/bridge: ite-it6505: Switch to atomic_create_state
      drm/bridge: ite-it66121: Switch to atomic_create_state
      drm/bridge: lontium-lt9211: Switch to atomic_create_state
      drm/bridge: lontium-lt9611: Switch to atomic_create_state
      drm/bridge: lvds-codec: Switch to atomic_create_state
      drm/bridge: nwl-dsi: Switch to atomic_create_state
      drm/bridge: panel: Switch to atomic_create_state
      drm/bridge: parade-ps8640: Switch to atomic_create_state
      drm/bridge: samsung-dsim: Switch to atomic_create_state
      drm/bridge: sii902x: Switch to atomic_create_state
      drm/bridge: ssd2825: Switch to atomic_create_state
      drm/bridge: dw-dp: Switch to atomic_create_state
      drm/bridge: dw-hdmi-qp: Switch to atomic_create_state
      drm/bridge: dw-hdmi: Switch to atomic_create_state
      drm/bridge: dw-mipi-dsi: Switch to atomic_create_state
      drm/bridge: dw-mipi-dsi2: Switch to atomic_create_state
      drm/bridge: tc358762: Switch to atomic_create_state
      drm/bridge: tc358767: Switch to atomic_create_state
      drm/bridge: tc358768: Switch to atomic_create_state
      drm/bridge: tc358775: Switch to atomic_create_state
      drm/bridge: ti-dlpc3433: Switch to atomic_create_state
      drm/bridge: ti-sn65dsi83: Switch to atomic_create_state
      drm/bridge: ti-sn65dsi86: Switch to atomic_create_state
      drm/bridge: ti-tdp158: Switch to atomic_create_state
      drm/bridge: ti-tfp410: Switch to atomic_create_state
      drm/imx: parallel-display: Switch to atomic_create_state
      drm/ingenic: Switch to atomic_create_state
      drm/mediatek: dp: Switch to atomic_create_state
      drm/mediatek: dpi: Switch to atomic_create_state
      drm/mediatek: dsi: Switch to atomic_create_state
      drm/mediatek: hdmi: Switch to atomic_create_state
      drm/mediatek: hdmi_v2: Switch to atomic_create_state
      drm/meson: encoder_cvbs: Switch to atomic_create_state
      drm/meson: encoder_dsi: Switch to atomic_create_state
      drm/meson: encoder_hdmi: Switch to atomic_create_state
      drm/msm: dp: Switch to atomic_create_state
      drm/msm: hdmi: Switch to atomic_create_state
      drm/omap: hdmi4: Switch to atomic_create_state
      drm/omap: hdmi5: Switch to atomic_create_state
      drm/renesas: rcar-du: lvds: Switch to atomic_create_state
      drm/renesas: rcar-du: mipi_dsi: Switch to atomic_create_state
      drm/renesas: rz-du: mipi_dsi: Switch to atomic_create_state
      drm/rockchip: cdn-dp: Switch to atomic_create_state
      drm/rockchip: rk3066_hdmi: Switch to atomic_create_state
      drm/rockchip: lvds: Switch to atomic_create_state
      drm/stm: lvds: Switch to atomic_create_state
      drm/tests: bridge: Switch to atomic_create_state
      drm/tidss: encoder: Switch to atomic_create_state
      drm/tidss: oldi: Switch to atomic_create_state
      drm/vc4: dsi: Switch to atomic_create_state
      drm/verisilicon: Switch to atomic_create_state
      drm/xlnx: zynqmp_dp: Switch to atomic_create_state
      drm/atomic-state-helper: Remove drm_atomic_helper_bridge_reset()
      drm/bridge: cdns-dsi: Use __drm_atomic_helper_bridge_state_init()
      drm/bridge: cdns-dsi: Switch to atomic_create_state
      drm/bridge: cdns-mhdp8546: Switch to atomic_create_state
      drm/bridge: Remove atomic_reset support
      drm/adp: mipi: Add atomic bridge state handlers
      drm/bridge: analogix-anx6345: Switch to atomic bridge callbacks
      drm/bridge: analogix-anx78xx: Switch to atomic bridge callbacks
      drm/bridge: aux-bridge: Add atomic bridge state handlers
      drm/bridge: aux-hpd-bridge: Add atomic bridge state handlers
      drm/bridge: chrontel-ch7033: Switch to atomic bridge callbacks
      drm/bridge: cros-ec-anx7688: Add atomic bridge state handlers
      drm/bridge: lontium-lt8713sx: Add atomic bridge state handlers
      drm/bridge: lontium-lt8912b: Switch to atomic bridge callbacks
      drm/bridge: lontium-lt9611uxc: Add atomic bridge state handlers
      drm/bridge: lvds-codec: Switch to atomic bridge callbacks
      drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Add atomic bridge
state handlers
      drm/bridge: microchip-lvds: Add atomic bridge state handlers
      drm/bridge: nxp-ptn3460: Switch to atomic bridge callbacks
      drm/bridge: of-display-mode-bridge: Add atomic bridge state handlers
      drm/bridge: parade-ps8622: Switch to atomic bridge callbacks
      drm/bridge: sii9234: Add atomic bridge state handlers
      drm/bridge: sil-sii8620: Add atomic bridge state handlers
      drm/bridge: simple-bridge: Switch to atomic bridge callbacks
      drm/bridge: tc358764: Switch to atomic bridge callbacks
      drm/bridge: tda998x: Switch to atomic bridge callbacks
      drm/bridge: ti-tfp410: Switch to atomic bridge callbacks
      drm/bridge: ti-tpd12s015: Add atomic bridge state handlers
      drm/bridge: thc63lvd1024: Switch to atomic bridge callbacks
      drm/bridge: waveshare-dsi: Switch to atomic bridge callbacks
      drm/exynos: mic: Switch to atomic bridge callbacks
      drm/mcde: dsi: Add atomic bridge state handlers
      drm/mediatek: dpi: Switch to atomic bridge callbacks
      drm/msm: dsi: Switch to atomic bridge callbacks
      drm/omap: dpi: Switch to atomic bridge callbacks
      drm/omap: dsi: Switch to atomic bridge callbacks
      drm/omap: sdi: Switch to atomic bridge callbacks
      drm/omap: venc: Switch to atomic bridge callbacks
      drm/sti: dvo: Switch to atomic bridge callbacks
      drm/sti: hda: Switch to atomic bridge callbacks
      drm/sti: hdmi: Switch to atomic bridge callbacks
      drm/bridge: Remove legacy bridge callback support

Ma=C3=ADra Canal (21):
      dma-fence: Clarify external lock use case in dma_fence_init() docs
      drm/v3d: Reduce PM runtime autosuspend delay
      accel: ethosu: Remove redundant job_lock
      drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h
      drm/v3d: Clear queue->active_job when v3d_fence_create() fails
      drm/v3d: Extract v3d_job_add_syncobjs() helper
      drm/v3d: Reject invalid syncobj handles in submit ioctls
      drm/v3d: Migrate BO reservation locking to DRM exec
      drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls
      drm/v3d: Make v3d_get_cpu_indirect_csd_params() a pure parser
      drm/v3d: Convert submit helpers to operate on struct v3d_submit
      drm/v3d: Refactor CPU ioctl into unified submission chain
      drm/v3d: Split BO fence attach from syncobj output handling
      drm/v3d: Reject invalid out_sync handles in submit ioctls
      drm/v3d: Ensure atomic submissions in v3d_submit_jobs()
      drm/v3d: Deprecate V3D 3.3 and 4.1 support
      drm/v3d: Refactor perfmon locking
      drm/v3d: Serialize jobs across queues when a perfmon is attached
      drm/v3d: Use write_to_buffer() helper in performance query copy
      drm/v3d: Associate BOs with every job that accesses them
      drm/panfrost: Remove unused scheduled_jobs list

Melissa Wen (5):
      drm/amd/display: use GAMCOR for degamma private props in subsampled f=
ormat
      Revert "drm/amd/display: Remove unused
cm3_helper_translate_curve_to_degamma_hw_format"
      drm/amd/display: use a separate helper to translate degamma curves
      drm/amd/display: support up to 256 samples per region in degamma/blen=
d LUT
      drm/amd/display: use halving distribution for PQ/sRGB linearizing LUT

Michael Bommarito (1):
      drm/v3d: bound CPU-job query writes to their destination BO

Michael Kelley (1):
      drm/hyperv: Use "hv_drm_" as symbol name prefix

Michael Strauss (1):
      drm/amd/display: Add 12bpc Color Ramp Support

Michail Tatas (3):
      drm/panel: ilitek-ili9805: Use _multi variants
      drm/panel: ilitek-ili9805: Use dsi_multi in init
      drm/panel: ilitek-ili9805: make cleanup funcs void

Michal Wajdeczko (23):
      drm/xe/ggtt: Fix xe_ggtt documentation
      drm/xe/pcode: Don't ignore drmm_mutex_init failure
      drm/xe/mcr: Prefer GT-oriented WARN messages
      drm/xe/mmio: Verify MMIO is available
      drm/xe/mmio: Map MMIO BAR using managed version of pci_iomap
      drm/xe/mmio: Add check for minimal BAR size
      drm/xe/mmio: Drop tiles_fini action
      drm/xe/mmio: Check MMIO BAR size when initializing tiles
      drm/xe/mmio: Prefer tile-based WARN message
      drm/xe/pf: Don't attempt to process FAST_REQ or EVENT relays
      drm/xe/guc: Allow to print single KLV
      drm/xe/guc: Prepare to print group KLVs
      drm/xe/guc: Add basic KLV encoding helpers
      drm/xe/guc: Add string KLV encoding helper
      drm/xe/guc: Add object KLV encoding helper
      drm/xe/guc: Add KLV parsing helper
      drm/xe/guc: Formalize Reserved KLVs
      drm/xe/tests: Add GuC KLV helpers basic tests
      drm/xe/tests: Add string encoding helper test
      drm/xe/tests: Add object encoding helper test
      drm/xe/tests: Add GuC KLV printer test
      drm/xe/tests: Add migration packet test
      drm/xe/pf: Handle migration descriptor using KLV helpers

Micha=C5=82 Grzelak (3):
      drm/print: describe 6th & 9th bit of drm.debug
      drm/managed: fix drmm_add_action() kernel-doc
      drm/i915/dp_link_caps: s/lc/lce/

Micha=C5=82 Miros=C5=82aw (5):
      drm/amd/display/amdgpu_dm: show error names
      drm/amd/pm/smu7: make SMU message reports more readable
      drm/amd/pm/smu7: return error on message send failure
      drm/amd/amdgpu/cgs: Avoid redundant copying of firmware filename
      drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info

Mikhail Gavrilov (3):
      drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to drm_exec
      drm/amdgpu: fix recursive ww_mutex acquire in amdgpu_devcoredump_form=
at
      drm/amd/display: make DC_RUN_WITH_PREEMPTION_ENABLED misuse a build e=
rror

Mikko Perttunen (11):
      gpu: host1x: Wait for timeout worker completion on channel free
      gpu: host1x: Avoid double device_add when clients already present
      gpu: host1x: Fix offset calculation in trace_write_gather
      gpu: host1x: Avoid stack over-read in debug output helpers
      gpu: host1x: Change pin_job() return type to int
      gpu: host1x: Annotate intentional syncpoint wrap-around
      dt-bindings: display: tegra: Changes to support Tegra264
      dt-bindings: display: tegra: Add Tegra264 compatible for VIC
      gpu: host1x: Correctly parse linear ranges of context devices
      drm/tegra: falcon: Add support for RISC-V external boot
      drm/tegra: vic: Add Tegra264 support

Mitul Golani (1):
      drm/i915/display: Program TRANS_VTOTAL from mode vtotal

Muhammad Bilal (1):
      accel/rocket: fix NULL dereference and integer overflow in
rocket_job_push()

Nareshkumar Gollakoti (6):
      drm/xe: add page size allocation control state to xe_device
      drm/xe/debugfs: add page-size allocation mode knob
      drm/xe: add XE_BO_FLAG_NEEDS_1G for minimum page-size sizing
      drm/xe: apply debug page-size allocation policy to user BOs
      drm/xe/pt: allow selecting the bind leaf PTE level
      drm/xe/tests: add live KUnit coverage for BO page-size allocation mod=
es

Natalie Vock (10):
      drm/amdgpu: Only set bo->moved when the BO was actually moved
      drm/amdgpu: Rename moved state to needs_update
      MAINTAINERS: Update Natalie Vock's email
      cgroup/dmem: Add queries for protection values
      cgroup,cgroup/dmem: Add (dmem_)cgroup_common_ancestor helper
      drm/ttm: Extract code for attempting allocation in a place
      drm/ttm: Split cgroup charge and resource allocation
      drm/ttm: Be more aggressive when allocating below protection limit
      drm/ttm: Use common ancestor of evictor and evictee as limit pool
      drm/nouveau: Wire up dmem cgroups

Nathan Lucas (2):
      drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
      drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE

Neil Armstrong (3):
      dt-bindings: display: panel: document the Renesas R63419 based
dual-DSI video mode Display Panels
      drm/panel: visionox-vtdr6130: switch to devm panel calls and drop rem=
ove
      drm: fix missing header include for drm_panel_put()

Nemesa Garg (4):
      drm/dp: Add DP_DSC_MAX_BPP_DELTA register
      drm/dp: Rename YCbCr420 bpp delta mask to native
      drm/dp: Add max bpp delta computation constants
      drm/i915/dp: Decode dsc max delta bpp from sink dpcd

Nicholas Carbones (1):
      drm/amd/display: Correct vblank_end calc for fams cmd packet

Nicholas Kazlauskas (2):
      drm/amd/display: Add a new interface to set idle opts in clock manage=
r
      drm/amd/display: Exit LS for ISHARP before coefficient write

Nicolas Frattaroli (26):
      drm/display: hdmi-state-helper: Use default case for unsupported form=
ats
      drm: Add new general DRM property "color format"
      drm/connector: Let connectors have a say in their color format
      drm/display: bridge_connector: Use HDMI color format for HDMI conns
      drm/bridge: Act on the DRM color format property
      drm/atomic-helper: Add HDMI bridge output bus formats helper
      drm/display: hdmi-state-helper: Act on color format DRM property
      drm/display: hdmi-state-helper: Try subsampling in mode_valid
      drm/amdgpu: Implement "color format" DRM property
      drm/rockchip: Add YUV422 output mode constants for VOP2
      drm/rockchip: vop2: Add RK3576 to the RG swap special case
      drm/rockchip: vop2: Recognise 10-bit YUV422 as YUV format
      drm/rockchip: vop2: Set correct output format for RK3576 YUV422
      drm/bridge: dw-hdmi-qp: Use common HDMI output bus fmts helper
      drm/rockchip: dw_hdmi_qp: Implement "color format" DRM property
      drm/rockchip: dw_hdmi_qp: Set supported_formats platdata
      drm/connector: Register color format property on HDMI connectors
      drm/tests: hdmi: Add tests for the color_format property
      drm/tests: hdmi: Add tests for HDMI helper's mode_valid
      drm/tests: bridge: Add KUnit tests for bridge chain format selection
      drm/tests: bridge: Add test for HDMI output bus formats helper
      drm/bridge: Document bridge chain format selection
      drm/connector: Update docs of "colorspace" for color format prop
      drm/tests: Move test EDID data to separate .c file
      drm/connector: Fix epoch_counter docs to reflect reality
      drm: Send per-connector hotplug events

Nicol=C3=A1s Antinori (3):
      gpu: nova-core: vbios: parse structs via zerocopy
      drm/panel: novatek-nt37801: Use mipi_dsi_*_multi() functions
      drm/amdgpu: Inline drm_simple_encoder_init()

Nikita Zhandarovich (1):
      drm/i915/edp: Check supported link rates DPCD read

Niranjana Vishwanathapura (7):
      drm/xe/multi_queue: skip submit when primary queue is suspended
      drm/xe: only resume exec queues that were actually suspended
      drm/xe/guc: ban exec queue on suspend timeout
      drm/xe/guc: add uninterruptible suspend wait for cross-process cleanu=
p
      drm/xe/hw_engine_group: propagate suspend failures during mode switch
      drm/xe/multi_queue: preempt primary on queue group suspend
      drm/xe/multi_queue: wait for secondary's own suspend in suspend_wait

Nitin Gote (2):
      drm/xe/xe3: Apply Wa_16029380221 to media
      drm/xe: Hold a dma-buf reference for imported BOs

N=C3=ADcolas F. R. A. Prado (1):
      drm/amd/display: Always notify the HDA driver on connector disconnect

Osama Abdelkader (5):
      drm/panthor: return PTR_ERR() from devm_drm_dev_alloc()
      drm/bridge: tc358762: use devm for bridge registration and DSI attach
      drm/bridge: tc358764: use devm for bridge registration and DSI attach
      drm/panthor: harden firmware build-info bounds checks
      drm/panthor: fix firmware control interface bounds checks

Ovidiu Bunea (1):
      drm/amd/display: Temp disable repeater FGCG as workaround

Pan Chuang (1):
      drm/bridge: ti-sn65dsi86: Remove redundant dev_err_probe()

Paul Kocialkowski (2):
      drm: lcdif: Set undocumented bit to clear FIFO at vsync
      drm: lcdif: Wait for vblank before disabling DMA

Paul Louvel (2):
      dt-bindings: display: simple: Add Ampire AM-800480N3TZQW-00H
      drm/panel: simple: Add Ampire AM-800480N3TZQW-00H

Pavel Ondra=C4=8Dka (1):
      drm/radeon: fix r100_copy_blit for large BOs

Peichen Huang (1):
      drm/amd/display: correct encoder minimal creation

Pengpeng Hou (3):
      drm/virtio: fail init on display-info timeout
      drm/i915/gt: use correct selftest config symbol
      drm/amd/display: wire DCN42B mcache programming callback

Pengyu Luo (2):
      dt-bindings: display: panel: Add Novatek NT36536
      drm/panel: Add Novatek NT36536 panel driver

Perry Yuan (1):
      drm/amdgpu: flush pending RCU callbacks on module unload

Philip Yang (5):
      drm/amdkfd: Avoid topology_lock in kfd_mmap
      drm/amdkfd: Evict SVM BOs synchronously from TTM eviction
      drm/amdkfd: Remove svm_bo eviction fence
      drm/amdkfd: Add helper svm_range_update_checkpoint_timestamp
      drm/amdkfd: Unmap svm range from GPU set to no-access

Philipp Stanner (2):
      Documentation: drm: Add entry for removing spsc_queue to TODO list
      drm/sched: Remove relic from entity docu

Pierre-Eric Pelloux-Prayer (3):
      drm/amdgpu: add userq job and state transition trace events
      drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini
      drm/amdgpu: don't disable ttm buffer funcs on reset

Piotr Maziarz (1):
      drm/amd/display: Fix 4018 warning

Prike Liang (18):
      drm/amdgpu: allocate lockdep mutex on the heap to fix stack overflow
      drm/amdgpu: correct reservation fence slots for userq per-vm BOs evic=
tion
      drm/amdgpu: set the userq xcp_id
      drm/amdgpu: add userq create and destroy tracepoints
      drm/amdgpu: add the doorbell index input for suspending userq
      drm/amdgpu/mes11: set doorbell offset for suspending userq
      drm/amdgpu/mes12: set doorbell offset for suspending userq
      drm/amdgpu: add RS64 local memory context array init/fini
      drm/amdgpu/mes: add MES process/gang context size and bitmap helper
      drm/amdgpu: add mes process context alloc/free
      drm/amdgpu/mes11: get MES process/gang contex size
      drm/amdgpu: add mes gang contex alloc/free helper
      drm/amd/display: Fix DML file discovery for out-of-tree builds
      drm/amdgpu/mes: refactor the amdgpu_mes_alloc/free_proc|gang()
      drm/amdgpu/mes: tear down the rs64mem bitmap in sw_fini
      drm/amdkfd: enable rs64mem for kfd queue
      drm/amdgpu/mes11: enable MES process/gang load from MES local mem
      drm/amdgpu/mes11: disable MES RS64 process/gang context loading

Priya Hosur (4):
      drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting via VCLK level ind=
ex
      drm/amd/pm: add IP_VERSION(11,5,1) to vclk/dclk DPM sysfs whitelists
      drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in DPM frequency que=
ries
      drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM level marking

Qiang Yu (2):
      drm/amdgpu: initialize iter.start in amdgpu_devcoredump_format
      drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12

Raag Jadav (9):
      drm/xe/drm_ras: Make counter allocation drm managed
      drm/xe/drm_ras: Add per node cleanup action
      drm/xe/hw_error: Use HW_ERR prefix in log
      drm/xe/hw_error: Defeature hardware error handling with system contro=
ller
      drm/xe/i2c: Drop manual VF check
      drm/xe/i2c: Allow per domain unique id
      drm/xe/ras: Fix boot-time ras error processing
      drm/xe/drm_ras: Move has_drm_ras check to drm_ras layer
      drm/xe: Fix xe_device_probe() failure

Rafael Passos (1):
      drm/xe: Documentation: fix chars used for subsection

Rafal Ostrowski (3):
      drm/amd/display: Introduce dc_plane_cm and migrate surface
update color path
      drm/amd/display: Refactor surface_update_flags to flat struct with he=
lpers
      drm/amd/display: Migrate color manager HW and fix MCM blend LUT issue=
s

Randolph Sapp (1):
      drm/etnaviv: force flush on power register ops

Randy Dunlap (2):
      drm/amdgpu: drop kernel-doc for deleted struct fields
      drm/amdkfd: kfd_ioctl.h: fix most kernel-doc warnings

Ray Wu (3):
      drm/amd/display: Increase HDMI AV mute wait from 2 to 3 frames
      drm/amd/display: Add AV mute wait frames to dce110_set_avmute
      drm/amd/display: Check for tg ops in dce110_set_avmute

Relja Vojvodic (4):
      drm/amd/display: Update link bw
      drm/amd/display: Fix force FRL rate debug setting
      drm/amd/display: switch max FFE level cap based on FRL link rate
      drm/amd/display: Add FFE level defaults

Riana Tauro (17):
      drm/xe/uapi: Add additional error components to xe drm_ras
      drm/xe/xe_ras: Add support to get error counter value
      drm/xe/xe_ras: Add support to clear error counter value
      drm/xe/xe_drm_ras: Wire get and clear counter callbacks
      drm/xe: Move xe drm_ras initialization
      drm/xe/xe_ras: Add drm_ras feature flag
      drm/xe/xe_pci_error: Implement PCI error recovery callbacks
      drm/xe/xe_pci_error: Group all devres to release them on PCIe slot re=
set
      drm/xe: Skip device access during PCI error recovery
      drm/xe/xe_ras: Initialize Uncorrectable AER Registers
      drm/xe/xe_sysctrl: Make sysctrl flood limit reusable
      drm/xe/xe_ras: Add support for uncorrectable core-compute errors
      drm/xe/xe_ras: Query errors from system controller on probe
      drm/xe/xe_pci_error: Process errors in mmio_enabled
      drm/xe/xe_survivability: Decouple survivability info from boot
survivability
      drm/xe/xe_ras: Handle uncorrectable SoC Internal errors
      drm/xe/xe_ras: Add support to query device memory errors

Rob Herring (Arm) (1):
      accel: ethosu: Add performance counter support

Robert Mader (1):
      dma-buf/udmabuf: Disable the size limit by default

Robert-Andrei Mercea (1):
      drm/panel: osd101t2587: migrate to newer mipi_dsi* functions

Robin Chen (2):
      drm/amd/display: Add PSR Active VTotal Control capability
      drm/amd/display: fix debug flags assignment in dmub_replay.c

Rodrigo Vivi (5):
      drm/xe: improve Kconfig.profile help text for scheduler timeouts
      drm/xe: fix job timeout recovery for unstarted jobs and kernel queues
      drm/xe/lrc: fix spurious warning when reading context timestamp
      drm/xe: wedge from the timeout handler only after releasing the queue
      Merge drm/drm-next into drm-xe-next

Roman Li (3):
      drm/amd/display: Skip PHY SSC reduction on some 8K panels
      drm/amdgpu/discovery: Fix device family for DCN42
      drm/amd/display: Remove duplicate in tests/Makefile

Ruijing Dong (1):
      drm/amdgpu: enumerate UMSCH HW IP

Ruoyu Wang (1):
      drm/radeon: avoid double free in r600 DPM cleanup

Ryosuke Yasuoka (1):
      drm/virtio: abort virtqueue wait on device removal to avoid hung task

Sami Tolvanen (2):
      rust: drm: gpuvm: require Send + Sync for the driver's associated dat=
a
      rust: drm: gpuvm: implement Send and Sync for GpuVaAlloc and GpuVmBo

Samuel Pitoiset (1):
      drm/amd/display: Fix NULL pointer dereference in
amdgpu_dm_crtc_set_vblank()

Samuel Zhang (1):
      drm/amd: add AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU debug mask

Sanjay Yadav (1):
      drm/xe/migrate: Revamp PAT index selection for migrate PTEs

Santhosh, Ashwin (1):
      drm/amd/display: Promote DC to 3.2.391

Santosh BS (1):
      gpu: host1x: Add Tegra264 support

Satyanarayana K V P (2):
      drm/xe/pf: Disable display in admin only PF mode
      drm/xe/vf: Add drm_dev guards when detaching CCS read/write buffers

Sean Paul (2):
      drm/i915/color: Fix step discontinuity in Post-CSC Gamma LUT
      drm/i915/color: Fix step discontinuity in Pre-CSC Gamma LUT

Shahyan Soltani (8):
      dma_buf: change unsigned int and int types into size_t
      drm/amdgpu: move struct amdgpu_wb and helpers into separate files
      drm/amdgpu: move struct amdgpu_video_codecs and helpers into header f=
ile
      drm/amdgpu: move struct amdgpu_mqd and helpers into header file
      drm/amdgpu: move amdgpu_acpi helpers into new header
      drm/amdgpu: move amdgpu_allowed_register_entry into amdgpu_reg_access=
.h
      drm/amdgpu: include amdgpu_video_codecs.h only where needed
      drm/amdgpu: fix lifetime issue of amdgpu_vm_get_task_info_pasid()

Shaoyun Liu (1):
      drm/amd/amdgpu/include : update mes api header v11/v12

Shikang Fan (1):
      drm/amdkfd: preserve VRAM MQD across hibernation via unpin/repin

Shubhankar Milind Sardeshpande (6):
      drm/amd/pm: re-enable MC access after PrepareMp1ForUnload on SMU V15 =
APUs
      drm/amdgpu: Enable support for PSP 15_0_5
      drm/amdgpu: Fix NBIO 7.11.5 offsets
      drm/amd/pm/smu15: add metrics table header for SMU v15.0.0
      drm/amd/pm/smu15: switch SMU v15.0.0 to DRAM-based accumulator metric=
s
      drm/amdgpu: Enable GFXOFF functionality for SMU IP v15.0.5

Shuicheng Lin (9):
      drm/xe/userptr: Hold notifier_lock for write on inject test path
      drm/xe/userptr: Drop bogus static from finish in force_invalidate
      drm/xe/hw_engine: Fix double-free of managed BO in error path
      drm/xe/userptr: Stub notifier_lock helpers when DRM_GPUSVM=3Dn
      drm/xe/configfs: Add enable_multi_queue attribute
      drm/xe: Use xe_tile_info() in alloc_primary_gt() and alloc_media_gt()
      drm/xe/vm: Fix SVM leak on resv obj alloc failure in xe_vm_create()
      drm/xe/vm: Remove redundant INIT_WORK() for rebind_work in xe_vm_crea=
te()
      drm/xe/vm: Use regular comment for GSC VM lockdep note in xe_vm_creat=
e()

Shuvam Pandey (1):
      accel/rocket: initialize job domain before cleanup paths

Sk Anirban (2):
      drm/xe/guc: distinguish wedged from recoverable cancellation
      drm/xe/guc: fix activity stats error message format

Soham Purkait (1):
      drm/xe/xe_ras: Add RAS GPU health indicator

Srinivasan Shanmugam (10):
      drm/amdgpu/powerplay: Align get_tonga_state_array() header with proto=
type
      drm/amdgpu/mes12: Remove MES self test
      drm/amd/display: Check dc_link before applying DSC policy
      drm/amdkfd: Do not fail process debugfs setup on debugfs errors
      drm/amd/display: Run FP-disabled MST stub test only without DC FP
      drm/amdgpu/gfx9.4.3: Fix MEC rollback loop in EOP IRQ setup
      drm/amdgpu: Allow PASID allocator to store fpriv owner
      drm/amdgpu: Resolve VM through DRM PASID ownership
      drm/amdgpu: Drop vm_manager PASID to VM mapping
      drm/amdgpu: Add missing MES helper parameter descriptions

Stanley.Yang (3):
      drm/amdgpu/ras: Resum RAS IP hw init during nps dynamic switch
      drm/amdgpu/ras: only check bad page for address-based UMC injection
      drm/amdgpu/ras: use vram_base_offset for UMC inject address

Sudarshan Shetty (1):
      drm: bridge: ti-sn65dsi83: Remove NO_HFP and NO_HBP mode flags
for LVDS stability

Sung-huai Wang (1):
      drm/amd/display: Increase fclk change latency on dcn351

Sunil Khatri (2):
      drm/amdgpu: do not release the root bo after vm validate
      drm/amdgpu: dont pin wptr bo instead use eviction fence

Suraj Kandpal (6):
      drm/i915/cx0: Remove unnecessary hdmi link rate function declaration
      drm/i915/ltphy: Readout ssc_enabled for LT PHY
      drm/i915/ltphy: Fix SSC Enablement bit in PORT_CLOCK_CTL
      drm/i915/display: Skip TRANS_VTOTAL.Vtotal write on NVL pre-C0
      drm/i915/backlight: Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check
for DPCD backlight
      drm/i915/hdcp: Make hdcp2_encrypted and hdcp_encrypted mutually exclu=
sive

Suresh Guttula (2):
      drm/amdgpu: Disable JDPG on VCN5_3
      drm/amdgpu : update mmhub eco sec lvl for vcn5_3

Svyatoslav Ryhel (2):
      drm/tegra: dsi: Add support for Tegra20/Tegra30
      drm/tegra: dsi: Re-add clear enable register if DSI was powered
by bootloader

Taimur Hassan (10):
      drm/amd/display: Promote DC to 3.2.385
      drm/amd/display: [FW Promotion] Release 0.1.63.0
      drm/amd/display: Promote DC to 3.2.386
      drm/amd/display: [FW Promotion] Release 0.1.64.0
      drm/amd/display: Promote DC to 3.2.387
      drm/amd/display: Promote DC to 3.2.388
      drm/amd/display: Promote DC to 3.2.389
      drm/amd/display: Promote DC to 3.2.390
      drm/amd/display: Add missing DMUB CACP and PR definitions
      drm/amd/display: Promote DC to 3.2.392

Tangudu Tilak Tirumalesh (5):
      Revert "drm/xe: Skip exec queue schedule toggle if queue is idle
during suspend"
      drm/xe: Clear pending_disable before signaling suspend fence
      drm/xe: explicit TLB flush for context based tlb invalidation
      drm/xe: include all registered queues in TLB invalidation
      drm/xe: drop unused xe_exec_queue_ops::active callback

Tao Zhou (6):
      drm/amd/ras: send RMA event in RAS init stage
      drm/amd/ras: update flip bit setting for uniras
      drm/amd/ras: detect old ras eeprom format
      drm/amd/ras: move some umc v12 specific functions to ras_umc.c
      drm/amd/ras: add get_die_id for uniras umc v12
      drm/amd/ras: Handle the lack of mca address case for uniras

Teguh Sobirin (1):
      drm/panel: Add panel driver for Chipone ICNA35XX based panels

Tejas Upadhyay (3):
      drm/xe/guc: Fix buffer overflow in steered register list allocation
      drm/gpu: Add gpu_buddy_allocated_addr_to_block helper
      gpu/tests/gpu_buddy: Add KUnit test for gpu_buddy_allocated_addr_to_b=
lock

Terry Hsiao (3):
      drm/panel-edp: Add AUO B116XAT04.3, CMN N116BCP-EA2, CSW MNB601LS1-8
      drm/panel-edp: Add BOE NV116WH2-M30, BOE NT116WHM-N21, BOE
NV116FH1-M31, BOE NV116FH1-M30
      drm/panel-edp: Add CMN N116BCP-EA2 (HW: C3)

Thadeu Lima de Souza Cascardo (2):
      cgroup/dmem: introduce a peak file
      drm/amdgpu: initialize irq.lock spinlock earlier

Thierry Reding (1):
      drm/panel: Use drm_of_get_panel_orientation()

Thomas Hellstr=C3=B6m (10):
      Merge drm/drm-next into drm-xe-next
      drm/xe/rtp: Fix build error with clang < 21 and non-const initializer=
s
      drm/xe: Fix wa_oob codegen recipe for external module builds
      drm/xe/guc: Add suspend refcount to exec queue ops
      drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
      cgroup/dmem: Introduce struct dmem_cgroup_init for region initializat=
ion
      cgroup/dmem: Add reclaim callback for lowering max below current usag=
e
      drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem control=
ler
      drm/xe: Wire up dmem cgroup reclaim for VRAM manager
      drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

Thomas Zimmermann (21):
      lib/fonts: Look up glyph data with font_data_glyph_buf()
      drm/client: log: Look up glyph shape with font helper
      drm/panic: Look up glyph shape with font helper
      drm/draw: Remove unused helper drm_draw_get_char_bitmap()
      drm/hibmc: Use drm_atomic_helper_check_plane_state()
      drm/hibmc: Fix list of formats on the primary plane
      drm/hibmc: Store fb in variable in atomic_update
      drm/hibmc: Do not use cpp from struct drm_format_info
      drm/hibmc: Verify the framebuffer pitch to be a multiple of 128
      drm/hibmc: Use gem-shmem with shadow-plane helpers for memory managem=
ent
      Merge drm/drm-next into drm-misc-next
      firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as deprecated
      drm/sysfb: simpledrm: Improve framebuffer-size validation
      drm/sysfb: simpledrm: Improve panel-size validation
      drm/sysfb: simpledrm: Inline simplefb_get_validated_int()
      drm/sysfb: simpledrm: Improve stride validation
      drm/sysfb: simpledrm: Validate mmap size against framebuffer size
      drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips
      Merge drm/drm-next into drm-misc-next
      drm/of: Implement drm_of_get_panel_orientation()
      drm/sysfb: simpledrm: Read panel orientation from DT node

Thorsten Blum (2):
      dma-buf: heaps: use max3 in dma_heap_ioctl
      drm/bridge: sii902x: inline i2c_check_functionality check

Tiago Dourado (2):
      drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
      drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

Tim Kovalenko (1):
      gpu: nova-core: falcon: store bar and dev in falcon

Timur Krist=C3=B3f (60):
      drm/amd/display: Add detect reason to handle_hpd_irq_helper
      drm/amd/display: Use handle_hpd_irq_helper for HPD RX
      drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr function=
s
      drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GT=
T
      drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
      drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU segment when
it isn't at 0 (v2)
      amdgpu/ih6.1: Fix minor version
      drm/amdgpu: Use system unbound workqueue for soft IH ring
      drm/amdgpu: Clarify name of soft recovery to avoid confusion
      drm/amdgpu: Clean up defunct soft reset from ASIC reset code path
      drm/amdgpu: Delete GMC 8 soft reset
      drm/amdgpu: Delete soft reset code from legacy display driver
      drm/amdgpu: Delete check_soft_reset() from amd_ip_funcs
      drm/amdgpu: Delete pre/post_soft_reset() from amd_ip_funcs
      drm/amdgpu: Add IP block soft reset as a GPU recovery method
      drm/amdgpu/gfx8: Stop CP and RLC during reset
      drm/amdgpu/gfx8: Return error when testing all rings
      drm/amdgpu/gfx8: Support COND_EXEC on compute rings
      drm/amdgpu/gfx8: Adjust EDC GPR workaround
      drm/amdgpu/gfx8: Fixup IP block soft reset
      drm/amdgpu/gfx8: Enable IP block soft reset as a GPU recovery method
      drm/amdgpu: Simplify filtering rings during IP block soft reset
      drm/amdgpu: Fix typos in comments for IP block soft reset
      drm/amd/display: Fix preferred link rate for NUTMEG
      drm/amd/display: Add dp_skip_rbr flag for NUTMEG
      drm/amdgpu: Print vmid, pasid and more task info in devcoredump
      drm/amdgpu: Reserve space for IB contents in devcoredumps
      drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)
      drm/amd/display: Set native cursor mode for disabled CRTCs
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initializ=
ed
      drm/amd/pm/si: Fix AC/DC switch notification
      drm/amdgpu: Fix IP block NULL check during soft reset
      drm/amd/pm/smu7: Fix AC/DC switch notification
      drm/amdgpu/ttm: Consider concurrent VM flushes for buffer entities
      drm/fourcc: Add modifiers for AMD GFX6-8
      drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
      drm/amd/display: Support DRM format modifiers on GFX6-8
      drm/amd/display: Don't use tiling flags anymore
      drm/amdgpu/ttm: Use more optimal copy packet sizes for copy and fill
      drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable on GFX7
      drm/amdgpu/gfx7: Refactor MQD initialization and finalization
      drm/amdgpu/gfx7: Return error code when compute ring tests fail
      drm/amdgpu/gfx7: Return error code when failing to start GFX ring
      drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
      drm/amdgpu/gfx7: Clean up gfx ring during reset
      drm/amdgpu/gfx7: Use COND_EXEC
      drm/amdgpu/gfx7: Fixup IP block soft reset
      drm/amdgpu/gfx7: Enable IP block soft reset as a GPU recovery method
      drm/amdgpu/gfx6: Fixup emit_cntxcntl()
      drm/amdgpu/gfx6: Fixup emitting SWITCH_BUFFER packets
      drm/amdgpu/gfx6: Use PFP on the compute queues too
      drm/amdgpu/gfx6: Initialize compute rings before CP start
      drm/amdgpu/gfx6: Clean up rings during reset
      drm/amdgpu/gfx6: Execute CLEAR_STATE when initializing compute rings
      drm/amdgpu/gfx6: Adjust how harvested TCCs are set up
      drm/amdgpu/gfx6: Use COND_EXEC
      drm/amdgpu/gfx6: Add IP block soft reset implementation
      drm/amdgpu/gfx6: Enable IP block soft reset as a GPU recovery method
      drm/amd/display: Set native cursor mode for disabled CRTCs again
      drm/amd/display: Fix crash in hwss_set_output_transfer_func()

Timur Tabi (8):
      rust: alloc: add Vec::zeroed method
      rust: firmware: add request_into_buf()
      gpu: nova-core: add TLV parser for firmware files
      gpu: nova-core: transition booter to TLV images
      gpu: nova-core: transition gsp to TLV images
      gpu: nova-core: transition gen_bootloader to TLV images
      gpu: nova-core: transition fsp to TLV images
      gpu: nova-core: update firmware module info for TLV images

Tom Chung (1):
      drm/amd/display: Tear down dangling pipe on boot to fix s0i3

Tomasz Siemek (4):
      drm/amd/display: Drop CONFIG_DRM_AMD_DC_DCN4_2 from 3dlut code
      drm/amd/display: Refactor DPP_PROGRAM_GAMUT_REMAP to drop pipe_ctx pa=
ram
      drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC to drop pipe_c=
tx
      drm/amd/display: Use current mpc pipe in set output transfer func

Travis K. Bangs (1):
      drm/amd: Disable DP audio spread spectrum for Cyan Skillfish

Tvrtko Ursulin (19):
      drm/sched: Remove redundant entity->rq initialization and checks
      drm/amdgpu: Fix context pstate override handling
      drm/amdgpu: Remove arbitrary number of contexts limitation
      drm/amdgpu: Consolidate ctx put
      drm/amdgpu: Remove live context error log and skip
      drm/amdgpu: Simplify amdgpu_ctx_get_stable_pstate()
      drm/amdgpu: Convert context manager to xarray
      drm/amdgpu: Clarify odd behaviour of AMDGPU_CTX_OP_GET_STABLE_PSTATE
      drm/amdgpu: Choose SOC15 RLC register read write functions at init ti=
me
      drm/amdgpu: Only calculate register offset once in SOC15 RLC
      drm/nouveau: Simplify nouveau_cli_work
      drm/amdgpu: Drop support for variable struct drm_amdgpu_bo_list_entry=
 size
      drm/amdgpu: Remove the bo list mutex
      drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
      drm/amdgpu: Remove output parameter in bo list handling
      drm/amdgpu: Remove unused amdgpu_device_ip_is_hw
      drm/amdgpu: Save some cycles on the job submission path
      drm/amdgpu: Do not fiddle with the idle workers too much
      drm/panthor: Remove redundant drm_sched_job_cleanup() from the
.free_job callback

Ulisses Paixao (1):
      drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12

Uma Shankar (2):
      drm/i915/dram: Interpret 0xF populated-channel count as 16
      drm/i915/bw: Update bw calculation to account for 16 channels

Uwe Kleine-K=C3=B6nig (1):
      drm/radeon: Only define radeon_acpi_vfct_match when actually used

Uwe Kleine-K=C3=B6nig (The Capable Hub) (7):
      drm: Consistently define pci_device_ids using named initializers
      drm/amdgpu: Don't use UTS_RELEASE directly
      drm/hyperv: Unregister pci driver in error path before module unload
      drm/hyperv: Explicitly set subvendor and subdevice for pci match arra=
y
      drm/hyperv: Move MODULE_DEVICE_TABLE to the device_id arrays
      drm/bridge: Use named initializers for arrays of i2c_device_data
      drm/amdgpu: Consistently define pci_device_ids using named initialize=
rs

Venkat Rao Bagalkote (1):
      drm/amd/display: Shorten KUnit exported symbol names

Victor Skvortsov (1):
      drm/amdgpu: Disable ras_check_bad_page_status on VFs

Victor Zhao (3):
      drm/amdgpu: add generic interfaces for PTL requests in virtualization
      drm/amdgpu: always get PTL state from PSP under sriov
      drm/amdgpu: convert ptl_hw_supported to enum

Vidya Srinivas (1):
      drm/i915/display: Fix NV12 ceiling division for bigjoiner case

Ville Syrj=C3=A4l=C3=A4 (44):
      drm/i915/de: Remove the 2 usec fast timeout
      drm/i915/bw: Don't memcpy() pointlessly
      drm/i915/bw: Streamline dg2_get_bw_info()
      drm/i915/bw: Initialize num_planes sensibly for the first plane
group in TGL+
      drm/i915/bw: Move 'bi_next' to tighter scope
      drn/i915/bw: s/num_points/num_qgv_points/
      drm/i915/bw: Move num_{qgv,psf}_points out from the plane group
      drm/i915/bw: Move psf_bw[] out from the plane group
      drm/i915/bw: Move peakbw[] out from the plane group
      drm/i915/bw: Print derated bandwidth numbers for DG2
      drm/i915/bw: Use icl_qgv_bw()
      drm/i915/bw: Simplify the best max_data_rate search
      drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enabl=
e
      drm/i915/cdclk: Print the reason for the CDCLK sanitization
      drm/i915/cdclk: Clean up CDCLK_CTL defines
      drm/i915/cdclk: Document CDCLK_CTL bits
      drm/i915/cdclk: Introduce bxt_cdclk_cd2x_pipe_mask() and use it
      drm/i915/cdclk: Use the TGL+ CD2x pipe select bits also on ICL
      drm/i915/panel: Split VRR vs. fixed refresh rate fixed mode
selection into separate stages
      drm/modes: Add DRM_MODE_MATCH_TIMINGS_VRR
      drm/i915: Pass the full atomic state to .compute_config()
      drm/i915/panel: Adjust intel_panel_compute_config() calling conventio=
n
      drm/i915/panel: Attempt VRR based refresh rate change for !allow_mode=
set
      drm/i915/gmbus: Rename GPIO pins
      drm/i915/gmbus: s/gmbus_pins_bdw/gmbus_pins_lpt/
      drm/i915/gmbus: Add gmbus_pins_lpt_lp[]
      drm/i915/gmbus: s/gmbus_pins_skl/gmbus_pins_spt/
      drm/i915/gmbus: Drop the platform suffixes from GMBUS pins
      drm/i915/hdmi: Remove CNP port F leftovers
      drm/i915: Disable the plane if initial plane config readout failed
      drm/i915/fbdev: Extract bios_fb_ok()
      drm/i915: Throw away the BIOS fb if has the wrong depth/bpp
      drm/i915: Use drm_dbg_kms() for initial FB debugs
      drm/xe: Do the initial FB size alignment earlier
      drm/xe: Print a debug message if we have no stolen for the initial FB
      drm/xe: Abstract the initial FB PTE checks a bit
      drm/xe: Check the PTE local memory bit for initial FB in stolen
      drm/xe: s/bar2/lmembar/
      drm/i915: Fix BIOS FB memory region name debug prints
      drm/i915: Print the phys_base in addition to the dma_addr for the BIO=
S FB
      drm/i915/cdclk: Use intel_cdclk_ppc() in intel_modeset_readout_hw_sta=
te()
      drm/i915/cdclk: Introduce HAS_2PPC()
      drm/i915/cdclk: Introduce crtc_state->pixel_rate_cdclk
      drm/i915/cdclk: Deal with 2 PPC hscale issues when calculating min CD=
CLK

Vinay Belgaumkar (1):
      drm/xe: Fix a bug in pc_adjust_freq_bounds()

Vinod Govindapillai (11):
      drm/i915/display: update to the BW buddy configuration
      drm/i915/wm: clear the plane ddb_y entries on plane disable
      drm/i915/pm_demand: introduce HAS_PMDEMAND macro
      drm/i915/display: sagv pre/post plane calls to check pmdemand support
      drm/i915/bw: Extract icl_init_qgv_info()
      drm/i915/bw: extract update_sagv_status()
      drm/i915/bw: avoid replicating the update_sagv_status() calls
      drm/i915/bw: introduce the peak bandwidth threshold
      drm/xe/display: Expose plane max width/height helpers to global scope
      drm/i915/fbc: No need of any hardcoded plane width limit from LNL+
      drm/i915/fbc: No surface size restrictions from LNL onwards

Violet Monti (3):
      drm/xe/rtp: Ensure gt_was doesn't evaluate rules with engine types
      drm/xe/rtp: Ensure oob_was does not evaluate engine type rules
      drm/xe/rtp: Ensure device_oob_was only evaluates correct rules

Vitaly Prosyak (1):
      drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init

Vitor Soares (1):
      dt-bindings: vendor-prefixes: Add Riverdi

Vladimir Marioukhine (1):
      drm/amdkfd: fix QID bit leak in pqm_create_queue()

Wang Jiang (1):
      drm/radeon: restore hardware polling in fence_is_signaled to fix
performance regression

Wayne Lin (4):
      drm/amd/display: Add SPL UPSP upsampling and YUV422 scaling support
      drm/amd/display: Add missing OTG_CRC1_SELECT mask for DCN3.2
      drm/amd/display: Fix CRC engine 1 enable/disable on DCN3.1.2+
      drm/amd/display: Configure all CRC engines in pipe CRC source path

Weiji Wang (1):
      drm/panel-edp: Add BOE NE140QDM-NX2

WenTao Liang (2):
      drm/amd/display: detect_link_and_local_sink: DP alt mode timeout
path leaks prev_sink reference
      drm/amd/display: set new_stream to NULL after release

Wenjing Liu (11):
      drm/amd/display: Add utm_qos_model pointer to clk_bw_params
      drm/amd/display: Remove get_utm_qos_model from soc_and_ip_translator
      drm/amd/display: Remove unused project_id from DML2 core instance
      drm/amd/display: Replace repeated no-native-i2c checks with
force_i2c_over_aux field
      drm/amd/display: Introduce dc_probe public object model
      drm/amd/display: Introduce dc_update_state unified commit interface
      drm/amd/display: Refactor dc_validation_set array into single root st=
ruct
      drm/amd/display: Introduce dc_state_get_status unified status accesso=
r
      drm/amd/display: Introduce program_perfmon hwss hook and BLS
perfmon sequence
      drm/amd/display: Wire probe commit path into dc_update_state
      drm/amd/display: Make dc_state_update const in commit path

Wentao Liang (2):
      drm/xe: fix refcount leak in xe_range_fence_insert()
      drm/sun4i: fix refcount leak in sun4i_backend_init_sat()

Werner Sembach (2):
      drm/amd/display: Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check
      drm/amd/display: Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check

Will Aitken (1):
      drm/amdgpu: Use just sriov capability bit for xgmi ext peer link supp=
ort

William Palacek (5):
      drm/amdkfd: use scnprintf/vscnprintf in kfd_smi_event_add
      drm/amdkfd: Add bounds check for CRAT subtype length
      drm/amdkfd: fix uint32_t overflow in EOP ring buffer size alignment
      drm/amdkfd: hold event_mutex while checkpointing CRIU events
      drm/amdkfd: allow CWSR grace period of 0 on supported firmware

Wolfram Sang (1):
      drm/bridge: remove unneeded 'fast_io' parameter in regmap_config

Xiang Liu (6):
      drm/amd/ras: Sync bad page count on EEPROM update
      drm/amdgpu: dump RAS EEPROM table via debugfs
      drm/amdgpu: protect XCP scheduler selection
      drm/amd/pm: Guard VBIOS AC timing table walk
      drm/amd/ras: initialize CPER after XGMI reset on init
      drm/amd/ras: track debug mode for query mode

Xiaogang Chen (4):
      drm/amdkfd: Let driver decide buffer size at
AMDKFD_IOC_GET_DMABUF_INFO ioctl
      drm/amdkfd: check find_first_zero_bit before __set_bit on
kfd->doorbell_bitmap
      drm/amdkfd: Use memdup_array_user to copy data from/to user
space at kfd ioctls
      drm/amdkfd: Guard m->cp_hqd_eop_control setting by q->eop_ring_buffer=
_size

Xilin Wu (1):
      dt-bindings: vendor-prefixes: Add AYN Technologies

Xin Wang (1):
      drm/xe/query: Avoid global forcewake in cycle query path

Yang Wang (23):
      drm/amd/pm: make pp_features read-only when scpm is enabled
      drm/amd/pm: fix amdgpu_pm_info power display units
      drm/amd/pm: Validate pp_table header before reading size
      drm/amd/pm: Use uploaded size for legacy custom PPTable
      drm/amd/pm: Validate Tonga PowerPlay state array bounds
      drm/amd/pm: Validate Vega hwmgr PowerPlay table bounds
      drm/amd/pm: Validate legacy hwmgr PP table offsets
      drm/amd/pm: Validate Vega10 PPTable subtable bounds
      drm/amd/pm: Validate Tonga PPTable subtable bounds
      drm/amd/pm: drop unused smu pptable callbacks
      drm/amd/pm: fix smu13 power limit range calculation
      drm/amd/pm: fix smu14 power limit range calculation
      drm/amd/pm: fix pptable use-after-free
      drm/amd/pm: fix torn gpu metrics reads
      drm/amd/pm: use milliwatts for GPU power sensors
      drm/amd/pm: hide pp_table sysfs on APUs
      drm/amd/pm: derive stable PPT limits from PPTable
      drm/amd/pm: refactor PPT limits by controller and power source
      drm/amd/pm: account for OD percentage in effective PPT limits
      drm/amd/pm: refactor user PPT policy save and restore
      drm/amd/pm: restore user PPT limits after GPU reset
      drm/amdgpu: check ASPM on the dGPU host link
      drm/amdgpu: fix nbif 6.3.1 l1 low power not functional

YiPeng Chai (4):
      drm/amdgpu: add bounds check to prevent array overflow
      drm/amd/ras: use IS_ERR() to check thread creation result
      drm/amd/ras: rename rascore directory to core
      drm/amd/ras: rename core ras_* files and update include guards

Yicong Hui (1):
      drm: Remove unused header in drm_dumb_buffers.c

Yifan Zhang (2):
      drm/amdgpu: add ioctl to handle RAS poison error
      drm/amdgpu: skip BOs being torn down during GTT recovery

Yilin Chen (1):
      rust: drm: fix GEM object pointer safety docs

Yongqiang Sun (6):
      drm/amdkfd: remove obsolete events page mmap support
      drm/amdkfd: remove dead kernel-allocated signal page code
      drm/amdkfd: drop struct kfd_signal_page wrapper
      drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to BO size
      drm/amdkfd: use node XCC count for v9 CRIU control stack restore
      drm/amdkfd: fix 32-bit overflow in CWSR total size calculation

Younes Akhouayri (1):
      rust: drm: Fix typo in FEAT_RENDER documentation

Yunxiang Li (2):
      drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free
      drm/amdgpu: skip already suspended IP blocks in ip_suspend_phase2

Zhan Wei (1):
      drm/xe/hwmon: document DG2 fan speed reporting quirk

Zhanjun Dong (1):
      drm/xe/guc: Handle GuC local uncorrectable error notifications

ZhaoJinming (1):
      accel/rocket: Fix error path handling in rocket_job_run()

Zhi Wang (12):
      gpu: nova-core: factor out common FSP message header
      gpu: nova-core: return FSP response buffer to caller
      gpu: nova-core: add FSP and PRC protocol documentation
      gpu: nova-core: consolidate GSP boot parameters into GspBootContext
      gpu: nova-core: fsp: rename FSP response header type
      gpu: nova-core: build SetRegistry entries dynamically
      PCI/IOV: Return unsigned int from pci_sriov_get_totalvfs()
      rust: pci: add sriov_get_totalvfs() helper
      gpu: nova-core: read vGPU mode from FSP via PRC protocol
      gpu: nova-core: detect and store vGPU state
      gpu: nova-core: set RMSetSriovMode for vGPU
      gpu: nova-core: reserve vGPU WPR2 heap

Zhu Lingshan (5):
      drm/amdgpu: implement per-process MES context
      drm/amdgpu: reject mapping a reserved doorbell to a new queue
      amdkfd: properly free secondary context id
      drm/amdkfd: expose pasid of secondary contexts by debugfs
      drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

Ziran Zhang (1):
      drm/amd/display: Remove redundant NULL check before kfree() in
mod_power_create()

Zongyao Bai (1):
      drm/xe/pt: Reset current_op in xe_pt_update_ops_init()

chong li (1):
      drm/amdgpu: reduce early full GPU access during SR-IOV init

geomcrae_amdeng (1):
      drm/amdgpu: clean up discovery and preempt sysfs entries on shutdown

yanglinlin (1):
      drm/amd/display: fix __udivdi3 link error

 .clang-format                                      |     2 +-
 .mailmap                                           |     4 +-
 .../ABI/testing/sysfs-driver-intel-xe-hwmon        |     7 +
 .../ABI/testing/sysfs-driver-intel-xe-ras          |    30 +
 Documentation/admin-guide/cgroup-v2.rst            |     6 +
 .../bindings/display/bridge/renesas,dsi.yaml       |     1 +
 .../display/bridge/renesas,r9a08g046-lvds.yaml     |   120 +
 .../bindings/display/mediatek/mediatek,cec.yaml    |    11 +-
 .../bindings/display/panel/anbernic,td4310.yaml    |    66 +
 .../bindings/display/panel/chipone,icna3512.yaml   |    79 +
 .../bindings/display/panel/himax,hx83121a.yaml     |     3 +
 .../bindings/display/panel/ilitek,ili7807s.yaml    |    71 +
 .../bindings/display/panel/ilitek,ili9488.yaml     |    63 +
 .../bindings/display/panel/jadard,jd9365da-h3.yaml |     1 +
 .../bindings/display/panel/novatek,nt36536.yaml    |    91 +
 .../bindings/display/panel/panel-lvds.yaml         |     2 +
 .../bindings/display/panel/panel-simple.yaml       |     2 +
 .../bindings/display/panel/renesas,r63419.yaml     |    98 +
 .../display/panel/rocktech,jh057n00900.yaml        |     2 +
 .../bindings/display/panel/samsung,atna33xc20.yaml |     2 +
 .../bindings/display/renesas,rzg2l-du.yaml         |    26 +-
 .../display/rockchip/rockchip,analogix-dp.yaml     |    47 +-
 .../display/tegra/nvidia,tegra124-vic.yaml         |     1 +
 .../display/tegra/nvidia,tegra20-host1x.yaml       |    20 +-
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml |     3 +-
 .../devicetree/bindings/gpu/img,powervr-sgx.yaml   |     3 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    10 +
 .../gpu/amdgpu/display/display-manager.rst         |     9 +
 Documentation/gpu/automated_testing.rst            |     3 +-
 Documentation/gpu/drm-kms-helpers.rst              |     6 +
 Documentation/gpu/drm-kms.rst                      |    12 +
 .../gpu/intel-display/dp-link-capabilities.rst     |    11 +
 .../gpu/intel-display/dp-link-training.rst         |     8 +
 Documentation/gpu/intel-display/index.rst          |     2 +
 Documentation/gpu/nova/core/fsp.rst                |   142 +
 Documentation/gpu/nova/core/tlv.rst                |   184 +
 Documentation/gpu/nova/index.rst                   |     2 +
 Documentation/gpu/todo.rst                         |    50 +-
 Documentation/gpu/xe/xe_device.rst                 |     7 +
 MAINTAINERS                                        |    22 +-
 drivers/accel/amdxdna/amdxdna_gem.c                |     6 +
 drivers/accel/ethosu/Makefile                      |     2 +-
 drivers/accel/ethosu/ethosu_device.h               |    35 +-
 drivers/accel/ethosu/ethosu_drv.c                  |    23 +-
 drivers/accel/ethosu/ethosu_drv.h                  |    61 +-
 drivers/accel/ethosu/ethosu_job.c                  |    61 +-
 drivers/accel/ethosu/ethosu_job.h                  |     2 +
 drivers/accel/ethosu/ethosu_perfmon.c              |   301 +
 drivers/accel/ivpu/ivpu_drv.c                      |    28 +-
 drivers/accel/ivpu/ivpu_drv.h                      |     5 +-
 drivers/accel/ivpu/ivpu_fw.c                       |     2 +-
 drivers/accel/ivpu/ivpu_hw.c                       |     4 +
 drivers/accel/ivpu/ivpu_ipc.c                      |    25 +-
 drivers/accel/ivpu/ivpu_ipc.h                      |     3 +-
 drivers/accel/ivpu/ivpu_job.c                      |    59 +-
 drivers/accel/ivpu/ivpu_job.h                      |     7 +-
 drivers/accel/ivpu/ivpu_mmu_context.c              |     4 +-
 drivers/accel/rocket/rocket_job.c                  |    32 +-
 drivers/dma-buf/dma-fence-unwrap.c                 |     8 +-
 drivers/dma-buf/dma-fence.c                        |    22 +-
 drivers/dma-buf/dma-heap.c                         |     3 +-
 drivers/dma-buf/st-dma-fence-chain.c               |     4 +-
 drivers/dma-buf/st-dma-fence-unwrap.c              |    42 +-
 drivers/dma-buf/st-dma-fence.c                     |    16 +-
 drivers/dma-buf/st-dma-resv.c                      |    10 +-
 drivers/dma-buf/udmabuf.c                          |     4 +-
 drivers/firmware/Kconfig                           |    28 +-
 drivers/gpu/Kconfig                                |     3 +-
 drivers/gpu/Makefile                               |    58 +-
 drivers/gpu/buddy.c                                |   158 +-
 drivers/gpu/drm/Makefile                           |     2 +-
 drivers/gpu/drm/adp/adp-mipi.c                     |     4 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   321 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c            |   985 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h            |   232 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |    68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h           |   151 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |    18 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c    |    63 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c |     3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |     2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |   184 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h        |    22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |    62 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |   135 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h           |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    74 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   215 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |     9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   439 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   313 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   177 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   651 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   367 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |    23 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |    85 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c             |   157 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h             |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    71 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |   486 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h            |   108 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   312 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    89 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |    23 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    40 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c    |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c         |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  1019 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |    70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   514 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |    26 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h     |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   210 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c            |    39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |    10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h             |    78 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |    28 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   150 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    63 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |   266 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |    44 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c       |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   228 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    88 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |     3 +
 .../amdgpu_video_codecs.h}                         |    42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    37 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |    11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   128 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |    65 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h       |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c             |   129 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h             |   102 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |    46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   308 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |    27 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |    61 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |    66 +-
 drivers/gpu/drm/amd/amdgpu/atom.h                  |     3 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |     8 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    11 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    66 -
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    57 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    57 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    32 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   425 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   318 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   301 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   386 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   348 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   239 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    34 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  1131 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |     4 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |     4 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |     4 -
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   125 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    24 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |     5 +-
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c             |     5 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h             |     4 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |    21 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |    88 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |     2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h           |     4 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |    94 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h           |     8 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |    66 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |    22 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   182 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h         |     9 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   362 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   298 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   379 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c            |   231 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |    65 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |     7 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |    28 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h              |     2 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |     7 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c           |     4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    73 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   204 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |    10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |    10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |    28 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |    28 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |    28 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    12 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |     8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |    10 +-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    61 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    34 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |    12 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |    15 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |    40 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c             |   736 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h             |    31 -
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    55 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |    10 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |    69 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |    12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |    45 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |    87 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |    90 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |     3 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |    43 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    28 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           |   115 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    24 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   345 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     2 +
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   241 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h            |     4 -
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |     8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |    16 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |    10 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |    54 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |    16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |    70 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    43 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   152 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    25 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |     7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   376 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |    26 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    11 +-
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c        |    18 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |     8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  8242 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   124 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |   338 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h    |    58 +
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   737 +
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |    90 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   235 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |    34 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |     3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  3965 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   226 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   122 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |     6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    47 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |    15 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |   448 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h   |    52 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   135 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |   964 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |    78 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |   362 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.h |    65 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   297 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |    64 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   152 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h  |    61 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  1765 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |    84 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |     6 +-
 .../display/amdgpu_dm/amdgpu_dm_kunit_helpers.h    |    19 -
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   195 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |    26 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   528 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |    63 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   379 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h   |    64 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |    53 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |     5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |    34 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |    12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    60 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |    34 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |    17 +
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h     |     6 +-
 .../drm/amd/display/amdgpu_dm/tests/.kunitconfig   |     6 +
 .../gpu/drm/amd/display/amdgpu_dm/tests/Makefile   |    19 +
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |  1259 +
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  1995 +
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |  1465 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   140 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  5691 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   850 +
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  1939 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   268 +
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |  1419 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   453 +
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |  2480 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  3907 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |  4093 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   392 +-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   195 +
 .../amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h |    39 +
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |  1429 +
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |  3137 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |  2474 +
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   509 +-
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   168 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   432 +-
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   313 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  1232 +
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   437 +
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |    61 +-
 drivers/gpu/drm/amd/display/dc/basics/conversion.h |    12 +-
 .../amd/display/dc/bios/command_table_helper2.c    |     1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |     9 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    15 +
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    57 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h |     9 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |    72 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |     2 +
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c   |    29 +-
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.h   |     2 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |   183 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h  |   389 +
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |  1673 +
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h   |   150 +
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c       |   369 +
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h       |    35 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   895 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  1025 +-
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |     7 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   156 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |     3 +
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |    82 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    76 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |    44 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   486 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |    89 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |    66 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |     1 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   228 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    53 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h          |    97 +
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |    32 +-
 drivers/gpu/drm/amd/display/dc/dc_state.h          |     7 +
 drivers/gpu/drm/amd/display/dc/dc_state_priv.h     |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    62 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    81 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile       |     8 +
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h |    10 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |    11 +-
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h |     5 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    61 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c |   187 +
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h |   182 +
 drivers/gpu/drm/amd/display/dc/dce/Makefile        |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |     9 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    28 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |     9 +
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |    73 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c |   213 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h |    20 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |     2 +-
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |     2 -
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |     2 -
 .../drm/amd/display/dc/dce112/dce112_compressor.c  |     8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |   184 +
 drivers/gpu/drm/amd/display/dc/dio/Makefile        |     8 +
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |    10 +-
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.h  |    16 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.c  |     4 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.h  |     2 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c        |    15 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h        |    10 +
 .../display/dc/dio/dcn60/dcn60_dio_link_encoder.c  |   373 +
 .../display/dc/dio/dcn60/dcn60_dio_link_encoder.h  |    43 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c        |   538 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.h        |   181 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |    19 +
 drivers/gpu/drm/amd/display/dc/dm_services.h       |     4 -
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |     2 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |     2 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |     2 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |     4 +-
 .../gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c  |    10 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |    40 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |   149 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |   146 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.h  |     5 +
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.c    |    40 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |     6 -
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |    42 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn5_soc_bb.h  |    36 +
 .../dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h  |   229 +
 .../inc/bounding_boxes/utm_qos_model_dchub_v1.h    |   109 +
 .../inc/bounding_boxes/utm_qos_model_dchub_v2.h    |   122 +
 .../inc/bounding_boxes/utm_qos_model_dchub_v3.h    |    53 +
 .../dml21/inc/bounding_boxes/utm_qos_model_types.h |    51 +
 .../amd/display/dc/dml2_0/dml21/inc/dml_dmub_cmd.h |   502 +
 .../dc/dml2_0/dml21/inc/dml_top_dchub_registers.h  |    30 +
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |    10 +
 .../dml2_0/dml21/inc/dml_top_soc_parameter_types.h |    15 +
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |    50 +
 .../dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c   |   152 +
 .../dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.h   |     9 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c   |    38 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_factory.h   |     9 +
 .../dml2_core/dml2_core_calcs_dsc_shared_types.h   |    32 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |    38 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |   149 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.h     |     2 +
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |  5893 ++
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.h     |   426 +
 .../dml2_core/dml2_core_dcn5_calcs_display_pipe.c  |  1029 +
 .../dml2_core/dml2_core_dcn5_calcs_display_pipe.h  |   151 +
 .../dml2_core/dml2_core_dcn5_calcs_dsc_latency.c   |   501 +
 .../dml2_core/dml2_core_dcn5_calcs_dsc_latency.h   |    23 +
 .../dml2_core/dml2_core_dcn5_funcs_initialize.c    |    78 +
 .../dml2_core/dml2_core_dcn5_funcs_initialize.h    |    12 +
 .../dml2_core_dcn5_funcs_mode_programming.c        |  1791 +
 .../dml2_core_dcn5_funcs_mode_programming.h        |    11 +
 .../dml2_core/dml2_core_dcn5_funcs_mode_support.c  |  2957 +
 .../dml2_core/dml2_core_dcn5_funcs_mode_support.h  |    11 +
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs.c     |    11 +
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs.h     |     8 +
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c     |  1951 +
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.h     |   101 +
 .../dml2_core/dml2_core_dcn6_funcs_initialize.c    |   165 +
 .../dml2_core/dml2_core_dcn6_funcs_initialize.h    |    12 +
 .../dml2_core_dcn6_funcs_mode_programming.c        |  1389 +
 .../dml2_core_dcn6_funcs_mode_programming.h        |    11 +
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.c  |  4277 ++
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.h  |    11 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |    27 +-
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |   165 +-
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |    22 +-
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c |   449 +
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.h |    19 +
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |    12 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |     5 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c  |    32 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |    59 +-
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.c   |   522 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h   |    21 +
 .../src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.c  |  2228 +
 .../src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.h  |    97 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c   |   506 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h   |    22 +
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c  |  1789 +
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.h  |    17 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |    34 +
 .../alternate_pstate_shared_lib.c                  |  1078 +
 .../alternate_pstate_shared_lib.h                  |   109 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c       |     7 +
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c    |   394 +
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.h    |     9 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c     |   144 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.h     |    11 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c     |   405 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.h     |    12 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c  |    29 +
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.h  |    11 +
 .../dml21/src/inc/dml2_internal_shared_types.h     |   486 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h   |     8 +
 drivers/gpu/drm/amd/display/dc/dpp/Makefile        |    17 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |    13 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c    |     8 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |     8 +-
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h |    41 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |    51 +-
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |     7 +-
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.h   |     6 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c   |   391 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h   |    86 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |   346 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h   |   525 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c  |   315 +
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |     7 +
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c   |   447 +
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h   |   248 +
 .../drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h |     4 +
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c    |     3 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |    10 +
 .../amd/display/dc/gpio/dce80/hw_translate_dce80.c |     5 +-
 .../amd/display/dc/gpio/dcn10/hw_translate_dcn10.c |   484 +-
 .../amd/display/dc/gpio/dcn20/hw_translate_dcn20.c |   434 +-
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.c |   419 +-
 .../amd/display/dc/gpio/dcn30/hw_translate_dcn30.c |   434 +-
 .../display/dc/gpio/dcn315/hw_translate_dcn315.c   |   420 +-
 .../amd/display/dc/gpio/dcn32/hw_translate_dcn32.c |   386 +-
 .../display/dc/gpio/dcn401/hw_translate_dcn401.c   |   394 +-
 .../amd/display/dc/gpio/dcn42/hw_translate_dcn42.c |   191 +-
 .../amd/display/dc/gpio/dcn60/hw_factory_dcn60.c   |   228 +
 .../amd/display/dc/gpio/dcn60/hw_factory_dcn60.h   |    11 +
 .../amd/display/dc/gpio/dcn60/hw_translate_dcn60.c |   168 +
 .../amd/display/dc/gpio/dcn60/hw_translate_dcn60.h |    13 +
 drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h     |    15 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |   302 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.h       |    28 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     4 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |    90 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h |    21 +
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c     |     9 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile        |     8 +
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h     |    47 -
 .../dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.c      |   114 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.h      |    18 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c    |   358 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.h    |    32 +
 drivers/gpu/drm/amd/display/dc/hubbub/Makefile     |     8 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h |   108 +
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |     8 +-
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |     2 +-
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h |     7 +-
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |     3 +-
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.h   |     4 +-
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |  1816 +
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h |   207 +
 drivers/gpu/drm/amd/display/dc/hubp/Makefile       |    16 +
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |     3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h |    32 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |   201 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |    23 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |   135 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |    15 +-
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c |   532 +
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h |    48 +
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c |   472 +
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h |   272 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile       |    16 +
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h    |     9 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |    49 +-
 .../drm/amd/display/dc/hwss/dce60/dce60_hwseq.c    |    10 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |    96 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h    |     5 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   101 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h    |     3 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c  |     2 +-
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c    |    40 +-
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h    |     2 +
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    68 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h    |     6 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |    70 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    72 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h    |     8 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |    19 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   775 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    23 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |     3 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   540 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |     9 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |     2 -
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |   759 +
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.h    |    32 +
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |  1164 +
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h    |    32 +
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |   181 +
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.h |    12 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |   315 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |    10 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |    10 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    54 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |     3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    23 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |    22 +
 .../drm/amd/display/dc/inc/hw/cursor_reg_cache.h   |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |    18 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |     7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    35 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h    |    24 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |    81 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |     1 +
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |     5 +-
 drivers/gpu/drm/amd/display/dc/inc/reg_helper.h    |    19 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |     9 +-
 .../drm/amd/display/dc/inc/soc_and_ip_translator.h |    14 -
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |     9 +
 .../amd/display/dc/irq/dcn60/irq_service_dcn60.c   |   417 +
 .../amd/display/dc/irq/dcn60/irq_service_dcn60.h   |    12 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |    56 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   358 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.h    |     4 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |    12 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |    28 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.h   |     2 +
 .../display/dc/link/protocols/link_dp_capability.c |    14 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |     1 -
 .../dc/link/protocols/link_dp_panel_replay.c       |     3 +-
 .../display/dc/link/protocols/link_dp_training.c   |    28 +-
 .../dc/link/protocols/link_edp_panel_control.c     |    21 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |    25 +-
 drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile   |    10 +
 .../amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c |     4 +-
 .../amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.h |     5 +
 .../display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c   |   135 +
 .../display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h   |    40 +
 .../amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h |     1 +
 drivers/gpu/drm/amd/display/dc/mpc/Makefile        |     8 +
 .../gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   |     4 -
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |    44 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |   246 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |    31 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   |   405 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h   |    55 +-
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c   |   330 +
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h   |   472 +
 drivers/gpu/drm/amd/display/dc/opp/Makefile        |     8 +
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c   |    51 +-
 .../gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.c   |    25 +
 .../gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.h   |    64 +
 drivers/gpu/drm/amd/display/dc/optc/Makefile       |     9 +
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c |    41 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h |     3 +-
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |     5 -
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |     5 -
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h |     4 +
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |     5 -
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.h   |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |     5 -
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h |     2 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |    31 +-
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.c   |     5 -
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.h   |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c |     9 +-
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |     4 +
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c |   107 +
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h |   178 +
 drivers/gpu/drm/amd/display/dc/os_types.h          |    10 +
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |   258 +-
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h    |    22 +-
 drivers/gpu/drm/amd/display/dc/resource/Makefile   |    10 +
 .../display/dc/resource/dce100/dce100_resource.h   |     1 -
 .../display/dc/resource/dce112/dce112_resource.h   |     7 -
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |     1 +
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |     1 +
 .../display/dc/resource/dcn201/dcn201_resource.c   |     1 +
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |     1 +
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |     5 +-
 .../display/dc/resource/dcn301/dcn301_resource.c   |     3 +
 .../display/dc/resource/dcn302/dcn302_resource.c   |     5 +-
 .../display/dc/resource/dcn303/dcn303_resource.c   |     5 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |     8 +-
 .../display/dc/resource/dcn314/dcn314_resource.c   |     8 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |    13 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |    12 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |     5 +-
 .../display/dc/resource/dcn321/dcn321_resource.c   |     5 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |    10 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |    10 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |    10 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |    65 +-
 .../display/dc/resource/dcn401/dcn401_resource.h   |    11 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |    44 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.h |     1 +
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |    60 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.h   |    43 +-
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |  2377 +
 .../amd/display/dc/resource/dcn60/dcn60_resource.h |   676 +
 .../amd/display/dc/soc_and_ip_translator/Makefile  |     6 +
 .../dcn401/dcn401_soc_and_ip_translator.c          |    16 +
 .../dcn42/dcn42_soc_and_ip_translator.c            |    18 +-
 .../dcn42/dcn42_soc_and_ip_translator.h            |     1 +
 .../dcn42b/dcn42b_soc_and_ip_translator.c          |    42 +
 .../dcn42b/dcn42b_soc_and_ip_translator.h          |    17 +
 .../dcn60/dcn60_soc_and_ip_translator.c            |   117 +
 .../dcn60/dcn60_soc_and_ip_translator.h            |    16 +
 .../soc_and_ip_translator/soc_and_ip_translator.c  |     9 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c       |   202 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h |    58 +-
 drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h    |     4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |    14 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   518 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |     1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c  |   732 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h  |   303 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   107 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |    18 +
 drivers/gpu/drm/amd/display/include/dal_types.h    |     1 +
 .../drm/amd/display/include/ddc_service_types.h    |     1 +
 drivers/gpu/drm/amd/display/include/gpio_types.h   |    48 +
 .../drm/amd/display/modules/freesync/freesync.c    |     8 +-
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |    11 +
 drivers/gpu/drm/amd/display/modules/power/Makefile |     2 +-
 drivers/gpu/drm/amd/display/modules/power/power.c  |    28 +-
 .../gpu/drm/amd/display/modules/power/power_abm.c  |   365 +-
 .../drm/amd/display/modules/power/power_helpers.h  |    19 +
 .../gpu/drm/amd/display/modules/power/power_psr.c  |     7 +
 .../drm/amd/display/modules/power/power_replay.c   |    16 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |     6 -
 drivers/gpu/drm/amd/include/amdgpu_ptl.h           |     9 +-
 .../amd/include/asic_reg/dcn/dcn_6_0_0_offset.h    | 15799 +++++
 .../amd/include/asic_reg/dcn/dcn_6_0_0_sh_mask.h   | 58556 +++++++++++++++=
++++
 .../amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h  |    47 +
 .../amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h |    55 +
 .../drm/amd/include/asic_reg/gca/gfx_6_0_sh_mask.h |    32 +-
 .../include/asic_reg/mmhub/mmhub_5_0_1_offset.h    |    17 +
 .../include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h   |    17 +
 .../amd/include/asic_reg/sdma/sdma_4_4_2_offset.h  |     4 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |     3 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |    52 +-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h      |     5 +-
 drivers/gpu/drm/amd/include/soc15_hw_ip.h          |     1 +
 drivers/gpu/drm/amd/include/v9_structs.h           |     4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |     9 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   151 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |     1 -
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |    21 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    |    38 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c  |    11 +-
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c |   753 +-
 .../drm/amd/pm/powerplay/hwmgr/processpptables.c   |   446 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |    60 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |    83 +-
 .../pm/powerplay/hwmgr/vega10_processpptables.c    |   761 +-
 .../pm/powerplay/hwmgr/vega12_processpptables.c    |     7 +
 .../pm/powerplay/hwmgr/vega20_processpptables.c    |     7 +
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |    20 +
 .../gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c  |    25 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   267 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   109 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h |   230 +
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h   |     5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |     3 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |    17 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |    24 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |    15 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |    15 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |    73 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |    94 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   124 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   105 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |   134 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |     1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |    98 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   117 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   128 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   148 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   816 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |    31 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   128 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |   108 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |   105 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   134 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   109 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   314 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h   |    13 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |   150 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |     2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   140 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |    13 +
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h        |     4 +-
 drivers/gpu/drm/amd/ras/Makefile                   |     4 +-
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/Makefile |    16 +-
 .../drm/amd/ras/{rascore/ras_aca.c =3D> core/aca.c}  |    21 +-
 .../drm/amd/ras/{rascore/ras_aca.h =3D> core/aca.h}  |     4 +-
 .../{rascore/ras_aca_v1_0.c =3D> core/aca_v1_0.c}    |    17 +-
 .../{rascore/ras_aca_v1_0.h =3D> core/aca_v1_0.h}    |     4 +-
 .../drm/amd/ras/{rascore/ras_cmd.c =3D> core/cmd.c}  |     2 +-
 .../drm/amd/ras/{rascore/ras_cmd.h =3D> core/cmd.h}  |     8 +-
 .../amd/ras/{rascore/ras_core.c =3D> core/core.c}    |    40 +-
 .../ras_core_status.h =3D> core/core_status.h}       |     4 +-
 .../ras/{rascore/ras_eeprom.c =3D> core/eeprom.c}    |    10 +-
 .../ras/{rascore/ras_eeprom.h =3D> core/eeprom.h}    |     8 +-
 .../{rascore/ras_eeprom_fw.c =3D> core/eeprom_fw.c}  |     2 +-
 .../{rascore/ras_eeprom_fw.h =3D> core/eeprom_fw.h}  |     4 +-
 .../{rascore/ras_log_ring.c =3D> core/log_ring.c}    |     4 +-
 .../{rascore/ras_log_ring.h =3D> core/log_ring.h}    |     6 +-
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras.h    |    22 +-
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_cper.c   |     4 +-
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_cper.h   |     0
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx.c    |     2 +-
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx.h    |     0
 .../drm/amd/ras/{rascore =3D> core}/ras_gfx_v9_0.c   |     2 +-
 .../drm/amd/ras/{rascore =3D> core}/ras_gfx_v9_0.h   |     0
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1.c    |    19 +-
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1.h    |     3 +
 .../drm/amd/ras/{rascore =3D> core}/ras_mp1_v13_0.c  |    15 +-
 .../drm/amd/ras/{rascore =3D> core}/ras_mp1_v13_0.h  |     0
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio.c   |     0
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio.h   |     0
 .../drm/amd/ras/{rascore =3D> core}/ras_nbio_v7_9.c  |     0
 .../drm/amd/ras/{rascore =3D> core}/ras_nbio_v7_9.h  |     0
 .../drm/amd/ras/{rascore =3D> core}/ras_process.c    |     5 +-
 .../drm/amd/ras/{rascore =3D> core}/ras_process.h    |     0
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_psp.c    |     5 +-
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_psp.h    |     2 +-
 .../drm/amd/ras/{rascore =3D> core}/ras_psp_v13_0.c  |     0
 .../drm/amd/ras/{rascore =3D> core}/ras_psp_v13_0.h  |     0
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_umc.c    |   216 +-
 .../gpu/drm/amd/ras/{rascore =3D> core}/ras_umc.h    |    51 +-
 .../drm/amd/ras/{rascore =3D> core}/ras_umc_v12_0.c  |   240 +-
 .../drm/amd/ras/{rascore =3D> core}/ras_umc_v12_0.h  |     5 +-
 .../amd/ras/{rascore/ras_ta_if.h =3D> core/ta_if.h}  |     4 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |    89 +-
 .../drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c    |     4 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    96 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h   |     4 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c |    14 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c   |    22 +
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h          |     3 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |    12 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |    27 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |    13 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    19 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |     6 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |    32 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |     6 +-
 drivers/gpu/drm/bridge/aux-bridge.c                |     4 +
 drivers/gpu/drm/bridge/aux-hpd-bridge.c            |     4 +
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |     9 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |     8 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c           |     6 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |    15 +-
 drivers/gpu/drm/bridge/cros-ec-anx7688.c           |     4 +
 drivers/gpu/drm/bridge/display-connector.c         |    38 +-
 drivers/gpu/drm/bridge/fsl-ldb.c                   |     3 +-
 drivers/gpu/drm/bridge/imx/Kconfig                 |    11 +
 drivers/gpu/drm/bridge/imx/Makefile                |     1 +
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c       |     2 +-
 drivers/gpu/drm/bridge/imx/imx8qm-ldb.c            |     2 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c           |     2 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c    |     2 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c    |     2 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c       |     2 +-
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c            |   222 +
 drivers/gpu/drm/bridge/inno-hdmi.c                 |     2 +-
 drivers/gpu/drm/bridge/ite-it6263.c                |     4 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |     4 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |     2 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |     6 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |    14 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            |     7 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |     6 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |     5 +-
 drivers/gpu/drm/bridge/lvds-codec.c                |    13 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |    11 +-
 drivers/gpu/drm/bridge/microchip-lvds.c            |     3 +
 drivers/gpu/drm/bridge/nwl-dsi.c                   |     2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |    21 +-
 drivers/gpu/drm/bridge/of-display-mode-bridge.c    |     6 +-
 drivers/gpu/drm/bridge/panel.c                     |    22 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |    26 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |     2 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |     5 +-
 drivers/gpu/drm/bridge/sii902x.c                   |     8 +-
 drivers/gpu/drm/bridge/sii9234.c                   |    41 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |     6 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |    13 +-
 drivers/gpu/drm/bridge/ssd2825.c                   |     3 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |     9 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |     3 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |     5 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |     2 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |     3 +-
 drivers/gpu/drm/bridge/tc358762.c                  |    21 +-
 drivers/gpu/drm/bridge/tc358764.c                  |    32 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    10 +-
 drivers/gpu/drm/bridge/tc358768.c                  |     7 +-
 drivers/gpu/drm/bridge/tc358775.c                  |     6 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |    15 +-
 drivers/gpu/drm/bridge/thc63lvd1024.c              |    14 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c               |     4 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |     9 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |     8 +-
 drivers/gpu/drm/bridge/ti-tdp158.c                 |     2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |    14 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c              |     4 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |    15 +-
 drivers/gpu/drm/clients/drm_log.c                  |    10 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |    45 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |   116 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |    68 +-
 drivers/gpu/drm/drm_atomic.c                       |    82 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    86 +
 drivers/gpu/drm/drm_atomic_state_helper.c          |   154 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |     4 +
 drivers/gpu/drm/drm_blend.c                        |    20 +-
 drivers/gpu/drm/drm_bridge.c                       |   187 +-
 drivers/gpu/drm/drm_buddy.c                        |    30 +-
 drivers/gpu/drm/drm_colorop.c                      |    41 +-
 drivers/gpu/drm/drm_connector.c                    |   192 +-
 drivers/gpu/drm/drm_displayid_internal.h           |    24 +
 drivers/gpu/drm/drm_draw_internal.h                |     7 -
 drivers/gpu/drm/drm_drv.c                          |    46 +-
 drivers/gpu/drm/drm_dumb_buffers.c                 |     1 -
 drivers/gpu/drm/drm_edid.c                         |    80 +-
 drivers/gpu/drm/drm_exec.c                         |     2 +-
 drivers/gpu/drm/drm_fb_helper.c                    |    11 +-
 drivers/gpu/drm/drm_gem.c                          |     3 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |    22 +-
 drivers/gpu/drm/drm_gpusvm.c                       |   243 +-
 drivers/gpu/drm/drm_gpuvm.c                        |    44 -
 drivers/gpu/drm/drm_mode_config.c                  |   210 +-
 drivers/gpu/drm/drm_modes.c                        |    23 +
 drivers/gpu/drm/drm_of.c                           |    49 +-
 drivers/gpu/drm/drm_panel.c                        |    68 +-
 drivers/gpu/drm/drm_panic.c                        |     6 +-
 drivers/gpu/drm/drm_print.c                        |     4 +-
 drivers/gpu/drm/drm_probe_helper.c                 |    53 +-
 drivers/gpu/drm/drm_syncobj.c                      |     2 +-
 drivers/gpu/drm/drm_writeback.c                    |     6 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |    33 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |     6 +
 drivers/gpu/drm/exynos/exynos_dp.c                 |    32 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    17 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |    11 +-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |    14 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    14 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    20 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    18 +
 drivers/gpu/drm/gma500/cdv_intel_crt.c             |     9 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |   120 +-
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |    10 +-
 drivers/gpu/drm/gma500/cdv_intel_lvds.c            |     9 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |     9 +-
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |     9 +-
 drivers/gpu/drm/gma500/psb_drv.c                   |    56 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |     9 +-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig            |     4 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |   114 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    78 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |     5 +
 drivers/gpu/drm/hyperv/hyperv_drm.h                |    16 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |   100 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |   110 +-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c          |    70 +-
 drivers/gpu/drm/i915/.kunitconfig                  |     9 +
 drivers/gpu/drm/i915/Kconfig.debug                 |    12 +
 drivers/gpu/drm/i915/Makefile                      |     7 +-
 drivers/gpu/drm/i915/display/g4x_dp.c              |    15 +-
 drivers/gpu/drm/i915/display/g4x_hdmi.c            |     4 +-
 drivers/gpu/drm/i915/display/hsw_ips.c             |     2 +-
 drivers/gpu/drm/i915/display/i9xx_plane.c          |     8 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |     5 +-
 drivers/gpu/drm/i915/display/intel_alpm.c          |    15 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |    55 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |    62 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |   280 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |    60 +-
 drivers/gpu/drm/i915/display/intel_cdclk.h         |     1 +
 drivers/gpu/drm/i915/display/intel_cmtg.c          |   280 +-
 drivers/gpu/drm/i915/display/intel_cmtg.h          |    19 +-
 drivers/gpu/drm/i915/display/intel_cmtg_regs.h     |    24 +-
 drivers/gpu/drm/i915/display/intel_color.c         |   115 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |     9 +-
 drivers/gpu/drm/i915/display/intel_crtc.c          |     2 +-
 drivers/gpu/drm/i915/display/intel_cursor.c        |     5 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |    11 +
 drivers/gpu/drm/i915/display/intel_cx0_phy.h       |     1 -
 drivers/gpu/drm/i915/display/intel_ddi.c           |    37 +-
 drivers/gpu/drm/i915/display/intel_de.c            |    40 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   242 +-
 drivers/gpu/drm/i915/display/intel_display.h       |     7 +
 drivers/gpu/drm/i915/display/intel_display_core.h  |    16 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |     2 +
 .../gpu/drm/i915/display/intel_display_device.c    |    14 +
 .../gpu/drm/i915/display/intel_display_device.h    |     6 +-
 .../gpu/drm/i915/display/intel_display_driver.c    |   202 +-
 .../gpu/drm/i915/display/intel_display_driver.h    |    17 +-
 drivers/gpu/drm/i915/display/intel_display_irq.c   |    21 +-
 drivers/gpu/drm/i915/display/intel_display_irq.h   |     2 +
 .../gpu/drm/i915/display/intel_display_limits.h    |     2 +
 drivers/gpu/drm/i915/display/intel_display_power.c |   189 +-
 drivers/gpu/drm/i915/display/intel_display_power.h |    40 +
 .../drm/i915/display/intel_display_power_well.c    |    76 +-
 .../drm/i915/display/intel_display_power_well.h    |     1 +
 drivers/gpu/drm/i915/display/intel_display_regs.h  |    49 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |    67 +-
 drivers/gpu/drm/i915/display/intel_display_wa.c    |     4 +
 drivers/gpu/drm/i915/display/intel_display_wa.h    |     2 +
 drivers/gpu/drm/i915/display/intel_dmc.c           |    25 +-
 drivers/gpu/drm/i915/display/intel_dmc_regs.h      |     2 +
 drivers/gpu/drm/i915/display/intel_dmc_wl.c        |     2 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   849 +-
 drivers/gpu/drm/i915/display/intel_dp.h            |    31 +-
 drivers/gpu/drm/i915/display/intel_dp_link_caps.c  |  1312 +
 drivers/gpu/drm/i915/display/intel_dp_link_caps.h  |   195 +
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  1269 +-
 .../gpu/drm/i915/display/intel_dp_link_training.h  |    46 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |    87 +-
 drivers/gpu/drm/i915/display/intel_dp_test.c       |   108 +-
 drivers/gpu/drm/i915/display/intel_dp_test.h       |     3 +-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c     |    55 +-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h     |    17 +
 drivers/gpu/drm/i915/display/intel_dram.c          |    14 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |    32 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |     5 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |    21 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |    35 +-
 drivers/gpu/drm/i915/display/intel_gmbus.c         |   148 +-
 drivers/gpu/drm/i915/display/intel_gmbus.h         |    22 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |     2 +
 drivers/gpu/drm/i915/display/intel_hdmi.c          |    45 +-
 drivers/gpu/drm/i915/display/intel_initial_plane.c |     8 +-
 drivers/gpu/drm/i915/display/intel_lpe_audio.c     |     4 +-
 drivers/gpu/drm/i915/display/intel_lt_phy.c        |    14 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |     5 +-
 drivers/gpu/drm/i915/display/intel_modeset_setup.c |    30 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |   170 +-
 drivers/gpu/drm/i915/display/intel_panel.h         |     6 +-
 drivers/gpu/drm/i915/display/intel_parent.c        |     6 +-
 drivers/gpu/drm/i915/display/intel_parent.h        |     4 +-
 drivers/gpu/drm/i915/display/intel_plane.c         |   109 +-
 drivers/gpu/drm/i915/display/intel_plane.h         |    10 +-
 drivers/gpu/drm/i915/display/intel_pmdemand.c      |    12 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   280 +-
 drivers/gpu/drm/i915/display/intel_psr.h           |     1 +
 drivers/gpu/drm/i915/display/intel_psr_regs.h      |     1 +
 drivers/gpu/drm/i915/display/intel_sdvo.c          |     7 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |    22 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |     5 +-
 drivers/gpu/drm/i915/display/intel_vrr.c           |    29 +-
 drivers/gpu/drm/i915/display/intel_vrr.h           |     4 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.c |    22 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.h |     9 +
 drivers/gpu/drm/i915/display/skl_watermark.c       |     6 +
 drivers/gpu/drm/i915/display/tests/Makefile        |     7 +
 .../drm/i915/display/tests/intel_dp_link_test.c    |  1408 +
 drivers/gpu/drm/i915/display/vlv_dsi.c             |     5 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |     7 -
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |   128 -
 drivers/gpu/drm/i915/gem/i915_gem_panic.c          |   147 +
 drivers/gpu/drm/i915/gem/i915_gem_panic.h          |    11 +
 drivers/gpu/drm/i915/gt/intel_gsc.c                |     2 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |     2 +-
 .../gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c    |     2 +-
 drivers/gpu/drm/i915/gvt/edid.c                    |    14 +-
 drivers/gpu/drm/i915/i915_active.c                 |     2 +-
 drivers/gpu/drm/i915/i915_driver.c                 |   181 +-
 drivers/gpu/drm/i915/i915_initial_plane.c          |    12 +-
 drivers/gpu/drm/i915/i915_panic.c                  |    35 -
 drivers/gpu/drm/i915/i915_panic.h                  |     9 -
 drivers/gpu/drm/imagination/pvr_ccb.c              |     6 +-
 drivers/gpu/drm/imagination/pvr_check.h            |    36 +
 drivers/gpu/drm/imagination/pvr_device.c           |     4 +-
 drivers/gpu/drm/imagination/pvr_device_info.h      |     6 +-
 drivers/gpu/drm/imagination/pvr_drv.c              |     7 +-
 drivers/gpu/drm/imagination/pvr_gem.h              |    12 +-
 drivers/gpu/drm/imagination/pvr_queue.c            |    14 +-
 drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h |    11 +-
 .../drm/imagination/pvr_rogue_fwif_client_check.h  |     9 +-
 .../drm/imagination/pvr_rogue_fwif_shared_check.h  |     9 +-
 .../gpu/drm/imagination/pvr_rogue_heap_config.h    |    10 +-
 drivers/gpu/drm/imagination/pvr_rogue_mips_check.h |    71 +-
 drivers/gpu/drm/imx/dc/dc-ic.c                     |     6 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |     4 +
 drivers/gpu/drm/imx/ipuv3/parallel-display.c       |     2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |     6 +-
 drivers/gpu/drm/lima/lima_device.c                 |    12 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c        |    12 +
 drivers/gpu/drm/loongson/lsdc_drv.c                |     4 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |     1 +
 drivers/gpu/drm/mcde/mcde_dsi.c                    |     4 +
 drivers/gpu/drm/mediatek/mtk_dp.c                  |     2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |    12 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |     2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |     2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |     2 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |     2 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |     2 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |     2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |    24 +-
 drivers/gpu/drm/msm/dp/dp_drm.c                    |     4 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |    25 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |    13 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |     2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |     2 -
 drivers/gpu/drm/mxsfb/lcdif_drv.c                  |     2 +-
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  |    18 +-
 drivers/gpu/drm/mxsfb/lcdif_regs.h                 |     1 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |     2 +
 drivers/gpu/drm/nouveau/dispnv50/base.h            |     6 +
 drivers/gpu/drm/nouveau/dispnv50/base507c.c        |     1 +
 drivers/gpu/drm/nouveau/dispnv50/base827c.c        |     1 +
 drivers/gpu/drm/nouveau/dispnv50/base907c.c        |     1 +
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c        |     3 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |     4 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |    40 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |    11 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c        |     1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c        |     1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c        |     1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c        |     1 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |    14 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    36 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |     4 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |    11 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |     8 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h    |     2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c |     8 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c |     1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |    39 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h |     1 +
 drivers/gpu/drm/nova/Makefile                      |     5 +-
 drivers/gpu/drm/nova/driver.rs                     |    36 +-
 drivers/gpu/drm/nova/file.rs                       |    22 +-
 drivers/gpu/drm/nova/gem.rs                        |    18 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |    14 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |    21 +-
 drivers/gpu/drm/omapdrm/dss/dsi.h                  |     2 -
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |     2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |     2 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |     1 +
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |    14 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |    14 +-
 drivers/gpu/drm/panel/Kconfig                      |    67 +
 drivers/gpu/drm/panel/Makefile                     |     6 +
 drivers/gpu/drm/panel/panel-anbernic-td4310.c      |   258 +
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c   |     3 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |     3 +-
 drivers/gpu/drm/panel/panel-chipone-icna35xx.c     |   423 +
 drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c  |     3 +-
 drivers/gpu/drm/panel/panel-edp.c                  |    73 +-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c       |     3 +-
 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c   |     3 +-
 drivers/gpu/drm/panel/panel-himax-hx83102.c        |     3 +-
 drivers/gpu/drm/panel/panel-himax-hx83121a.c       |    39 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c         |     3 +-
 drivers/gpu/drm/panel/panel-ilitek-ili7807s.c      |   285 +
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c       |   290 +
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c       |   212 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c  |     3 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |     3 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c      |     3 +-
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   |   251 +-
 drivers/gpu/drm/panel/panel-lvds.c                 |     2 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c      |     3 +-
 drivers/gpu/drm/panel/panel-novatek-nt36536.c      |   486 +
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c     |   522 +-
 drivers/gpu/drm/panel/panel-novatek-nt37801.c      |   106 +-
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |    14 +-
 drivers/gpu/drm/panel/panel-renesas-r63419.c       |   351 +
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |    10 +-
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      |     4 +
 drivers/gpu/drm/panel/panel-simple.c               |    38 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c      |     3 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |    99 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |     3 +-
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c       |    42 +-
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c    |    42 +-
 drivers/gpu/drm/panfrost/panfrost_device.c         |     1 -
 drivers/gpu/drm/panfrost/panfrost_device.h         |     1 -
 drivers/gpu/drm/panfrost/panfrost_drv.c            |     1 +
 drivers/gpu/drm/panthor/panthor_device.h           |     3 +
 drivers/gpu/drm/panthor/panthor_drv.c              |    16 +-
 drivers/gpu/drm/panthor/panthor_fw.c               |    22 +-
 drivers/gpu/drm/panthor/panthor_gem.c              |    18 +
 drivers/gpu/drm/panthor/panthor_gem.h              |     2 +
 drivers/gpu/drm/panthor/panthor_mmu.c              |   270 +-
 drivers/gpu/drm/panthor/panthor_sched.c            |     1 -
 drivers/gpu/drm/pl111/pl111_drv.c                  |     1 +
 drivers/gpu/drm/qxl/qxl_display.c                  |    12 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |    15 +-
 drivers/gpu/drm/radeon/r600_dpm.c                  |    21 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |    64 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c      |    20 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |     1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c        |     3 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |     2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c   |     1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |     2 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |    51 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |    11 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |     9 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c   |     8 +-
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          |    16 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |   228 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |   112 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |    10 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |     4 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |   176 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h       |     2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |    15 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |    11 +-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |    46 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |     7 -
 drivers/gpu/drm/scheduler/sched_main.c             |     9 -
 drivers/gpu/drm/scheduler/tests/tests_basic.c      |   359 +
 drivers/gpu/drm/scheduler/tests/tests_scheduler.c  |     2 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |   414 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |    23 +-
 drivers/gpu/drm/sti/sti_hda.c                      |    20 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |    20 +-
 drivers/gpu/drm/stm/ltdc.c                         |     2 +
 drivers/gpu/drm/stm/lvds.c                         |    14 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |     2 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |     2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |     3 +
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |    19 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    13 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |    23 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |    23 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    24 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |    10 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |    16 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |    10 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |     2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |     2 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c             |    71 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h             |     6 +
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c            |    20 +-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h            |     1 +
 drivers/gpu/drm/sysfb/Kconfig                      |     7 +-
 drivers/gpu/drm/sysfb/simpledrm.c                  |   120 +-
 drivers/gpu/drm/tegra/drm.c                        |     3 +
 drivers/gpu/drm/tegra/dsi.c                        |   131 +-
 drivers/gpu/drm/tegra/dsi.h                        |    10 +
 drivers/gpu/drm/tegra/falcon.c                     |    66 +-
 drivers/gpu/drm/tegra/falcon.h                     |    23 +
 drivers/gpu/drm/tegra/output.c                     |    24 +-
 drivers/gpu/drm/tegra/vic.c                        |    92 +-
 drivers/gpu/drm/tegra/vic.h                        |     9 +-
 drivers/gpu/drm/tests/Makefile                     |     3 +-
 drivers/gpu/drm/tests/drm_bridge_test.c            |  1017 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   347 +-
 drivers/gpu/drm/tests/drm_kunit_edid.c             |   995 +
 drivers/gpu/drm/tests/drm_kunit_edid.h             |   985 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |    17 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |     2 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |    16 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |     2 +-
 drivers/gpu/drm/tidss/tidss_plane.c                |     2 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |     5 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c   |     2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   322 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |     3 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |    37 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 |   105 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |     2 +
 drivers/gpu/drm/tyr/Kconfig                        |     5 +
 drivers/gpu/drm/tyr/driver.rs                      |    81 +-
 drivers/gpu/drm/tyr/file.rs                        |    15 +-
 drivers/gpu/drm/tyr/fw.rs                          |   321 +
 drivers/gpu/drm/tyr/fw/parser.rs                   |   588 +
 drivers/gpu/drm/tyr/gem.rs                         |   141 +-
 drivers/gpu/drm/tyr/mmu.rs                         |   120 +
 drivers/gpu/drm/tyr/mmu/address_space.rs           |   511 +
 drivers/gpu/drm/tyr/regs.rs                        |   149 +-
 drivers/gpu/drm/tyr/slot.rs                        |   404 +
 drivers/gpu/drm/tyr/tyr.rs                         |     4 +
 drivers/gpu/drm/tyr/vm.rs                          |   950 +
 drivers/gpu/drm/v3d/Kconfig                        |     1 +
 drivers/gpu/drm/v3d/v3d_drv.c                      |    20 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |    88 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |     7 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |     7 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |   189 +-
 drivers/gpu/drm/v3d/v3d_power.c                    |     4 +
 drivers/gpu/drm/v3d/v3d_sched.c                    |   103 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   |  1008 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |     2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    10 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c            |     4 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |   101 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |    26 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |    71 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |    90 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |    45 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |    50 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c              |     5 +-
 drivers/gpu/drm/xe/.gitignore                      |     1 +
 drivers/gpu/drm/xe/.kunitconfig-display            |    11 +
 drivers/gpu/drm/xe/Kconfig.debug                   |    16 +
 drivers/gpu/drm/xe/Kconfig.profile                 |    71 +-
 drivers/gpu/drm/xe/Makefile                        |     5 +
 drivers/gpu/drm/xe/abi/guc_actions_abi.h           |     1 +
 drivers/gpu/drm/xe/abi/guc_capture_abi.h           |     3 +-
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |    39 +-
 drivers/gpu/drm/xe/abi/guc_scheduler_abi.h         |     3 +-
 drivers/gpu/drm/xe/abi/xe_driver_klvs_abi.h        |    27 +
 drivers/gpu/drm/xe/display/tests/Makefile          |    13 +
 drivers/gpu/drm/xe/display/xe_display.c            |   284 +-
 drivers/gpu/drm/xe/display/xe_display.h            |    12 +-
 drivers/gpu/drm/xe/display/xe_display_bo.c         |    33 +-
 drivers/gpu/drm/xe/display/xe_initial_plane.c      |    58 +-
 drivers/gpu/drm/xe/display/xe_panic.c              |    26 +-
 drivers/gpu/drm/xe/regs/xe_pmt.h                   |     2 +
 drivers/gpu/drm/xe/regs/xe_regs.h                  |     2 +
 drivers/gpu/drm/xe/tests/Makefile                  |     1 +
 drivers/gpu/drm/xe/tests/xe_bo.c                   |   242 +
 .../gpu/drm/xe/tests/xe_guc_klv_helpers_kunit.c    |   429 +
 drivers/gpu/drm/xe/tests/xe_live_test_mod.c        |     6 +
 drivers/gpu/drm/xe/tests/xe_pci.c                  |    53 +-
 drivers/gpu/drm/xe/tests/xe_rtp_tables_test.c      |   112 +
 drivers/gpu/drm/xe/tests/xe_rtp_test.c             |    52 +
 drivers/gpu/drm/xe/tests/xe_sriov_packet_kunit.c   |    89 +
 drivers/gpu/drm/xe/tests/xe_wa_test.c              |     3 -
 drivers/gpu/drm/xe/xe_bo.c                         |   174 +-
 drivers/gpu/drm/xe/xe_bo.h                         |     1 +
 drivers/gpu/drm/xe/xe_configfs.c                   |    65 +
 drivers/gpu/drm/xe/xe_configfs.h                   |     2 +
 drivers/gpu/drm/xe/xe_debugfs.c                    |   166 +-
 drivers/gpu/drm/xe/xe_debugfs.h                    |     6 +
 drivers/gpu/drm/xe/xe_device.c                     |    70 +-
 drivers/gpu/drm/xe/xe_device.h                     |    65 +-
 drivers/gpu/drm/xe/xe_device_types.h               |    45 +-
 drivers/gpu/drm/xe/xe_drm_client.c                 |     5 +-
 drivers/gpu/drm/xe/xe_drm_ras.c                    |    44 +-
 drivers/gpu/drm/xe/xe_eu_stall.c                   |    42 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |    17 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |    29 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |     8 +-
 drivers/gpu/drm/xe/xe_ggtt.c                       |     8 +-
 drivers/gpu/drm/xe/xe_gt.c                         |    21 +-
 drivers/gpu/drm/xe/xe_gt.h                         |    14 +-
 drivers/gpu/drm/xe/xe_gt_mcr.c                     |    28 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c        |     5 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_policy.c         |     5 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                |    47 +
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h                |     1 +
 drivers/gpu/drm/xe/xe_gt_sriov_vf_types.h          |     4 +
 drivers/gpu/drm/xe/xe_gt_types.h                   |    17 +-
 drivers/gpu/drm/xe/xe_guc.c                        |    70 +
 drivers/gpu/drm/xe/xe_guc.h                        |    23 +-
 drivers/gpu/drm/xe/xe_guc_ads.c                    |   134 +-
 drivers/gpu/drm/xe/xe_guc_capture.c                |    21 +-
 drivers/gpu/drm/xe/xe_guc_capture.h                |     6 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |    43 +-
 drivers/gpu/drm/xe/xe_guc_engine_activity.c        |    12 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |     7 +
 drivers/gpu/drm/xe/xe_guc_fwif.h                   |     1 +
 drivers/gpu/drm/xe/xe_guc_klv_helpers.c            |   260 +-
 drivers/gpu/drm/xe/xe_guc_klv_helpers.h            |    10 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   382 +-
 drivers/gpu/drm/xe/xe_guc_submit.h                 |     1 +
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c              |     6 -
 drivers/gpu/drm/xe/xe_hw_engine.c                  |   300 +-
 drivers/gpu/drm/xe/xe_hw_engine_group.c            |    85 +-
 drivers/gpu/drm/xe/xe_hw_engine_types.h            |     7 +-
 drivers/gpu/drm/xe/xe_hw_error.c                   |    34 +-
 drivers/gpu/drm/xe/xe_i2c.c                        |     3 -
 drivers/gpu/drm/xe/xe_lrc.c                        |     8 +-
 drivers/gpu/drm/xe/xe_migrate.c                    |    65 +-
 drivers/gpu/drm/xe/xe_mmio.c                       |   100 +-
 drivers/gpu/drm/xe/xe_module.c                     |     3 -
 drivers/gpu/drm/xe/xe_module.h                     |     1 -
 drivers/gpu/drm/xe/xe_oa.c                         |    25 +-
 drivers/gpu/drm/xe/xe_observation.c                |    32 +-
 drivers/gpu/drm/xe/xe_observation.h                |     3 +-
 drivers/gpu/drm/xe/xe_pat.c                        |    44 +
 drivers/gpu/drm/xe/xe_pci.c                        |   206 +-
 drivers/gpu/drm/xe/xe_pci_error.c                  |   139 +
 drivers/gpu/drm/xe/xe_pci_error.h                  |    13 +
 drivers/gpu/drm/xe/xe_pci_types.h                  |     3 +
 drivers/gpu/drm/xe/xe_pcode.c                      |    40 +-
 drivers/gpu/drm/xe/xe_pcode.h                      |     9 +-
 drivers/gpu/drm/xe/xe_pm.c                         |     2 +
 drivers/gpu/drm/xe/xe_preempt_fence.c              |     7 +
 drivers/gpu/drm/xe/xe_pt.c                         |    84 +-
 drivers/gpu/drm/xe/xe_pxp.c                        |    35 +-
 drivers/gpu/drm/xe/xe_query.c                      |     7 +-
 drivers/gpu/drm/xe/xe_ras.c                        |   604 +-
 drivers/gpu/drm/xe/xe_ras.h                        |     7 +
 drivers/gpu/drm/xe/xe_ras_types.h                  |   216 +
 drivers/gpu/drm/xe/xe_reg_whitelist.c              |     5 +-
 drivers/gpu/drm/xe/xe_reg_whitelist.h              |     4 +
 drivers/gpu/drm/xe/xe_rtp.c                        |    10 +-
 drivers/gpu/drm/xe/xe_rtp.h                        |    19 +
 drivers/gpu/drm/xe/xe_rtp_types.h                  |    33 +-
 drivers/gpu/drm/xe/xe_sched_job.c                  |     2 +-
 drivers/gpu/drm/xe/xe_sriov_packet.c               |   115 +-
 drivers/gpu/drm/xe/xe_step.c                       |    38 +-
 drivers/gpu/drm/xe/xe_step.h                       |     8 +-
 drivers/gpu/drm/xe/xe_survivability_mode.c         |    13 +-
 drivers/gpu/drm/xe/xe_svm.c                        |    68 +-
 drivers/gpu/drm/xe/xe_svm.h                        |    14 +-
 drivers/gpu/drm/xe/xe_sysctrl_event.c              |     2 +-
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h        |     3 -
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c            |    28 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h            |     3 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |    13 +
 drivers/gpu/drm/xe/xe_tile.c                       |     4 +-
 drivers/gpu/drm/xe/xe_trace.h                      |     5 +
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c             |    16 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               |    71 +-
 drivers/gpu/drm/xe/xe_tuning.c                     |     3 +-
 drivers/gpu/drm/xe/xe_tuning.h                     |     6 +
 drivers/gpu/drm/xe/xe_uc_fw.c                      |     1 +
 drivers/gpu/drm/xe/xe_userptr.c                    |     7 +-
 drivers/gpu/drm/xe/xe_vm.c                         |    28 +-
 drivers/gpu/drm/xe/xe_wa.c                         |    15 +-
 drivers/gpu/drm/xe/xe_wa.h                         |     7 +
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |     7 +
 drivers/gpu/drm/xlnx/zynqmp_dp.c                   |     2 +-
 drivers/gpu/host1x/Makefile                        |     3 +-
 drivers/gpu/host1x/bus.c                           |     2 +-
 drivers/gpu/host1x/cdma.c                          |     3 +-
 drivers/gpu/host1x/context.c                       |    13 +-
 drivers/gpu/host1x/debug.c                         |     4 +-
 drivers/gpu/host1x/dev.c                           |    41 +
 drivers/gpu/host1x/hw/cdma_hw.c                    |    14 +-
 drivers/gpu/host1x/hw/channel_hw.c                 |    15 +-
 drivers/gpu/host1x/hw/host1x10.c                   |    33 +
 drivers/gpu/host1x/hw/host1x10.h                   |    15 +
 drivers/gpu/host1x/hw/host1x10_hardware.h          |    21 +
 drivers/gpu/host1x/hw/hw_host1x10_common.h         |     6 +
 drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h     |    10 +
 drivers/gpu/host1x/hw/hw_host1x10_uclass.h         |   181 +
 drivers/gpu/host1x/hw/hw_host1x10_vm.h             |    36 +
 drivers/gpu/host1x/intr.c                          |     5 +-
 drivers/gpu/host1x/job.c                           |     2 +-
 drivers/gpu/host1x/syncpt.c                        |     7 +-
 drivers/gpu/host1x/syncpt.h                        |     3 +-
 drivers/gpu/nova-core/.gitignore                   |     1 +
 drivers/gpu/nova-core/Makefile                     |     5 +-
 drivers/gpu/nova-core/bitfield.rs                  |   329 -
 drivers/gpu/nova-core/falcon.rs                    |   272 +-
 drivers/gpu/nova-core/falcon/fsp.rs                |    65 +-
 drivers/gpu/nova-core/falcon/gsp.rs                |    32 +-
 drivers/gpu/nova-core/falcon/hal.rs                |    19 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |    36 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |    28 +-
 drivers/gpu/nova-core/fb.rs                        |   104 +-
 drivers/gpu/nova-core/fb/hal.rs                    |     2 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs              |    10 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs              |     2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |    11 +-
 drivers/gpu/nova-core/fb/hal/gb202.rs              |    39 +-
 drivers/gpu/nova-core/fb/hal/gh100.rs              |    37 +-
 drivers/gpu/nova-core/fb/hal/tu102.rs              |    14 +-
 drivers/gpu/nova-core/fb/regs.rs                   |   155 +
 drivers/gpu/nova-core/firmware.rs                  |   327 +-
 drivers/gpu/nova-core/firmware/booter.rs           |   344 +-
 drivers/gpu/nova-core/firmware/fsp.rs              |    88 +-
 drivers/gpu/nova-core/firmware/fwsec.rs            |    24 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |    95 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |    65 +-
 drivers/gpu/nova-core/firmware/riscv.rs            |    75 +-
 drivers/gpu/nova-core/firmware/tlv.rs              |   262 +
 drivers/gpu/nova-core/fsp.rs                       |   366 +-
 drivers/gpu/nova-core/fsp/hal.rs                   |     4 +
 drivers/gpu/nova-core/fsp/hal/gb100.rs             |     6 +
 drivers/gpu/nova-core/fsp/hal/gb202.rs             |     9 +-
 drivers/gpu/nova-core/fsp/hal/gh100.rs             |     9 +-
 drivers/gpu/nova-core/gpu.rs                       |   191 +-
 drivers/gpu/nova-core/gsp.rs                       |   101 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |   152 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |    75 +-
 drivers/gpu/nova-core/gsp/commands.rs              |    90 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |   201 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs           |    42 +-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs  |     1 +
 drivers/gpu/nova-core/gsp/hal.rs                   |    72 +-
 drivers/gpu/nova-core/gsp/hal/ga102.rs             |    14 +
 drivers/gpu/nova-core/gsp/hal/gh100.rs             |   122 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |   390 +-
 drivers/gpu/nova-core/gsp/regs.rs                  |    22 +
 drivers/gpu/nova-core/gsp/sequencer.rs             |   112 +-
 drivers/gpu/nova-core/mctp.rs                      |    88 +-
 drivers/gpu/nova-core/nova_core.rs                 |     6 +-
 drivers/gpu/nova-core/nova_core_exports.c          |    15 +
 drivers/gpu/nova-core/regs.rs                      |   148 +-
 drivers/gpu/nova-core/vbios.rs                     |    64 +-
 drivers/gpu/nova-core/vgpu.rs                      |    91 +
 drivers/gpu/nova-core/vgpu/hal.rs                  |    25 +
 drivers/gpu/nova-core/vgpu/hal/gb202.rs            |    15 +
 drivers/gpu/nova-core/vgpu/hal/tu102.rs            |    15 +
 drivers/gpu/tests/.kunitconfig                     |     2 +
 drivers/gpu/tests/gpu_buddy_test.c                 |    95 +
 drivers/pci/iov.c                                  |     2 +-
 drivers/pwm/pwm_th1520.rs                          |     7 +-
 include/drm/bridge/analogix_dp.h                   |    13 +-
 include/drm/bridge/dw_dp.h                         |     1 +
 include/drm/display/drm_dp.h                       |    25 +-
 include/drm/display/drm_dp_tunnel.h                |    21 +
 include/drm/display/drm_hdmi_state_helper.h        |     4 +-
 include/drm/drm_atomic.h                           |     5 +-
 include/drm/drm_atomic_helper.h                    |     7 +
 include/drm/drm_atomic_state_helper.h              |    18 +-
 include/drm/drm_bridge.h                           |   151 +-
 include/drm/drm_colorop.h                          |     2 +
 include/drm/drm_connector.h                        |   123 +-
 include/drm/drm_crtc.h                             |    16 +
 include/drm/drm_debugfs.h                          |     2 +-
 include/drm/drm_drv.h                              |    10 +-
 include/drm/drm_gem.h                              |     3 -
 include/drm/drm_gem_shmem_helper.h                 |     4 +
 include/drm/drm_gpusvm.h                           |    67 +-
 include/drm/drm_gpuvm.h                            |     4 +-
 include/drm/drm_managed.h                          |     2 +-
 include/drm/drm_mipi_dsi.h                         |     2 +
 include/drm/drm_mode_config.h                      |     1 +
 include/drm/drm_modes.h                            |     1 +
 include/drm/drm_of.h                               |    11 +
 include/drm/drm_panel.h                            |     8 -
 include/drm/drm_plane.h                            |    16 +
 include/drm/drm_print.h                            |     2 +-
 include/drm/gpu_scheduler.h                        |     3 +-
 include/drm/intel/display_parent_interface.h       |     4 +-
 include/drm/intel/mchbar_regs.h                    |     2 -
 include/drm/intel/pciids.h                         |     5 +-
 include/drm/ttm/ttm_bo.h                           |    10 +
 include/drm/ttm/ttm_resource.h                     |    13 +-
 include/linux/cgroup.h                             |    21 +
 include/linux/cgroup_dmem.h                        |    63 +-
 include/linux/dma-fence-unwrap.h                   |     6 +-
 include/linux/dma-fence.h                          |     4 +-
 include/linux/font.h                               |     3 +
 include/linux/gpu_buddy.h                          |    17 +
 include/linux/pci.h                                |     4 +-
 include/linux/perf_event.h                         |    31 +-
 include/linux/sysfb.h                              |     4 +-
 include/uapi/drm/amdgpu_drm.h                      |    21 +
 include/uapi/drm/drm_fourcc.h                      |   209 +-
 include/uapi/drm/drm_mode.h                        |     1 +
 include/uapi/drm/ethosu_accel.h                    |    60 +-
 include/uapi/drm/nouveau_drm.h                     |     1 +
 include/uapi/drm/panthor_drm.h                     |    26 +-
 include/uapi/drm/xe_drm.h                          |    17 +-
 include/uapi/linux/kfd_ioctl.h                     |   180 +-
 kernel/cgroup/dmem.c                               |   278 +-
 kernel/events/core.c                               |    18 +
 lib/fonts/fonts.c                                  |    31 +
 rust/helpers/io.c                                  |    13 +
 rust/helpers/pci.c                                 |     8 +
 rust/kernel/alloc/kvec.rs                          |    27 +
 rust/kernel/devres.rs                              |    24 +-
 rust/kernel/dma.rs                                 |   333 +-
 rust/kernel/drm/device.rs                          |   291 +-
 rust/kernel/drm/driver.rs                          |   113 +-
 rust/kernel/drm/gem/mod.rs                         |   111 +-
 rust/kernel/drm/gem/shmem.rs                       |   594 +-
 rust/kernel/drm/gpuvm/mod.rs                       |    36 +-
 rust/kernel/drm/gpuvm/sm_ops.rs                    |     4 +-
 rust/kernel/drm/gpuvm/va.rs                        |     8 +
 rust/kernel/drm/gpuvm/vm_bo.rs                     |     9 +
 rust/kernel/drm/ioctl.rs                           |    56 +-
 rust/kernel/drm/mod.rs                             |     4 +-
 rust/kernel/faux.rs                                |    81 +-
 rust/kernel/firmware.rs                            |    46 +-
 rust/kernel/io.rs                                  |  1527 +-
 rust/kernel/io/mem.rs                              |    29 +-
 rust/kernel/io/poll.rs                             |     6 +-
 rust/kernel/io/register.rs                         |    44 +-
 rust/kernel/iommu/pgtable.rs                       |    32 +-
 rust/kernel/lib.rs                                 |     3 +
 rust/kernel/pci.rs                                 |    14 +-
 rust/kernel/pci/io.rs                              |   170 +-
 rust/kernel/ptr.rs                                 |    12 +
 samples/rust/rust_dma.rs                           |    12 +-
 samples/rust/rust_driver_faux.rs                   |     3 +-
 1587 files changed, 231369 insertions(+), 40524 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-ras
 create mode 100644
Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yam=
l
 create mode 100644
Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/chipone,icna3512.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
 create mode 100644 Documentation/gpu/intel-display/dp-link-capabilities.rs=
t
 create mode 100644 Documentation/gpu/intel-display/dp-link-training.rst
 create mode 100644 Documentation/gpu/nova/core/fsp.rst
 create mode 100644 Documentation/gpu/nova/core/tlv.rst
 create mode 100644 drivers/accel/ethosu/ethosu_perfmon.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
 rename drivers/gpu/drm/amd/{display/modules/power/power_helpers.c =3D>
amdgpu/amdgpu_video_codecs.h} (63%)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlig=
ht.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlig=
ht.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connect=
or.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connect=
or.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.=
c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.=
h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesyn=
c.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesyn=
c.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers=
.h
 delete mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.=
h
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_t=
est.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_=
mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_=
mgr.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_probe.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn5_soc_bb.=
h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.=
h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_mode=
l_dchub_v1.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_mode=
l_dchub_v2.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_mode=
l_dchub_v3.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_mode=
l_types.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_dmub_cmd.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_calcs_d=
sc_shared_types.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_ca=
lcs_dchub.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_ca=
lcs_dchub.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_ca=
lcs_display_pipe.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_ca=
lcs_display_pipe.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_ca=
lcs_dsc_latency.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_ca=
lcs_dsc_latency.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_fu=
ncs_initialize.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_fu=
ncs_initialize.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_fu=
ncs_mode_programming.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_fu=
ncs_mode_programming.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_fu=
ncs_mode_support.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_fu=
ncs_mode_support.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_ca=
lcs.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_ca=
lcs.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_ca=
lcs_dchub.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_ca=
lcs_dchub.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_fu=
ncs_initialize.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_fu=
ncs_initialize.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_fu=
ncs_mode_programming.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_fu=
ncs_mode_programming.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_fu=
ncs_mode_support.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_fu=
ncs_mode_support.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5_stag=
e_optimizers.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5_stag=
e_optimizers.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stag=
e_optimizers.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stag=
e_optimizers.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/a=
lternate_pstate_shared_lib.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/a=
lternate_pstate_shared_lib.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_so=
c_bb_dcn5.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_so=
c_bb_dcn5.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_so=
c_bb_dcn6.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_so=
c_bb_dcn6.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_so=
c_bb_factory.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_so=
c_bb_factory.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_factory_dc=
n60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_factory_dc=
n60.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_translate_dcn60.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_translate_dcn60.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbu=
b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbu=
b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn60/irq_service_dc=
n60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn60/irq_service_dc=
n60.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_=
ip_translator.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_=
ip_translator.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip=
_translator.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip=
_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_sh_m=
ask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/Makefile (86%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_aca.c =3D> core/aca.c} (97%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_aca.h =3D> core/aca.h} (98%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_aca_v1_0.c =3D>
core/aca_v1_0.c} (97%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_aca_v1_0.h =3D>
core/aca_v1_0.h} (98%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_cmd.c =3D> core/cmd.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_cmd.h =3D> core/cmd.h} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_core.c =3D> core/core.c} (94%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_core_status.h =3D>
core/core_status.h} (96%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_eeprom.c =3D> core/eeprom.c} (=
99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_eeprom.h =3D> core/eeprom.h} (=
97%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_eeprom_fw.c =3D>
core/eeprom_fw.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_eeprom_fw.h =3D>
core/eeprom_fw.h} (98%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_log_ring.c =3D>
core/log_ring.c} (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_log_ring.h =3D>
core/log_ring.h} (97%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras.h (94%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cper.c (99%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cper.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx.c (98%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx_v9_0.c (99%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx_v9_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1.c (86%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1.h (92%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1_v13_0.c (89%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1_v13_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio_v7_9.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio_v7_9.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_process.c (98%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_process.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp.c (99%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp.h (99%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp_v13_0.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp_v13_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc.c (77%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc.h (78%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc_v12_0.c (75%)
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc_v12_0.h (99%)
 rename drivers/gpu/drm/amd/ras/{rascore/ras_ta_if.h =3D> core/ta_if.h} (99=
%)
 create mode 100644 drivers/gpu/drm/bridge/imx/imx93-pdfc.c
 create mode 100644 drivers/gpu/drm/i915/.kunitconfig
 create mode 100644 drivers/gpu/drm/i915/display/intel_dp_link_caps.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_dp_link_caps.h
 create mode 100644 drivers/gpu/drm/i915/display/tests/Makefile
 create mode 100644 drivers/gpu/drm/i915/display/tests/intel_dp_link_test.c
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_panic.c
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_panic.h
 delete mode 100644 drivers/gpu/drm/i915/i915_panic.c
 delete mode 100644 drivers/gpu/drm/i915/i915_panic.h
 create mode 100644 drivers/gpu/drm/imagination/pvr_check.h
 create mode 100644 drivers/gpu/drm/panel/panel-anbernic-td4310.c
 create mode 100644 drivers/gpu/drm/panel/panel-chipone-icna35xx.c
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9488.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36536.c
 create mode 100644 drivers/gpu/drm/panel/panel-renesas-r63419.c
 create mode 100644 drivers/gpu/drm/tests/drm_kunit_edid.c
 create mode 100644 drivers/gpu/drm/tyr/fw.rs
 create mode 100644 drivers/gpu/drm/tyr/fw/parser.rs
 create mode 100644 drivers/gpu/drm/tyr/mmu.rs
 create mode 100644 drivers/gpu/drm/tyr/mmu/address_space.rs
 create mode 100644 drivers/gpu/drm/tyr/slot.rs
 create mode 100644 drivers/gpu/drm/tyr/vm.rs
 create mode 100644 drivers/gpu/drm/xe/.kunitconfig-display
 create mode 100644 drivers/gpu/drm/xe/abi/xe_driver_klvs_abi.h
 create mode 100644 drivers/gpu/drm/xe/display/tests/Makefile
 create mode 100644 drivers/gpu/drm/xe/tests/xe_guc_klv_helpers_kunit.c
 create mode 100644 drivers/gpu/drm/xe/tests/xe_rtp_tables_test.c
 create mode 100644 drivers/gpu/drm/xe/tests/xe_sriov_packet_kunit.c
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.c
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.h
 create mode 100644 drivers/gpu/host1x/hw/host1x10.c
 create mode 100644 drivers/gpu/host1x/hw/host1x10.h
 create mode 100644 drivers/gpu/host1x/hw/host1x10_hardware.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x10_common.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x10_uclass.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x10_vm.h
 create mode 100644 drivers/gpu/nova-core/.gitignore
 delete mode 100644 drivers/gpu/nova-core/bitfield.rs
 create mode 100644 drivers/gpu/nova-core/fb/regs.rs
 create mode 100644 drivers/gpu/nova-core/firmware/tlv.rs
 create mode 100644 drivers/gpu/nova-core/gsp/hal/ga102.rs
 create mode 100644 drivers/gpu/nova-core/gsp/regs.rs
 create mode 100644 drivers/gpu/nova-core/nova_core_exports.c
 create mode 100644 drivers/gpu/nova-core/vgpu.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/hal.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/hal/gb202.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/hal/tu102.rs
 create mode 100644 drivers/gpu/tests/.kunitconfig
