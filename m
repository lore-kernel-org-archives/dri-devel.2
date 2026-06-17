Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37906CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB4D10EE35;
	Wed, 17 Jun 2026 07:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hKnLd+ut";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6531210E2BB
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:19:19 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-9158c621ebbso665725785a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 23:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781677158; cv=none;
 d=google.com; s=arc-20240605;
 b=S+jqMI8wS+xoGvxlCXKGfE5SnkSn2oKFP44FC0N6G59MSsTRf3TXgsuovjDmnPOh8j
 aUkusmPa1FpvHwIBm0mePePp3A16YHLaB0QRkL+KdTLTz2qcF463Nrbd2T3vcRrXn5tl
 7XEX7GSbwZhgMTTHgMSCoIOCAgCJFMmNoj1cTyTHMMg1GJUkHj8UZ/+CxQWPWBQcAG+k
 89D6hhbrwoozBBDd+uBh9zCMvp3VAXHOkRoN7+ZnUWNUY5TaBMRWNxqtOVHmSC+lhmDH
 DkPjtRWhVBjcDFzIxGXrtZzwkv2CWRQFZ18OV7lGcknyPAu3H3bir5684RtGpA+WDvLj
 6Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=XityFkRBd3cO7HCtxHj+qYBksJxcjgws3jz0El0FAkc=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=ioe6Rv2mYEGFvAl0MxxiixdWmbeh/G79x3z3+A5xJ6J9JGqRSqBQeFxIA5q6uQvvzu
 1ua8SteaxstVMIaLlZGqZnPuKDRhPpZD9xQ24IA79rgQJzcYyvULd+fx2R9uiGwu36pi
 C5nbc83b1c52vJgWypbismZxamF8DdBLmT+nBm4qxSzvWbEqu0niVGHY45FOUbED+sl+
 pvBglrSuzhJoSAKgVtRs4MgbHfYAG/YTsXlVXF01cDwb87W2G7dX/Uuf58PNeGuJIi7n
 Yr6yiP0cXUhCX08SQV4Gdk4xh1yj5H2HdcS+W6E5VBnDr2wFAHsbJCxL+TsIArawadX8
 Ha+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781677158; x=1782281958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XityFkRBd3cO7HCtxHj+qYBksJxcjgws3jz0El0FAkc=;
 b=hKnLd+utY/JW4vrpJs4snm7Lnv78ZnsgY5zoNHW2DVbT+PkpPkOUw+7fgzgxf2cpwl
 Qr2KJwfcsqp5B0a5VxBZEgYxtS4Twx80LNry6zuwUUPJolfbvOL3+Wy7Xqkf4TqWmmeS
 vkNsT0pMPcyxZdjSEVuKZOUcrYSqL+auY4mfPHWjfy/sxSrpdm/bk0l40dfCpl/YfiJH
 hEccdYnCKuxkd3u22T2RqoFKa2JpFa34YnQ4BgyJ81Fo7Ry8cWvmK3/5zdHQ5mZX9HZ2
 kFfc1d4Sw9sAJt2ubtA54Q9YgPfh2SinMWHHI2xhMk5H2lT4GUMT0mg5qgWOGcijiKzl
 +jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781677158; x=1782281958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XityFkRBd3cO7HCtxHj+qYBksJxcjgws3jz0El0FAkc=;
 b=fpiVn0Ea5tIhyb8VE2HK1XO0wPbtbHJqUMrPTxp6B/RcvwrjuuYWXBAygcEejcOgSC
 ojboIjmKGkjzErEIj/ldoBZm7bCWsgXSIDSPw3+8iof5poUaVAAMJLsPrfgHjNU4vYgF
 jx+KQg3maYES3SHWYQdLmq4F8FwlC8OFYjqfwrGxWzBazQaHmUSNk/EjiFf1aVb+7Xo9
 OB1m2DpvYS9V4WW/KWWfnXOg6OyzMvfraitmnHHqE7uCy2h+zy/SDVASkDr5I5SZWegq
 JdTP6MAbOjaOWXRm+SCmg5bPSk5mL10XAGLRyQupQVq/LG0ja1tw0b4tCNlvz7Hj35Q6
 WDiw==
X-Gm-Message-State: AOJu0YwXbgR3fgiOYp2L+EC684XvOs0+cxq76JyevarChciTaSw766l/
 aKBuDCxJLqaMXxCIvdhkn2jzHynY41PIciy46FW1nUCEWRSy6aLq0TV9qd71AM28KqUgKOh+zpH
 AhYWj8xPw6UbaiMxafpwHs/akzkJ0A60=
X-Gm-Gg: Acq92OGRYsi8qTUzeLuuh3E26oHSv7/ofaJirPZqxlH34ZMxu/I991ftrcPHpbF4QUE
 WEHefdk8AX0k2EDl/BWcwA+T3x4+zIATJhIfEHwGlIpDESwanmyGjCxyFWEYeuuqmoMRVP7qA4x
 cLbEB8hudf5Twx6850BgP2UDQaU6kGzbPMK1LPCH/x5baXzse90S/fUAf9uLN/gwWXvDOvvP/zY
 gHuIT9HPs3wEPJxez7x+DXD+B4ApcS1Xd3Ztil9GCGrzxfcbU29Ol1Tmfc39WAuqEDgHyVI0ani
 oCanCU1RMFivNjgG6oqqMDsQPvNJIW8wKyEgtFixhoX4N3ZqGhSx1z/IBw==
X-Received: by 2002:a05:620a:2a10:b0:915:abc4:b56f with SMTP id
 af79cd13be357-91d8e2a49afmr447676485a.50.1781677157169; Tue, 16 Jun 2026
 23:19:17 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 17 Jun 2026 16:19:04 +1000
X-Gm-Features: AVVi8Cdy-V-7zDT2F6OzBhZaKj8vopIgux3ITBrjr8nttZtBsgV2iUVNtdz9mdU
Message-ID: <CAPM=9tyvcK=48vPeSB-DH8yd9=eZi-77kWgJSAP54d+kJWx6Jw@mail.gmail.com>
Subject: [git pull] drm for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:07:22 +0000
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

This is the main drm pull request for 7.2.

There are some conflicts in amdgpu, panfrost and atomic/colorops code.

I've put a trial merge here:
https://github.com/airlied/linux/tree/drm-next-7.2-rc1-merged

None of them were too confusing, but the panfrost one isn't that
straightforward and amdgpu ones are a bit tricky.

The commit list looks fine but the diffstat looks wonky for some reason.

There should only really be rust things outside of this tree, and
there was a common tag that might already have landed by the time you
get this.

Highlights:
- xe: add initial CRI platform support
- amdgpu: initial HDMI 2.1 FRL support
- rust: add some new type concepts for device lifetimes
- scheduler: moves to a fair algorithm and lots of cleanups

But it's mostly the usual mountain of changes across the board.

Let me know if there are any problems,

Dave.

drm-next-2026-06-17:
drm-next for 7.2-rc1

core:
- add docbook for DRM_IOCTL_SYNCOBJ_EVENTFD
- change signature of drm_connector_attach_hdr_output_metadata_property
- dedup counter and timestamp retrieval in vblank code
- parse AMD VSDB v3 in CTA extension blocks
- add P230, Y7, XYYY2101010, T430, XVUY210101010 formats
- don't call drop master on file close if not master
- use drm_printf_indent in atomic / bridge
- fix 32b format descriptions
- docs: fix toctree
- hdmi: add common TMDS character rates
- fix drm_syncobj_find_fence leak

rust:
- introduce Higher-Ranked lifetime types
- replace drvdata with scoped registration data
- add GPUVM immediate mode abstraction for rust GPU drivers
- introduce DeviceContext type state for drm::Device

bridge:
- clarify drm_bridge_get/put
- create drm_get_bridge_by_endpoint and use it
- analogix_dp: add panel probing
- ite-it6211 - use drm audio hdmi helpers

buddy:
- add lockdep annotations

dp:
- add PR and VRR updates
- mst: fix buffer overflows
- add Adaptive Sync SDP decoding support
- fix OOB reads in dp-mst

ttm:
- bump fpfn/lpfn to 64-bit

scheduler:
- change default to fair scheduler
- map runqueue 1:1 with scheduler

dma-buf:
- port selftests to kunit
- convert dma-buf system/heap allocators to module
- add separate DMABUF_HEAPS_SYSTEM_CC_SHARED Kconfig

udmabuf:
- revert hugetlb support
- fix error with CONFIG_DMA_API_DEBUG

dma-fence:
- fix tracepoints lifetime
- remove unused signal on any support

ras:
- add clear error counter netlink command to drm ras

gpusvm:
- reject VMAs with VM_IO or VM_PFNMAP when creating SVM ranges
- use IOVA allocations

pagemap:
- use IOVA allocations

panels:
- update to use ref counts
- add support for CSW PNB601LS1-2, LGD LP116WHA-SPB1
- add support for waveshare panels
- CMN N116BCN-EA1, CMN N140HCA-EEK, IVO M140NWFQ R5,
- IVO, R140NWFW R0, BOE NT140*, BOE NV133FHM-N4F,
- AUO B140*, AUO B133HAN06.6 and AUO B116XTN02.3 eDP panels
- Surface Pro 12 Panel

xe:
- add CRI PCI-IDs
- debugfs add multi-lrc info
- engine init cleanup
- PF fair scheduling auto provisioning
- system controller support for CRI/Xe3p
- PXP state machine fixes
- Reset/wedge/unload corner case fixes
- Wedge path memory allocation fixes
- PAT type cleanups
- Reject unsafe PAT for CPU cached memory
- OA improvements for CRI device memory
- kernel doc syntax in xe headers
- xe_drm.h documentation fixes
- include guard cleanups
- VF CCS memory pool
- i915/xe step unification
- Xe3p GT tuning fixes
- forcewake cleanup in GT and GuC
- admin-only PF mode
- enable hwmon energy attributes for CRI
- enable GT_MI_USER_INTERRUPT
- refactor emit functions
- oa workarounds
- multi_queue: allow QUEUE_TIMESTAMP register
- convert stolen memory to ttm range manager
- use xe2 style blitter as a feature flag
- make drm_driver const
- add/use IRQ page to HW engine definition
- fix oops when display disabled

i915:
- enable PIPEDMC_ERROR interrupt
- more common display code refactoring
- restructure DP/HDMI sink format handling
- eliminate FB usage from lowlevel pinning code
- panel replay bw optimization
- integrate sharpness filter into the scaler
- new fb_pin abstraction for xe/i915 fb transparent handling
- skip inactive MST connectors on HDCP
- start switching to display specific registers
- use polling when irq unavailable
- Adaptive-sync SDP prep

amdgpu:
- use drm_display_info for AMD VSDB data
- Initial HDMI 2.1 FRL support
- Initial DCN 4.2.1 support
- GART fixes for non-4k pages
- GC 11.5.6/SDMA 6.4.0/and other new IPs
- GFX9/DCE6/Hawaii/SDMA4/GART/Userq fixes
- Finish support for using multiple SDMA queues for TTM operations
- SWSMU updates
- GC 12.1 updates
- SMU 15.0.8 updates
- DCN 4.2 updates
- DC type conversion fixes
- Enable DC power module
- Replay/PSR updates
- SMU 13.x updates
- Compute queue quantum MQD updates
- ASPM fix
- Align VKMS with common implementation
- DC analog support fixes
- UVD 3 fixes
- TCC harvesting fixes for SI
- GC 11 APU module reload fix
- NBIO 6.3.2 support
- IH 7.1 updates
- DC cursor fixes
- VCN/JPEG user fence fixes
- DC support for connectors without DDC
- Prefer ROM BAR for default VGA device
- DC bandwidth fixes
- Add PTL support for profiler
- Introduce dc_plane_cm and migrate surface update color path
- Add FRL registers for HDMI 2.1
- Restructure VM state machine
- Auxless ALPM support
- GEM_OP locking/warning fixes
- switch to system_dfl_wq

amdkfd:
- GPUVM TLB flush fix
- Hotplug fix
- Boundary check fixes
- SVM fixes
- CRIU fixes
- add profiler API
- MES 12.1 updates

msm:
- core:
  - fix shrinker documentation
  - IFPC enabled for gen8
  - PERFCNTR_CONFIG ioctl support
- GPU:
  - reworked UBWC handling
  - a810 support
- MDSS:
  - add support for Milos platform
  - reworked UBWC handling
- DisplayPort:
  - reworked HPD handling as prep for MST
- DPU:
  - Milos platform support
  - reworked UBWC handling
- DSI:
  - Milos platform support

nova:
- Hopper/Blackwell enablement (GH100/GB100/GB202)
  - FSP support
  - 32-bit firmware support
  - HAL functions
- refactor GSP boot/unload
- GA100 support
- VBIOS hardening/refactoring
- Adopt higher order lifetime types

tyr:
- define register blocks
- add shmem backed GEM objects
- adopt higher order lifetime types
- move clock cleanup into Drop

radeon:
- Hawaii SMU fixes
- CS parser fix
- use struct drm_edid instead of edid

amdxdna:
- export per-client BO memory via fdinfo
- AIE4 device support
- support medium/lower power modes
- expandable device heap support
- revert read-only user-pointer BO mappings

ivpu:
- support frequency limiting

panthor:
- enable GEM shrinker support
- add eviction and reclaim info to fdinfo

v3d:
- enable runtime PM

mgag200:
- support XRGB1555 + C8

ast:
- support XRGB1555 + C8
- use constants for lots of registers
- fix register handling

imagination:
- fence handling refactoring

nouveau:
- fix sched double call
- expose VBIOS on GSP-RM systems
- add GA100 support

virtio:
- add VIRTIO_GPU_F_BLOB_ALIGNMENT flag
- add deferred mapping support

gud:
- add RCade Display Adapter

hibmc:
- fix no connectors usage

mediatek:
- hdmi: convert error handling
- simplify mtk_crtc allocation

exynos:
- move fbdev emulation to drm client buffers
- use drm format helpers for geometry/size
- adopt core DMA tracking
- fix framebuffer offset handling

renesas:
- add RZ/T2H SOC support

versilicon:
- add cursor plane support

tegra:
- use drm client for framebuffer
The following changes since commit d18f3646184fc805d213fc049fc3b5d9fb9a6a27=
:

  samples: rust: rust_driver_auxiliary: showcase lifetime-bound
registration data (2026-05-27 16:29:34 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-06-17

for you to fetch changes up to 52d4ab1ca790a668cc8f2c27017138b1c467168c:

  Merge tag 'drm-misc-next-fixes-2026-06-11' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2026-06-13 08:10:38 +1000)

----------------------------------------------------------------
drm-next for 7.2-rc1

core:
- add docbook for DRM_IOCTL_SYNCOBJ_EVENTFD
- change signature of drm_connector_attach_hdr_output_metadata_property
- dedup counter and timestamp retrieval in vblank code
- parse AMD VSDB v3 in CTA extension blocks
- add P230, Y7, XYYY2101010, T430, XVUY210101010 formats
- don't call drop master on file close if not master
- use drm_printf_indent in atomic / bridge
- fix 32b format descriptions
- docs: fix toctree
- hdmi: add common TMDS character rates
- fix drm_syncobj_find_fence leak

rust:
- introduce Higher-Ranked lifetime types
- replace drvdata with scoped registration data
- add GPUVM immediate mode abstraction for rust GPU drivers
- introduce DeviceContext type state for drm::Device

bridge:
- clarify drm_bridge_get/put
- create drm_get_bridge_by_endpoint and use it
- analogix_dp: add panel probing
- ite-it6211 - use drm audio hdmi helpers

buddy:
- add lockdep annotations

dp:
- add PR and VRR updates
- mst: fix buffer overflows
- add Adaptive Sync SDP decoding support
- fix OOB reads in dp-mst

ttm:
- bump fpfn/lpfn to 64-bit

scheduler:
- change default to fair scheduler
- map runqueue 1:1 with scheduler

dma-buf:
- port selftests to kunit
- convert dma-buf system/heap allocators to module
- add separate DMABUF_HEAPS_SYSTEM_CC_SHARED Kconfig

udmabuf:
- revert hugetlb support
- fix error with CONFIG_DMA_API_DEBUG

dma-fence:
- fix tracepoints lifetime
- remove unused signal on any support

ras:
- add clear error counter netlink command to drm ras

gpusvm:
- reject VMAs with VM_IO or VM_PFNMAP when creating SVM ranges
- use IOVA allocations

pagemap:
- use IOVA allocations

panels:
- update to use ref counts
- add support for CSW PNB601LS1-2, LGD LP116WHA-SPB1
- add support for waveshare panels
- CMN N116BCN-EA1, CMN N140HCA-EEK, IVO M140NWFQ R5,
- IVO, R140NWFW R0, BOE NT140*, BOE NV133FHM-N4F,
- AUO B140*, AUO B133HAN06.6 and AUO B116XTN02.3 eDP panels
- Surface Pro 12 Panel

xe:
- add CRI PCI-IDs
- debugfs add multi-lrc info
- engine init cleanup
- PF fair scheduling auto provisioning
- system controller support for CRI/Xe3p
- PXP state machine fixes
- Reset/wedge/unload corner case fixes
- Wedge path memory allocation fixes
- PAT type cleanups
- Reject unsafe PAT for CPU cached memory
- OA improvements for CRI device memory
- kernel doc syntax in xe headers
- xe_drm.h documentation fixes
- include guard cleanups
- VF CCS memory pool
- i915/xe step unification
- Xe3p GT tuning fixes
- forcewake cleanup in GT and GuC
- admin-only PF mode
- enable hwmon energy attributes for CRI
- enable GT_MI_USER_INTERRUPT
- refactor emit functions
- oa workarounds
- multi_queue: allow QUEUE_TIMESTAMP register
- convert stolen memory to ttm range manager
- use xe2 style blitter as a feature flag
- make drm_driver const
- add/use IRQ page to HW engine definition
- fix oops when display disabled

i915:
- enable PIPEDMC_ERROR interrupt
- more common display code refactoring
- restructure DP/HDMI sink format handling
- eliminate FB usage from lowlevel pinning code
- panel replay bw optimization
- integrate sharpness filter into the scaler
- new fb_pin abstraction for xe/i915 fb transparent handling
- skip inactive MST connectors on HDCP
- start switching to display specific registers
- use polling when irq unavailable
- Adaptive-sync SDP prep

amdgpu:
- use drm_display_info for AMD VSDB data
- Initial HDMI 2.1 FRL support
- Initial DCN 4.2.1 support
- GART fixes for non-4k pages
- GC 11.5.6/SDMA 6.4.0/and other new IPs
- GFX9/DCE6/Hawaii/SDMA4/GART/Userq fixes
- Finish support for using multiple SDMA queues for TTM operations
- SWSMU updates
- GC 12.1 updates
- SMU 15.0.8 updates
- DCN 4.2 updates
- DC type conversion fixes
- Enable DC power module
- Replay/PSR updates
- SMU 13.x updates
- Compute queue quantum MQD updates
- ASPM fix
- Align VKMS with common implementation
- DC analog support fixes
- UVD 3 fixes
- TCC harvesting fixes for SI
- GC 11 APU module reload fix
- NBIO 6.3.2 support
- IH 7.1 updates
- DC cursor fixes
- VCN/JPEG user fence fixes
- DC support for connectors without DDC
- Prefer ROM BAR for default VGA device
- DC bandwidth fixes
- Add PTL support for profiler
- Introduce dc_plane_cm and migrate surface update color path
- Add FRL registers for HDMI 2.1
- Restructure VM state machine
- Auxless ALPM support
- GEM_OP locking/warning fixes
- switch to system_dfl_wq

amdkfd:
- GPUVM TLB flush fix
- Hotplug fix
- Boundary check fixes
- SVM fixes
- CRIU fixes
- add profiler API
- MES 12.1 updates

msm:
- core:
  - fix shrinker documentation
  - IFPC enabled for gen8
  - PERFCNTR_CONFIG ioctl support
- GPU:
  - reworked UBWC handling
  - a810 support
- MDSS:
  - add support for Milos platform
  - reworked UBWC handling
- DisplayPort:
  - reworked HPD handling as prep for MST
- DPU:
  - Milos platform support
  - reworked UBWC handling
- DSI:
  - Milos platform support

nova:
- Hopper/Blackwell enablement (GH100/GB100/GB202)
  - FSP support
  - 32-bit firmware support
  - HAL functions
- refactor GSP boot/unload
- GA100 support
- VBIOS hardening/refactoring
- Adopt higher order lifetime types

tyr:
- define register blocks
- add shmem backed GEM objects
- adopt higher order lifetime types
- move clock cleanup into Drop

radeon:
- Hawaii SMU fixes
- CS parser fix
- use struct drm_edid instead of edid

amdxdna:
- export per-client BO memory via fdinfo
- AIE4 device support
- support medium/lower power modes
- expandable device heap support
- revert read-only user-pointer BO mappings

ivpu:
- support frequency limiting

panthor:
- enable GEM shrinker support
- add eviction and reclaim info to fdinfo

v3d:
- enable runtime PM

mgag200:
- support XRGB1555 + C8

ast:
- support XRGB1555 + C8
- use constants for lots of registers
- fix register handling

imagination:
- fence handling refactoring

nouveau:
- fix sched double call
- expose VBIOS on GSP-RM systems
- add GA100 support

virtio:
- add VIRTIO_GPU_F_BLOB_ALIGNMENT flag
- add deferred mapping support

gud:
- add RCade Display Adapter

hibmc:
- fix no connectors usage

mediatek:
- hdmi: convert error handling
- simplify mtk_crtc allocation

exynos:
- move fbdev emulation to drm client buffers
- use drm format helpers for geometry/size
- adopt core DMA tracking
- fix framebuffer offset handling

renesas:
- add RZ/T2H SOC support

versilicon:
- add cursor plane support

tegra:
- use drm client for framebuffer

----------------------------------------------------------------
Aaron Kling (2):
      dt-bindings: display: panel: Add ChipWealth CH13726A AMOLED driver
      drm/tegra: Enable cmu for Tegra186 and Tegra194

Abhishek Rajput (1):
      drm/mediatek: Convert legacy DRM logging to drm_* helpers in mtk_dsi.=
c

Akash Goel (2):
      drm/panthor: Add a GEM shrinker
      drm/panthor: Avoid potential UAF due to memory reclaim

Akhil P Oommen (4):
      drm/msm/a8xx: Make a8xx_recover IFPC safe
      drm/msm/a6xx: Limit GXPD votes to recovery in A8x
      drm/msm/a8xx: Fix RSCC offset
      dt-bindings: display/msm: gpu: Document Adreno X2-185

Alan Liu (1):
      drm/amdgpu/vpe: Force collaborate sync after TRAP

Albert Esteve (10):
      drm/panel/visionox-g2647fb105: Use refcounted allocation in
place of devm_kzalloc()
      drm/panel/samsung-s6e63m0: Use refcounted allocation in place of
devm_kzalloc()
      drm/panel/novatek-nt37700f: Use refcounted allocation in place
of devm_kzalloc()
      drm/panel/lxd-m9189a: Use refcounted allocation in place of devm_kzal=
loc()
      drm/panel/ilitek-ili9806e: Use refcounted allocation in place of
devm_kzalloc()
      drm/panel/tdo-tl070wsh30: Use refcounted allocation in place of
devm_kzalloc()
      drm/panel/sharp-ls043t1le01: Use refcounted allocation in place
of devm_kzalloc()
      drm/panel/truly-nt35597: Use refcounted allocation in place of
devm_kzalloc()
      drm/panel/startek-kd070fhfid015: Use refcounted allocation in
place of devm_kzalloc()
      drm/panel: Make drm_panel_init() static

Alessio Belle (8):
      drm/imagination: Count paired job fence as dependency in prepare_job(=
)
      drm/imagination: Fit paired fragment job in the correct CCCB
      drm/imagination: Skip check on paired job fence during job submission
      drm/imagination: Rename pvr_queue_fence_is_ufo_backed() to reflect us=
age
      drm/imagination: Rename fence returned by pvr_queue_job_arm()
      drm/imagination: Move repeated job fence check to its own function
      drm/imagination: Update check to skip prepare_job() for fragment jobs
      drm/imagination: Minor improvements to job submission code documentat=
ion

Alex Deucher (16):
      drm/amdgpu/gfx7: align mqd settings with KFD
      drm/amdgpu/gfx8: align mqd settings with KFD
      drm/amdgpu/gfx9: align mqd settings with KFD
      drm/amdgpu/gfx10: align mqd settings with KFD
      drm/amdgpu/gfx11: align mqd settings with KFD
      drm/amdgpu/gfx12: align mqd settings with KFD
      drm/amdgpu/gfx9.4.3: align mqd settings with KFD
      drm/amdgpu/gfx12.1: align mqd settings with KFD
      drm/amd/display: properly handle family setting for early GC 11.5.4
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon
      drm/radeon: add missing revision check for CI
      drm/amdgpu: plumb timedout fence through to force completion
      drm/amdgpu: simplify VCN reset helper
      drm/amdgpu/sdma7.1: fix support for disable_kq
      drm/amdkfd: always resume_all after suspend_all

Alex Hung (21):
      drm/amd/display: Remove unused state param from enable_link_analog
      drm/amd/display: Add KUnit test for HDCP process_output
      drm/amd/display: Add KUnit test for colorop TF bitmasks
      drm/amd/display: Add KUnit test for color helpers
      drm/amd/display: Add KUnit test for PSR function
      drm/amd/display: Add KUnit test for replay
      drm/amd/display: Add KUnit test for ISM functions
      drm/amdkfd: Fix UML build guards for x86_64-only code
      drm/amd/display: Enable gcov coverage for amdgpu_dm KUnit builds
      drm/amd/display: Add KUnit tests for color LUT functions
      drm/amd/display: Extract transfer function helpers
      drm/amd/display: Add more color KUnit tests
      drm/amd/display: Refactor amdgpu_dm_initialize_default_pipeline
      drm/amd/display: Fix gamma 2.2 colorop TF direction in tests
      drm/amd/display: Add KUnit tests for amdgpu_dm_colorop
      drm/amd/display: Add more KUnit tests for amdgpu_dm_ism
      drm/amd/display: Extract dm_ism_dispatch_next_event
      drm/amd/display: Add KUnit tests for dm_ism_dispatch_next_event
      drm/amd/display: Add KUnit tests for amdgpu_dm_psr_set_event
      drm/amd/display: Export symbols for KUnit test modules
      drm/amd/display: Clean up PSR helper functions

Alex Sierra (2):
      drm/amdgpu/gfx12_1: Increase reserved memory size to 150M
      drm/amdkfd: fix redundant MQD iterations in GFX v12.1

Alexander Koskovich (6):
      dt-bindings: display/msm/gmu: Document Adreno 810 GMU
      dt-bindings: display/msm/gpu: Document Adreno 810 GPU
      drm/msm/adreno: rename llc_mmio to cx_misc_mmio
      drm/msm/adreno: set cx_misc_mmio regardless of if platform has LLCC
      drm/msm/a8xx: use pipe protect slot 15 for last-span-unbound feature
      drm/msm/adreno: add Adreno 810 GPU support

Alexandre Courbot (8):
      gpu: nova-core: remove unneeded get_gsp_info proxy function
      gpu: nova-core: do not import firmware commands into GSP command modu=
le
      gpu: nova-core: gsp: shuffle boot code a bit to keep
chipset-specific parts close
      gpu: nova-core: gsp: move chipset-specific parts of the boot
process into a HAL
      gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloadin=
g
      gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding
      gpu: nova-core: gsp: run the unload bundle if Gsp::boot() fails
      gpu: nova-core: gsp: enable FSP boot path

Alexandru Dadu (1):
      drm/imagination: Add support for trace points

Alice Ryhl (6):
      drm/gpuvm: take refcount on DRM device
      rust: gpuvm: add GpuVm::obtain()
      rust: gpuvm: add GpuVa struct
      rust: gpuvm: add GpuVmCore::sm_unmap()
      rust: gpuvm: add GpuVmCore::sm_map()
      drm/gpuvm: rust: add RUST_DRM_GPUVM option to Kconfig

Allen Li (2):
      drm/amd/display: Unset Replay desync error verification by default
      drm/amd/display: Add Replay/PSR active check in link loss status chec=
k

Alvin Lee (1):
      drm/amd/display: Update tmz field for LSDMA

Alvin Sun (1):
      drm/tyr: use shmem GEM object type in TyrDrmDriver

Alysa Liu (3):
      drm/amdkfd: Add upper bound check for num_of_nodes
      drm/amdkfd: validate SVM ioctl nattr against buffer size
      drm/amdkfd: fix UAF race in destroy_queue_cpsch

Amber Lin (12):
      drm/amdgpu: Fix gfx_hqd_mask in mes 12.1
      drm/amdgpu: Fixup boost mes detect hang array size
      drm/amdgpu: Fixup detect and reset
      drm/amdgpu: Create hqd info structure
      drm/amdgpu: Update mes 12.1's suspend/resume
      drm/amdgpu: Missing multi-XCC support in MES
      drm/amdgpu: Enable suspend/resume gang in mes 12.1
      drm/amdkfd: Add detect+reset hangs to GC 12.1
      drm/amdkfd: Reset queue/pipe in MES
      drm/amdkfd: Queue reset support in KFD topology
      drm/amdgpu: Support MES suspend_all_sdma_gangs
      drm/amdkfd: Enable SDMA queue reset on gfx v12.1

Amir Shetaia (1):
      drm/amdgpu: reject non-user addresses early in GEM_USERPTR ioctl

Andrew Lichmanov (1):
      drm/amd/display: Remove SYMCLK F and G values from link encoder
and MANUAL_FLOW_CONTROL from optc

Andrew Martin (1):
      drm/amdkfd: Fix buffer overflow in SDMA queue checkpoint/restore on G=
FX11

Andrzej Kacprowski (2):
      accel/ivpu: Add support for limiting NPU frequency
      accel/ivpu: Remove disable_d0i3_msg workaround

Animesh Manna (3):
      drm/display: Add drm helper to check pr optimization support
      drm/i915/display: Add hook to check optimization support for
Intel platforms
      drm/i915/display: Panel Replay BW optimization for DP2.0 tunneling

Ankit Nautiyal (35):
      drm/i915/vrr: Avoid vrr for PCON with HDMI2.1 sink
      drm/i915/dp: Add a helper to decide if AS SDP can be used
      drm/i915/dp: Skip AS SDP for DP branch devices
      drm/i915/intel_sdvo: Check fixed_mode->clock against
max_dotclock in mode_valid
      drm/i915/intel_panel: Avoid calls to intel_panel_fixed_mode() in
mode_valid
      drm/i915/intel_dvo: Drop call to intel_panel_fixed_mode() from
compute_config
      drm/i915/intel_sdvo: Drop call to intel_panel_fixed_mode() from
compute_config
      drm/i915/dp: Drop call to intel_panel_fixed_mode() from compute_confi=
g
      drm/dp: Rename and relocate AS SDP payload field masks
      drm/dp: Clean up DPRX feature enumeration macros
      drm/dp: Add bits for AS SDP FAVT Payload Fields Parsing support
      drm/dp: Add DPCD for configuring AS SDP for PR + VRR
      drm/dp: Refactor AS SDP logging to use space-separated field names
      drm/dp: Store coasting vtotal in struct drm_dp_as_sdp
      drm/dp: Add a helper to get the SDP type as a string
      drm/dp: Add target_rr_divider field in AS SDP logging
      drm/dp: Use drm_printf_indent for DP SDP logging
      drm/i915/dp: Fix readback for target_rr in Adaptive Sync SDP
      drm/i915/dp: Use revision field of AS SDP data structure
      drm/i915/dp: Set sdp_type in AS SDP unpack
      drm/i915/dp: Include all relevant AS SDP fields in comparison
      drm/i915/psr: Simplify the conditions for SCL computation
      drm/i915/psr: Allow SCL=3D0 on platforms with always-on VRR TG
      drm/i915/psr: Add helper to get Async Video timing support in PR acti=
ve
      drm/i915/dp: Add member to intel_dp to store AS SDP v2 support
      drm/i915/dp: Allow AS SDP only if v2 is supported
      drm/i915/psr: Write the PR config DPCDs in burst mode
      drm/i915/display: Add helper for AS SDP transmission time selection
      drm/i915/psr: Program Panel Replay CONFIG3 using AS SDP transmission =
time
      drm/i915/dp: Set relevant Downspread Ctrl DPCD bits for PR + Auxless =
ALPM
      drm/i915/dp: Program AS SDP DB[1:0] for PR with Link off
      drm/i915/dp: Compute and include coasting vtotal for AS SDP
      drm/i915/dp: Compute AS SDP after PSR compute config
      drm/i915/dp: Enable AS SDP whenever VRR is possible or PR !async
      drm/i915/dp: Account for AS_SDP guardband only when enabled

Anoop Vijay (8):
      drm/xe/xe_sysctrl: Add System Controller types and device integration
      drm/xe/xe_sysctrl: Add System Controller mailbox register definitions
      drm/xe/xe_sysctrl: Add ABI and mailbox interface headers
      drm/xe/xe_sysctrl: Add System Controller initialization support
      drm/xe/xe_sysctrl: Add System Controller mailbox communication suppor=
t
      drm/xe/xe_sysctrl: Add System Controller power management support
      drm/xe/xe_pci: Enable System Controller support on CRI platform
      drm/xe/xe_sysctrl: Drop redundant endian conversions in mailbox
header macros

Aric Cyr (2):
      drm/amd/display: Fix assertion due to disable/enable CM blocks
      drm/amd/display: Enable additional wait for pipe pending checks

Arjan van de Ven (1):
      drm/amdgpu: fix zero-size GDS range init on RDNA4

Arnd Bergmann (3):
      drm/ipv3: add CONFIG_OF dependency for DRM_OF_DISPLAY_MODE_BRIDGE
      drm/exynos: fix size_t format string
      dma-buf: move system_cc_shared heap under separate Kconfig

Artur Kowalski (1):
      gpu: host1x: trace: fix string fields in host1x traces

Arun R Murthy (1):
      drm/i915/lt_phy: Update the Tx Swing for DP 1.4

Arvind Yadav (1):
      drm/xe/madvise: Track purgeability with BO-local counters

Asad Kamal (6):
      drm/amd/pm: Align PPTable fill with non-Q10 static metrics
      drm/amd/pm: Add partition metrics support
      drm/amd/pm: Add mem temp to gpu metrics for smu_v15_0_8
      drm/amd/pm: Relax manual min/max clock check
      drm/amd/pm: bound pp_dpm_set_pp_table() memcpy
      drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE

Asahi Lina (1):
      rust: drm: add base GPUVM immediate mode abstraction

Ashutosh Desai (3):
      drm/dp/mst: fix buffer overflows in sideband chunk accumulation
      drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
      drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers

Ashutosh Dixit (7):
      drm/xe/oa: Use xe_map layer
      drm/xe/oa: Use drm_gem_mmap_obj for OA buffer mmap
      drm/xe/oa: Implement Wa_14026633728
      drm/xe/oa: Refactor oa_unit_supports_oa_format
      drm/xe/oa: MERTOA Wa_14026746987
      drm/xe/oa: Add val arg to xe_oa_is_valid_config_reg
      drm/xe/oa: MERTOA Wa_14026779378

Aurabindo Pillai (4):
      drm/amd/display: Add KUnit test for CRC function
      drm/amd/display: widen FRL debug knobs to unsigned int
      drm/amd/display: widen dc_hdmi_frl_flags.force_frl_rate to unsigned i=
nt
      drm/amd/display: use unsigned types for local pipe and REG_GET counte=
rs

Avinal Kumar (2):
      drm/mipi-dsi: add mipi_dsi_shutdown_peripheral_multi
      drm/panel: panasonic-vvx10f034n00: transition to mipi_dsi
wrapped functions

Balasubramani Vivekanandan (5):
      drm/xe/cri: Add new PCI IDs
      drm/xe: Refactor emit_clear_main_copy
      drm/xe: Refactor emit_clear_link_copy
      drm/xe: Refactor emit_xy_fast_copy and emit_mem_copy functions
      drm/xe: Restore IDLEDLY regiter on engine reset

Beata Michalska (1):
      drm/tyr: set DMA mask using GPU physical address

Ben Dooks (1):
      gpu: host1x: Fix missing 'host1x_context_device_bus_type'

Benjamin Cheng (2):
      drm/amdgpu/vcn3: Avoid overflow on msg bound check
      drm/amdgpu/vcn4: Avoid overflow on msg bound check

Benjamin Welton (1):
      amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel
driver changes

Bhuvanachandra Pinninti (1):
      drm/amd/display: Implement block sequencing infrastructure for
modular hardware operations.

Biju Das (9):
      dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3L SoC
      drm/panfrost: Drop redundant optional clock checks in runtime PM
      drm/panfrost: Add bus_ace optional clock support for RZ/G2L
      drm/panfrost: Add GPU_PM_RT support for RZ/G3L SoC
      drm: renesas: rzg2l_mipi_dsi: Move rzg2l_mipi_dsi_set_display_timing(=
)
      drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion delay
      drm: renesas: rzg2l_mipi_dsi: Fix deassert/assert of CMN_RSTB signal
      drm/bridge: ite-it6263: Move chip initialization code from probe
to atomic_enable
      drm/bridge: ite-it6263: Drop unnecessary blank line

Bing Ma (2):
      drm/amdgpu: Add gc v12_1_1 ip headers v3
      drm/amdgpu: Add gc v12_1_0 ip headers v6

Boris Brezillon (10):
      drm/gem: Consider GEM object reclaimable if shrinking fails
      drm/panthor: Remove unused panthor_vm_op_ctx::map::new_vma field
      drm/panthor: Move panthor_gems_debugfs_init() to panthor_gem.c
      drm/panthor: Group panthor_kernel_bo_xxx() helpers
      drm/panthor: Don't call drm_gpuvm_bo_extobj_add() if the object is pr=
ivate
      drm/panthor: Part ways with drm_gem_shmem_object
      drm/panthor: Lazily allocate pages on mmap()
      drm/panthor: Split panthor_vm_prepare_map_op_ctx() to prepare for rec=
laim
      drm/panthor: Track the number of mmap on a BO
      drm/tyr: rename TyrObject to BoData

Brajesh Gupta (5):
      drm/imagination: Restrict init_fw_trace_mask module param to read onl=
y
      drm/imagination: Populate FW common context ID before passing to the =
FW
      drm/imagination: Don't timeout job if its fence has been signaled
      drm/imagination: Rename FW booted to FW initialised
      drm/imagination: Access FW initialised state with READ/WRITE_ONCE

Caden Chien (6):
      drm/amdgpu/nbio: remove doorbell entry5 for vcn on 7.11.4
      drm/amdgpu/nbio: add doorbell range init for vpe on 7.11.4
      drm/amdgpu/vpe: add new vpe v2.0.0 register offset and sh/mask
      drm/amdgpu/vpe: add vpe v2.0.0 support
      drm/amdgpu/nbio: enable doorbell range init for vpe on v7.11.5
      drm/amdgpu/vpe: add vpe v2.2.0 support

Candice Li (12):
      drm/amd/ras: bound CPER record fetch buffer size
      drm/amdgpu: cap ATOM command table nesting depth
      drm/amdgpu: Bound GPIO I2C table entry count from VBIOS
      drm/amdgpu: validate and share PSP fw_pri_buf copies via psp_copy_fw
      drm/amd/pm: return -EINVAL on invalid CCLK OD core index
      drm/amdgpu/pm: fix SmartShift bias sysfs store PM refcount on parse e=
rror
      drm/amd/ras: validate RAS EEPROM tbl_size before record count
      drm/amdgpu: validate RAS EEPROM tbl_size before record count
      drm/amdgpu: NUL-terminate securedisplay debugfs input from userspace
      drm/amd/pm: use kcalloc in phm table copy helpers
      drm/amd/amdxcp: use kasprintf for XCP platform device names
      drm/amd/pm: bound OD parameter parsing to stack array size

Ce Sun (4):
      drm/amdgpu: avoid integer overflow in VA range check
      drm/amdgpu: Fix memory leak of i2s_pdata in ACP initialization
      drm/amd/ras: Add more IP versions for uniras
      drm/amdgpu: Fix user-triggerable BUG()/BUG_ON() calls

Chaitanya Kumar Borah (2):
      drm/i915/dp: Fix VSC dynamic range signaling for RGB formats
      drm/i915/display: Copy color pipeline from plane in the primary
joiner pipe

Charlene Liu (7):
      drm/amd/display: fix hubp tmz field define mismatch
      drm/amd/display: fix dual cursor shows on extend desktop
      drm/amd/display: remove watermark range notify
      drm/amd/display: only call pmfw if smu present flags true
      drm/amd/display: enable ODM 2:1 on single eDP based on pixel clock
      drm/amd/display: Allow power up when PG disallowed in driver
      drm/amd/display: Add DC_VALIDATE_MODE_AND_PROGRAMMING condition
check for force odm2:1

Chen Ni (4):
      drm/rockchip: analogix_dp: Add missing error check for
platform_get_resource()
      drm/xe/vm: Convert comma to semicolon
      drm/amd/display: Remove duplicate include of dce/dmub_hw_lock_mgr.h
      drm/panel: focaltech-ota7290b: Fix error check for devm_drm_panel_all=
oc()

Chen-Yu Tsai (7):
      drm/exynos: Internalize exynos_drm_gem_free_object()
      drm/exynos: Use DRM core dedicated DMA device tracking facility
      drm/exynos: Drop exynos_drm_gem.size field
      drm/exynos: Drop MAX_FB_BUFFER in favor of DRM_FORMAT_MAX_PLANES
      drm/xlnx/zynqmp-dpsub: Fix dependencies for COMPILE_TEST
      drm/panel-edp: Add AUO B133HAN06.6 and BOE NV133FHM-N4F V8.0
      drm/exynos/dma: Drop iommu_dma_init_domain() stub

Cheng-Yang Chou (2):
      gpu: nova, nova-core: Rename to kebab-case
      gpu: nova: Use module names consistently

Chenglei Xie (4):
      drm/amdgpu: fix OOB risk parsing virt RAS batch trace replies on the =
VF
      drm/amdgpu: bound SR-IOV RAS CPER dump parsing against used_size
      drm/amdgpu: Fix TOCTOU on UniRAS  command response size
      drm/amdgpu: grow VF RAS bad page table with bounded dynamic alloc

Chenyu Chen (2):
      drm/edid: Parse AMD Vendor-Specific Data Block
      drm/amd/display: Use drm_display_info for AMD VSDB data

Chris Brandt (1):
      drm: renesas: rz-du: mipi_dsi: Fix return path on error

Christian K=C3=B6nig (17):
      drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG
      drm/amdgpu: rework userq fence signal processing
      dma-buf/dma_fence_array: remove unused functionality v4
      drm/amdgpu: nuke amdgpu_userq_fence_slab v2
      drm/amdgpu: remove deadlocks from amdgpu_userq_pre_reset
      drm/amdgpu: rework amdgpu_userq_signal_ioctl v3
      drm/amdgpu: remove almost all calls to
amdgpu_userq_detect_and_reset_queues
      drm/amdgpu: fix userq hang detection and reset
      drm/amdgpu: rework userq reset work handling
      drm/amdgpu: fix handling in amdgpu_userq_create
      drm/amdgpu: restructure VM state machine v4
      drm/amdgpu: fix amdgpu_hmm_range_get_pages
      drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx
      drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine
      drm/amdgpu: fix waiting for all submissions for userptrs
      drm/amdgpu: deprecate guilty handling
      drm/amdgpu: restart the CS if some parts of the VM are still invalida=
ted

ChunTao Tso (1):
      drm/amd/display: Fix refresh rate round up case

Chuntao Tso (1):
      drm/amd/display: Enable frame skipping in 0x37B

Clay King (1):
      drm/amd/display: Fix warnings

Clint Taylor (1):
      drm/xe/xe3p: add gt tuning TileY 2x2 walk pattern

Cristian Ciocaltea (7):
      drm/rockchip: inno-hdmi: Switch to drmm_kzalloc()
      drm/rockchip: dw_dp: Switch to drmm_kzalloc()
      drm/rockchip: dw_dp: Fix null-ptr-deref in dw_dp_remove()
      drm/rockchip: dw_dp: Simplify error handling
      drm/rockchip: dw_dp: Drop unnecessary #include
      drm/rockchip: dw_hdmi_qp: Switch to drmm_encoder_init()
      drm/bridge: synopsys: dw-dp: Drop useless memory allocation

Cristian Cozzolino (2):
      dt-bindings: display: panel: Add Novatek NT35532 LCD DSI
      drm/panel: Add driver for Novatek NT35532

Cruise Hung (1):
      drm/amd/display: Exclude the MST overhead from BW deallocation

Damon Ding (17):
      drm/bridge: analogix_dp: Add &analogix_dp_plat_data.next_bridge
      drm/bridge: Move legacy bridge driver out of imx directory for
multi-platform use
      drm/exynos: exynos_dp: Remove &exynos_dp_device.ptn_bridge
      drm/exynos: exynos_dp: Remove unused &exynos_dp_device.connector
      drm/exynos: exynos_dp: Apply of-display-mode-bridge to parse the
display-timings node
      drm/bridge: analogix_dp: Remove redundant
&analogix_dp_plat_data.skip_connector
      drm/bridge: analogix_dp: Move the color format check to
.atomic_check() for Rockchip platforms
      drm/bridge: analogix_dp: Remove unused &analogix_dp_plat_data.get_mod=
es()
      drm/bridge: analogix_dp: Remove unused struct drm_connector* for
&analogix_dp_plat_data.attach()
      drm/bridge: analogix_dp: Pass struct drm_atomic_state* for
analogix_dp_bridge_mode_set()
      drm/bridge: analogix_dp: Apply drm_bridge_connector helper
      drm/bridge: analogix_dp: Add new API analogix_dp_finish_probe()
      drm/rockchip: analogix_dp: Apply analogix_dp_finish_probe()
      drm/exynos: exynos_dp: Apply analogix_dp_finish_probe()
      drm/bridge: analogix_dp: Attach the next bridge in
analogix_dp_bridge_attach()
      drm/bridge: analogix_dp: Remove bridge disabing and panel
unpreparing in analogix_dp_unbind()
      drm/bridge: analogix_dp: Apply panel_bridge helper

Daniel Almeida (1):
      drm/tyr: Use register! macro for GPU_CONTROL

Daniele Ceraolo Spurio (5):
      drm/xe/pxp: Clean up termination status on failure
      drm/xe/pxp: Remove incorrect handling of impossible state during susp=
end
      drm/xe/pxp: Clear restart flag in pxp_start after jumping back
      drm/xe/pxp: Don't allow PXP on older PTL GSC FWs
      drm/xe: Suppress reset log for killed queues

Danilo Krummrich (9):
      Merge remote-tracking branch 'drm/drm-next' into drm-rust-next
      Merge tag 'dd-lifetimes-7.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core
into drm-rust-next
      gpu: nova-core: use lifetime for Bar
      gpu: nova-core: unregister sysmem flush page from Drop
      gpu: nova-core: replace ARef<Device> with &'bound Device in SysmemFlu=
sh
      gpu: nova-core: gsp: replace ARef<Device> with &'a Device in sequence=
r
      gpu: nova: separate driver type from driver data
      drm/tyr: separate driver type from driver data
      drm/tyr: use IoMem directly instead of Devres

Dario Binacchi (2):
      dt-bindings: display: simple: Add AM-1280800W8TZQW-T00H
      drm/panel: simple: Add AM-1280800W8TZQW-T00H

Dave Airlie (26):
      Merge tag 'drm-xe-next-2026-04-30' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'drm-misc-next-2026-04-20' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-intel-next-2026-05-05' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'amd-drm-next-7.2-2026-05-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2026-05-07' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-next-7.2-2026-05-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      drm/bridge/rockchip: fix build after atomic API change.
      Merge tag 'drm-misc-next-2026-05-14' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-xe-next-2026-05-14' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'drm-intel-next-2026-05-14' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'amd-drm-next-7.2-2026-05-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2026-05-21' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-xe-next-2026-05-21' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'mediatek-drm-next-20260521' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-next
      Merge tag 'exynos-drm-next-for-v7.2' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-next
      Merge tag 'drm-xe-next-2026-05-28' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'drm-intel-next-2026-05-28' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-misc-next-2026-05-28' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-intel-gt-next-2026-05-29' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'amd-drm-next-7.2-2026-05-29' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-msm-next-2026-05-30' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge tag 'amd-drm-next-7.2-2026-06-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-rust-next-2026-06-04' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
      Merge tag 'amd-drm-next-7.2-2026-06-04' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2026-06-05' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-misc-next-fixes-2026-06-11' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next

David Francis (3):
      drm/amdkfd: Check bounds on allocate_doorbell
      drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id
      drm/amdkfd: Check for pdd drm file first in CRIU restore path

David Heidelberg (4):
      dt-bindigs: display: extend the LVDS codec with Triple 10-BIT
LVDS Transmitter
      drm/panel: Clean up S6E3FC2X01 config dependencies
      drm/panel: Clean up S6E3HA2 config dependencies and fill help text
      drm/panel: Enable GPIOLIB for panels which uses functions from it

David Rosca (1):
      drm/amdgpu/userq: Fix reading timeline points in wait ioctl

David Zhang (10):
      accel/amdxdna: Add basic support for AIE4 devices
      accel/amdxdna: Create common PSP interfaces for AIE2 and AIE4
      accel/amdxdna: Add AIE4 firmware loading
      accel/amdxdna: Create common SMU interfaces for AIE2 and AIE4
      accel/amdxdna: Add AIE4 power on and off support
      accel/amdxdna: Add initial support for AIE4 VF
      accel/amdxdna: Init AIE4 device partition
      accel/amdxdna: Add AIE4 VF hardware context create and destroy
      accel/amdxdna: Add command doorbell and wait support
      accel/amdxdna: Add AIE4 metadata query support

Deborah Brouwer (7):
      drm/tyr: Print GPU_ID without filtering
      drm/tyr: Use register! macro for JOB_CONTROL
      drm/tyr: Use register! macro for MMU_CONTROL
      drm/tyr: Remove custom register struct
      drm/tyr: Add DOORBELL_BLOCK registers
      drm/tyr: move clock cleanup into Clocks Drop impl
      drm/tyr: add shmem backing for GEM objects

Deepanshu Kartikey (1):
      drm/virtio: use uninterruptible resv lock for plane updates

Desnes Nunes (1):
      drm/i915/dmc: use display instead of dereferencing dmc in
intel_dmc_update_dc6_allowed_count()

Dharma Balasubiramani (3):
      drm/bridge: microchip-lvds: Remove unused drm_panel and
redundant port node lookup
      drm/bridge: microchip-lvds: migrate to atomic bridge ops
      drm/bridge: microchip-lvds: fix bus format mismatch with VESA display=
s

Dibin Moolakadan Subrahmanian (3):
      drm/i915/dmc: Remove invalid PIPEDMC interrupt bits
      drm/i915/dmc: Enable PIPEDMC_ERROR interrupt
      drm/i915/dmc: Reduce wakelock hold time

Dillon Varone (2):
      drm/amd/display: Add minimum vfp requirement
      drm/amd/display: Fix Color Manager (3DLUT, Shaper, Blend)

Dmitry Baryshkov (49):
      dt-bindings: display: panel: add Waveshare LCD panels
      drm/panel: simple: add Waveshare LCD panels
      dt-bindings: display/panel: himax,hx83102: describe Waveshare panel
      dt-bindings: display/panel: himax,hx8394: describe Waveshare panel
      dt-bindings: display/panel: jadard,jd9365da-h3: describe Waveshare pa=
nel
      dt-bindings: dipslay/panel: describe panels using Focaltech OTA7290B
      drm/of: add helper to count data-lanes on a remote endpoint
      drm/panel: himax-hx83102: support Waveshare 12.3" DSI panel
      drm/panel: himax-hx8394: set prepare_prev_first
      drm/panel: himax-hx8394: simplify hx8394_enable()
      drm/panel: himax-hx8394: support Waveshare DSI panels
      drm/panel: jadard-jd9365da-h3: use drm_connector_helper_get_modes_fix=
ed
      drm/panel: jadard-jd9365da-h3: support variable DSI configuration
      drm/panel: jadard-jd9365da-h3: set prepare_prev_first
      drm/panel: jadard-jd9365da-h3: support Waveshare round DSI panels
      drm/panel: jadard-jd9365da-h3: support Waveshare WXGA DSI panels
      drm/panel: jadard-jd9365da-h3: support Waveshare 720p DSI panels
      drm/panel: add devm_drm_panel_add() helper
      drm/panel: add driver for Waveshare 8.8" DSI TOUCH-A panel
      dt-bindings: display: waveshare,dsp2dpi: describe DSI2LVDS setup
      drm/bridge: waveshare-dsi: support DSI LCD kits with LVDS panels
      dt-bindings: display/panel: ilitek,ili9881c: describe Waveshare panel
      drm/panel: ilitek-ili9881c: support Waveshare 7.0" DSI panel
      soc: qcom: ubwc: define UBWC 3.1
      soc: qcom: ubwc: define helper for MDSS and Adreno drivers
      soc: qcom: ubwc: add helper controlling AMSBC enablement
      Merge branch
'20260507-ubwc-rework-v4-4-c19593d20c1d@oss.qualcomm.com' of
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into HEAD
      drm/ci: disable mr-label-maker-test
      drm/msm/mdss: correct UBWC programming sequences
      drm/msm/adreno: use qcom_ubwc_version_tag() helper
      drm/msm/mdss: use qcom_ubwc_version_tag() helper
      drm/msm/adreno: use new helper to set min_acc length
      drm/msm/mdss: use new helper to set min_acc length
      drm/msm/adreno: use new helper to set macrotile_mode
      drm/msm/mdss: use new helper to set macrotile_mode
      drm/msm/mdss: use new helper to set UBWC bank spreading
      drm/msm/adreno: use new helper to set ubwc_swizzle
      drm/msm/dpu: use new helper to set ubwc_swizzle
      drm/msm/mdss: use new helper to set ubwc_swizzle
      drm/msm/adreno: write reserved UBWC-related bits
      drm/msm/adreno: set fp16compoptdis for UBWC 3.0 formats
      drm/msm/adreno: use new helper to set amsbc
      drm/msm/adreno: use version ranges in A8xx UBWC code
      drm/msm/mdss: use new helper to set amsbc
      drm/msm/dpu: drop ubwc_dec_version
      drm/msm/dpu: invert the order of UBWC checks
      drm/msm/dp: drop event data
      drm/msm/dp: turn link_ready into plugged
      drm/msm/dp: clear EDID on display unplug

Dmitry Osipenko (1):
      drm/virtio: Extend blob UAPI with deferred-mapping hinting

Dmytro Laktyushkin (2):
      drm/amd/display: Enable dcn42 pstate pmo
      drm/amd/display: Add DCN42 PMO init_for_pstate_support

Dominik Kaszewski (1):
      drm/amd/display: Fix DPMS using partially updated pipe context

Donet Tom (1):
      drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K page size syst=
ems

Dongyang Jin (1):
      drm/panel: fix kernel-doc warning for devm_drm_panel_add()

Eduardo Vasconcelos (1):
      drm/crc: Fix typo in doc for drm_crtc_crc

Eliot Courtney (25):
      gpu: nova-core: simplify and_then with condition to filter
      gpu: nova: require little endian
      gpu: nova-core: vbios: stop scanning at BIOS_MAX_SCAN_LEN
      gpu: nova-core: vbios: use checked arithmetic for bios image range en=
d
      gpu: nova-core: vbios: avoid reading too far in read_more_at_offset
      gpu: nova-core: vbios: read BitToken using FromBytes
      gpu: nova-core: vbios: use checked ops and accesses in
`FwSecBiosImage::ucode`
      gpu: nova-core: vbios: use checked access in `FwSecBiosImage::header`
      gpu: nova-core: vbios: use checked accesses in `setup_falcon_data`
      gpu: nova-core: vbios: drop unused falcon_data_offset from
FwSecBiosBuilder
      gpu: nova-core: vbios: keep PmuLookupTable local in setup_falcon_data
      gpu: nova-core: vbios: compute FWSEC-relative Falcon data offset
      gpu: nova-core: vbios: simplify setup_falcon_data
      gpu: nova-core: vbios: read PMU lookup entries using FromBytes
      gpu: nova-core: vbios: store PMU lookup entries in a KVVec
      gpu: nova-core: vbios: construct `FwSecBiosImage` directly from
BIOS images
      gpu: nova-core: vbios: use the first PCI-AT image
      gpu: nova-core: vbios: use single logical block for the FWSEC section
      gpu: nova-core: vbios: use let-else in Vbios::new
      gpu: nova-core: vbios: remove unnecessary fields in PciRomHeader
      gpu: nova-core: vbios: drop unused image wrappers
      gpu: nova-core: vbios: drop redundant TryFrom import
      gpu: nova-core: vbios: move constants and functions to be associated
      gpu: nova-core: vbios: remove unused rom_header field
      gpu: nova-core: add non-sec2 unload path

Eric Huang (3):
      drm/amdkfd: remove obsolete codes for kfd_mmap
      drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
      drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger

Ethan Tidmore (2):
      drm/bridge: analogix_dp: Extract error pointer from correct variable
      drm/panel: jadard-jd9365da-h3: Fix signedness bug

Fangzhi Zuo (2):
      drm/amd/display: add HDMI 2.1 Compliance Support
      drm/amd/display: Disable FRL and add module param to enable it

Feifei Xu (3):
      drm/amdgpu: Place psp pri_fw bo to VRAM on A+A
      drm/amdgpu: Add size guard before copy discovery binary
      drm/amdgpu: fix shift-out-bounds warning of number_instance

Felix Gu (3):
      accel/amdxdna: Fix memory leak in amdxdna_iommu_alloc()
      gpu: host1x: mipi: Fix device_node reference leak in tegra_mipi_reque=
st()
      drm/tegra: dc: Fix device node reference leak in tegra_dc_has_output(=
)

Felix Kuehling (2):
      drm/amdkfd: Make all TLB-flushes heavy-weight
      drm/ttm: Support 52-bit PAs in ttm_place

Francesco Dolcini (1):
      MAINTAINERS: Update maintainer for LT8912B DRM HDMI bridge

Francois Dugast (2):
      drm/xe: Document GT statistics
      drm: Drop HPAGE_PMD_SIZE dependency in dma_iova_try_alloc calls

Gabe Teeger (1):
      drm/amd/display: Handle aux_inst for connectors without DDC pin

Gabriel Almeida (2):
      drm/amdgpu: move program_aspm to amdgpu_nbio
      drm/amdgpu: move read_indexed_register to amdgpu_reg_access

Gaghik Khachatrian (16):
      drm/amd/display: Fix implicit narrowing conversion warnings
      drm/amd/display: Fix narrowing boundaries and eDP parser assignment
      drm/amd/display: Fix dml2_0 narrowing boundaries
      drm/amd/display: Update MCIF_ADDR macro to address IGT DWB regression
      drm/amd/display: Fix implicit conversion warning
      drm/amd/display: Fix narrowing boundaries in dml
      drm/amd/display: Fix type mismatches in DML and normalize loop bounds
      drm/amd/display: Do DML float narrowing explicit
      drm/amd/display: Fix type mismatches in DC and DMUB modules
      drm/amd/display: Fix type mismatches using guards and explicit casts
      drm/amd/display: fix buffer overruns warnings
      drm/amd/display: Fix signed/unsigned comparison mismatches
      drm/amd/display: Fix compiler warnings in dml2
      drm/amd/display: Fix multiple compiler warnings
      drm/amd/display: always-true lower-bound assert
      drm/amd/display: Fix enum decl warnings

Gangliang Xie (3):
      drm/amdgpu: add first record offset check
      drm/amd/ras: add first record offset check
      drm/amd/ras: return error when converting records to nps pages fails

Gary Guo (1):
      gpu: nova-core: move lifetime to `Bar0`

Guangshuo Li (1):
      gpu: host1x: Fix device reference leak in
host1x_device_parse_dt() error path

Gustavo Sousa (23):
      drm/xe/xe3p_lpg: Add missing indirect ring state feature flag
      drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_stat=
us()
      drm/xe: Define CACHE_MODE_1 as MCR register
      drm/xe: Define and use MCR version of COMMON_SLICE_CHICKEN1
      drm/xe: Define and use MCR version of COMMON_SLICE_CHICKEN4
      drm/xe: Extract xe_hw_engine_setup_reg_lrc()
      drm/xe/kunit: Use KUNIT_EXPECT_EQ() in xe_wa_gt()
      drm/xe/mcr: Extract reg_in_steering_type_ranges()
      drm/xe/reg_sr: Do sanity check for MCR vs non-MCR
      drm/xe/guc: Use xe_device_is_l2_flush_optimized()
      drm/i915/bw: Don't call intel_dram_info() too early
      drm/i915/bw: Extract platform-specific parameters
      drm/i915/bw: Deduplicate intel_sa_info instances
      drm/i915/bw: Rename struct intel_sa_info to intel_display_bw_params
      drm/i915/bw: Extract get_display_bw_params()
      drm/i915/dmc_wl: Remove macro HAS_DMC_WAKELOCK()
      drm/xe/rtp: Write kunit test cases specific for rule matching
      drm/xe/rtp: Drop rule matching cases from rtp_to_sr_cases and rtp_cas=
es
      drm/xe/rtp: Don't short-circuit to false in or-yes case
      drm/xe/rtp: Do not break parsing when missing context
      drm/xe/rtp: Extract rule_match_item()
      drm/xe/rtp: Fully parse the ruleset
      drm/xe/rtp: Implement a structured parser for rule matching

Hamza Mahfooz (2):
      drm/edid: add CTA Video Format Data Block support
      drm/hyperv: use VMBUS_RING_SIZE()

Harish Chegondi (1):
      drm/xe/eustall: Return ENODEV from read if EU stall registers get res=
et

Harish Kasiviswanathan (6):
      drm/amdgpu: In GFX12.1 CU is same as WGP
      drm/amdgpu: Set chicken bit for gfx_v12.1 xnack
      drm/amdgpu: Set default xnack mode for gfx_v12.1 A0/B0
      drm/amdkfd: Limit per-process xnack support for GFX12.1
      drm/amdgpu: Use asic specific pte_addr_mask
      drm/amdgpu: drm/amdgpu: Set correct DMA mask for gfx12.1

Harrison Vanderbyl (1):
      drm/panel-edp: Add panel for Surface Pro 12in

Harry Wentland (23):
      drm/amdgpu: Remove UML build exclusion from Kconfig
      drm/amd/display: Fix integer overflow in bios_get_image()
      drm/amd/display: Validate GPIO pin LUT table size before iterating
      drm/amd/display: Validate payload length and link_index in
dc_process_dmub_aux_transfer_async
      drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval(=
)
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array siz=
e
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()
      drm/amd/display: Reject gpio_bitshift >=3D 32 in
bios_parser_get_gpio_pin_info()
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Bound VBIOS record-chain walk loops
      drm/amd/display: Add HDMI FRL definitions to includes
      drm/amd/display: Add DML changes to support HDMI FRL
      drm/amd/display: add HDMI 2.1 FRL base support to DML 2.0
      drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL
      drm/amd/display: Add FRL support to clk_mgr, dsc, hdcp
      drm/amd/display: Tie FRL programming together in HWSS
      drm/amd/display: Add DC resource support for FRL
      drm/amd/display: Add DC link support for FRL
      drm/amd/display: Add support for FRL to DC core
      drm/amd/display: Update HDCP and info_packet modules for FRL
      drm/amd/display: Tie FRL support into amdgpu_dm
      drm/amd/display: add HDMI 2.1 DSC over FRL support

Hawking Zhang (4):
      drm/amdgpu: Add nbio v6_3_2 ip headers v4
      drm/amdgpu: Add nbio v6_3_2 support
      drm/amdgpu: Switch to gfx_v12_1_get_xccs_per_xcp
      drm/amdgpu: Add node_id-to-die-name decoding for ih v7_1

Honglei Huang (1):
      drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages

Hongling Zeng (5):
      nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions
      nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd
      nouveau/gsp/rm: cleanup IS_ERR_OR_NULL in core implementation
      nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)
      nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage

Hongyan Xu (1):
      drm/amdgpu: avoid double drm_exec_fini() in userq validate

Ian Chen (1):
      drm/amd/display: Skip HDR metadata update when Smart Power OLED enabl=
ed

Icenowy Zheng (7):
      drm: verisilicon: make vs_format conversion function return int
      drm: verisilicon: subclass drm_plane_state
      drm: verisilicon: call atomic helper's plane state check even if no C=
RTC
      drm: verisilicon: fill plane's vs_format in atomic_check
      drm: verisilicon: add max cursor size to HWDB
      drm: verisilicon: add support for cursor planes
      drm: verisilicon: fix build failure of cursor plane code

Ilya Bakoulin (2):
      drm/amd/display: Fix double free
      drm/amd/display: Avoid DPMS-on for phantom stream

Imre Deak (7):
      drm/i915/ddi: Fix cleanup after DP connector init failure
      drm/i915/ddi: Fix cleanup after HDMI connector init failure
      drm/i915/dp: Reset link params after a DPRX capability change
      drm/i915/dp: Add helper to set common link params
      drm/i915/dp: Cache max common lane count
      drm/i915/dp: Detect changes in common link parameters
      drm/dp: Add DSC virtual DPCD quirk for Realtek MST branch device

Ion Agorria (1):
      drm/tegra: gr2d/gr3d: Contain PM in the gr*d_probe/gr*d_remove

Ivan Lipski (7):
      drm/amd/display: Remove Mall, SubVP and MCLK from DCN42
      drm/amd/display: Add additional IPS entry/exit for PSR/Replay
      drm/amd/display: Enable IPS on DCN42
      drm/amd/display: Write REFCLK to 48MHz on DCN21
      drm/amd/display: Initialize dsc_caps to 0
      drm/amd/display: Add a default case for dc_status_to_str
      drm/amd/display: Rename hdmi_frl_borrow_mode

Jacob McLemore (1):
      drm/tegra: sor: Remove usage of drm_simple_encoder_init()

Jakub Kolakowski (1):
      drm/xe/sriov: Mark NVL as SR-IOV capable

James Lin (2):
      drm/amd/display: Add some missing code for dcn42
      Revert "drm/amd/display: dmub_cmd.h: add missing kernel-doc for enums=
"

Jani Nikula (70):
      Merge drm/drm-next into drm-intel-next
      drm/{i915, xe}: convert VLV sideband display wrappers into real funct=
ions
      drm/i915: pass struct intel_display * to VLV sideband wrappers
      drm/i915/dram: prefer display abstractions for VLV sideband
      drm/i915: move VLV IOSF sideband to display parent interface
      drm/{i915, xe}: add shared header for VLV IOSF sideband units
and registers
      drm/xe/fbdev: put intel_fbdev_fb_prefer_stolen() behind
IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
      drm/{i915, xe}/fbdev: drop drm device parameter from
intel_fbdev_fb_fill_info()
      drm/{i915, xe}: move fbdev fb calls to parent interface
      drm/i915: pass struct drm_i915_private to i915_bo_fbdev_prefer_stolen=
()
      drm/xe: pass struct xe_device to xe_display_bo_fbdev_prefer_stolen()
      drm/i915: move intel_fb_pin.c to i915_fb_pin.c
      drm/i915/pin: s/dev_priv/i915/ and drop struct drm_device usage
      drm/i915/pin: switch to i915 core runtime pm
      drm/i915/mchbar: include intel_mchbar_regs.h from intel_mchbar.h
      drm/i915/mchbar: drop unnecessary intel_mchbar_regs.h include
      drm/i915/mchbar: move intel_mchbar_regs.h under include/drm/intel
      drm/i915: drop unnecessary intel_pci_config.h include
      drm/i915/pci: move intel_pci_config.h under include/drm/intel
      Merge drm/drm-next into drm-intel-next
      drm/xe/step: switch to the shared step definitions with i915
      drm/xe/step: switch from enum xe_step to intel_step naming
      drm/i915/display: switch to including common step file directly
      Merge tag 'topic/step-2026-04-09' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-intel-next
      Merge tag 'topic/pipe-reorder-2026-04-15' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-intel-next
      drm/i915/ddi: add wrapper for calling ->get_buf_trans() hook
      drm/atomic: prefer drm_printf_indent() over inline \t
      drm/bridge: prefer drm_printf_indent() over inline \t
      drm/i915/display: move audio funcs under audio sub-struct
      drm/i915/display: move color funcs under color sub-struct
      drm/i915/display: move fdi funcs under fdi sub-struct
      drm/i915/display: move watermark funcs under wm sub-struct
      drm/i915/display: move hotplug irq funcs under hotplug sub-struct
      drm/i915/display: move dpll funcs under dpll sub-struct
      drm/i915/display: move cdclk funcs under cdclk sub-struct
      drm/i915/display: move display funcs under modeset sub-struct
      Revert "drm/i915: replace select with dependency for visible
DEBUG_OBJECTS"
      drm/i915/irq: drop unnecessary forward declarations and includes
      Documentation/gpu: add dedicated documentation for Intel display
      Documentation/gpu: use =3D=3D=3D for Intel display section heading un=
derlines
      Documentation/gpu: add remaining DOC: comments to Intel display
documentation
      Documentation/gpu: limit main toctree depth to 2
      Documentation/gpu: add some tables of contents to large documents
      Documentation/gpu/rfc: fix toctree
      drm/i915/display: add typedef for intel_reg_t and use it
      drm/i915/display: add struct intel_irq_regs and use it
      drm/i915/display: add struct intel_error_regs and use it
      drm/i915/display: define and use intel_reg_{offset, equal,
valid}() helpers
      drm/i915/sdvo: use the i2c bus locking functions
      drm/xe/display: fix oops in suspend/shutdown without display
      drm/i915/irq: deduplicate dg1_de_irq_postinstall() and
gen11_de_irq_postinstall()
      drm/i915/irq: constify pipe stats parameters
      drm/i915/irq: add display irq funcs, start with intel_display_irq_res=
et()
      drm/i915/irq: add intel_display_irq_postinstall() to irq funcs
      drm/i915/irq: add platform specific display irq ack functions
      drm/i915/irq: add platform specific display irq handler functions
      drm/i915/irq: add intel_display_irq_ack() to irq funcs
      drm/i915/irq: add intel_display_irq_handler() to irq funcs
      drm/i915: relocate intel_hpd_cancel_work() call
      drm/{i915, xe}: move xe_display_flush_cleanup_work() to i915 display
      drm/i915/display: switch from drm_for_each_crtc() to for_each_intel_c=
rtc()
      drm/i915/display: always pass display->drm to for_each_intel_crtc*()
      drm/i915/display: pass struct intel_display to all
for_each_intel_crtc*() macros
      drm/i915/display: stop passing i to
for_each_*_intel_crtc_in_state() macros
      drm/i915/display: stop passing i to
for_each_pipe_crtc_modeset_{enable, disable}()
      drm/i915/power: make intel_power_domains_{suspend, resume}() static
      drm/i915/power: rename intel_power_domains_*() to intel_display_power=
_*()
      drm/i915/power: drop resume parameter from intel_display_power_init_h=
w()
      drm/i915/power: add "runtime" to intel_display_power_{suspend,
resume}() names
      drm/i915: rename intel_runtime_{suspend, resume} to
i915_pm_runtime_{suspend, resume}

Janusz Krzysztofik (2):
      drm/i915: Skip deprecated selftest
      drm/i915: Fix potential UAF in TTM object purge

Jason Gunthorpe (6):
      udmabuf: Do not create malformed scatterlists
      dma-buf: Change st-dma-resv.c to use kunit
      dma-buf: Change st-dma-fence.c to use kunit
      dma-buf: Change st-dma-fence-unwrap.c to use kunit
      dma-buf: Change st-dma-fence-chain.c to use kunit
      dma-buf: Remove the old selftest

Javier Martinez Canillas (12):
      drm/imagination: Fix missing argument in pvr_power_fw_{en,dis}able()
      video/hdmi: Add common TMDS character rate constants
      drm/bridge: dw-hdmi: Use the common TMDS char rate constant
      drm/bridge: dw-hdmi-qp: Use the common TMDS char rate constant
      drm/bridge: inno-hdmi: Use the common TMDS char rate constant
      drm/sti: hdmi: Use the common TMDS char rate constants
      drm/sun4i: hdmi: Use the common TMDS char rate constant
      drm/msm/hdmi: Use the common TMDS char rate constants in 8996 PHY
      drm/msm/hdmi: Use the common TMDS char rate constants in 8998 PHY
      drm/bridge: ite-it66121: Switch to the HDMI connector helpers
      drm/bridge: ite-it66121: Move .mode_set logic to .atomic_enable
      drm/bridge: ite-it66121: Select HDMI or DVI mode based on sink type

Jeevana Muthyala (1):
      drm/amdgpu/vcn5.0.0: enable secure submission on unified ring
for VCN 5.3.0

Jeremy Klarenbeek (2):
      drm/amd/pm/si: Fix updating clock limits from power states
      drm/amd/pm/si: Notify the SMC when switching to AC

Jesse Zhang (1):
      drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP header on GFX12

Jessica Zhang (7):
      drm/msm/dp: fix HPD state status bit shift value
      drm/msm/dp: Fix the ISR_* enum values
      drm/msm/dp: Read DPCD and sink count in bridge detect()
      drm/msm/dp: Move link training to atomic_enable()
      drm/msm/dp: Drop EV_USER_NOTIFICATION
      drm/msm/dp: rework HPD handling
      drm/msm/dp: Add sink_count to debug logs

Jia Yao (2):
      drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in madvi=
se
      drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR

Jing Zhou (1):
      drm/amd/display: fix root clock disabled when DSC power gate
disabled for DCN314

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

John Hubbard (29):
      gpu: nova-core: use SizeConstants trait for u64 size constants
      gpu: nova-core: make WPR heap sizing fallible
      gpu: nova-core: factor .fwsignature* selection into a new
find_gsp_sigs_section()
      gpu: nova-core: use GPU Architecture to simplify HAL selections
      gpu: nova-core: Hopper/Blackwell: basic GPU identification
      gpu: nova-core: add Copy/Clone to Spec and Revision
      gpu: nova-core: move GFW boot wait into a GPU HAL
      gpu: nova-core: Hopper/Blackwell: skip GFW boot waiting
      gpu: nova-core: refactor SEC2 booter loading into BooterFirmware::run=
()
      gpu: nova-core: set DMA mask width based on GPU architecture
      gpu: nova-core: Hopper/Blackwell: new location for PCI config mirror
      gpu: nova-core: Blackwell: compute PMU-reserved framebuffer size
      gpu: nova-core: Hopper/Blackwell: larger non-WPR heap
      gpu: nova-core: Hopper/Blackwell: larger WPR2 (GSP) heap
      gpu: nova-core: Blackwell: use correct sysmem flush registers
      gpu: nova-core: don't assume 64-bit firmware images
      gpu: nova-core: add support for 32-bit firmware images
      gpu: nova-core: add auto-detection of 32-bit, 64-bit firmware images
      gpu: nova-core: Hopper/Blackwell: add FSP falcon engine stub
      gpu: nova-core: Hopper/Blackwell: add FMC firmware image
      gpu: nova-core: Hopper/Blackwell: add FSP secure boot completion wait=
ing
      gpu: nova-core: Hopper/Blackwell: add FMC signature extraction
      gpu: nova-core: Hopper/Blackwell: add FSP falcon EMEM operations
      gpu: nova-core: Hopper/Blackwell: add FSP message infrastructure
      gpu: nova-core: add MCTP/NVDM protocol types for firmware communicati=
on
      gpu: nova-core: Hopper/Blackwell: add FSP send/receive messaging
      gpu: nova-core: Hopper/Blackwell: select FSP Chain of Trust version
      gpu: nova-core: Hopper/Blackwell: add FSP Chain of Trust boot
      gpu: nova-core: Hopper/Blackwell: add GSP lockdown release polling

Jonathan Cavitt (5):
      drm/xe/vm: Add missing pad and extensions check
      drm/xe/tlb: Init range tilemask err to zero
      drm/gpuvm: Do not prepare NULL objects
      drm/colorop: Check if getting curve_1d_type default succeeds
      drm/auth: Only drm_drop_master if it exists

Joonas Lahtinen (3):
      drm/i915/gem: Drop check for changed VM in EXECBUF
      Merge drm/drm-next into drm-intel-gt-next
      Revert "i915: don't use a vma that didn't match the context VM"

Joshua Peisach (2):
      drm/radeon/radeon_connectors: use struct drm_edid instead of struct e=
did
      drm/radeon/radeon_connectors: remove radeon_connector_free_edid

Jouni H=C3=B6gander (11):
      drm/i915/psr: Do not use pipe_src as borders for SU area
      drm/i915/psr: Init variable to avoid early exit from et alignment loo=
p
      drm/i915/psr: Disable Panel Replay on Dell XPS 16 DA16260 as a quirk
      drm/i915/psr: Disable PSR2 on Xiaomi Book Pro 14 2026 as a quirk
      drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD regis=
ter
      drm/i915/psr: Read Intel DPCD workaround register
      drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used
      drm/i915/psr: Apply SDP on prior scanline workaround for Xe3p
      drm/i915/psr: Block DC states on vblank enable when Panel Replay supp=
orted
      drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable
      drm/i915/display: Handle odd position for planar formats in
selective fetch

Juha-Pekka Heikkila (1):
      drm/i915/display: enable ccs modifiers on dg2

Julia Filipchuk (1):
      drm/xe: Enable Wa_14025515070

Julian Braha (1):
      drm/i915: replace select with dependency for visible DEBUG_OBJECTS

J=C3=A9r=C3=B4me de Bretagne (1):
      drm/panel-edp: Add LG LP129WT232166 panel

Karol Wachowski (2):
      accel/ivpu: Fix swapped register names in pwr_island_drive functions
      accel/ivpu: Document why full JSM message size is always used

Karthik Poosa (2):
      drm/xe/hwmon: Read accepted power limit for CRI
      drm/xe/hwmon: Enable energy attributes for CRI

Karunika Choo (8):
      drm/panthor: Pass an iomem pointer to GPU register access helpers
      drm/panthor: Split register definitions by components
      drm/panthor: Replace cross-component register accesses with helpers
      drm/panthor: Store IRQ register base iomem pointer in panthor_irq
      drm/panthor: Use a local iomem base for GPU registers
      drm/panthor: Use a local iomem base for PWR registers
      drm/panthor: Use a local iomem base for firmware control registers
      drm/panthor: Use a local iomem base for MMU AS registers

Kent Russell (1):
      drm/amdgpu: Only send RMA CPER when threshold is exceeded

Konrad Dybcio (1):
      drm/msm/adreno: Trust the SSoT UBWC config

Krzysztof Karas (2):
      drm/i915/selftests: Prevent userspace mapping invalidation
      drm/i915/selftests: Run vma tests only if current->mm is present

Lad Prabhakar (4):
      dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H and RZ/N2H support
      drm: renesas: rz-du: Make DU reset control optional for RZ/T2H suppor=
t
      drm: renesas: rz-du: Move mode_valid logic to per-SoC clock limits
      drm: renesas: rz-du: Add support for RZ/T2H SoC

Laura Nao (1):
      rust: drm: add FEAT_RENDER flag for render node support

Laurent Pinchart (2):
      drm: rcar-du: Fix crash when no CMM is available
      drm: uapi: Use SPDX in DRM core uAPI headers

Le Ma (1):
      drm/amdgpu: make driver manages local vram allocations for for
gmc v12.1 A+A

Leo Chen (4):
      drm/amd/display: Enable driver power gating
      drm/amd/display: Enable HUBP/OPTC/DPP power gating
      drm/amd/display: Disable hpo power gate
      drm/amd/display: Revert "Enable HUBP/OPTC/DPP power gating"

Leo Li (2):
      drm/amd/display: Undo accidental fix revert in amdgpu_dm_ism.c
      drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs

Leon Huang (1):
      drm/amd/display: Add Auxless-ALPM support in VESA Panel Replay

Leonardo Cesar (1):
      drm/amdgpu: deduplicate ring preempt ib function

Leorize (1):
      drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs

Lijo Lazar (10):
      drm/amd/pm: Enable thermal alert on SMUv15.0.8
      drm/amd/pm: Add thermal alert logging to smu15.0.8
      drm/amd/pm: Check SMUv13.0.6/12 metrics integrity
      drm/amd/pm: Update emit clock logic
      drm/amd/pm: Add fine grained flag to SMU v13.0.6
      drm/amdgpu: Prefer ROM BAR for default VGA device
      drm/amdgpu: Add helper to set gart size
      drm/amdgpu: Use helper to set gart size
      drm/amdgpu: Fix discovery offset check under VF
      drm/amd/pm: Use strscpy in profile mode parsing

Likun Gao (6):
      drm/amdgpu: update cp cmd pkt for gfx v12_1 v2
      drm/amdgpu: support rlc_1 fw load for gc 12_1
      drm/amdgpu: support toc_1 fw load for mp0 v15_0_8
      drm/amdgpu: add doorbell range function for nbio v6_3_2
      drm/amdgpu: support nbio v6_3_2
      drm/amdgpu: update cp cmd pkt for gfx v12_1

Lin He (4):
      drm/hisilicon/hibmc: add updating link cap in DP detect()
      drm/hisilicon/hibmc: fix no showing when no connectors connected
      drm/hisilicon/hibmc: move display contrl config to hibmc_probe()
      drm/hisilicon/hibmc: use clock to look up the PLL value

Liviu Dudau (1):
      drm/syncobj: Fix memory leak in drm_syncobj_find_fence()

Lizhi Hou (16):
      accel/amdxdna: Create shared functions for AIE2 and AIE4
      accel/amdxdna: Adjust size for copy_to_user()
      accel/amdxdna: Expose per-client BO memory usage via fdinfo
      accel/amdxdna: Read real-time clock frequencies
      accel/amdxdna: Check for device hang on job timeout
      accel/amdxdna: Fix iommu_map_sgtable() return value handling
      accel/amdxdna: Fix order of canceled mailbox messages
      accel/amdxdna: Set default DPM level based on QoS for temporal-only m=
ode
      accel/amdxdna: Fix clflush buffer size
      accel/amdxdna: Add expandable device heap support
      Revert "accel/amdxdna: Support read-only user-pointer BO mappings"
      accel/amdxdna: Preserve user address when PASID is disabled
      accel/amdxdna: Remove drv_cmd tracing from job free callback
      accel/amdxdna: Return errors for failed debug BO commands
      accel/amdxdna: Require carveout when PASID and force_iova are disable=
d
      accel/amdxdna: Clear sva pointer after unbind

Lohita Mudimela (3):
      drm/amd/display: Separate ABM functions into dedicated power_abm.c fi=
le
      drm/amd/display: Refactor PSR functionality into dedicated
power_psr module
      drm/amd/display: Refactor Replay functionality into dedicated
power_replay module

Luca Ceresoli (77):
      drm/kmb/dsi: convert to of_drm_find_and_get_bridge()
      drm/omap: dss: convert to of_drm_find_and_get_bridge()
      drm/bridge: drm_bridge_get/put(): document NULL pointer behaviour
      drm/mxsfb/lcdif: simplify remote pointer management using __free
      drm/mxsfb/lcdif: simplify ep pointer management using __free
      drm/mxsfb/lcdif: use dev_err_probe() consistently in lcdif_attach_bri=
dge
      drm/mxsfb/lcdif: move iteration-specific variables declaration
inside loop in lcdif_attach_bridge
      drm/bridge: dw-hdmi: document the output_port field
      drm/bridge: dw-hdmi: warn on unsupported attach combination
      drm/bridge: dw-hdmi: move next_bridge lookup to attach time
      drm/bridge: imx8mp-hdmi-tx-connector-fixup: add an
hdmi-connector when missing using a DT overlay at boot time
      drm/bridge: imx8mp-hdmi-tx-connector-fixup: show a warning when
adding the overlay
      drm/bridge: imx8mp-hdmi-tx: switch to DRM_BRIDGE_ATTACH_NO_CONNECTOR
      drm/mxsfb/lcdif: use DRM_BRIDGE_ATTACH_NO_CONNECTOR and the
bridge-connector
      drm/encoder: add mutex to protect the bridge chain
      drm/encoder: drm_encoder_cleanup: lock the encoder chain mutex
during removal
      drm/bridge: drm_bridge_attach: lock the encoder chain mutex
during insertion
      drm/bridge: lock the encoder chain in scoped for_each loops
      drm/bridge: prevent encoder chain changes while iterating with
list_for_each_entry_from()
      drm/bridge: prevent encoder chain changes while iterating with
list_for_each_entry_reverse()
      drm/bridge: prevent encoder chain changes in pre_enable/post_disable
      drm: renesas: rz-du: rzg2l_du_encoder: convert to
of_drm_find_and_get_bridge()
      drm: rcar-du: encoder: convert to of_drm_find_and_get_bridge()
      drm/display: bridge-connector: attach the encoder to the created conn=
ector
      drm: adp: remove now-redundant call to drm_connector_attach_encoder()
      drm/bridge: adv7511: remove now-redundant call to
drm_connector_attach_encoder()
      drm/bridge: ite-it6263: remove now-redundant call to
drm_connector_attach_encoder()
      drm/bridge: ti-sn65dsi86: remove now-redundant call to
drm_connector_attach_encoder()
      drm/imx/dcss: remove now-redundant call to drm_connector_attach_encod=
er()
      drm/imx: ldb: remove now-redundant call to drm_connector_attach_encod=
er()
      drm/imx: parallel-display: remove now-redundant call to
drm_connector_attach_encoder()
      drm/imx/lcdc: remove now-redundant call to drm_connector_attach_encod=
er()
      drm/ingenic: remove now-redundant call to drm_connector_attach_encode=
r()
      drm/kmb/dsi: remove now-redundant call to drm_connector_attach_encode=
r()
      drm/mediatek: mtk_dpi: remove now-redundant call to
drm_connector_attach_encoder()
      drm/mediatek: mtk_dsi: remove now-redundant call to
drm_connector_attach_encoder()
      drm/meson: encoder_cvbs: remove now-redundant call to
drm_connector_attach_encoder()
      drm/meson: encoder_hdmi: remove now-redundant call to
drm_connector_attach_encoder()
      drm/msm/dp: remove now-redundant call to drm_connector_attach_encoder=
()
      drm/msm/hdmi: remove now-redundant call to drm_connector_attach_encod=
er()
      drm/omapdrm: remove now-redundant call to drm_connector_attach_encode=
r()
      drm/rockchip: cdn-dp: remove now-redundant call to
drm_connector_attach_encoder()
      drm/rockchip: rk3066_hdmi: remove now-redundant call to
drm_connector_attach_encoder()
      drm/tegra: hdmi: remove now-redundant call to
drm_connector_attach_encoder()
      drm/tegra: rgb: remove now-redundant call to
drm_connector_attach_encoder()
      drm/tests: bridge: remove now-redundant call to
drm_connector_attach_encoder()
      drm: verisilicon: remove now-redundant call to
drm_connector_attach_encoder()
      drm/exynos: exynos_dp: remove now-redundant call to
drm_connector_attach_encoder()
      drm: rcar-du: encoder: remove now-redundant call to
drm_connector_attach_encoder()
      drm: renesas: rz-du: rzg2l_du_encoder: remove now-redundant call
to drm_connector_attach_encoder()
      drm/rockchip: analogix_dp: remove now-redundant call to
drm_connector_attach_encoder()
      drm/rockchip: dw_dp: remove now-redundant call to
drm_connector_attach_encoder()
      drm/rockchip: dw_hdmi_qp: remove now-redundant call to
drm_connector_attach_encoder()
      drm/rockchip: inno-hdmi: remove now-redundant call to
drm_connector_attach_encoder()
      drm/msm/mdp4: remove now-redundant call to drm_connector_attach_encod=
er()
      drm/msm/dsi: remove now-redundant call to drm_connector_attach_encode=
r()
      drm/mxsfb/lcdif: remove now-redundant call to
drm_connector_attach_encoder()
      drm/rockchip: lvds: remove now-redundant call to
drm_connector_attach_encoder()
      drm/tidss: remove now-redundant call to drm_connector_attach_encoder(=
)
      drm/tilcdc: remove now-redundant call to drm_connector_attach_encoder=
()
      drm: zynqmp_kms: remove now-redundant call to
drm_connector_attach_encoder()
      drm/imx: dc: remove now-redundant call to drm_connector_attach_encode=
r()
      drm/rockchip: rgb: remove now-redundant call to
drm_connector_attach_encoder()
      drm: renesas: shmobile: remove now-redundant call to
drm_connector_attach_encoder()
      drm/bridge: ti-sn65dsi83: add test pattern generation support
      MAINTAINERS: add Luca Ceresoli as reviewer for DRM bridge code
      drm/bridge: drm_bridge_put(): ignore ERR_PTR
      drm/bridge: add of_drm_get_bridge_by_endpoint()
      drm/msm/hdmi: switch to of_drm_get_bridge_by_endpoint()
      drm/hisilicon/kirin: switch to of_drm_get_bridge_by_endpoint()
      drm/bridge: chrontel-ch7033: switch to of_drm_get_bridge_by_endpoint(=
)
      drm/bridge: lontium-lt9611uxc: switch to of_drm_get_bridge_by_endpoin=
t()
      drm/bridge: lt9611: switch to of_drm_get_bridge_by_endpoint()
      drm/bridge: adv7511: switch to of_drm_get_bridge_by_endpoint()
      drm/bridge: lt8713sx: switch to of_drm_get_bridge_by_endpoint()
      drm: zynqmp_dp: switch to of_drm_get_bridge_by_endpoint()
      drm: of: forbid bridge-only calls to drm_of_find_panel_or_bridge()

Luca Coelho (8):
      drm/i915: move SKL clock gating init to display
      drm/i915: move KBL clock gating init to display
      drm/i915/display: move CFL clock gating init to display
      drm/i915/display: move BXT clock gating init to display
      drm/i915/display: move GLK clock gating init to display
      drm/i915/display: move HSW and BDW clock gating init to display
      drm/i915/display: move pre-HSW clock gating init to display
      drm/i915: remove HAS_PCH_NOP() dependency from clock gating

Luca Leonardo Scorcia (1):
      drm/mediatek: dsi: Add compatible for mt8167-dsi

Luca Weiss (7):
      dt-bindings: display: msm-dsi-phy-7nm: document the Milos DSI PHY
      dt-bindings: display: msm-dsi-controller-main: document the
Milos DSI Controller
      dt-bindings: display: msm: document the Milos DPU
      dt-bindings: display: msm: document the Milos Mobile Display Subsyste=
m
      drm/msm/dsi: add support for DSI-PHY on Milos
      drm/msm: mdss: Add Milos support
      drm/msm/dpu: Add Milos support

Lyude Paul (11):
      drm/nouveau/kms/nvd9-: Remove unused header in crc.c
      Revert "nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage"
      Revert "nouveau/gsp/rm: cleanup IS_ERR_OR_NULL in core implementation=
"
      Revert "nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)"
      Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd"
      Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions"
      rust: drm: gem: s/device::Device/Device/ for shmem.rs
      drm/gem/shmem: Introduce __drm_gem_shmem_free_sgt_locked()
      rust/drm: Introduce DeviceContext
      rust/drm/gem: Add DriverAllocImpl type alias
      rust/drm/gem: Use DeviceContext with GEM objects

Maarten Lankhorst (3):
      Revert "drm/edid: add CTA Video Format Data Block support"
      drm/intel/display: Add support for pipe background color (v4)
      drm/i915: Remove useless comment about MTRR.

Maciej Falkowski (1):
      MAINTAINERS: accel/ivpu: Remove myself and add Andrzej as maintainer

Mallesh Koujalagi (2):
      drm/xe: Apply WA_14026999295 to engine
      drm/xe/xe_survivability: Simplify runtime survivability error handlin=
g

Marco Crivellari (6):
      drm/tilcdc: replace use of system_wq with system_percpu_wq
      drm/nouveau: replace use of system_unbound_wq with system_dfl_wq
      drm/nouveau: WQ_PERCPU added to alloc_workqueue users
      drm/bridge: replace use of system_wq with system_percpu_wq
      drm/amd/display: Replace use of system_unbound_wq with system_dfl_wq
      drm/amdgpu: Replace use of system_unbound_wq with system_dfl_wq

Marek Vasut (4):
      dt-bindings: vendor-prefixes: Add Displaytech Ltd.
      dt-bindings: display: simple: Document Displaytech DT050BTFT-PTS pane=
l
      drm/panel: simple: Add Displaytech DT050BTFT-PTS panel
      dt-bindings: display: bridge: lt9211: Require data-lanes on DSI
input ports

Marijn Suijten (1):
      drm/panel: Clean up SOFEF00 config dependencies

Mario Limonciello (5):
      drm/amd: Adjust ASPM support quirk to cover more Intel hosts
      drm/amd: Reduce code duplication in runtime PM
      drm/amd: Add dedicated helper for amdgpu_device_find_parent()
      drm/amd: Fix amdgpu_device_find_parent()
      drm/amdgpu: Adjust _PR3 detection

Mario Limonciello (AMD) (1):
      amdkfd: Only ignore -ENOENT for KFD init failuires

Matt Roper (18):
      drm/xe: Drop redundant rtp entries for Wa_14019988906 & Wa_1401987713=
8
      drm/xe/tuning: Stop applying CCCHKNREG1 tuning from Xe3p onward
      drm/xe/tuning: Use proper register offset for GAMSTLB_CTRL
      drm/xe: Mark ROW_CHICKEN5 as a masked register
      drm/xe/debugfs: Correct printing of register whitelist ranges
      drm/xe: Drop skip_mtcfg descriptor flag
      drm/xe: Steer MCR for NODE/L3BANK according to L3 fusing on Xe2/Xe3
      drm/xe: Move CCS enablement to engine setup RTP
      drm/xe/rtp: Add "always true" match function
      drm/xe: Stop programming BLIT_CCTL on Xe2 and later platforms
      drm/xe: Move HWSTAM programming to RTP
      drm/xe: Fix name and definition of GFX_MODE register
      drm/xe: Const-ify parameters to xe_device_has_* functions
      drm/xe: Move GFX_MODE programming to RTP
      drm/xe: Drop unnecessary STOP_RING clearing
      drm/xe: Drop xe_hw_engine_mmio_write32()
      drm/xe: Mark BCS engines as belonging to the GT forcewake domain
      drm/xe: Make decision to use Xe2-style blitter instructions a feature=
 flag

Matthew Auld (2):
      drm/xe/dma-buf: handle empty bo and UAF races
      drm/xe/dma-buf: fix UAF with retry loop

Matthew Brost (10):
      drm/xe: Disable garbage collector work item on SVM close
      drm/xe: Avoid memory allocations in xe_device_declare_wedged()
      drm/xe: Drop registration of guc_submit_wedged_fini from
xe_guc_submit_wedge()
      drm/gpusvm: Reject VMAs with VM_IO or VM_PFNMAP when creating SVM ran=
ges
      drm/gpusvm: Use dma-map IOVA alloc, link, and sync API in GPU SVM
      drm/pagemap: Drop source_peer_migrates flag and assume true
      drm/pagemap: Split drm_pagemap_migrate_map_pages into device / system
      drm/pagemap: Use dma-map IOVA alloc, link, and sync API for DRM pagem=
ap
      drm/pagemap: Fix drm_pagemap_migrate_unmap_pages kerneldoc
      drm/xe: Add timestamp_ms to LRC snapshot

Matthew Stewart (11):
      drm/amd/display: Refactor dc_link_aux_transfer_raw
      drm/amd/display: Add no_native_i2c codepath
      drm/amd: Add register header files for DCN42B
      drm/amd/display: Add DCN42B DC resource files
      drm/amd/display: Add dcn42b_soc_bb to DML2
      drm/amd/display: Add DCN42B code to DC
      drm/amd/display: Add DCN42B DMUB support
      drm/amd/display: Enable DCN 4.2.1 in amdgpu_dm
      drm/amd/display: Enable DM for DCN 4.2.1
      drm/amd/display: Fix DCN42B version detection
      drm/amd/display: Add DCN42B to dml21_translation_helper

Max Krummenacher (1):
      drm/bridge: lontium-lt8912b: Do not generate HFP

Max Zhen (9):
      accel/amdxdna: Fix leak when pinning ubuf pages
      accel/amdxdna: Support read-only user-pointer BO mappings
      accel/amdxdna: Handle DETACH_DEBUG_BO through config_debug_bo path
      accel/amdxdna: Fix fatal_error_info layout in firmware interface
      accel/amdxdna: Add hardware scheduler time quantum support
      accel/amdxdna: Get device revision to derive VBNV string
      accel/amdxdna: Guard management mailbox channel cleanup against
NULL pointer
      accel/amdxdna: Improve tracing for job lifecycle and mailbox RX worke=
r
      accel/amdxdna: Add carveout memory support for non-IOMMU systems

Maxim Schwalm (1):
      drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1

Maxime Ripard (7):
      drm: Rename struct drm_atomic_state to drm_atomic_commit
      Documentation: drm: Remove drm_atomic_state rename entry
      Merge drm/drm-next into drm-misc-next
      dma-buf: heaps: Export mem_accounting parameter
      dma-buf: heaps: cma: Turn the heap into a module
      dma-buf: heaps: system: Turn the heap into a module
      arm64: defconfig: Enable dma-buf heaps

Ma=C3=ADra Canal (8):
      drm/vc4: Use devm_request_irq() for automatic cleanup
      drm/vc4: Clean-up UAPI header inclusion
      drm/v3d: Use devm_reset_control_get_optional_exclusive()
      drm/v3d: Allocate all resources before enabling the clock
      drm/v3d: Introduce Runtime Power Management
      drm/connector: Make
drm_connector_attach_hdr_output_metadata_property() return void
      drm/v3d: Flush MMU TLB and cache during runtime resume
      drm/v3d: Clean caches before runtime suspend

Michael Bommarito (1):
      drm/amdgpu: fix lock leak on ENOMEM in AMDGPU_GEM_OP_GET_MAPPING_INFO

Michal Simek (1):
      drm/amdgpu/jpeg: Fix sprintf buffer overflow warning in jpeg_v2_5

Michal Wajdeczko (44):
      drm/xe/uc: Track uc firmware state changes
      drm/xe/guc: Add support for NO_RESPONSE_BUSY in CTB
      drm/xe/guc: Update POLICY_SCHED_IF_IDLE documentation
      drm/xe/pf: Fix pf_get_sched_priority() function signature
      drm/xe/pf: Force new VFs prorities only once
      drm/xe/pf: Print applied policy KLVs
      drm/xe/pf: Reprovision policy settings after GT reset
      drm/xe/pf: Don't reprovision policies if already default
      drm/xe/pf: Encode scheduling priority KLV if needed
      drm/xe/pf: Check EQ/PT/PRIO when testing VF config
      drm/xe/pf: Allow to change sched_if_idle policy under lock
      drm/xe/pf: Reprovision scheduling to default when no VFs
      drm/xe/pf: Extract helper to show which VFs are provisioned
      drm/xe/pf: Extract helpers for bulk EQ/PT provisioning
      drm/xe/pf: Perform fair scheduling auto-provisioning
      drm/xe/pf: Fix VF's scheduling priority reporting
      drm/xe: Drop unused ggtt_balloon field
      drm/xe/memirq: Update interrupt handler logic
      drm/xe/memirq: Enable GT_MI_USER_INTERRUPT only
      drm/xe: Drop unused drm/drm_atomic_helper.h include
      drm/xe/display: Drop xe_display_driver_remove() stub
      drm/xe/display: Prefer forward declarations
      drm/xe/display: Add macro with display driver ops
      drm/xe/display: Add macro with display driver features
      drm/xe/display: Drop xe_display_driver_set_hooks()
      drm/xe: Make drm_driver const
      drm/xe/vf: Fix signature of print functions
      drm/xe: Add IRQ page to HW engine definition
      drm/xe/memirq: Make page layout macros private
      drm/xe/memirq: Update GuC initialization and IRQ handler
      drm/xe/memirq: Use IRQ page from HW engine definition
      drm/xe/memirq: Reduce buffer size
      drm/xe/memirq: Update diagnostic message
      drm/xe/memirq: Dump all source pages if MSI-X
      drm/xe/memirq: Drop cached iosys_map for MEMIRQ mask
      drm/xe/memirq: Drop cached iosys_map for MEMIRQ status
      drm/xe: Use raw device ID to find sub-platform descriptor
      drm/xe: Drop unused param from xe_device_create()
      drm/xe: Move xe->info.force_execlist initialization
      drm/xe: Move xe->info.devid|revid initialization
      drm/xe: Separate early xe_device initialization
      drm/xe/pm: Don't access device in init_early()
      drm/xe/pm: Do early initialization in init_early()
      drm/xe: Move xe_uc_fw_abi.h to abi/

Micha=C5=82 Grzelak (10):
      drm/i915/aux: use polling when irqs are unavailable
      drm/i915/casf: fix comment typos
      drm/i915/casf: rename *_coef*() into *_coeff*()
      drm/i915: rename t into tap
      drm/i915/casf: rename sumcoeff into sum_coeff
      drm/i915/scaler: s/i/scaler_id/ where appropriate
      drm/i915/scaler: remove id in favor of scaler_id
      drm/i915/scaler: unloop scaler readout that is run once
      drm/i915/scaler: abstract scaler searching loop
      drm/i915/scaler: eliminate dead code

Michel D=C3=A4nzer (1):
      drm/amd/display: Consult MCCS FreeSync cap only if requested & suppor=
ted

Mikhail Gavrilov (3):
      udmabuf: fix DMA direction mismatch in release_udmabuf()
      dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warn=
ing
      drm/amd/display: Wrap DCN32 phantom-plane allocation in
DC_RUN_WITH_PREEMPTION_ENABLED

Mikko Perttunen (3):
      gpu: host1x: Allow entries in BO caches to be freed
      gpu: host1x: Fix iommu_map_sgtable() return value check
      drm/tegra: Fix iommu_map_sgtable() return value check

Mingyu Wang (1):
      agp/amd64: Fix broken error propagation in agp_amd64_probe()

Mohanram Meenakshisundaram (1):
      drm/xe/pf: Fix CFI failure in debugfs access

Muhammad Bilal (1):
      drm/amdkfd: fix NULL dereference in get_queue_ids()

Myeonghun Pak (1):
      drm/tve200: Fix probe cleanup after register failure

Nareshkumar Gollakoti (1):
      drm/xe: Set GT rp min frequency as 1.2GHz default for BMG/CRI

Nathan Chancellor (1):
      drm/msm: Restore second parameter name in purge() and evict()

Nemesa Garg (1):
      drm/i915/pfit: Prevent negative coordinates in center mode

Nicholas Kazlauskas (1):
      drm/amd/display: Enable DCN42 PMO policy

Nicolas Frattaroli (2):
      drm/panthor: Implement evicted status for GEM objects
      drm/panthor: Reduce padding in gems debugfs for refcount

Niranjana Vishwanathapura (3):
      drm/xe/multi_queue: Remove redundant assignment in guc_exec_queue_run=
_job
      drm/xe/multi_queue: Refactor CGP_SYNC send path
      drm/xe/multi_queue: Fix secondary queue error case

Nishad Saraf (3):
      accel/amdxdna: Set the system efficiency factor to 2
      accel/amdxdna: Add configuring low and medium power mode
      accel/amdxdna: Add AIE4 work buffer initialization

Osama Abdelkader (1):
      drm/bridge: chipone-icn6211: use devm_drm_bridge_add in dsi probe

Ovidiu Bunea (5):
      drm/amd/display: Find link encoder for flexible DIG mapping cases
      drm/amd/display: Revert "Unify fast update classification paths"
      drm/amd/display: Update get_pixel_clk_frequency() for DCN4x DCCG DP D=
TO
      drm/amd/display: Change default driver setting for "Force ODM2:1
for eDP" policy
      drm/amd/display: Fix DP_PIXEL_FORMAT fields & update clk_src for DCN4=
x

Parth Pancholi (1):
      drm/bridge: tc358768: Set pre_enable_prev_first for reverse order

Perry Yuan (21):
      drm/amdgpu: add new performance monitor PSP interfaces
      drm/amdgpu: add psp interfaces for peak tops limiter driver
      drm/amdgpu: add PTL enable/query gfx control support for GC 9.4.4
      drm/amdkfd: add kgd control interface for ptl
      Documentation/amdgpu: Add documentation for Peak Tops Limiter
(PTL) sysfs interface
      drm/amdgpu: add sysfs for Peak Tops Limiter (PTL)
      drm/amdkfd: Add PTL control IOCTL Option and unify refcount logic
      drm/amdkfd: suspend scheduler during PTL re-enabling
      drm/amdgpu: Track PTL disable requests by source
      drm/amdgpu: add amdgpu.ptl module parameter for PTL control
      drm/amdgpu: add new data types F8 and Vector for PTL
      drm/amdgpu: Wait for GFX idle before PTL state transition
      drm/amdgpu: check PSP response status in psp_ptl_invoke
      drm/amdgpu: add SPI idle check for GC 9.4.4 in gfx_v9_4_3_is_idle()
      drm/amdgpu: Move KFD sched stop/start into PTL control path
      drm/amdgpu: create PTL sysfs after XGMI reset-on-init restore
      drm/amdkfd: fix unhalt_cpsch warning during module unload
      drm/amdgpu: only set PTL SYSFS disable bit when PTL is disabled
      drm/amdgpu/gfx9.4.3: skip PTL disable during GPU reset
      drm/amdgpu: fix ptl state isssue after GPU reset or suspend
      drm/amdkfd: bump KFD ioctl minor version to 1.23

Philip Yang (3):
      drm/amdgpu: Move amdgpu_device_check_iommu_direct_map() earlier
      drm/amdgpu: Move VM PTE MTYPE override to per-PTE granularity
      drm/amdgpu: zero-initialize GART table on allocation

Philipp Stanner (2):
      drm/sched: Make drm_sched_entity_kill() a public function
      drm/nouveau: Fix double call to drm_sched_entity_fini()

Pierre-Eric Pelloux-Prayer (9):
      drm/amdgpu: pass all the sdma scheds to amdgpu_mman
      drm/amdgpu: only use working sdma schedulers for ttm
      drm/amdgpu: create multiple clear/move ttm entities
      drm/amdgpu: give ttm entities access to all the sdma scheds
      drm/amdgpu: get rid of amdgpu_ttm_clear_buffer
      drm/amdgpu: rename amdgpu_fill_buffer as amdgpu_ttm_clear_buffer
      drm/amdgpu: split amdgpu_ttm_set_buffer_funcs_status in 2 funcs
      drm/amdgpu: use DRM_SCHED_PRIORITY_KERNEL for all ttm entities
      drm/amdgpu: fix root reservation in amdgpu_vm_handle_fault

Pranay Samala (1):
      drm/i915/color: Fix HDR pre-CSC LUT programming loop

Pratik Vishwakarma (7):
      drm/amdgpu: Add support for GC IP version 11.5.6
      drm/amdgpu: add support for SDMA IP version 6.4.0
      drm/amdgpu: add support for NBIO IP version 7.11.5
      drm/amdgpu: add support for IH IP version 6.4.0
      drm/amdgpu: add support for HDP IP version 6.4.0
      drm/amdgpu: add support for MMHUB IP version 3.4.2
      drm/amdgpu: Add support for SMU 15.0.5

Prike Liang (4):
      drm/amdgpu: clean up the userq unmap error handler
      drm/amdgpu: reserve TTM move fences slot for rearming eviction fences
      drm/amdgpu: unmap userq for evicting user queue
      drm/amdgpu: improve the userq seq BO free bit lookup

Priya Hosur (1):
      drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
set_soft_freq_limited_range

Raag Jadav (7):
      drm/xe/guc_pc: Make xe_guc_pc_stop() void
      drm/xe/guc_pc: Reorder forcewake in xe_guc_pc_fini_hw()
      drm/xe/gt: Drop redundant forcewake
      drm/xe/sysctrl: Add system controller interrupt handler
      drm/xe/sysctrl: Add system controller event support
      drm/xe/ras: Introduce correctable error handling
      drm/xe/hw_error: Cleanup array map

Rafal Ostrowski (3):
      drm/amd/display: Align HWSS fast commit path with legacy path
      drm/amd/display: Unify fast update classification paths
      drm/amd/display: Introduce dc_plane_cm and migrate surface
update color path

Randy Dunlap (6):
      drm/amd/display: dmub_cmd.h: correct typos and spellos
      drm/amd/display: dmub_cmd.h: correct all kernel-doc prototype warning=
s
      drm/amd/display: dmub_cmd.h: add missing kernel-doc for enums
      drm/amdgpu: amdgpu{_reset}.h: fix all kernel-doc warnings
      drm/tegra: dp: fix kernel-doc warnings in dp.h
      drm/tegra: tegra_drm.h: fix all uapi kernel-doc warnings

Ray Wu (7):
      drm/amd/display: Introduce power module on Linux
      drm/amd/display: Add power module on Linux
      drm/amd/display: Rename backlight_properties to pwr_backlight_propert=
ies
      drm/amd/display: Fix white screen on boot with OLED panel
      drm/amd/display: Fix ISM dc_lock deadlock during suspend
      drm/amd/display: Use lockdep_assert_held() for dc_lock check
      drm/amd/display: Fix amdgpu_dm KUnit allmodconfig build

Riana Tauro (2):
      drm/drm_ras: Add clear-error-counter netlink command to drm_ras
      drm/xe/xe_drm_ras: Add support for clear-error-counter in XE drm_ras

Rob Clark (16):
      drm/msm: Remove obsolete perf infrastructure
      drm/msm: Allow CAP_PERFMON for setting SYSPROF
      drm/msm/adreno: Sync registers from mesa
      drm/msm/registers: Sync gen_header.py from mesa
      drm/msm/registers: Add perfcntr json
      drm/msm: Add a6xx+ perfcntr tables
      drm/msm: Add sysprof accessors
      drm/msm/a6xx: Add yield & flush helper
      drm/msm: Add per-context perfcntr state
      drm/msm: Add basic perfcntr infrastructure
      drm/msm/a6xx+: Add support to configure perfcntrs
      drm/msm/a8xx: Add perfcntr flush sequence
      drm/msm: Add PERFCNTR_CONFIG ioctl
      drm/msm/a6xx: Increase pwrup_reglist size
      drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
      drm/msm/a6xx: Allow IFPC with perfcntr stream

Rob Herring (Arm) (1):
      accel: ethosu: Validate SRAM size on submit

Robert Ancell (1):
      drm/fourcc: Fix descriptions of 32b float formats

Rodrigo Siqueira (9):
      drm/amd/display: Add FRL registers for DCN30
      drm/amd/display: Add required FRL registers for DCN31
      drm/amd/display: Add FRL registers for DCN321
      drm/amd/display: Introduce FRL registers for DCN32
      drm/amd/display: Add the necessary FRL registers for DCN314
      drm/amd/display: Add FRL register for DCN302
      drm/amd/display: Add FRL register for DCN303
      drm/amd/display: Add FRL registers for DCN315
      drm/amd/display: Add FRL registers for DCN316

Rodrigo Vivi (3):
      Merge drm/drm-next into drm-xe-next
      Merge tag 'topic/step-2026-04-09' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-xe-next
      Merge drm/drm-next into drm-intel-next

Roman Li (4):
      drm/amd/display: Add allow_clock_gating to dcn42 dccg
      drm/amd/display: bypass post csc for additional color spaces in dcn42
      drm/amd/display: Remove unused dml2_project
      drm/amd/display: Restore analog connector support

Rosen Penev (5):
      drm/etnaviv: use kzalloc_flex
      nouveau/vmm: use kzalloc_flex
      drm/nouveau/gsp: Use kzalloc_flex() for r535 display funcs
      accel/qaic: kcalloc + kzalloc to kzalloc
      drm/mediatek: Simplify mtk_crtc allocation

Samson Tam (2):
      drm/amd/display: Add README.md file to DML2_0 repository
      drm/amd/display: Check for sharpening case when calculating max
vtaps for scaler

Sanjay Yadav (1):
      drm/xe: Convert stolen memory over to ttm_range_manager

Satyanarayana K V P (5):
      drm/xe: Add memory pool with shadow support
      drm/xe/vf: Use drm mm instead of drm sa for CCS read/write
      drm/xe/pf: Restrict device query responses in admin-only PF mode
      drm/xe/pf: Derive admin-only PF mode from xe_device state
      drm/xe/guc: Exclude indirect ring state page from ADS engine state si=
ze

Sebastian Brzezinka (2):
      drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat
      drm/i915: skip __i915_request_skip() for already signaled requests

Sen Wang (1):
      drm/bridge: ite-it66121: Convert to DRM HDMI Audio Helper

Sergey Shtylyov (1):
      drm/rockchip: cdn-dp: add missing check in cdn_dp_config_video()

Sergio Lopez (3):
      drm/virtio: support VIRTIO_GPU_F_BLOB_ALIGNMENT
      drm/virtio: honor blob_alignment requirements
      drm/virtio: add VIRTGPU_PARAM_BLOB_ALIGNMENT to params

Shaoyun Liu (2):
      drm/amd/amdgpu : Distribute inv_tlbs on individual XCC
      drm/amdgpu: Move get mes version info to the end of set_hw_resource

Shekhar Chauhan (1):
      drm/xe/devcoredump: Drop a FIXME in devcoredump

Shivam Kalra (1):
      drm/mediatek: mtk_dpi: Open-code drm_simple_encoder_init()

Shiwu Zhang (4):
      Revert "drm/amdgpu: Init mcm_addr look up table"
      drm/amdgpu: use the ASP command for partition switch
      drm/amdgpu: fix buffer overflow during vBIOS update
      drm/amdgpu: fix duplicated buffer allocation for concurrent

Shubhankar Milind Sardeshpande (2):
      drm/amdgpu: Avoid reset in AMDGPU unload path for APUs with GFX
V11 and higher.
      drm/admgpu: Add support for ATHUB 3.4.2

Shuicheng Lin (31):
      drm/xe/ggtt: Remove duplicate XE_GGTT_FLAGS_64K macro definition
      drm/xe: Add missing include guards to unprotected headers
      drm/xe: Add missing _H to include guard suffixes
      drm/xe: Add missing trailing underscore to include guards
      drm/xe: Add missing leading underscore to include guards
      drm/xe: Normalize double-underscore include guards to single-undersco=
re
      drm/xe/uapi: Fix typos and spelling errors in xe_drm.h documentation
      drm/xe/uapi: Fix grammar errors in xe_drm.h documentation
      drm/xe/uapi: Fix wrong names and references in xe_drm.h
      drm/xe/uapi: Fix kernel-doc cross-reference syntax in xe_drm.h
      drm/xe/uapi: Fix code examples in xe_drm.h documentation
      drm/xe/uapi: Fix doc formatting and completeness in xe_drm.h
      drm/xe: Fix potential NULL deref in
xe_exec_queue_tlb_inval_last_fence_put_unlocked
      drm/xe/bo: Fix bo leak on unaligned size validation in xe_bo_init_loc=
ked()
      drm/xe/bo: Fix bo leak on GGTT flag validation in xe_bo_init_locked()
      drm/xe: Fix bo leak in xe_dma_buf_init_obj() on allocation failure
      drm/xe: Fix dma-buf attachment leak in xe_gem_prime_import()
      drm/xe: Fix error cleanup in xe_exec_queue_create_ioctl()
      drm/xe: Fix stale and mismatched kernel-doc member tags in header fil=
es
      drm/xe: Add missing '@' prefix to kernel-doc member tags
      drm/xe: Fix kernel-doc comment syntax issues in header files
      drm/xe: Fix type and parameter name mismatches in kernel-doc referenc=
es
      drm/xe/eustall: Fix drm_dev_put called before stream disable in close
      drm/xe/gsc: Fix BO leak on error in query_compatibility_version()
      drm/xe/mcr: Remove unused xe_gt_mcr_steering_info_to_dss_id()
      drm/xe/pf: Fix EAGAIN sign in pf_migration_consume()
      drm/xe/pf: Fix MMIO access using PF view instead of VF view
during migration
      drm/gpusvm: Drop redundant @flags.* kernel-doc on struct drm_gpusvm_p=
ages
      drm/xe/gsc: Fix double-free of managed BO in error path
      drm/xe/gt_idle: Use NSEC_PER_MSEC instead of float literal
      drm/xe/oa: Fix exec_queue leak on width check in stream open

Simon Ser (1):
      drm/doc: document DRM_IOCTL_SYNCOBJ_EVENTFD

Simona Vetter (1):
      Merge v7.1-rc5 into drm-next

Siwei He (1):
      drm/amdgpu: OR init_pte_flags into invalid leaf PTE updates

Sophie D (1):
      drm/gud: Add RCade Display Adapter VID/PID pair

Souradipto Das (1):
      drm/tegra: hdmi: Open-code drm_simple_encoder_init()

Srinivasan Shanmugam (5):
      drm/amd/display: Fix divide by zero in calc_psr_num_static_frames
      drm/amd/display: Fix unsigned underflow in SubVP vblank
schedulability check v2
      drm/amdkfd: Validate CRIU-restored IDs before idr_alloc
      drm/amd/display: Fix kdoc parameter names for DSC padding helper
      drm/amd/display: Add missing kdoc for ALLM parameters

Stanley.Yang (7):
      drm/amdgpu: fix potential overflow in fs_info.debugfs_name
      drm/amdgpu: init locals in umc_v12_0_convert_error_address
      drm/amd/ras: cap pending_ecc_list size
      drm/amd/ras: Return RAS TA injection result to userspace
      drm/amd/ras: snapshot remote cmd header to fix double-fetch
      drm/amd/ras: Remove redundant error log
      drm/amdgpu: harden FRU PIA parsing with bounded helpers

Stefan Kerkmann (2):
      dt-bindings: display: simple: Add Startek KD070HDFLD092 panel
      drm/panel: simple: Add Startek KD070HDFLD092 LVDS panel support

Steffen Trumtrar (2):
      dt-bindings: display: simple: Add NEC NL6448BC33-70C panel
      drm/panel: simple: add NEC NL6448BC33-70C

Steven Price (1):
      drm/panthor: Fix kernel-doc in panthor_sched.c so it's visible

Sunday Clement (2):
      drm/amdkfd: Fix OOB memory exposure in get_wave_state()
      drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS

Sung-huai Wang (1):
      drm/amd/display: Fix eDP receiver ready status check in T7 sequence

Sunil Khatri (22):
      drm/amdgpu/userq: fix access to stale wptr mapping
      drm/amdgpu/userq: use drm_exec in amdgpu_userq_fence_read_wptr
      drm/amdgpu/userq: pin mqd and fw object bo to avoid eviction
      drm/amdgpu/userq: cancel reset work while tear down in progress
      drm/amdgpu/userq: update the vm task info during signal ioctl
      drm/amdgpu: remove va cursors for all mappings
      drm/amdgpu: use atomic operation to achieve lockless serialization
      drm/amdgpu: userq_va_mapped should remain true once done
      drm/amdgpu/userq: Fix doorbell object cleanup of queue
      drm/amdgpu/userq: Fix the mutex_init cleanup for fence_drv_lock
      drm/amdgpu: simplify return value in amdgpu_userq_get_doorbell_index
      drm/amdgpu/userq: add amdgpu_bo_unpin when amdgpu_ttm_alloc_gart fail=
s
      drm/amdgpu/userq: reserve root bo without interruption
      drm/amdgpu/userq: make sure queue is valid in the hang_detect_work
      drm/amdgpu/userq: remove amdgpu_userq_create/destroy_object wrapper
      drm/amdgpu/userq: move mqd_destroy to later stage to keep core obj va=
lid
      drm/amdgpu/userq: use array instead of list for userq_vas
      drm/amdgpu/userq: remove the vital queue unmap logging
      drm/amdgpu/userq: move wptr_obj cleanup in mqd_destroy
      drm/amdgpu: compare MES firmware version ucode for gfx11
      drm/amdgpu: validate the mes firmware version for gfx12
      drm/amdgpu: validate the mes firmware version for gfx12.1

Suraj Kandpal (7):
      drm/i915/backlight: Fix VESA backlight possible check condition
      drm/i915/dp: Change drm_err to drm_dbg_kms
      drm/i915/display: Avoid stale PIPE_SCANLINE values after crtc_enable
      drm/i915/hdcp: Use new MST topology state in intel_conn_to_vcpi()
      drm/i915/hdcp: Drop mgr->base.lock acquisition in intel_conn_to_vcpi(=
)
      drm/i915/hdcp: Skip inactive MST connectors when building stream list
      Revert "drm/i915/backlight: Remove try_vesa_interface"

Svyatoslav Ryhel (2):
      dt-bindigs: display: extend the simple bridge with MStar
TSUMU88ADT3-LF-1 bridge
      drm/tegra: gr2d/gr3d: Initialize address register map before
HOST1X client is registered

Taimur Hassan (9):
      drm/amd/display: Promote DC to 3.2.379
      drm/amd/display: [FW Promotion] Release 0.1.57.0
      drm/amd/display: Promote DC to 3.2.380
      drm/amd/display: Promote DC to 3.2.381
      drm/amd/display: [FW Promotion] Release 0.1.59.0
      drm/amd/display: Promote DC to 3.2.382
      drm/amd/display: Promote DC to 3.2.383
      ddrm/amd/display: [FW Promotion] Release 0.1.61.0
      drm/amd/display: Promote DC to 3.2.384

Tanmay Patil (2):
      gpu: host1x: Skip redundant syncpoint loads in host1x_syncpt_wait()
      gpu: host1x: Skip redundant HW state update

Teguh Sobirin (1):
      drm/panel: Add panel driver for ChipWealth CH13726A based panels

Tejas Upadhyay (3):
      Use xe_map_resource_to_region helper instead of direct access
      drm/xe: Use drmm_mutex_init for VRAM manager lock
      drm/buddy: Integrate lockdep annotations for gpu buddy manager

Terry Hsiao (5):
      drm/panel-edp: Add CSW PNB601LS1-2 and LGD LP116WHA-SPB1
      drm/panel-edp: Add AUO B140XTN07.5, AUO B140HAK03.5, AUO
B116XTN02.3, AUO B140XTK02.4, AUO B140HAN07.7
      drm/panel-edp: Add BOE NT140WHM-N4T, BOE NT140WHM-T05, BOE NV140FHM-N=
40
      drm/panel-edp: Add CMN N116BCN-EA1, CMN N140HCA-EEK, IVO
M140NWFQ R5, IVO R140NWFW R0
      drm/panel-edp: Modify panel name and delay for CMN 0x14d6

Thomas Hellstr=C3=B6m (5):
      Merge drm/drm-next into drm-xe-next
      drm/exec: Remove the index parameter from
drm_exec_for_each_locked_obj[_reverse]
      drm/exec: Make the drm_exec_until_all_locked() macro more readable
      drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer
      drm/exec, drm/xe, drm/amdgpu: Add an accessor for struct drm_exec::ti=
cket

Thomas Zimmermann (48):
      drm/rockchip: Test for imported buffers with drm_gem_is_imported()
      Merge drm/drm-next into drm-misc-next
      Merge drm/drm-next into drm-misc-next
      drm/ast: Move 32-bit register-access helpers to ast_drv.{c, h}
      drm/ast: Use constants for AHBC registers
      drm/ast: Use constants for MCR registers
      drm/ast: Use constants for SCU registers
      drm/ast: Use constants for A2P registers
      drm/ast: Use constants for WDT registers
      drm/ast: Use constants for SDRAM registers
      drm/ast: Store register addresses in struct ast_dramstruct
      drm/ast: Gen1: Fix open-coded register access
      drm/ast: Gen2: Fix open-coded register access
      drm/ast: Gen4: Fix open-coded register access
      drm/ast: Gen6: Fix open-coded register access
      drm/ast: dp501: Fix open-coded register access
      drm/ast: Fix open-coded scu_rev access
      drm/ast: Add constant for VGACR91
      drm/ast: Remove traces of DRM_FORMAT_RGB888 handling
      drm/ast: Replace references to struct drm_format_info.cpp
      drm/ast: Support DRM_FORMAT_XRGB1555 on the primary plane
      drm/mgag200: Set xmulctrl from DRM format
      drm/mgag200: Set scale from DRM format
      drm/mgag200: Simplify offset calculation
      drm/mgag200: g200se: Set hiprilvl from DRM format
      drm/mgag200: Enable DRM_FORMAT_C8 on the primary plane
      drm/mgag200: Enable DRM_FORMAT_XRGB1555 on the primary plane
      drm/amdgpu: Replace VKMS vblank timer with common implementation
      Merge drm/drm-next into drm-misc-next
      drm/vmwgfx: Determine lock-waiting timeout from vblank state
      drm/vmwgfx: Move vblank handling into separate helper
      drm/vmwgfx: Convert to DRM vblank timers
      drm/sysfb: corebootdrm: Support power management
      drm/sysfb: efidrm: Support power management
      drm/sysfb: ofdrm: Support power management
      drm/sysfb: simpledrm: Support power management
      drm/sysfb: vesadrm: Support power management
      drm/exynos: fbdev: Remove offset into screen_buffer
      drm/exynos: fbdev: Inline exynos_drm_fbdev_update()
      drm/exynos: fbdev: Calculate buffer geometry with format helpers
      drm/exynos: fbdev: Use a DRM client buffer
      drm/exynos: Make exynos_drm_framebuffer_init() an internal interface
      Merge drm/drm-next into drm-misc-next
      drm/tegra: fbdev: Do not assign to struct drm_fb_helper.info
      drm/tegra: fbdev: Remove offset into framebuffer memory
      drm/tegra: fbdev: Calculate buffer geometry with format helpers
      drm/tegra: fbdev: Use a DRM client buffer
      drm/tegra: Make tegra_fb_alloc() an internal interface

Thorsten Blum (3):
      drm/radeon: replace nested min calls with min3
      drm/tegra: dp: use str_plural in drm_dp_link_train_{full,fast}
      drm/tegra: sor: use str_plural in tegra_sor_dp_link_configure

Timur Krist=C3=B3f (40):
      drm/amd/display: Disable 10-bit truncation and dithering on DCE 6.x
      drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not overlap with VRA=
M
      drm/amdgpu/uvd3.1: Don't validate the firmware when already validated
      Documentation/gpu: Add TCC, update TCP in amdgpu glossary
      drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)
      drm/amd/display: Allow embedded connectors without DDC
      drm/amd/display: Allow DCE link encoder without AUX registers
      drm/amd/display: Allow constructing DCE6 link encoder without DDC
      drm/amd/display: Allow constructing DCE8 link encoder without DDC
      drm/amd/display: Read EDID from VBIOS embedded panel info
      drm/amd/display: Use EDID from VBIOS embedded panel info
      drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on Tahiti (v2)
      drm/amdgpu/vce1: Check that the GPU address is < 128 MiB
      drm/amdgpu/vce1: Remove superfluous address check
      drm/amdgpu/vce1: Check if VRAM address is lower than GART.
      drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
      drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
      drm/amdgpu/vce1: Stop using amdgpu_vce_resume
      drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
      drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets
      drm/amd/display: Delete unimplemented
dm_pp_apply_power_level_change_request() (v2)
      drm/amd/display: Delete dce_get_required_clocks_state()
      drm/amd/display: Remove min/max clock levels from clk_mgr (v2)
      drm/amd/display: Delete max_clocks_state
      drm/amd/display: Set max supported display clock without
max_clks_by_state (v2)
      drm/amd/display: Delete max_clks_by_state from DCE clock manager (v2)
      drm/amd/display: Delete disp_clk_voltage from integrated info (v2)
      drm/amd/display: Delete dm_pp_clocks_state
      drm/amd/pm: Delete unused get_display_power_level() function
      drm/amd/pm: Delete dummy get_dal_power_level implementations
      drm/amd/pm: Delete non-functional SMU8 get_dal_power_level implementa=
tion
      drm/amd/pm: Delete vddc_dep_on_dal_pwrl
      drm/amd/pm: Delete get_dal_power_level
      drm/amd/pm: Delete PP_DAL_POWERLEVEL
      drm/amd/pm/si: Disregard vblank time when no displays are connected
      drm/amd/pm: Rename enable_bapm() to notify_ac_dc()
      drm/amd/pm/smu7: Notify SMU7 of DC->AC switch
      drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on all SI
      drm/amdgpu: Use gmc->noretry instead of amdgpu_noretry directly
      drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as needed

Timur Tabi (18):
      gpu: nova-core: program_brom cannot fail
      Documentation: gpu: nova: document the IFR header layout
      gpu: nova-core: use correct fwsignature for GA100
      gpu: nova-core: do not consider 0xBB77 as a valid PCI ROM header sign=
ature
      gpu: nova-core: only boot FRTS if its region is allocated
      gpu: nova-core: add FbHal::frts_size() for GA100 support
      gpu: nova-core: skip the IFR header if present
      gpu: nova-core: enable GA100
      drm/nouveau: expose VBIOS via debugfs on GSP-RM systems
      drm/nouveau/gsp: add SEC2 to GA100 chip table
      drm/nouveau/gsp: use fb.bios.addr for gspFwWprEnd instead of
vga_workspace.addr
      drm/nouveau/gsp: read MMU_LOCK to fix WPR placement on GA100
      drm/nouveau: only boot FRTS if its region is allocated
      drm/nouveau: GA100 has an FRTS region size of zero
      drm/nouveau/bios: specify correct display fuse register for Ampere an=
d Ada
      drm/nouveau/bios: skip the IFR header if present
      drm/nouveau/gsp: require GSP-RM for GA100 support
      drm/nouveau/gsp: formally support GA100

Tom Chung (1):
      drm/amd/display: Fix CRC open failure during active rendering

Tomi Valkeinen (19):
      drm/tidss: Drop extra drm_mode_config_reset() call
      drm/tidss: Fix missing drm_bridge_add() call
      drm/fourcc: Add warning for bad bpp
      drm/fourcc: Add DRM_FORMAT_P230
      drm/fourcc: Add DRM_FORMAT_Y8
      drm/fourcc: Add DRM_FORMAT_XYYY2101010
      drm/fourcc: Add DRM_FORMAT_T430
      drm/fourcc: Add DRM_FORMAT_XVUY2101010
      drm: xlnx: zynqmp: Use drm helpers when calculating buffer sizes
      drm: xlnx: zynqmp: Add support for P030 & P230
      drm: xlnx: zynqmp: Add support for Y8 and XYYY2101010
      drm: xlnx: zynqmp: Add support for T430
      drm: xlnx: zynqmp: Add support for XVUY2101010
      drm/bridge: tc358768: Fix typo in TC358768_DSI_CONTROL_DIS_MODE
      drm/bridge: tc358768: Separate indirect register writes
      drm/bridge: tc358768: Support non-continuous clock
      drm/bridge: tc358768: Add LP mode command support
      drm/bridge: tc358768: Separate video format config
      drm/bridge: tc358768: Add support for long command tx via video buffe=
r

Tommaso Merciai (2):
      drm: rz-du: Ensure correct suspend/resume ordering with VSP
      dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL

Troy Hanson (1):
      accel/qaic: Simplify bootlog line handling

Tvrtko Ursulin (35):
      dma-fence: Fix potential tracepoint null pointer dereferences
      drm/sched: Disallow initializing entities with no schedulers
      drm/sched: Consolidate entity run queue management
      drm/sched: Move run queue related code into a separate file
      drm/sched: Add some scheduling quality unit tests
      drm/sched: Add some more scheduling quality unit tests
      drm/sched: Implement RR via FIFO
      drm/sched: Free all finished jobs at once
      drm/sched: Account entity GPU time
      drm/sched: Remove idle entity from tree
      drm/sched: Add fair scheduling policy
      drm/sched: Favour interactive clients slightly
      drm/sched: Switch default policy to fair
      drm/sched: Remove FIFO and RR and simplify to a single run queue
      drm/sched: Embed run queue singleton into the scheduler
      accel/amdxdna: Remove drm_sched_init_args->num_rqs usage
      accel/rocket: Remove drm_sched_init_args->num_rqs usage
      accel/ethosu: Remove drm_sched_init_args->num_rqs usage
      drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
      drm/etnaviv: Remove drm_sched_init_args->num_rqs usage
      drm/imagination: Remove drm_sched_init_args->num_rqs usage
      drm/lima: Remove drm_sched_init_args->num_rqs usage
      drm/msm: Remove drm_sched_init_args->num_rqs usage
      drm/nouveau: Remove drm_sched_init_args->num_rqs usage
      drm/panfrost: Remove drm_sched_init_args->num_rqs usage
      drm/panthor: Remove drm_sched_init_args->num_rqs usage
      drm/sched: Remove drm_sched_init_args->num_rqs usage
      drm/v3d: Remove drm_sched_init_args->num_rqs usage
      drm/xe: Remove drm_sched_init_args->num_rqs usage
      drm/sched: Remove drm_sched_init_args->num_rqs
      drm/xe/xelp: Fix Wa_18022495364
      drm/xe: Use fb cached min alignment
      drm/xe: Assign queue name in time for drm_sched_init
      drm/sched: Fix clang build warning in kunit tests
      amd/amdkfd: Fix profiler lock init order

Umesh Nerlige Ramappa (10):
      drm/xe/lrc: Use 64 bit ctx timestamp in the LRC snapshot
      drm/xe/lrc: Refactor xe_lrc_timestamp to simplify logic
      drm/xe/multi_queue: Refactor check for multi queue support for
engine class
      drm/xe/multi_queue: Store primary LRC and position info in LRC
      drm/xe/multi_queue: Add helpers to access CS QUEUE TIMESTAMP from lrc
      drm/xe/lrc: Refactor out engine id to hwe conversion
      drm/xe/multi_queue: Capture queue run times for active queues
      drm/xe/multi_queue: Add trace event for the multi queue timestamp
      drm/xe/multi_queue: Use QUEUE_TIMESTAMP as job timestamp for multi-qu=
eue
      drm/xe/multi_queue: Whitelist QUEUE_TIMESTAMP register

Uwe Kleine-K=C3=B6nig (The Capable Hub) (3):
      drm/xe: Don't use UTS_RELEASE directly
      drm/gma500: Drop unused include of <drm/drm_pciids.h>
      drm/mgag200: Drop unused include of <drm/drm_pciids.h>

Varun Gupta (1):
      drm/xe/xe3p_lpg: Add Wa_18044193044

Vidya Srinivas (1):
      drm/i915/display: Use ceiling division for NV12 UV surface
offset calculation

Ville Syrj=C3=A4l=C3=A4 (113):
      drm/vblank: Extract get_vblank_counter_and_timestamp()
      drm/i915/cdclk: Do the full CDCLK dance for min_voltage_level changes
      drm/i915/dp: Use crtc_state->enhanced_framing properly on ivb/hsw CPU=
 eDP
      drm/i915: Split the pipe_src dump to its own line
      drm/i915: Include the crtc min_voltage_level in the state dump
      drm/i915: Eliminate out of place "HBlank" CamelCase
      drm/i915: Move the sharpness filter dump next to pfit
      drm/i915/dp: Implement the POST_LT_ADJ_REQ sequence
      drm/i915/qgv: Use intel_de_read() for MTL_MEM_SS_INFO* reads
      drm/i915/mchbar: Provide intel_mchbar_read*() abstraction
      drm/i915/mchbar: Define the end of the MCHBAR mirror
      drm/i915/mchbar: WARN when accessing non-MCHBAR registers via
intel_mchbar_read*()
      drm/i915/mchbar: Use intel_mchbar_read() instead of intel_de_read()
      drm/i915/mchbar: Use intel_mchbar_read*() instead of intel_uncore_rea=
d*()
      drm/i915/de: Add intel_de_read16()
      drm/i915/de: s/intel_de_read64_2x32()/intel_de_read64_2x32_volatile()=
/
      drm/i915/de: Add a simple intel_de_read64_2x32()
      drm/i915/vrr: Use intel_de_read64_2x32()
      drm/i915/mchbar: Use intel_de_read*() for MCHBAR register accesses
      drm/i915/rom: Use intel_de for SPI ROM register access
      drm/i915/casf: s/casf_enable/enable/
      drm/i915/casf: Make a proper hw state copy of the sharpness_strength
      drm/i915/casf: Move the casf state to better place
      drm/i915/casf: Extract scaler_has_casf()
      drm/i915/casf: Handle CASF in skl_scaler_get_filter_select()
      drm/i915/casf: Constify crtc_state
      drm/i915/casf: Remove redundant argument from intel_casf_filter_lut_l=
oad()
      drm/i915/pfit: Call intel_pfit_compute_config() unconditionally
on (e)DP/HDMI
      drm/i915/casf: Integrate the sharpness filter properly into the
scaler code
      drm/i915/dp: Don't use DP link min bpp for the FRL link bandwidth che=
ck
      drm/i915/wm: Reject SAGV consistently when block_time_us=3D=3D0
      drm/i915/wm: Don't compute separate SAGV watermarks for RKL
      drm/i915/wm: Consolidate SAGV pipe active/interlace checks to common =
code
      drm/i915/wm: Verify the correct plane DDB entry
      drm/i915/wm: Extract skl_wm_level_verify()
      drm/i915/wm: Extract skl_ddb_entry_verify()
      drm/i915/wm: Verify 'ddb_y' as well as 'ddb'
      drm/i915/wm: Reduce copy-pasta in skl_print_plane_wm_changes()
      drm/i915/wm: Allow SAGV with multiple pipes on pre-icl
      drm/i915/fb: Nuke intel_tile_row_size()
      drm/i915/fb: Make intel_fb_needs_pot_stride_remap() static
      drm/i915/fb: Reject per-plane remapping with DPT
      drm/i915/vma: Add helpers to check GTT view type
      drm/i915/fb: Use i915_gtt_view_is_*()
      drm/i915/fb: Use intel_fb_needs_pot_stride_remap() in intel_fb_view_i=
nit()
      drm/i915/mst: Call intel_pfit_compute_config() for sharpness filter
      drm/i915/mst: Remove redundant has_pch_encoder=3Dfalse assignment
      drm/i915/hdmi: Add missing intel_pfit_mode_valid() for 4:2:0 also mod=
es
      drm/i915/hdmi: Restructure the sink/output format selection
      drm/i915/hdmi: Restructure 4:2:0 vs. 4:4:4 mode validation
      drm/i915/dp: Restructure the sink/output format selection
      drm/i915/dp: Validate "4:2:0 also" modes twice
      drm/i915/dp: Require a HDMI sink for YCbCr output via PCON
      drm/i915/dp: Validate sink format in .mode_valid()
      drm/i915/hdmi: Make the RGB fallback for "4:2:0 only" modes the
last resort
      drm/i915/dp: Make the RGB fallback for "4:2:0 only" modes the last re=
sort
      drm/i915: Introduce sanity to the plane_config pointer vs. array thin=
g
      drm/i915: Remove 'mem' and 'phy_base' from struct
intel_initial_plane_config
      drm/i915: Don't pass the whole plane_config to initial_plane_phys()
      drm/i915: Make plane_config->fb a struct drm_framebuffer*
      drm/i915: Move initial plane vblank wait into display code
      drm/i915: Use a 1 second timeout for the polling vblank wait
      drm/i915: Reject tile4 BIOS FB
      drm/i915: Reject X/Y tiled BIOS FB if we don't have fenced regions
      drm/i915: Completely reject DPT BIOS FBs.
      drm/i915: Reject BIOS FB rotation in common code
      drm/i915: Track fence region ID in plane state
      drm/i915: Remove the vma parent interface
      drm/i915: Clear i915->display when no longer valid
      drm/xe: Clear xe->display when no longer valid
      drm/i915/reset: Reorganize display reset code
      drm/i915/reset: Move pending_fb_pin handling to i915
      drm/xe/display: Add init_clock_gating.h stubs
      drm/i915/reset: Add "intel_display_reset_count" debugfs file
      drm/i915/reset: Disable execlist per-engine reset for display reset t=
ests
      drm/xe/fb: Use the correct gtt view for remapped FBs
      drm/i915: Introduce struct intel_fb_pin_params
      drm/i915: Extract intel_fb_needs_cpu_access()
      drm/i915: Introduce pin_params.needs_cpu_lmem_access
      drm/i915: Extract intel_plane_needs_low_address()
      drm/i915: Introduce pin_params.needs_low_address
      drm/i915: Introduce pin_params.needs_physical
      drm/i915: Extract intel_plane_needs_fence()
      drm/i915: Introduce pin_params.needs_fence
      drm/xe: Eliminate intel_fb_uses_dpt() call from __xe_pin_fb_vma()
      drm/i915: Don't pass the framebuffer to low level pinning functions
      drm/xe: Respect pin_params.alignment for GGTT
      drm/i915: Introduce intel_parent_fb_pin_get_map()
      drm/i915: Move intel_fb_pin_params to the parent interface
      drm/i915: Move the i915_dpt_offset()=3D=3D0 assert
      drm/i915: Reorganize intel_plane_pin_fb() a bit
      drm/i915: Introduce i915_fb_pin_dpt_(un)pin()
      drm/i915: Introduce i915_fb_pin_ggtt_(un)pin()
      drm/xe: Move the FORCE_WC assert into __xe_pin_fb_vma()
      drm/xe: Kill the fbdev vma reuse hack
      drm/xe: Reorganize intel_plane_pin_fb() a bit
      drm/xe: Introduce xe_fb_pin_dpt_(un)pin()
      drm/xe: Introduce xe_fb_pin_ggtt_(un)pin()
      drm/xe: Restructure reuse_vma()
      drm/i915: Introduce the main fb_pin parent interface
      drm/i915/fbdev: Use intel_parent_fb_pin_ggtt_(un)pin()
      drm/xe: Use xe_fb_pin_ggtt_pin() for the initial FB pin
      drm/i915: Consolidate the intel_plane_(un)pin_fb() implementations
      drm/i915/bw: Fix num_planes handling on TGL+
      drm/i915/bw: Fix DCLK rounding mess
      drm/i915/bw: Fix bw rounding direction
      drm/i915/bw: Fix 'deinterleave' rounding direction
      drm/i915/bw: Fix rounding direction in clperchgroup calculation
      drm/i915/bw: Fix DEPROGBWPCLIMIT handling on BMG
      drm/i915/bw: Fix/unify peakbw calculations
      drm/i915/bw: Round the PM demand bandwidth down
      drm/i915/bw: Remove deinterleave fallback for TGL+
      drm/i915/bw: Do not consider tile4 as tileY

Vinay Belgaumkar (1):
      drm/xe: Fix bug in idledly unit conversion

Vitaliy Triang3l Kuzmin (1):
      drm/radeon/evergreen_cs: Add missing NULL prefix check in surface che=
ck

Vitaly Prosyak (5):
      drm/amdgpu: fix KASAN slab-out-of-bounds in amdgpu_coredump ring dump
      drm/amd/pm: Add empty string validation to sysfs store functions
      drm/amd/pm: Reject negative values in thermal_throttling_logging
      drm/amdgpu: set noretry=3D1 as default for GFX 10.1.x (Navi10/12/14)
      drm/amdgpu: Add lockdep annotations for lock ordering validation

Vitor Soares (2):
      drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()
      dt-bindings: display: panel-lvds: Add Riverdi RVT70HSLNWCA0 and
RVT101HVLNWC00

Vladimir Oltean (1):
      drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node

Wei-Guang Li (1):
      drm/amd/display: Add debug option for replay ESD recovery

Wenjing Liu (3):
      drm/amd/display: add memory bandwidth override debug interface
      drm/amd/display: add max bandwidth budget to QoS interface
      drm/amd/display: Add DRAM table fields to clk_mgr_internal

Wenxian Wang (1):
      drm/amd/display: Add ADDR3 swizzle modes

Werner Kasselman (2):
      drm/amdgpu: fix integer overflow in amdgpu_gem_align_pitch()
      drm/radeon: fix integer overflow in radeon_align_pitch()

William Bright (2):
      dt-bindings: panel-simple-dsi: Add Team Source Display TST070WSNE-196=
C
      drm/panel: simple: Add Team Source Display TST070WSBE-196C panel

Xiang Liu (7):
      drm/amdgpu: Rename CPER Fatal severity macro
      drm/amd/ras: Fix CPER ring debugfs read overflow
      drm/amd/ras: Fix UMC error address allocation leak
      drm/amd/ras: reset CPER ring on corrupt entry size
      drm/amd/ras: Fix SMU EEPROM record field decoding
      drm/amd/ras: make UNIRAS CPER debugfs header legacy-compatible
      drm/amd/ras: chunk UNIRAS CPER debugfs reads

Xiaogang Chen (1):
      drm/amdkfd: Check if there are kfd porcesses using adev by
kfd_processes_count

Xin Wang (5):
      drm/xe: improve readability of debugfs engine info output
      drm/xe: expose multi-lrc engine classes in debugfs info
      drm/xe: Standardize pat_index to u16 type
      drm/xe/pat: Default XE_CACHE_NONE_COMPRESSION to invalid
      drm/xe/pat: Introduce xe_cache_pat_idx() macro helper

Yang Wang (13):
      drm/amd/pm: remove trailing semicolon from AMDGPU_PM_POLICY_ATTR macr=
o
      drm/amd/pm: fix missing fine-grained dpm table flag on aldebaran
      drm/amd/pm: add SMU multi-msgs helpers
      drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0
      drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_0
      drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_8
      drm/amdgpu: fix error return code in mes_v12_1_map_test_bo
      drm/amd/pm: update dpm clock pm attributes for aldebaran (gc 9.4.2)
      drm/amd/pm: fix memleak of dpm_policies on smu v15
      drm/amd/pm: apply SMU 13.0.10 workaround during MP1 unload
      drm/amd/pm: fix smu13 power limit default/cap calculation
      drm/amd/pm: mark metrics.energy_accumulator is invalid for smu 14.0.2
      drm/amd/pm: zero unused SMU argument registers

YiPeng Chai (7):
      drm/amd/ras: use mutex to prevent concurrent access conflicts
      drm/amd/ras: add error handling for seqno operations
      drm/amd/ras: remove unused code
      drm/amd/ras: fix memory leak on ras sw_init failure
      drm/amd/ras: add length check for ras command output buffer
      drm/amd/ras: copy ras log data instead of referencing pointers
      drm/amdgpu: check and drop invalid bad page records

Yicong Hui (1):
      drm/panthor: Fix kernel-doc warning in panthor_sched.c

Yifan Zhang (1):
      drm/amdgpu: unmap all user mappings of framebuffer and doorbell
before mode1 reset

Yinjie Yao (19):
      drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v2.5 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v3.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.3 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.5 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.1 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.2 enc ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.3 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.1 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.2 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.3.0 ring

Yongqiang Sun (4):
      drm/amdkfd: fix SMI event cross-process information leak
      drm/amdkfd: Unwind debug trap enable on copy_to_user failure
      drm/amdkfd: fix sysfs topology prop length on buffer truncation
      drm/amdkfd: Fix infinite loop parsing CRAT with zero subtype length

YuanShang (1):
      drm/amdkfd: check if vm ready in svm map and unmap to gpu

Yuho Choi (1):
      drm/radeon: fix memory leak in radeon_ring_restore() on lock failure

Yunxiang Li (3):
      drm/amdgpu: set sub_block_index for mca ras sub-blocks
      drm/amdgpu/ras: add ras_suspend callback and use it for cp_ecc_error_=
irq
      drm/amdgpu/gfx: move fault and EOP IRQ get/put to hw_init/hw_fini

Yury Norov (1):
      drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=3Dn

Zack McKevitt (2):
      accel/qaic: Update copyright headers to yearless format
      accel/qaic: Retain bootlogs that overflow

Zbigniew Kempczy=C5=84ski (1):
      drm/xe/pat: Print PAT_ATS during register dump

Zhanjun Dong (1):
      drm/xe: Fix null pointer dereference in devcoredump cleanup

Zheng, Austin (1):
      drm/amd/display: Clean Up Legacy DML Content

Ziyi Guo (1):
      drm/amdgpu: check num_entries in GEM_OP GET_MAPPING_INFO

chong li (2):
      drm/amdgpu: Sync the pf2vf structure between guest and host
      drm/amdgpu: Add guest driver CUID support

gyeyoung (1):
      drm/panthor: Fix missing declaration for panthor_transparent_hugepage

sai madhu (1):
      drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()

shayderrr (1):
      host1x: bus: Fix missing ops null check in error teardown

 .mailmap                                           |    10 +
 Documentation/.renames.txt                         |     1 +
 Documentation/ABI/obsolete/sysfs-driver-ivpu       |    30 +
 .../ABI/{obsolete =3D> removed}/sysfs-selinux-user   |     0
 Documentation/ABI/testing/sysfs-driver-ivpu        |    65 +
 Documentation/accel/amdxdna/amdnpu.rst             |    25 +
 Documentation/admin-guide/cgroup-v1/memcg_test.rst |     6 +-
 Documentation/admin-guide/cgroup-v2.rst            |     2 +-
 .../admin-guide/laptops/uniwill-laptop.rst         |    10 +
 Documentation/admin-guide/pm/amd-pstate.rst        |    11 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |    11 +-
 Documentation/arch/riscv/cmodx.rst                 |     8 +-
 Documentation/arch/riscv/zicfilp.rst               |     2 +-
 Documentation/crypto/krb5.rst                      |    17 +-
 .../bindings/display/bridge/lontium,lt9211.yaml    |    43 +-
 .../bindings/display/bridge/lvds-codec.yaml        |     1 +
 .../bindings/display/bridge/simple-bridge.yaml     |     1 +
 .../bindings/display/bridge/waveshare,dsi2dpi.yaml |     9 +-
 .../bindings/display/msm/dp-controller.yaml        |    28 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |     2 +
 .../devicetree/bindings/display/msm/gmu.yaml       |    30 +
 .../devicetree/bindings/display/msm/gpu.yaml       |    19 +
 .../bindings/display/msm/qcom,eliza-mdss.yaml      |    20 +-
 .../bindings/display/msm/qcom,milos-mdss.yaml      |   286 +
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |     3 +-
 .../bindings/display/msm/qcom,sm8650-mdss.yaml     |     2 +-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     |    16 +-
 .../display/panel/chipwealth,ch13726a.yaml         |    67 +
 .../bindings/display/panel/focaltech,ota7290b.yaml |    70 +
 .../bindings/display/panel/himax,hx83102.yaml      |     2 +
 .../bindings/display/panel/himax,hx8394.yaml       |     2 +
 .../bindings/display/panel/ilitek,ili9881c.yaml    |     2 +
 .../bindings/display/panel/jadard,jd9365da-h3.yaml |     6 +
 .../bindings/display/panel/novatek,nt35532.yaml    |    80 +
 .../bindings/display/panel/panel-lvds.yaml         |     4 +
 .../bindings/display/panel/panel-simple-dsi.yaml   |     2 +
 .../bindings/display/panel/panel-simple.yaml       |    36 +
 .../bindings/display/renesas,rzg2l-du.yaml         |    21 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |     2 +
 .../bindings/i2c/amlogic,meson6-i2c.yaml           |    13 +-
 .../devicetree/bindings/i2c/apple,i2c.yaml         |     4 +-
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |     1 +
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |    13 +-
 .../devicetree/bindings/phy/qcom,dsi-phy-7nm.yaml  |     1 +
 .../sound/mediatek,mt8173-rt5650-rt5514.yaml       |     2 +
 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml  |     3 +
 .../devicetree/bindings/vendor-prefixes.yaml       |     2 +
 Documentation/filesystems/isofs.rst                |     2 +-
 Documentation/gpu/amdgpu/amdgpu-glossary.rst       |     9 +-
 Documentation/gpu/amdgpu/index.rst                 |     1 +
 Documentation/gpu/amdgpu/ptl.rst                   |    94 +
 Documentation/gpu/driver-uapi.rst                  |     2 +
 Documentation/gpu/drivers.rst                      |     1 +
 Documentation/gpu/drm-internals.rst                |     2 +
 Documentation/gpu/drm-kms-helpers.rst              |     2 +
 Documentation/gpu/drm-kms.rst                      |    19 +-
 Documentation/gpu/drm-mm.rst                       |     2 +
 Documentation/gpu/drm-ras.rst                      |    10 +
 Documentation/gpu/drm-uapi.rst                     |     8 +-
 Documentation/gpu/drm-usage-stats.rst              |     3 +
 Documentation/gpu/i915.rst                         |   202 +-
 Documentation/gpu/index.rst                        |     1 +
 Documentation/gpu/intel-display/async-flip.rst     |     8 +
 Documentation/gpu/intel-display/atomic.rst         |    11 +
 Documentation/gpu/intel-display/audio.rst          |    23 +
 Documentation/gpu/intel-display/casf.rst           |     8 +
 Documentation/gpu/intel-display/cdclk.rst          |    11 +
 Documentation/gpu/intel-display/cmtg.rst           |     8 +
 Documentation/gpu/intel-display/dmc.rst            |    26 +
 Documentation/gpu/intel-display/dpio.rst           |     8 +
 Documentation/gpu/intel-display/dpll.rst           |    14 +
 Documentation/gpu/intel-display/drrs.rst           |    11 +
 Documentation/gpu/intel-display/dsb.rst            |    11 +
 Documentation/gpu/intel-display/fbc.rst            |    11 +
 Documentation/gpu/intel-display/fifo-underrun.rst  |    11 +
 Documentation/gpu/intel-display/frontbuffer.rst    |    14 +
 Documentation/gpu/intel-display/hotplug.rst        |    11 +
 Documentation/gpu/intel-display/index.rst          |    44 +
 Documentation/gpu/intel-display/plane.rst          |    11 +
 Documentation/gpu/intel-display/psr.rst            |    11 +
 Documentation/gpu/intel-display/snps-phy.rst       |     8 +
 Documentation/gpu/intel-display/vbt.rst            |    14 +
 Documentation/gpu/introduction.rst                 |     2 +
 Documentation/gpu/komeda-kms.rst                   |     8 +-
 Documentation/gpu/nova/core/vbios.rst              |    65 +-
 Documentation/gpu/rfc/index.rst                    |    26 +-
 Documentation/gpu/todo.rst                         |    23 -
 Documentation/gpu/xe/index.rst                     |     6 +
 Documentation/gpu/xe/xe_firmware.rst               |     4 +-
 Documentation/gpu/xe/xe_gt_stats.rst               |    11 +
 Documentation/hwmon/sy7636a-hwmon.rst              |     2 +-
 Documentation/hwmon/yogafan.rst                    |     2 +-
 Documentation/netlink/genetlink-c.yaml             |     9 +
 Documentation/netlink/genetlink-legacy.yaml        |     9 +
 Documentation/netlink/genetlink.yaml               |     9 +
 Documentation/netlink/netlink-raw.yaml             |     9 +
 Documentation/netlink/specs/drm_ras.yaml           |    13 +-
 Documentation/netlink/specs/net_shaper.yaml        |     7 +
 Documentation/netlink/specs/psp.yaml               |     2 +
 .../device_drivers/ethernet/3com/3c509.rst         |   249 +
 .../networking/device_drivers/ethernet/index.rst   |     1 +
 Documentation/process/index.rst                    |     1 +
 Documentation/process/security-bugs.rst            |   106 +-
 Documentation/process/threat-model.rst             |   235 +
 Documentation/sound/codecs/cs35l56.rst             |     2 +-
 Documentation/userspace-api/rseq.rst               |    94 +-
 .../virt/kvm/x86/amd-memory-encryption.rst         |     8 +-
 MAINTAINERS                                        |   211 +-
 Makefile                                           |     4 +-
 arch/alpha/include/asm/Kbuild                      |     1 +
 arch/arc/include/asm/Kbuild                        |     1 +
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts      |     3 -
 arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts     |     2 -
 arch/arm/boot/dts/renesas/r7s72100.dtsi            |     2 +-
 arch/arm/boot/dts/renesas/r8a7778.dtsi             |     2 +-
 arch/arm/boot/dts/renesas/r8a7779.dtsi             |     2 +-
 arch/arm/boot/dts/renesas/r8a7792.dtsi             |     2 +-
 arch/arm/include/asm/Kbuild                        |     1 +
 arch/arm/mach-versatile/integrator_cp.c            |    13 +-
 .../dts/renesas/draak-ebisu-panel-aa104xd12.dtso   |     5 +
 arch/arm64/boot/dts/renesas/r8a78000.dtsi          |     8 +-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi         |     1 +
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi         |     2 +
 .../boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  |     5 +
 .../boot/dts/renesas/rz-smarc-du-adv7513.dtsi      |     5 +
 .../boot/dts/renesas/salvator-panel-aa104xd12.dtso |     5 +
 arch/arm64/configs/defconfig                       |     3 +
 arch/arm64/include/asm/insn.h                      |     2 +-
 arch/arm64/include/asm/irqflags.h                  |    14 +-
 arch/arm64/include/asm/kernel-pgtable.h            |     7 +-
 arch/arm64/include/asm/kvm_asm.h                   |    28 +-
 arch/arm64/include/asm/kvm_host.h                  |     5 +-
 arch/arm64/include/asm/kvm_nested.h                |     1 +
 arch/arm64/include/asm/page.h                      |     2 +-
 arch/arm64/include/asm/ring_buffer.h               |    10 +
 arch/arm64/include/asm/sysreg.h                    |     2 +-
 arch/arm64/include/asm/tlb.h                       |     3 +-
 arch/arm64/kernel/entry-common.c                   |    31 +-
 arch/arm64/kernel/pi/patch-scs.c                   |     4 +-
 arch/arm64/kernel/ptrace.c                         |     4 +-
 arch/arm64/kernel/signal.c                         |    54 +-
 arch/arm64/kvm/arm.c                               |    29 +-
 arch/arm64/kvm/config.c                            |    23 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |     2 +-
 arch/arm64/kvm/hyp/nvhe/clock.c                    |     3 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |    30 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |    47 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |    54 +-
 arch/arm64/kvm/hyp/nvhe/setup.c                    |     8 +-
 arch/arm64/kvm/hyp/nvhe/trace.c                    |     9 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |     3 +-
 arch/arm64/kvm/mmu.c                               |    29 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |     4 +
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                 |     2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |     2 +-
 arch/arm64/mm/fault.c                              |    11 +-
 arch/csky/include/asm/Kbuild                       |     1 +
 arch/hexagon/include/asm/Kbuild                    |     1 +
 arch/loongarch/Kbuild                              |     2 +-
 arch/loongarch/Kconfig                             |     1 +
 arch/loongarch/Makefile                            |     2 +
 arch/loongarch/include/asm/Kbuild                  |     1 +
 arch/loongarch/include/asm/asm-prototypes.h        |    20 +
 arch/loongarch/include/asm/efi.h                   |     4 +-
 arch/loongarch/include/asm/kvm_host.h              |     3 -
 arch/loongarch/include/asm/linkage.h               |     2 +-
 arch/loongarch/include/asm/paravirt.h              |     6 +
 arch/loongarch/include/asm/qspinlock.h             |     5 +-
 arch/loongarch/include/asm/vdso/gettimeofday.h     |     6 -
 arch/loongarch/kernel/kprobes.c                    |    14 +-
 arch/loongarch/kernel/relocate.c                   |    50 +
 arch/loongarch/kvm/Makefile                        |     3 +-
 arch/loongarch/kvm/exit.c                          |     1 +
 arch/loongarch/kvm/interrupt.c                     |    34 +-
 arch/loongarch/kvm/main.c                          |    35 +-
 arch/loongarch/kvm/mmu.c                           |     2 +-
 arch/loongarch/kvm/switch.S                        |    22 +-
 arch/loongarch/kvm/timer.c                         |    10 +-
 arch/loongarch/kvm/vm.c                            |     2 +-
 arch/loongarch/mm/init.c                           |     4 -
 arch/loongarch/pci/acpi.c                          |     5 +
 arch/loongarch/pci/pci.c                           |     3 +
 arch/loongarch/vdso/Makefile                       |     2 +
 arch/m68k/include/asm/Kbuild                       |     1 +
 arch/microblaze/include/asm/Kbuild                 |     1 +
 arch/mips/include/asm/Kbuild                       |     1 +
 arch/nios2/include/asm/Kbuild                      |     1 +
 arch/nios2/include/asm/linkage.h                   |     2 +
 arch/openrisc/include/asm/Kbuild                   |     1 +
 arch/parisc/Makefile                               |    16 +-
 arch/parisc/include/asm/Kbuild                     |     1 +
 arch/parisc/include/asm/vdso.h                     |     7 +-
 arch/parisc/kernel/Makefile                        |     7 +-
 arch/parisc/kernel/drivers.c                       |    21 +-
 arch/powerpc/Kconfig.debug                         |     3 +-
 arch/powerpc/configs/amigaone_defconfig            |     1 -
 arch/powerpc/configs/chrp32_defconfig              |     1 -
 arch/powerpc/configs/g5_defconfig                  |     3 +-
 arch/powerpc/configs/pasemi_defconfig              |     1 -
 arch/powerpc/configs/powernv_defconfig             |     1 -
 arch/powerpc/configs/ppc64_defconfig               |     1 -
 arch/powerpc/configs/ppc64e_defconfig              |     1 -
 arch/powerpc/configs/ppc6xx_defconfig              |     1 +
 arch/powerpc/configs/skiroot_defconfig             |     1 -
 arch/powerpc/include/asm/Kbuild                    |     1 +
 arch/powerpc/include/asm/pmac_low_i2c.h            |     4 -
 arch/powerpc/kernel/time.c                         |     6 +-
 arch/powerpc/kernel/vdso/Makefile                  |     6 +
 arch/powerpc/kexec/Makefile                        |     2 +-
 arch/powerpc/lib/vmx-helper.c                      |     9 +-
 arch/powerpc/perf/core-book3s.c                    |     5 +-
 arch/powerpc/perf/hv-gpci.c                        |    24 +-
 arch/powerpc/platforms/44x/warp.c                  |     2 +
 arch/powerpc/platforms/82xx/km82xx.c               |     4 +-
 arch/powerpc/platforms/8xx/cpm1.c                  |     4 +-
 arch/powerpc/platforms/pasemi/pci.c                |     3 +-
 arch/powerpc/platforms/powermac/low_i2c.c          |    34 -
 arch/powerpc/platforms/ps3/device-init.c           |     4 +-
 arch/powerpc/platforms/pseries/htmdump.c           |   133 +-
 arch/powerpc/platforms/pseries/papr-hvpipe.c       |   181 +-
 arch/powerpc/platforms/pseries/papr-hvpipe.h       |     1 -
 arch/riscv/Kconfig                                 |    22 +
 .../boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi |    10 -
 .../boot/dts/microchip/mpfs-icicle-kit-prod.dts    |    10 +
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts  |    19 +
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |    27 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi           |    28 -
 arch/riscv/errata/mips/errata.c                    |     2 +-
 arch/riscv/include/asm/Kbuild                      |     1 +
 arch/riscv/kernel/compat_signal.c                  |     2 +
 arch/riscv/kernel/copy-unaligned.S                 |     5 +-
 arch/riscv/kernel/cpufeature.c                     |    20 +-
 arch/riscv/kernel/ptrace.c                         |     4 +-
 arch/riscv/kernel/traps_misaligned.c               |     2 +-
 arch/riscv/kernel/usercfi.c                        |     7 +-
 arch/riscv/kernel/vec-copy-unaligned.S             |     5 +-
 arch/riscv/kvm/vcpu_insn.c                         |     9 +-
 arch/riscv/kvm/vcpu_pmu.c                          |    12 +-
 arch/riscv/kvm/vcpu_sbi_sta.c                      |     2 +-
 arch/riscv/kvm/vcpu_sbi_v01.c                      |     2 +
 arch/riscv/mm/init.c                               |    25 +
 arch/s390/include/asm/Kbuild                       |     1 +
 arch/s390/kernel/debug.c                           |     8 +
 arch/s390/kernel/perf_pai.c                        |    31 +-
 arch/s390/kernel/topology.c                        |    10 +-
 arch/s390/kvm/dat.c                                |     1 +
 arch/s390/kvm/dat.h                                |     3 +-
 arch/s390/kvm/gaccess.c                            |     1 +
 arch/s390/kvm/gmap.c                               |    18 +-
 arch/s390/kvm/gmap.h                               |    61 +-
 arch/s390/kvm/interrupt.c                          |     3 +-
 arch/s390/kvm/pci.c                                |    10 +-
 arch/s390/mm/fault.c                               |     2 +-
 arch/sh/include/asm/Kbuild                         |     1 +
 arch/sh/include/asm/setup.h                        |     2 +-
 arch/sparc/include/asm/Kbuild                      |     1 +
 arch/um/include/asm/Kbuild                         |     1 +
 arch/x86/entry/Makefile                            |     2 +-
 arch/x86/entry/common.c                            |    61 +
 arch/x86/entry/entry.S                             |    46 +
 arch/x86/entry/entry_64_fred.S                     |     1 -
 arch/x86/entry/vdso/vma.c                          |     2 +-
 arch/x86/events/core.c                             |    13 +-
 arch/x86/events/intel/core.c                       |    50 +-
 arch/x86/events/perf_event.h                       |    10 +
 arch/x86/include/asm/Kbuild                        |     1 +
 arch/x86/include/asm/desc.h                        |     4 +
 arch/x86/include/asm/desc_defs.h                   |     2 +-
 arch/x86/include/asm/efi.h                         |     3 +-
 arch/x86/include/asm/entry-common.h                |     2 +
 arch/x86/include/asm/fred.h                        |     1 -
 arch/x86/include/asm/msr-index.h                   |     3 +-
 arch/x86/kernel/acpi/cppc.c                        |     6 +-
 arch/x86/kernel/cpu/amd.c                          |     3 +
 arch/x86/kernel/cpu/cpuid-deps.c                   |     1 +
 arch/x86/kernel/cpu/mce/core.c                     |    33 +-
 arch/x86/kernel/e820.c                             |     6 +-
 arch/x86/kernel/idt.c                              |    15 +
 arch/x86/kernel/nmi.c                              |     1 -
 arch/x86/kernel/relocate_kernel_64.S               |     8 +
 arch/x86/kvm/emulate.c                             |     2 +-
 arch/x86/kvm/hyperv.c                              |     2 +-
 arch/x86/kvm/lapic.c                               |    24 +-
 arch/x86/kvm/mmu/mmu.c                             |    54 +-
 arch/x86/kvm/svm/avic.c                            |    12 +-
 arch/x86/kvm/svm/nested.c                          |    43 +-
 arch/x86/kvm/svm/svm.c                             |    15 +-
 arch/x86/kvm/trace.h                               |     2 +-
 arch/x86/kvm/vmx/capabilities.h                    |     1 +
 arch/x86/kvm/vmx/vmenter.S                         |    46 -
 arch/x86/kvm/vmx/vmx.c                             |    76 +-
 arch/x86/kvm/x86.c                                 |     2 +-
 arch/x86/mm/fault.c                                |     2 +-
 arch/x86/platform/efi/quirks.c                     |    13 +-
 arch/x86/xen/mmu_pv.c                              |     8 +-
 arch/x86/xen/setup.c                               |    15 +-
 arch/xtensa/include/asm/Kbuild                     |     1 +
 block/bio-integrity-fs.c                           |     6 +-
 block/bio-integrity.c                              |    19 +-
 block/bio.c                                        |    27 +-
 block/blk-cgroup.c                                 |     2 +-
 block/blk-mq.c                                     |    53 +-
 block/blk-zoned.c                                  |    39 +-
 block/ioctl.c                                      |    24 +-
 crypto/authencesn.c                                |     5 +
 crypto/krb5/krb5_api.c                             |    54 +-
 drivers/accel/amdxdna/Makefile                     |    13 +-
 drivers/accel/amdxdna/aie.c                        |   167 +
 drivers/accel/amdxdna/aie.h                        |   120 +
 drivers/accel/amdxdna/aie2_ctx.c                   |   149 +-
 drivers/accel/amdxdna/aie2_error.c                 |    24 +-
 drivers/accel/amdxdna/aie2_message.c               |   338 +-
 drivers/accel/amdxdna/aie2_msg_priv.h              |    42 +-
 drivers/accel/amdxdna/aie2_pci.c                   |   283 +-
 drivers/accel/amdxdna/aie2_pci.h                   |   161 +-
 drivers/accel/amdxdna/aie2_pm.c                    |    22 +-
 drivers/accel/amdxdna/aie2_psp.c                   |   161 -
 drivers/accel/amdxdna/aie2_smu.c                   |   156 -
 drivers/accel/amdxdna/aie2_solver.c                |    10 +-
 drivers/accel/amdxdna/aie4_ctx.c                   |   333 +
 drivers/accel/amdxdna/aie4_host_queue.h            |    24 +
 drivers/accel/amdxdna/aie4_message.c               |    83 +
 drivers/accel/amdxdna/aie4_msg_priv.h              |   147 +
 drivers/accel/amdxdna/aie4_pci.c                   |   667 +
 drivers/accel/amdxdna/aie4_pci.h                   |    89 +
 drivers/accel/amdxdna/aie4_sriov.c                 |    88 +
 drivers/accel/amdxdna/aie_psp.c                    |   235 +
 drivers/accel/amdxdna/aie_smu.c                    |   153 +
 drivers/accel/amdxdna/amdxdna_cbuf.c               |   280 +
 drivers/accel/amdxdna/amdxdna_cbuf.h               |    18 +
 drivers/accel/amdxdna/amdxdna_ctx.c                |   125 +-
 drivers/accel/amdxdna/amdxdna_ctx.h                |    10 +-
 drivers/accel/amdxdna/amdxdna_debugfs.c            |   129 +
 drivers/accel/amdxdna/amdxdna_debugfs.h            |    18 +
 drivers/accel/amdxdna/amdxdna_gem.c                |   442 +-
 drivers/accel/amdxdna/amdxdna_gem.h                |    18 +-
 drivers/accel/amdxdna/amdxdna_iommu.c              |    76 +-
 drivers/accel/amdxdna/amdxdna_mailbox.c            |    30 +-
 drivers/accel/amdxdna/amdxdna_mailbox.h            |     8 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |   174 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |    36 +-
 drivers/accel/amdxdna/amdxdna_sysfs.c              |     5 +-
 drivers/accel/amdxdna/amdxdna_ubuf.c               |    62 +-
 drivers/accel/amdxdna/npu1_regs.c                  |    31 +-
 drivers/accel/amdxdna/npu3_regs.c                  |   100 +
 drivers/accel/amdxdna/npu4_regs.c                  |    73 +-
 drivers/accel/amdxdna/npu5_regs.c                  |    11 +-
 drivers/accel/amdxdna/npu6_regs.c                  |    11 +-
 drivers/accel/ethosu/ethosu_job.c                  |    19 +-
 drivers/accel/ivpu/ivpu_drv.c                      |    29 +-
 drivers/accel/ivpu/ivpu_drv.h                      |     3 -
 drivers/accel/ivpu/ivpu_fw.c                       |    23 +-
 drivers/accel/ivpu/ivpu_hw.h                       |    16 +-
 drivers/accel/ivpu/ivpu_hw_btrs.c                  |   112 +-
 drivers/accel/ivpu/ivpu_hw_btrs.h                  |    10 +-
 drivers/accel/ivpu/ivpu_hw_ip.c                    |    24 +-
 drivers/accel/ivpu/ivpu_ipc.c                      |     6 +-
 drivers/accel/ivpu/ivpu_jsm_msg.c                  |    21 +-
 drivers/accel/ivpu/ivpu_jsm_msg.h                  |     3 +-
 drivers/accel/ivpu/ivpu_sysfs.c                    |   190 +-
 drivers/accel/ivpu/vpu_boot_api.h                  |     6 +-
 drivers/accel/ivpu/vpu_jsm_api.h                   |    34 +-
 drivers/accel/qaic/mhi_controller.c                |     2 +-
 drivers/accel/qaic/mhi_controller.h                |     9 +-
 drivers/accel/qaic/qaic.h                          |    13 +-
 drivers/accel/qaic/qaic_control.c                  |     2 +-
 drivers/accel/qaic/qaic_data.c                     |    25 +-
 drivers/accel/qaic/qaic_debugfs.c                  |    30 +-
 drivers/accel/qaic/qaic_debugfs.h                  |     2 +-
 drivers/accel/qaic/qaic_drv.c                      |    10 +-
 drivers/accel/qaic/qaic_ras.c                      |     5 +-
 drivers/accel/qaic/qaic_ras.h                      |     1 +
 drivers/accel/qaic/qaic_ssr.c                      |     2 +-
 drivers/accel/qaic/qaic_ssr.h                      |     9 +-
 drivers/accel/qaic/qaic_timesync.c                 |     3 +-
 drivers/accel/qaic/qaic_timesync.h                 |     7 +-
 drivers/accel/qaic/sahara.c                        |     2 +-
 drivers/accel/qaic/sahara.h                        |     2 +-
 drivers/accel/rocket/rocket_gem.c                  |     2 +
 drivers/accel/rocket/rocket_job.c                  |     1 -
 drivers/acpi/ac.c                                  |     6 +-
 drivers/acpi/acpi_pad.c                            |     6 +-
 drivers/acpi/acpi_tad.c                            |    41 +-
 drivers/acpi/apei/einj-core.c                      |    55 +-
 drivers/acpi/arm64/cpuidle.c                       |    10 +-
 drivers/acpi/battery.c                             |    10 +-
 drivers/acpi/button.c                              |     9 +-
 drivers/acpi/cppc_acpi.c                           |     6 +-
 drivers/acpi/ec.c                                  |     6 +-
 drivers/acpi/hed.c                                 |     6 +-
 drivers/acpi/nfit/core.c                           |     6 +-
 drivers/acpi/pfr_telemetry.c                       |     6 +-
 drivers/acpi/pfr_update.c                          |     6 +-
 drivers/acpi/sbs.c                                 |     6 +-
 drivers/acpi/sbshc.c                               |     6 +-
 drivers/acpi/thermal.c                             |     2 +-
 drivers/acpi/tiny-power-button.c                   |     6 +-
 drivers/acpi/video_detect.c                        |     8 +
 drivers/android/binder/range_alloc/array.rs        |     1 -
 drivers/ata/libata-core.c                          |     9 +-
 drivers/ata/libata-eh.c                            |     8 +-
 drivers/ata/libata-pmp.c                           |    18 +-
 drivers/ata/libata-scsi.c                          |    93 +-
 drivers/ata/pata_parport/pata_parport.c            |    21 +-
 drivers/ata/sata_sil24.c                           |     6 +-
 drivers/base/memory.c                              |     8 +-
 drivers/base/platform.c                            |    16 +-
 drivers/base/regmap/regmap-sdw-mbq.c               |     2 +-
 drivers/block/rbd.c                                |    20 +-
 drivers/block/ublk_drv.c                           |    45 +-
 drivers/bluetooth/btintel_pcie.c                   |    33 +-
 drivers/bluetooth/btintel_pcie.h                   |     5 +-
 drivers/bluetooth/btmtk.c                          |    17 +-
 drivers/bluetooth/hci_ath.c                        |     3 +
 drivers/bluetooth/hci_bcsp.c                       |     3 +
 drivers/bluetooth/hci_h4.c                         |     3 +
 drivers/bluetooth/hci_h5.c                         |     3 +
 drivers/bluetooth/hci_ldisc.c                      |    48 +-
 drivers/bluetooth/hci_qca.c                        |    33 +-
 drivers/bluetooth/virtio_bt.c                      |    39 +-
 drivers/cdrom/cdrom.c                              |    73 +-
 drivers/char/agp/amd64-agp.c                       |     2 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |    70 +-
 drivers/char/ipmi/ipmi_ssif.c                      |    24 +-
 drivers/clk/clk-eyeq.c                             |    60 +-
 drivers/clk/clk-rk808.c                            |     2 +-
 drivers/clk/spacemit/ccu-k3.c                      |     2 +-
 drivers/cpufreq/Kconfig.x86                        |    12 -
 drivers/cpufreq/amd-pstate-ut.c                    |    36 +-
 drivers/cpufreq/amd-pstate.c                       |    27 +-
 drivers/cpufreq/intel_pstate.c                     |     3 +-
 drivers/dma-buf/.kunitconfig                       |     2 +
 drivers/dma-buf/Kconfig                            |    11 +-
 drivers/dma-buf/Makefile                           |     5 +-
 drivers/dma-buf/dma-fence-array.c                  |    13 +-
 drivers/dma-buf/dma-fence-unwrap.c                 |     3 +-
 drivers/dma-buf/dma-fence.c                        |     3 +-
 drivers/dma-buf/dma-heap.c                         |     1 +
 drivers/dma-buf/dma-resv.c                         |     3 +-
 drivers/dma-buf/heaps/Kconfig                      |    12 +-
 drivers/dma-buf/heaps/cma_heap.c                   |     3 +
 drivers/dma-buf/heaps/system_heap.c                |    21 +-
 drivers/dma-buf/selftest.c                         |   167 -
 drivers/dma-buf/selftest.h                         |    30 -
 drivers/dma-buf/selftests.h                        |    16 -
 drivers/dma-buf/st-dma-fence-chain.c               |   217 +-
 drivers/dma-buf/st-dma-fence-unwrap.c              |   292 +-
 drivers/dma-buf/st-dma-fence.c                     |   200 +-
 drivers/dma-buf/st-dma-resv.c                      |   145 +-
 drivers/dma-buf/udmabuf.c                          |    58 +-
 drivers/dpll/dpll_netlink.c                        |    10 +
 drivers/dpll/dpll_netlink.h                        |     2 -
 drivers/dpll/zl3073x/dpll.c                        |     6 +-
 drivers/edac/versalnet_edac.c                      |    10 +-
 drivers/firmware/arm_ffa/bus.c                     |     4 +-
 drivers/firmware/arm_ffa/driver.c                  |   146 +-
 drivers/firmware/efi/efi-pstore.c                  |     4 +-
 drivers/firmware/efi/efi.c                         |    28 +-
 drivers/firmware/efi/libstub/Makefile              |     2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c     |     4 +
 drivers/firmware/efi/libstub/efistub.h             |     7 -
 drivers/firmware/efi/libstub/loongarch-stub.c      |    80 +
 drivers/firmware/efi/libstub/loongarch.c           |    21 +
 drivers/firmware/efi/libstub/mem.c                 |    82 +
 drivers/firmware/efi/libstub/relocate.c            |   166 -
 drivers/firmware/efi/sysfb_efi.c                   |     9 +-
 drivers/firmware/psci/psci.c                       |    10 +
 drivers/fwctl/pds/main.c                           |     3 +
 drivers/gpio/gpio-aggregator.c                     |    15 +-
 drivers/gpio/gpio-pca953x.c                        |     2 +-
 drivers/gpio/gpio-sim.c                            |    11 +-
 drivers/gpio/gpio-virtuser.c                       |     9 +-
 drivers/gpio/gpiolib-cdev.c                        |    13 +
 drivers/gpu/buddy.c                                |    11 +
 drivers/gpu/drm/Kconfig                            |     7 +
 drivers/gpu/drm/adp/adp_drv.c                      |    14 +-
 drivers/gpu/drm/amd/amdgpu/Kconfig                 |     1 -
 drivers/gpu/drm/amd/amdgpu/Makefile                |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    48 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |    76 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    15 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c    |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |    24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   108 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   110 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    83 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     |    97 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    77 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |    32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h            |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    57 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        |   195 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h        |    39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |    99 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |     4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c           |    10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   451 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    62 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |    44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c     |    32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h     |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h          |    69 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   133 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c  |    33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   331 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   585 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |    64 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |   335 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   171 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   127 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   585 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    75 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |    13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |    33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |    15 +-
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c            |     3 +
 drivers/gpu/drm/amd/amdgpu/atom.c                  |    11 +
 drivers/gpu/drm/amd/amdgpu/atom.h                  |     3 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    48 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   243 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   236 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   224 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h         |   415 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    66 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |     7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |     6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    45 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |   125 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c        |    12 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c          |    12 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          |    14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c           |    12 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c         |    12 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    25 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |     9 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |    27 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |    13 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |    29 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |    31 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    35 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    76 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c               |    40 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c             |    12 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   149 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |     3 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   151 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c            |     3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |     2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |   204 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c           |   369 +
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h           |    31 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |    31 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    17 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c           |    14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    21 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |    12 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |    11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |    17 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |    16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |    13 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    12 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |    30 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    35 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |    21 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |    33 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c             |     3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |    10 +
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |    64 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |     9 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |     2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |     2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |     7 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |     5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |     3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |     1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |    40 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |     3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |     1 +
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |   351 +
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.h              |    29 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   283 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             |     6 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    56 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   232 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     6 +-
 .../amd/amdkfd/kfd_device_queue_manager_v12_1.c    |    19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |     7 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |    16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |    63 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |     8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |     6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |    26 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |    11 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    37 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    91 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |     8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |     9 +-
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c        |     9 +-
 drivers/gpu/drm/amd/display/Kconfig                |    12 +
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |     8 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   685 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    31 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   146 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |   118 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |    26 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |     5 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    60 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |    10 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    74 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |     5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   170 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |     7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |    13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   120 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   193 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |    18 +
 .../display/amdgpu_dm/amdgpu_dm_kunit_helpers.h    |    19 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   101 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |     4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |     6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |    55 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |   267 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |    20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   146 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h   |    28 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    27 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |    20 +-
 .../drm/amd/display/amdgpu_dm/tests/.kunitconfig   |    22 +
 .../gpu/drm/amd/display/amdgpu_dm/tests/Makefile   |    18 +
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |  1639 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   239 +
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   121 +
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   175 +
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   938 +
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   291 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   206 +
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |     2 +-
 .../gpu/drm/amd/display/dc/basics/custom_float.c   |     2 +-
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c  |     6 +-
 drivers/gpu/drm/amd/display/dc/basics/vector.c     |     4 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |   130 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   217 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.c   |     9 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.h   |     5 +
 .../gpu/drm/amd/display/dc/bios/command_table.c    |    12 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |    10 +-
 .../amd/display/dc/bios/command_table_helper2.c    |     1 +
 .../dc/bios/dce112/command_table_helper2_dce112.c  |     3 +
 .../dc/bios/dce112/command_table_helper_dce112.c   |     3 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |    10 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    15 +
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |   150 +-
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h    |     5 +-
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |    37 +-
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |    41 -
 .../amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c |    16 -
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c |     2 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |    19 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |    42 +-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |    56 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c       |     4 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h       |     2 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |    43 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |    58 +-
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |    72 +-
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |    71 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |    61 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |    78 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |   141 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    79 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h |     4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c     |     4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h     |     2 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |    61 +-
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c   |     1 -
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |   483 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h |    48 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   919 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |     8 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  1139 +-
 .../gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c  |    14 +-
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |    47 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   446 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |    10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    79 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |     8 +-
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c |     4 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   300 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |     7 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   151 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |     9 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |     7 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |    10 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c       |    10 +-
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h     |   164 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |    18 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    12 +-
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    43 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    80 +-
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c |    15 +-
 .../gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c |    40 +
 .../gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.h |     8 +
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c |    92 +-
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h |    13 +
 .../drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c   |    25 +
 .../gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c |    68 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |   321 +
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c   |    93 +-
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h   |     4 +
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    35 +
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |     8 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |   197 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |     8 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   133 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |    26 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |     2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c    |    16 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c       |     2 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |     7 +-
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.c    |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |    22 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c  |    16 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |    12 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |    23 +-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |    10 +-
 .../amd/display/dc/dce80/dce80_timing_generator.c  |     2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |    16 +-
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |    22 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c   |     2 +-
 .../drm/amd/display/dc/dcn21/dcn21_link_encoder.c  |     2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |     8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h   |    13 +
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |    16 +-
 .../amd/display/dc/dio/dcn20/dcn20_link_encoder.h  |     1 +
 .../display/dc/dio/dcn30/dcn30_dio_link_encoder.c  |   250 +
 .../display/dc/dio/dcn30/dcn30_dio_link_encoder.h  |    17 +
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c        |     6 +-
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c        |    18 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.c  |   114 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.h  |     8 +
 .../display/dc/dio/dcn32/dcn32_dio_link_encoder.c  |   214 +
 .../display/dc/dio/dcn32/dcn32_dio_link_encoder.h  |    16 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c        |    20 +
 .../display/dc/dio/dcn35/dcn35_dio_link_encoder.c  |    21 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c        |   220 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h        |    16 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c      |     2 +-
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.c  |    21 +
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.h  |    97 +-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c        |    68 +-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.h        |     6 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h         |     1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |     1 +
 drivers/gpu/drm/amd/display/dc/dm_services.h       |     8 -
 drivers/gpu/drm/amd/display/dc/dm_services_types.h |    31 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |     3 +
 .../drm/amd/display/dc/dml/calcs/dcn_calc_auto.c   |  1824 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calc_math.c   |     6 +-
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |   294 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |   166 +-
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |   328 +-
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |   326 +-
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  |   164 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |   164 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |   368 +-
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |    80 +-
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |   221 +-
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h   |    22 +
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |  1033 +-
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  |    82 +-
 .../gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c |    27 +-
 .../gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c |    19 +-
 .../gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c |    19 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   |    41 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |  1124 +-
 .../display/dc/dml/dcn31/display_rq_dlg_calc_31.c  |    76 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |    23 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |  1126 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c        |    80 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   426 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h   |     2 +
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |   211 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |   461 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h        |     8 +-
 .../display/dc/dml/dcn32/display_rq_dlg_calc_32.c  |   138 +-
 .../gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c |    95 +-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |    37 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |    37 +-
 .../drm/amd/display/dc/dml/display_mode_enums.h    |     1 +
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |     8 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |    12 +-
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |    32 +-
 .../gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c  |   790 +
 .../gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h  |   173 +
 .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   |    18 +-
 .../gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c   |    82 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |     2 +
 drivers/gpu/drm/amd/display/dc/dml2_0/README.md    |    31 +
 .../drm/amd/display/dc/dml2_0/display_mode_core.c  |   124 +-
 .../drm/amd/display/dc/dml2_0/display_mode_util.c  |    23 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |    58 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |     2 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |   227 +
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |     2 +-
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |     1 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |    29 +-
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |     1 -
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |     3 +
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |     1 -
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c  |     2 +-
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |     1 -
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c  |   223 +-
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h  |     2 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |    30 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h       |    46 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |    19 +-
 .../dml2_standalone_libraries/lib_frl_cap_check.c  |   396 +
 .../dml2_standalone_libraries/lib_frl_cap_check.h  |    90 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c       |     1 -
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h |     9 -
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c  |    30 +-
 .../drm/amd/display/dc/dml2_0/dml2_mall_phantom.c  |   105 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_policy.c    |     6 +-
 .../display/dc/dml2_0/dml2_translation_helper.c    |     8 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |    44 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h   |     1 +
 .../drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c    |   413 +
 .../drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h    |   109 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |     4 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c  |     2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |    18 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |     5 +-
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c |     8 +-
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |     2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |     3 +-
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |    15 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |   719 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |    27 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c   |     8 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |    13 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |     5 +
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c   |    33 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |     8 +
 .../amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c |   313 +
 .../amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h |    11 +
 .../display/dc/gpio/dcn42b/hw_translate_dcn42b.c   |   192 +
 .../display/dc/gpio/dcn42b/hw_translate_dcn42b.h   |    13 +
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |     3 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |     2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     4 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c   |     2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c      |     2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h      |     9 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c       |     2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     4 +
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c     |     1 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile        |    10 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c      |   286 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h      |   146 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c    |  1043 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h    |   436 +
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c     |     2 +-
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h     |    47 +
 .../dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c  |   907 +
 .../dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h  |   335 +
 .../dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c    |   207 +
 .../dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h    |    59 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c |    16 +-
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |    28 +-
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h |     3 +
 .../drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c |    12 +-
 .../drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c |    12 +-
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |    12 +-
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h |   198 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |     9 +-
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |     5 +-
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |     6 +-
 .../gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c |     4 +-
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |     4 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |   233 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |    25 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |    78 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |    29 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile       |     8 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   260 +-
 .../drm/amd/display/dc/hwss/dce120/dce120_hwseq.c  |    12 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   126 +-
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c |     2 +
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |    66 +-
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c |     2 +
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c    |    10 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    88 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h    |    13 +
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |     3 +
 .../drm/amd/display/dc/hwss/dcn301/dcn301_init.c   |     2 +
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |    25 +-
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |     3 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |    91 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |     3 +
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    51 +-
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |     5 +
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |   125 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h    |     2 +
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |     2 +
 .../drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c  |     2 +-
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |     2 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   533 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |     3 +
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   556 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |     9 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |     2 +
 .../drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c  |   238 +
 .../drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h  |    15 +
 .../drm/amd/display/dc/hwss/dcn42b/dcn42b_init.c   |    20 +
 .../drm/amd/display/dc/hwss/dcn42b/dcn42b_init.h   |    14 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |   427 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |     3 +
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h      |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h  |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |     2 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    22 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    43 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |    52 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |    10 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    39 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |     1 +
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |   176 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |    79 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h       |     1 -
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |   232 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    13 +-
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |    17 +-
 drivers/gpu/drm/amd/display/dc/inc/reg_helper.h    |    72 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |     9 +
 .../drm/amd/display/dc/inc/soc_and_ip_translator.h |    19 +-
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |     2 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile       |     2 +
 .../amd/display/dc/link/accessories/link_dp_cts.c  |    39 +-
 .../amd/display/dc/link/hwss/link_hwss_hpo_dp.c    |     4 +-
 .../amd/display/dc/link/hwss/link_hwss_hpo_frl.c   |   113 +
 .../amd/display/dc/link/hwss/link_hwss_hpo_frl.h   |    34 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   123 +-
 .../gpu/drm/amd/display/dc/link/link_detection.h   |     2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   288 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.h    |     1 +
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |   136 +-
 .../gpu/drm/amd/display/dc/link/link_validation.c  |   302 +-
 .../gpu/drm/amd/display/dc/link/link_validation.h  |    13 +
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |   158 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.h   |     4 +
 .../display/dc/link/protocols/link_dp_capability.c |    12 +-
 .../amd/display/dc/link/protocols/link_dp_dpia.c   |     2 +-
 .../display/dc/link/protocols/link_dp_dpia_bw.c    |    12 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |    55 +-
 .../dc/link/protocols/link_dp_panel_replay.c       |    40 +-
 .../display/dc/link/protocols/link_dp_training.c   |     4 +-
 .../dc/link/protocols/link_dp_training_8b_10b.c    |    10 +-
 .../dc/link/protocols/link_edp_panel_control.c     |    60 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |  1187 +
 .../amd/display/dc/link/protocols/link_hdmi_frl.h  |    53 +
 .../drm/amd/display/dc/link/protocols/link_hpd.c   |     1 +
 .../amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c |     4 +-
 .../amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c |     4 +-
 .../gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   |     4 +-
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |     6 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |   177 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |    25 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   |   392 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h   |    49 +-
 .../gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c   |     1 +
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c   |     2 +-
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h   |     2 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c |     2 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h |     5 +-
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |     4 +-
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c |     8 +-
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h |     8 +-
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |     2 +
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |     2 +-
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |     1 -
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.c   |     2 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c |     2 -
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |   180 +-
 .../drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c    |     6 +-
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |    47 +-
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h    |    86 +
 drivers/gpu/drm/amd/display/dc/resource/Makefile   |     7 +
 .../display/dc/resource/dce100/dce100_resource.c   |    10 +-
 .../display/dc/resource/dce110/dce110_resource.c   |    12 +-
 .../display/dc/resource/dce112/dce112_resource.c   |     7 +-
 .../display/dc/resource/dce120/dce120_resource.c   |     6 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |     3 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |    11 +-
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |    19 +-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |    80 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |    28 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |   203 +-
 .../display/dc/resource/dcn301/dcn301_resource.c   |    40 +-
 .../display/dc/resource/dcn302/dcn302_resource.c   |   135 +-
 .../display/dc/resource/dcn303/dcn303_resource.c   |   135 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |   161 +-
 .../display/dc/resource/dcn314/dcn314_resource.c   |   157 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |   169 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |   159 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |   184 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.h |    79 +-
 .../dc/resource/dcn32/dcn32_resource_helpers.c     |     8 +-
 .../display/dc/resource/dcn321/dcn321_resource.c   |   158 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |   151 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |   151 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |   151 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |   161 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   238 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.h |    10 +-
 .../display/dc/resource/dcn42/dcn42_resource_fpu.c |    22 +
 .../display/dc/resource/dcn42/dcn42_resource_fpu.h |     2 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |  2404 +
 .../display/dc/resource/dcn42b/dcn42b_resource.h   |   672 +
 .../dcn401/dcn401_soc_and_ip_translator.c          |    42 +-
 .../dcn42/dcn42_soc_and_ip_translator.c            |    26 +-
 .../soc_and_ip_translator/soc_and_ip_translator.c  |     1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |     1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   581 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |     1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c |    34 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h |    13 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |     4 +
 drivers/gpu/drm/amd/display/include/audio_types.h  |     1 +
 .../drm/amd/display/include/bios_parser_types.h    |    15 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     7 +-
 drivers/gpu/drm/amd/display/include/dal_types.h    |     1 +
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |     6 +-
 .../amd/display/include/grph_object_ctrl_defs.h    |    13 +-
 drivers/gpu/drm/amd/display/include/logger_types.h |     2 +
 drivers/gpu/drm/amd/display/include/signal_types.h |    12 +-
 .../drm/amd/display/modules/color/color_gamma.c    |    40 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |     2 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |     6 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |     3 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |     2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |     2 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.h    |     2 +
 .../drm/amd/display/modules/inc/mod_color_types.h  |    47 +
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |     3 +
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |     1 +
 .../drm/amd/display/modules/inc/mod_info_packet.h  |    11 +-
 .../display/modules/inc/mod_info_packet_types.h    |    37 +
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |   417 +
 .../amd/display/modules/info_packet/info_packet.c  |   126 +-
 drivers/gpu/drm/amd/display/modules/power/Makefile |     4 +-
 drivers/gpu/drm/amd/display/modules/power/power.c  |   503 +
 .../gpu/drm/amd/display/modules/power/power_abm.c  |  2070 +
 .../drm/amd/display/modules/power/power_helpers.c  |  1065 -
 .../drm/amd/display/modules/power/power_helpers.h  |   122 +
 .../gpu/drm/amd/display/modules/power/power_psr.c  |   665 +
 .../drm/amd/display/modules/power/power_replay.c   |   911 +
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c    |     6 +-
 drivers/gpu/drm/amd/include/amd_cper.h             |     2 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |     4 +
 drivers/gpu/drm/amd/include/amdgpu_ptl.h           |    64 +
 .../amd/include/asic_reg/clk/clk_15_0_5_offset.h   |    42 +
 .../amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h  |    45 +
 .../amd/include/asic_reg/dcn/dcn_3_0_0_offset.h    |   129 +
 .../amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h   |   600 +
 .../amd/include/asic_reg/dcn/dcn_3_0_2_offset.h    |   112 +
 .../amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h   |  1907 +
 .../amd/include/asic_reg/dcn/dcn_3_0_3_offset.h    |   111 +
 .../amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h   |   941 +
 .../amd/include/asic_reg/dcn/dcn_3_1_2_offset.h    |   109 +
 .../amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h   |   548 +
 .../amd/include/asic_reg/dcn/dcn_3_1_4_offset.h    |   108 +
 .../amd/include/asic_reg/dcn/dcn_3_1_4_sh_mask.h   |   544 +
 .../amd/include/asic_reg/dcn/dcn_3_1_5_offset.h    |   111 +
 .../amd/include/asic_reg/dcn/dcn_3_1_5_sh_mask.h   |   548 +
 .../amd/include/asic_reg/dcn/dcn_3_1_6_offset.h    |   111 +
 .../amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h   |   546 +
 .../amd/include/asic_reg/dcn/dcn_3_2_0_offset.h    |   109 +
 .../amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h   |   544 +
 .../amd/include/asic_reg/dcn/dcn_3_2_1_offset.h    |   124 +-
 .../amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h   |   548 +
 .../amd/include/asic_reg/dcn/dcn_4_2_1_offset.h    | 16305 +++++
 .../amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h   | 60623 +++++++++++++++=
++++
 .../amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h  |   109 +
 .../amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h |   413 +
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h |   110 +
 .../amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h    |   455 +
 .../drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h |   149 +
 .../amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h    |   377 +
 .../amd/include/asic_reg/nbio/nbio_6_3_2_offset.h  | 13149 ++++
 .../amd/include/asic_reg/nbio/nbio_6_3_2_sh_mask.h | 49475 +++++++++++++++
 .../amd/include/asic_reg/vpe/vpe_2_0_0_offset.h    |  1041 +
 .../amd/include/asic_reg/vpe/vpe_2_0_0_sh_mask.h   |  3162 +
 drivers/gpu/drm/amd/include/dm_pp_interface.h      |    19 -
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |     6 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |     4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |     8 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |    77 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c         |     6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |    50 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |    37 +-
 .../drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   |    10 -
 .../drm/amd/pm/powerplay/hwmgr/processpptables.c   |     1 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |    47 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |    15 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |    63 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c    |    10 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |    18 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |    16 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |    17 -
 .../gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h |     3 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |     5 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c    |    13 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |     1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |     1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |     1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |    42 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |     9 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |    32 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |     3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |     1 -
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |    47 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |    38 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |   229 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |    34 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   106 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |    22 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |    15 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    26 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |    84 +-
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h          |     9 +
 drivers/gpu/drm/amd/ras/rascore/ras.h              |     1 -
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c          |   108 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h          |    12 +-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c         |     6 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cper.c         |    20 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cper.h         |     2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c       |    33 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c    |     8 +-
 drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c     |    23 +-
 drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h     |     2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c          |    21 +-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c          |    40 +-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h          |    12 +
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |     8 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |    10 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |    14 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |    28 +-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |     4 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |    10 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |     6 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |     4 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |     2 +-
 drivers/gpu/drm/arm/malidp_mw.h                    |     2 +-
 drivers/gpu/drm/arm/malidp_planes.c                |     6 +-
 drivers/gpu/drm/armada/armada_crtc.c               |    10 +-
 drivers/gpu/drm/armada/armada_overlay.c            |    10 +-
 drivers/gpu/drm/armada/armada_plane.c              |     6 +-
 drivers/gpu/drm/armada/armada_plane.h              |     2 +-
 drivers/gpu/drm/ast/ast_2000.c                     |    61 +-
 drivers/gpu/drm/ast/ast_2100.c                     |   292 +-
 drivers/gpu/drm/ast/ast_2300.c                     |   392 +-
 drivers/gpu/drm/ast/ast_2500.c                     |   327 +-
 drivers/gpu/drm/ast/ast_cursor.c                   |     6 +-
 drivers/gpu/drm/ast/ast_dp.c                       |     4 +-
 drivers/gpu/drm/ast/ast_dp501.c                    |   134 +-
 drivers/gpu/drm/ast/ast_drv.c                      |    84 +-
 drivers/gpu/drm/ast/ast_drv.h                      |    60 +-
 drivers/gpu/drm/ast/ast_mode.c                     |   104 +-
 drivers/gpu/drm/ast/ast_post.c                     |    48 +-
 drivers/gpu/drm/ast/ast_post.h                     |    20 +-
 drivers/gpu/drm/ast/ast_reg.h                      |   211 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |    10 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |     2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |     2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |     6 +-
 drivers/gpu/drm/bridge/Kconfig                     |    12 +
 drivers/gpu/drm/bridge/Makefile                    |     1 +
 drivers/gpu/drm/bridge/adv7511/adv7511.h           |     1 -
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |    21 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |     3 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |   247 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |     1 -
 drivers/gpu/drm/bridge/analogix/anx7625.c          |     4 +-
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |    15 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |     6 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c           |    21 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |    28 +-
 drivers/gpu/drm/bridge/fsl-ldb.c                   |     4 +-
 drivers/gpu/drm/bridge/imx/Kconfig                 |    28 +-
 drivers/gpu/drm/bridge/imx/Makefile                |     3 +-
 drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c     |    91 -
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c       |     4 +-
 .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.c    |    75 +
 .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso |    30 +
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c        |     1 +
 drivers/gpu/drm/bridge/imx/imx8qm-ldb.c            |     4 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c           |     6 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c    |     2 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c    |     4 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c       |    42 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |    10 +-
 drivers/gpu/drm/bridge/ite-it6263.c                |    33 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |    10 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |   453 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |    10 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |     1 +
 drivers/gpu/drm/bridge/lontium-lt9211.c            |     4 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |    17 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |     9 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |    16 +-
 drivers/gpu/drm/bridge/microchip-lvds.c            |    63 +-
 drivers/gpu/drm/bridge/nwl-dsi.c                   |     4 +-
 drivers/gpu/drm/bridge/of-display-mode-bridge.c    |    93 +
 drivers/gpu/drm/bridge/panel.c                     |     8 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |     4 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |     8 +-
 drivers/gpu/drm/bridge/sii902x.c                   |     4 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |     5 +
 drivers/gpu/drm/bridge/ssd2825.c                   |     6 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |     8 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |    10 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    65 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |     6 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |     6 +-
 drivers/gpu/drm/bridge/tc358762.c                  |     6 +-
 drivers/gpu/drm/bridge/tc358767.c                  |     8 +-
 drivers/gpu/drm/bridge/tc358768.c                  |   210 +-
 drivers/gpu/drm/bridge/tc358775.c                  |     6 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |     4 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c               |     6 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |    20 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    24 +-
 drivers/gpu/drm/bridge/ti-tdp158.c                 |     4 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |     2 +-
 drivers/gpu/drm/bridge/waveshare-dsi.c             |     5 +-
 drivers/gpu/drm/ci/gitlab-ci.yml                   |     4 +
 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt      |    20 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |    13 +-
 drivers/gpu/drm/display/drm_dp_helper.c            |    73 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |    58 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |    31 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |     6 +-
 drivers/gpu/drm/drm_atomic.c                       |   238 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   172 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |     2 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |    28 +-
 drivers/gpu/drm/drm_auth.c                         |     2 +-
 drivers/gpu/drm/drm_blend.c                        |     8 +-
 drivers/gpu/drm/drm_bridge.c                       |   153 +-
 drivers/gpu/drm/drm_buddy.c                        |     1 +
 drivers/gpu/drm/drm_client_modeset.c               |     8 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |     8 +-
 drivers/gpu/drm/drm_colorop.c                      |     8 +-
 drivers/gpu/drm/drm_connector.c                    |     9 +-
 drivers/gpu/drm/drm_crtc_helper.c                  |     2 +-
 drivers/gpu/drm/drm_crtc_internal.h                |    10 +-
 drivers/gpu/drm/drm_damage_helper.c                |    10 +-
 drivers/gpu/drm/drm_drv.c                          |     2 +
 drivers/gpu/drm/drm_encoder.c                      |    18 +-
 drivers/gpu/drm/drm_exec.c                         |     9 +-
 drivers/gpu/drm/drm_fb_helper.c                    |    10 +-
 drivers/gpu/drm/drm_fourcc.c                       |    25 +-
 drivers/gpu/drm/drm_framebuffer.c                  |     8 +-
 drivers/gpu/drm/drm_gem.c                          |    74 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |     4 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |    32 +-
 drivers/gpu/drm/drm_gpusvm.c                       |    55 +-
 drivers/gpu/drm/drm_gpuvm.c                        |    12 +-
 drivers/gpu/drm/drm_mipi_dbi.c                     |     8 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |    28 +
 drivers/gpu/drm/drm_mode_object.c                  |     8 +-
 drivers/gpu/drm/drm_modeset_helper.c               |     2 +-
 drivers/gpu/drm/drm_of.c                           |    60 +-
 drivers/gpu/drm/drm_pagemap.c                      |   226 +-
 drivers/gpu/drm/drm_panel.c                        |    31 +-
 drivers/gpu/drm/drm_ras.c                          |    43 +-
 drivers/gpu/drm/drm_ras_nl.c                       |    13 +
 drivers/gpu/drm/drm_ras_nl.h                       |     2 +
 drivers/gpu/drm/drm_self_refresh_helper.c          |    12 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |    10 +-
 drivers/gpu/drm/drm_syncobj.c                      |    10 +-
 drivers/gpu/drm/drm_vblank.c                       |    36 +-
 drivers/gpu/drm/drm_vblank_helper.c                |     6 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |    12 -
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |     3 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |    17 +-
 drivers/gpu/drm/exynos/Kconfig                     |     3 +
 drivers/gpu/drm/exynos/exynos_dp.c                 |   110 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |    10 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |    15 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |     1 -
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |     9 -
 drivers/gpu/drm/exynos/exynos_drm_fb.c             |     9 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.h             |    10 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   113 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |    13 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |    52 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |     8 -
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            |     2 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.h            |     4 +-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |     8 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |     6 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |     6 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |     6 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |     1 +
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |     9 +-
 drivers/gpu/drm/gma500/psb_drv.c                   |     1 -
 drivers/gpu/drm/gud/gud_connector.c                |    10 +-
 drivers/gpu/drm/gud/gud_drv.c                      |     1 +
 drivers/gpu/drm/gud/gud_internal.h                 |     8 +-
 drivers/gpu/drm/gud/gud_pipe.c                     |     8 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h       |     1 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h         |     1 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c       |     2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |    90 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c     |    39 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    14 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |     1 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    75 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |     9 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |    14 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |     6 +-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c          |     2 +-
 drivers/gpu/drm/i915/Kconfig.debug                 |     2 +-
 drivers/gpu/drm/i915/Makefile                      |     7 +-
 drivers/gpu/drm/i915/display/g4x_dp.c              |     4 +-
 drivers/gpu/drm/i915/display/g4x_dp.h              |    10 +-
 drivers/gpu/drm/i915/display/g4x_hdmi.c            |     4 +-
 drivers/gpu/drm/i915/display/g4x_hdmi.h            |    12 +-
 drivers/gpu/drm/i915/display/i9xx_display_sr.c     |     2 +-
 drivers/gpu/drm/i915/display/i9xx_plane.c          |     2 +-
 drivers/gpu/drm/i915/display/i9xx_wm.c             |   107 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |     2 +-
 drivers/gpu/drm/i915/display/intel_alpm.c          |    20 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |    19 +-
 drivers/gpu/drm/i915/display/intel_atomic.h        |    12 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |    32 +-
 drivers/gpu/drm/i915/display/intel_backlight.c     |     2 +-
 drivers/gpu/drm/i915/display/intel_bo.c            |    27 +
 drivers/gpu/drm/i915/display/intel_bo.h            |     8 +
 drivers/gpu/drm/i915/display/intel_bw.c            |   373 +-
 drivers/gpu/drm/i915/display/intel_casf.c          |   122 +-
 drivers/gpu/drm/i915/display/intel_casf.h          |     6 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   156 +-
 drivers/gpu/drm/i915/display/intel_color.c         |   111 +-
 drivers/gpu/drm/i915/display/intel_color.h         |     3 +
 drivers/gpu/drm/i915/display/intel_combo_phy.c     |     2 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |     8 +-
 drivers/gpu/drm/i915/display/intel_crt.h           |     6 +-
 drivers/gpu/drm/i915/display/intel_crtc.c          |    17 +-
 .../gpu/drm/i915/display/intel_crtc_state_dump.c   |    26 +-
 drivers/gpu/drm/i915/display/intel_cursor.c        |     1 -
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |     4 +-
 drivers/gpu/drm/i915/display/intel_dbuf_bw.c       |     7 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |    79 +-
 drivers/gpu/drm/i915/display/intel_ddi.h           |     6 +-
 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c |    11 +-
 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.h |     3 +
 drivers/gpu/drm/i915/display/intel_de.c            |    36 +-
 drivers/gpu/drm/i915/display/intel_de.h            |    57 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   316 +-
 drivers/gpu/drm/i915/display/intel_display.h       |   100 +-
 .../drm/i915/display/intel_display_clock_gating.c  |   270 +
 .../drm/i915/display/intel_display_clock_gating.h  |    27 +
 drivers/gpu/drm/i915/display/intel_display_core.h  |    68 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |    19 +-
 .../gpu/drm/i915/display/intel_display_device.c    |     4 +-
 .../gpu/drm/i915/display/intel_display_device.h    |     2 +-
 .../gpu/drm/i915/display/intel_display_driver.c    |    16 +-
 .../gpu/drm/i915/display/intel_display_driver.h    |     4 +-
 drivers/gpu/drm/i915/display/intel_display_irq.c   |   264 +-
 drivers/gpu/drm/i915/display/intel_display_irq.h   |    37 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |   108 +-
 drivers/gpu/drm/i915/display/intel_display_power.h |    21 +-
 .../gpu/drm/i915/display/intel_display_power_map.c |     2 +-
 .../drm/i915/display/intel_display_power_well.c    |    73 +-
 .../gpu/drm/i915/display/intel_display_reg_defs.h  |    35 +
 drivers/gpu/drm/i915/display/intel_display_regs.h  |    82 +-
 drivers/gpu/drm/i915/display/intel_display_reset.c |    50 +-
 drivers/gpu/drm/i915/display/intel_display_reset.h |     8 +-
 drivers/gpu/drm/i915/display/intel_display_trace.h |     6 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |    34 +-
 drivers/gpu/drm/i915/display/intel_display_wa.c    |     4 +-
 drivers/gpu/drm/i915/display/intel_display_wa.h    |     1 +
 drivers/gpu/drm/i915/display/intel_dmc.c           |    62 +-
 drivers/gpu/drm/i915/display/intel_dmc_wl.c        |    25 +-
 drivers/gpu/drm/i915/display/intel_dmc_wl.h        |     6 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   495 +-
 drivers/gpu/drm/i915/display/intel_dp.h            |     5 +
 drivers/gpu/drm/i915/display/intel_dp_aux.c        |    48 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |    19 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |   144 +-
 .../gpu/drm/i915/display/intel_dp_link_training.h  |     5 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |    28 +-
 drivers/gpu/drm/i915/display/intel_dp_test.c       |     2 +-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c     |    26 +-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h     |     6 +
 drivers/gpu/drm/i915/display/intel_dpcd.h          |    15 +
 drivers/gpu/drm/i915/display/intel_dpio_phy.c      |   184 +-
 drivers/gpu/drm/i915/display/intel_dpll.c          |   144 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |    38 +-
 drivers/gpu/drm/i915/display/intel_dram.c          |    48 +-
 drivers/gpu/drm/i915/display/intel_drrs.c          |     4 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |    22 +-
 drivers/gpu/drm/i915/display/intel_dsb.h           |    10 +-
 drivers/gpu/drm/i915/display/intel_dsi.c           |     7 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |    29 +-
 drivers/gpu/drm/i915/display/intel_dvo_dev.h       |     2 +-
 drivers/gpu/drm/i915/display/intel_fb.c            |    49 +-
 drivers/gpu/drm/i915/display/intel_fb.h            |     3 +-
 drivers/gpu/drm/i915/display/intel_fb_pin.c        |   357 -
 drivers/gpu/drm/i915/display/intel_fb_pin.h        |    33 -
 drivers/gpu/drm/i915/display/intel_fbc.c           |    13 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |    65 +-
 drivers/gpu/drm/i915/display/intel_fbdev.h         |    11 +-
 drivers/gpu/drm/i915/display/intel_fbdev_fb.c      |   118 -
 drivers/gpu/drm/i915/display/intel_fbdev_fb.h      |    24 -
 drivers/gpu/drm/i915/display/intel_fdi.c           |    28 +-
 drivers/gpu/drm/i915/display/intel_fifo_underrun.c |     8 +-
 drivers/gpu/drm/i915/display/intel_flipq.c         |     4 +-
 drivers/gpu/drm/i915/display/intel_global_state.c  |     8 +-
 drivers/gpu/drm/i915/display/intel_gmbus.c         |     4 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |    27 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   195 +-
 drivers/gpu/drm/i915/display/intel_hotplug_irq.c   |    30 +-
 drivers/gpu/drm/i915/display/intel_initial_plane.c |    87 +-
 drivers/gpu/drm/i915/display/intel_link_bw.c       |     2 +-
 drivers/gpu/drm/i915/display/intel_load_detect.c   |    22 +-
 drivers/gpu/drm/i915/display/intel_load_detect.h   |     6 +-
 drivers/gpu/drm/i915/display/intel_lpe_audio.c     |     2 +-
 drivers/gpu/drm/i915/display/intel_lt_phy.c        |     8 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |    13 +-
 drivers/gpu/drm/i915/display/intel_lvds.h          |     6 +-
 drivers/gpu/drm/i915/display/intel_mchbar.c        |    78 +
 drivers/gpu/drm/i915/display/intel_mchbar.h        |    21 +
 drivers/gpu/drm/i915/display/intel_modeset_lock.c  |     2 +-
 drivers/gpu/drm/i915/display/intel_modeset_setup.c |    45 +-
 drivers/gpu/drm/i915/display/intel_opregion.c      |     2 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |    10 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |     9 +-
 drivers/gpu/drm/i915/display/intel_panel.h         |     3 +-
 drivers/gpu/drm/i915/display/intel_parent.c        |    95 +-
 drivers/gpu/drm/i915/display/intel_parent.h        |    42 +-
 drivers/gpu/drm/i915/display/intel_pch_display.c   |    14 +-
 drivers/gpu/drm/i915/display/intel_pfit.c          |    24 +-
 drivers/gpu/drm/i915/display/intel_pipe_crc.c      |     8 +-
 drivers/gpu/drm/i915/display/intel_plane.c         |   160 +-
 drivers/gpu/drm/i915/display/intel_plane.h         |     6 +
 drivers/gpu/drm/i915/display/intel_pmdemand.c      |     8 +-
 drivers/gpu/drm/i915/display/intel_pps.c           |    38 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   208 +-
 drivers/gpu/drm/i915/display/intel_psr.h           |     1 +
 drivers/gpu/drm/i915/display/intel_quirks.c        |    17 +
 drivers/gpu/drm/i915/display/intel_quirks.h        |     1 +
 drivers/gpu/drm/i915/display/intel_rom.c           |    19 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |    25 +-
 drivers/gpu/drm/i915/display/intel_sdvo.h          |    10 +-
 drivers/gpu/drm/i915/display/intel_snps_phy.c      |     6 +-
 drivers/gpu/drm/i915/display/intel_sprite_uapi.c   |     8 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |    18 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |     4 +-
 drivers/gpu/drm/i915/display/intel_vblank.c        |     6 +-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |    10 +-
 drivers/gpu/drm/i915/display/intel_vga.c           |     4 +-
 drivers/gpu/drm/i915/display/intel_vrr.c           |    20 +-
 drivers/gpu/drm/i915/display/intel_wm.c            |    32 +-
 drivers/gpu/drm/i915/display/skl_scaler.c          |   172 +-
 drivers/gpu/drm/i915/display/skl_scaler.h          |     2 -
 drivers/gpu/drm/i915/display/skl_universal_plane.c |    39 +-
 drivers/gpu/drm/i915/display/skl_watermark.c       |   334 +-
 drivers/gpu/drm/i915/display/vlv_clock.c           |    13 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |    36 +-
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c         |    38 +-
 drivers/gpu/drm/i915/display/vlv_sideband.c        |   136 +-
 drivers/gpu/drm/i915/display/vlv_sideband.h        |   166 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |     5 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |     4 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |    28 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |    16 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |     2 +-
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |     2 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |     2 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c      |     1 -
 drivers/gpu/drm/i915/gt/intel_llc.c                |     2 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.c        |     2 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |    43 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |     4 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |     3 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c        |     1 -
 drivers/gpu/drm/i915/gvt/cfg_space.c               |     2 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |     1 -
 drivers/gpu/drm/i915/i915_bo.c                     |   114 +
 drivers/gpu/drm/i915/i915_bo.h                     |     6 +
 drivers/gpu/drm/i915/i915_debugfs.c                |     2 +-
 drivers/gpu/drm/i915/i915_dpt.c                    |     5 +-
 drivers/gpu/drm/i915/i915_driver.c                 |    43 +-
 drivers/gpu/drm/i915/i915_drv.h                    |     2 +
 drivers/gpu/drm/i915/i915_fb_pin.c                 |   311 +
 drivers/gpu/drm/i915/i915_fb_pin.h                 |     9 +
 drivers/gpu/drm/i915/i915_freq.c                   |     2 +-
 drivers/gpu/drm/i915/i915_gmch.c                   |     2 +-
 drivers/gpu/drm/i915/i915_gtt_view_types.h         |    15 +
 drivers/gpu/drm/i915/i915_hwmon.c                  |     2 +-
 drivers/gpu/drm/i915/i915_initial_plane.c          |    33 +-
 drivers/gpu/drm/i915/i915_irq.c                    |   185 +-
 drivers/gpu/drm/i915/i915_irq.h                    |     7 -
 drivers/gpu/drm/i915/i915_overlay.c                |     8 +-
 drivers/gpu/drm/i915/i915_pci.c                    |     2 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    31 -
 drivers/gpu/drm/i915/i915_selftest.h               |     1 +
 drivers/gpu/drm/i915/i915_vma.c                    |    10 -
 drivers/gpu/drm/i915/i915_vma.h                    |     2 -
 drivers/gpu/drm/i915/intel_clock_gating.c          |   230 +-
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c        |     2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |     2 +-
 drivers/gpu/drm/i915/selftests/i915_selftest.c     |    74 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |     1 +
 drivers/gpu/drm/i915/vlv_iosf_sb.c                 |     8 +
 drivers/gpu/drm/i915/vlv_iosf_sb.h                 |    16 +-
 drivers/gpu/drm/imagination/Makefile               |     3 +
 drivers/gpu/drm/imagination/pvr_context.c          |    32 +-
 drivers/gpu/drm/imagination/pvr_device.c           |     2 +-
 drivers/gpu/drm/imagination/pvr_drv.c              |     3 +
 drivers/gpu/drm/imagination/pvr_fw.c               |     4 +-
 drivers/gpu/drm/imagination/pvr_fw.h               |     7 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c         |     4 +-
 drivers/gpu/drm/imagination/pvr_job.c              |    11 +-
 drivers/gpu/drm/imagination/pvr_mmu.c              |     4 +-
 drivers/gpu/drm/imagination/pvr_power.c            |    10 +-
 drivers/gpu/drm/imagination/pvr_queue.c            |   167 +-
 drivers/gpu/drm/imagination/pvr_queue.h            |     2 +-
 .../gpu/drm/imagination/pvr_rogue_fwif_shared.h    |    10 +-
 drivers/gpu/drm/imagination/pvr_sync.c             |     8 +-
 drivers/gpu/drm/imagination/pvr_sync.h             |     2 +-
 drivers/gpu/drm/imagination/pvr_trace.h            |   113 +
 drivers/gpu/drm/imagination/pvr_trace_points.c     |     7 +
 drivers/gpu/drm/imx/dc/dc-crtc.c                   |    10 +-
 drivers/gpu/drm/imx/dc/dc-kms.c                    |     8 +-
 drivers/gpu/drm/imx/dc/dc-plane.c                  |     6 +-
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               |     8 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |     2 -
 drivers/gpu/drm/imx/dcss/dcss-plane.c              |     6 +-
 drivers/gpu/drm/imx/ipuv3/Kconfig                  |     6 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c           |     4 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm.h                |     2 +-
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c                |     8 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c             |    10 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            |     8 +-
 drivers/gpu/drm/imx/ipuv3/parallel-display.c       |     7 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                |     2 -
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    26 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |    10 +-
 drivers/gpu/drm/kmb/kmb_crtc.c                     |    10 +-
 drivers/gpu/drm/kmb/kmb_drv.h                      |     2 +-
 drivers/gpu/drm/kmb/kmb_dsi.c                      |     8 +-
 drivers/gpu/drm/kmb/kmb_dsi.h                      |     2 +-
 drivers/gpu/drm/kmb/kmb_plane.c                    |     6 +-
 drivers/gpu/drm/lima/lima_sched.c                  |     1 -
 drivers/gpu/drm/logicvc/logicvc_crtc.c             |     6 +-
 drivers/gpu/drm/logicvc/logicvc_layer.c            |     6 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c               |     8 +-
 drivers/gpu/drm/loongson/lsdc_drv.c                |     2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c      |     2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c      |     6 +-
 drivers/gpu/drm/loongson/lsdc_plane.c              |    22 +-
 drivers/gpu/drm/mediatek/mtk_cec.c                 |     2 +-
 drivers/gpu/drm/mediatek/mtk_crtc.c                |    27 +-
 drivers/gpu/drm/mediatek/mtk_crtc.h                |     2 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |     4 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |    11 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |     2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    37 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |    12 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c            |     2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c         |     2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |    10 +-
 drivers/gpu/drm/mediatek/mtk_plane.c               |    10 +-
 drivers/gpu/drm/meson/meson_crtc.c                 |    12 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |     6 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |     4 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |     6 +-
 drivers/gpu/drm/meson/meson_overlay.c              |     6 +-
 drivers/gpu/drm/meson/meson_plane.c                |     6 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |     1 -
 drivers/gpu/drm/mgag200/mgag200_drv.h              |    26 +-
 drivers/gpu/drm/mgag200/mgag200_g200.c             |     4 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh.c           |     4 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c          |     2 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh5.c          |     2 +-
 drivers/gpu/drm/mgag200/mgag200_g200er.c           |     6 +-
 drivers/gpu/drm/mgag200/mgag200_g200ev.c           |     6 +-
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c          |     2 +-
 drivers/gpu/drm/mgag200/mgag200_g200se.c           |    23 +-
 drivers/gpu/drm/mgag200/mgag200_g200wb.c           |     4 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   127 +-
 drivers/gpu/drm/mgag200/mgag200_reg.h              |     1 +
 drivers/gpu/drm/mgag200/mgag200_vga_bmc.c          |     4 +-
 drivers/gpu/drm/msm/Makefile                       |    29 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |     7 -
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |    16 -
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |     3 -
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    27 +-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   298 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |    89 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   363 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |    30 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |     2 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c          |     2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   106 +-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c          |     2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |    10 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    19 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |    10 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_10_2_milos.h |   279 +
 .../drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h |     2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |     8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |     4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |    12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |    29 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |     1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |    39 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |     5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |     2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |     2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |     5 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |    10 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |     7 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |     4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |    10 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |     4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h           |     4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c         |     4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.h         |     4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c          |     4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.h          |     4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |     8 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.h       |     2 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |    30 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |    16 -
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |     1 -
 drivers/gpu/drm/msm/dp/dp_display.c                |   742 +-
 drivers/gpu/drm/msm/dp/dp_display.h                |     3 +-
 drivers/gpu/drm/msm/dp/dp_drm.c                    |    71 +-
 drivers/gpu/drm/msm/dp/dp_drm.h                    |     8 +-
 drivers/gpu/drm/msm/dp/dp_panel.c                  |     8 +
 drivers/gpu/drm/msm/dp/dp_panel.h                  |     2 +
 drivers/gpu/drm/msm/dp/dp_reg.h                    |     4 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |     1 +
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |     4 -
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |     2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |     1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |    23 +
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |    72 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |     4 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c           |     6 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c           |     6 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |     8 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |     6 -
 drivers/gpu/drm/msm/msm_drv.c                      |    13 +-
 drivers/gpu/drm/msm/msm_drv.h                      |    26 +-
 drivers/gpu/drm/msm/msm_gem.c                      |    33 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |    44 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |     6 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |    13 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   123 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |   104 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |     5 +-
 drivers/gpu/drm/msm/msm_kms.h                      |     4 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |   127 +-
 drivers/gpu/drm/msm/msm_perf.c                     |   235 -
 drivers/gpu/drm/msm/msm_perfcntr.c                 |   670 +
 drivers/gpu/drm/msm/msm_perfcntr.h                 |   155 +
 drivers/gpu/drm/msm/msm_ringbuffer.c               |     7 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h               |     2 +
 drivers/gpu/drm/msm/msm_submitqueue.c              |     3 +-
 .../drm/msm/registers/adreno/a2xx_perfcntrs.json   |   109 +
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml      |     8 +-
 drivers/gpu/drm/msm/registers/adreno/a5xx.xml      |   139 +-
 .../drm/msm/registers/adreno/a5xx_perfcntrs.json   |   128 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |  1286 +-
 .../drm/msm/registers/adreno/a6xx_descriptors.xml  |    71 +-
 .../gpu/drm/msm/registers/adreno/a6xx_enums.xml    |     3 +
 .../drm/msm/registers/adreno/a6xx_perfcntrs.json   |   112 +
 .../drm/msm/registers/adreno/a7xx_perfcntrs.json   |   228 +
 .../drm/msm/registers/adreno/a8xx_descriptors.xml  |    96 +-
 .../drm/msm/registers/adreno/a8xx_perfcntrs.json   |   241 +
 .../drm/msm/registers/adreno/a8xx_perfcntrs.xml    |  1929 +
 .../gpu/drm/msm/registers/adreno/adreno_common.xml |    42 +
 .../gpu/drm/msm/registers/adreno/adreno_pm4.xml    |    50 +-
 drivers/gpu/drm/msm/registers/gen_header.py        |  1857 +-
 drivers/gpu/drm/mxsfb/Kconfig                      |     2 +
 drivers/gpu/drm/mxsfb/lcdif_drv.c                  |    61 +-
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  |    12 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |    16 +-
 drivers/gpu/drm/nouveau/dispnv50/atom.h            |     6 +-
 drivers/gpu/drm/nouveau/dispnv50/crc.c             |    17 +-
 drivers/gpu/drm/nouveau/dispnv50/crc.h             |    16 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |    70 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            |     2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |     2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |     2 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c             |    21 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |     2 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |     2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |     2 +-
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |     4 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c            |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |     1 +
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowramin.c |     3 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c   |   110 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c    |     5 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c |     3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c    |    61 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c      |     3 +-
 drivers/gpu/drm/nova/Kconfig                       |     3 +-
 drivers/gpu/drm/nova/Makefile                      |     3 +-
 drivers/gpu/drm/nova/driver.rs                     |    26 +-
 drivers/gpu/drm/nova/gem.rs                        |    15 +-
 drivers/gpu/drm/nova/nova.rs                       |     2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |     4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |     4 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |    11 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |    10 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    16 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |     2 +-
 drivers/gpu/drm/omapdrm/omap_overlay.c             |     4 +-
 drivers/gpu/drm/omapdrm/omap_overlay.h             |     4 +-
 drivers/gpu/drm/omapdrm/omap_plane.c               |     6 +-
 drivers/gpu/drm/panel/Kconfig                      |    59 +-
 drivers/gpu/drm/panel/Makefile                     |     3 +
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |     2 +
 drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c  |   333 +
 drivers/gpu/drm/panel/panel-edp.c                  |    20 +-
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |     4 +-
 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c   |   225 +
 drivers/gpu/drm/panel/panel-himax-hx83102.c        |   146 +-
 drivers/gpu/drm/panel/panel-himax-hx83121a.c       |     4 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c         |   279 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c |    10 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |   251 +-
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   |  1423 +-
 drivers/gpu/drm/panel/panel-lxd-m9189a.c           |    11 +-
 drivers/gpu/drm/panel/panel-novatek-nt35532.c      |   796 +
 drivers/gpu/drm/panel/panel-novatek-nt37700f.c     |    11 +-
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |    24 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |    14 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |    11 +-
 drivers/gpu/drm/panel/panel-simple.c               |   539 +
 .../gpu/drm/panel/panel-startek-kd070fhfid015.c    |    12 +-
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c       |    14 +-
 drivers/gpu/drm/panel/panel-truly-nt35597.c        |    10 +-
 drivers/gpu/drm/panel/panel-visionox-g2647fb105.c  |    13 +-
 drivers/gpu/drm/panfrost/panfrost_device.c         |    34 +-
 drivers/gpu/drm/panfrost/panfrost_device.h         |     1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c            |     3 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |     1 -
 drivers/gpu/drm/panthor/Kconfig                    |     1 -
 drivers/gpu/drm/panthor/panthor_device.c           |    39 +-
 drivers/gpu/drm/panthor/panthor_device.h           |   162 +-
 drivers/gpu/drm/panthor/panthor_drv.c              |    41 +-
 drivers/gpu/drm/panthor/panthor_drv.h              |     2 +
 drivers/gpu/drm/panthor/panthor_fw.c               |    56 +-
 drivers/gpu/drm/panthor/panthor_fw.h               |     1 +
 drivers/gpu/drm/panthor/panthor_fw_regs.h          |    29 +
 drivers/gpu/drm/panthor/panthor_gem.c              |  1464 +-
 drivers/gpu/drm/panthor/panthor_gem.h              |   146 +-
 drivers/gpu/drm/panthor/panthor_gpu.c              |   101 +-
 drivers/gpu/drm/panthor/panthor_gpu.h              |     6 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h         |   119 +
 drivers/gpu/drm/panthor/panthor_heap.c             |     2 +-
 drivers/gpu/drm/panthor/panthor_hw.c               |    56 +-
 drivers/gpu/drm/panthor/panthor_hw.h               |     2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |   566 +-
 drivers/gpu/drm/panthor/panthor_mmu.h              |     8 +
 drivers/gpu/drm/panthor/panthor_mmu_regs.h         |    69 +
 drivers/gpu/drm/panthor/panthor_pwr.c              |    95 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h         |    79 +
 drivers/gpu/drm/panthor/panthor_regs.h             |   291 -
 drivers/gpu/drm/panthor/panthor_sched.c            |    90 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |    16 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |     6 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |     9 +-
 drivers/gpu/drm/radeon/cik.c                       |     2 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |     6 +-
 drivers/gpu/drm/radeon/radeon_audio.c              |     4 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |     4 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |    60 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |    13 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |     4 +-
 drivers/gpu/drm/radeon/radeon_ring.c               |     4 +-
 drivers/gpu/drm/radeon/si.c                        |     2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     |    18 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |    31 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h  |     1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c      |     6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c    |     6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h    |     2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      |     4 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c        |     6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |     6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.h    |     6 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c      |    15 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c       |    20 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h       |    14 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c   |    24 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c       |    20 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h       |     2 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |    70 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |    22 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c |     6 +-
 drivers/gpu/drm/rockchip/Kconfig                   |     1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |    73 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |     6 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |     2 +
 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c   |     2 +-
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          |    35 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |    25 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |    15 +-
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c      |     5 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |     8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |     2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    22 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |    18 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |     6 -
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |     9 -
 drivers/gpu/drm/scheduler/Makefile                 |     2 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |   175 +-
 drivers/gpu/drm/scheduler/sched_fence.c            |     2 +-
 drivers/gpu/drm/scheduler/sched_internal.h         |    70 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   351 +-
 drivers/gpu/drm/scheduler/sched_rq.c               |   383 +
 drivers/gpu/drm/scheduler/tests/Makefile           |     3 +-
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c   |     1 -
 drivers/gpu/drm/scheduler/tests/tests_scheduler.c  |   874 +
 drivers/gpu/drm/sitronix/st7571.c                  |    10 +-
 drivers/gpu/drm/sitronix/st7586.c                  |     6 +-
 drivers/gpu/drm/sitronix/st7735r.c                 |     2 +-
 drivers/gpu/drm/sitronix/st7920.c                  |    12 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |    32 +-
 drivers/gpu/drm/sprd/sprd_dpu.c                    |    12 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |     6 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |     6 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |     6 +-
 drivers/gpu/drm/sti/sti_hda.c                      |     8 +-
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c         |     6 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |     6 +-
 drivers/gpu/drm/stm/drv.c                          |     2 +-
 drivers/gpu/drm/stm/ltdc.c                         |    12 +-
 drivers/gpu/drm/stm/ltdc.h                         |     2 +-
 drivers/gpu/drm/stm/lvds.c                         |     6 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |     4 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |    10 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |     2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |     8 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |     4 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |     4 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |     2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |     4 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |     4 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h               |     4 +-
 drivers/gpu/drm/sysfb/corebootdrm.c                |    21 +
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |     8 +-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          |     8 +-
 drivers/gpu/drm/sysfb/efidrm.c                     |    19 +
 drivers/gpu/drm/sysfb/ofdrm.c                      |    23 +-
 drivers/gpu/drm/sysfb/simpledrm.c                  |    21 +
 drivers/gpu/drm/sysfb/vesadrm.c                    |    23 +-
 drivers/gpu/drm/tegra/dc.c                         |   152 +-
 drivers/gpu/drm/tegra/dc.h                         |    15 +-
 drivers/gpu/drm/tegra/dp.c                         |     6 +-
 drivers/gpu/drm/tegra/dp.h                         |    12 +-
 drivers/gpu/drm/tegra/drm.c                        |     6 +-
 drivers/gpu/drm/tegra/drm.h                        |     5 -
 drivers/gpu/drm/tegra/fb.c                         |     1 +
 drivers/gpu/drm/tegra/fbdev.c                      |    88 +-
 drivers/gpu/drm/tegra/gem.c                        |    22 +-
 drivers/gpu/drm/tegra/gr2d.c                       |    19 +-
 drivers/gpu/drm/tegra/gr3d.c                       |    19 +-
 drivers/gpu/drm/tegra/hdmi.c                       |    12 +-
 drivers/gpu/drm/tegra/hub.c                        |    12 +-
 drivers/gpu/drm/tegra/hub.h                        |     4 +-
 drivers/gpu/drm/tegra/rgb.c                        |     2 -
 drivers/gpu/drm/tegra/sor.c                        |    37 +-
 drivers/gpu/drm/tegra/submit.c                     |     3 +-
 drivers/gpu/drm/tests/Makefile                     |     2 +-
 ...tomic_state_test.c =3D> drm_atomic_commit_test.c} |    12 +-
 drivers/gpu/drm/tests/drm_bridge_test.c            |    10 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |    88 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |    18 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |    10 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |     8 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |     6 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |     4 +-
 drivers/gpu/drm/tidss/tidss_plane.c                |     8 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |    10 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |     2 +-
 drivers/gpu/drm/tilcdc/tilcdc_encoder.c            |     6 -
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |     4 +-
 drivers/gpu/drm/tiny/appletbdrm.c                  |    10 +-
 drivers/gpu/drm/tiny/bochs.c                       |    20 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |     8 +-
 drivers/gpu/drm/tiny/hx8357d.c                     |     2 +-
 drivers/gpu/drm/tiny/ili9163.c                     |     2 +-
 drivers/gpu/drm/tiny/ili9225.c                     |     6 +-
 drivers/gpu/drm/tiny/ili9341.c                     |     2 +-
 drivers/gpu/drm/tiny/ili9486.c                     |     2 +-
 drivers/gpu/drm/tiny/mi0283qt.c                    |     2 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c              |     2 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |    10 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |    10 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    18 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    11 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |    18 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 |    18 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |     6 +-
 drivers/gpu/drm/tyr/Kconfig                        |     1 +
 drivers/gpu/drm/tyr/driver.rs                      |    86 +-
 drivers/gpu/drm/tyr/gem.rs                         |    33 +-
 drivers/gpu/drm/tyr/gpu.rs                         |   180 +-
 drivers/gpu/drm/tyr/regs.rs                        |  1725 +-
 drivers/gpu/drm/tyr/tyr.rs                         |     4 +-
 drivers/gpu/drm/udl/udl_main.c                     |     3 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |    13 +-
 drivers/gpu/drm/v3d/Makefile                       |     1 +
 drivers/gpu/drm/v3d/v3d_debugfs.c                  |    23 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |   160 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |    18 +
 drivers/gpu/drm/v3d/v3d_gem.c                      |    17 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |    15 +-
 drivers/gpu/drm/v3d/v3d_mmu.c                      |    23 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |    18 +-
 drivers/gpu/drm/v3d/v3d_power.c                    |    89 +
 drivers/gpu/drm/v3d/v3d_sched.c                    |    17 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   |    41 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |    18 +-
 drivers/gpu/drm/vc4/tests/vc4_mock.h               |     4 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c        |     4 +-
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c     |    50 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |     1 -
 drivers/gpu/drm/vc4/vc4_crtc.c                     |    10 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |     2 -
 drivers/gpu/drm/vc4/vc4_drv.h                      |    28 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |     8 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |     1 -
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    12 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |    10 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |    33 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |    30 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |    10 +-
 drivers/gpu/drm/vc4/vc4_render_cl.c                |     1 -
 drivers/gpu/drm/vc4/vc4_txp.c                      |    10 +-
 drivers/gpu/drm/vc4/vc4_validate.c                 |     1 -
 drivers/gpu/drm/vc4/vc4_vec.c                      |     4 +-
 drivers/gpu/drm/verisilicon/Makefile               |     3 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c            |     7 +-
 drivers/gpu/drm/verisilicon/vs_crtc.c              |    15 +-
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |   272 +
 drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h |    44 +
 drivers/gpu/drm/verisilicon/vs_hwdb.c              |     4 +
 drivers/gpu/drm/verisilicon/vs_hwdb.h              |     5 +
 drivers/gpu/drm/verisilicon/vs_plane.c             |    54 +-
 drivers/gpu/drm/verisilicon/vs_plane.h             |    19 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |    56 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |     8 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |     1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h               |     5 +
 drivers/gpu/drm/virtio/virtgpu_gem.c               |    17 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    11 +
 drivers/gpu/drm/virtio/virtgpu_kms.c               |    14 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |    16 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c              |    30 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |     6 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |     4 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |     4 +-
 drivers/gpu/drm/vkms/vkms_writeback.c              |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c       |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h       |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |     2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    18 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |     3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |     5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |     9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c               |    78 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h               |    12 +-
 drivers/gpu/drm/xe/Makefile                        |    11 +-
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |     8 +
 .../gpu/drm/xe/{xe_uc_fw_abi.h =3D> abi/uc_fw_abi.h} |     4 +-
 drivers/gpu/drm/xe/abi/xe_sysctrl_abi.h            |    65 +
 .../xe/compat-i915-headers/intel_clock_gating.h    |    10 +-
 .../drm/xe/compat-i915-headers/intel_mchbar_regs.h |     6 -
 .../drm/xe/compat-i915-headers/intel_pci_config.h  |     6 -
 .../gpu/drm/xe/compat-i915-headers/intel_step.h    |    13 -
 .../gpu/drm/xe/compat-i915-headers/vlv_iosf_sb.h   |    42 -
 .../drm/xe/compat-i915-headers/vlv_iosf_sb_reg.h   |     6 -
 drivers/gpu/drm/xe/display/intel_fbdev_fb.c        |   120 -
 drivers/gpu/drm/xe/display/xe_display.c            |   110 +-
 drivers/gpu/drm/xe/display/xe_display.h            |    21 +-
 drivers/gpu/drm/xe/display/xe_display_bo.c         |   120 +
 drivers/gpu/drm/xe/display/xe_display_bo.h         |     6 +
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |   233 +-
 drivers/gpu/drm/xe/display/xe_fb_pin.h             |    21 +
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c           |    12 +-
 drivers/gpu/drm/xe/display/xe_initial_plane.c      |    48 +-
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h  |     4 +-
 drivers/gpu/drm/xe/regs/xe_engine_regs.h           |     9 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |    11 +-
 drivers/gpu/drm/xe/regs/xe_irq_regs.h              |     1 +
 drivers/gpu/drm/xe/regs/xe_lrc_layout.h            |     3 +
 drivers/gpu/drm/xe/regs/xe_oa_regs.h               |     3 +
 drivers/gpu/drm/xe/regs/xe_pcode_regs.h            |     3 +
 drivers/gpu/drm/xe/regs/xe_sysctrl_regs.h          |    36 +
 .../gpu/drm/xe/tests/xe_gt_sriov_pf_config_kunit.c |    21 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c              |     5 +-
 drivers/gpu/drm/xe/tests/xe_pci.c                  |    10 +-
 drivers/gpu/drm/xe/tests/xe_rtp.c                  |    38 +
 drivers/gpu/drm/xe/tests/xe_rtp_test.c             |   402 +-
 drivers/gpu/drm/xe/tests/xe_rtp_test.h             |    23 +
 drivers/gpu/drm/xe/tests/xe_wa_test.c              |    14 +-
 drivers/gpu/drm/xe/xe_bo.c                         |    51 +-
 drivers/gpu/drm/xe/xe_bo.h                         |    88 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |    33 +-
 drivers/gpu/drm/xe/xe_debugfs.c                    |    43 +-
 drivers/gpu/drm/xe/xe_dep_scheduler.c              |     1 -
 drivers/gpu/drm/xe/xe_dep_scheduler.h              |     5 +
 drivers/gpu/drm/xe/xe_devcoredump.c                |    10 +-
 drivers/gpu/drm/xe/xe_device.c                     |   124 +-
 drivers/gpu/drm/xe/xe_device.h                     |    27 +-
 drivers/gpu/drm/xe/xe_device_types.h               |    25 +-
 drivers/gpu/drm/xe/xe_device_wa_oob.rules          |     3 +
 drivers/gpu/drm/xe/xe_dma_buf.c                    |    65 +-
 drivers/gpu/drm/xe/xe_drm_ras.c                    |    35 +-
 drivers/gpu/drm/xe/xe_drm_ras.h                    |     4 +-
 drivers/gpu/drm/xe/xe_eu_stall.c                   |    44 +-
 drivers/gpu/drm/xe/xe_eu_stall.h                   |     4 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |    23 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |     2 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |    10 -
 drivers/gpu/drm/xe/xe_ggtt.c                       |     8 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler.c              |     1 -
 drivers/gpu/drm/xe/xe_gsc.c                        |     7 +-
 drivers/gpu/drm/xe/xe_gt.c                         |     9 +-
 drivers/gpu/drm/xe/xe_gt.h                         |    15 +
 drivers/gpu/drm/xe/xe_gt_idle.c                    |     4 +-
 drivers/gpu/drm/xe/xe_gt_mcr.c                     |    88 +-
 drivers/gpu/drm/xe/xe_gt_mcr.h                     |     2 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c                |     1 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |   262 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h         |     2 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_migration.c      |     8 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c        |     6 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h        |     2 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_policy.c         |   124 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_policy.h         |     4 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h          |     1 -
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                |    24 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h                |     6 +-
 drivers/gpu/drm/xe/xe_gt_stats.c                   |    41 +
 drivers/gpu/drm/xe/xe_gt_stats_types.h             |   118 +
 drivers/gpu/drm/xe/xe_gt_types.h                   |    11 +-
 drivers/gpu/drm/xe/xe_guc.c                        |    19 +-
 drivers/gpu/drm/xe/xe_guc_ads.c                    |    15 +-
 drivers/gpu/drm/xe/xe_guc_capture.c                |     8 +-
 drivers/gpu/drm/xe/xe_guc_capture.h                |     4 +-
 drivers/gpu/drm/xe/xe_guc_capture_types.h          |     6 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |    38 +-
 drivers/gpu/drm/xe/xe_guc_ct_types.h               |     8 +-
 drivers/gpu/drm/xe/xe_guc_fwif.h                   |     4 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                     |    42 +-
 drivers/gpu/drm/xe/xe_guc_pc.h                     |     2 +-
 drivers/gpu/drm/xe/xe_guc_relay_types.h            |     2 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   197 +-
 drivers/gpu/drm/xe/xe_guc_submit_types.h           |     2 +-
 drivers/gpu/drm/xe/xe_hw_engine.c                  |   112 +-
 drivers/gpu/drm/xe/xe_hw_engine.h                  |     3 +-
 drivers/gpu/drm/xe/xe_hw_engine_types.h            |     4 +-
 drivers/gpu/drm/xe/xe_hw_error.c                   |    32 +-
 drivers/gpu/drm/xe/xe_hw_error.h                   |     4 +-
 drivers/gpu/drm/xe/xe_hwmon.c                      |    28 +-
 drivers/gpu/drm/xe/xe_irq.c                        |     2 +
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h         |     3 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |   275 +-
 drivers/gpu/drm/xe/xe_lrc.h                        |    12 +-
 drivers/gpu/drm/xe/xe_lrc_types.h                  |    11 +
 drivers/gpu/drm/xe/xe_mem_pool.c                   |   403 +
 drivers/gpu/drm/xe/xe_mem_pool.h                   |    35 +
 drivers/gpu/drm/xe/xe_mem_pool_types.h             |    21 +
 drivers/gpu/drm/xe/xe_memirq.c                     |   148 +-
 drivers/gpu/drm/xe/xe_memirq_types.h               |    13 +-
 drivers/gpu/drm/xe/xe_migrate.c                    |   146 +-
 drivers/gpu/drm/xe/xe_migrate.h                    |     4 +-
 drivers/gpu/drm/xe/xe_nvm.h                        |     4 +-
 drivers/gpu/drm/xe/xe_oa.c                         |   182 +-
 drivers/gpu/drm/xe/xe_oa_types.h                   |    12 +-
 drivers/gpu/drm/xe/xe_pagefault_types.h            |     4 +-
 drivers/gpu/drm/xe/xe_pat.c                        |     9 +
 drivers/gpu/drm/xe/xe_pat.h                        |     8 +
 drivers/gpu/drm/xe/xe_pci.c                        |    51 +-
 drivers/gpu/drm/xe/xe_pci_sriov.c                  |     2 +
 drivers/gpu/drm/xe/xe_pci_types.h                  |     2 +-
 drivers/gpu/drm/xe/xe_pcode_api.h                  |     8 +-
 drivers/gpu/drm/xe/xe_pm.c                         |    48 +-
 drivers/gpu/drm/xe/xe_pm.h                         |     1 +
 drivers/gpu/drm/xe/xe_pt.c                         |     3 +-
 drivers/gpu/drm/xe/xe_pt_types.h                   |     2 +-
 drivers/gpu/drm/xe/xe_pt_walk.h                    |    14 +-
 drivers/gpu/drm/xe/xe_pxp.c                        |     6 +
 drivers/gpu/drm/xe/xe_pxp.h                        |     6 +-
 drivers/gpu/drm/xe/xe_pxp_debugfs.h                |     6 +-
 drivers/gpu/drm/xe/xe_pxp_submit.h                 |     6 +-
 drivers/gpu/drm/xe/xe_pxp_types.h                  |     6 +-
 drivers/gpu/drm/xe/xe_query.c                      |     7 +
 drivers/gpu/drm/xe/xe_ras.c                        |    93 +
 drivers/gpu/drm/xe/xe_ras.h                        |    15 +
 drivers/gpu/drm/xe/xe_ras_types.h                  |    73 +
 drivers/gpu/drm/xe/xe_reg_sr.c                     |    36 +
 drivers/gpu/drm/xe/xe_reg_sr.h                     |     4 +-
 drivers/gpu/drm/xe/xe_reg_sr_types.h               |     4 +-
 drivers/gpu/drm/xe/xe_reg_whitelist.c              |    16 +-
 drivers/gpu/drm/xe/xe_reg_whitelist.h              |     4 +-
 drivers/gpu/drm/xe/xe_res_cursor.h                 |    14 +-
 drivers/gpu/drm/xe/xe_ring_ops.c                   |     8 +-
 drivers/gpu/drm/xe/xe_rtp.c                        |   340 +-
 drivers/gpu/drm/xe/xe_rtp.h                        |    57 +-
 drivers/gpu/drm/xe/xe_rtp_helpers.h                |     6 +-
 drivers/gpu/drm/xe/xe_rtp_types.h                  |     4 +-
 drivers/gpu/drm/xe/xe_sriov_pf.c                   |     6 -
 drivers/gpu/drm/xe/xe_sriov_pf_helpers.h           |     3 +-
 drivers/gpu/drm/xe/xe_sriov_pf_migration.c         |     7 +-
 drivers/gpu/drm/xe/xe_sriov_pf_provision.c         |    41 +
 drivers/gpu/drm/xe/xe_sriov_pf_provision.h         |     1 +
 drivers/gpu/drm/xe/xe_sriov_pf_types.h             |     3 -
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c               |    54 +-
 drivers/gpu/drm/xe/xe_sriov_vf_ccs_types.h         |     5 +-
 drivers/gpu/drm/xe/xe_step.c                       |     2 +-
 drivers/gpu/drm/xe/xe_step.h                       |     4 +-
 drivers/gpu/drm/xe/xe_step_types.h                 |    61 +-
 drivers/gpu/drm/xe/xe_survivability_mode.c         |    14 +-
 drivers/gpu/drm/xe/xe_survivability_mode.h         |     2 +-
 drivers/gpu/drm/xe/xe_svm.c                        |    11 +-
 drivers/gpu/drm/xe/xe_sync.c                       |     2 +-
 drivers/gpu/drm/xe/xe_sysctrl.c                    |   132 +
 drivers/gpu/drm/xe/xe_sysctrl.h                    |    24 +
 drivers/gpu/drm/xe/xe_sysctrl_event.c              |    88 +
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h        |    57 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c            |   371 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h            |    31 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |    58 +
 drivers/gpu/drm/xe/xe_sysctrl_types.h              |    39 +
 drivers/gpu/drm/xe/xe_tile_types.h                 |     2 -
 drivers/gpu/drm/xe/xe_tlb_inval.c                  |     2 +-
 drivers/gpu/drm/xe/xe_trace_lrc.h                  |    27 +
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c             |    64 +-
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.h             |    12 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               |    18 +-
 drivers/gpu/drm/xe/xe_tuning.c                     |    11 +-
 drivers/gpu/drm/xe/xe_tuning.h                     |     4 +-
 drivers/gpu/drm/xe/xe_uc_fw.c                      |    11 +
 drivers/gpu/drm/xe/xe_uc_fw.h                      |     6 +-
 drivers/gpu/drm/xe/xe_validation.c                 |     4 +-
 drivers/gpu/drm/xe/xe_validation.h                 |     2 +-
 drivers/gpu/drm/xe/xe_vm.c                         |    73 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |   209 +-
 drivers/gpu/drm/xe/xe_vm_madvise.h                 |     2 -
 drivers/gpu/drm/xe/xe_vm_types.h                   |     3 +-
 drivers/gpu/drm/xe/xe_vram.c                       |    22 +
 drivers/gpu/drm/xe/xe_vram.h                       |     2 +
 drivers/gpu/drm/xe/xe_wa.c                         |    27 +-
 drivers/gpu/drm/xe/xe_wa.h                         |     4 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |     7 +
 drivers/gpu/drm/xlnx/Kconfig                       |     4 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |    56 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c                   |    25 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |    22 +-
 drivers/gpu/host1x/bus.c                           |    66 +-
 drivers/gpu/host1x/context.c                       |     1 +
 drivers/gpu/host1x/context.h                       |     3 +-
 drivers/gpu/host1x/context_bus.c                   |     1 +
 drivers/gpu/host1x/intr.c                          |     8 +-
 drivers/gpu/host1x/job.c                           |    10 +-
 drivers/gpu/host1x/mipi.c                          |     6 +-
 drivers/gpu/host1x/syncpt.c                        |    23 +-
 drivers/gpu/nova-core/Kconfig                      |     3 +-
 drivers/gpu/nova-core/Makefile                     |     3 +-
 drivers/gpu/nova-core/driver.rs                    |    47 +-
 drivers/gpu/nova-core/falcon.rs                    |    49 +-
 drivers/gpu/nova-core/falcon/fsp.rs                |   171 +
 drivers/gpu/nova-core/falcon/gsp.rs                |    23 +-
 drivers/gpu/nova-core/falcon/hal.rs                |    34 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |    22 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |    14 +-
 drivers/gpu/nova-core/fb.rs                        |    66 +-
 drivers/gpu/nova-core/fb/hal.rs                    |    41 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs              |    29 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs              |    23 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   122 +
 drivers/gpu/nova-core/fb/hal/gb202.rs              |    95 +
 drivers/gpu/nova-core/fb/hal/gh100.rs              |    50 +
 drivers/gpu/nova-core/fb/hal/tu102.rs              |    44 +-
 drivers/gpu/nova-core/firmware.rs                  |   197 +-
 drivers/gpu/nova-core/firmware/booter.rs           |    34 +-
 drivers/gpu/nova-core/firmware/fsp.rs              |   128 +
 drivers/gpu/nova-core/firmware/fwsec.rs            |     5 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |     2 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |    32 +-
 drivers/gpu/nova-core/fsp.rs                       |   320 +
 drivers/gpu/nova-core/fsp/hal.rs                   |    32 +
 drivers/gpu/nova-core/fsp/hal/gb100.rs             |    23 +
 drivers/gpu/nova-core/fsp/hal/gb202.rs             |    27 +
 drivers/gpu/nova-core/fsp/hal/gh100.rs             |    32 +
 drivers/gpu/nova-core/gfw.rs                       |    76 -
 drivers/gpu/nova-core/gpu.rs                       |   119 +-
 drivers/gpu/nova-core/gpu/hal.rs                   |    39 +
 drivers/gpu/nova-core/gpu/hal/gh100.rs             |    34 +
 drivers/gpu/nova-core/gpu/hal/tu102.rs             |   100 +
 drivers/gpu/nova-core/gsp.rs                       |     5 +
 drivers/gpu/nova-core/gsp/boot.rs                  |   302 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |    10 +-
 drivers/gpu/nova-core/gsp/commands.rs              |    78 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |   121 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs           |    60 +-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs  |    94 +
 drivers/gpu/nova-core/gsp/hal.rs                   |    94 +
 drivers/gpu/nova-core/gsp/hal/gh100.rs             |   192 +
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |   349 +
 drivers/gpu/nova-core/gsp/sequencer.rs             |    15 +-
 drivers/gpu/nova-core/mctp.rs                      |    88 +
 drivers/gpu/nova-core/nova_core.rs                 |     7 +-
 drivers/gpu/nova-core/regs.rs                      |   136 +-
 drivers/gpu/nova-core/vbios.rs                     |   636 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 |     6 +-
 drivers/hid/hid-appletb-kbd.c                      |    58 +-
 drivers/hid/hid-core.c                             |    67 +-
 drivers/hid/hid-elan.c                             |     1 +
 drivers/hid/hid-ft260.c                            |    16 +-
 drivers/hid/hid-gfrm.c                             |     4 +-
 drivers/hid/hid-google-hammer.c                    |     2 +-
 drivers/hid/hid-ids.h                              |     4 +
 drivers/hid/hid-lenovo-go-s.c                      |    44 +
 drivers/hid/hid-logitech-hidpp.c                   |    40 +-
 drivers/hid/hid-magicmouse.c                       |    16 +
 drivers/hid/hid-mcp2221.c                          |     7 +
 drivers/hid/hid-multitouch.c                       |     2 +-
 drivers/hid/hid-playstation.c                      |     6 +-
 drivers/hid/hid-primax.c                           |     2 +-
 drivers/hid/hid-quirks.c                           |     2 +-
 drivers/hid/hid-sjoy.c                             |    12 +-
 drivers/hid/hid-sony.c                             |    15 +-
 drivers/hid/hid-uclogic-core.c                     |     4 +-
 drivers/hid/hid-vivaldi-common.c                   |     2 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |     9 +-
 .../intel-quickspi/quickspi-protocol.c             |     4 +-
 drivers/hid/usbhid/hid-core.c                      |    11 +-
 drivers/hid/usbhid/hid-pidff.c                     |     7 +-
 drivers/hid/wacom_sys.c                            |     6 +-
 drivers/hwmon/Makefile                             |     1 -
 drivers/hwmon/acpi_power_meter.c                   |     6 +-
 drivers/hwmon/ads7871.c                            |     6 +-
 drivers/hwmon/asus_atk0110.c                       |     7 +-
 drivers/hwmon/corsair-psu.c                        |     4 +-
 drivers/hwmon/lenovo-ec-sensors.c                  |    20 +-
 drivers/hwmon/lm63.c                               |    39 +-
 drivers/hwmon/lm75.c                               |    10 +-
 drivers/hwmon/lm90.c                               |    26 +-
 drivers/hwmon/ltc2992.c                            |    41 +-
 drivers/hwmon/pmbus/adm1266.c                      |    46 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |     6 +-
 drivers/i2c/busses/i2c-tegra.c                     |    19 +-
 drivers/i2c/i2c-core-acpi.c                        |     1 +
 drivers/i2c/i2c-core-base.c                        |     3 +-
 drivers/i2c/i2c-core-smbus.c                       |    13 +
 drivers/i2c/i2c-dev.c                              |     9 +-
 drivers/i2c/i2c-slave-testunit.c                   |     4 +-
 drivers/i2c/i2c-stub.c                             |     5 +
 drivers/infiniband/core/addr.c                     |     2 +-
 drivers/infiniband/core/ib_core_uverbs.c           |    87 +
 drivers/infiniband/core/nldev.c                    |     3 +
 drivers/infiniband/core/uverbs.h                   |    34 +
 drivers/infiniband/core/uverbs_cmd.c               |     9 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   148 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |     2 +-
 drivers/infiniband/hw/hfi1/pio.c                   |     5 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |     4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |    13 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |    12 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.c          |     2 +-
 drivers/infiniband/hw/mana/cq.c                    |     5 +-
 drivers/infiniband/hw/mana/main.c                  |     1 +
 drivers/infiniband/hw/mana/qp.c                    |    16 +-
 drivers/infiniband/hw/mlx4/srq.c                   |     4 +-
 drivers/infiniband/hw/mlx5/main.c                  |     9 +-
 drivers/infiniband/hw/mlx5/qp.c                    |     7 +-
 drivers/infiniband/hw/mlx5/qpc.c                   |     9 +-
 drivers/infiniband/hw/mlx5/srq_cmd.c               |     9 +-
 drivers/infiniband/hw/mlx5/umr.c                   |     4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |     8 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |     2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |    11 +
 drivers/infiniband/sw/rxe/rxe_resp.c               |    14 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c              |    15 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |     8 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |     2 +-
 drivers/iommu/amd/amd_iommu.h                      |     3 +
 drivers/iommu/amd/amd_iommu_types.h                |    21 +-
 drivers/iommu/amd/debugfs.c                        |     9 +-
 drivers/iommu/amd/init.c                           |   133 +-
 drivers/iommu/amd/iommu.c                          |    13 +-
 drivers/iommu/amd/ppr.c                            |     8 +-
 drivers/iommu/generic_pt/iommu_pt.h                |    24 +-
 drivers/iommu/intel/iommu.c                        |    16 +-
 drivers/iommu/iommu-pages.h                        |     2 +-
 drivers/iommu/iommu.c                              |   305 +-
 drivers/irqchip/exynos-combiner.c                  |     6 +-
 drivers/irqchip/irq-ath79-cpu.c                    |     7 -
 drivers/irqchip/irq-gic-v5-its.c                   |    34 +-
 drivers/irqchip/irq-gic-v5.c                       |    98 +-
 drivers/irqchip/irq-meson-gpio.c                   |     3 +-
 drivers/irqchip/irq-renesas-rzt2h.c                |     2 +-
 drivers/irqchip/irq-riscv-imsic-early.c            |     2 +
 drivers/mailbox/cix-mailbox.c                      |     6 +-
 drivers/mailbox/exynos-mailbox.c                   |     4 -
 drivers/mailbox/hi3660-mailbox.c                   |     2 -
 drivers/mailbox/hi6220-mailbox.c                   |    14 +-
 drivers/mailbox/imx-mailbox.c                      |     4 +-
 drivers/mailbox/mailbox-sti.c                      |     2 -
 drivers/mailbox/mailbox-test.c                     |    80 +-
 drivers/mailbox/mailbox.c                          |    67 +-
 drivers/mailbox/mailbox.h                          |    12 -
 drivers/mailbox/mtk-cmdq-mailbox.c                 |    10 +-
 drivers/mailbox/mtk-vcp-mailbox.c                  |     2 +-
 drivers/mailbox/omap-mailbox.c                     |     4 +-
 drivers/mailbox/pcc.c                              |     2 -
 drivers/mailbox/rockchip-mailbox.c                 |     9 +-
 drivers/mailbox/tegra-hsp.c                        |     6 +-
 drivers/md/md-bitmap.c                             |   133 +-
 drivers/md/md-bitmap.h                             |     2 +-
 drivers/md/md-llbitmap.c                           |     7 +-
 drivers/md/md.c                                    |   182 +-
 drivers/md/md.h                                    |     6 +-
 drivers/md/persistent-data/dm-btree-remove.c       |     8 +
 drivers/md/raid1-10.c                              |     7 +-
 drivers/md/raid1.c                                 |    15 +-
 drivers/md/raid10.c                                |     2 +
 drivers/md/raid5.c                                 |     7 +-
 .../media/platform/qcom/camss/camss-csid-gen3.c    |     6 +-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |    10 +-
 drivers/media/platform/qcom/camss/camss.c          |    80 +-
 drivers/media/platform/qcom/iris/Kconfig           |     2 +-
 drivers/media/platform/qcom/iris/iris_buffer.c     |     8 +-
 drivers/media/platform/qcom/iris/iris_core.c       |     4 +
 drivers/media/platform/qcom/iris/iris_hfi_common.c |     4 +
 drivers/media/platform/qcom/iris/iris_hfi_queue.c  |     2 +-
 drivers/media/platform/qcom/iris/iris_vdec.c       |     6 -
 drivers/media/platform/qcom/iris/iris_vdec.h       |     1 -
 drivers/media/platform/qcom/iris/iris_venc.c       |     6 -
 drivers/media/platform/qcom/iris/iris_venc.h       |     1 -
 drivers/media/platform/qcom/iris/iris_vidc.c       |     6 +-
 drivers/media/platform/qcom/iris/iris_vpu2.c       |     1 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      |     9 +-
 drivers/media/platform/qcom/iris/iris_vpu4x.c      |    24 +-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h |     2 +-
 drivers/media/platform/qcom/iris/iris_vpu_common.c |    16 +-
 drivers/media/platform/qcom/iris/iris_vpu_common.h |     3 +
 drivers/media/platform/qcom/venus/Kconfig          |     2 +-
 drivers/media/rc/ttusbir.c                         |     2 +-
 drivers/mtd/nand/spi/core.c                        |    24 +-
 drivers/mtd/nand/spi/winbond.c                     |     6 +-
 drivers/mtd/spi-nor/debugfs.c                      |     4 +-
 drivers/net/bareudp.c                              |     3 +
 drivers/net/bonding/bond_3ad.c                     |   109 +-
 drivers/net/bonding/bond_main.c                    |     8 +-
 drivers/net/bonding/bond_netlink.c                 |    16 +-
 drivers/net/bonding/bond_procfs.c                  |     3 +-
 drivers/net/bonding/bond_sysfs_slave.c             |    17 +-
 drivers/net/dsa/mt7530.c                           |   235 +-
 drivers/net/dsa/mt7530.h                           |     8 +
 drivers/net/ethernet/3com/3c509.c                  |  1543 +
 drivers/net/ethernet/3com/Kconfig                  |    14 +
 drivers/net/ethernet/3com/Makefile                 |     1 +
 drivers/net/ethernet/airoha/airoha_eth.c           |    67 +-
 drivers/net/ethernet/airoha/airoha_eth.h           |     5 +
 drivers/net/ethernet/amazon/ena/ena_com.c          |     7 +-
 drivers/net/ethernet/amazon/ena/ena_phc.c          |     5 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |     7 +-
 drivers/net/ethernet/amd/pds_core/dev.c            |    11 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |     6 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |     4 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |     4 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |     2 +-
 drivers/net/ethernet/atheros/ag71xx.c              |     3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |    29 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    10 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |     9 +-
 drivers/net/ethernet/cirrus/cs89x0.c               |     2 -
 drivers/net/ethernet/cortina/gemini.c              |    21 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |     1 +
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |    15 +-
 drivers/net/ethernet/freescale/enetc/enetc_msg.c   |   108 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |    75 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |     1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |    42 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |    22 +
 drivers/net/ethernet/ibm/ibmveth.h                 |     1 +
 drivers/net/ethernet/intel/i40e/i40e.h             |     1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |     2 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |     3 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |     9 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |    52 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |    76 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |     2 +
 drivers/net/ethernet/intel/ice/ice_common.c        |     2 -
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |     4 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |   151 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h          |    32 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |    12 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |    33 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |     7 +-
 drivers/net/ethernet/intel/ice/virt/queues.c       |     2 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c         |     6 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |     4 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |     9 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |     1 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |     7 +-
 .../ethernet/marvell/octeontx2/af/cn20k/debugfs.c  |    33 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  |   382 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.h  |    24 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |     3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   233 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |    30 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c |     2 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |     2 +
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |     3 +-
 drivers/net/ethernet/mellanox/mlx4/srq.c           |    13 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |     6 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |     7 +-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c |    36 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    30 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |     2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |     3 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |    21 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |     5 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |   114 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h   |     2 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |     3 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |     8 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |    10 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |     3 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |    40 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |    35 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |    10 +-
 drivers/net/ethernet/microsoft/mana/shm_channel.c  |     5 -
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |     2 +
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |     7 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |     8 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h |     1 +
 drivers/net/ethernet/renesas/ravb_main.c           |     9 +-
 drivers/net/ethernet/renesas/rtsn.c                |     6 +-
 drivers/net/ethernet/sfc/efx_devlink.c             |     2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-eic7700.c    |   128 +-
 .../net/ethernet/stmicro/stmmac/dwmac-nuvoton.c    |     2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    19 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c       |     1 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |     7 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c  |     4 +-
 drivers/net/fddi/defza.c                           |    11 +-
 drivers/net/ifb.c                                  |    11 +-
 drivers/net/macsec.c                               |    39 +-
 drivers/net/mctp/mctp-i2c.c                        |     4 +-
 drivers/net/net_failover.c                         |    12 +-
 drivers/net/netconsole.c                           |    49 +-
 drivers/net/netdevsim/dev.c                        |     2 +-
 drivers/net/netdevsim/netdev.c                     |     3 +-
 drivers/net/netdevsim/netdevsim.h                  |     4 +-
 drivers/net/netdevsim/psp.c                        |    65 +-
 drivers/net/ovpn/io.c                              |    19 +-
 drivers/net/ovpn/main.c                            |    12 +-
 drivers/net/ovpn/netlink.c                         |     8 +-
 drivers/net/ovpn/peer.c                            |    23 +-
 drivers/net/ovpn/peer.h                            |     1 -
 drivers/net/ovpn/stats.h                           |    16 +
 drivers/net/ovpn/tcp.c                             |    19 +-
 drivers/net/ovpn/udp.c                             |     2 +-
 drivers/net/phy/bcm-phy-lib.c                      |     9 +
 drivers/net/phy/bcm-phy-lib.h                      |     1 +
 drivers/net/phy/bcm7xxx.c                          |    14 +
 drivers/net/phy/broadcom.c                         |     5 +
 drivers/net/phy/dp83869.c                          |    13 +-
 drivers/net/phy/dp83tc811.c                        |     1 +
 drivers/net/phy/micrel.c                           |    15 +-
 drivers/net/phy/phy-c45.c                          |     8 +
 drivers/net/phy/phy_device.c                       |     6 +-
 drivers/net/pse-pd/pse_core.c                      |     2 +-
 drivers/net/tap.c                                  |     2 +-
 drivers/net/usb/asix_devices.c                     |     2 +
 drivers/net/usb/cdc_ncm.c                          |     8 +
 drivers/net/usb/r8152.c                            |     1 +
 drivers/net/usb/rtl8150.c                          |    12 +-
 drivers/net/veth.c                                 |     3 +-
 drivers/net/vrf.c                                  |    15 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |    16 +-
 drivers/net/wireless/ath/ath10k/Kconfig            |     1 +
 drivers/net/wireless/ath/ath10k/wmi.c              |    17 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |     9 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    14 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |     5 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |     1 +
 drivers/net/wireless/ath/ath11k/wmi.c              |   131 +-
 drivers/net/wireless/ath/ath12k/core.c             |    77 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |     5 +-
 drivers/net/wireless/ath/ath12k/mac.c              |    10 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |     2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   105 +-
 drivers/net/wireless/ath/ath5k/base.c              |     3 +-
 drivers/net/wireless/broadcom/b43/xmit.c           |     3 +-
 drivers/net/wireless/broadcom/b43legacy/xmit.c     |     3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |     6 +-
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |     4 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |     6 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |    13 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |    15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |    27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    14 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |     6 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |     6 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |     2 +-
 drivers/net/wireless/rsi/rsi_common.h              |     5 +-
 drivers/net/wireless/st/cw1200/pm.c                |     2 -
 drivers/net/wwan/iosm/iosm_ipc_imem.c              |     2 +
 drivers/net/wwan/t7xx/t7xx_modem_ops.c             |    20 +-
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c         |    18 +-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h            |     2 +-
 drivers/nfc/trf7970a.c                             |     3 +-
 drivers/nvme/common/auth.c                         |    94 +-
 drivers/nvme/host/apple.c                          |     7 +-
 drivers/nvme/host/auth.c                           |    16 +-
 drivers/nvme/host/core.c                           |    22 +-
 drivers/nvme/host/fc.c                             |     1 +
 drivers/nvme/host/ioctl.c                          |    18 +-
 drivers/nvme/host/multipath.c                      |     4 -
 drivers/nvme/host/pci.c                            |    43 +-
 drivers/nvme/host/rdma.c                           |     9 +
 drivers/nvme/host/sysfs.c                          |    19 +
 drivers/nvme/host/tcp.c                            |    29 +-
 drivers/nvme/target/Kconfig                        |     9 +
 drivers/nvme/target/admin-cmd.c                    |     8 +-
 drivers/nvme/target/auth.c                         |    34 +-
 drivers/nvme/target/configfs.c                     |    27 +
 drivers/nvme/target/core.c                         |    10 +-
 drivers/nvme/target/fabrics-cmd-auth.c             |     9 +-
 drivers/nvme/target/nvmet.h                        |    13 +
 drivers/nvme/target/tcp.c                          |   119 +-
 drivers/nvme/target/zns.c                          |     6 +-
 drivers/parisc/lasi.c                              |    12 +-
 drivers/parisc/led.c                               |     6 +-
 drivers/pci/controller/pcie-brcmstb.c              |     4 +-
 drivers/pci/pci-driver.c                           |     9 +-
 drivers/pci/pci.c                                  |     9 +-
 drivers/pci/setup-res.c                            |     2 +
 drivers/phy/apple/atc.c                            |    27 +-
 drivers/phy/eswin/phy-eic7700-sata.c               |     4 +-
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c         |     5 +-
 drivers/phy/qualcomm/phy-qcom-edp.c                |   224 +-
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |     1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           |     2 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |     7 +-
 drivers/phy/spacemit/phy-k1-usb2.c                 |     1 -
 drivers/phy/tegra/xusb-tegra186.c                  |    33 +-
 drivers/phy/tegra/xusb.h                           |     1 +
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      |    48 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |    18 +
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c         |     6 +-
 drivers/pinctrl/pinctrl-amd.c                      |    35 +
 drivers/pinctrl/qcom/pinctrl-eliza.c               |     8 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c             |     2 +-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |     5 +
 drivers/pinctrl/qcom/pinctrl-qcs615.c              |     6 +-
 drivers/pinctrl/qcom/pinctrl-sm8150.c              |     8 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |    23 +-
 drivers/platform/chrome/cros_typec_altmode.c       |     1 +
 .../platform/surface/surface_aggregator_registry.c |     2 -
 drivers/platform/surface/surfacepro3_button.c      |    10 +-
 drivers/platform/wmi/core.c                        |     3 +
 drivers/platform/x86/Kconfig                       |     1 +
 drivers/platform/x86/acer-wireless.c               |     8 +-
 drivers/platform/x86/adv_swbutton.c                |     6 +-
 drivers/platform/x86/asus-armoury.c                |    16 +-
 drivers/platform/x86/asus-armoury.h                |   113 +
 drivers/platform/x86/asus-laptop.c                 |     6 +-
 drivers/platform/x86/asus-nb-wmi.c                 |     9 +
 drivers/platform/x86/dell/dell-rbtn.c              |     6 +-
 drivers/platform/x86/eeepc-laptop.c                |     6 +-
 drivers/platform/x86/fujitsu-laptop.c              |    12 +-
 drivers/platform/x86/fujitsu-tablet.c              |     6 +-
 drivers/platform/x86/hp/hp-wmi.c                   |    10 +-
 drivers/platform/x86/hp/hp_accel.c                 |     3 +
 drivers/platform/x86/intel/hid.c                   |     6 +-
 drivers/platform/x86/intel/int1092/intel_sar.c     |     7 +-
 drivers/platform/x86/intel/plr_tpmi.c              |    45 +-
 drivers/platform/x86/intel/rst.c                   |     6 +-
 drivers/platform/x86/intel/smartconnect.c          |     6 +-
 drivers/platform/x86/intel/vbtn.c                  |     6 +-
 drivers/platform/x86/intel/vsec.c                  |    54 +-
 drivers/platform/x86/intel/vsec_tpmi.c             |    29 +-
 drivers/platform/x86/lenovo/Kconfig                |     1 -
 drivers/platform/x86/lenovo/wmi-capdata.c          |     8 +-
 drivers/platform/x86/lenovo/wmi-capdata.h          |    20 +
 drivers/platform/x86/lenovo/wmi-events.c           |     2 +-
 drivers/platform/x86/lenovo/wmi-gamezone.c         |     7 +-
 drivers/platform/x86/lenovo/wmi-gamezone.h         |    20 -
 drivers/platform/x86/lenovo/wmi-helpers.c          |   105 +-
 drivers/platform/x86/lenovo/wmi-helpers.h          |    21 +
 drivers/platform/x86/lenovo/wmi-other.c            |   296 +-
 drivers/platform/x86/lenovo/wmi-other.h            |    16 -
 drivers/platform/x86/lg-laptop.c                   |     9 +-
 drivers/platform/x86/panasonic-laptop.c            |     6 +-
 drivers/platform/x86/samsung-galaxybook.c          |    69 +-
 drivers/platform/x86/sony-laptop.c                 |    12 +-
 drivers/platform/x86/system76_acpi.c               |     6 +-
 drivers/platform/x86/toshiba_acpi.c                |     6 +-
 drivers/platform/x86/toshiba_bluetooth.c           |     6 +-
 drivers/platform/x86/toshiba_haps.c                |     6 +-
 drivers/platform/x86/uniwill/uniwill-acpi.c        |    47 +-
 drivers/platform/x86/wireless-hotkey.c             |     9 +-
 drivers/pmdomain/core.c                            |    10 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |    10 +-
 drivers/regulator/Kconfig                          |     3 +-
 drivers/regulator/qcom-rpmh-regulator.c            |     2 +-
 drivers/regulator/tps65219-regulator.c             |   135 +-
 drivers/resctrl/mpam_devices.c                     |    81 +-
 drivers/resctrl/mpam_internal.h                    |     2 -
 drivers/reset/reset-eyeq.c                         |    24 +-
 drivers/s390/char/Kconfig                          |     8 -
 drivers/s390/char/sclp_config.c                    |     6 -
 drivers/s390/cio/chsc.c                            |     4 +-
 drivers/s390/cio/chsc_sch.c                        |    20 +-
 drivers/s390/cio/scm.c                             |     2 +-
 drivers/scsi/device_handler/scsi_dh_alua.c         |     2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |     2 +-
 drivers/scsi/isci/host.c                           |     3 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |    14 +-
 drivers/scsi/pmcraid.h                             |     2 +-
 drivers/scsi/sd.c                                  |     3 +-
 drivers/scsi/sg.c                                  |     2 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |     1 +
 drivers/scsi/sr.c                                  |    11 +-
 drivers/scsi/sr.h                                  |     1 -
 drivers/spi/spi-amd.c                              |     2 +-
 drivers/spi/spi-amlogic-spisg.c                    |     3 +-
 drivers/spi/spi-axiado.c                           |     2 +-
 drivers/spi/spi-cadence-quadspi.c                  |    36 +-
 drivers/spi/spi-cadence.c                          |    15 +-
 drivers/spi/spi-ch341.c                            |     2 +-
 drivers/spi/spi-ep93xx.c                           |     2 +
 drivers/spi/spi-imx.c                              |     7 +-
 drivers/spi/spi-microchip-core-qspi.c              |    99 +-
 drivers/spi/spi-mtk-snfi.c                         |     2 +-
 drivers/spi/spi-qup.c                              |     3 +
 drivers/spi/spi-rockchip.c                         |     6 +-
 drivers/spi/spi-rzv2h-rspi.c                       |     2 +-
 drivers/spi/spi-sprd.c                             |     3 +-
 drivers/spi/spi-ti-qspi.c                          |     1 +
 drivers/staging/greybus/hid.c                      |     2 +-
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |     3 +-
 drivers/staging/vme_user/vme_fake.c                |     2 +
 drivers/target/iscsi/iscsi_target.c                |    22 +-
 drivers/target/loopback/tcm_loop.c                 |    12 +-
 drivers/target/target_core_configfs.c              |     2 +-
 drivers/ufs/core/ufshcd.c                          |    30 +-
 drivers/usb/class/usblp.c                          |     3 +-
 drivers/usb/common/ulpi.c                          |     5 +-
 drivers/usb/dwc3/core.c                            |    12 +-
 drivers/usb/gadget/udc/omap_udc.c                  |     4 -
 drivers/usb/serial/option.c                        |     4 +
 drivers/usb/typec/tcpm/tcpm.c                      |    27 +-
 drivers/vfio/pci/vfio_pci_core.c                   |    37 +-
 drivers/vfio/pci/vfio_pci_dmabuf.c                 |    42 +-
 drivers/vfio/pci/vfio_pci_rdwr.c                   |    26 +-
 drivers/video/fbdev/core/fb_defio.c                |     1 -
 drivers/video/fbdev/udlfb.c                        |    31 +-
 drivers/virt/coco/sev-guest/sev-guest.c            |    20 +-
 drivers/xen/privcmd.c                              |     7 +
 drivers/xen/sys-hypervisor.c                       |     8 +-
 drivers/xen/xen-acpi-pad.c                         |     6 +-
 fs/9p/v9fs_vfs.h                                   |    13 -
 fs/9p/vfs_inode.c                                  |     6 +-
 fs/9p/vfs_inode_dotl.c                             |    12 +-
 fs/afs/Makefile                                    |     1 +
 fs/afs/dir.c                                       |    79 +-
 fs/afs/file.c                                      |    24 +-
 fs/afs/fsclient.c                                  |     4 +-
 fs/afs/inode.c                                     |   127 +-
 fs/afs/internal.h                                  |    45 +-
 fs/afs/symlink.c                                   |   278 +
 fs/afs/validation.c                                |    14 +-
 fs/afs/write.c                                     |     2 +-
 fs/afs/yfsclient.c                                 |     4 +-
 fs/btrfs/block-group.c                             |    23 +-
 fs/btrfs/compression.c                             |    26 +-
 fs/btrfs/disk-io.c                                 |     1 +
 fs/btrfs/extent_io.c                               |    14 +-
 fs/btrfs/extent_io.h                               |     3 +-
 fs/btrfs/extent_map.c                              |     4 +-
 fs/btrfs/file.c                                    |    11 +-
 fs/btrfs/free-space-tree.c                         |    18 +-
 fs/btrfs/fs.h                                      |     1 +
 fs/btrfs/inode.c                                   |    36 +-
 fs/btrfs/ioctl.c                                   |     7 +-
 fs/btrfs/qgroup.c                                  |   101 +-
 fs/btrfs/raid-stripe-tree.c                        |    57 +-
 fs/btrfs/relocation.c                              |    30 +-
 fs/btrfs/transaction.c                             |     9 +-
 fs/cachefiles/namei.c                              |     2 +
 fs/ceph/addr.c                                     |     2 +
 fs/ceph/quota.c                                    |    37 +-
 fs/ceph/xattr.c                                    |    17 +
 fs/efivarfs/super.c                                |     5 +-
 fs/erofs/xattr.c                                   |     4 +-
 fs/erofs/zdata.c                                   |    15 +-
 fs/fuse/file.c                                     |     5 +-
 fs/inode.c                                         |     8 +-
 fs/iomap/direct-io.c                               |     2 +-
 fs/isofs/export.c                                  |     2 +-
 fs/isofs/namei.c                                   |    11 +-
 fs/isofs/rock.c                                    |     9 +
 fs/jfs/namei.c                                     |     2 +-
 fs/mnt_idmapping.c                                 |     2 +
 fs/netfs/buffered_read.c                           |    73 +-
 fs/netfs/buffered_write.c                          |   174 +-
 fs/netfs/direct_read.c                             |    42 +-
 fs/netfs/direct_write.c                            |     6 +-
 fs/netfs/internal.h                                |     3 +
 fs/netfs/iterator.c                                |    41 +-
 fs/netfs/misc.c                                    |    41 +-
 fs/netfs/read_collect.c                            |    19 +-
 fs/netfs/read_retry.c                              |    17 +-
 fs/netfs/read_single.c                             |    23 +-
 fs/netfs/write_collect.c                           |    15 +-
 fs/netfs/write_issue.c                             |    51 +-
 fs/netfs/write_retry.c                             |     6 +-
 fs/nfsd/nfs4proc.c                                 |    18 +-
 fs/nfsd/nfs4state.c                                |    64 +-
 fs/nfsd/state.h                                    |     1 +
 fs/nfsd/xdr4.h                                     |     1 +
 fs/notify/fanotify/fanotify.c                      |     2 +-
 fs/notify/fsnotify.c                               |     2 +-
 fs/notify/mark.c                                   |    57 +-
 fs/nsfs.c                                          |     2 +-
 fs/ntfs/attrib.c                                   |    46 +-
 fs/ntfs/attrlist.c                                 |     7 +-
 fs/ntfs/bdev-io.c                                  |     7 +-
 fs/ntfs/bitmap.c                                   |    19 +-
 fs/ntfs/dir.c                                      |    13 +-
 fs/ntfs/index.c                                    |    34 +-
 fs/ntfs/inode.c                                    |     6 +-
 fs/ntfs/iomap.c                                    |     6 +-
 fs/ntfs/logfile.c                                  |     5 +-
 fs/ntfs/mft.c                                      |    93 +-
 fs/ntfs/namei.c                                    |    17 +-
 fs/ntfs/reparse.c                                  |     5 +-
 fs/ntfs/runlist.c                                  |    33 +-
 fs/ntfs/super.c                                    |    35 +-
 fs/orangefs/namei.c                                |     2 +-
 fs/overlayfs/util.c                                |     2 +-
 fs/select.c                                        |    11 +
 fs/smb/client/cached_dir.c                         |     8 +
 fs/smb/client/cifs_spnego.c                        |    16 +
 fs/smb/client/cifsacl.c                            |    37 +-
 fs/smb/client/cifsfs.c                             |    42 +-
 fs/smb/client/cifsproto.h                          |     1 -
 fs/smb/client/cifssmb.c                            |     3 +-
 fs/smb/client/file.c                               |    13 +-
 fs/smb/client/fs_context.c                         |   196 +-
 fs/smb/client/inode.c                              |    14 +-
 fs/smb/client/ioctl.c                              |     2 +-
 fs/smb/client/netlink.c                            |     6 +-
 fs/smb/client/readdir.c                            |     3 +-
 fs/smb/client/smb2file.c                           |     3 +
 fs/smb/client/smb2inode.c                          |    14 +-
 fs/smb/client/smb2misc.c                           |     3 +-
 fs/smb/client/smb2ops.c                            |    61 +-
 fs/smb/client/smb2pdu.c                            |    26 +-
 fs/smb/client/smb2transport.c                      |    37 +-
 fs/smb/client/smbdirect.c                          |     3 +-
 fs/smb/client/smbdirect.h                          |     2 +-
 fs/smb/client/transport.c                          |    15 +-
 fs/smb/common/fscc.h                               |     4 +-
 fs/smb/common/smb2pdu.h                            |     4 +
 fs/smb/server/connection.c                         |   153 +-
 fs/smb/server/connection.h                         |     7 +
 fs/smb/server/mgmt/share_config.c                  |    12 +-
 fs/smb/server/oplock.c                             |    13 +-
 fs/smb/server/server.c                             |    12 +
 fs/smb/server/smb2pdu.c                            |    29 +-
 fs/smb/server/smbacl.c                             |   144 +-
 fs/smb/server/transport_rdma.c                     |     3 +-
 fs/smb/server/transport_rdma.h                     |     2 +-
 fs/smb/server/vfs_cache.c                          |   359 +-
 fs/smb/server/vfs_cache.h                          |     4 +-
 fs/smb/smbdirect/accept.c                          |     2 +-
 fs/smb/smbdirect/connect.c                         |     4 +-
 fs/smb/smbdirect/connection.c                      |    18 +-
 fs/smb/smbdirect/debug.c                           |     4 +-
 fs/smb/smbdirect/devices.c                         |     2 +-
 fs/smb/smbdirect/internal.h                        |     4 +-
 fs/smb/smbdirect/listen.c                          |     2 +-
 fs/smb/smbdirect/mr.c                              |    27 +-
 fs/smb/smbdirect/rw.c                              |     2 +-
 fs/smb/smbdirect/smbdirect.h                       |    52 -
 fs/smb/smbdirect/socket.c                          |    20 +-
 fs/sysfs/group.c                                   |     2 +-
 fs/udf/misc.c                                      |     8 +-
 fs/xfs/libxfs/xfs_dir2_data.c                      |    18 +-
 fs/xfs/libxfs/xfs_refcount.c                       |     3 +-
 fs/xfs/scrub/common.c                              |    11 +
 fs/xfs/scrub/common.h                              |     2 +
 fs/xfs/scrub/dabtree.c                             |     7 +-
 fs/xfs/scrub/dir.c                                 |     7 +-
 fs/xfs/xfs_buf.c                                   |    34 +-
 fs/xfs/xfs_inode.c                                 |     6 -
 fs/xfs/xfs_notify_failure.c                        |     2 +-
 fs/xfs/xfs_trans.c                                 |    11 +
 fs/xfs/xfs_zone_alloc.c                            |     4 +-
 fs/xfs/xfs_zone_gc.c                               |     2 +-
 fs/zonefs/super.c                                  |     6 +-
 include/acpi/acpi_bus.h                            |     2 +
 include/acpi/actbl1.h                              |     6 +
 include/asm-generic/kprobes.h                      |     2 +-
 include/asm-generic/ring_buffer.h                  |    13 +
 include/crypto/krb5.h                              |     9 +-
 include/drm/bridge/analogix_dp.h                   |     8 +-
 include/drm/bridge/dw_hdmi.h                       |     6 +
 include/drm/bridge/imx.h                           |    17 -
 include/drm/bridge/of-display-mode-bridge.h        |    17 +
 include/drm/display/drm_dp.h                       |    20 +-
 include/drm/display/drm_dp_helper.h                |     1 +
 include/drm/display/drm_dp_mst_helper.h            |    32 +-
 include/drm/display/drm_dp_tunnel.h                |    30 +-
 include/drm/display/drm_hdmi_state_helper.h        |     6 +-
 include/drm/drm_atomic.h                           |   158 +-
 include/drm/drm_atomic_helper.h                    |    78 +-
 include/drm/drm_atomic_state_helper.h              |     4 +-
 include/drm/drm_blend.h                            |     4 +-
 include/drm/drm_bridge.h                           |    96 +-
 include/drm/drm_colorop.h                          |     4 +-
 include/drm/drm_connector.h                        |     8 +-
 include/drm/drm_crtc.h                             |    10 +-
 include/drm/drm_crtc_helper.h                      |     4 +-
 include/drm/drm_damage_helper.h                    |     2 +-
 include/drm/drm_debugfs_crc.h                      |     2 +-
 include/drm/drm_device.h                           |     7 +
 include/drm/drm_encoder.h                          |     4 +
 include/drm/drm_exec.h                             |    71 +-
 include/drm/drm_fb_helper.h                        |     6 +
 include/drm/drm_gem.h                              |    20 +-
 include/drm/drm_gem_shmem_helper.h                 |     1 +
 include/drm/drm_gpusvm.h                           |    12 +-
 include/drm/drm_kunit_helpers.h                    |     2 +-
 include/drm/drm_mipi_dbi.h                         |     8 +-
 include/drm/drm_mipi_dsi.h                         |     1 +
 include/drm/drm_mode_config.h                      |    38 +-
 include/drm/drm_modeset_helper_vtables.h           |    44 +-
 include/drm/drm_of.h                               |    13 +
 include/drm/drm_pagemap.h                          |     9 +-
 include/drm/drm_panel.h                            |     5 +-
 include/drm/drm_plane.h                            |     6 +-
 include/drm/drm_ras.h                              |    11 +
 include/drm/drm_self_refresh_helper.h              |     6 +-
 include/drm/drm_vblank_helper.h                    |     8 +-
 include/drm/gpu_scheduler.h                        |    45 +-
 include/drm/intel/display_parent_interface.h       |    65 +-
 .../drm/intel/mchbar_regs.h                        |     7 +-
 .../drm/intel/pci_config.h                         |     0
 include/drm/intel/pciids.h                         |     6 +-
 .../drm/intel/vlv_iosf_sb_regs.h                   |    18 +-
 include/drm/ttm/ttm_placement.h                    |     4 +-
 include/drm/ttm/ttm_resource.h                     |     2 +
 include/linux/arm-smccc.h                          |     6 +
 include/linux/bio.h                                |     3 +-
 include/linux/bpf.h                                |     9 +-
 include/linux/bpf_verifier.h                       |     2 +
 include/linux/cdrom.h                              |     1 +
 include/linux/cgroup-defs.h                        |     4 +-
 include/linux/cgroup.h                             |     2 +
 include/linux/dma-buf.h                            |     4 +-
 include/linux/dma-fence-array.h                    |     6 +-
 include/linux/dpll.h                               |     1 +
 include/linux/efi.h                                |     2 +-
 include/linux/filter.h                             |     3 -
 include/linux/fprobe.h                             |     5 +
 include/linux/fsnotify_backend.h                   |     1 +
 include/linux/fwnode.h                             |     1 +
 include/linux/gfp_types.h                          |    10 +-
 include/linux/gpu_buddy.h                          |    41 +
 include/linux/hdmi.h                               |     6 +
 include/linux/hid.h                                |     6 +-
 include/linux/hid_bpf.h                            |    14 +-
 include/linux/highmem.h                            |     7 +-
 include/linux/host1x.h                             |     7 +
 include/linux/intel_tpmi.h                         |     6 +
 include/linux/irq-entry-common.h                   |     8 -
 include/linux/irqchip/arm-gic-v5.h                 |     3 -
 include/linux/libata.h                             |     7 +-
 include/linux/list.h                               |    37 +
 include/linux/mailbox_client.h                     |     1 +
 include/linux/mailbox_controller.h                 |    17 +-
 include/linux/maple_tree.h                         |     2 +-
 include/linux/mm.h                                 |     2 +-
 include/linux/mroute_base.h                        |     3 +
 include/linux/mtd/spinand.h                        |     7 +
 include/linux/netfilter/x_tables.h                 |    12 +-
 include/linux/netfilter_arp/arp_tables.h           |     1 -
 include/linux/netfilter_ipv4/ip_tables.h           |     1 -
 include/linux/netfilter_ipv6/ip6_tables.h          |     1 -
 include/linux/netfs.h                              |   295 +-
 include/linux/nvme-auth.h                          |     6 +-
 include/linux/rculist.h                            |    29 +
 include/linux/rhashtable-types.h                   |     5 +
 include/linux/rhashtable.h                         |     8 +-
 include/linux/rseq.h                               |    37 +-
 include/linux/rseq_entry.h                         |   141 +-
 include/linux/rseq_types.h                         |    13 +-
 include/linux/sched.h                              |     3 +
 include/linux/sched/deadline.h                     |     9 +
 include/linux/sched/ext.h                          |    16 +-
 include/linux/sched/isolation.h                    |     6 +-
 include/linux/slab.h                               |     3 +
 .../public.h =3D> include/linux/smbdirect.h          |    52 +-
 include/linux/soc/airoha/airoha_offload.h          |     6 +-
 include/linux/soc/qcom/ubwc.h                      |    22 +
 include/linux/tracepoint.h                         |     2 +-
 include/linux/vfio_pci_core.h                      |     2 +-
 include/linux/workqueue.h                          |     6 +-
 include/net/bluetooth/bluetooth.h                  |     1 +
 include/net/bluetooth/hci_core.h                   |     2 +-
 include/net/bond_3ad.h                             |     2 +-
 include/net/dropreason-core.h                      |     6 +
 include/net/genetlink.h                            |     4 +-
 include/net/ip_vs.h                                |    34 +-
 include/net/ipv6.h                                 |     3 +
 include/net/macsec.h                               |     7 +-
 include/net/mana/shm_channel.h                     |     6 +
 include/net/neighbour.h                            |     8 +-
 include/net/net_shaper.h                           |     1 +
 include/net/netfilter/nf_conntrack_expect.h        |     5 +-
 include/net/netfilter/nf_dup_netdev.h              |    13 +
 include/net/netfilter/nf_flow_table.h              |     4 +-
 include/net/netfilter/nf_queue.h                   |     1 +
 include/net/netfilter/nf_tables.h                  |    13 +
 include/net/netmem.h                               |    15 +
 include/net/netns/ipv4.h                           |     2 +-
 include/net/netns/ipv6.h                           |     1 +
 include/net/nsh.h                                  |     4 +-
 include/net/tcp.h                                  |     7 +-
 include/rdma/uverbs_ioctl.h                        |     1 +
 include/trace/events/amdxdna.h                     |    42 +-
 include/trace/events/btrfs.h                       |     4 +-
 include/trace/events/damon.h                       |     2 +-
 include/trace/events/dma_fence.h                   |    40 +-
 include/trace/events/host1x.h                      |    50 +-
 include/trace/events/netfs.h                       |     8 +
 include/trace/events/rxrpc.h                       |     1 +
 include/uapi/drm/amdxdna_accel.h                   |    27 +-
 include/uapi/drm/drm.h                             |    27 +-
 include/uapi/drm/drm_fourcc.h                      |    54 +-
 include/uapi/drm/drm_mode.h                        |    19 +-
 include/uapi/drm/drm_ras.h                         |     1 +
 include/uapi/drm/drm_sarea.h                       |    20 +-
 include/uapi/drm/msm_drm.h                         |    48 +
 include/uapi/drm/tegra_drm.h                       |    16 +
 include/uapi/drm/virtgpu_drm.h                     |     5 +
 include/uapi/drm/xe_drm.h                          |   206 +-
 include/uapi/linux/io_uring.h                      |     3 +-
 include/uapi/linux/kfd_ioctl.h                     |    38 +-
 include/uapi/linux/rseq.h                          |     5 +-
 include/uapi/linux/virtio_gpu.h                    |     9 +
 include/ufs/unipro.h                               |     5 +
 include/video/imx-ipu-image-convert.h              |    16 +-
 include/video/udlfb.h                              |     1 +
 include/xen/arm/interface.h                        |     2 +-
 io_uring/cancel.c                                  |     2 +-
 io_uring/eventfd.c                                 |     1 +
 io_uring/fdinfo.c                                  |     3 +-
 io_uring/io-wq.c                                   |     3 +-
 io_uring/io_uring.c                                |    38 +-
 io_uring/kbuf.c                                    |     9 +-
 io_uring/kbuf.h                                    |     8 +-
 io_uring/napi.c                                    |    29 +-
 io_uring/napi.h                                    |     8 +-
 io_uring/net.c                                     |    26 +-
 io_uring/nop.c                                     |     4 +-
 io_uring/rw.c                                      |     4 +-
 io_uring/timeout.c                                 |    55 +-
 io_uring/tw.c                                      |    12 +-
 io_uring/wait.c                                    |     6 +-
 io_uring/waitid.c                                  |     1 +
 io_uring/zcrx.c                                    |     3 +-
 kernel/audit.c                                     |     4 +
 kernel/auditsc.c                                   |     2 +-
 kernel/bpf/arena.c                                 |     2 +-
 kernel/bpf/arraymap.c                              |     2 +-
 kernel/bpf/cfg.c                                   |    13 +-
 kernel/bpf/core.c                                  |    27 +-
 kernel/bpf/fixups.c                                |    13 +-
 kernel/bpf/helpers.c                               |     5 +
 kernel/bpf/liveness.c                              |    25 +-
 kernel/bpf/syscall.c                               |    26 +
 kernel/bpf/verifier.c                              |    27 +-
 kernel/cgroup/cgroup.c                             |   280 +-
 kernel/cgroup/cpuset-internal.h                    |     6 +
 kernel/cgroup/cpuset.c                             |    67 +-
 kernel/cgroup/dmem.c                               |     1 +
 kernel/cgroup/rdma.c                               |     2 +-
 kernel/cgroup/rstat.c                              |    37 +-
 kernel/dma/debug.c                                 |     9 +-
 kernel/dma/direct.c                                |     4 +-
 kernel/dma/mapping.c                               |     4 -
 kernel/events/core.c                               |    70 +-
 kernel/events/internal.h                           |     1 +
 kernel/events/ring_buffer.c                        |     2 +
 kernel/exit.c                                      |     2 +
 kernel/fork.c                                      |    12 +-
 kernel/futex/requeue.c                             |    13 +-
 kernel/irq/chip.c                                  |     9 +-
 kernel/irq_work.c                                  |     7 +
 kernel/liveupdate/kexec_handover.c                 |    23 +-
 kernel/liveupdate/luo_session.c                    |    15 +-
 kernel/ptrace.c                                    |    22 +-
 kernel/rcu/srcutree.c                              |    12 +-
 kernel/rseq.c                                      |   214 +-
 kernel/sched/core.c                                |     1 +
 kernel/sched/deadline.c                            |    13 +-
 kernel/sched/ext.c                                 |   737 +-
 kernel/sched/ext_idle.c                            |    32 +-
 kernel/sched/ext_idle.h                            |     1 +
 kernel/sched/ext_internal.h                        |     2 +
 kernel/sched/fair.c                                |    84 +-
 kernel/sched/membarrier.c                          |    11 +-
 kernel/time/timer_migration.c                      |    40 +-
 kernel/trace/Makefile                              |     7 +-
 kernel/trace/bpf_trace.c                           |     3 +-
 kernel/trace/fprobe.c                              |    23 +-
 kernel/trace/remote_test.c                         |     4 +-
 kernel/trace/ring_buffer.c                         |    30 +-
 kernel/trace/simple_ring_buffer.c                  |     4 +-
 kernel/trace/trace_branch.c                        |     8 +-
 kernel/trace/trace_events_hist.c                   |     6 +-
 kernel/trace/trace_probe.c                         |     6 +
 kernel/trace/trace_probe.h                         |     4 +-
 kernel/trace/tracing_map.c                         |    17 +-
 kernel/workqueue.c                                 |    45 +-
 lib/debugobjects.c                                 |    18 +-
 lib/fonts/font_rotate.c                            |     2 +-
 lib/kunit/Kconfig                                  |     5 +-
 lib/maple_tree.c                                   |     2 +-
 lib/rhashtable.c                                   |    69 +-
 lib/test_maple_tree.c                              |     4 +-
 lib/tests/kunit_iov_iter.c                         |    10 +-
 lib/tests/test_kprobes.c                           |    29 +-
 lib/vdso/gettimeofday.c                            |     5 +-
 mm/damon/lru_sort.c                                |    85 +-
 mm/damon/reclaim.c                                 |    85 +-
 mm/damon/stat.c                                    |    30 +-
 mm/damon/sysfs-schemes.c                           |    25 +-
 mm/hugetlb_cma.c                                   |     1 +
 mm/memcontrol.c                                    |    35 +-
 mm/memfd_luo.c                                     |    25 +-
 mm/memory.c                                        |    24 +-
 mm/memory_hotplug.c                                |     2 +
 mm/migrate_device.c                                |     2 +-
 mm/page-writeback.c                                |    16 +-
 mm/page_alloc.c                                    |    13 +-
 mm/slab_common.c                                   |     2 +
 mm/slub.c                                          |    21 +
 mm/userfaultfd.c                                   |    12 +-
 mm/util.c                                          |    26 +-
 mm/vma.c                                           |     3 +-
 mm/vmalloc.c                                       |     2 +-
 net/appletalk/aarp.c                               |     5 +
 net/atm/signaling.c                                |     1 +
 net/batman-adv/bat_iv_ogm.c                        |   167 +-
 net/batman-adv/bat_v_ogm.c                         |    59 +-
 net/batman-adv/bridge_loop_avoidance.c             |   120 +-
 net/batman-adv/distributed-arp-table.c             |     3 +
 net/batman-adv/fragmentation.c                     |    58 +-
 net/batman-adv/gateway_client.c                    |     4 +
 net/batman-adv/main.c                              |     1 +
 net/batman-adv/mesh-interface.c                    |     1 +
 net/batman-adv/originator.c                        |     4 +-
 net/batman-adv/tp_meter.c                          |   231 +-
 net/batman-adv/tp_meter.h                          |     1 +
 net/batman-adv/translation-table.c                 |    55 +-
 net/batman-adv/tvlv.c                              |    28 +-
 net/batman-adv/tvlv.h                              |     2 +-
 net/batman-adv/types.h                             |    63 +-
 net/bluetooth/af_bluetooth.c                       |    99 +-
 net/bluetooth/bnep/core.c                          |    15 +-
 net/bluetooth/hci_conn.c                           |   124 +-
 net/bluetooth/hci_event.c                          |    31 +-
 net/bluetooth/hci_sync.c                           |     6 +-
 net/bluetooth/hidp/core.c                          |    27 +-
 net/bluetooth/iso.c                                |    70 +-
 net/bluetooth/l2cap_core.c                         |    16 +-
 net/bluetooth/l2cap_sock.c                         |    60 +-
 net/bluetooth/mgmt.c                               |     6 +
 net/bluetooth/rfcomm/core.c                        |     7 +-
 net/bluetooth/rfcomm/sock.c                        |     9 +-
 net/bluetooth/sco.c                                |    71 +-
 net/bridge/br_multicast.c                          |    22 +-
 net/bridge/br_netfilter_hooks.c                    |     6 +-
 net/bridge/br_netlink.c                            |    10 +
 net/bridge/netfilter/ebtable_broute.c              |    14 +-
 net/bridge/netfilter/ebtable_filter.c              |    14 +-
 net/bridge/netfilter/ebtable_nat.c                 |    12 +-
 net/bridge/netfilter/ebtables.c                    |    71 +-
 net/ceph/auth_x.c                                  |     5 +
 net/ceph/crush/crush.c                             |     6 +-
 net/ceph/osdmap.c                                  |    17 +-
 net/core/bpf_sk_storage.c                          |    14 +-
 net/core/dev.c                                     |    23 +-
 net/core/devmem.c                                  |    14 +-
 net/core/failover.c                                |     6 +-
 net/core/filter.c                                  |    55 +-
 net/core/gro.c                                     |     7 +
 net/core/neighbour.c                               |    10 +-
 net/core/netpoll.c                                 |    44 +-
 net/core/page_pool.c                               |    10 +-
 net/core/rtnetlink.c                               |     6 +-
 net/core/skbuff.c                                  |    11 +-
 net/core/skmsg.c                                   |     9 +-
 net/core/sock_map.c                                |    39 +-
 net/ethtool/bitset.c                               |     8 +-
 net/ethtool/phy.c                                  |    36 +-
 net/hsr/hsr_framereg.c                             |     9 +-
 net/ipv4/ah4.c                                     |    14 +-
 net/ipv4/bpf_tcp_ca.c                              |     2 +-
 net/ipv4/esp4.c                                    |     3 +-
 net/ipv4/icmp.c                                    |     3 +
 net/ipv4/igmp.c                                    |    58 +-
 net/ipv4/inet_connection_sock.c                    |     4 +-
 net/ipv4/inetpeer.c                                |     3 +-
 net/ipv4/ip_output.c                               |     2 +
 net/ipv4/ipmr.c                                    |   118 +-
 net/ipv4/ipmr_base.c                               |    16 +
 net/ipv4/netfilter/arp_tables.c                    |    71 +-
 net/ipv4/netfilter/arpt_mangle.c                   |     8 +
 net/ipv4/netfilter/arptable_filter.c               |    27 +-
 net/ipv4/netfilter/ip_tables.c                     |    59 +-
 net/ipv4/netfilter/iptable_filter.c                |    27 +-
 net/ipv4/netfilter/iptable_mangle.c                |    29 +-
 net/ipv4/netfilter/iptable_nat.c                   |     6 +-
 net/ipv4/netfilter/iptable_raw.c                   |    26 +-
 net/ipv4/netfilter/iptable_security.c              |    27 +-
 net/ipv4/netfilter/nf_socket_ipv4.c                |     3 +
 net/ipv4/raw.c                                     |     2 +-
 net/ipv4/route.c                                   |     2 +-
 net/ipv4/tcp.c                                     |     3 -
 net/ipv4/tcp_ao.c                                  |     3 +-
 net/ipv4/tcp_input.c                               |    15 +-
 net/ipv4/tcp_ipv4.c                                |    17 +-
 net/ipv4/tcp_minisocks.c                           |     2 +-
 net/ipv4/tcp_output.c                              |     1 +
 net/ipv4/tcp_timer.c                               |     5 +-
 net/ipv4/udp_offload.c                             |    22 +-
 net/ipv6/Kconfig                                   |     4 +-
 net/ipv6/ah6.c                                     |    14 +-
 net/ipv6/esp6.c                                    |     3 +-
 net/ipv6/exthdrs.c                                 |    30 +-
 net/ipv6/exthdrs_core.c                            |     7 +
 net/ipv6/ip6_flowlabel.c                           |    46 +-
 net/ipv6/ip6_gre.c                                 |     5 +-
 net/ipv6/ip6_input.c                               |     5 +
 net/ipv6/ip6_output.c                              |     5 +
 net/ipv6/ip6_tunnel.c                              |     4 +
 net/ipv6/netfilter/ip6_tables.c                    |    56 +-
 net/ipv6/netfilter/ip6t_hbh.c                      |     4 +
 net/ipv6/netfilter/ip6table_filter.c               |    26 +-
 net/ipv6/netfilter/ip6table_mangle.c               |    27 +-
 net/ipv6/netfilter/ip6table_nat.c                  |     6 +-
 net/ipv6/netfilter/ip6table_raw.c                  |    24 +-
 net/ipv6/netfilter/ip6table_security.c             |    27 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                |     5 +-
 net/ipv6/route.c                                   |    11 +-
 net/ipv6/rpl_iptunnel.c                            |     9 +
 net/ipv6/seg6_iptunnel.c                           |     9 +
 net/ipv6/tcp_ipv6.c                                |    20 +-
 net/ipv6/xfrm6_protocol.c                          |     4 +-
 net/l2tp/l2tp_core.c                               |     2 +-
 net/mac80211/cfg.c                                 |     5 +-
 net/mac80211/mlme.c                                |    23 +-
 net/mac80211/parse.c                               |   107 +-
 net/mac80211/rx.c                                  |    12 +-
 net/mac80211/tests/chan-mode.c                     |     1 +
 net/mac80211/util.c                                |     4 +-
 net/mctp/test/route-test.c                         |     2 +-
 net/mctp/test/utils.c                              |     2 +-
 net/mptcp/bpf.c                                    |     2 +-
 net/mptcp/fastopen.c                               |     4 +-
 net/mptcp/pm.c                                     |   118 +-
 net/mptcp/pm_kernel.c                              |    14 +-
 net/mptcp/protocol.c                               |    28 +-
 net/mptcp/sockopt.c                                |    26 +-
 net/mptcp/subflow.c                                |     4 +-
 net/netfilter/ipset/ip_set_core.c                  |     5 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |    57 +-
 net/netfilter/ipset/ip_set_hash_ipmark.c           |     6 +-
 net/netfilter/ipset/ip_set_hash_ipport.c           |     5 +-
 net/netfilter/ipset/ip_set_hash_ipportip.c         |     5 +-
 net/netfilter/ipset/ip_set_hash_ipportnet.c        |     5 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |    74 +-
 net/netfilter/ipvs/ip_vs_core.c                    |     2 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   343 +-
 net/netfilter/ipvs/ip_vs_est.c                     |    83 +-
 net/netfilter/nf_conntrack_broadcast.c             |     1 +
 net/netfilter/nf_conntrack_core.c                  |     7 +-
 net/netfilter/nf_conntrack_expect.c                |     1 +
 net/netfilter/nf_conntrack_h323_main.c             |    12 +-
 net/netfilter/nf_conntrack_helper.c                |    18 +-
 net/netfilter/nf_conntrack_netlink.c               |    21 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |    10 +-
 net/netfilter/nf_conntrack_sip.c                   |   162 +-
 net/netfilter/nf_dup_netdev.c                      |    16 -
 net/netfilter/nf_flow_table_core.c                 |     1 +
 net/netfilter/nf_flow_table_ip.c                   |   151 +-
 net/netfilter/nf_flow_table_path.c                 |     7 +-
 net/netfilter/nf_nat_sip.c                         |     1 +
 net/netfilter/nf_queue.c                           |     4 +-
 net/netfilter/nf_tables_api.c                      |   347 +-
 net/netfilter/nf_tables_core.c                     |     2 +-
 net/netfilter/nfnetlink_queue.c                    |     2 +
 net/netfilter/nft_bitwise.c                        |     3 +-
 net/netfilter/nft_compat.c                         |    45 +-
 net/netfilter/nft_ct.c                             |     2 +
 net/netfilter/nft_exthdr.c                         |     2 +-
 net/netfilter/nft_fwd_netdev.c                     |    29 +-
 net/netfilter/nft_inner.c                          |     3 +-
 net/netfilter/nft_osf.c                            |     2 +-
 net/netfilter/nft_tproxy.c                         |     8 +-
 net/netfilter/x_tables.c                           |   256 +-
 net/netfilter/xt_CT.c                              |     8 +-
 net/netfilter/xt_TCPMSS.c                          |    33 +-
 net/netfilter/xt_TPROXY.c                          |    11 +-
 net/netfilter/xt_addrtype.c                        |    25 +-
 net/netfilter/xt_devgroup.c                        |    18 +-
 net/netfilter/xt_ecn.c                             |     4 +
 net/netfilter/xt_hashlimit.c                       |     4 +-
 net/netfilter/xt_osf.c                             |     3 +
 net/netfilter/xt_physdev.c                         |    24 +-
 net/netfilter/xt_policy.c                          |    26 +-
 net/netfilter/xt_set.c                             |    39 +-
 net/netfilter/xt_tcpmss.c                          |     4 +
 net/netlink/genetlink.c                            |     8 +-
 net/openvswitch/vport-geneve.c                     |     5 +-
 net/openvswitch/vport-gre.c                        |     5 +-
 net/openvswitch/vport-netdev.c                     |    72 +-
 net/openvswitch/vport-netdev.h                     |     2 +-
 net/openvswitch/vport-vxlan.c                      |     5 +-
 net/phonet/pep.c                                   |    19 +-
 net/phonet/socket.c                                |    10 +-
 net/psp/psp-nl-gen.c                               |     4 +-
 net/psp/psp_main.c                                 |    42 +-
 net/psp/psp_nl.c                                   |    10 +-
 net/rds/message.c                                  |    21 +-
 net/rds/tcp.c                                      |     9 +-
 net/rxrpc/ar-internal.h                            |    14 +-
 net/rxrpc/call_event.c                             |    20 +-
 net/rxrpc/call_object.c                            |     2 +
 net/rxrpc/conn_event.c                             |    29 +-
 net/rxrpc/insecure.c                               |     8 +-
 net/rxrpc/recvmsg.c                                |    68 +-
 net/rxrpc/rxgk.c                                   |   160 +-
 net/rxrpc/rxgk_app.c                               |    46 +-
 net/rxrpc/rxgk_common.h                            |    66 +-
 net/rxrpc/rxkad.c                                  |   115 +-
 net/sched/sch_cake.c                               |   370 +-
 net/sched/sch_cbs.c                                |    16 +-
 net/sched/sch_choke.c                              |    26 +-
 net/sched/sch_dualpi2.c                            |     4 +-
 net/sched/sch_fq_codel.c                           |    39 +-
 net/sched/sch_fq_pie.c                             |    19 +-
 net/sched/sch_netem.c                              |    76 +-
 net/sched/sch_pie.c                                |    14 +-
 net/sched/sch_red.c                                |     2 +-
 net/sched/sch_sfb.c                                |     2 +-
 net/sched/sch_sfq.c                                |    48 +-
 net/sched/sch_taprio.c                             |    13 +-
 net/sctp/sm_statefuns.c                            |     6 +
 net/sctp/socket.c                                  |     9 +
 net/shaper/shaper.c                                |   224 +-
 net/shaper/shaper_nl_gen.c                         |     7 +-
 net/shaper/shaper_nl_gen.h                         |     2 +
 net/smc/af_smc.c                                   |    28 +-
 net/smc/smc_tracepoint.h                           |     2 +-
 net/sunrpc/cache.c                                 |     2 +-
 net/tls/tls.h                                      |     1 +
 net/tls/tls_strp.c                                 |     6 +
 net/tls/tls_sw.c                                   |    56 +-
 net/unix/af_unix.c                                 |    14 +-
 net/unix/garbage.c                                 |     6 +-
 net/vmw_vsock/hyperv_transport.c                   |     4 +-
 net/vmw_vsock/virtio_transport_common.c            |   159 +-
 net/vmw_vsock/vmci_transport.c                     |     2 +-
 net/wireless/nl80211.c                             |    27 +
 net/wireless/pmsr.c                                |     2 +-
 net/wireless/scan.c                                |     3 +
 net/wireless/wext-compat.c                         |     2 +
 net/xdp/xsk.c                                      |   115 +-
 net/xdp/xsk_buff_pool.c                            |     3 +
 net/xdp/xskmap.c                                   |     4 +
 net/xfrm/xfrm_output.c                             |    20 +-
 net/xfrm/xfrm_state.c                              |    12 +-
 net/xfrm/xfrm_user.c                               |     1 +
 rust/Makefile                                      |     2 +
 rust/bindings/bindings_helper.h                    |     1 +
 rust/helpers/drm_gpuvm.c                           |    26 +
 rust/helpers/helpers.c                             |     1 +
 rust/kernel/drm/device.rs                          |   272 +-
 rust/kernel/drm/driver.rs                          |    49 +-
 rust/kernel/drm/gem/mod.rs                         |    85 +-
 rust/kernel/drm/gem/shmem.rs                       |    67 +-
 rust/kernel/drm/gpuvm/mod.rs                       |   328 +
 rust/kernel/drm/gpuvm/sm_ops.rs                    |   429 +
 rust/kernel/drm/gpuvm/va.rs                        |   168 +
 rust/kernel/drm/gpuvm/vm_bo.rs                     |   249 +
 rust/kernel/drm/mod.rs                             |     5 +
 rust/pin-init/internal/src/init.rs                 |   184 +-
 rust/pin-init/src/__internal.rs                    |    28 +-
 scripts/gcc-plugins/gcc-common.h                   |     4 +-
 scripts/gdb/linux/mm.py                            |     6 +-
 scripts/gdb/linux/slab.py                          |     4 +-
 scripts/mod/file2alias.c                           |    79 +-
 scripts/package/PKGBUILD                           |     2 +-
 security/lsm_syscalls.c                            |     9 +-
 security/selinux/hooks.c                           |    38 +-
 security/selinux/include/objsec.h                  |     4 +-
 security/selinux/include/security.h                |     2 -
 security/selinux/selinuxfs.c                       |   196 +-
 security/selinux/ss/services.c                     |   125 -
 sound/core/misc.c                                  |     8 +-
 sound/core/oss/pcm_oss.c                           |    29 +-
 sound/core/pcm_drm_eld.c                           |     4 +-
 sound/core/pcm_lib.c                               |     3 +
 sound/core/seq/seq_clientmgr.c                     |     2 +-
 sound/core/seq/seq_clientmgr.h                     |     5 +-
 sound/core/seq/seq_ports.c                         |     7 +-
 sound/core/seq/seq_ump_client.c                    |    24 +-
 sound/core/timer.c                                 |    19 +-
 sound/drivers/aloop.c                              |    43 +-
 sound/drivers/pcmtest.c                            |     6 +-
 sound/firewire/tascam/tascam-hwdep.c               |     1 +
 sound/hda/codecs/Makefile                          |     2 -
 sound/hda/codecs/ca0132.c                          |    44 +-
 sound/hda/codecs/conexant.c                        |     8 +-
 sound/hda/codecs/realtek/alc269.c                  |   101 +-
 sound/hda/codecs/side-codecs/Kconfig               |     1 -
 sound/hda/codecs/side-codecs/cs35l41_hda.c         |     4 +-
 sound/hda/codecs/side-codecs/cs35l56_hda.c         |    32 +-
 sound/hda/codecs/side-codecs/cs35l56_hda.h         |     1 +
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c     |    14 +-
 sound/hda/common/auto_parser.c                     |     4 +-
 sound/hda/common/codec.c                           |     3 +
 sound/hda/common/controller.c                      |    28 +-
 sound/hda/common/hda_controller.h                  |    14 +-
 sound/hda/controllers/intel.c                      |   106 +-
 sound/hda/controllers/intel.h                      |    15 +-
 sound/hda/core/hdmi_chmap.c                        |    11 +-
 sound/pci/asihpi/hpicmn.c                          |     6 +
 sound/soc/amd/acp-config.c                         |     7 +
 sound/soc/amd/acp/acp-legacy-mach.c                |     2 +-
 sound/soc/amd/acp/acp-mach-common.c                |    22 +-
 sound/soc/amd/acp/acp-mach.h                       |     4 +
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |     2 +-
 sound/soc/amd/acp/acp-sof-mach.c                   |     2 +-
 sound/soc/amd/yc/acp6x-mach.c                      |    21 +
 sound/soc/codecs/Kconfig                           |     3 -
 sound/soc/codecs/ab8500-codec.c                    |   304 +-
 sound/soc/codecs/aw88395/aw88395.c                 |     9 +-
 sound/soc/codecs/cs-amp-lib.c                      |    17 +-
 sound/soc/codecs/cs35l56-sdw.c                     |     8 +-
 sound/soc/codecs/cs35l56-shared.c                  |    18 +-
 sound/soc/codecs/cs35l56.c                         |    24 +-
 sound/soc/codecs/es8389.c                          |     2 +-
 sound/soc/codecs/fs210x.c                          |     2 +-
 sound/soc/codecs/pcm512x.c                         |     6 +-
 sound/soc/codecs/tas2764.c                         |    36 +-
 sound/soc/codecs/tas2770.c                         |    27 +-
 sound/soc/codecs/wcd937x.c                         |    26 +-
 sound/soc/codecs/wm_adsp_fw_find_test.c            |    57 +-
 sound/soc/fsl/fsl_sai.c                            |    43 +-
 sound/soc/fsl/fsl_xcvr.c                           |    17 +-
 sound/soc/intel/boards/bytcr_wm5102.c              |     1 +
 sound/soc/intel/boards/sof_sdw.c                   |     8 +
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |    71 +-
 sound/soc/intel/common/soc-acpi-intel-nvl-match.c  |    13 +
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |   134 +-
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.c  |    16 +
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.h  |     1 +
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |     7 +-
 sound/soc/sdw_utils/soc_sdw_utils.c                |    15 +-
 sound/soc/soc-utils.c                              |     1 +
 sound/soc/sof/amd/acp.c                            |     2 +-
 sound/soc/sof/intel/hda.c                          |     3 +-
 sound/soc/spacemit/k1_i2s.c                        |    56 +-
 sound/soc/tegra/Makefile                           |     1 -
 sound/soc/ti/omap-dmic.c                           |     2 +-
 sound/sparc/dbri.c                                 |     1 +
 sound/usb/caiaq/device.c                           |     6 +-
 sound/usb/caiaq/input.c                            |     2 +-
 sound/usb/clock.c                                  |    15 +-
 sound/usb/midi.c                                   |    12 +-
 sound/usb/midi2.c                                  |    21 +-
 sound/usb/misc/ua101.c                             |    12 +-
 sound/usb/mixer.c                                  |    10 +
 sound/usb/mixer_scarlett2.c                        |     9 +-
 sound/usb/qcom/qc_audio_offload.c                  |    31 +-
 sound/usb/quirks-table.h                           |     4 +-
 sound/usb/quirks.c                                 |    11 +-
 sound/usb/stream.c                                 |    62 +-
 sound/usb/stream.h                                 |     3 +-
 tools/arch/x86/include/asm/msr-index.h             |     3 +-
 tools/include/uapi/linux/stddef.h                  |    26 +-
 tools/lib/bpf/gen_loader.c                         |     3 +-
 tools/net/ynl/Makefile.deps                        |     4 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |    37 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |    31 +-
 tools/perf/Makefile                                |     5 +-
 tools/perf/Makefile.perf                           |     9 +-
 tools/perf/builtin-trace.c                         |     9 +-
 tools/perf/trace/beauty/beauty.h                   |     3 +
 tools/perf/trace/beauty/clone.sh                   |     4 +
 tools/perf/trace/beauty/fsmount.c                  |    18 +-
 tools/perf/trace/beauty/fsmount.sh                 |    11 +-
 tools/perf/trace/beauty/fsmount_attr.sh            |    22 +
 tools/perf/trace/beauty/include/linux/socket.h     |     2 +-
 tools/perf/trace/beauty/include/uapi/linux/fs.h    |    12 +
 tools/perf/trace/beauty/include/uapi/linux/mount.h |     1 +
 tools/perf/trace/beauty/include/uapi/linux/sched.h |    17 +-
 tools/sched_ext/scx_qmap.bpf.c                     |    24 +-
 tools/testing/radix-tree/maple.c                   |     2 +-
 tools/testing/selftests/arm64/gcs/gcs-util.h       |     6 -
 tools/testing/selftests/arm64/gcs/libc-gcs.c       |     1 +
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |     4 +
 .../selftests/bpf/prog_tests/kfunc_dynptr_param.c  |     2 +-
 .../bpf/prog_tests/percpu_array_inner_map.c        |    57 +
 .../selftests/bpf/prog_tests/sockmap_ktls.c        |   103 +
 .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |    17 +-
 .../selftests/bpf/prog_tests/tcp_hdr_options.c     |     4 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |     2 +
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |    14 +
 .../testing/selftests/bpf/progs/exceptions_fail.c  |    22 +
 tools/testing/selftests/bpf/progs/sockopt_sk.c     |    16 +
 .../bpf/progs/test_misc_tcp_hdr_options.c          |    15 +-
 .../selftests/bpf/progs/test_sockmap_ktls.c        |    21 +
 .../selftests/bpf/progs/verifier_call_large_imm.c  |    66 +
 tools/testing/selftests/cgroup/lib/cgroup_util.c   |     5 +-
 .../selftests/cgroup/test_cpuset_v1_base.sh        |     2 +-
 tools/testing/selftests/cgroup/test_kmem.c         |    12 +-
 tools/testing/selftests/drivers/net/README.rst     |    10 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |     1 +
 tools/testing/selftests/drivers/net/hw/config      |     5 +
 .../selftests/drivers/net/hw/ipsec_vxlan.py        |   204 +
 tools/testing/selftests/drivers/net/lib/py/load.py |     5 +-
 tools/testing/selftests/drivers/net/shaper.py      |    24 +-
 tools/testing/selftests/kselftest.h                |     2 +-
 tools/testing/selftests/kselftest_harness.h        |    12 +-
 .../selftests/kvm/access_tracking_perf_test.c      |    44 +-
 tools/testing/selftests/kvm/arch_timer.c           |     6 +-
 .../testing/selftests/kvm/arm64/aarch32_id_regs.c  |    14 +-
 tools/testing/selftests/kvm/arm64/arch_timer.c     |     8 +-
 .../selftests/kvm/arm64/arch_timer_edge_cases.c    |   161 +-
 .../testing/selftests/kvm/arm64/debug-exceptions.c |    72 +-
 tools/testing/selftests/kvm/arm64/hypercalls.c     |    24 +-
 tools/testing/selftests/kvm/arm64/idreg-idst.c     |     4 +-
 tools/testing/selftests/kvm/arm64/no-vgic.c        |     8 +-
 .../testing/selftests/kvm/arm64/page_fault_test.c  |    82 +-
 tools/testing/selftests/kvm/arm64/psci_test.c      |    26 +-
 tools/testing/selftests/kvm/arm64/sea_to_user.c    |    41 +-
 tools/testing/selftests/kvm/arm64/set_id_regs.c    |    70 +-
 tools/testing/selftests/kvm/arm64/smccc_filter.c   |    10 +-
 tools/testing/selftests/kvm/arm64/vgic_init.c      |    56 +-
 tools/testing/selftests/kvm/arm64/vgic_irq.c       |   137 +-
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  |    20 +-
 tools/testing/selftests/kvm/arm64/vgic_v5.c        |    10 +-
 .../selftests/kvm/arm64/vpmu_counter_access.c      |    56 +-
 tools/testing/selftests/kvm/coalesced_io_test.c    |    38 +-
 tools/testing/selftests/kvm/demand_paging_test.c   |    10 +-
 tools/testing/selftests/kvm/dirty_log_perf_test.c  |    14 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |    82 +-
 tools/testing/selftests/kvm/get-reg-list.c         |     2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     |    27 +-
 tools/testing/selftests/kvm/guest_print_test.c     |    22 +-
 .../testing/selftests/kvm/hardware_disable_test.c  |     6 +-
 .../selftests/kvm/include/arm64/arch_timer.h       |    30 +-
 tools/testing/selftests/kvm/include/arm64/delay.h  |     4 +-
 tools/testing/selftests/kvm/include/arm64/gic.h    |     8 +-
 .../selftests/kvm/include/arm64/gic_v3_its.h       |     7 +-
 .../selftests/kvm/include/arm64/processor.h        |    22 +-
 tools/testing/selftests/kvm/include/arm64/ucall.h  |     4 +-
 tools/testing/selftests/kvm/include/arm64/vgic.h   |    22 +-
 tools/testing/selftests/kvm/include/kvm_util.h     |   344 +-
 .../testing/selftests/kvm/include/kvm_util_types.h |     8 +-
 .../selftests/kvm/include/loongarch/arch_timer.h   |     4 +-
 .../selftests/kvm/include/loongarch/ucall.h        |     4 +-
 tools/testing/selftests/kvm/include/memstress.h    |    30 +-
 .../selftests/kvm/include/riscv/arch_timer.h       |    22 +-
 .../selftests/kvm/include/riscv/processor.h        |     9 +-
 tools/testing/selftests/kvm/include/riscv/ucall.h  |     4 +-
 .../kvm/include/s390/diag318_test_handler.h        |     2 +-
 .../testing/selftests/kvm/include/s390/facility.h  |     4 +-
 tools/testing/selftests/kvm/include/s390/ucall.h   |     4 +-
 tools/testing/selftests/kvm/include/sparsebit.h    |     6 +-
 tools/testing/selftests/kvm/include/test_util.h    |    40 +-
 tools/testing/selftests/kvm/include/timer_test.h   |    18 +-
 tools/testing/selftests/kvm/include/ucall_common.h |    22 +-
 .../selftests/kvm/include/userfaultfd_util.h       |     6 +-
 tools/testing/selftests/kvm/include/x86/apic.h     |    22 +-
 tools/testing/selftests/kvm/include/x86/evmcs.h    |    22 +-
 tools/testing/selftests/kvm/include/x86/hyperv.h   |    28 +-
 .../selftests/kvm/include/x86/kvm_util_arch.h      |    36 +-
 tools/testing/selftests/kvm/include/x86/pmu.h      |     9 +-
 .../testing/selftests/kvm/include/x86/processor.h  |   292 +-
 tools/testing/selftests/kvm/include/x86/sev.h      |    20 +-
 tools/testing/selftests/kvm/include/x86/smm.h      |     3 +-
 tools/testing/selftests/kvm/include/x86/svm_util.h |    12 +-
 tools/testing/selftests/kvm/include/x86/ucall.h    |     2 +-
 tools/testing/selftests/kvm/include/x86/vmx.h      |    70 +-
 tools/testing/selftests/kvm/kvm_page_table_test.c  |    54 +-
 tools/testing/selftests/kvm/lib/arm64/gic.c        |     6 +-
 .../testing/selftests/kvm/lib/arm64/gic_private.h  |    26 +-
 tools/testing/selftests/kvm/lib/arm64/gic_v3.c     |    90 +-
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c |    11 +-
 tools/testing/selftests/kvm/lib/arm64/processor.c  |   163 +-
 tools/testing/selftests/kvm/lib/arm64/ucall.c      |    12 +-
 tools/testing/selftests/kvm/lib/arm64/vgic.c       |    40 +-
 tools/testing/selftests/kvm/lib/elf.c              |    19 +-
 tools/testing/selftests/kvm/lib/guest_modes.c      |     2 +-
 tools/testing/selftests/kvm/lib/guest_sprintf.c    |    18 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |   377 +-
 .../selftests/kvm/lib/loongarch/processor.c        |   110 +-
 tools/testing/selftests/kvm/lib/loongarch/ucall.c  |    12 +-
 tools/testing/selftests/kvm/lib/memstress.c        |    38 +-
 tools/testing/selftests/kvm/lib/riscv/processor.c  |    91 +-
 .../selftests/kvm/lib/s390/diag318_test_handler.c  |    12 +-
 tools/testing/selftests/kvm/lib/s390/facility.c    |     2 +-
 tools/testing/selftests/kvm/lib/s390/processor.c   |    65 +-
 tools/testing/selftests/kvm/lib/sparsebit.c        |    18 +-
 tools/testing/selftests/kvm/lib/test_util.c        |    30 +-
 tools/testing/selftests/kvm/lib/ucall_common.c     |    34 +-
 tools/testing/selftests/kvm/lib/userfaultfd_util.c |    14 +-
 tools/testing/selftests/kvm/lib/x86/apic.c         |     2 +-
 tools/testing/selftests/kvm/lib/x86/hyperv.c       |    14 +-
 tools/testing/selftests/kvm/lib/x86/memstress.c    |    14 +-
 tools/testing/selftests/kvm/lib/x86/pmu.c          |     8 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    |   292 +-
 tools/testing/selftests/kvm/lib/x86/sev.c          |    20 +-
 tools/testing/selftests/kvm/lib/x86/svm.c          |    16 +-
 tools/testing/selftests/kvm/lib/x86/ucall.c        |     4 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          |    44 +-
 tools/testing/selftests/kvm/loongarch/arch_timer.c |    28 +-
 tools/testing/selftests/kvm/loongarch/pmu_test.c   |    10 +-
 .../kvm/memslot_modification_stress_test.c         |    10 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    |   164 +-
 tools/testing/selftests/kvm/mmu_stress_test.c      |    28 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  |    12 +-
 tools/testing/selftests/kvm/riscv/arch_timer.c     |     8 +-
 tools/testing/selftests/kvm/riscv/ebreak_test.c    |     6 +-
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |     4 +-
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |     8 +-
 tools/testing/selftests/kvm/s390/debug_test.c      |     8 +-
 tools/testing/selftests/kvm/s390/irq_routing.c     |     2 +-
 tools/testing/selftests/kvm/s390/memop.c           |    94 +-
 tools/testing/selftests/kvm/s390/resets.c          |     6 +-
 .../selftests/kvm/s390/shared_zeropage_test.c      |     2 +-
 tools/testing/selftests/kvm/s390/tprot.c           |    24 +-
 tools/testing/selftests/kvm/s390/ucontrol_test.c   |     8 +-
 .../testing/selftests/kvm/set_memory_region_test.c |    40 +-
 tools/testing/selftests/kvm/steal_time.c           |    81 +-
 .../selftests/kvm/system_counter_offset_test.c     |    12 +-
 tools/testing/selftests/kvm/x86/amx_test.c         |    14 +-
 tools/testing/selftests/kvm/x86/aperfmperf_test.c  |    16 +-
 .../selftests/kvm/x86/apic_bus_clock_test.c        |    28 +-
 tools/testing/selftests/kvm/x86/cpuid_test.c       |     6 +-
 tools/testing/selftests/kvm/x86/debug_regs.c       |     4 +-
 .../kvm/x86/dirty_log_page_splitting_test.c        |    16 +-
 .../selftests/kvm/x86/evmcs_smm_controls_test.c    |     6 +-
 tools/testing/selftests/kvm/x86/fastops_test.c     |    52 +-
 .../testing/selftests/kvm/x86/feature_msrs_test.c  |    12 +-
 .../testing/selftests/kvm/x86/fix_hypercall_test.c |    20 +-
 tools/testing/selftests/kvm/x86/flds_emulation.h   |     6 +-
 tools/testing/selftests/kvm/x86/hwcr_msr_test.c    |    10 +-
 tools/testing/selftests/kvm/x86/hyperv_clock.c     |     6 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |    10 +-
 .../selftests/kvm/x86/hyperv_extended_hypercalls.c |    20 +-
 tools/testing/selftests/kvm/x86/hyperv_features.c  |    26 +-
 tools/testing/selftests/kvm/x86/hyperv_ipi.c       |    12 +-
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c  |    10 +-
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c |    36 +-
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c |     2 +-
 tools/testing/selftests/kvm/x86/kvm_clock_test.c   |    14 +-
 tools/testing/selftests/kvm/x86/kvm_pv_test.c      |    10 +-
 .../testing/selftests/kvm/x86/monitor_mwait_test.c |     2 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c      |     2 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c      |    10 +-
 .../selftests/kvm/x86/nested_emulation_test.c      |    20 +-
 .../selftests/kvm/x86/nested_exceptions_test.c     |     6 +-
 .../selftests/kvm/x86/nested_invalid_cr3_test.c    |     2 +-
 .../selftests/kvm/x86/nested_set_state_test.c      |     4 +-
 .../selftests/kvm/x86/nested_tsc_adjust_test.c     |    12 +-
 .../selftests/kvm/x86/nested_tsc_scaling_test.c    |    24 +-
 .../selftests/kvm/x86/nested_vmsave_vmload_test.c  |     2 +-
 .../testing/selftests/kvm/x86/nx_huge_pages_test.c |    18 +-
 .../testing/selftests/kvm/x86/platform_info_test.c |     6 +-
 .../testing/selftests/kvm/x86/pmu_counters_test.c  |   109 +-
 .../selftests/kvm/x86/pmu_event_filter_test.c      |   102 +-
 .../kvm/x86/private_mem_conversions_test.c         |    78 +-
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c |    14 +-
 tools/testing/selftests/kvm/x86/set_boot_cpu_id.c  |     6 +-
 tools/testing/selftests/kvm/x86/set_sregs_test.c   |     6 +-
 tools/testing/selftests/kvm/x86/sev_init2_tests.c  |     6 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |    22 +-
 .../kvm/x86/smaller_maxphyaddr_emulation_test.c    |     8 +-
 tools/testing/selftests/kvm/x86/smm_test.c         |     8 +-
 tools/testing/selftests/kvm/x86/state_test.c       |    14 +-
 tools/testing/selftests/kvm/x86/svm_int_ctl_test.c |     2 +-
 .../selftests/kvm/x86/svm_lbr_nested_state.c       |     2 +-
 .../selftests/kvm/x86/svm_nested_clear_efer_svme.c |     2 +-
 .../selftests/kvm/x86/svm_nested_shutdown_test.c   |     2 +-
 .../kvm/x86/svm_nested_soft_inject_test.c          |    10 +-
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c      |    14 +-
 tools/testing/selftests/kvm/x86/svm_vmcall_test.c  |     2 +-
 tools/testing/selftests/kvm/x86/sync_regs_test.c   |     2 +-
 .../selftests/kvm/x86/triple_fault_event_test.c    |     4 +-
 tools/testing/selftests/kvm/x86/tsc_msrs_test.c    |     2 +-
 tools/testing/selftests/kvm/x86/tsc_scaling_sync.c |     4 +-
 .../selftests/kvm/x86/ucna_injection_test.c        |    45 +-
 .../testing/selftests/kvm/x86/userspace_io_test.c  |     4 +-
 .../selftests/kvm/x86/userspace_msr_exit_test.c    |    58 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c       |     4 +-
 .../selftests/kvm/x86/vmx_apicv_updates_test.c     |     4 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c       |     2 +-
 tools/testing/selftests/kvm/x86/vmx_msrs_test.c    |    22 +-
 .../selftests/kvm/x86/vmx_nested_la57_state_test.c |     4 +-
 .../testing/selftests/kvm/x86/vmx_pmu_caps_test.c  |    12 +-
 .../selftests/kvm/x86/vmx_preemption_timer_test.c  |     2 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c   |    64 +-
 tools/testing/selftests/kvm/x86/xapic_state_test.c |    20 +-
 tools/testing/selftests/kvm/x86/xapic_tpr_test.c   |    24 +-
 tools/testing/selftests/kvm/x86/xcr0_cpuid_test.c  |     8 +-
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c  |    22 +-
 tools/testing/selftests/kvm/x86/xss_msr_test.c     |     2 +-
 tools/testing/selftests/mm/config                  |     1 +
 tools/testing/selftests/mm/hmm-tests.c             |    50 +
 tools/testing/selftests/mm/run_vmtests.sh          |     2 +-
 tools/testing/selftests/net/Makefile               |     1 +
 .../selftests/net/forwarding/bridge_vlan_mcast.sh  |    30 +-
 tools/testing/selftests/net/lib/xdp_native.bpf.c   |    55 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |     6 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |    31 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |    26 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |    20 +-
 .../selftests/net/openvswitch/openvswitch.sh       |    37 +
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |    19 +-
 .../selftests/net/ovpn/test-close-socket.sh        |     2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      |     6 +-
 tools/testing/selftests/net/ovpn/test.sh           |     8 +-
 tools/testing/selftests/net/rds/config             |     1 +
 tools/testing/selftests/net/tcp_ecmp_failover.sh   |   216 +
 tools/testing/selftests/net/tls.c                  |    43 +
 tools/testing/selftests/rdma/rxe_ipv6.sh           |     6 +-
 .../selftests/rdma/rxe_rping_between_netns.sh      |     7 +
 .../selftests/rdma/rxe_socket_with_netns.sh        |     6 +
 .../selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh   |     6 +-
 tools/testing/selftests/rseq/Makefile              |    21 +-
 tools/testing/selftests/rseq/check_optimized.c     |    17 +
 tools/testing/selftests/rseq/legacy_check.c        |    65 +
 tools/testing/selftests/rseq/param_test.c          |    25 +-
 tools/testing/selftests/rseq/rseq-abi.h            |     7 +-
 tools/testing/selftests/rseq/rseq.c                |    39 +-
 tools/testing/selftests/rseq/rseq.h                |     8 +-
 tools/testing/selftests/rseq/run_legacy_check.sh   |     4 +
 tools/testing/selftests/rseq/run_param_test.sh     |    39 +
 tools/testing/selftests/rseq/run_timeslice_test.sh |    14 +
 tools/testing/selftests/rseq/slice_test.c          |    12 +-
 tools/testing/selftests/sched_ext/Makefile         |     1 +
 tools/testing/selftests/sched_ext/dequeue.c        |     1 +
 .../selftests/sched_ext/non_scx_kfunc_deny.bpf.c   |    44 +
 .../selftests/sched_ext/non_scx_kfunc_deny.c       |    47 +
 .../tc-testing/tc-tests/infra/qdiscs.json          |   189 +
 .../tc-testing/tc-tests/qdiscs/taprio.json         |    26 +
 tools/testing/selftests/ublk/kublk.c               |    11 +
 tools/testing/vma/include/dup.h                    |     2 +-
 tools/testing/vma/include/stubs.h                  |     3 +-
 virt/kvm/dirty_ring.c                              |     3 +-
 3781 files changed, 275133 insertions(+), 45020 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-ivpu
 rename Documentation/ABI/{obsolete =3D> removed}/sysfs-selinux-user (100%)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ivpu
 create mode 100644
Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml
 create mode 100644 Documentation/gpu/amdgpu/ptl.rst
 create mode 100644 Documentation/gpu/intel-display/async-flip.rst
 create mode 100644 Documentation/gpu/intel-display/atomic.rst
 create mode 100644 Documentation/gpu/intel-display/audio.rst
 create mode 100644 Documentation/gpu/intel-display/casf.rst
 create mode 100644 Documentation/gpu/intel-display/cdclk.rst
 create mode 100644 Documentation/gpu/intel-display/cmtg.rst
 create mode 100644 Documentation/gpu/intel-display/dmc.rst
 create mode 100644 Documentation/gpu/intel-display/dpio.rst
 create mode 100644 Documentation/gpu/intel-display/dpll.rst
 create mode 100644 Documentation/gpu/intel-display/drrs.rst
 create mode 100644 Documentation/gpu/intel-display/dsb.rst
 create mode 100644 Documentation/gpu/intel-display/fbc.rst
 create mode 100644 Documentation/gpu/intel-display/fifo-underrun.rst
 create mode 100644 Documentation/gpu/intel-display/frontbuffer.rst
 create mode 100644 Documentation/gpu/intel-display/hotplug.rst
 create mode 100644 Documentation/gpu/intel-display/index.rst
 create mode 100644 Documentation/gpu/intel-display/plane.rst
 create mode 100644 Documentation/gpu/intel-display/psr.rst
 create mode 100644 Documentation/gpu/intel-display/snps-phy.rst
 create mode 100644 Documentation/gpu/intel-display/vbt.rst
 create mode 100644 Documentation/gpu/xe/xe_gt_stats.rst
 create mode 100644
Documentation/networking/device_drivers/ethernet/3com/3c509.rst
 create mode 100644 Documentation/process/threat-model.rst
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 arch/x86/entry/common.c
 create mode 100644 drivers/accel/amdxdna/aie.c
 create mode 100644 drivers/accel/amdxdna/aie.h
 delete mode 100644 drivers/accel/amdxdna/aie2_psp.c
 delete mode 100644 drivers/accel/amdxdna/aie2_smu.c
 create mode 100644 drivers/accel/amdxdna/aie4_ctx.c
 create mode 100644 drivers/accel/amdxdna/aie4_host_queue.h
 create mode 100644 drivers/accel/amdxdna/aie4_message.c
 create mode 100644 drivers/accel/amdxdna/aie4_msg_priv.h
 create mode 100644 drivers/accel/amdxdna/aie4_pci.c
 create mode 100644 drivers/accel/amdxdna/aie4_pci.h
 create mode 100644 drivers/accel/amdxdna/aie4_sriov.c
 create mode 100644 drivers/accel/amdxdna/aie_psp.c
 create mode 100644 drivers/accel/amdxdna/aie_smu.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_cbuf.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_cbuf.h
 create mode 100644 drivers/accel/amdxdna/amdxdna_debugfs.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_debugfs.h
 create mode 100644 drivers/accel/amdxdna/npu3_regs.c
 create mode 100644 drivers/dma-buf/.kunitconfig
 delete mode 100644 drivers/dma-buf/selftest.c
 delete mode 100644 drivers/dma-buf/selftest.h
 delete mode 100644 drivers/dma-buf/selftests.h
 delete mode 100644 drivers/firmware/efi/libstub/relocate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfi=
g
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
 create mode 100644
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/README.md
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_b=
b.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/l=
ib_frl_cap_check.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/l=
ib_frl_cap_check.h
 delete mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq=
.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.=
c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.=
h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_=
frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_=
frl.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_color_types=
.h
 create mode 100644
drivers/gpu/drm/amd/display/modules/inc/mod_info_packet_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_power.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_abm.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_replay.=
c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ptl.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_off=
set.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_m=
ask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offse=
t.h
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_ma=
sk.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_3_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_3_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_sh_m=
ask.h
 delete mode 100644 drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c
 create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fix=
up.c
 create mode 100644
drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
 create mode 100644 drivers/gpu/drm/bridge/of-display-mode-bridge.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_display_clock_gating=
.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_display_clock_gating=
.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_dpcd.h
 delete mode 100644 drivers/gpu/drm/i915/display/intel_fb_pin.c
 delete mode 100644 drivers/gpu/drm/i915/display/intel_fb_pin.h
 delete mode 100644 drivers/gpu/drm/i915/display/intel_fbdev_fb.c
 delete mode 100644 drivers/gpu/drm/i915/display/intel_fbdev_fb.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_mchbar.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_mchbar.h
 create mode 100644 drivers/gpu/drm/i915/i915_fb_pin.c
 create mode 100644 drivers/gpu/drm/i915/i915_fb_pin.h
 create mode 100644 drivers/gpu/drm/imagination/pvr_trace.h
 create mode 100644 drivers/gpu/drm/imagination/pvr_trace_points.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_2_milos.h
 delete mode 100644 drivers/gpu/drm/msm/msm_perf.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.xml
 create mode 100644 drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
 create mode 100644 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt35532.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_fw_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_mmu_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_pwr_regs.h
 delete mode 100644 drivers/gpu/drm/panthor/panthor_regs.h
 create mode 100644 drivers/gpu/drm/scheduler/sched_rq.c
 create mode 100644 drivers/gpu/drm/scheduler/tests/tests_scheduler.c
 rename drivers/gpu/drm/tests/{drm_atomic_state_test.c =3D>
drm_atomic_commit_test.c} (98%)
 create mode 100644 drivers/gpu/drm/v3d/v3d_power.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
 rename drivers/gpu/drm/xe/{xe_uc_fw_abi.h =3D> abi/uc_fw_abi.h} (99%)
 create mode 100644 drivers/gpu/drm/xe/abi/xe_sysctrl_abi.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/intel_mchbar_reg=
s.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/intel_pci_config=
.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/intel_step.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/vlv_iosf_sb.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/vlv_iosf_sb_reg.=
h
 delete mode 100644 drivers/gpu/drm/xe/display/intel_fbdev_fb.c
 create mode 100644 drivers/gpu/drm/xe/display/xe_fb_pin.h
 create mode 100644 drivers/gpu/drm/xe/regs/xe_sysctrl_regs.h
 create mode 100644 drivers/gpu/drm/xe/tests/xe_rtp.c
 create mode 100644 drivers/gpu/drm/xe/tests/xe_rtp_test.h
 create mode 100644 drivers/gpu/drm/xe/xe_mem_pool.c
 create mode 100644 drivers/gpu/drm/xe/xe_mem_pool.h
 create mode 100644 drivers/gpu/drm/xe/xe_mem_pool_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_ras.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.h
 create mode 100644 drivers/gpu/drm/xe/xe_ras_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_event.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_event_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_types.h
 create mode 100644 drivers/gpu/nova-core/falcon/fsp.rs
 create mode 100644 drivers/gpu/nova-core/fb/hal/gb100.rs
 create mode 100644 drivers/gpu/nova-core/fb/hal/gb202.rs
 create mode 100644 drivers/gpu/nova-core/fb/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/firmware/fsp.rs
 create mode 100644 drivers/gpu/nova-core/fsp.rs
 create mode 100644 drivers/gpu/nova-core/fsp/hal.rs
 create mode 100644 drivers/gpu/nova-core/fsp/hal/gb100.rs
 create mode 100644 drivers/gpu/nova-core/fsp/hal/gb202.rs
 create mode 100644 drivers/gpu/nova-core/fsp/hal/gh100.rs
 delete mode 100644 drivers/gpu/nova-core/gfw.rs
 create mode 100644 drivers/gpu/nova-core/gpu/hal.rs
 create mode 100644 drivers/gpu/nova-core/gpu/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/gpu/hal/tu102.rs
 create mode 100644 drivers/gpu/nova-core/gsp/hal.rs
 create mode 100644 drivers/gpu/nova-core/gsp/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/gsp/hal/tu102.rs
 create mode 100644 drivers/gpu/nova-core/mctp.rs
 delete mode 100644 drivers/mailbox/mailbox.h
 create mode 100644 drivers/net/ethernet/3com/3c509.c
 delete mode 100644 drivers/platform/x86/lenovo/wmi-gamezone.h
 delete mode 100644 drivers/platform/x86/lenovo/wmi-other.h
 create mode 100644 fs/afs/symlink.c
 delete mode 100644 fs/smb/smbdirect/smbdirect.h
 create mode 100644 include/asm-generic/ring_buffer.h
 delete mode 100644 include/drm/bridge/imx.h
 create mode 100644 include/drm/bridge/of-display-mode-bridge.h
 rename drivers/gpu/drm/i915/intel_mchbar_regs.h =3D>
include/drm/intel/mchbar_regs.h (98%)
 rename drivers/gpu/drm/i915/intel_pci_config.h =3D>
include/drm/intel/pci_config.h (100%)
 rename drivers/gpu/drm/i915/vlv_iosf_sb_reg.h =3D>
include/drm/intel/vlv_iosf_sb_regs.h (95%)
 rename fs/smb/smbdirect/public.h =3D> include/linux/smbdirect.h (76%)
 create mode 100644 rust/helpers/drm_gpuvm.c
 create mode 100644 rust/kernel/drm/gpuvm/mod.rs
 create mode 100644 rust/kernel/drm/gpuvm/sm_ops.rs
 create mode 100644 rust/kernel/drm/gpuvm/va.rs
 create mode 100644 rust/kernel/drm/gpuvm/vm_bo.rs
 create mode 100644 tools/perf/trace/beauty/fsmount_attr.sh
 create mode 100644
tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_call_large_i=
mm.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
 create mode 100755 tools/testing/selftests/net/tcp_ecmp_failover.sh
 create mode 100644 tools/testing/selftests/rseq/check_optimized.c
 create mode 100644 tools/testing/selftests/rseq/legacy_check.c
 create mode 100755 tools/testing/selftests/rseq/run_legacy_check.sh
 create mode 100755 tools/testing/selftests/rseq/run_timeslice_test.sh
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bp=
f.c
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.c
