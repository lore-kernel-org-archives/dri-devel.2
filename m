Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B8FFA0C3F
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964D410E683;
	Wed, 15 Apr 2026 07:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bR5h+f1a";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294A010E10D
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 06:42:53 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cbb6d5f780so570009785a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 23:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776235372; cv=none;
 d=google.com; s=arc-20240605;
 b=ZtkFWRY9rjIJ048AZqaPuGUJvil2KArlLgLm9/nFs/lTgMZVXeIz/TH6nxRJBo411n
 q4l6uyBe7Ry+enBvX61A1Yu5NcQ3gJM5uGPOp11fGfi2r9G9ZxHeGpUq2Mv50RTaUl4I
 IUvp6J6NTUxycoAptUorE4ylI25PElplF0GyTHXuzmmuQSTOMsKiEHeOlAtWH9rYNDpp
 O04iTyrEU5yQwmP/np93pH6Rmn9UBEJiAfQUqPfTVHKFDDyVAHqoqQWQmXVpT3TPleYW
 V75dP5euK/of/YiXYbMOctXVvZvD2WKtojBxS5pzO0qzEAkBs22UUOMyh/Sizm+iEuTv
 kGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=6gjKH4nf3k6Hak9nCU3fkzVDDowkBGuP499qapRl+ro=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=iepvcjTcETuwCNzfp02SQALDSw9gKx+hPImyrEIqfqfs5KtKsbSMUrHdepeGY4Bq/V
 QVfUxHpm33bLRorb/+Q4GQwp1b1BUAR8C3BJxdtygJB1cErnJt8ggyNCR7E+h6BIOfF6
 YVmit+m1GUYn1nDTGo7X1tKevvexTJaXUV7bhQqOHsAts2rDAqEanrMkjtlNFJW9UTsz
 TPr4AK31Xu9tmHmkmEPC+uNFZcmBAOSUT19tUReCX2y/49VIBTxsOweNNaeIgtDTytMy
 YiYCNHMsHc8Ojo4pmG4IcDc9c1UEdsJEoq4hW+g5+GqQS3R9gwS87IcFaW53T1f5hOtR
 jYAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776235372; x=1776840172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6gjKH4nf3k6Hak9nCU3fkzVDDowkBGuP499qapRl+ro=;
 b=bR5h+f1asbnfhqrzLDM4Zl/UcIKB1bxR3nkNMZe70XrE1mlASmcnWql5R992xvoX8y
 PWnLyAL1HXIMBNROl1tc9NlWifpMbszjxcaR1VMiy3FY/UkCEa6BObE8fyCV7iLCDs0d
 aKDo1gFHDRI55xn27/U0g+b07oYSv1O6/EBvfpPj8M0KI4BKSWFIUZcEhiz2J0bHcNOo
 gJj5vLe3AVRivjgmeNGiLUPy/fVdIhcDow/K54ADabzsmvvo0/ePbgsjOQXTFWRpXpRI
 AilBM1MyXKSk2HiFxtHVtTwDT0yvTzgLkRI3bs9qTrX6u/ptlxYa2Gulkh/15CoJH04S
 1InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776235372; x=1776840172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gjKH4nf3k6Hak9nCU3fkzVDDowkBGuP499qapRl+ro=;
 b=AxGupwLqqVYxcjLGNXlbVGh7hW0RrKkc+2ScFiHTTg+HGBfKXxNY1oBs6W7PdsNv7h
 wDO30agYOj+HyC6pDKQZsinunZXreVhJPqUqgc+zIvFvdUzW6HkUhGMcyn7zBJI3kQvI
 UsU9jrYe714uYhCljWvxoUa6Ot5sV3CDx+QtkbZ1DfebYpxcpX6PYOiMSp4D4Hrpq5nK
 o6LmcdA6/bor1CXZKoumnSe/WiNncn/EMvDC9h6wcj+KDfQf2ivlDkph9xhoJGLC4dtg
 fM0VGAsrNIaDv47R+6Rm00rHAJokqB8n6hO5q026m49ZFsMOShJc5aJYAdifejttMbaW
 1wDg==
X-Gm-Message-State: AOJu0YxaViXkMQuu5zo/2sLA64deRbTUWt+ikx9Mfftwd1FWxHz+CPMr
 pEBzHvFmCrYkZ2DNxKca68/nMd5TfYCAocvWDfgWEiJnW8fvTVPNquG0rn7xgBPJPUq/QoQuTSb
 CL5UMa8NA/c+EE4jxd5RoE3x53gLzTN0=
X-Gm-Gg: AeBDieu0gekX2l8sYLAVaIjNqI3U+9XCmpBvGNuzqvmvjoKFUvIF1Vs7zkCqmiMgy/2
 +PmwinaUu9+otaxE6UdkJekItKkLdhdRo5KHrBZDwAJXS8Pampo2Tnr26p64oRo7FAABOmYmdIa
 W5gfBJ2ncUS+yecenMqpKQeN35m30fqeT6mTLNQBy+8dut0DVZYrN6t6StH9FmBe/XmaHEi+8fH
 TS7+pnjee8Up8YodbM/a0U/veo14mjCMYk+UPFupOIe+8hk6fQyW35U4LZuMveDbdMoIIr0iiPg
 j4j/MTcPg3qi4muRb/Dor77bTbsseGdLXfl2L3oGU1lisRh53T7lDNLuU9tcRJbFh/k=
X-Received: by 2002:a05:620a:f02:b0:8d5:bb98:f3f6 with SMTP id
 af79cd13be357-8ddd03a5875mr3129787785a.59.1776235370860; Tue, 14 Apr 2026
 23:42:50 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 15 Apr 2026 16:42:38 +1000
X-Gm-Features: AQROBzDK3nUw2HJV5vT9DleDfv-sx31l15EP_TJxAX7o3mVqvUf4lVolezBNO-E
Message-ID: <CAPM=9tyvKEU6-6O=Le9wVjTJqd3NdrUr-pA_eHxt3Bj-Cv7zMw@mail.gmail.com>
Subject: [git pull] drm for 7.1
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 15 Apr 2026 07:14:48 +0000
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

This is the main drm pull request for 7.1-rc1.

I found two conflicts when testing the merge: one in Rust core and one
in Tyr, but both were trivial to solve.

This has a fixed tree shared with driver-core tree in it, which Danilo
will send later.

Outside of drm:
- mm: adding new statistics for GPU memory usage tracking and an
EXPORT addition.
- mm: mmu notifier addition for two-pass internal notifiers
- math.h change to allow DIV_ROUND_CLOSEST to be used in uapi facing pieces=
.
- core rust changes for nova-core/tyr

Highlights:
- new DRM RAS infrastructure using netlink
- amdgpu: enable DC on CIK APUs, and more IP enablement, and more user
queue work
- xe: purgeable BO support, and new hw enablement
- dma-buf : add revocable operations

Let me know if there any problems, or some other conflict shows up I
missed here,

Regards,
Dave.

drm-next-2026-04-15:
drm for v7.1-rc1

mm:
- two pass MMU interval notifiers
- add gpu active/reclaim per-node stat counters

math:
- provide __KERNEL_DIV_ROUND_CLOSEST() in UAPI
- implement DIV_ROUND_CLOSEST() with __KERNEL_DIV_ROUND_CLOSEST()

rust:
- shared tag with driver-core: register macro and io infra
- core: rework DMA coherent API
- core: add interop::list to interop with C linked lists
- core: add more num::Bounded operations
- core: enable generic_arg_infer and add EMSGSIZE
- workqueue: add ARef<T> support for work and delayed work
- add GPU buddy allocator abstraction
- add DRM shmem GEM helper abstraction
- allow drm:::Device to dispatch work and delayed work items
  to driver private data
- add dma_resv_lock helper and raw accessors

core:
- introduce DRM RAS infrastructure over netlink
- add connector panel_type property
- fourcc: add ARM interleaved 64k modifier
- colorop: add destroy helper
- suballoc: split into alloc and init helpers
- mode: provide DRM_ARGB_GET*() macros for reading color components

edid:
- provide drm_output_color_Format

dma-buf:
- provide revoke mechanism for shared buffers
- rename move_notify to invalidate_mappings
- always enable move_notify
- protect dma_fence_ops with RCU and improve locking
- clean pages with helpers

atomic:
- allocate drm_private_state via callback
- helper: use system_percpu_wq

buddy:
- make buddy allocator available to gpu level
- add kernel-doc for buddy allocator
- improve aligned allocation

ttm:
- fix fence signalling
- improve tests and docs
- improve handling of gfp_retry_mayfail
- use per-node stat counters to track memory allocations
- port pool to use list_lru
- drop NUMA specific pools
- make pool shrinker numa aware
- track allocated pages per numa node

coreboot:
- cleanup coreboot framebuffer support

sched:
- fix race condition in drm_sched_fini

pagemap:
- enable THP support
- pass pagemap_addr by reference

gem-shmem:
- Track page accessed/dirty status across mmap/vmap

gpusvm:
- reenable device to device migration
- fix unbalanced unclock

bridge:
- anx7625: Support USB-C plus DT bindings
- connector: Fix EDID detection
- dw-hdmi-qp: Support Vendor-Specfic and SDP Infoframes; improve others
- fsl-ldb: Fix visual artifacts plus related DT property
'enable-termination-resistor'
- imx8qxp-pixel-link: Improve bridge reference handling
- lt9611: Support Port-B-only input plus DT bindings
- tda998x: Support DRM_BRIDGE_ATTACH_NO_CONNECTOR; Clean up
- Support TH1520 HDMI plus DT bindings
- waveshare-dsi: Fix register and attach; Support 1..4 DSI lanes plus
DT bindings
- anx7625: Fix USB Type-C handling
- cdns-mhdp8546-core: Handle HDCP state in bridge atomic_check
- Support Lontium LT8713SX DP MST bridge plus DT bindings
- analogix_dp: Use DP helpers for link training

panel:
- panel-jdi-lt070me05000: Use mipi-dsi multi functions
- panel-edp: Support Add AUO B116XAT04.1 (HW: 1A); Support CMN
N116BCL-EAK (C2); Support FriendlyELEC plus DT changes
- panel-edp: Fix timings for BOE NV140WUM-N64
- ilitek-ili9882t: Allow GPIO calls to sleep
- jadard: Support TAIGUAN XTI05101-01A
- lxd: Support LXD M9189A plus DT bindings
- mantix: Fix pixel clock; Clean up
- motorola: Support Motorola Atrix 4G and Droid X2 plus DT bindings
- novatek: Support Novatek/Tianma NT37700F plus DT bindings
- simple: Support EDT ET057023UDBA plus DT bindings; Support Powertip
  PH800480T032-ZHC19 plus DT bindings; Support Waveshare 13.3"
- novatek-nt36672a: Use mipi_dsi_*_multi() functions
- panel-edp: Support BOE NV153WUM-N42, CMN N153JCA-ELK, CSW MNF307QS3-2
- support Himax HX83121A plus DT bindings
- support JuTouch JT070TM041 plus DT bindings
- support Samsung S6E8FC0 plus DT bindings
- himax-hx83102c: support Samsung S6E8FC0 plus DT bindings; support backlig=
ht
- ili9806e: support Rocktech RK050HR345-CT106A plus DT bindings
- simple: support Tianma TM050RDH03 plus DT bindings

amdgpu:
- enable DC by default on CIK APUs
- userq fence ioctl param size fixes
- set panel_type to OLED for eDP
- refactor DC i2c code
- FAMS2 update
- rework ttm handling to allow multiple engines
- DC DCE 6.x cleanup
- DC support for NUTMEG/TRAVIS DP bridge
- DCN 4.2 support
- GC12 idle power fix for compute
- use struct drm_edid in non-DC code
- enable NV12/P010 support on primary planes
- support newer IP discovery tables
- VCN/JPEG 5.0.2 support
- GC/MES 12.1 updates
- USERQ fixes
- add DC idle state manager
- eDP DSC seamless boot

amdkfd:
- GC 12.1 updates
- non 4K page fixes

xe:
- basic Xe3p_LPG and NVL-P enabling patches
- allow VM_BIND decompress support
- add purgeable buffer object support
- add xe_vm_get_property_ioctl
- restrict multi-lrc to VCS/VECS engines
- allow disabling VM overcommit in fault mode
- dGPU memory optimizations
- Workaround cleanups and simplification
- Allow VFs VRAM quote changes using sysfs
- convert GT stats to per-cpu counters
- pagefault refactors
- enable multi-queue on xe3p_xpc
- disable DCC on PTL
- make MMIO communication more robust
- disable D3Cold for BMG on specific platforms
- vfio: improve FLR sync for Xe VFIO

i915/display:
- C10/C20/LT PHY PLL divider verification
- use trans push mechanism to generate PSR frame change on LNL+
- refactor DP DSC slice config
- VGA decode refactoring
- refactor DPT, gen2-4 overlay, masked field register macro helpers
- refactor stolen memory allocation decisions
- prepare for UHBR DP tunnels
- refactor LT PHY PLL to use DPLL framework
- implement register polling/waiting in display code
- add shared stepping header between i915 and display

i915:
- fix potential overflow of shmem scatterlist length

nouveau:
- provide Z cull info to userspace
- initial GA100 support
- shutdown on PCI device shutdown

nova-core:
- harden GSP command queue
- add support for large RPCs
- simplify GSP sequencer and message handling
- refactor falcon firmware handling
- convert to new register macro
- conver to new DMA coherent API
- use checked arithmetic
- add debugfs support for gsp-rm log buffers
- fix aux device registration for multi-GPU

msm:
- CI:
  - Uprev mesa
  - Restore CI jobs for Qualcomm APQ8016 and APQ8096 devices
- Core:
  - Switched to of_get_available_child_by_name()
- DPU:
  - Fixes for DSC panels
  - Fixed brownout because of the frequency / OPP mismatch
  - Quad pipe preparation (not enabled yet)
  - Switched to virtual planes by default
  - Dropped VBIF_NRT support
  - Added support for Eliza platform
  - Reworked alpha handling
  - Switched to correct CWB definitions on Eliza
  - Dropped dummy INTF_0 on MSM8953
  - Corrected INTFs related to DP-MST
- DP:
  - Removed debug prints looking into PHY internals
- DSI:
  - Fixes for DSC panels
  - RGB101010 support
  - Support for SC8280XP
  - Moved PHY bindings from display/ to phy/
- GPU:
  - Preemption support for x2-85 and a840
  - IFPC support for a840
  - SKU detection support for x2-85 and a840
  - Expose AQE support (VK ray-pipeline)
  - Avoid locking in VM_BIND fence signaling path
  - Fix to avoid reclaim in GPU snapshot path
  - Disallow foreign mapping of _NO_SHARE BOs
- HDMI:
  - Fixed infoframes programming
- MDP5:
  - Dropped support for MSM8974v1
  - Dropped now unused code for MSM8974 v1 and SDM660 / MSM8998

panthor:
- add tracepoints for power and IRQs
- fix fence handling
- extend timestamp query with flags
- support various sources for timestamp queries

tyr:
- fix names and model/versions

rockchip:
- vop2: use drm logging function
- rk3576 displayport support
- support CRTC background color

atmel-hlcdc:
- support sana5d65 LCD controller

tilcdc:
- use DT bindings schema
- use managed DRM interfaces
- support DRM_BRIDGE_ATTACH_NO_CONNECTOR

verisilicon:
- support DC8200 + DT bindings

virtgpu:
- support PRIME import with 3D enabled

komeda:
- fix integer overflow in AFBC checks

mcde:
- improve bridge handling

gma500:
- use drm client buffer for fbdev framebuffer

amdxdna:
- add sensors ioctls
- provide NPU power estimate
- support column utilization sensor
- allow forcing DMA through IOMMU IOVA
- support per-BO mem usage queries
- refactor GEM implementation

ivpu:
- update boot API to v3.29.4
- limit per-user number of doorbells/contexts
- perform engine reset on TDR error

loongson:
- replace custom code with drm_gem_ttm_dumb_map_offset()

imx:
- support planes behind the primary plane
- fix bus-format selection

vkms:
- support CRTC background color

v3d:
- improve handling of struct v3d_stats

komeda:
- support Arm China Linlon D6 plus DT bindings

imagination:
- improve power-off sequence
- support context-reset notification from firmware

mediatek:
- mtk_dsi: enable hs clock during pre-enable
- Remove all conflicting aperture devices during probe
- Add support for mt8167 display blocks
The following changes since commit 591cd656a1bf5ea94a222af5ef2ee76df029c1d2=
:

  Linux 7.0-rc7 (2026-04-05 15:26:23 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-04-15

for you to fetch changes up to 83e8d8bbffa8161e94f3aeee4dd09a35062a78c8:

  Merge tag 'drm-misc-next-fixes-2026-04-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2026-04-10 11:15:22 +1000)

----------------------------------------------------------------
drm for v7.1-rc1

mm:
- two pass MMU interval notifiers
- add gpu active/reclaim per-node stat counters

math:
- provide __KERNEL_DIV_ROUND_CLOSEST() in UAPI
- implement DIV_ROUND_CLOSEST() with __KERNEL_DIV_ROUND_CLOSEST()

rust:
- shared tag with driver-core: register macro and io infra
- core: rework DMA coherent API
- core: add interop::list to interop with C linked lists
- core: add more num::Bounded operations
- core: enable generic_arg_infer and add EMSGSIZE
- workqueue: add ARef<T> support for work and delayed work
- add GPU buddy allocator abstraction
- add DRM shmem GEM helper abstraction
- allow drm:::Device to dispatch work and delayed work items
  to driver private data
- add dma_resv_lock helper and raw accessors

core:
- introduce DRM RAS infrastructure over netlink
- add connector panel_type property
- fourcc: add ARM interleaved 64k modifier
- colorop: add destroy helper
- suballoc: split into alloc and init helpers
- mode: provide DRM_ARGB_GET*() macros for reading color components

edid:
- provide drm_output_color_Format

dma-buf:
- provide revoke mechanism for shared buffers
- rename move_notify to invalidate_mappings
- always enable move_notify
- protect dma_fence_ops with RCU and improve locking
- clean pages with helpers

atomic:
- allocate drm_private_state via callback
- helper: use system_percpu_wq

buddy:
- make buddy allocator available to gpu level
- add kernel-doc for buddy allocator
- improve aligned allocation

ttm:
- fix fence signalling
- improve tests and docs
- improve handling of gfp_retry_mayfail
- use per-node stat counters to track memory allocations
- port pool to use list_lru
- drop NUMA specific pools
- make pool shrinker numa aware
- track allocated pages per numa node

coreboot:
- cleanup coreboot framebuffer support

sched:
- fix race condition in drm_sched_fini

pagemap:
- enable THP support
- pass pagemap_addr by reference

gem-shmem:
- Track page accessed/dirty status across mmap/vmap

gpusvm:
- reenable device to device migration
- fix unbalanced unclock

bridge:
- anx7625: Support USB-C plus DT bindings
- connector: Fix EDID detection
- dw-hdmi-qp: Support Vendor-Specfic and SDP Infoframes; improve others
- fsl-ldb: Fix visual artifacts plus related DT property
'enable-termination-resistor'
- imx8qxp-pixel-link: Improve bridge reference handling
- lt9611: Support Port-B-only input plus DT bindings
- tda998x: Support DRM_BRIDGE_ATTACH_NO_CONNECTOR; Clean up
- Support TH1520 HDMI plus DT bindings
- waveshare-dsi: Fix register and attach; Support 1..4 DSI lanes plus
DT bindings
- anx7625: Fix USB Type-C handling
- cdns-mhdp8546-core: Handle HDCP state in bridge atomic_check
- Support Lontium LT8713SX DP MST bridge plus DT bindings
- analogix_dp: Use DP helpers for link training

panel:
- panel-jdi-lt070me05000: Use mipi-dsi multi functions
- panel-edp: Support Add AUO B116XAT04.1 (HW: 1A); Support CMN
N116BCL-EAK (C2); Support FriendlyELEC plus DT changes
- panel-edp: Fix timings for BOE NV140WUM-N64
- ilitek-ili9882t: Allow GPIO calls to sleep
- jadard: Support TAIGUAN XTI05101-01A
- lxd: Support LXD M9189A plus DT bindings
- mantix: Fix pixel clock; Clean up
- motorola: Support Motorola Atrix 4G and Droid X2 plus DT bindings
- novatek: Support Novatek/Tianma NT37700F plus DT bindings
- simple: Support EDT ET057023UDBA plus DT bindings; Support Powertip
  PH800480T032-ZHC19 plus DT bindings; Support Waveshare 13.3"
- novatek-nt36672a: Use mipi_dsi_*_multi() functions
- panel-edp: Support BOE NV153WUM-N42, CMN N153JCA-ELK, CSW MNF307QS3-2
- support Himax HX83121A plus DT bindings
- support JuTouch JT070TM041 plus DT bindings
- support Samsung S6E8FC0 plus DT bindings
- himax-hx83102c: support Samsung S6E8FC0 plus DT bindings; support backlig=
ht
- ili9806e: support Rocktech RK050HR345-CT106A plus DT bindings
- simple: support Tianma TM050RDH03 plus DT bindings

amdgpu:
- enable DC by default on CIK APUs
- userq fence ioctl param size fixes
- set panel_type to OLED for eDP
- refactor DC i2c code
- FAMS2 update
- rework ttm handling to allow multiple engines
- DC DCE 6.x cleanup
- DC support for NUTMEG/TRAVIS DP bridge
- DCN 4.2 support
- GC12 idle power fix for compute
- use struct drm_edid in non-DC code
- enable NV12/P010 support on primary planes
- support newer IP discovery tables
- VCN/JPEG 5.0.2 support
- GC/MES 12.1 updates
- USERQ fixes
- add DC idle state manager
- eDP DSC seamless boot

amdkfd:
- GC 12.1 updates
- non 4K page fixes

xe:
- basic Xe3p_LPG and NVL-P enabling patches
- allow VM_BIND decompress support
- add purgeable buffer object support
- add xe_vm_get_property_ioctl
- restrict multi-lrc to VCS/VECS engines
- allow disabling VM overcommit in fault mode
- dGPU memory optimizations
- Workaround cleanups and simplification
- Allow VFs VRAM quote changes using sysfs
- convert GT stats to per-cpu counters
- pagefault refactors
- enable multi-queue on xe3p_xpc
- disable DCC on PTL
- make MMIO communication more robust
- disable D3Cold for BMG on specific platforms
- vfio: improve FLR sync for Xe VFIO

i915/display:
- C10/C20/LT PHY PLL divider verification
- use trans push mechanism to generate PSR frame change on LNL+
- refactor DP DSC slice config
- VGA decode refactoring
- refactor DPT, gen2-4 overlay, masked field register macro helpers
- refactor stolen memory allocation decisions
- prepare for UHBR DP tunnels
- refactor LT PHY PLL to use DPLL framework
- implement register polling/waiting in display code
- add shared stepping header between i915 and display

i915:
- fix potential overflow of shmem scatterlist length

nouveau:
- provide Z cull info to userspace
- initial GA100 support
- shutdown on PCI device shutdown

nova-core:
- harden GSP command queue
- add support for large RPCs
- simplify GSP sequencer and message handling
- refactor falcon firmware handling
- convert to new register macro
- conver to new DMA coherent API
- use checked arithmetic
- add debugfs support for gsp-rm log buffers
- fix aux device registration for multi-GPU

msm:
- CI:
  - Uprev mesa
  - Restore CI jobs for Qualcomm APQ8016 and APQ8096 devices
- Core:
  - Switched to of_get_available_child_by_name()
- DPU:
  - Fixes for DSC panels
  - Fixed brownout because of the frequency / OPP mismatch
  - Quad pipe preparation (not enabled yet)
  - Switched to virtual planes by default
  - Dropped VBIF_NRT support
  - Added support for Eliza platform
  - Reworked alpha handling
  - Switched to correct CWB definitions on Eliza
  - Dropped dummy INTF_0 on MSM8953
  - Corrected INTFs related to DP-MST
- DP:
  - Removed debug prints looking into PHY internals
- DSI:
  - Fixes for DSC panels
  - RGB101010 support
  - Support for SC8280XP
  - Moved PHY bindings from display/ to phy/
- GPU:
  - Preemption support for x2-85 and a840
  - IFPC support for a840
  - SKU detection support for x2-85 and a840
  - Expose AQE support (VK ray-pipeline)
  - Avoid locking in VM_BIND fence signaling path
  - Fix to avoid reclaim in GPU snapshot path
  - Disallow foreign mapping of _NO_SHARE BOs
- HDMI:
  - Fixed infoframes programming
- MDP5:
  - Dropped support for MSM8974v1
  - Dropped now unused code for MSM8974 v1 and SDM660 / MSM8998

panthor:
- add tracepoints for power and IRQs
- fix fence handling
- extend timestamp query with flags
- support various sources for timestamp queries

tyr:
- fix names and model/versions

rockchip:
- vop2: use drm logging function
- rk3576 displayport support
- support CRTC background color

atmel-hlcdc:
- support sana5d65 LCD controller

tilcdc:
- use DT bindings schema
- use managed DRM interfaces
- support DRM_BRIDGE_ATTACH_NO_CONNECTOR

verisilicon:
- support DC8200 + DT bindings

virtgpu:
- support PRIME import with 3D enabled

komeda:
- fix integer overflow in AFBC checks

mcde:
- improve bridge handling

gma500:
- use drm client buffer for fbdev framebuffer

amdxdna:
- add sensors ioctls
- provide NPU power estimate
- support column utilization sensor
- allow forcing DMA through IOMMU IOVA
- support per-BO mem usage queries
- refactor GEM implementation

ivpu:
- update boot API to v3.29.4
- limit per-user number of doorbells/contexts
- perform engine reset on TDR error

loongson:
- replace custom code with drm_gem_ttm_dumb_map_offset()

imx:
- support planes behind the primary plane
- fix bus-format selection

vkms:
- support CRTC background color

v3d:
- improve handling of struct v3d_stats

komeda:
- support Arm China Linlon D6 plus DT bindings

imagination:
- improve power-off sequence
- support context-reset notification from firmware

mediatek:
- mtk_dsi: enable hs clock during pre-enable
- Remove all conflicting aperture devices during probe
- Add support for mt8167 display blocks

----------------------------------------------------------------
Adriano Vero (1):
      drm/amd/display: clean up typecasts and constants in dcn4_calcs

Akhil P Oommen (16):
      drm/msm/a6xx: Use barriers while updating HFI Q headers
      drm/msm/a8xx: Fix the ticks used in submit traces
      drm/msm/a6xx: Switch to preemption safe AO counter
      drm/msm/a6xx: Correct OOB usage
      drm/msm/adreno: Implement gx_is_on() for A8x
      drm/msm/a6xx: Fix gpu init from secure world
      drm/msm/a6xx: Add support for Debug HFI Q
      drm/msm/a6xx: Use packed structs for HFI
      drm/msm/a6xx: Update HFI definitions
      drm/msm/a8xx: Add SKU table for A840
      drm/msm/a6xx: Add soft fuse detection support
      drm/msm/a6xx: Add SKU detection support for X2-85
      drm/msm/a8xx: Implement IFPC support for A840
      drm/msm/a8xx: Preemption support for A840
      drm/msm/a6xx: Enable Preemption on X2-85
      drm/msm/adreno: Expose a PARAM to check AQE support

Alex Deucher (32):
      drm/amdgpu: don't call drm_sched_stop/start() in asic reset
      drm/amdgpu: remove some retired module parameters
      drm/amdgpu: add a helper to calculate ring distance
      drm/amdgpu: reorder IB schedule sequence
      drm/amdgpu: rework ring reset backup and reemit v9
      drm/amdgpu/sdma4.0: adjust SDMA limits
      drm/amdgpu/sdma4.4: adjust SDMA limits
      drm/amdgpu/sdma5.2: adjust SDMA limits
      drm/amdgpu/sdma6.0: adjust SDMA limits
      drm/amdgpu/sdma7.0: adjust SDMA limits
      drm/amdgpu/sdma7.1: adjust SDMA limits
      drm/amdkfd: fix CWSR trap handler
      drm/amdgpu: gfx 12.1 cleanups
      drm/amdgpu/gfx12.1: add support for disable_kq
      drm/amdgpu: use common defines for GMC 12.1 HUB faults
      drm/amdgpu/mmhub2.0: add bounds checking for cid
      drm/amdgpu/mmhub2.3: add bounds checking for cid
      drm/amdgpu/mmhub3.0.1: add bounds checking for cid
      drm/amdgpu/mmhub3.0.2: add bounds checking for cid
      drm/amdgpu/mmhub3.0: add bounds checking for cid
      drm/amdgpu/mmhub4.1.0: add bounds checking for cid
      drm/amdgpu/mmhub4.2.0: add bounds checking for cid
      drm/amdgpu/gmc9.0: add bounds checking for cid
      drm/amdgpu: rework how we handle TLB fences
      drm/amdgpu: apply state adjust rules to some additional HAINAN vairan=
ts
      drm/radeon: apply state adjust rules to some additional HAINAN vairan=
ts
      drm/amdgpu/pm: drop SMU driver if version not matched messages
      drm/amdgpu/gfx10: look at the right prop for gfx queue priority
      drm/amdgpu/gfx11: look at the right prop for gfx queue priority
      drm/amd/display: check if ext_caps is valid in BL setup
      drm/amd/display: Fix DCE LVDS handling
      drm/amd/display: add a no_hpd link_encoder_funcs variant

Alex Hung (7):
      drm/amd/display: Use mpc.preblend flag to indicate 3D LUT
      drm/amd/display: Enable DEGAMMA and reject COLOR_PIPELINE+DEGAMMA_LUT
      drm/amd/display: Remove redundant initializers
      drm/amd/display: Remove always-false branches
      drm/amd/display: Prevent integer overflow when mhz to khz
      drm/amd/display: Fix gamma 2.2 colorop TFs
      drm/amd/display: Fix drm_edid leak in amdgpu_dm

Alex Sierra (1):
      drm/amdgpu: 57-bit enable for watch address on gfx_v12_1

Alexander Chechik (1):
      drm/amd/display: Fix DCN42 memory clock table using MemClk instead of=
 UClk

Alexander Konyukhov (1):
      drm/komeda: fix integer overflow in AFBC framebuffer size check

Alexander Koskovich (6):
      drm/msm/dpu: calculate data_width like downstream
      drm/mipi-dsi: add RGB101010 pixel format
      drm/meson: use default case for unsupported DSI pixel formats
      drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to V2_0_0
      drm/msm/dsi: add DSI version >=3D comparison helper
      drm/msm/dsi: Add support for RGB101010 pixel format

Alexander Stein (1):
      drm: lcdif: Use dev_err_probe()

Alexandre Courbot (37):
      gpu: nova-core: gsp: warn if data remains after processing a message
      gpu: nova-core: gsp: remove unnecessary Display impls
      gpu: nova-core: gsp: simplify sequencer opcode parsing
      gpu: nova-core: gsp: remove unneeded sequencer trait
      gpu: nova-core: gsp: derive `Debug` on more sequencer types
      gpu: nova-core: gsp: derive Zeroable for GspStaticConfigInfo
      gpu: nova-core: use core library's CStr instead of kernel one
      gpu: nova-core: create falcon firmware DMA objects lazily
      gpu: nova-core: falcon: add constant for memory block alignment
      gpu: nova-core: falcon: rename load parameters to reflect DMA depende=
ncy
      gpu: nova-core: falcon: remove FalconFirmware's dependency on
FalconDmaLoadable
      gpu: nova-core: move brom_params and boot_addr to FalconFirmware
      gpu: nova-core: falcon: remove unwarranted safety check in dma_load
      gpu: nova-core: make Chipset::arch() const
      gpu: nova-core: add gen_bootloader firmware to ModInfoBuilder
      gpu: nova-core: firmware: add comments to justify v3 header values
      gpu: nova-core: firmware: fix and explain v2 header offsets computati=
ons
      gpu: nova-core: gsp: move Cmdq's DMA handle to a struct member
      gpu: nova-core: introduce `bounded_enum` macro
      gpu: nova-core: convert PMC registers to kernel register macro
      gpu: nova-core: convert PBUS registers to kernel register macro
      gpu: nova-core: convert PFB registers to kernel register macro
      gpu: nova-core: convert GC6 registers to kernel register macro
      gpu: nova-core: convert FUSE registers to kernel register macro
      gpu: nova-core: convert PDISP registers to kernel register macro
      gpu: nova-core: convert falcon registers to kernel register macro
      gpu: nova-core: remove `io::` qualifier to register macro invocations
      Documentation: nova: remove register abstraction task
      rust: dma: add from-slice constructors for Coherent and CoherentBox
      gpu: nova-core: firmware: riscv: use dma::Coherent
      gpu: nova-core: firmware: fwsec: use dma::Coherent
      gpu: nova-core: falcon: use dma::Coherent
      gpu: nova-core: fb: use dma::CoherentHandle
      gpu: nova-core: firmware: gsp: use dma::Coherent for signatures
      gpu: nova-core: firmware: gsp: use dma::Coherent for level0 table
      gpu: nova-core: gsp: fix undefined behavior in command queue code
      gpu: nova-core: falcon: pad firmware DMA object size to required
block alignment

Alexandru Dadu (3):
      drm/imagination: Add missing rogue context reset reasons
      drm/imagination: Switch reset_reason fields from enum to u32
      drm/imagination: Implement handling of context reset notification

Alice Ryhl (2):
      rust: workqueue: use new sync::aref path for imports
      rust: drm: use new sync::aref path for imports

Alvin1 Chen (1):
      drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK, CSW MNF307QS3-2

Alysa Liu (1):
      drm/amdgpu: Fix use-after-free race in VM acquire

Amin GATTOUT (1):
      drm/loongson: use drm_gem_ttm_dumb_map_offset()

Andrew Martin (1):
      drm/amdkfd: Removed commented line for MQD queue priority

Andrzej Kacprowski (1):
      accel/ivpu: Remove boot params address setting via MMIO register

Andy Nguyen (1):
      drm/amd: fix dcn 2.01 check

Andy Shevchenko (1):
      drm/nouveau/gsp: simplify code with acpi_get_local_u64_address()

Andy Yan (4):
      dt-bindings: display: rockchip: Add rk3576 DisplayPort
      drm/bridge: synopsys: dw-dp: Set pixel mode by platform data
      drm/bridge: synopsys: dw-dp: Make i2s/spdif clk optional
      drm/rockchip: dw_dp: Add DisplayPort support for rk3576

Ankit Nautiyal (26):
      drm/i915/vbt: Add edp pipe joiner enable/disable bits
      drm/i915/dp: Avoid joiner for eDP if not enabled in VBT
      drm/i915/gvt_mmio_table: Use the gvt versions of the display macros
      drm/i915/dp: Early reject bad hdisplay in intel_dp_mode_valid
      drm/i915/dp: Move num_joined_pipes and related checks together
      drm/i915/dp: Extract helper to get the hdisplay limit
      drm/i915/dp: Rework pipe joiner logic in mode_valid
      drm/i915/dp: Rework pipe joiner logic in compute_config
      drm/i915/dp_mst: Move the check for dotclock at the end
      drm/i915/dp_mst: Move the joiner dependent code together
      drm/i915/dp_mst: Rework pipe joiner logic in mode_valid
      drm/i915/dp_mst: Extract helper to compute link for given joiner conf=
ig
      drm/i915/dp_mst: Rework pipe joiner logic in compute_config
      drm/i915/dp: Remove unused joiner helpers
      drm/i915/dp: Introduce helper to check pixel rate against dotclock li=
mits
      drm/i915/dp: Refactor dsc_slice_count handling in intel_dp_mode_valid=
()
      drm/i915/dp: Account for DSC slice overhead
      drm/i915/dp: Add helpers for joiner candidate loops
      drm/i915/alpm: Compute LOBF late after guardband is already determine=
d
      drm/i915/alpm: Allow LOBF only if window1 > alpm check_entry lines
      drm/i915/alpm: Allow LOBF only for platform that have Always on VRR T=
G
      drm/i915/alpm: Simplify and align LOBF checks in pre/post plane updat=
e
      drm/i915/alpm: Disable LOBF around transitioning for LRR/seamless MN
      drm/i915/quirks: Fix device id for QUIRK_EDP_LIMIT_RATE_HBR2 entry
      drm/i915/dp: Make intel_dp_can_join() static
      drm/i915/dp: Restore the missing check for intel_dp_has_joiner

Anna Maniscalco (1):
      drm/msm: always recover the gpu

Aradhya Bhatia (1):
      drm/xe/xe3p_lpg: Set STLB bank hash mode to 4KB

Arnd Bergmann (5):
      drm/pagemap: pass pagemap_addr by reference
      drm: bridge: anx7625: enforce CONFIG_USB_ROLE_SWITCH dependency
      drm/i915/fbdev: fix link failure without FBDEV emulation
      drm/bridge: lt8713sx select CONFIG_CRC8
      drm/bridge: lt8713sx: avoid 64-bit division

Arun R Murthy (3):
      drm/i915/cx0_phy_regs: Include SoC and OS turnaround time
      drm/i915/lt_phy_regs: Add SoC/OS turnaround time
      drm/i915/dp: Read ALPM caps after DPCD init

Arunpravin Paneer Selvam (2):
      drm/buddy: Improve offset-aligned allocation handling
      drm/buddy: Add KUnit test for offset-aligned allocations

Arvind Yadav (12):
      drm/xe/xe2: Apply Wa_14024997852
      drm/xe/bo: Add purgeable bo state tracking and field madv to xe_bo
      drm/xe/madvise: Implement purgeable buffer object support
      drm/xe/bo: Block CPU faults to purgeable buffer objects
      drm/xe/vm: Prevent binding of purged buffer objects
      drm/xe/madvise: Implement per-VMA purgeable state tracking
      drm/xe/madvise: Block imported and exported dma-bufs
      drm/xe/bo: Block mmap of DONTNEED/purged BOs
      drm/xe/dma_buf: Block export of DONTNEED/purged BOs
      drm/xe/bo: Add purgeable shrinker state helpers
      drm/xe/madvise: Enable purgeable buffer object IOCTL support
      drm/xe/madvise: Accept canonical GPU addresses in xe_vm_madvise_ioctl

Asad Kamal (30):
      drm/amd/pm: Avoid overflow when sorting pp_feature list
      drm/amd/pm: Add aid/xcd/hbm temperatures
      drm/amd/pm: Enable aid/xcd/hbm temperature reporting
      drm/amdgpu: Add default reset method for soc_v1_0
      drm/amd/amdgpu: Disable reset on init for soc_v1_0
      drm/amd/pm: Add common smu fw check function
      drm/amd/pm: Use common smu fw check function for smu13
      drm/amd/pm: Use common smu fw check function for smu15
      drm/amd/pm: Add fru eeprom info support
      drm/amd/pm: Update pm attributes
      drm/amd/pm: Add mutex lock for metrics table
      drm/amd/pm: Skip redundant UCLK restore in smu_v13_0_6
      drm/amd/pm: Return -EOPNOTSUPP for unsupported OD_MCLK on smu_v13_0_6
      drm/amd/pm: Add OD_FCLK interface
      drm/amd/pm: Add custom fclk setting support
      drm/amd/pm: Add mode2 support for smu_v15_0_8
      drm/amd/pm: Update dpm table structs for smu_v15_0
      drm/amd/pm: Add default dpm table support for smu 15.0.8
      drm/amd/pm: Add get_pm_metrics support for smu 15.0.8
      drm/amd/pm: Add emit clock support
      drm/amd/pm: add populate_umd_state_clk support
      drm/amd/pm: Add od_edit_dpm_table support
      drm/amd/pm: Add get_thermal_temperature_range support
      drm/amd/pm: Add ppt1 support
      drm/amd/pm: Add read sensor support
      drm/amd/pm: Add gpuboard temperature metrics support
      drm/amd/pm: Add baseboard temperature metrics support
      drm/amd/pm: Add NPM support for smu_v15_0_8
      drm/amd/pm: Enable user specified gfx clock ranges
      drm/amd/pm: Use str_enabled_disabled in amdgpu_pm sysfs

Asahi Lina (2):
      rust: helpers: Add bindings/wrappers for dma_resv_lock
      rust: drm: gem: shmem: Add DRM shmem helper abstraction

Ashutosh Dixit (1):
      drm/xe/oa: Allow reading after disabling OA stream

Aurabindo Pillai (1):
      drm/amd/display: Add atomfirmware cap for DP++ Type2

Austin Zheng (2):
      drm/amd/display: Fix number of opp
      drm/amd/display: Add dcn_mrq_present Field

Balasubramani Vivekanandan (1):
      drm/xe: Apply WA_16028005424 to Media

Bart Van Assche (4):
      drm/amdgpu: Unlock a mutex before destroying it
      drm/amdgpu: Fix locking bugs in error paths
      dma-buf: Suppress a thread-safety complaint
      drm/fb-helper: Fix a locking bug in an error path

Ben Dooks (1):
      drm/msm/hdmi: make 'msm_hdmi_pm_ops' static

Benjamin Nwankwo (1):
      drm/amd/display: Clamp dc_cursor_position x_hotspot to prevent
integer overflow

Biju Das (1):
      drm/msm: Use of_get_available_child_by_name()

Boris Brezillon (2):
      drm/panthor: Fix the "done_fence is initialized" detection logic
      drm/shmem_helper: Make sure PMD entries get the writeable upgrade

Brajesh Gupta (2):
      drm/imagination: Improve firmware power off for layout_mars config
      drm/imagination: Skip 2nd thread DM association for non META Firmware

Brian Nguyen (3):
      drm/xe: Skip over non leaf pte for PRL generation
      drm/xe: Move page reclaim done_handler to own func
      drm/xe: Skip adding PRL entry to NULL VMA

Caio Ishikawa (1):
      drm/panel: boe-th101mb31ig002: Remove use of deprecated mipi_dsi_dcs_=
nop()

Calvin Owens (1):
      drm/amd/display: Fix uninitialized variable use which breaks full LTO

Caterina Shablia (1):
      drm: add ARM interleaved 64k modifier

Chaitanya Kumar Borah (14):
      drm/xe/guc: Fix kernel-doc warning in GuC scheduler ABI header
      drm/i915/display: Add upper limit check for pixel clock
      drm/i915/display: Extend the max dotclock limit to WCL
      drm/colorop: Add destroy helper for colorop objects
      drm: Allow driver-managed destruction of colorop objects
      drm/amd/display: Hook up colorop destroy helper for plane pipelines
      drm/vkms: Hook up colorop destroy helper for plane pipelines
      drm/i915/display: Hook up intel_colorop_destroy
      drm: Clean up colorop objects during mode_config cleanup
      drm/vkms: Remove drm_colorop_pipeline_destroy() from vkms_destroy()
      drm/colorop: Use destroy callback for color pipeline teardown
      drm/i915/color: Add failure handling in plane color pipeline init
      drm/colorop: Preserve bypass value in duplicate_state()
      drm/atomic: Add affected colorops with affected planes

Charlene Liu (11):
      drm/amd/display: Fix dcn401_optimize_bandwidth
      drm/amd/display: Update underflow detection
      drm/amd/display: dcn42 don't round up disclk and dppclk
      drm/amd/display: System Hang When System enters to S0i3 w/ iGPU
      drm/amd/display: Add Extra SMU Log for dtbclk
      drm/amd/display: remove disable_sutter touch pstate debug code
      drm/amd/display: pg cntl update based on previous asic.
      drm/amd/display: export get_power_profile interface for later use
      drm/amd/display: remove dc_clock_limit for apu
      drm/amd/display: add dccg FGCG mask init
      drm/amd/display: correct unknown plane state patch

Chen Ni (1):
      drm/amdgpu/userq: convert comma to semicolon

Chen-Yu Tsai (6):
      drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to get display memor=
y
      drm/prime: Limit scatter list size with dedicated DMA device
      drm/gem-dma: Support dedicated DMA device for allocation and mapping
      drm/mediatek: Set dedicated DMA device and drop custom GEM callbacks
      drm/sun4i: Use backend/mixer as dedicated DMA device
      drm/gem-dma: set VM_DONTDUMP for mmap

Chintan Patel (2):
      drm/panel: jdi-lt070me05000: Use MIPI DSI multi functions
      drm/panel: novatek-nt36672a: Convert to mipi_dsi_*_multi() helpers

Christian Hewitt (1):
      drm/panthor: correct firmware related messages

Christian K=C3=B6nig (18):
      dma-buf: add dma_fence_was_initialized function v2
      dma-buf: protected fence ops by RCU v8
      dma-buf: detach fence ops on signal v3
      dma-buf: abstract fence locking v2
      dma-buf: inline spinlock for fence protection v5
      dma-buf/selftests: test RCU ops and inline lock v2
      dma-buf: use inline lock for the stub fence v2
      dma-buf: use inline lock for the dma-fence-array
      dma-buf: use inline lock for the dma-fence-chain
      drm/amdgpu: revert to old status lock handling v4
      drm/amdgpu: fix amdgpu_userq_evict
      drm/amdgpu: completely rework eviction fence handling v2
      drm/amdgpu: fix eviction fence and userq manager shutdown
      drm/amdgpu: fix adding eviction fence
      drm/amdgpu: rework amdgpu_userq_wait_ioctl v4
      drm/amdgpu: make amdgpu_user_wait_ioctl more resilent v2
      drm/amdgpu: annotate eviction fence signaling path
      drm/amdgpu: fix some more bug in amdgpu_gem_va_ioctl

Christoph Manszewski (1):
      mailmap: update email address for Christoph Manszewski

ChunTao Tso (2):
      drm/amd/display: Add new types to replay config
      drm/amd/display: Agument live + capture with CVT case.

Clay King (4):
      drm/amd/display: Silence unused variable warning
      drm/amd/display: Clean up unused code
      drm/amd/display: Fix silence signed/unsigned mismatch warnings in dml
      drm/amd/display: Fixed silence signed/unsigned mismatch warnings

Colin Ian King (2):
      drm/amd/display: remove extra ; from statement, remove extra tabs
      drm/amdgpu/mes12_1: emove extra ; from declaration statement

Cong Yang (1):
      drm/panel-edp: Add CMN N116BCL-EAK (C2)

Connor Abbott (1):
      drm/msm/a6xx: Fix dumping A650+ debugbus blocks

Cristian Ciocaltea (10):
      drm/bridge: dw-hdmi-qp: Provide HDMI Vendor Specific InfoFrame
      drm/bridge: dw-hdmi-qp: Provide SPD InfoFrame
      drm/bridge: dw-hdmi-qp: Rework AVI InfoFrame handler
      drm/bridge: dw-hdmi-qp: Rework DRM InfoFrame handler
      drm/bridge: dw-hdmi-qp: Rework Audio InfoFrame handler
      drm/amdgpu: Fix kernel-doc comments for some LUT properties
      uapi: Provide DIV_ROUND_CLOSEST()
      drm: Add CRTC background color property
      drm/vkms: Support setting custom background color
      drm/rockchip: vop2: Support setting custom background color

Cruise Hung (1):
      drm/amd/display: Fix DPIA number and driver ID field issue

Cunyuan Liu (3):
      dt-bindings: vendor-prefixes: Add Arm Technology (China) Co., Ltd.
      dt-bindings: display: arm,komeda: add Arm China Linlon D6 compatible
      drm/komeda: Add support for Arm China Linlon-D6

C=C3=A9dric Bellegarde (1):
      drm/msm/dpu: fix vblank IRQ registration before atomic_mode_set

Damon Ding (8):
      drm/display: bridge_connector: Ensure last bridge determines
EDID/modes detection capabilities
      drm/bridge: analogix_dp: Formalize the struct analogix_dp_device
      drm/bridge: analogix_dp: Move &drm_bridge_funcs.mode_set to
&drm_bridge_funcs.atomic_enable
      drm/bridge: analogix_dp: Reuse &link_train.training_lane[] to
set DPCD DP_TRAINING_LANEx_SET
      drm/bridge: analogix_dp: Apply DP helper API
drm_dp_dpcd_read_link_status()
      drm/bridge: analogix_dp: Apply DP helper API drm_dp_clock_recovery_ok=
()
      drm/bridge: analogix_dp: Apply DP helper API drm_dp_channel_eq_ok()
      drm/bridge: analogix_dp: Apply DP helper APIs to get adjusted
voltages and pre-emphasises

Daniel Almeida (4):
      rust: workqueue: add support for ARef<T>
      rust: drm: dispatch work items to the private data
      rust: workqueue: add delayed work support for ARef<T>
      rust: drm: dispatch delayed work items to the private data

Daniele Ceraolo Spurio (2):
      drm/xe/guc: Fix CFI violation in debugfs access.
      drm/xe/guc: Fail immediately on GuC load error

Danilo Krummrich (14):
      Merge tag 'v7.0-rc4' into drm-rust-next
      Merge tag 'rust_io-7.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core
into drm-rust-next
      Merge tag 'drm-misc-next-2026-03-12' into drm-rust-next
      rust: dma: use "kernel vertical" style for imports
      rust: dma: introduce dma::CoherentBox for memory initialization
      rust: dma: add Coherent:init() and Coherent::init_with_attrs()
      gpu: nova-core: use Coherent::init to initialize GspFwWprMeta
      gpu: nova-core: convert Gsp::new() to use CoherentBox
      rust: dma: remove dma::CoherentAllocation<T>
      rust: uaccess: generalize write_dma() to accept any Coherent<T>
      rust: dma: generalize BinaryWriter impl for Coherent<T>
      gpu: nova-core: use sized array for GSP log buffers
      rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from public attrs
      rust: dma: add CoherentHandle for DMA allocations without kernel mapp=
ing

Dario Binacchi (4):
      drm/panel: ilitek-ili9806e: rename to specific DSI driver
      drm/panel: ilitek-ili9806e: split core and DSI logic
      dt-bindings: ili9806e: add Rocktech RK050HR345-CT106A display
      drm/panel: ilitek-ili9806e: add Rocktech RK050HR345-CT106A SPI panel

Dave Airlie (31):
      drm: drop lib from header search path.
      Merge tag 'drm-misc-next-2026-02-26' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-xe-next-2026-03-02' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'amd-drm-next-7.1-2026-03-04' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2026-03-05' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-misc-next-2026-03-12' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-intel-gt-next-2026-03-12' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-xe-next-2026-03-12' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'amd-drm-next-7.1-2026-03-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-2026-03-16' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'amd-drm-next-7.1-2026-03-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2026-03-20' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      BackMerge tag 'v7.0-rc4' into drm-next
      Merge tag 'amd-drm-next-7.1-2026-03-25' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-xe-next-2026-03-25' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'drm-misc-next-2026-03-26' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'mediatek-drm-next-20260325' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-next
      Merge tag 'drm-xe-next-2026-03-26-1' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      BackMerge tag 'v7.0-rc6' into drm-next
      Merge tag 'drm-intel-next-2026-03-30' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-rust-next-2026-03-30' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
      Merge tag 'amd-drm-next-7.1-2026-04-01' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-msm-next-2026-04-02' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      mm: add gpu active/reclaim per-node stat counters (v2)
      drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)
      ttm/pool: port to list_lru. (v2)
      ttm/pool: drop numa specific pools
      ttm/pool: make pool shrinker NUMA aware (v2)
      ttm/pool: track allocated_pages per numa node.
      Merge tag 'drm-rust-next-2026-04-06' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
      Merge tag 'drm-misc-next-fixes-2026-04-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next

Dave Hansen (1):
      MAINTAINERS: Remove bouncing Keem Bay maintainer

David Baum (1):
      drm/amdgpu: switch XGMI sysfs show helpers to sysfs_emit_at()

David Carlier (1):
      gpu: nova-core: fix missing colon in SEC2 boot debug message

David Francis (1):
      drm/amdgpu: Check for multiplication overflow in checkpoint stack siz=
e

Deborah Brouwer (3):
      drm/tyr: Use vertical style for imports
      drm/tyr: Clarify driver/device type names
      drm/tyr: Use DRM device type alias across driver

Dillon Varone (7):
      drm/amd/display: Refactor fams2 calculations
      drm/amd/display: Fallback to boot snapshot for dispclk
      drm/amd/display: Refactor DC update checks
      drm/amd/display: Add 3DLUT DMA broadcast support
      drm/amd/display: using cm structure for lut3d related info
      Revert "drm/amd/display: Add 3DLUT DMA broadcast support"
      Revert "drm/amd/display: Refactor DC update checks"

Dmitry Baryshkov (22):
      dt-bindings: drm/bridge: anx7625: describe Type-C connector
      drm: bridge: anx7625: implement minimal Type-C support
      drm: bridge: anx7625: implement message sending
      drm: bridge: anx7625: correctly detect if PD can be disabled
      drm/msm/dpu: simplify bg_alpha selection
      drm/msm/dpu: use full scale alpha in _dpu_crtc_setup_blend_cfg()
      drm/msm/dpu: enable virtual planes by default
      drm/msm: add missing MODULE_DEVICE_ID definitions
      drm/msm/dpu: don't try using 2 LMs if only one DSC is available
      drm/msm/dpu: drop VBIF_NRT handling
      drm/msm/dpu: stop declaring VBIFs as an array in catalog
      drm/msm/dpu: replace VBIF-related array with bare pointers
      drm/msm/dpu: drop VBIF id, base and name from the catalog
      drm/msm/dpu: drop vbif_idx from WB configuration
      drm/msm/dpu: drop VBIF index from the VBIF params
      drm/msm/dpu: drop VBIF index from the struct dpu_hw_vbif
      drm/panel: sharp-ls043t1le01: make use of prepare_prev_first
      drm/msm/mdp5: drop single flush support
      drm/msm/mdp5: drop workarounds specific to MDP5 1.0
      drm/msm/dpu: correct DP MST interface configuration
      drm/msm/dpu: drop INTF_0 on MSM8953
      dt-bindings: display/msm: move DSI PHY bindings to phy/ subdir

Dmytro Laktyushkin (2):
      drm/amd/display: Add gpuvm and hvm params to dml21
      drm/amd/display: move dcn42 bw_params init

Dnyaneshwar Bhadane (1):
      drm/xe/nvlp: Attach MOCS table for nvlp

Dominik Kaszewski (2):
      drm/amd/display: Refactor and fix link_dpms I2C
      drm/amd/display: Refactor and fix link_dpms info

Donet Tom (5):
      drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
      drm/amdkfd: Align expected_queue_size to PAGE_SIZE
      drm/amd: Fix MQD and control stack alignment for non-4K
      drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB
      drm/amdkfd: Fix queue preemption/eviction failures by aligning
control stack size to GPU page size

Eliot Courtney (20):
      gpu: nova-core: gsp: fix incorrect advancing of write pointer
      gpu: nova-core: gsp: clarify comments about invariants and pointer ro=
les
      gpu: nova-core: gsp: use empty slices instead of [0..0] ranges
      gpu: nova-core: gsp: fix improper handling of empty slot in cmdq
      gpu: nova-core: gsp: fix improper indexing in driver_read_area
      gpu: nova-core: gsp: sort `MsgFunction` variants alphabetically
      gpu: nova-core: gsp: add mechanism to wait for space on command queue
      rust: add EMSGSIZE error code
      gpu: nova-core: gsp: add checking oversized commands
      gpu: nova-core: gsp: clarify invariant on command queue
      gpu: nova-core: gsp: unconditionally call variable payload handling
      gpu: nova-core: gsp: add `size` helper to `CommandToGsp`
      gpu: nova-core: gsp: support large RPCs via continuation record
      gpu: nova-core: gsp: add tests for continuation records
      gpu: nova-core: gsp: fix stale doc comments on command queue methods
      gpu: nova-core: gsp: add `RECEIVE_TIMEOUT` constant for command queue
      gpu: nova-core: gsp: add reply/no-reply info to `CommandToGsp`
      gpu: nova-core: gsp: make `Cmdq` a pinned type
      gpu: nova-core: gsp: add mutex locking to Cmdq
      gpu: nova-core: bitfield: fix broken Default implementation

Eric Huang (2):
      drm/amdgpu: prevent immediate PASID reuse case
      drm/amdkfd: fix kernel crash on releasing NULL sysfs entry

Erik Kurzinger (1):
      drm/amd/display: remove duplicate format modifier

Ethan Tidmore (3):
      drm/sun4i: backend: fix error pointer dereference
      drm/sun4i: Fix resource leaks
      drm/bridge: waveshare-dsi: Fix signedness bug

Fabio Estevam (2):
      dt-bindings: display: bridge: ldb: Document nxp,
enable-termination-resistor
      drm/bridge: fsl-ldb: Allow the termination resistor to be enabled

Feifei Xu (1):
      drm/amdgpu/mmhub_v4_2_0: expand gart aperture to gart_end on A+A

Florijan Plohl (2):
      dt-bindings: display: simple: Add Powertip PH800480T032-ZHC19 panel
      drm/panel: simple: Add Powertip PH800480T032-ZHC19 panel

Francois Dugast (4):
      drm/pagemap: Unlock and put folios when possible
      drm/pagemap: Add helper to access zone_device_data
      drm/pagemap: Enable THP support for GPU memory migration
      drm/xe: Add new SVM copy GT stats per size

Gabe Teeger (3):
      drm/amd/display: Remove check for DC_DMCUB_ENABLE on DCN42
      drm/amd/display: Fix bounds checking in dml2_0 clock table array
      drm/amd/display: eliminate clock manager code duplication

Gaghik Khachatrian (12):
      drm/amd/display: Silence type mismatch warning
      drm/amd/display: Clean up NULL pointer warnings in dml2
      drm/amd/display: Fix compile warnings in dml2_0
      drm/amd/display: Silence static analysis warning
      drm/amd/display: Fix Silence warnings
      drm/amd/display: Fix Signed/Unsigned Int Usage Compiler Warning
      drm/amd/display: Fix Compiler Warning - unused func parameters
      drm/amd/display: Fix Silence Conversion Warnings in Dmub
      drm/amd/display: Fix Silence signed/unsighed mismatch warning in dc
      drm/amd/display: Fixed Silence complier warnings in dc
      drm/amd/display: Fix Compiler warnings in dmub
      drm/amd/display: Silence type conversion warnings in dml2

Gangliang Xie (15):
      drm/amd/pm: add pmfw eeprom messages into uniras interface
      drm/amd/pm: add feature query interface for uniras
      drm/amd/ras: add pmfw eeprom smu interfaces
      drm/amd/ras: add uniras smu feature flag init func
      drm/amd/ras: add wrapper funcs for pmfw eeprom
      drm/amd/ras: Add table reset func for pmfw eeprom
      drm/amd/ras: add check safety watermark func for pmfw eeprom
      drm/amd/ras: add append func for pmfw eeprom
      drm/amd/ras: add read func for pmfw eeprom
      drm/amd/ras: adapt page retirement process for pmfw eeprom
      drm/amd/ras: add initialization func for pmfw eeprom
      drm/amd/ras: add check func for pmfw eeprom
      drm/amd/ras: adapt sync info func for pmfw eeprom
      drm/amdgpu: reset ras eeprom table when it is invalid
      drm/amdgpu: add support to query vram info from firmware

Gary Bisson (1):
      drm/mediatek: mtk_dsi: enable hs clock during pre-enable

Gary Guo (4):
      gpu: nova-core: remove redundant `.as_ref()` for `dev_*` print
      rust: dma: add generalized container for types other than slices
      rust: dma: add zeroed constructor to `Coherent`
      gpu: nova-core: convert to new dma::Coherent API

Geert Uytterhoeven (1):
      drm: renesas: rz-du: mipi_dsi: Convert to FIELD_MODIFY()

Greg Kroah-Hartman (1):
      drm/vc4: platform_get_irq_byname() returns an int

Gustavo Sousa (12):
      drm/i915/cdclk: Extend Wa_13012396614 to Xe3p_LPD
      drm/xe/pat: Differentiate between primary and media for PTA
      drm/xe/xe3p_lpg: Update LRC sizes
      drm/xe/nvlp: Bump maximum WOPCM size
      drm/xe: Modify stepping info directly in xe_step_*_get()
      drm/xe: Drop unused IS_PLATFORM_STEP() and IS_SUBPLATFORM_STEP()
      drm/xe/nvlp: Read platform-level stepping info
      drm/xe/rtp: Add support for matching platform-level stepping
      drm/xe/nvlp: Implement Wa_14026539277
      drm/xe/xe3p: Drop Wa_16028780921
      drm/xe: Translate C-state "reset value" into RC6
      drm/xe/pat: Extract gt_pta_entry()

Haikun Zhou (1):
      drm/panel-edp: Change BOE NV140WUM-N64 timings

Harikrishna Shenoy (1):
      drm/bridge: cadence: cdns-mhdp8546-core: Handle HDCP state in
bridge atomic check

Harish Chegondi (3):
      drm/xe/xe2hpg: Remove SRIOV VF check for Wa_18041344222
      drm/xe/xe3: Remove SRIOV VF check for Wa_18041344222
      drm/xe/xe2lpg: Extend Wa_18041344222 to graphics IP 20.04

Harish Kasiviswanathan (3):
      drm/amdkfd: Don't expect signal mailbox update
      drm/amdgpu: Update MTYPE for GFX12.1
      drm/amdgpu: Support forcing MTYPE_RW

Harry Wentland (7):
      drm/amd/display: Set chroma taps to 1 if luma taps are 1
      drm/amd/display: Add NV12/P010 formats to primary plane
      drm/amd/display: Add COLOR_ENCODING/COLOR_RANGE to overlay planes
      drm/colorop: Fix blob property reference tracking in state lifecycle
      Revert "drm/amd/display: Add NV12/P010 formats to primary plane"
      drm/amd/display: Merge pipes for validate
      drm/amd/display: Don't set 4to1MPC config dynamically

Hawking Zhang (26):
      drm/amdgpu: New interface to get IP discovery binary v3
      drm/amdgpu: Use memcpy to update IPD table for sriov guest
      drm/amdgpu: Handle IH v7_1 reg offset differences
      drm/amdgpu: fix shift-out-of-bounds when updating umc active mask
      drm/amdgpu: Limit physical transcation mode to A + A only
      drm/amdgpu: Place gart and vram in sysvm aper for A + A
      drm/amdgpu: Init table depth and block_size for A + A
      drm/amdgpu/gmc12: Set up pdb0 for vmid0 page table
      drm/amdgpu: Correct mmhub system aperture settings for A + A
      drm/amdgpu: Update gfxhub system aperture settings for A + A
      drm/amdgpu/gmc12: Bypass FB resize on A + A platform
      drm/amdgpu/gmc12: Update gmc aperture base for A + A
      drm/amdgpu: Implement get_xgmi_info callback for mmhub_v4_2
      drm/amdgpu: Query xgmi info from mmhub if available
      drm/amdgpu: Retire get_xgmi_info callback for gfxhub v12_1
      drm/amdgpu/gmc12: Query host-gpu interface
      drm/amdgpu/gmc12: Fix VRAM base offset calculation
      drm/amdgpu/gmc12: Update connected_to_cpu flag
      drm/amdgpu/gmc12: Init vram_size for A + A
      drm/amdgpu: Place firmware bo in vram for A + A
      drm/amdgpu: fallback to default discovery offset/size in sriov guest
      drm/amd/pm: Add smu v15_0_8 driver interface header
      drm/amd/pm: Add smu v15_0_8 message header
      drm/amd/pm: Add smu v15_0_8 pmfw header
      drm/amd/pm: Add initial support for smu v15_0_8
      drm/amdgpu: Add smu v15_0_8 ip block

Himal Prasad Ghimiray (2):
      drm/xe/guc: Skip access counter queue init for unsupported platforms
      drm/xe/uapi: Add UAPI support for purgeable buffer objects

Hongyang Zhao (2):
      dt-bindings: display: lt9611: Support single Port B input
      drm/bridge: lt9611: Add support for single Port B input

Hou Wenlong (1):
      drm/amd/display: Rename enum 'pixel_format' to 'dc_pixel_format'

Hsieh Hung-En (1):
      drm/rockchip: vop2: Use drm_err_ratelimited() for wait timeouts

Icenowy Zheng (8):
      dt-bindings: vendor-prefixes: add verisilicon
      dt-bindings: display: add verisilicon,dc
      drm: verisilicon: add a driver for Verisilicon display controllers
      dt-bindings: display/bridge: add binding for TH1520 HDMI controller
      drm/bridge: add a driver for T-Head TH1520 HDMI controller
      drm: verisilicon: suppress snprintf warning for pixel clock name
      drm: verisilicon: assign git tree to drm/misc in MAINTAINERS
      drm: verisilicon: make vs_dc_platform_driver static

Imre Deak (55):
      drm/i915/dsc: Track the detaild DSC slice configuration
      drm/i915/dsc: Track the DSC stream count in the DSC slice config stat=
e
      drm/i915/dsi: Move initialization of DSI DSC streams-per-pipe to
fill_dsc()
      drm/i915/dsi: Track the detailed DSC slice configuration
      drm/i915/dp: Track the detailed DSC slice configuration
      drm/i915/dsc: Switch to using intel_dsc_line_slice_count()
      drm/i915/dp: Factor out intel_dp_dsc_min_slice_count()
      drm/i915/dp: Use int for DSC slice count variables
      drm/i915/dp: Rename test_slice_count to slices_per_line
      drm/i915/dp: Simplify the DSC slice config loop's
slices-per-pipe iteration
      drm/i915/dsc: Add intel_dsc_get_slice_config()
      drm/i915/dsi: Use intel_dsc_get_slice_config()
      drm/i915/dp: Unify DP and eDP slice count computation
      drm/i915/dp: Add intel_dp_dsc_get_slice_config()
      drm/i915/dp: Use intel_dp_dsc_get_slice_config()
      drm/i915/dp: Fix pipe BPP clamping due to HDR
      drm/i915/dp: Verify valid pipe BPP range
      drm/i915/display: Clarify target pipe bpp variable name in
compute_sink_pipe_bpp()
      drm/i915/dp: Clamp the connector max_bpc request to the valid
pipe bpp range
      drm/i915/dp: Add missing slice count check during mode validation
      drm/i915/dp: Export intel_dp_compute_min_compressed_bpp_x16()
      drm/i915/dp_mst: Track min link BPP as x16 fixed-point during
mode validation
      drm/i915/dp_mst: Allow modes requiring compression for DSC passthroug=
h
      drm/i915/dp: Fix ww mutex lock failure in for_each_joiner_candidate()=
 loop
      drm/i915/dp_mst: Fix ww mutex lock failure in
for_each_joiner_candidate() loop
      drm/i915/dp_tunnel: Don't update tunnel state during system resume
      drm/i915/dp_tunnel: Simplify detection of link BW change
      drm/i915/dp_tunnel: Split update_tunnel_state()
      drm/i915/dp_tunnel: Sanitize documentation of intel_dp_tunnel_detect(=
)
      drm/i915/dp_tunnel: Send BW change notification after tunnel creation
      drm/i915/dp: Fix DSC state computation
      drm/i915/dp_mst: Reprobe connector if the IRQ ESI read failed
      drm/i915/dp_mst: Verify the link status always the same way
      drm/i915/dp_mst: Reuse intel_dp_check_link_state() in the HPD IRQ han=
dler
      drm/i915/dp: Handle a tunneling IRQ after acking it
      drm/i915/dp: Handle the RX_CAP_CHANGED HPD IRQ
      drm/i915/dp: Handle the DOWNSTREAM_PORT_STATUS_CHANGED event
      drm/i915/dp: Don't clobber the encoder state in the HPD IRQ handler
      drm/i915/dp: Remove the device service IRQ handling from connector de=
tect
      drm/i915/dp: Fix the device service IRQ DPCD_REV check
      drm/i915/dp: Fix the link service IRQ DPCD_REV check
      drm/i915/dp: Reprobe connector if getting/acking device IRQs fails
      drm/i915/dp: Reprobe connector if getting/acking link service IRQs fa=
ils
      drm/i915/dp: Return early if getting/acking device service IRQs fails
      drm/i915/dp: Return early if getting/ackink link service IRQs fails
      drm/i915/dp: Read/ack sink count and sink IRQs for SST as it's
done for MST
      drm/i915/dp: Print debug message for a sink connected off request
      drm/i915/dp: Check SST link status while handling link service IRQs
      drm/i915/dp_mst: Reuse intel_dp_handle_link_service_irq()
      drm/i915/dp: Ack only the handled device service IRQs
      drm/i915/dp: Ack only the handled link service IRQs
      drm/i915/dmc: Fix an unlikely NULL pointer deference at probe
      drm/i915/dp_mst: Fix forced link retrain handling in MST HPD IRQ hand=
ler
      drm/i915/dp: Simplify forcing a link retraining
      drm/i915/dp_tunnel: Fix error handling when clearing stream BW
in atomic state

Ivan Lipski (6):
      drm/amd/display: Fix cursor pos at overlay plane edges on DCN4
      drm/amd/display: Initialize replay_state to PR_STATE_INVALID
      drm/amd/display: Add missing DCCG register entries for DCN20-DCN316
      drm/amd/display: Check for S0i3 to be done before DCCG init on DCN21
      drm/amd/display: Move DPM clk read to clk_mgr_construct in DCN42
      drm/amd/display: Move DPM clk read to clk_mgr_construct in DCN42

Jack Xiao (2):
      drm/amdgpu/mes_v12_1: add mes self test
      drm/amdgpu/mes12_1: fix the failure access to MID1 registers

Jani Nikula (50):
      drm/i915: move GEN7_ERR_INT snapshot to display irq code
      drm/i915/dsb: move i915 specific DSB buffer implementation to i915
      drm/{i915, xe}/dsb: move DSB buffer to parent interface
      drm/{i915, xe}/pcode: move display pcode calls to parent interface
      drm/i915/display: move enum aux_ch to intel_display_limits.h
      drm/i915/gvt: drop dependency on display struct dpll
      drm/i915/gvt: drop dependency on intel_display_types.h
      drm/i915/gvt: drop unnecessary include of intel_display.h
      drm/i915/overlay: remove dead code with MTL platform checks
      drm/xe: remove unnecessary struct dram_info forward declaration
      Merge drm/drm-next into drm-intel-next
      drm/i915/dpt: move display/intel_dpt.c to i915_dpt.c
      drm/i915/dpt: pass obj, size instead of framebuffer to intel_dpt_crea=
te()
      drm/i915/dpt: move create/destroy to parent interface
      drm/i915/dpt: move suspend/resume to parent interface
      drm/i915/dpt: remove display/intel_dpt.h
      drm/i915/dpt: drop _common from the DPT file names
      drm/i915/dpt: switch to i915 runtime pm calls
      drm/i915/dpt: rename i915 specific functions to i915_dpt_ prefix
      drm/i915/dpt: rename struct i915_dpt to intel_dpt
      drm/i915/dpt: pass opaque struct intel_dpt around instead of
i915_address_space
      drm/i915/fbdev: stop debug logging i915_ggtt_offset()
      drm/i915: add VMA to parent interface
      drm/xe/compat: remove i915_vma.h from compat
      drm/xe/display: clean up xe_initial_plane.c includes
      drm/i915/reg: make masked field helpers constexpr
      drm/i915/lrc: switch to _MASKED_BIT_ENABLE() and _MASKED_BIT_DISABLE(=
)
      drm/{i915, xe}/reg: rename masked field helpers REG_MASKED_FIELD*()
      drm/i915/perf: prefer REG_MASKED_FIELD_ENABLE() and
REG_MASKED_FIELD_DISABLE()
      drm/xe/oa: prefer REG_MASKED_FIELD_ENABLE() and REG_MASKED_FIELD_DISA=
BLE()
      drm/intel: add reg_bits.h for the various register content helpers
      drm/intel: add pick.h for the various "picker" helpers
      drm/i915/gt: prefer _PICK_EVEN() over _PICK()
      drm/i915/gem: relocate __i915_gem_object_{flush, invalidate}_frontbuf=
fer()
      drm/i915/gem: unify i915 gem object frontbuffer function names
      drm/i915/overlay: convert from struct intel_frontbuffer to
i915_frontbuffer
      drm/intel: fix @dpt kernel-doc for parent interface
      drm/{i915, xe}/frontbuffer: move frontbuffer handling to parent inter=
face
      drm/i915/frontbuffer: call parent interface directly
      drm/i915/frontbuffer: reduce fb for frontbuffer abbreviation usage
      drm/i915: move i915 specific bo implementation to i915
      drm/xe: rename intel_bo.c to xe_display_bo.c
      drm/{i915, xe}/bo: move display bo calls to parent interface
      drm/i915/fb: make intel_fb_bo.c less dependent on display
      drm/{i915,xe}: move framebuffer bo to parent interface
      drm/i915/dmc: simplify stepping info initialization
      drm/i915/display: add step name in display runtime info
      drm/i915/dmc: use step name from runtime info
      drm/xe/compat: remove intel_step_name macro
      drm/intel: add shared step.h and switch i915 to use it

Janusz Krzysztofik (1):
      drm/i915: Fix potential overflow of shmem scatterlist length

Jayesh Choudhary (5):
      drm/bridge: cadence: cdns-mhdp8546-core: Set the mhdp connector
earlier in atomic_enable()
      drm/bridge: cadence: cdns-mhdp8546-core: Add mode_valid hook to
drm_bridge_funcs
      drm/bridge: cadence: cdns-mhdp8546-core: Remove legacy support
for connector initialisation in bridge
      cadence: cdns-mhdp8546*: Change drm_connector from structure to point=
er
      drm/bridge: cadence: cdns-mhdp8546-core: Reduce log level for
DPCD read/write

Jernej Skrabec (1):
      drm/sun4i: mixer: Fix layer init code

Jesse Zhang (3):
      drm/amdgpu/vcn4.0.3: gate per-queue reset by PSP SOS program version
      drm/amdgpu: guard atom_context in devcoredump VBIOS dump
      drm/amdgpu: flush coredump work before HW teardown

Jesse.Zhang (10):
      drm/amdgpu: add mqd_update callback to AMDGPU user queue interface
      drm/amdgpu: Add CU mask support for MQD properties
      drm/amdgpu/gfx11: add CU mask support for compute MQD initialization
      drm/amdgpu/gfx12: add CU mask support for compute MQD initialization
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion
      drm/amd/amdgpu: Fix build errors due to declarations after labels
      drm/amdgpu: validate fence_count in wait_fences ioctl
      drm/amdgpu: replace WARN with DRM_ERROR for invalid sched priority
      drm/amdgpu: use DISCOVERY_TMR_SIZE in ACPI TMR fallback
      drm/amd/pm: Enable VCN reset for pgm=3D4 with appropriate FW version

Jia Yao (1):
      drm/xe: Add bounds check on pat_index to prevent OOB kernel read
in madvise

Jinzhou Su (5):
      drm/amd/ras: Add address check structure
      drm/amd/ras: Add convert retired address structure
      drm/amd/ras: Handle address check in SR-IOV guest
      drm/amd/ras: Add function to convert retired address
      drm/amd/ras: Handle check address validity in SR-IOV

Jocelyn Falempe (1):
      drm/panic: depends on PRINTK

Joel Fernandes (11):
      gpu: Move DRM buddy allocator one level up (part one)
      gpu: Move DRM buddy allocator one level up (part two)
      gpu: nova-core: use checked arithmetic in FWSEC firmware parsing
      gpu: nova-core: use checked arithmetic in Booter signature parsing
      gpu: nova-core: use checked arithmetic in frombytes_at helper
      gpu: nova-core: use checked arithmetic in BinFirmware::data
      gpu: nova-core: use checked arithmetic in RISC-V firmware parsing
      gpu: nova-core: Kconfig: Sort select statements alphabetically
      rust: interop: Add list module for C linked list interface
      rust: gpu: Add GPU buddy allocator bindings
      MAINTAINERS: gpu: buddy: Update reviewer

John Hubbard (7):
      gpu: nova-core: fix aux device registration for multi-GPU systems
      gpu: nova-core: print FB sizes, along with ranges
      gpu: nova-core: add FbRange.len() and use it in boot.rs
      gpu: nova-core: apply the one "use" item per line policy to commands.=
rs
      gpu: nova-core: firmware: move firmware image parsing code to firmwar=
e.rs
      gpu: nova-core: firmware: factor out an elf_str() function
      gpu: nova-core: vbios: use from_le_bytes() for PCI ROM header parsing

John Keeping (1):
      drm/panel: ilitek-ili9882t: use gpiod_set_value_cansleep()

Jonathan Cavitt (8):
      drm/i915/display: Prevent u64 underflow in intel_fbc_stolen_end
      drm/i915/display: vcpi is always greater than zero
      drm/i915/display: PORT_NONE is not valid
      drm/i915/gvt: Swap read and write checks
      drm/xe/xe_pagefault: Disallow writes to read-only VMAs
      drm/xe/uapi: Define drm_xe_vm_get_property
      drm/xe/xe_vm: Add per VM fault info
      drm/xe/xe_vm: Implement xe_vm_get_property_ioctl

Joshua Aberback (1):
      drm/amd/display: Restore full update for tiling change to linear

Joshua Peisach (2):
      drm/amdgpu/amdgpu_connectors: use struct drm_edid instead of struct e=
did
      drm/amdgpu/amdgpu_connectors: remove amdgpu_connector_free_edid

Jouni H=C3=B6gander (23):
      drm/i915/psr: Don't enable Panel Replay on sink if globally disabled
      drm/i915/psr: Add TRANS_PUSH register bit definition for PSR
      drm/i915/psr: Add intel_psr_use_trans_push to query if TRANS_PUSH is =
used
      drm/i915/vrr: Add helper for parsing value to be written into TRANS_P=
USH
      drm/i915/vrr: Add helper for PSR to enable Frame Change event on
trans push
      drm/i915/vrr: Prepare to Use TRANS_PUSH mechanism for PSR frame chang=
e
      drm/i915/dsb: Set DSB_SKIP_WAITS_EN chicken bit for LunarLake and onw=
ards
      drm/i915/display: Wait for vblank in case of PSR is using trans push
      drm/i915/psr: Wait for idle only after possible send push
      drm/i915/psr: Do PSR exit on frontbuffer flush on LunarLake and onwar=
ds
      drm/i915/display: Add HAS_PSR_TRANS_PUSH_FRAME_CHANGE macro
      drm/i915/psr: Use TRANS_PUSH to trigger frame change event
      drm/i915/alpm: ALPM disable fixes
      drm/dp: Add definition for Panel Replay full-line granularity
      drm/i915/psr: Fix for Panel Replay X granularity DPCD register handli=
ng
      drm/i915/psr: Repeat Selective Update area alignment
      drm/i915/dsc: Add Selective Update register definitions
      drm/i915/dsc: Add helper for writing DSC Selective Update ET paramete=
rs
      drm/i915/psr: Write DSC parameters on Selective Update in ET mode
      drm/i915/psr: Disable PSR on update_m_n and update_lrr
      drm/i915/psr: Compute PSR entry_setup_frames into intel_crtc_state
      drm/i915/psr: Disable Panel Replay on Dell XPS 14 DA14260 as a quirk
      drm/i915/psr: Fixes for Dell XPS DA14260 quirk

Julian Braha (1):
      drm: fix dead default for DRM_TTM_KUNIT_TEST

Jun Nie (3):
      drm/msm/dpu: Extract plane splitting into a dedicated function
      drm/msm/dpu: Defer SSPP allocation until CRTC check
      drm/msm/dpu: support plane splitting in quad-pipe case

Junrui Luo (2):
      drm/amdgpu: validate doorbell_offset in user queue creation
      drm/amdgpu/userq: fix memory leak in MQD creation error paths

Karol Wachowski (5):
      accel/ivpu: Limit number of maximum contexts and doorbells per user
      accel/ivpu: Test for imported buffers with drm_gem_is_imported()
      accel/ivpu: Apply minor code style cleanups to align with kernel styl=
e
      accel/ivpu: Perform engine reset instead of device recovery on TDR
      accel/ivpu: Trigger recovery on TDR with OS scheduling

Karthik Poosa (2):
      drm/xe/pm: Disable D3Cold for BMG only on specific platforms
      drm/xe/hwmon: Prevent unintended VRAM channel creation

Kaushlendra Kumar (1):
      drm/i915/acpi: free _DSM package when no connectors

Kees Cook (1):
      drm/amd/ras: Fix type size of remainder argument

Kexin Sun (2):
      drm/amd/display: update outdated comments for renamed
vblank_control_worker()
      drm/amdgpu: update outdated comment for renamed amdgpu_fence_driver_i=
nit()

Koen Koning (1):
      gpu: Fix uninitialized buddy for built-in drivers

Konrad Dybcio (2):
      drm/msm/mdp5: Remove MSM8974v1
      drm/msm/mdss: Add a TODO for better managing the MDSS clock power sta=
te

Konstantin Khorenko (1):
      drm/i915/guc: Fix corrupted copyright symbols in selftest files

Kory Maincent (TI) (2):
      drm/tilcdc: Remove tilcdc_panel driver reintroduced by a merge
      drm/tilcdc: Fix type mismatch

Kory Maincent (TI.com) (25):
      dt-bindings: display: tilcdc: Convert to DT schema
      dt-bindings: display: tilcdc: Mark panel binding as deprecated
      drm/tilcdc: Remove simulate_vesa_sync flag
      drm/tilcdc: Add support for DRM bus flags and simplify panel config
      drm/tilcdc: Convert legacy panel binding via DT overlay at boot time
      drm/tilcdc: Remove tilcdc panel driver
      drm/tilcdc: Remove component framework support
      drm/tilcdc: Remove tilcdc_panel_info structure
      drm/tilcdc: Remove redundant #endif/#ifdef in debugfs code
      drm/tilcdc: Remove unused encoder and connector tracking arrays
      drm/tilcdc: Rename external_encoder and external_connector to
encoder and connector
      drm/tilcdc: Rename tilcdc_external to tilcdc_encoder
      drm/tilcdc: Remove the useless module list support
      drm/tilcdc: Use drm_module_platform_driver() helper
      drm/tilcdc: Move tilcdc_init/fini closer to probe/remove
      drm/tilcdc: Modernize driver initialization and cleanup paths
      drm/tilcdc: Remove the use of drm_device private_data
      drm/tilcdc: Convert to DRM managed resources
      drm/tilcdc: Convert to drm_device-based logging helpers
      drm/tilcdc: Use devm_drm_of_get_bridge() helper
      drm/bridge: tda998x: Remove component support
      drm/bridge: tda998x: Move tda998x_create/destroy into probe and remov=
e
      drm/bridge: tda998x: Remove useless tda998x_connector_destroy wrapper
      drm/bridge: tda998x: Add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR
      drm/tilcdc: Add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR

Krzysztof Karas (1):
      drm/i915/selftests: Keep mock file open during unfaultable
migrate with fill

Krzysztof Kozlowski (20):
      dt-bindings: display: samsung,s6d7aa0: Document port
      dt-bindings: display: innolux,p097pfg: Document ports
      dt-bindings: display: panel: Drop redundant properties
      dt-bindings: display: panel: Align style of additionalProperties
      dt-bindings: display/msm: dp-controller: Add Eliza SoC
      dt-bindings: display/msm: dsi-phy-7nm: Add Eliza SoC
      dt-bindings: display/msm: dsi-controller-main: Add Eliza SoC
      dt-bindings: display/msm: qcom,sm8650-dpu: Add Eliza SoC
      dt-bindings: display/msm: qcom,eliza-mdss: Add Eliza SoC
      drm/msm/dpu: Add support for Eliza SoC
      drm/msm/mdss: Add support for Eliza SoC
      drm/msm/hdmi: Fix wrong CTRL1 register used in writing info frames
      drm/msm/hdmi: Simplify with dev_of_node()
      drm/msm/hdmi: Avoid double error print on msm_hdmi_get_phy() failure
      drm/msm/hdmi: Simplify with local 'dev' variable
      drm/msm/hdmi: Consistently use u32 instead of uint32_t
      drm/msm/hdmi: Drop redundant 'int' for longs
      dt-bindings: display: panel: Align style of "true" properties
      dt-bindings: display/msm/gpu: Drop redundant reg-names in one if:then=
:
      drm/msm/dpu: eliza: Use Eliza-specific CWB array

Lang Yu (1):
      drm/amdkfd: Switch to dev_* printk stuff in kfd_int_process_v12_1.c

Langyan Ye (3):
      dt-bindings: vendor: add taiguanck
      dt-bindings: display: panel: Add compatible for TAIGUAN XTI05101-01A
      drm/panel: panel-jadard-jd9365da-h3: support for
taiguan-xti05101-01a MIPI-DSI panel

Laurent Pinchart (4):
      drm: rcar-du: Ensure correct suspend/resume ordering with VSP
      drm: rcar-du: Store CMM device pointer instead of platform_device
      drm: rcar-du: Use __free() to simplify device_node handling
      drm: rcar-du: Don't leak device_link to CMM

Le Ma (3):
      drm/amdgpu: update GFX CGCG/LS flags for gfx 12.1
      drm/amdgpu: bypass IMU ucode loading for MP0 15.0.8
      drm/amdgpu: fix array out of bounds accesses for mes sw_fini

Leo Li (1):
      drm/amdgpu/atomfirmware: Add LpDDR5x and new fields for info v2_3

Leon Romanovsky (8):
      dma-buf: Rename .move_notify() callback to a clearer identifier
      dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings(=
)
      dma-buf: Always build with DMABUF_MOVE_NOTIFY
      vfio: Wait for dma-buf invalidation to complete
      dma-buf: Make .invalidate_mapping() truly optional
      dma-buf: Add dma_buf_attach_revocable()
      vfio: Permit VFIO to work with pinned importers
      iommufd: Add dma_buf_pin()

Li Chen (1):
      nouveau: pci: quiesce GPU on shutdown

Lijo Lazar (29):
      drm/amdgpu: Print full vbios info
      drm/amdgpu: Fix error handling in slot reset
      drm/amdgpu: Move register access functions
      drm/amdgpu: Add smc method to register block
      drm/amdgpu: Add uvd indirect to register block
      drm/amdgpu: Add didt method to register block
      drm/amdgpu: Add gc cac method to register block
      drm/amdgpu: Add se cac method to register block
      drm/amdgpu: Add audio method to register block
      drm/amdgpu: Add pciep method to register block
      drm/amdgpu: Add pcie indirect to register block
      drm/amdgpu: Add pcie ext access to register block
      drm/amdgpu: Add pcie64 indirect to register block
      drm/amdgpu: Add pcie64 extended to register block
      drm/amdgpu: Move pcie lock to register block
      drm/amdgpu: Add smn callbacks to register block
      drm/amdgpu: Use get_smn_base in aqua_vanjaram
      drm/amd/pm: Add pm firmware info to dmesg log
      drm/amd/pm: Fix xgmi max speed reporting
      drm/amdgpu: Add client id helpers to mmhub
      drm/amdgpu: Add client ids for mmhub v4.x
      drm/amdgpu: Add client ids for mmhub v3.x
      drm/amdgpu: Add client ids for mmhub v2.x
      drm/amdgpu: Add client ids for gmcv9 mmhubs
      drm/amdgpu: Use stack variable to fetch nps info
      drm/amd/pm: Unify version check in SMUv11
      drm/amd/pm: Unify version check in SMUv12
      drm/amdgpu: Fix wait after reset sequence in S4
      drm/amd/pm: Unify version check in SMUv14

Likun Gao (11):
      drm/amdgpu/discovery: support new discovery binary header
      drm/amdgpu/discovery: use common function to check discovery table
      drm/amdgpu: Add lsdma v7_1_0 ip headers
      drm/amdgpu: add support for lsdma v7_1
      drm/amdgpu: fix DF NULL pointer issue for soc24
      drm/amdgpu: correct SDMA instance number for soc v1_0
      drm/amdgpu: change sdma doorbell size for soc v1
      drm/amdgpu: disable rlc fw info print
      drm/amdgpu: fix sysfs ip base addr with 64bit
      drm/amdgpu: retire some unsupport cmd pkt bit for gfx v12_1
      drm/amdgpu: update cp packets for gfx v12_1

Lincheng Ku (1):
      drm/amd/dc: Add link output control for DPIA

Linus Walleij (2):
      dma-buf: heaps: Clear CMA pages with clear_pages()
      dma-buf: heaps: Clear CMA highages using helper

Lionel Landwerlin (1):
      drm/xe: Allow per queue programming of COMMON_SLICE_CHICKEN3 bit13

Liu Ying (2):
      dt-bindings: display: simple: Add Tianma TM050RDH03 panel
      drm/panel: simple: Add Tianma TM050RDH03 panel

Lizhi Hou (4):
      accel/amdxdna: Add IOCTL to retrieve realtime NPU power estimate
      accel/amdxdna: Allow forcing IOVA-based DMA via module parameter
      accel/amdxdna: Add debug prints for command submission
      accel/amdxdna: Support retrieving hardware context debug information

Loic Poulain (1):
      drm: bridge: anx7625: don't crash if Type-C port is not used

Luca Ceresoli (8):
      drm/bridge: imx8qxp-pixel-link: simplify logic to find next bridge
      drm/bridge: imx8qxp-pixel-link: simplify freeing of the remote device=
_node
      drm/bridge: imx8qxp-pixel-link:
imx8qxp_pixel_link_find_next_bridge: return int, not ERR_PTR
      drm/mcde: dsi: mcde_dsi_bind: break when a panel or bridge is found
      drm/mcde: dsi: convert to of_drm_find_and_get_bridge()
      drm/bridge: imx8qxp-pixel-link: get/put the next bridge
      drm/bridge: add drm_bridge_clear_and_put()
      drm/bridge: samsung-dsim: use drm_bridge_clear_and_put() to put
the next bridge

Luca Coelho (20):
      drm/i915/display: remove enum macro magic in intel_display_wa()
      drm/i915/display: convert audio workaround to new framework
      drm/i915/display: convert W/As in intel_display_power.c to new framew=
ork
      drm/i915/display: convert W/As in intel_cdclk.c to new framework
      drm/i915/display: convert W/As in intel_cursor.c to new framework
      drm/i915/display: convert W/As in intel_ddi.c to new framework
      drm/i915/display: convert W/As in intel_display.c to new framework
      drm/i915/display: convert W/As in intel_display_device.c to new frame=
work
      drm/i915/display: convert W/As in intel_dp_mst.c to new framework
      drm/i915/display: convert W/As in intel_fbc.c to new framework
      drm/i915/display: convert W/As in intel_flipq.c to new framework
      drm/i915/display: convert W/As in intel_modeset_setup.c to new framew=
ork
      drm/i915/display: convert W/As in intel_pmdemand.c to new framework
      drm/i915/display: convert W/As in intel_psr.c to new framework
      drm/i915/display: convert W/As in skl_universal_plane.c to new framew=
ork
      drm/i915/display: convert W/As in skl_watermark.c to new framework
      drm/i915/display: move clock-gating init for IBX to display
      drm/i915: move CPT clock gating init into intel_pch
      drm/i915: move LPT clock gating init into intel_pch
      drm/i915: move CNP clock gating init into intel_pch

Luca Leonardo Scorcia (4):
      dt-bindings: display: panel: Document the rotation property
      drm/mediatek: Remove all conflicting aperture devices during probe
      dt-bindings: display: mediatek: Add compatibles for MediaTek mt8167
      dt-bindings: phy: mediatek, dsi-phy: Add support for mt8167

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in GPU BUDDY ALLOCATOR

Lyude Paul (5):
      rust/drm: Fixup import styles
      rust/drm: Remove imports covered by prelude::*
      rust: drm: Add gem::impl_aref_for_gem_obj!
      rust: gem: Introduce DriverObject::Args
      rust: drm: gem: Add raw_dma_resv() function

Maarten Lankhorst (7):
      drm/xe: Make xe_ggtt_node offset relative to starting offset
      drm/xe: Rewrite GGTT VF initialization
      drm/xe: Move struct xe_ggtt to xe_ggtt.c
      drm/xe: Make xe_ggtt_node_insert return a node
      drm/xe: Remove xe_ggtt_node_allocated
      drm/xe: Remove useless comment.
      drm/ttm/tests: Remove checks from ttm_pool_free_no_dma_alloc

Maciej Falkowski (1):
      accel/ivpu: Update FW Boot API to version 3.29.4

Maciej Patelczyk (1):
      drm/gpusvm: Fix unbalanced unlock in drm_gpusvm_scan_mm()

Mangesh Gadre (1):
      drm/amdgpu : Update psp 13_0_15 ip block support

Marcin Slusarz (1):
      drm/panthor: extend timestamp query with flags

Marco Crivellari (9):
      drm/xe: replace use of system_unbound_wq with system_dfl_wq
      drm/xe: add WQ_PERCPU to alloc_workqueue users
      drm/atomic-helper: replace use of system_unbound_wq with system_dfl_w=
q
      drm/probe-helper: replace use of system_wq with system_percpu_wq
      drm/self_refresh: replace use of system_wq with system_percpu_wq
      drm/vc4: hdmi: replace use of system_wq with system_percpu_wq
      drm/i915: replace use of system_unbound_wq with system_dfl_wq
      drm/i915: replace use of system_wq with system_percpu_wq in the
documentation
      drm/i915: add WQ_PERCPU to alloc_workqueue users

Marco Felsch (2):
      dt-bindings: display: simple: add EDT ET057023UDBA panel
      drm/panel: simple: add EDT ET057023UDBA panel

Marek Vasut (6):
      drm/rcar-du: dsi: Clean up VCLK divider calculation
      drm/bridge: waveshare-dsi: Register and attach our DSI device at prob=
e
      dt-bindings: display: bridge: waveshare,dsi2dpi: Document 1..4
DSI lane support
      drm/bridge: waveshare-dsi: Add support for 1..4 DSI data lanes
      drm/panel: simple: Add Waveshare 13.3" panel support
      drm/imx: parallel-display: Prefer bus format set via legacy
"interface-pix-fmt" DT property

Mario Limonciello (4):
      drm/amd: Disable MES LR compute W/A
      drm/amd: Fix NULL pointer dereference in device cleanup
      drm/amd: Fix a few more NULL pointer dereference in device cleanup
      drm/amd: Set num IP blocks to 0 if discovery fails

Mario Limonciello (AMD) (4):
      drm/connector: Add a new 'panel_type' property
      drm/amd/display: Attach OLED property to eDP panels
      accel/amdxdna: Import AMD_PMF namespace
      accel/amdxdna: Support sensors for column utilization

Mark Brown (1):
      RDMA/uverbs: Update for semantic conflict with drm-misc

Martin Kepplinger-Novakovic (1):
      drm/imx: parallel-display: add DRM_DISPLAY_HELPER for
DRM_IMX_PARALLEL_DISPLAY

Matt Coster (6):
      drm/imagination: Use dev_pm_domain_attach_list()
      drm/imagination: Improve handling of unknown FWCCB commands
      drm/imagination: Mark FWCCB_CMD_UPDATE_STATS as known
      drm/imagination: Check for NULL struct dev_pm_domain_list
      drm/imagination: Detach pm domains if linking fails
      drm/imagination: Ensure struct pvr_device->power is initialized

Matt Roper (49):
      drm/xe: Drop unnecessary goto in xe_device_create
      drm/xe: Move number of XeCore fuse registers to graphics descriptor
      drm/xe/xe3p_xpc: XeCore mask spans four registers
      drm/xe/xe3p_lpg: Add new PAT table
      drm/xe/xe3p_lpg: Add MCR steering
      drm/xe/xe3p_lpg: Add LRC parsing for additional RCS engine state
      drm/xe/xe3p_lpg: Disable reporting of context switch status to GHWSP
      drm/xe/xe3p_lpg: Drop unnecessary tuning settings
      drm/xe/xe3p_lpg: Extend 'group ID' mask size
      drm/i915/nvlp: Hook up display support
      drm/xe/xe2_hpg: Fix handling of Wa_14019988906 & Wa_14019877138
      drm/xe/xe3p_xpc: Add new XeCore fuse registers to VF runtime regs
      drm/xe: Stop applying Wa_16018737384 from Xe3 onward
      drm/xe/wa: Steer RMW of MCR registers while building default LRC
      drm/xe/reg_sr: Don't process gt/hwe lists in VF
      drm/xe/reg_sr: Add debugfs to verify status of reg_sr programming
      drm/xe: Add facility to lookup the value of a register in a default L=
RC
      drm/xe/reg_sr: Allow register_save_restore_check debugfs to
verify LRC values
      drm/xe/mtl: Drop pre-prod workarounds Wa_14015795083 & Wa_14014475959
      drm/xe/pvc: Drop pre-prod workarounds
      drm/xe/wa: Document new policy regarding workaround IP ranges
      drm/xe: Consolidate workaround entries for Wa_16021867713
      drm/xe: Consolidate workaround entries for Wa_14019449301
      drm/xe: Consolidate workaround entries for Wa_16028005424
      drm/xe: Consolidate workaround entries for Wa_16021865536
      drm/xe: Consolidate workaround entries for Wa_18032247524
      drm/xe: Consolidate workaround entries for Wa_16018712365
      drm/xe: Consolidate workaround entries for Wa_14020338487
      drm/xe: Consolidate workaround entries for Wa_14018471104
      drm/xe: Consolidate workaround entries for Wa_16021639441
      drm/xe: Consolidate workaround entries for Wa_14021402888
      drm/xe: Consolidate workaround entries for Wa_13012615864
      drm/xe: Consolidate workaround entries for Wa_14019877138
      drm/xe: Consolidate workaround entries for Wa_14019386621
      drm/xe: Consolidate workaround entries for Wa_14019988906
      drm/xe: Consolidate workaround entries for Wa_18033852989
      drm/xe: Consolidate workaround entries for Wa_15016589081
      drm/xe/wa_oob: Consolidate some OOB rules
      drm/xe: Consolidate workaround entries for Wa_14023061436
      drm/xe: Consolidate workaround entries for Wa_18041344222
      drm/xe/xe2_hpg: Drop invalid workaround Wa_15010599737
      drm/xe/xe3p_xpc: Drop stale MCR steering TODO comment
      drm/xe/tuning: Apply windower hardware filtering setting on Xe3 and X=
e3p
      drm/xe/xe2_hpg: Correct implementation of Wa_16025250150
      drm/xe: Add for_each_gt_with_type() iterator
      drm/xe: Utilize for_each_gt_with_type() for type-specific GT loops
      drm/xe/wa: Drop redundant entries for Wa_16021867713 & Wa_14019449301
      drm/xe: Include running dword offset in default_lrc dumps
      drm/xe: Implement recent spec updates to Wa_16025250150

Matthew Auld (5):
      drm/xe/uapi: disallow bind queue sharing
      drm/xe/migrate: fix job lock assert
      drm/xe/uapi: update used tracking kernel-doc
      drm/xe: always keep track of remap prev/next
      drm/ttm/tests: fix lru_count ASSERT

Matthew Brost (32):
      drm/xe: Reduce LRC timestamp stuck message on VFs to notice
      drm/xe: Ban entire multi-queue group on any job timeout
      drm/xe: Add normalize_invalidation_range
      drm/xe: Make usm.asid_to_vm allocation use GFP_NOWAIT
      drm/xe: Add has_ctx_tlb_inval to device info
      drm/xe: Add xe_device_asid_to_vm helper
      drm/xe: Add vm to exec queues association
      drm/xe: Taint TLB invalidation seqno lock with GFP_KERNEL
      drm/xe: Rename send_tlb_inval_ppgtt to send_tlb_inval_asid_ppgtt
      drm/xe: Add send_tlb_inval_ppgtt helper
      drm/xe: Add xe_tlb_inval_idle helper
      drm/xe: Add exec queue active vfunc
      drm/xe: Add context-based invalidation to GuC TLB invalidation backen=
d
      drm/gpusvm: Force unmapping on error in drm_gpusvm_get_pages
      drm/gpusvm: Allow device pages to be mapped in mixed mappings
after system pages
      drm/xe: Pack fault type and level into a u8
      drm/xe: Avoid touching consumer fields in GuC pagefault ack
      drm/xe: Convert GT stats to per-cpu counters
      drm/i915/selftests: Fix build after dma-fence locking rework
      dma-buf: Assign separate lockdep class to chain lock
      dma-buf: Assign separate lockdep class to array lock
      drm/xe: Do not preempt fence signaling CS instructions
      drm/xe: Split H2G and G2H into separate buffer objects
      drm/xe: Avoid unconditional VRAM reads in H2G path
      drm/xe: Move LRC seqno to system memory to avoid slow dGPU reads
      Merge drm/drm-next into drm-xe-next
      drm/xe: Always kill exec queues in xe_guc_submit_pause_abort
      drm/xe: Forcefully tear down exec queues in GuC submit fini
      drm/xe: Trigger queue cleanup if not in wedged mode 2
      drm/xe: Open-code GGTT MMIO access protection
      drm/pagemap: Correct cpages calculation for migrate_vma_setup
      drm/xe: Issue GGTT invalidation under lock in ggtt_node_remove

Matthew Stewart (1):
      drm/amd/display: Hardcode dtbclk value in bw_params

Max Zhen (2):
      accel/amdxdna: Refactor GEM BO handling and add helper APIs for
address retrieval
      accel/amdxdna: Add per-process BO memory usage query support

Maxime Ripard (33):
      drm/atomic: Make drm_atomic_private_obj_init fallible
      drm/atomic: Add new atomic_create_state callback to drm_private_obj
      drm/atomic-helper: Add private_obj atomic_create_state helper
      drm/bridge: Switch private_obj initialization to atomic_create_state
      drm/dp_mst: Switch private_obj initialization to atomic_create_state
      drm/dp_tunnel: Switch private_obj initialization to atomic_create_sta=
te
      drm/arm: komeda: Switch private_obj initialization to atomic_create_s=
tate
      drm/ingenic: Switch private_obj initialization to atomic_create_state
      drm/msm: mdp5: Switch private_obj initialization to atomic_create_sta=
te
      drm/msm: dpu1: Switch private_obj initialization to atomic_create_sta=
te
      drm/vc4: Switch private_obj initialization to atomic_create_state
      Merge drm/drm-next into drm-misc-next
      drm/tests: Mark slow tests as slow
      Merge drm/drm-next into drm-misc-next
      drm/amdgpu: Switch private_obj initialization to atomic_create_state
      drm/omapdrm: Switch private_obj initialization to atomic_create_state
      drm/tegra: Switch private_obj initialization to atomic_create_state
      drm/atomic: Remove state argument to drm_atomic_private_obj_init
      drm/connector: Introduce drm_output_color_format enum
      drm/edid: Convert to drm_output_color_format enum
      drm/display: hdmi: Convert to drm_output_color_format
      drm/amdgpu: display: Convert to drm_output_color_format
      drm/bridge: adv7511: Convert to drm_output_color_format
      drm/bridge: analogix: Convert to drm_output_color_format
      drm/bridge: cadence: Convert to drm_output_color_format
      drm/bridge: synopsys: dw-dp: Convert to drm_output_color_format
      drm/bridge: synopsys: dw-hdmi: Convert to drm_output_color_format
      drm/arm: komeda: Convert to drm_output_color_format
      drm/mediatek: dp: Convert to drm_output_color_format
      drm/rockchip: analogix: Convert to drm_output_color_format
      drm/connector: Remove DRM_COLOR_FORMAT defines
      drm/display: hdmi: Use drm_output_color_format instead of hdmi_colors=
pace
      Merge drm/drm-fixes into drm-misc-next-fixes

Ma=C3=ADra Canal (5):
      drm/panel: ilitek-ili9882t: Select DRM_DISPLAY_DSC_HELPER
      drm/v3d: Replace IDR with XArray for perfmon tracking
      drm/vc4: Replace IDR with XArray for perfmon tracking
      drm/v3d: Handle error from drm_sched_entity_init()
      drm/v3d: Remove dedicated fence_lock

Meenakshikumar Somasundaram (1):
      drm/amd/display: Update dpia supported configuration

Mel Henning (2):
      drm/nouveau: Fetch zcull info from device
      drm/nouveau: Add DRM_IOCTL_NOUVEAU_GET_ZCULL_INFO

Michael Chen (1):
      drm/amdgpu: Fix RRMT for gfx v12_1

Michael Tretter (2):
      drm/imx: ipuv3-plane: decouple zpos from plane type
      drm/imx: ipuv3-plane: support underlay plane

Michal Wajdeczko (39):
      drm/xe/vf: Reset VF GuC state on fini
      drm/xe/pf: Fix typo in function kernel-doc
      drm/xe/pf: Simplify IS_SRIOV_PF macro
      drm/xe: Promote relaxed_ms_sleep
      drm/xe: Move exponential sleep logic to helper
      drm/xe/guc: Limit sleep while waiting for H2G credits
      drm/xe/guc: Drop redundant register read
      drm/xe/guc: Wait before retrying sending H2G
      drm/xe/guc: Allow second H2G retry on FLR
      drm/xe: Keep all defaults in single header
      drm/xe/configfs: Use proper notation for local include
      drm/xe/configfs: Always return consistent max_vfs value
      drm/xe/pf: Define admin_only as real flag
      drm/xe/configfs: Add sriov.admin_only_pf attribute
      drm/xe/pf: Fix sysfs initialization
      drm/xe: Move xe_root_tile_mmio() to xe_device.h
      drm/xe: Promote struct xe_mmio definition to own file
      drm/xe: Promote struct xe_tile definition to own file
      drm/xe: Drop unnecessary include from xe_tile.h
      drm/xe/configfs: Fix 'parameter name omitted' errors
      drm/xe/vf: Allow VF to initialize MCR tables
      drm/xe/pf: Expose LMTT page size
      drm/xe/pf: Add locked variants of VRAM configuration functions
      drm/xe/pf: Add functions for VRAM provisioning
      drm/xe/pf: Allow to change VFs VRAM quota using sysfs
      drm/xe/pf: Use migration-friendly VRAM auto-provisioning
      drm/xe/tests: Add KUnit tests for new VRAM fair provisioning
      drm/xe/pf: Don't check for empty config
      drm/xe/pf: Prefer guard(mutex) when doing fair LMEM provisioning
      drm/xe/pf: Skip VRAM auto-provisioning if already provisioned
      drm/xe/pf: Add documentation for vram_quota
      drm/xe/pf: Use explicit VRAM BO flag for VRAM provisioning
      drm/xe/pf: Don't force 2MB VRAM alignment
      drm/xe/pf: Don't use LMTT page size if no LMTT
      drm/xe: Don't expose display modparam if no display support
      drm/xe/tests: Change TEST_VRAM to work with 32-bit resource_size_t
      drm/xe: Add PR_CTR_CTRL/THRSH register definitions
      drm/xe: Add MI_SEMAPHORE_WAIT command definition
      drm/xe/vf: Improve getting clean NULL context

Micha=C5=82 Grzelak (1):
      drm/i915: move intel_gvt_init() level higher

Micha=C5=82 Winiarski (2):
      drm/xe/pf: Fix the address range assert in ggtt_get_pte helper
      drm/xe/pf: Fix use-after-free in migration restore

Mika Kahola (40):
      drm/i915/cx0: Move C10 port clock calculation
      drm/i915/cx0: Move C20 port clock calculation
      drm/i915/cx0: Drop Cx0 crtc_state from HDMI TMDS pll divider calculat=
ion
      drm/i915/lt_phy: Drop LT PHY crtc_state for port calculation
      drm/i915/cx0: Drop encoder from port clock calculation
      drm/i915/cx0: Create macro around PLL tables
      drm/i915/lt_phy: Create macro for LT PHY PLL state
      drm/i915/display: Add helper function for fuzzy clock check
      drm/i915/cx0: Fix HDMI FRL clock rates
      drm/i915/cx0: Add a fuzzy check for DP/HDMI clock rates during progra=
mming
      drm/i915/cx0: Verify C10/C20 pll dividers
      drm/i915/lt_phy: Add verification for lt phy pll dividers
      drm/i915/cx0: Drop C20 25.175 MHz rate
      drm/i915/lt_phy: Drop 27.2 MHz rate
      drm/i915/display: Remove .clock member from eDP/DP/HDMI pll tables
      drm/i915/power_well: Enable workaround for DSS clock gating issue
      drm/i915/lt_phy: Dump missing PLL state parameters
      drm/i915/lt_phy: Add check if PLL is enabled
      drm/i915/lt_phy: Add PLL information for xe3plpd
      drm/i915/lt_phy: Refactor LT PHY PLL handling to use explicit PLL sta=
te
      drm/i915/lt_phy: Add lane_count to PLL state
      drm/i915/lt_phy: Add xe3plpd .compute_dplls hook
      drm/i915/lt_phy: Add xe3plpd .get_dplls hook
      drm/i915/lt_phy: Add xe3plpd .put_dplls hook
      drm/i915/lt_phy: Add xe3plpd .update_active_dpll hook
      drm/i915/lt_phy: Add xe3plpd .update_dpll_ref_clks hook
      drm/i915/lt_phy: Add xe3plpd .dump_hw_state hook
      drm/i915/lt_phy: Add xe3plpd .compare_hw_state hook
      drm/i915/lt_phy: Add xe3plpd .get_hw_state hook
      drm/i915/lt_phy: Add xe3plpd .get_freq hook
      drm/i915/lt_phy: Add xe3plpd .crtc_get_dpll
      drm/i915/lt_phy: Add .enable_clock hook on DDI
      drm/i915/lt_phy: Add .disable_clock hook on DDI
      drm/i915/lt_phy: Dump lane count for HW state
      drm/i915/lt_phy: Readout lane count
      drm/i915/lt_phy: Get encoder configuration for xe3plpd platform
      drm/i915/lt_phy: Add xe3plpd Thunderbolt PLL hooks
      drm/i915/lt_phy: Remove LT PHY specific state verification
      drm/i915/lt_phy: Enable dpll framework for xe3plpd
      drm/i915/lt_phy: Replace crtc compute clock

Mika Kuoppala (1):
      drm/xe: Fix overflow in guc_ct_snapshot_capture

Mithil Bavishi (3):
      dt-bindings: vendor-prefixes: Add Doestek
      dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
      dt-bindings: display: panel-lvds: Add compatibles for Samsung
LTN070NL01 and LTN101AL03 panels

Mitul Golani (1):
      drm/i915/display: Implement Wa_16024710867

Mohit Bawa (1):
      drm/amd/display: enable eDP DSC seamless boot support

Muaaz Nisar (1):
      drm/amd/display: Add Visual Confirm Support for Testing

Nakshtra Goyal (1):
      drm/xe/xe_query: Remove check for gt

Nareshkumar Gollakoti (2):
      drm/xe: Prevent VFs from exposing the CCS mode sysfs file
      drm/xe: Mutual exclusivity between CCS-mode and PF

Natalie Vock (1):
      drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink

Nathan Chancellor (3):
      drm/xe: Move _THIS_IP_ usage from xe_vm_create() to dedicated functio=
n
      drm/amdgpu/discovery: Add braces to case statements in
amdgpu_discovery_table_check()
      drm/xe: Fix format specifier for printing pointer differences

Nemesa Garg (1):
      drm/i915/casf: Disable CASF with joiner

Nicholas Carbones (1):
      drm/amd/display: Query DC for gfx handling when setting linear tiling

Nicholas Kazlauskas (7):
      drm/amd/display: Fix HWSS v3 fast path determination
      drm/amd/display: Add documentation and cleanup DMUB HW lock manager
      drm/amd/display: Plumb MRQ programming out of DML for dml2_1
      drm/amd/display: Add MRQ programming for DCN42
      drm/amd/display: Split arbiter programming for DCN42
      drm/amd/display: Revert inbox0 lock for cursor due to deadlock
      drm/amd/display: Avoid turning off the PHY when OTG is running for DV=
I

Nicolas Frattaroli (5):
      drm/panthor: Rework panthor_irq::suspended into panthor_irq::state
      drm/panthor: Extend IRQ helpers for mask modification/restoration
      drm/panthor: Add tracepoint for hardware utilisation changes
      drm/panthor: Add gpu_job_irq tracepoint
      drm/panthor: Add src path to includes of panthor_gpu.o

Niranjana Vishwanathapura (3):
      drm/xe/multi_queue: Enable multi_queue on xe3p_xpc
      drm/xe/multi_queue: Protect priority against concurrent access
      drm/xe: Add missing kernel docs in xe_exec_queue.c

Nitin Gote (7):
      drm/xe: derive mem copy capability from graphics version
      drm/xe/xe3p_lpg: Add Wa_14026781792
      drm/xe: add VM_BIND DECOMPRESS uapi flag
      drm/xe: add xe_migrate_resolve wrapper and is_vram_resolve support
      drm/xe: implement VM_BIND decompression in vm_bind_ioctl
      drm/xe/uapi: Fix kernel-doc for DRM_XE_VM_BIND_FLAG_DECOMPRESS
      drm/xe: Extend Wa_14026781792 for xe3lpg

Onur =C3=96zkan (1):
      drm/tyr: gpu: fix GpuInfo::log model/version decoding

Ovidiu Bunea (4):
      drm/amd/display: Exit IPS w/ DC helper for all dc_set_power_state cas=
es
      drm/amd/display: Add missing clock types & fix formatting
      drm/amd/display: Add min clock init for DML21 mode programming
      drm/amd/dc: Disable PSR & Replay CRTC disable by default

Pallavi Mishra (1):
      drm/xe/tests: Fix g2g_test_array indexing

Peichen Huang (1):
      drm/amd/display: Return early from vesa replay enable function

Pengpeng Hou (1):
      drm/amd/display: bios_parser: fix GPIO I2C line off-by-one

Pengyu Luo (9):
      drm/msm/dsi/phy: rename DSI_PHY_7NM_QUIRK_PRE_V4_1 to
DSI_PHY_7NM_QUIRK_V4_0
      dt-bindings: display: msm-dsi-phy-7nm: Add SC8280XP
      dt-bindings: display/msm: dsi-controller-main: Add SC8280XP
      dt-bindings: display: msm: Document DSI controller and DSI PHY on SC8=
280XP
      drm/msm/dsi: add the missing parameter description
      drm/msm/dsi: fix bits_per_pclk
      drm/msm/dsi: fix hdisplay calculation for CMD mode panel
      dt-bindings: display: panel: Add Himax HX83121A
      drm/panel: Add Himax HX83121A panel driver

Philip Yang (3):
      drm/amdgpu: GFX12.1 scratch memory limit up to 57-bit
      drm/amdkfd: Unreserve bo if queue update failed
      drm/amdkfd: Update queue properties for metadata ring

Philipp Stanner (1):
      drm/sched: Remove racy hack from drm_sched_fini()

Pierre-Eric Pelloux-Prayer (19):
      drm/amdgpu: remove gart_window_lock usage from gmc v12_1
      drm/amdgpu: statically assign gart windows to ttm entities
      drm/amdgpu: add amdgpu_ttm_buffer_entity_fini func
      drm/amdgpu: add amdgpu_gtt_node_to_byte_offset helper
      amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries
      amdgpu/ttm: use amdgpu_gtt_mgr_alloc_entries
      amdgpu/gtt: remove AMDGPU_GTT_NUM_TRANSFER_WINDOWS
      drm/amdgpu: add missing lock in amdgpu_benchmark_do_move
      drm/amdgpu: check entity lock is held in amdgpu_ttm_job_submit
      drm/amdgpu: double AMDGPU_GTT_MAX_TRANSFER_SIZE
      drm/amdgpu: introduce amdgpu_sdma_set_vm_pte_scheds
      drm/amdgpu: move sched status check inside
amdgpu_ttm_set_buffer_funcs_status
      drm/amdgpu: include ip discovery data in devcoredump
      drm/amdgpu: move devcoredump generation to a worker
      drm/amdgpu: allocate clear entities dynamically
      drm/amdgpu: allocate move entities dynamically
      drm/amdgpu: round robin through clear_entities in amdgpu_fill_buffer
      drm/amdgpu: use TTM_NUM_MOVE_FENCES when reserving fences
      drm/amdgpu: use multiple entities in amdgpu_move_blit

Piotr Pi=C3=B3rkowski (4):
      drm/xe/vf: Avoid reading media version when media GT is disabled
      drm/xe: Force EXEC_QUEUE_FLAG_KERNEL for kernel internal VMs
      drm/xe/pf: Add FLR_PREPARE state to VF control flow
      vfio/xe: Notify PF about VF FLR in reset_prepare

Pratap Nirujogi (1):
      drm/amdgpu: Fix ISP segfault issue in kernel v7.0

Prike Liang (2):
      drm/amdgpu: fix syncobj leak for amdgpu_gem_va_ioctl()
      drm/amdgpu: fix the idr allocation flags

Raag Jadav (8):
      drm/xe: Update xe_device_declare_wedged() error log
      drm/xe/bo: Redirect faults to dummy page for wedged device
      drm/xe/lrc: Refactor context init into xe_lrc_ctx_init()
      drm/xe/migrate: Refactor xe_migrate_prepare_vm()
      drm/xe/i2c: Assert/Deassert I2C IRQ
      drm/doc: Update documentation for 'none' recovery method
      drm: Update log for 'none' recovery method
      drm/xe: Send 'none' recovery method for
XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET

Rafal Ostrowski (3):
      drm/amd/display: Move FPU Guards From DML To DC - Part 1
      drm/amd/display: Move FPU Guards From DML To DC - Part 2
      drm/amd/display: Move FPU Guards From DML To DC - Part 3

Rahul Bukte (1):
      drm/i915/gt: Check set_default_submission() before deferencing

Randy Dunlap (3):
      drm/sun4i: fix kernel-doc warnings in sunxi_engine.h
      iopoll: fix function parameter names in read_poll_timeout_atomic()
      dma-fence: correct kernel-doc function parameter @flags

Ray Wu (2):
      drm/amd/display: Add debugfs to disallow eDP Replay entry
      drm/amd/display: Add Idle state manager(ISM)

Relja Vojvodic (2):
      drm/amd/display: Rework YCbCr422 DSC policy
      Revert "drm/amd/display: Rework YCbCr422 DSC policy"

Riana Tauro (4):
      drm/xe/xe_drm_ras: Add support for XE DRM RAS
      drm/xe/xe_hw_error: Integrate DRM RAS with hardware error handling
      drm/xe/xe_hw_error: Add support for Core-Compute errors
      drm/xe/xe_hw_error: Add support for PVC SoC errors

Richard Acayan (4):
      dt-bindings: arm: qcom: document google,bonito-tianma board
      dt-bindings: panel-simple-dsi: add nt37700f compatible
      drm/panel: Add Novatek/Tianma NT37700F panel
      dt-bindings: display/msm/gmu: Add SDM670 compatible

Rob Clark (9):
      drm/msm/adreno: Change chip_id format
      drm/msm/a8xx: Update GPU name with slice_mask
      drm/msm/vma: Avoid lock in VM_BIND fence signaling path
      drm/msm/a6xx: Add missing aperture_lock init
      drm/msm: Reject fb creation from _NO_SHARE objs
      drm/msm: Disallow foreign mapping of _NO_SHARE
      drm/msm: Fix VM_BIND UNMAP locking
      drm/msm/a6xx: Fix HLSQ register dumping
      drm/msm/shrinker: Fix can_block() logic

Robin Murphy (2):
      dt-bindings: display: panel: Move FriendlyElec HD702E to eDP
      drm/panel-edp: Move FriendlyELEC HD702E

Rodrigo Vivi (1):
      drm/ras: Introduce the DRM RAS infrastructure over generic netlink

Roman Li (17):
      drm/amd/display: Add dcn42 version identifiers
      drm/amd/display: Add dcn42 register headers
      drm/amd/display: Add dcn42 DC resources
      drm/amd/display: Add DMUB support for dcn42
      drm/amd/display: Enable dcn42 DMUB
      drm/amd/display: Enable dcn42 DC
      drm/amd/display: Enable dcn42 in DM
      drm/amdgpu/discovery: Enable DM for DCN42
      drm/amd/display: Enable dcn42 DC clk_mgr
      drm/amd/display: Add DML support for dcn42
      drm/amd/display: Sync dcn42 with DC 3.2.373
      drm/amd/display: Add get_default_tiling_info for dcn42
      drm/amd/display: Add missing dcn42 hubbub function pointers
      drm/amd/display: Clamp min DS DCFCLK value to DCN limit
      drm/amd/display: Update underflow detection for DCN42
      drm/amd/display: Enable Replay support for dcn42
      drm/amd/display: Remove invalid DPSTREAMCLK mask usage

Rouven Czerwinski (3):
      dt-bindings: vendor-prefixes: Add lxd
      dt-bindings: display: panel: add LXD M9189A
      drm/panel: add LXD M9189A panel driver

Ruijing Dong (1):
      drm/amdgpu: fix strsep() corrupting lockup_timeout on multi-GPU (v3)

Ryan Wanner (1):
      drm: atmel-hlcdc: add LCD controller layer definition for sama7d65

Samasth Norway Ananda (2):
      drm/i915/gmbus: fix spurious timeout on 512-byte burst reads
      drm/i915/gmbus: fix a typo in comment message

Sanjay Yadav (6):
      drm/xe: Use DRM_BUDDY_CONTIGUOUS_ALLOCATION for contiguous allocation=
s
      drm/buddy: Add kernel-doc for allocator structures and flags
      drm/buddy: Move internal helpers to buddy.c
      gpu/buddy: Introduce gpu_buddy_assert() for kunit-aware assertions
      gpu/tests/gpu_buddy: Add gpu_test_buddy_alloc_range for
exact-range allocation
      drm/xe: Fix missing runtime PM reference in ccs_mode_store

Satyanarayana K V P (3):
      drm/sa: Split drm_suballoc_new() into SA alloc and init helpers
      drm/xe/vf: Fix fs_reclaim warning with CCS save/restore BB allocation
      drm/xe/sa: Add lockdep annotations for SA manager swap_guard

Sebastian Brzezinka (1):
      drm/ttm: fix NULL deref in ttm_bo_flush_all_fences() after fence
ops detach

Sebastian Krzyszkowiak (2):
      drm/panel: mantix: Drop the shutdown callback
      drm/panel: mantix: Set the pixel clocks for 60 Hz

Sebastian Reichel (1):
      drm/panel: simple: Correct G190EAN01 prepare timing

Sergey Senozhatsky (1):
      drm: gpu: msm: forbid mem reclaim from reset

Shekhar Chauhan (3):
      drm/xe/xe3p_lpg: Add support for graphics IP 35.10
      drm/xe/xe3p_lpg: Add initial workarounds for graphics version 35.10
      drm/xe/nvlp: Add NVL-P platform definition

Shuicheng Lin (20):
      drm/xe: Skip address copy for sync-only execs
      drm/xe: Unregister drm device on probe error
      drm/xe/gt: Use CLASS() for forcewake in xe_gt_enable_comp_1wcoh
      drm/xe/configfs: Fix is_bound() pci_dev lifetime
      drm/xe/nvm: Manage nvm aux cleanup with devres
      drm/xe/nvm: Fix double-free on aux add failure
      drm/xe/nvm: Defer xe->nvm assignment until init succeeds
      drm/xe/query: Fix topology query pointer advance
      drm/xe: Fix kerneldoc for xe_migrate_exec_queue
      drm/xe: Fix kerneldoc for xe_gt_tlb_inval_init_early
      drm/xe: Fix kerneldoc for xe_tlb_inval_job_alloc_dep
      drm/xe/mmio: Avoid double-adjust in 64-bit reads
      drm/xe: Make xe_modparam.force_vram_bar_size signed
      drm/xe/sync: Cleanup partially initialized sync on parse failure
      drm/xe/sync: Fix user fence leak on alloc failure
      drm/xe/guc: Accumulate CT H2G retry sleep budget
      drm/xe/guc: Refine CT queue checks and log formatting
      drm/xe/configfs: Free ctx_restore_mid_bb in release
      drm/xe/reg_sr: Fix leak on xa_store failure
      drm/xe: Fix mismatched include guards in header files

Simon Louis (1):
      drm/amdgpu: Add xgmi link status for VFs

Simon Richter (1):
      drm/i915: handle failure from vga_get_uninterruptible()

Simona Vetter (2):
      Merge v7.0-rc3 into drm-next
      Merge v7.0-rc7 into drm-next

Sk Anirban (1):
      drm/xe/guc: Add Wa_14025883347 for GuC DMA failure on reset

Sonny Jiang (4):
      drm/amdgpu: Add VCN v5_0_2
      drm/amdgpu: Add VCN_5_0_2 codecs capabilities support
      drm/amdgpu: Set VCN_5_0_2 DPG mode
      drm/amdgpu: Add JPEG_v5_0_2 IP block

Sreekant Somasekharan (1):
      drm/amdgpu: Revert setting up Retry based Thrashing on GFX 12.1

Srinivasan Shanmugam (28):
      drm/gem: Make drm_gem_objects_lookup() self-cleaning on failure v6
      drm/amdgpu: Make amdgpu_fence_emit() non-failing v2
      drm/amdgpu: Make amdgpu_vm_flush() non-failing in submission path
      drm/amd/display: Fix kdoc formatting in dcn42_hwseq.c
      drm/amdgpu: Drop redundant syncobj handle limit checks in userq ioctl=
s
      drm/amdgpu: Fix mutex handling in amdgpu_benchmark_do_move() v3
      drm/amd/display: Fix DisplayID not-found handling in
parse_edid_displayid_vrr()
      drm/amdgpu: Drop unreachable return in amdgpu_reg_get_smn_base64()
      drm/amd/ras: Fix NULL deref in ras_core_ras_interrupt_detected()
      drm/amdgpu: Add default case in DVI mode validation
      drm/amd/ras: Fix NULL deref in ras_core_get_utc_second_timestamp()
      drm/amdgpu: Drop redundant queue NULL check in hang detect worker
      drm/amdgpu: Move amdgpu_vm_is_bo_always_valid() before first use
      drm/amdgpu: Remove dead negative offset check in
amdgpu_virt_init_critical_region()
      drm/amd/ras: Remove redundant NULL check in pending bad-bank
list iteration
      drm/amdgpu: Avoid NULL dereference in discovery topology coredump pat=
h v3
      drm/amd/ras: Add NULL checks for ras_core sys_fn callbacks
      drm/amd/ras: Add input pointer validation in ras core helpers
      drm/amdgpu: Skip discovery dump when topology is unavailable
      drm/amd/display: Add clk_mgr NULL checks in dcn32_initialize_min_cloc=
ks()
      drm/amd/display: Fix NULL pointer assumptions in dcn42_init_hw()
      drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib
      drm/amdkfd: Fix NULL pointer check order in kfd_ioctl_create_process
      drm/amd/display: Avoid NULL dereference in dc_dmub_srv error paths
      drm/amd/display: Add NULL check for integrated_info in clk_mgr_constr=
uct
      drm/amd/display: Add update_descriptor param info in
'update_planes_and_stream_state'
      drm/amd/display: Fix NULL pointer dereference in dcn401_init_hw()
      drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.5.4

Stanley.Yang (1):
      drm/amdgpu: Add amdgpu_regs_pcie64 debugfs node

Steffen Trumtrar (2):
      dt-bindings: display: simple: Add JuTouch JT070TM041 panel
      drm/panel: simple: add JuTouch JT070TM041

Sunil Khatri (23):
      drm/amdgpu: add upper bound check on user inputs in signal ioctl
      drm/amdgpu: add upper bound check on user inputs in wait ioctl
      drm/amdgpu/userq: change queue id type to u32 from int
      drm/amdgpu: update type for num_syncobj_handles in drm_amdgpu_userq_s=
ignal
      drm/amdgpu: update type for num_syncobj_handles in drm_amdgpu_userq_w=
ait
      drm/amdgpu/userq: refcount userqueues to avoid any race conditions
      drm/amdgpu/userq: remove queue from doorbell xarray
      drm/amdgpu/userq: remove queue from doorbell xa during clean up
      drm/amdgpu: fix warning for potentially insecure string
      drm/amdkfd: fix the warning for potential insecure string
      drm/amdgpu/userq: defer queue publication until create completes
      drm/amdgpu/userq: declutter the code with goto
      drm/amdgpu: push userq debugfs function in amdgpu_debugfs files
      Revert "drm/amdgpu: revert to old status lock handling v4"
      drm/amdgpu/userq: Use kvfree instead of kfree in amdgpu_userq_wait_io=
ctl
      drm/amdgpu/userq: Use kvfree instead of kfree in amdgpu_userq_signal_=
ioctl
      drm/amdgpu/userq: fix dma_fence refcount underflow in userq path
      drm/amdgpu/userq: unlock cancel_delayed_work_sync for hang_detect_wor=
k
      drm/amdgpu/userq: cleanup amdgpu_userq_get/put where not needed
      drm/amdgpu/userq: dont use goto to jump when at end of function
      drm/amdgpu/userq: schedule_delayed_work should be after fence signall=
ed
      drm/amdgpu/userq: amdgpu_userq_vm_validate does not need userq mutex
      drm/amdgpu/userq: Fix the code alignment for readability

Suraj Kandpal (14):
      drm/i915/cx0: Clear response ready & error bit
      drm/i915/cx0: Rename intel_clear_response_ready flag
      drm/i915/display: Disable DMG Clock Gating
      drm/i915/dp: Add a meaningful return to intel_dp_read_dsc_dpcd
      drm/i915/ltphy: Return true for TBT scenario during lt_phy_state comp=
are
      drm/i915/backlight: Remove try_vesa_interface
      drm/i915/backlight: Use intel_panel variable instead of intel_connect=
or
      drm/i915/backlight: Take luminance_set into account for VESA backligh=
t
      drm/i915/backlight: Check luminance_set when disabling PWM via
AUX VESA backlight
      drm/i915/backlight: Short circuit intel_dp_aux_supports_hdr_backlight
      drm/i915/backlight: Update debug log during backlight setup
      drm/i915/backlight: Provide clear description on how backlight
level is controlled
      drm/i915/hdcp: Take force_hdcp14 into account during check_link
      drm/i915/backlight: Check if VESA backlight is possible

Svyatoslav Ryhel (7):
      drm/panel: r61307: align with schema property
      drm/panel: r61307/r69328: convert to drm_connector_helper_get_modes_f=
ixed
      drm/panel: r61307/r69328: remove redundant checks
      drm/panel: r61307/r69328: return accumulated errors
      drm/panel: r61307/r69328: convert to devm_mipi_dsi_attach
      dt-bindings: display: panel: document Atrix 4G and Droid X2 DSI panel
      gpu/drm: panel: add support for DSI panel used in Motorola Atrix
4G and Droid X2

Taimur Hassan (10):
      drm/amd/display: Promote DC to 3.2.370
      drm/amd/display: [FW Promotion] Release 0.1.48.0
      drm/amd/display: Promote DC to 3.2.371
      drm/amd/display: Promote DC to 3.2.372
      drm/amd/display: [FW Promotion] Release 0.1.50.0
      drm/amd/display: Promote DC to 3.2.373
      drm/amd/display: Promote DC to 3.2.374
      drm/amd/display: Promote DC to 3.2.375
      drm/amd/display: [FW Promotion] Release 0.1.53.0
      drm/amd/display: Promote DC to 3.2.376

Tao Zhou (4):
      drm/amdgpu: compatible with specific RAS old eeprom format
      drm/amdgpu: clear related counter after RAS eeprom reset
      drm/amd/ras: make MCA IPID parse global
      drm/amdgpu: update flip bit setting of RAS bad page

Tejas Upadhyay (4):
      drm/xe/xe3p_lpg: flush shrinker bo cachelines manually
      drm/xe/pat: define coh_mode 2way
      drm/xe/xe3p_lpg: Restrict UAPI to enable L2 flush optimization
      drm/xe/xe3p: Skip TD flush

Terry Hsiao (1):
      drm/panel-edp: Add AUO B116XAT04.1 (HW: 1A)

Thadeu Lima de Souza Cascardo (3):
      drm/ttm: document that ttm_bo_swapout deals with pages
      drm/ttm/tests: add a test to exercise ttm_bo_swapout
      drm/vram: remove DRM_VRAM_MM_FILE_OPERATIONS from docs

Thomas Hellstr=C3=B6m (14):
      drm, drm/xe: Fix xe userptr in the absence of CONFIG_DEVICE_PRIVATE
      drm/xe: Select CONFIG_DEVICE_PRIVATE when DRM_XE_GPUSVM is selected
      mm: Fix a hmm_range_fault() livelock / starvation problem
      Revert "drm/pagemap: Disable device-to-device migration"
      drm/xe/uapi: Introduce a flag to disallow vm overcommit in fault mode
      mm/mmu_notifier: Allow two-pass struct mmu_interval_notifiers
      drm/xe/userptr: Convert invalidation to two-pass MMU notifier
      drm/xe: Split TLB invalidation into submit and wait steps
      drm/xe/userptr: Defer Waiting for TLB invalidation to the second
pass if possible
      Merge drm/drm-next into drm-xe-next
      drm/ttm: Don't spam the log on buffer object backing store
allocation failure
      drm/ttm: Avoid invoking the OOM killer when reading back swapped cont=
ent
      drm/ttm: Update the struct ttm_operation_ctx kerneldoc
      drm/msm: Remove abuse of drm_exec internals

Thomas Zimmermann (51):
      Merge drm/drm-next into drm-misc-next
      drm/fbdev-emulation: Remove empty placeholders
      drm/fbdev-emulation: Remove support for legacy emulation
      firmware: google: framebuffer: Do not unregister platform device
      firmware: google: framebuffer: Do not mark framebuffer as busy
      firmware: google: framebuffer: Init memory resource with helper macro
      firmware: google: framebuffer: Tie platform device to PCI hardware
      firmware: google: framebuffer: Fix dependencies
      firmware: google: Init coreboot bus with subsys_initcall()
      firmware: google: Clean up include statements in coreboot_table.h
      firmware: google: Export coreboot table entries
      firmware: google: Pack structures for coreboot table entries
      drm/sysfb: Generalize pixel-format matching
      drm/sysfb: corebootdrm: Add DRM driver for coreboot framebuffers
      drm/sysfb: corebootdrm: Support panel orientation
      drm/nouveau: Test for imported buffers with drm_gem_is_imported()
      drm/i915: Test for imported buffers with drm_gem_is_imported()
      drm/panfrost: Test for imported buffers with drm_gem_is_imported()
      drm/panthor: Test for imported buffers with drm_gem_is_imported()
      drm/client: Export drm_client_buffer_create()
      drm/gma500: fbdev: Set framebuffer size to GEM object size
      drm/gma500: fbdev: Calculate buffer geometry with format helpers
      drm/gma500: fbdev: Use a DRM client buffer
      drm/gma500: Create framebuffers with drm_gem_fb_create()
      drm/vc4: Test for imported buffers with drm_gem_is_imported()
      Merge drm/drm-next into drm-misc-next
      drm/gud: Test for imported buffers with drm_gem_is_imported()
      drm/amdgpu: Move test for fbdev GEM object into generic helper
      drm/radeon: Test for fbdev GEM object with generic helper
      drm/gem-shmem: Use obj directly where appropriate in fault handler
      drm/gem-shmem: Test for existence of page in mmap fault handler
      drm/gem-shmem: Return vm_fault_t from drm_gem_shmem_try_map_pmd()
      drm/gem-shmem: Refactor drm_gem_shmem_try_map_pmd()
      drm/gem-shmem: Track folio accessed/dirty status in mmap
      drm/gem-shmem: Track folio accessed/dirty status in vmap
      drm/mipi-dbi: Only modify planes on enabled CRTCs
      drm/mipi-dbi: Support custom pipelines with drm_mipi_dbi_dev_init()
      drm/mipi-dbi: Provide callbacks for atomic interfaces
      drm/hx8357d: Use regular atomic helpers; drop simple-display helpers
      drm/ili9163: Use regular atomic helpers; drop simple-display helpers
      drm/ili9225: Use regular atomic helpers; drop simple-display helpers
      drm/ili9341: Use regular atomic helpers; drop simple-display helpers
      drm/ili9486: Use regular atomic helpers; drop simple-display helpers
      drm/mi0283qt: Use regular atomic helpers; drop simple-display helpers
      drm/panel-mipi-dbi: Use regular atomic helpers; drop
simple-display helpers
      drm/st7586: Use regular atomic helpers; drop simple-display helpers
      drm/st7735r: Rename struct st7735r_priv to struct st7735r_device
      drm/st7735r: Rename priv variable to st7735r
      drm/st7735r: Use regular atomic helpers; drop simple-display helpers
      drm/mipi-dbi: Remove simple-display helpers from mipi-dbi
      drm/simple-kms: Deprecate simple-kms helpers

Timur Krist=C3=B3f (25):
      drm/amd/display: Use dce_audio_create for DCE 6
      drm/amd/display: Delete unused dce_clk_mgr.c
      drm/amd/display: Remove unused dce60_clk_mgr register definitions
      drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
      drm/amd/display: Handle DCE 6 in dce110_register_irq_handlers
      drm/amd/display: Add color depth helper function to BIOS parser
      drm/amd/display: Refactor DAC load detection, move to HWSS
      drm/amd/display: Implement BIOS parser external encoder control
      drm/amd/display: Implement DDC probe over AUX channel
      drm/amd/display: Add ability for HWSS to prepare the DDC before use
      drm/amd/display: Use preferred DP link rate if specified
      drm/amd/display: Add DCE HWSS support for external DP bridge encoders
      drm/amd/display: Link detection for external DP bridge encoders
      drm/amd/display: Use external DP bridge encoders
      drm/amd/display: Implement DAC load detection on external DP
bridge encoders
      drm/amdgpu: Use DC by default on CIK APUs
      drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is disabled
      drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
      drm/amd/pm/smu7: Fix SMU7 voltage dependency on display clock
      drm/amd/pm/smu7: Remove non-functional SMU7 voltage dependency on DAL
      drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
      drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
      drm/amd/pm/ci: Fill DW8 fields from SMC
      drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
      drm/amdgpu/uvd4.2: Don't initialize UVD 4.2 when DPM is disabled

Timur Tabi (9):
      drm/nouveau/gsp: add support for GA100
      gpu: nova-core: add PIO support for loading firmware images
      gpu: nova-core: use the Generic Bootloader to boot FWSEC on Turing
      rust: device: add device name method
      rust: uaccess: add write_dma() for copying from DMA buffers to usersp=
ace
      rust: dma: implement BinaryWriter for Coherent<[u8]>
      gpu: nova-core: Replace module_pci_driver! with explicit module init
      gpu: nova-core: create debugfs root in module init
      gpu: nova-core: create GSP-RM logging buffers debugfs entries

Tom Chung (2):
      drm/amd/display: Add back missing memory type in array
      drm/amd/display: Add a buffer for boot time crc

Tomasz Lis (6):
      drm/xe/guc: Increase GuC log sizes in debug builds
      drm/xe/queue: Call fini on exec queue creation fail
      drm/xe: Wrappers for setting and getting LRC references
      drm/xe/vf: Wait for all fixups before using default LRCs
      drm/xe/vf: Redo LRC creation while in VF fixups
      drm/xe: Fix confusion with locals on context creation

Tvrtko Ursulin (30):
      drm/xe/xelp: Fix Wa_18022495364
      dma-fence: Fix sparse warnings due __rcu annotations
      drm/amdgpu: Remove a few holes from struct amdgpu_ctx
      drm/amdgpu: Remove duplicate struct member
      drm/amdgpu/userq: Use memdup_array_user in amdgpu_userq_wait_ioctl
      drm/amdgpu/userq: Use memdup_array_user in amdgpu_userq_signal_ioctl
      drm/amdgpu/userq: Fix reference leak in amdgpu_userq_wait_ioctl
      drm/amdgpu/userq: Do not allow userspace to trivially triger
kernel warnings
      drm/amdgpu/userq: Consolidate wait ioctl exit path
      drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_i=
octl
      drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_wait_ioc=
tl
      drm/amdgpu: Reject impossible entities early
      drm/amdgpu: Remove redundant missing hw ip handling
      drm/v3d: Use raw seqcount helpers instead of fighting with lockdep
      drm/v3d: Refcount v3d_stats
      drm/v3d: Hold v3d_stats references in each job
      drm/v3d: Attach per-fd reset counters to v3d_stats
      drm/xe: Rename XE_BO_FLAG_SCANOUT to XE_BO_FLAG_FORCE_WC
      drm/xe: Use write-combine mapping when populating DPT
      drm/xe/xelpg: Limit AuxCCS ring buffer programming to Alderlake
      drm/xe/xelp: Quiesce memory traffic before invalidating AuxCCS
      drm/xe/xelp: Wait for AuxCCS invalidation to complete
      drm/xe: Move aux table invalidation to ring ops
      drm/xe/xelp: Add AuxCCS invalidation to the indirect context workarou=
nds
      drm/xe/display: Move remapped plane loop out of __xe_pin_fb_vma_dpt
      drm/xe/display: Change write_dpt_remapped_tiled function signature
      drm/xe/display: Respect remapped plane alignment
      drm/xe/display: Add support for AuxCCS
      drm/xe/xelp: Expose AuxCCS frame buffer modifiers on Alderlake-P
      drm/gem: Improve drm_gem_objects_lookup() kerneldoc

Uma Shankar (23):
      drm/i915: Extract display registers from i915_reg.h to display
      drm/i915: Extract South chicken registers from i915_reg.h to display
      drm/i915: Extract display interrupt definitions
      drm/i915: Extract DSPCLK_GATE_D from i915_reg to display
      drm/{i915, xe}: Extract pcode definitions to common header
      drm/i915: Remove i915_reg.h from intel_display_device.c
      drm/i915: Move GMD_ID and mask to intel_gt header
      drm/i915: Remove i915_reg.h from intel_dram.c
      drm/i915: Remove i915_reg.h from intel_display.c
      drm/i915: Remove i915_reg.h from intel_overlay.c
      drm/i915: Remove i915_reg.h from g4x_dp.c
      drm/i915: Remove i915_reg.h from i9xx_wm.c
      drm/{i915, xe}: Remove i915_reg.h from g4x_hdmi.c
      drm/i915: Remove i915_reg.h from intel_rom.c
      drm/i915: Remove i915_reg.h from intel_psr.c
      drm/i915: Remove i915_reg.h from intel_fifo_underrun.c
      drm/i915: Remove i915_reg.h from intel_display_irq.c
      drm/i915: Remove i915_reg.h from intel_display_power_well.c
      drm/i915: Remove i915_reg.h from intel_modeset_setup.c
      drm/{i915, xe}: Remove i915_reg.h from display
      drm/xe/compat: Remove unused i915_reg.h from compat header
      Revert "drm/xe/compat: Remove unused i915_reg.h from compat header"
      drm/xe/compat: Remove unused i915_reg.h from compat header

Umesh Nerlige Ramappa (1):
      drm/xe/lrc: Fix uninitialized new_ts when capturing context timestamp

Val Packett (6):
      drm/virtio: Allow importing prime buffers when 3D is enabled
      drm/mediatek: ovl: Add specific entry for mt8167
      dt-bindings: vendor-prefixes: Add Holitech
      dt-bindings: display: panel: Add compatible for Holitech HTF065H045
      drm/panel: himax-hx83102: Add support for Holitech HTF065H045
      drm/panel: himax-hx83102: Add support for DSI DCS backlight control

Varun Gupta (6):
      drm/xe: Add counter for invalid prefetch pagefaults
      drm/xe: Add prefetch fault support for Xe3p
      drm/xe: Fix memory leak in xe_vm_madvise_ioctl
      drm/xe: Add Wa_14026578760
      drm/ttm: Fix spelling mistakes and comment style in ttm_resource.c
      drm/xe/xe3p_lpg: Add Wa_16029437861

Vignesh Raman (5):
      drm/ci: reduce sm8350-hdk parallel jobs from 4 to 2
      drm/ci: i915: cml: update runner tag
      drm/ci: uprev mesa
      drm/ci: move qualcomm baremetal jobs to lava
      drm/ci: add rk3588-rock-5b

Ville Syrj=C3=A4l=C3=A4 (66):
      drm/i915/vga: Register vgaarb client later
      drm/i915/vga: Get rid of intel_vga_reset_io_mem()
      drm/i915/power: Remove i915_power_well_desc::has_vga
      drm/i915/vga: Extract intel_gmch_ctrl_reg()
      drm/i915/vga: Don't touch VGA registers if VGA decode is fully disabl=
ed
      drm/i915/vga: Clean up VGA registers even if VGA plane is disabled
      drm/i915/vga: Avoid VGA arbiter during intel_vga_disable() for iGPUs
      drm/i915/vga: Stop trying to use GMCH_CTRL for VGA decode control
      drm/i915/vga: Assert that VGA register accesses are going to the righ=
t GPU
      drm/i915/de: Simplify intel_de_read8()
      drm/i915/de: Add intel_de_write8()
      drm/i915/vga: Introduce intel_vga_{read,write}()
      drm/i915/vga: Use MMIO for VGA registers on pre-g4x
      video/vga: Add VGA_IS0_R
      drm/i915/crt: Use IS0_R instead of VGA_MIS_W
      drm/i915/crt: Extract intel_crt_sense_above_threshold()
      drm/i915: Get rid of the INTEL_GMCH_CTRL alias
      drm/i915: Clean up PCI config space reg defines
      drm/i915: Document the GMCH_CTRL register a bit
      drm/xe/fbdev: Fix BIOS FB vs. stolen size check
      drm/i915/fbdev: Extract intel_fbdev_fb_prefer_stolen()
      drm/xe/fbdev: Extract intel_fbdev_fb_prefer_stolen()
      drm/i915/overlay: Remove GPU hang snapshot stuff
      drm/i915/overlay: Track current frontbuffer_bits
      drm/i915/overlay: Extract i915_overlay_is_active()
      drm/i915/overlay: Remove redundant overlay->active
      drm/i915/overlay: Relocate the underrun check
      drm/i915/overlay: Introduce i915_overlay_obj_lookup()
      drm/i915/overlay: Use struct drm_gem_object as the type
      drm/i915/overlay: Extract i915_overlay_reset()
      drm/i915/overlay: Extract i915_overlay_setup()
      drm/i915/overlay: Extract i915_overlay_cleanup()
      drm/i915/overlay: Abstract buffer (un)pinning
      drm/i915/overlay: Rename low level i915 specific functions
      drm/i915/overlay: Adjust i915 specific interfaces
      drm/i915/overlay: Make i830_overlay_clock_gating() i915 specific
      drm/i915/overlay: s/dev_priv/i915/
      drm/i915/overlay: Split 'struct intel_overlay'
      drm/i915/overlay: Don't use fetch_and_zero() in display code
      drm/i915/overlay: Move i915 specific code into i915_overlay.c
      drm/i915/overlay: Convert overlay to parent interface
      drm/i915/overlay: Fix oops on unload
      drm/i915/vrr: Configure VRR timings after enabling TRANS_DDI_FUNC_CTL
      drm/i915: Order OP vs. timeout correctly in __wait_for()
      drm/i915: Unlink NV12 planes earlier
      drm/i915: Relocate unlink_nv12_plane()
      drm/i915: Skip redundant NV12 plane unlinking
      drm/i915/wm: Nuke is_planar from skl+ wm structures
      drm/i915/wm: Reorder the arguments to skl_allocate_plane_ddb()
      drm/i915/wm: s/skl_check_nv12_wm_level()/skl_check_wm_level_nv12()/
      drm/i915/wm: Extract skl_allocate_plane_ddb_nv12()
      drm/i915/wm: Nuke wm->uv_wm[]
      drm/i915/wm: s/skl_print_plane_changes()/skl_print_plane_wm_changes()=
/
      drm/i915/wm: Extract skl_print_plane_ddb_changes()
      drm/i915/wm: Include ddb_y in skl_print_wm_changes() on pre-icl
      drm/i915/wm: Include .min_ddb_alloc_uv in the wm dumps
      drm/i915/de: Introduce intel_de.c and move intel_de_{read,write}8() t=
here
      drm/i915/de: Move intel_de_wait*() into intel_de.c
      drm/i915/de: Implement register polling in the display code
      drm/i915/dsi: Don't do DSC horizontal timing adjustments in command m=
ode
      drm/i915/dsi: s/eotp_pkt/eot_pkt/
      drm/i915/dsi: Make 'clock_stop' boolean
      drm/i915/dsi: Fill BLLPs with blanking packets if requested
      drm/i915/dsi: Place clock into LP during LPM if requested
      drm/i915/selftests: Nuke live_forcewake_domains selftest
      drm/i915/uncore: Do GT FIFO checks in early sanitize and forcewake ge=
t

Vinay Belgaumkar (7):
      drm/xe/ptl: Disable DCC on PTL
      drm/xe: Decouple GuC RC code from xe_guc_pc
      drm/xe: Use FORCEWAKE_GT in xe_guc_pc_fini_hw()
      drm/xe: Add a wrapper for SLPC set/unset params
      drm/xe: Add GSC to powergate_info
      drm/xe: Add forcewake status to powergate_info
      drm/xe: Don't disable GuCRC in suspend path

Vinod Govindapillai (4):
      drm/i915/display: fix the pixel normalization handling for xe3p_lpd
      drm/i915/display: remove the usage of dev_priv
      drm/xe/fbdev: print info about stolen memory preference for fbdev
      drm/i915/fbdev: print info about stolen memory preference for fbdev

Vishnu Saini (2):
      dt-bindings: bridge: lt8713sx: Add bindings
      drm/bridge: add support for lontium lt8713sx bridge driver

Vladimir Oltean (1):
      drm/msm/dp: remove debugging prints with internal struct phy state

Wayne Lin (2):
      drm/amd/display: Remove unnecessary completion flag for secure displa=
y
      drm/amd/display: Should support p-state under dcn21

Weiguang Li (1):
      drm/amd/display: Add ESD detection for replay recovery

Wendy Liang (1):
      accel/amdxdna: Return ERR_PTR on dma_alloc_noncoherent failure

Xi Ruoyao (1):
      drm/amd/display: Wrap dcn32_override_min_req_memclk() in
DC_FP_{START, END}

Xin Wang (2):
      drm/xe: use entry_dump callbacks for xe2+ PAT dumps
      drm/xe: restrict multi-lrc to VCS/VECS engines

Yang Wang (11):
      drm/amd/pm: remove invalid gpu_metrics.energy_accumulator on smu v13.=
0.x
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu=
 v13
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu=
 v14
      drm/amdgpu: fix gpu idle power consumption issue for gfx v12
      drm/amd/pm: Setup driver pptable for smu 15.0.8
      drm/amd/pm: add get_gpu_metrics support for 15.0.8
      drm/amd/pm: add get_unique_id support for smu 15.0.8
      drm/amd/pm: add set{get}_power_limit support for smu 15.0.8
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu=
 v13
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu=
 v14
      drm/amd/pm: add dedicated dram addr msg for smu v15

Yasuaki Torimaru (1):
      drm/msm/gem: fix error handling in msm_ioctl_gem_info_get_metadata()

Yedaya Katsman (2):
      dt-bindings: display: panel: Add Samsung S6E8FC0-M1906F9
      drm: panel: Add Samsung S6E8FC0 DSI controller for M1906F9 panel

YiPeng Chai (6):
      drm/amd/ras: use dedicated memory as vf ras command buffer
      drm/amdgpu: Fix static assertion failure issue
      drm/amd/ras: Add unified interface to handle ras interrupts
      drm/amdgpu: Add umc ecc error handling for gmc v12_1
      drm/amdgpu: Add poison consumption handling for gfx v12_1
      drm/amd/ras: Pass ras poison consumption message to sriov host

Yicong Hui (1):
      drm/amdgpu: Replace deprecated strcpy() in amdgpu_virt_write_vf2pf_da=
ta

Yuanjie Yang (1):
      drm/msm/dpu: fix mismatch between power and frequency

Yujie Liu (3):
      drm/amdgpu: fix kernel-doc warning for amdgpu_ttm_alloc_mmio_remap_bo=
()
      drm/amd/ras: fix kernel-doc warning for ras_eeprom_append()
      drm/amd/pm: fix kernel-doc warning for smu_msg_v1_send_msg()

Yussuf Khalil (1):
      drm/amd/display: Do not skip unrelated mode changes in DSC validation

Zhanjun Dong (4):
      drm/xe/gsc: Fix GSC proxy cleanup on early initialization failure
      drm/xe: Use XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET enum instead
of magic number
      drm/xe/guc: Ensure CT state transitions via STOP before DISABLED
      drm/xe/uc: Drop xe_guc_sanitize in favor of managed cleanup

haoyu.lu (1):
      accel/amdxdna: fix missing newline in pr_err message

sguttula (3):
      drm/amdgpu/vcn5: Add SMU dpm interface type
      drm/amdgpu: Enable DPG support for VCN5
      drm/amdgpu/psp: Use Indirect access address for GFX to PSP mailbox

 .mailmap                                           |     1 +
 .../ABI/testing/sysfs-driver-intel-xe-sriov        |    31 +
 Documentation/devicetree/bindings/arm/qcom.yaml    |     6 +
 .../devicetree/bindings/display/arm,komeda.yaml    |     4 +-
 .../bindings/display/bridge/analogix,anx7625.yaml  |    98 +-
 .../bindings/display/bridge/fsl,ldb.yaml           |    18 +
 .../bindings/display/bridge/lontium,lt8713sx.yaml  |   113 +
 .../bindings/display/bridge/lontium,lt9611.yaml    |    15 +-
 .../bindings/display/bridge/lvds-codec.yaml        |     1 +
 .../display/bridge/thead,th1520-dw-hdmi.yaml       |   120 +
 .../bindings/display/bridge/waveshare,dsi2dpi.yaml |     3 +
 .../bindings/display/mediatek/mediatek,aal.yaml    |     1 +
 .../bindings/display/mediatek/mediatek,ccorr.yaml  |     4 +-
 .../bindings/display/mediatek/mediatek,dither.yaml |     1 +
 .../bindings/display/mediatek/mediatek,gamma.yaml  |     1 +
 .../bindings/display/mediatek/mediatek,ovl.yaml    |     1 +
 .../bindings/display/mediatek/mediatek,rdma.yaml   |     1 +
 .../bindings/display/mediatek/mediatek,wdma.yaml   |     4 +-
 .../bindings/display/msm/dp-controller.yaml        |     1 +
 .../bindings/display/msm/dsi-controller-main.yaml  |     5 +
 .../devicetree/bindings/display/msm/gmu.yaml       |     1 +
 .../devicetree/bindings/display/msm/gpu.yaml       |     7 -
 .../bindings/display/msm/qcom,eliza-mdss.yaml      |   494 +
 .../bindings/display/msm/qcom,sc8280xp-mdss.yaml   |    30 +
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |     1 +
 .../bindings/display/panel/abt,y030xx067a.yaml     |     5 -
 .../display/panel/advantech,idk-1110wr.yaml        |     4 +-
 .../display/panel/advantech,idk-2121wr.yaml        |     4 +-
 .../display/panel/bananapi,s070wv20-ct16.yaml      |     4 +-
 .../bindings/display/panel/dlc,dlc0700yzg-1.yaml   |     4 +-
 .../display/panel/feiyang,fy07024di26a30d.yaml     |     1 -
 .../bindings/display/panel/himax,hx83102.yaml      |     2 +
 .../bindings/display/panel/himax,hx83112a.yaml     |     2 -
 .../bindings/display/panel/himax,hx83121a.yaml     |    91 +
 .../bindings/display/panel/himax,hx8394.yaml       |     7 +-
 .../bindings/display/panel/ilitek,ili9163.yaml     |     4 -
 .../bindings/display/panel/ilitek,ili9322.yaml     |     3 -
 .../bindings/display/panel/ilitek,ili9341.yaml     |     6 +-
 .../bindings/display/panel/ilitek,ili9806e.yaml    |    38 +-
 .../bindings/display/panel/innolux,ej030na.yaml    |     5 -
 .../bindings/display/panel/innolux,p097pfg.yaml    |    26 +-
 .../bindings/display/panel/jadard,jd9365da-h3.yaml |     4 +-
 .../display/panel/kingdisplay,kd035g6-54nt.yaml    |     5 -
 .../display/panel/leadtek,ltk050h3146w.yaml        |     1 +
 .../display/panel/leadtek,ltk500hd1829.yaml        |     1 +
 .../bindings/display/panel/lgphilips,lb035q02.yaml |     4 -
 .../bindings/display/panel/lxd,m9189a.yaml         |    64 +
 .../display/panel/mantix,mlaf057we51-x.yaml        |     5 +-
 .../display/panel/mitsubishi,aa104xd12.yaml        |     4 +-
 .../display/panel/mitsubishi,aa121td01.yaml        |     4 +-
 .../bindings/display/panel/motorola,mot-panel.yaml |    69 +
 .../bindings/display/panel/nec,nl8048hl11.yaml     |     4 -
 .../bindings/display/panel/novatek,nt35510.yaml    |     3 +-
 .../bindings/display/panel/novatek,nt36523.yaml    |     3 -
 .../bindings/display/panel/novatek,nt36672a.yaml   |     3 -
 .../bindings/display/panel/orisetech,otm8009a.yaml |     4 +-
 .../bindings/display/panel/panel-edp-legacy.yaml   |     2 +
 .../bindings/display/panel/panel-lvds.yaml         |     4 +
 .../bindings/display/panel/panel-simple-dsi.yaml   |     2 +
 .../bindings/display/panel/panel-simple.yaml       |    10 +-
 .../bindings/display/panel/pda,91-00156-a0.yaml    |     4 +-
 .../bindings/display/panel/raydium,rm68200.yaml    |     4 +-
 .../bindings/display/panel/raydium,rm692e5.yaml    |     2 -
 .../bindings/display/panel/renesas,r61307.yaml     |     3 +-
 .../bindings/display/panel/renesas,r69328.yaml     |     1 -
 .../display/panel/rocktech,jh057n00900.yaml        |     5 +-
 .../bindings/display/panel/samsung,atna33xc20.yaml |     4 +-
 .../bindings/display/panel/samsung,ld9040.yaml     |     4 -
 .../bindings/display/panel/samsung,lms380kf01.yaml |     6 -
 .../bindings/display/panel/samsung,lms397kf04.yaml |     6 -
 .../bindings/display/panel/samsung,s6d27a1.yaml    |     6 -
 .../bindings/display/panel/samsung,s6d7aa0.yaml    |     8 +
 .../bindings/display/panel/samsung,s6e3ha8.yaml    |     4 -
 .../bindings/display/panel/samsung,s6e63m0.yaml    |     2 -
 .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       |     5 +-
 .../bindings/display/panel/sgd,gktw70sdae4se.yaml  |     4 +-
 .../bindings/display/panel/sitronix,st7701.yaml    |     6 -
 .../bindings/display/panel/sitronix,st7789v.yaml   |     6 -
 .../bindings/display/panel/sony,acx565akm.yaml     |     4 -
 .../display/panel/sony,tulip-truly-nt35521.yaml    |     2 -
 .../display/panel/startek,kd070fhfid015.yaml       |    11 +-
 .../devicetree/bindings/display/panel/tpo,td.yaml  |     5 -
 .../bindings/display/panel/visionox,r66451.yaml    |     4 +-
 .../bindings/display/panel/visionox,rm69299.yaml   |     4 +-
 .../bindings/display/panel/visionox,vtdr6130.yaml  |     4 +-
 .../bindings/display/rockchip/rockchip,dw-dp.yaml  |    27 +-
 .../devicetree/bindings/display/tilcdc/panel.txt   |     1 +
 .../bindings/display/tilcdc/ti,am33xx-tilcdc.yaml  |   100 +
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |    82 -
 .../bindings/display/verisilicon,dc.yaml           |   122 +
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |     1 +
 .../qcom,dsi-phy-10nm.yaml}                        |     4 +-
 .../qcom,dsi-phy-14nm.yaml}                        |     4 +-
 .../qcom,dsi-phy-20nm.yaml}                        |     4 +-
 .../qcom,dsi-phy-28nm.yaml}                        |     4 +-
 .../dsi-phy-7nm.yaml =3D> phy/qcom,dsi-phy-7nm.yaml} |     9 +-
 .../qcom,dsi-phy-common.yaml}                      |     2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    12 +
 Documentation/filesystems/proc.rst                 |     8 +
 Documentation/gpu/drm-kms-helpers.rst              |    12 -
 Documentation/gpu/drm-mm.rst                       |    10 +-
 Documentation/gpu/drm-ras.rst                      |   103 +
 Documentation/gpu/drm-uapi.rst                     |    14 +-
 Documentation/gpu/index.rst                        |     1 +
 Documentation/gpu/introduction.rst                 |     6 -
 Documentation/gpu/nova/core/todo.rst               |    76 -
 Documentation/gpu/todo.rst                         |    32 +
 Documentation/gpu/xe/xe_firmware.rst               |     3 +
 Documentation/netlink/specs/drm_ras.yaml           |   115 +
 MAINTAINERS                                        |    50 +-
 drivers/accel/amdxdna/Makefile                     |     1 +
 drivers/accel/amdxdna/aie2_ctx.c                   |    95 +-
 drivers/accel/amdxdna/aie2_error.c                 |     5 +-
 drivers/accel/amdxdna/aie2_message.c               |   139 +-
 drivers/accel/amdxdna/aie2_msg_priv.h              |    52 +
 drivers/accel/amdxdna/aie2_pci.c                   |    71 +
 drivers/accel/amdxdna/aie2_pci.h                   |    38 +-
 drivers/accel/amdxdna/amdxdna_ctx.c                |    29 +-
 drivers/accel/amdxdna/amdxdna_ctx.h                |    33 +-
 drivers/accel/amdxdna/amdxdna_gem.c                |   515 +-
 drivers/accel/amdxdna/amdxdna_gem.h                |    39 +-
 drivers/accel/amdxdna/amdxdna_iommu.c              |   184 +
 drivers/accel/amdxdna/amdxdna_mailbox.c            |     2 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |    55 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |    28 +
 drivers/accel/amdxdna/amdxdna_ubuf.c               |    17 +-
 drivers/accel/amdxdna/amdxdna_ubuf.h               |     5 -
 drivers/accel/amdxdna/npu4_regs.c                  |     3 +-
 drivers/accel/ivpu/ivpu_debugfs.c                  |    14 +-
 drivers/accel/ivpu/ivpu_drv.c                      |    95 +-
 drivers/accel/ivpu/ivpu_drv.h                      |    29 +-
 drivers/accel/ivpu/ivpu_gem.c                      |    12 +-
 drivers/accel/ivpu/ivpu_job.c                      |    86 +-
 drivers/accel/ivpu/ivpu_jsm_msg.c                  |    19 +-
 drivers/accel/ivpu/ivpu_jsm_msg.h                  |     3 +-
 drivers/accel/ivpu/ivpu_mmu.c                      |     3 +-
 drivers/accel/ivpu/ivpu_pm.c                       |    21 +-
 drivers/accel/ivpu/ivpu_pm.h                       |     1 +
 drivers/accel/ivpu/vpu_boot_api.h                  |   211 +-
 drivers/base/node.c                                |     5 +
 drivers/dma-buf/Kconfig                            |    12 -
 drivers/dma-buf/dma-buf.c                          |    69 +-
 drivers/dma-buf/dma-fence-array.c                  |    19 +-
 drivers/dma-buf/dma-fence-chain.c                  |    16 +-
 drivers/dma-buf/dma-fence.c                        |   168 +-
 drivers/dma-buf/dma-resv.c                         |     5 +-
 drivers/dma-buf/heaps/cma_heap.c                   |     7 +-
 drivers/dma-buf/st-dma-fence.c                     |    50 +-
 drivers/dma-buf/sw_sync.c                          |    14 +-
 drivers/dma-buf/sync_debug.h                       |     2 +-
 drivers/firmware/google/Kconfig                    |     5 +-
 drivers/firmware/google/cbmem.c                    |     1 +
 drivers/firmware/google/coreboot_table.c           |    13 +-
 drivers/firmware/google/coreboot_table.h           |    59 +-
 drivers/firmware/google/framebuffer-coreboot.c     |   126 +-
 drivers/firmware/google/memconsole-coreboot.c      |     1 +
 drivers/firmware/google/vpd.c                      |     1 +
 drivers/gpu/Kconfig                                |    13 +
 drivers/gpu/Makefile                               |     4 +-
 drivers/gpu/buddy.c                                |  1525 +
 drivers/gpu/drm/Kconfig                            |    25 +-
 drivers/gpu/drm/Kconfig.debug                      |     2 -
 drivers/gpu/drm/Makefile                           |     5 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   161 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |   465 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h   |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c      |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   173 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h        |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |   110 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   835 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   572 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |    21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |   251 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h |    55 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   118 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   100 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    49 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |    26 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    59 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |    11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c     |   958 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h     |   163 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h     |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    50 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   234 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |    11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   224 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |   776 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |    18 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    77 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |    79 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h       |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |    27 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |    28 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |    21 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |    28 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |    52 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    31 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    16 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    16 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    16 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |    20 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |    49 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    33 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   189 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h         |   223 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          |   193 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |    88 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |    33 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   137 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c               |    36 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |   840 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h           |   111 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c            |    99 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h            |    31 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   396 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |    49 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |    18 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c            |    17 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c          |    18 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c          |    10 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c            |    55 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c          |    16 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |   195 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |    30 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    31 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    31 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    54 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |    39 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |    31 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |    35 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |    33 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |    33 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |    54 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    66 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    31 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |    68 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |     1 -
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    25 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    30 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |    20 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |   147 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h              |     2 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c             |   117 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |     5 +
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |    33 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |    19 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |  1219 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h            |    29 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |    76 +-
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |     2 +-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |     6 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm |     3 -
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |     7 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |    12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h            |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |    35 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c   |     6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c   |     6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c |    46 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |     6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |    12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |     1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |     1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |     1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |     1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |     1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |     8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |     2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |     7 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    33 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |     3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   390 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    21 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |    27 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |     7 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |     1 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    90 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |     6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    52 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |     9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   598 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |   151 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |    36 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |    63 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |     6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |    25 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h     |    17 +-
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c  |     8 +-
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c |     1 +
 drivers/gpu/drm/amd/display/dc/basics/vector.c     |     1 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    42 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |     9 +
 .../gpu/drm/amd/display/dc/bios/command_table.c    |   124 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |     2 +
 .../amd/display/dc/bios/command_table_helper2.c    |     1 +
 .../dc/bios/dce110/command_table_helper_dce110.c   |     1 +
 .../dc/bios/dce112/command_table_helper2_dce112.c  |     1 +
 .../dc/bios/dce112/command_table_helper_dce112.c   |     1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |    23 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    35 +-
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |    64 +-
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |     2 +-
 .../amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |   166 -
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |     3 +-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |     4 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |     7 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |    10 +-
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |     6 +-
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |    10 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |    10 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |     4 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |     7 +-
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c   |    14 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |     3 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |  1183 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |    86 +
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c   |   431 +
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.h   |   190 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   434 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |    61 +-
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    21 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |    77 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    24 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |    10 +
 drivers/gpu/drm/amd/display/dc/dc.h                |    92 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |     7 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |    38 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |     9 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |     6 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |     3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    79 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h          |     1 +
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/dc_trace.h          |     4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    40 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile       |    11 +-
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h |    16 +-
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c |     2 +
 .../gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |     2 +
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c   |    28 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |   334 +
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |   273 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |     1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h       |    60 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |   134 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.h     |     9 -
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c   |   966 -
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    10 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |     1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c       |     1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |     2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c    |     3 +
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c       |     1 +
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |    65 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |     4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c       |     1 +
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |     4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |     2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c  |     1 +
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |    18 +-
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h  |    31 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |     1 +
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |    10 +
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |     1 +
 .../amd/display/dc/dce110/dce110_opp_regamma_v.c   |     2 +
 .../display/dc/dce110/dce110_timing_generator.c    |     9 +
 .../display/dc/dce110/dce110_timing_generator_v.c  |     9 +
 .../drm/amd/display/dc/dce110/dce110_transform_v.c |     6 +
 .../drm/amd/display/dc/dce112/dce112_compressor.c  |     1 +
 .../display/dc/dce120/dce120_timing_generator.c    |     7 +
 .../amd/display/dc/dce80/dce80_timing_generator.c  |     6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |     8 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c   |     2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c   |     4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |     4 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c   |     1 +
 drivers/gpu/drm/amd/display/dc/dio/Makefile        |    11 +-
 .../display/dc/dio/dcn10/dcn10_stream_encoder.c    |     2 +
 .../display/dc/dio/dcn10/dcn10_stream_encoder.h    |    10 +-
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c      |     2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c        |     2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c        |     1 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c      |     3 +
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.c  |   205 +
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.h  |   140 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c        |   522 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.h        |   206 +
 .../display/dc/dio/virtual/virtual_link_encoder.c  |    65 +-
 .../dc/dio/virtual/virtual_stream_encoder.c        |   111 +-
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |     1 +
 .../gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c   |     2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |     3 +-
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |     4 +
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |     5 +
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  |     5 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |     5 +
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |    21 +-
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |     5 +
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |     2 +
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |    23 +
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  |     5 +
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |    24 +
 .../display/dc/dml/dcn31/display_rq_dlg_calc_31.c  |     8 +
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |     6 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |    24 +
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c        |     8 +
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |     2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |    29 +-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |     8 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |     7 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |     1 +
 .../amd/display/dc/dml/display_rq_dlg_helpers.c    |    14 +
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |     3 +
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |    73 +-
 .../drm/amd/display/dc/dml2_0/display_mode_core.c  |     4 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |    63 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.h     |     1 +
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |   237 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.h  |     1 +
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.c    |   387 +-
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.h    |    30 -
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.c    |   381 +
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.h    |    60 +
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |   263 +
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |    13 +
 .../dml2_0/dml21/inc/dml_top_soc_parameter_types.h |     3 +
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |     3 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |   112 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.h |     1 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |    54 +-
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |     9 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.c   |    63 +-
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.h   |     2 +
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |    53 +
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h |     1 +
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |     6 +
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c   |     9 +-
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h   |     2 +-
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c  |    79 +
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h  |    12 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |     6 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |     6 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |     4 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.h   |     2 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c       |     2 +
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.c |     1 -
 .../dml21/src/inc/dml2_internal_shared_types.h     |     3 +
 .../amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c  |    36 +-
 .../drm/amd/display/dc/dml2_0/dml2_mall_phantom.c  |    44 +-
 .../display/dc/dml2_0/dml2_translation_helper.c    |    12 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |     3 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c   |    26 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h   |     1 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c   |     9 +-
 drivers/gpu/drm/amd/display/dc/dpp/Makefile        |    10 +-
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |     9 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c  |     4 +-
 .../gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c   |    11 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c    |     1 +
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |     9 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |     3 +
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h |     5 +-
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |     5 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |    27 +-
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |   333 +
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.h   |   469 +
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |     5 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |     5 +
 .../gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c   |     1 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |    13 +-
 .../amd/display/dc/gpio/dcn42/hw_factory_dcn42.c   |   254 +
 .../amd/display/dc/gpio/dcn42/hw_factory_dcn42.h   |    31 +
 .../amd/display/dc/gpio/dcn42/hw_translate_dcn42.c |   206 +
 .../amd/display/dc/gpio/dcn42/hw_translate_dcn42.h |    36 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     5 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c      |     1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     5 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile        |    11 +-
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c     |     5 +
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h     |    10 +-
 .../dc/hpo/dcn42/dcn42_hpo_dp_link_encoder.c       |    93 +
 .../dc/hpo/dcn42/dcn42_hpo_dp_link_encoder.h       |    17 +
 drivers/gpu/drm/amd/display/dc/hubbub/Makefile     |    10 +-
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h |     6 +-
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |     1 +
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |     1 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |     8 +-
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |   576 +
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h |   268 +
 drivers/gpu/drm/amd/display/dc/hubp/Makefile       |    10 +-
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |     2 +
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |     2 +
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h |     8 +-
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |     2 +
 .../gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c |     1 +
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |   211 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |    23 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |   742 +
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |    79 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile       |    12 +-
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h    |    13 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   168 +-
 .../drm/amd/display/dc/hwss/dce120/dce120_hwseq.c  |     4 +
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |    55 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |    13 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |     5 +-
 .../drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c  |    11 +
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |     5 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |     1 +
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    21 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |    18 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   503 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |  1104 +
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |    47 +
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |   173 +
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.h |    11 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |    23 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |     5 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    24 +-
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |   102 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    10 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    36 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |    20 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |   100 +-
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |     2 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |     1 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |     9 +
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |    12 +-
 .../amd/display/dc/irq/dce120/irq_service_dce120.c |     2 +-
 .../amd/display/dc/irq/dce80/irq_service_dce80.c   |    10 +-
 .../amd/display/dc/irq/dcn10/irq_service_dcn10.c   |     5 +-
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   |     5 +-
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   |     5 +-
 .../amd/display/dc/irq/dcn30/irq_service_dcn30.c   |     5 +-
 .../amd/display/dc/irq/dcn302/irq_service_dcn302.c |     7 +-
 .../amd/display/dc/irq/dcn303/irq_service_dcn303.c |     5 +-
 .../amd/display/dc/irq/dcn31/irq_service_dcn31.c   |     7 +-
 .../amd/display/dc/irq/dcn314/irq_service_dcn314.c |     7 +-
 .../amd/display/dc/irq/dcn315/irq_service_dcn315.c |     7 +-
 .../amd/display/dc/irq/dcn32/irq_service_dcn32.c   |     7 +-
 .../amd/display/dc/irq/dcn35/irq_service_dcn35.c   |     7 +-
 .../amd/display/dc/irq/dcn351/irq_service_dcn351.c |     7 +-
 .../amd/display/dc/irq/dcn36/irq_service_dcn36.c   |     7 +-
 .../amd/display/dc/irq/dcn401/irq_service_dcn401.c |     7 +-
 .../amd/display/dc/irq/dcn42/irq_service_dcn42.c   |   415 +
 .../amd/display/dc/irq/dcn42/irq_service_dcn42.h   |    15 +
 .../amd/display/dc/link/accessories/link_dp_cts.c  |     2 +
 .../drm/amd/display/dc/link/hwss/link_hwss_dpia.c  |    22 +-
 .../amd/display/dc/link/hwss/link_hwss_hpo_dp.c    |     6 +
 .../hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |     1 +
 .../amd/display/dc/link/hwss/link_hwss_virtual.c   |     6 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |    72 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   634 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |    29 +-
 .../gpu/drm/amd/display/dc/link/link_validation.c  |     1 +
 .../display/dc/link/protocols/link_dp_capability.c |     2 +
 .../amd/display/dc/link/protocols/link_dp_dpia.c   |     2 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |    36 +-
 .../dc/link/protocols/link_dp_panel_replay.c       |    25 +-
 .../display/dc/link/protocols/link_dp_training.c   |     2 +
 .../dc/link/protocols/link_dp_training_128b_132b.c |     1 +
 .../dc/link/protocols/link_dp_training_dpia.c      |     6 +
 .../drm/amd/display/dc/link/protocols/link_dpcd.c  |     1 +
 .../dc/link/protocols/link_edp_panel_control.c     |    11 +-
 drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile   |    10 +-
 .../amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.c |    25 +
 .../amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h |    13 +
 drivers/gpu/drm/amd/display/dc/mpc/Makefile        |    10 +-
 .../gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   |     4 +-
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |     6 +-
 .../gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c   |     1 +
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |   190 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |    35 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   |   797 +
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h   |   962 +
 .../gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c   |     1 +
 drivers/gpu/drm/amd/display/dc/optc/Makefile       |    10 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c |     4 +
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h |    26 +-
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |     2 +
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |     3 +-
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c |   291 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |   220 +
 drivers/gpu/drm/amd/display/dc/pg/Makefile         |    10 +-
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |   649 +
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h    |   175 +
 drivers/gpu/drm/amd/display/dc/resource/Makefile   |    18 +
 .../display/dc/resource/dce100/dce100_resource.c   |     9 +-
 .../display/dc/resource/dce110/dce110_resource.c   |     6 +
 .../display/dc/resource/dce112/dce112_resource.c   |     7 +-
 .../display/dc/resource/dce120/dce120_resource.c   |     3 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |     2 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |     7 +-
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |    14 +-
 .../amd/display/dc/resource/dcn10/dcn10_resource.h |     2 +
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |    29 +-
 .../display/dc/resource/dcn201/dcn201_resource.c   |     3 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |    36 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.h |     3 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |     8 +-
 .../display/dc/resource/dcn301/dcn301_resource.c   |     6 +-
 .../display/dc/resource/dcn302/dcn302_resource.c   |     6 +-
 .../display/dc/resource/dcn303/dcn303_resource.c   |     6 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |    15 +-
 .../display/dc/resource/dcn314/dcn314_resource.c   |     9 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |    11 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |    12 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |     3 +-
 .../dc/resource/dcn32/dcn32_resource_helpers.c     |     1 +
 .../display/dc/resource/dcn321/dcn321_resource.c   |     3 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |    18 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.h |     1 +
 .../display/dc/resource/dcn351/dcn351_resource.c   |    18 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |     9 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |    45 +-
 .../display/dc/resource/dcn401/dcn401_resource.h   |     3 +
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |  2358 +
 .../amd/display/dc/resource/dcn42/dcn42_resource.h |   591 +
 .../display/dc/resource/dcn42/dcn42_resource_fpu.c |    47 +
 .../dcn42/dcn42_resource_fpu.h}                    |    17 +-
 .../amd/display/dc/soc_and_ip_translator/Makefile  |     3 +
 .../dcn401/dcn401_soc_and_ip_translator.c          |     3 +
 .../dcn42/dcn42_soc_and_ip_translator.c            |   172 +-
 .../dcn42/dcn42_soc_and_ip_translator.h            |     1 +
 .../soc_and_ip_translator/soc_and_ip_translator.c  |     4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |     5 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   127 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |     3 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |    20 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c  |     1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  |    23 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  |    17 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c  |    18 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c |    22 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  |   759 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h  |   303 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c    |     4 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |    72 +-
 .../drm/amd/display/include/bios_parser_types.h    |     2 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     1 +
 drivers/gpu/drm/amd/display/include/dal_types.h    |     1 +
 drivers/gpu/drm/amd/display/include/dpcd_defs.h    |     3 +
 .../drm/amd/display/modules/color/color_gamma.c    |     2 +
 .../drm/amd/display/modules/freesync/freesync.c    |     6 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |     1 +
 .../amd/include/asic_reg/clk/clk_15_0_0_offset.h   |    44 +
 .../amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h  |    52 +
 .../amd/include/asic_reg/dcn/dcn_4_2_0_offset.h    | 17880 +++++
 .../amd/include/asic_reg/dcn/dcn_4_2_0_sh_mask.h   | 67286 +++++++++++++++=
++++
 .../amd/include/asic_reg/dpcs/dpcs_4_0_0_offset.h  |   142 +
 .../amd/include/asic_reg/dpcs/dpcs_4_0_0_sh_mask.h |   688 +
 .../include/asic_reg/lsdma/lsdma_7_1_0_offset.h    |    44 +
 .../include/asic_reg/lsdma/lsdma_7_1_0_sh_mask.h   |   105 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |     6 +-
 drivers/gpu/drm/amd/include/discovery.h            |    13 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    72 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |    59 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c         |    16 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |    15 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   123 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h    |     1 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c    |    83 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h    |     2 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |     2 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c    |    15 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |    20 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |     3 +
 .../pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h |   295 +
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h    |   427 +
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h   |   100 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |    19 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |    14 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h       |     2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |     2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |     7 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |    57 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |     5 +-
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    |     3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |    21 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    25 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |    75 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |     3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |     2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |    36 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |     2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |    44 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |     2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |    42 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |     2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |     2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |    99 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |    13 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |     2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |     2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |    60 -
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |    18 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |     5 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile        |     2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   212 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |     3 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  2270 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |   313 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |    39 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |     2 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    34 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h   |     1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c |    46 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c   |    10 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c   |     3 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |   169 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h  |    14 +-
 drivers/gpu/drm/amd/ras/rascore/Makefile           |     3 +-
 drivers/gpu/drm/amd/ras/rascore/ras.h              |    30 +
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c          |    29 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c          |     9 +-
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h          |    29 +
 drivers/gpu/drm/amd/ras/rascore/ras_core.c         |    74 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c       |     4 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h       |     7 -
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c    |   520 +
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h    |    87 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c          |    39 +-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h          |     2 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c    |    19 +-
 .../gpu/drm/arm/display/include/malidp_product.h   |     1 +
 .../gpu/drm/arm/display/komeda/d71/d71_component.c |    14 +-
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   |     1 +
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |     2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |     1 +
 .../drm/arm/display/komeda/komeda_framebuffer.c    |     6 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |     7 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |     2 +-
 .../drm/arm/display/komeda/komeda_private_obj.c    |   208 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |    81 +
 drivers/gpu/drm/bridge/Kconfig                     |    21 +
 drivers/gpu/drm/bridge/Makefile                    |     2 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |     2 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |     2 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |   292 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |     4 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   216 +-
 drivers/gpu/drm/bridge/analogix/anx7625.h          |    34 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |   281 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.h    |     4 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c    |    18 +-
 drivers/gpu/drm/bridge/fsl-ldb.c                   |     7 +
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c    |    50 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |     6 +-
 drivers/gpu/drm/bridge/ite-it6263.c                |     2 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |   598 +
 drivers/gpu/drm/bridge/lontium-lt9611.c            |    46 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |     7 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |    83 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |   224 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h       |     3 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    16 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |   263 +-
 drivers/gpu/drm/bridge/th1520-dw-hdmi.c            |   173 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |    16 +-
 drivers/gpu/drm/ci/arm64.config                    |     6 +
 drivers/gpu/drm/ci/build.sh                        |    13 +-
 drivers/gpu/drm/ci/build.yml                       |    40 +-
 drivers/gpu/drm/ci/container.yml                   |    32 +-
 drivers/gpu/drm/ci/gitlab-ci.yml                   |    96 +-
 drivers/gpu/drm/ci/igt_runner.sh                   |     6 +-
 drivers/gpu/drm/ci/image-tags.yml                  |    22 +-
 drivers/gpu/drm/ci/lava-submit.sh                  |   101 +-
 drivers/gpu/drm/ci/static-checks.yml               |     1 +
 drivers/gpu/drm/ci/test.yml                        |   119 +-
 drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt  |    13 +-
 drivers/gpu/drm/ci/xfails/amdgpu-stoney-flakes.txt |     7 +
 drivers/gpu/drm/ci/xfails/i915-amly-fails.txt      |    27 +-
 drivers/gpu/drm/ci/xfails/i915-apl-fails.txt       |    24 +-
 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt       |    37 +-
 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt      |     7 +
 drivers/gpu/drm/ci/xfails/i915-glk-fails.txt       |    22 +-
 drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt       |    27 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt       |     5 +-
 drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt       |     5 +-
 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt      |     6 +
 drivers/gpu/drm/ci/xfails/i915-whl-fails.txt       |    13 +-
 .../gpu/drm/ci/xfails/mediatek-mt8173-fails.txt    |    12 +-
 .../gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt   |    35 +
 drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt    |     4 +
 drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt    |     2 +
 .../xfails/msm-sc7180-trogdor-kingoftown-fails.txt |     5 +-
 .../msm-sc7180-trogdor-lazor-limozeen-fails.txt    |     5 +-
 drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt |     1 +
 .../gpu/drm/ci/xfails/panfrost-mt8183-fails.txt    |     1 +
 .../gpu/drm/ci/xfails/panfrost-rk3288-fails.txt    |     1 +
 .../gpu/drm/ci/xfails/panfrost-rk3399-fails.txt    |     1 +
 drivers/gpu/drm/ci/xfails/panthor-rk3588-fails.txt |     5 +
 drivers/gpu/drm/ci/xfails/panthor-rk3588-skips.txt |    20 +
 .../gpu/drm/ci/xfails/rockchip-rk3288-fails.txt    |    15 +-
 .../gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt   |    21 +
 .../gpu/drm/ci/xfails/rockchip-rk3399-fails.txt    |    12 +-
 .../gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt   |    35 +
 .../gpu/drm/ci/xfails/rockchip-rk3588-fails.txt    |     9 +
 .../gpu/drm/ci/xfails/rockchip-rk3588-skips.txt    |    14 +
 .../gpu/drm/ci/xfails/virtio_gpu-none-fails.txt    |    66 +-
 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt      |     2 +
 drivers/gpu/drm/display/drm_bridge_connector.c     |    22 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |    36 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |    25 +-
 drivers/gpu/drm/display/drm_hdmi_helper.c          |     7 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |    60 +-
 drivers/gpu/drm/drm_atomic.c                       |    30 +-
 drivers/gpu/drm/drm_atomic_helper.c                |     6 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |    24 +
 drivers/gpu/drm/drm_atomic_uapi.c                  |     4 +
 drivers/gpu/drm/drm_blend.c                        |    39 +-
 drivers/gpu/drm/drm_bridge.c                       |    66 +-
 drivers/gpu/drm/drm_buddy.c                        |  1272 +-
 drivers/gpu/drm/drm_client.c                       |     3 +-
 drivers/gpu/drm/drm_colorop.c                      |    77 +-
 drivers/gpu/drm/drm_connector.c                    |    49 +-
 drivers/gpu/drm/drm_crtc.c                         |    10 +-
 drivers/gpu/drm/drm_drv.c                          |     8 +-
 drivers/gpu/drm/drm_edid.c                         |    18 +-
 drivers/gpu/drm/drm_fb_helper.c                    |    49 +-
 drivers/gpu/drm/drm_gem.c                          |    56 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c            |    22 -
 drivers/gpu/drm/drm_gem_dma_helper.c               |    23 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |    76 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |     7 +-
 drivers/gpu/drm/drm_gpusvm.c                       |    14 +-
 drivers/gpu/drm/drm_mipi_dbi.c                     |   394 +-
 drivers/gpu/drm/drm_mode_config.c                  |    12 +
 drivers/gpu/drm/drm_modeset_helper.c               |     3 -
 drivers/gpu/drm/drm_pagemap.c                      |   157 +-
 drivers/gpu/drm/drm_prime.c                        |     2 +-
 drivers/gpu/drm/drm_probe_helper.c                 |     2 +-
 drivers/gpu/drm/drm_ras.c                          |   354 +
 drivers/gpu/drm/drm_ras_genl_family.c              |    42 +
 drivers/gpu/drm/drm_ras_nl.c                       |    56 +
 drivers/gpu/drm/drm_ras_nl.h                       |    24 +
 drivers/gpu/drm/drm_self_refresh_helper.c          |     2 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |    83 -
 drivers/gpu/drm/drm_suballoc.c                     |   106 +-
 drivers/gpu/drm/drm_writeback.c                    |     2 +-
 drivers/gpu/drm/gma500/fbdev.c                     |   101 +-
 drivers/gpu/drm/gma500/framebuffer.c               |   104 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |     6 -
 drivers/gpu/drm/gud/gud_pipe.c                     |     2 +-
 drivers/gpu/drm/i915/Makefile                      |     8 +-
 drivers/gpu/drm/i915/display/g4x_dp.c              |     1 -
 drivers/gpu/drm/i915/display/g4x_hdmi.c            |     1 -
 drivers/gpu/drm/i915/display/hsw_ips.c             |    10 +-
 drivers/gpu/drm/i915/display/i9xx_plane.c          |     1 -
 drivers/gpu/drm/i915/display/i9xx_wm.c             |    10 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |    24 +-
 drivers/gpu/drm/i915/display/icl_dsi_regs.h        |     3 +-
 drivers/gpu/drm/i915/display/intel_alpm.c          |   144 +-
 drivers/gpu/drm/i915/display/intel_alpm.h          |     9 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |    24 +-
 drivers/gpu/drm/i915/display/intel_backlight.c     |     1 -
 drivers/gpu/drm/i915/display/intel_bios.c          |    31 +-
 drivers/gpu/drm/i915/display/intel_bo.c            |   100 +-
 drivers/gpu/drm/i915/display/intel_bo.h            |    14 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |    24 +-
 drivers/gpu/drm/i915/display/intel_casf.c          |     7 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |    63 +-
 .../gpu/drm/i915/display/intel_color_pipeline.c    |   175 +-
 drivers/gpu/drm/i915/display/intel_colorop.c       |     6 +
 drivers/gpu/drm/i915/display/intel_colorop.h       |     1 +
 drivers/gpu/drm/i915/display/intel_crt.c           |    18 +-
 drivers/gpu/drm/i915/display/intel_crt_regs.h      |     2 -
 drivers/gpu/drm/i915/display/intel_crtc.c          |     4 +-
 drivers/gpu/drm/i915/display/intel_cursor.c        |     3 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |   747 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.h       |     6 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h  |     4 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |    33 +-
 drivers/gpu/drm/i915/display/intel_de.c            |   178 +
 drivers/gpu/drm/i915/display/intel_de.h            |   116 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   185 +-
 drivers/gpu/drm/i915/display/intel_display.h       |    27 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |     2 +-
 .../gpu/drm/i915/display/intel_display_device.c    |    39 +-
 .../gpu/drm/i915/display/intel_display_device.h    |     2 +
 .../gpu/drm/i915/display/intel_display_driver.c    |    22 +-
 drivers/gpu/drm/i915/display/intel_display_irq.c   |    11 +-
 .../gpu/drm/i915/display/intel_display_limits.h    |    26 +
 drivers/gpu/drm/i915/display/intel_display_power.c |    29 +-
 .../gpu/drm/i915/display/intel_display_power_map.c |    13 -
 .../drm/i915/display/intel_display_power_well.c    |    72 +-
 .../drm/i915/display/intel_display_power_well.h    |     2 -
 drivers/gpu/drm/i915/display/intel_display_regs.h  |   268 +-
 drivers/gpu/drm/i915/display/intel_display_rps.c   |     2 +-
 .../gpu/drm/i915/display/intel_display_snapshot.c  |     4 -
 drivers/gpu/drm/i915/display/intel_display_types.h |    15 +-
 drivers/gpu/drm/i915/display/intel_display_wa.c    |    83 +-
 drivers/gpu/drm/i915/display/intel_display_wa.h    |    28 +-
 drivers/gpu/drm/i915/display/intel_dmc.c           |    20 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   864 +-
 drivers/gpu/drm/i915/display/intel_dp.h            |    20 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |    85 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   213 +-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c     |    96 +-
 drivers/gpu/drm/i915/display/intel_dpll.c          |    30 +-
 drivers/gpu/drm/i915/display/intel_dpll.h          |     1 +
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   197 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |     4 +-
 drivers/gpu/drm/i915/display/intel_dpt.c           |   328 +-
 drivers/gpu/drm/i915/display/intel_dpt.h           |    22 +-
 drivers/gpu/drm/i915/display/intel_dpt_common.c    |    35 -
 drivers/gpu/drm/i915/display/intel_dpt_common.h    |    13 -
 drivers/gpu/drm/i915/display/intel_dram.c          |     9 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |   107 +-
 drivers/gpu/drm/i915/display/intel_dsb_buffer.h    |    22 -
 drivers/gpu/drm/i915/display/intel_dsi.h           |     7 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |    12 +-
 drivers/gpu/drm/i915/display/intel_fb.c            |    41 +-
 drivers/gpu/drm/i915/display/intel_fb_bo.c         |   101 -
 drivers/gpu/drm/i915/display/intel_fb_bo.h         |    25 -
 drivers/gpu/drm/i915/display/intel_fb_pin.c        |    15 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |    17 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |     5 +-
 drivers/gpu/drm/i915/display/intel_fbdev_fb.c      |    38 +-
 drivers/gpu/drm/i915/display/intel_fbdev_fb.h      |     1 +
 drivers/gpu/drm/i915/display/intel_fdi.c           |     1 -
 drivers/gpu/drm/i915/display/intel_fifo_underrun.c |     1 -
 drivers/gpu/drm/i915/display/intel_flipq.c         |    13 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |    37 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.h   |    21 +-
 drivers/gpu/drm/i915/display/intel_gmbus.c         |     9 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |    18 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |    19 +-
 drivers/gpu/drm/i915/display/intel_hotplug_irq.c   |     1 -
 drivers/gpu/drm/i915/display/intel_lt_phy.c        |   434 +-
 drivers/gpu/drm/i915/display/intel_lt_phy.h        |    28 +-
 drivers/gpu/drm/i915/display/intel_lt_phy_regs.h   |     8 +-
 drivers/gpu/drm/i915/display/intel_modeset_setup.c |     4 +-
 .../gpu/drm/i915/display/intel_modeset_verify.c    |     1 -
 drivers/gpu/drm/i915/display/intel_oprom_regs.h    |    15 +
 drivers/gpu/drm/i915/display/intel_overlay.c       |   584 +-
 drivers/gpu/drm/i915/display/intel_overlay.h       |    48 -
 drivers/gpu/drm/i915/display/intel_parent.c        |   156 +
 drivers/gpu/drm/i915/display/intel_parent.h        |    51 +
 drivers/gpu/drm/i915/display/intel_pch.c           |    93 +
 drivers/gpu/drm/i915/display/intel_pch.h           |     1 +
 drivers/gpu/drm/i915/display/intel_pch_display.c   |     1 -
 drivers/gpu/drm/i915/display/intel_pch_refclk.c    |     1 -
 drivers/gpu/drm/i915/display/intel_plane.c         |    60 +-
 drivers/gpu/drm/i915/display/intel_pmdemand.c      |     8 +-
 drivers/gpu/drm/i915/display/intel_pps.c           |     1 -
 drivers/gpu/drm/i915/display/intel_psr.c           |    65 +-
 drivers/gpu/drm/i915/display/intel_psr.h           |     1 +
 drivers/gpu/drm/i915/display/intel_quirks.c        |    25 +-
 drivers/gpu/drm/i915/display/intel_quirks.h        |     1 +
 drivers/gpu/drm/i915/display/intel_rom.c           |     3 +-
 drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c |     2 -
 drivers/gpu/drm/i915/display/intel_tc.c            |     5 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |     1 +
 drivers/gpu/drm/i915/display/intel_vdsc.c          |    73 +-
 drivers/gpu/drm/i915/display/intel_vdsc.h          |     9 +
 drivers/gpu/drm/i915/display/intel_vga.c           |   333 +-
 drivers/gpu/drm/i915/display/intel_vga.h           |     5 +-
 drivers/gpu/drm/i915/display/intel_vrr.c           |    41 +-
 drivers/gpu/drm/i915/display/intel_vrr.h           |     1 +
 drivers/gpu/drm/i915/display/intel_vrr_regs.h      |     1 +
 drivers/gpu/drm/i915/display/skl_scaler.c          |     2 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.c |     7 +-
 drivers/gpu/drm/i915/display/skl_watermark.c       |   188 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |     3 +-
 drivers/gpu/drm/i915/gem/i915_gem_clflush.c        |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |     6 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |    30 +-
 .../gpu/drm/i915/gem/i915_gem_object_frontbuffer.c |    69 +
 .../gpu/drm/i915/gem/i915_gem_object_frontbuffer.h |    24 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |     4 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c       |     2 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |    27 +-
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c               |     2 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |     2 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |    10 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |     2 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |     6 +-
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |     7 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |     1 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |     2 +
 drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c      |     1 +
 drivers/gpu/drm/i915/gt/intel_gt_regs.h            |    11 +-
 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c        |     2 +
 drivers/gpu/drm/i915/gt/intel_llc.c                |     2 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                |    21 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c                |    24 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |     4 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |    21 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |     1 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |    26 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |     4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c          |     4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |    10 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |     4 +-
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c          |     2 +-
 .../gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c    |     2 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |     1 +
 drivers/gpu/drm/i915/gvt/display.c                 |     1 -
 drivers/gpu/drm/i915/gvt/edid.c                    |    18 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |    48 +-
 drivers/gpu/drm/i915/gvt/interrupt.c               |     1 +
 drivers/gpu/drm/i915/gvt/mmio_context.c            |     3 +-
 drivers/gpu/drm/i915/gvt/reg.h                     |     4 +-
 drivers/gpu/drm/i915/i915_active.c                 |    21 +-
 drivers/gpu/drm/i915/i915_bo.c                     |   156 +
 drivers/gpu/drm/i915/i915_bo.h                     |     9 +
 drivers/gpu/drm/i915/i915_debugfs.c                |     1 +
 drivers/gpu/drm/i915/i915_dpt.c                    |   277 +
 drivers/gpu/drm/i915/i915_dpt.h                    |    20 +
 drivers/gpu/drm/i915/i915_driver.c                 |    32 +-
 drivers/gpu/drm/i915/i915_drv.h                    |     5 +-
 .../intel_dsb_buffer.c =3D> i915_dsb_buffer.c}       |    28 +-
 drivers/gpu/drm/i915/i915_dsb_buffer.h             |     9 +
 drivers/gpu/drm/i915/i915_gem.c                    |     6 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |     6 -
 drivers/gpu/drm/i915/i915_gpu_error.h              |     1 -
 drivers/gpu/drm/i915/i915_hwmon.c                  |     2 +
 drivers/gpu/drm/i915/i915_initial_plane.c          |     6 +-
 drivers/gpu/drm/i915/i915_irq.c                    |     1 +
 drivers/gpu/drm/i915/i915_overlay.c                |   517 +
 drivers/gpu/drm/i915/i915_overlay.h                |    11 +
 drivers/gpu/drm/i915/i915_perf.c                   |    34 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   465 +-
 drivers/gpu/drm/i915/i915_reg_defs.h               |   179 +-
 drivers/gpu/drm/i915/i915_scatterlist.c            |    10 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c          |     2 +-
 drivers/gpu/drm/i915/i915_ttm_buddy_manager.c      |    55 +-
 drivers/gpu/drm/i915/i915_ttm_buddy_manager.h      |     4 +-
 drivers/gpu/drm/i915/i915_vma.c                    |    10 +
 drivers/gpu/drm/i915/i915_vma.h                    |     7 +-
 drivers/gpu/drm/i915/i915_vma_resource.c           |     2 +-
 drivers/gpu/drm/i915/intel_clock_gating.c          |   128 +-
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c        |    10 +-
 drivers/gpu/drm/i915/intel_pcode.c                 |    17 +-
 drivers/gpu/drm/i915/intel_pcode.h                 |     9 +-
 drivers/gpu/drm/i915/intel_step.h                  |    57 +-
 drivers/gpu/drm/i915/intel_uncore.c                |    76 +-
 drivers/gpu/drm/i915/pxp/intel_pxp.c               |     6 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_irq.c           |     2 +-
 drivers/gpu/drm/i915/selftests/i915_active.c       |     4 +-
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c     |     2 +-
 drivers/gpu/drm/i915/selftests/igt_mmap.c          |    43 +-
 drivers/gpu/drm/i915/selftests/igt_mmap.h          |     8 +
 .../gpu/drm/i915/selftests/intel_memory_region.c   |    20 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c      |    62 -
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |     2 +-
 drivers/gpu/drm/i915/vlv_suspend.c                 |     1 +
 drivers/gpu/drm/imagination/Makefile               |     1 +
 drivers/gpu/drm/imagination/pvr_ccb.c              |    25 +-
 drivers/gpu/drm/imagination/pvr_device.h           |    10 +-
 drivers/gpu/drm/imagination/pvr_dump.c             |   113 +
 drivers/gpu/drm/imagination/pvr_dump.h             |    17 +
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |   100 +-
 drivers/gpu/drm/imagination/pvr_gem.c              |     6 +-
 drivers/gpu/drm/imagination/pvr_power.c            |   122 +-
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h       |     8 +-
 .../gpu/drm/imagination/pvr_rogue_fwif_shared.h    |    18 +-
 drivers/gpu/drm/imx/ipuv3/Kconfig                  |     1 +
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            |    23 +-
 drivers/gpu/drm/imx/ipuv3/parallel-display.c       |    15 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    28 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |    28 +-
 drivers/gpu/drm/loongson/lsdc_drv.c                |     3 +-
 drivers/gpu/drm/loongson/lsdc_gem.c                |    15 -
 drivers/gpu/drm/loongson/lsdc_gem.h                |     4 -
 drivers/gpu/drm/mcde/mcde_dsi.c                    |    17 +-
 drivers/gpu/drm/mediatek/Makefile                  |     1 -
 drivers/gpu/drm/mediatek/mtk_crtc.c                |     1 -
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |    12 +
 drivers/gpu/drm/mediatek/mtk_dp.c                  |     4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |    26 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |     1 -
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    35 +-
 drivers/gpu/drm/mediatek/mtk_gem.c                 |   231 -
 drivers/gpu/drm/mediatek/mtk_gem.h                 |    17 -
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |     8 +-
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c          |     6 +-
 drivers/gpu/drm/msm/Makefile                       |     1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |     6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    12 +-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   243 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   140 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |     9 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   170 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |     7 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |    20 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |    33 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   155 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c          |    77 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.h          |    82 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   172 +-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c          |   259 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    19 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |    13 +-
 .../drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h    |     6 +-
 .../drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h    |     6 +-
 .../drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h    |    10 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h |   363 +
 .../drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h |     6 +-
 .../drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h   |     3 +-
 .../drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h   |     3 +-
 .../drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h   |    10 +-
 .../drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h    |     3 +-
 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |     3 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h |     3 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h |     3 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |     5 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h |     3 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |     6 +-
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |     4 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h |     6 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h |     6 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h |     4 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |     6 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |     4 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |     3 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h |     4 +-
 .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |     3 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h |     3 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |     6 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |     4 +-
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |    16 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |     6 +-
 .../drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h    |    13 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |     6 +-
 .../drm/msm/disp/dpu1/catalog/dpu_9_1_sar2130p.h   |     6 +-
 .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   |    11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    57 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h           |     2 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |     6 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |     2 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |     7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |    36 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |     9 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |    26 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |     1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          |    21 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h          |     2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |     6 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.c        |     3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.h        |     1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   116 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |     4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   303 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |    19 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |   157 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           |     4 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |    94 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c           |    90 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.h           |     1 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |    40 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |     8 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |    18 -
 drivers/gpu/drm/msm/dp/dp_display.c                |     1 +
 drivers/gpu/drm/msm/dsi/dsi.c                      |     1 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |     4 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |     2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |    50 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |     1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |    16 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |    35 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |     6 +-
 drivers/gpu/drm/msm/hdmi/hdmi_audio.c              |     5 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |     8 +-
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c                |     4 +-
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c                |    12 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                |     3 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c           |     2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c           |     2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c           |     2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |     7 +-
 drivers/gpu/drm/msm/msm_fb.c                       |     7 +-
 drivers/gpu/drm/msm/msm_gem.c                      |     3 +
 drivers/gpu/drm/msm/msm_gem.h                      |     1 +
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |     5 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |     4 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |    17 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |    53 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |     9 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |     4 +
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml  |     6 +-
 drivers/gpu/drm/msm/registers/display/dsi.xml      |     5 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c                  |     8 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/gr.h   |    19 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |    29 +
 drivers/gpu/drm/nouveau/nouveau_abi16.h            |     1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c               |     2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    38 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |     3 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |    11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c    |     4 -
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c   |     9 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |     7 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gr.c   |    34 +-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gr.h  |    19 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h    |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c    |    18 +-
 drivers/gpu/drm/nova/gem.rs                        |     5 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    22 +-
 drivers/gpu/drm/panel/Kconfig                      |    79 +-
 drivers/gpu/drm/panel/Makefile                     |     9 +-
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c   |     7 +-
 drivers/gpu/drm/panel/panel-edp.c                  |    40 +-
 drivers/gpu/drm/panel/panel-himax-hx83102.c        |   151 +
 drivers/gpu/drm/panel/panel-himax-hx83121a.c       |   749 +
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c |   134 +
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h |    15 +
 ...itek-ili9806e.c =3D> panel-ilitek-ili9806e-dsi.c} |   153 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c  |   323 +
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c      |    14 +-
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   |   244 +
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |   105 +-
 drivers/gpu/drm/panel/panel-lxd-m9189a.c           |   243 +
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c   |    15 +-
 drivers/gpu/drm/panel/panel-motorola-mot.c         |   244 +
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c     |    94 +-
 drivers/gpu/drm/panel/panel-novatek-nt37700f.c     |   299 +
 drivers/gpu/drm/panel/panel-renesas-r61307.c       |    40 +-
 drivers/gpu/drm/panel/panel-renesas-r69328.c       |    38 +-
 .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  |   301 +
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |     1 +
 drivers/gpu/drm/panel/panel-simple.c               |   154 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |     2 +-
 drivers/gpu/drm/panthor/Makefile                   |     2 +
 drivers/gpu/drm/panthor/panthor_device.h           |   107 +-
 drivers/gpu/drm/panthor/panthor_drv.c              |   134 +-
 drivers/gpu/drm/panthor/panthor_fw.c               |    20 +-
 drivers/gpu/drm/panthor/panthor_gem.c              |     2 +-
 drivers/gpu/drm/panthor/panthor_gpu.c              |    30 +-
 drivers/gpu/drm/panthor/panthor_gpu.h              |     2 +
 drivers/gpu/drm/panthor/panthor_hw.c               |    62 +
 drivers/gpu/drm/panthor/panthor_hw.h               |     8 +
 drivers/gpu/drm/panthor/panthor_mmu.c              |    47 +-
 drivers/gpu/drm/panthor/panthor_pwr.c              |     2 +-
 drivers/gpu/drm/panthor/panthor_sched.c            |     2 +-
 drivers/gpu/drm/panthor/panthor_trace.h            |    86 +
 drivers/gpu/drm/qxl/qxl_release.c                  |     5 +-
 drivers/gpu/drm/radeon/radeon_device.c             |     7 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c              |    17 -
 drivers/gpu/drm/radeon/radeon_mode.h               |     5 -
 drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c         |    26 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h         |    18 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     |    16 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h     |     3 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h      |     8 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c      |    52 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      |    16 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h      |     2 +
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |    35 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |     3 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |     4 +-
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          |    27 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |    24 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h       |     4 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |     8 +-
 drivers/gpu/drm/scheduler/sched_fence.c            |    10 +-
 drivers/gpu/drm/scheduler/sched_main.c             |    38 +-
 drivers/gpu/drm/scheduler/tests/tests_basic.c      |     4 +-
 drivers/gpu/drm/sitronix/st7586.c                  |   185 +-
 drivers/gpu/drm/sitronix/st7735r.c                 |   142 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    33 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |     2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |    29 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |    16 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |    27 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h               |     7 +-
 drivers/gpu/drm/sysfb/Kconfig                      |    16 +
 drivers/gpu/drm/sysfb/Makefile                     |     1 +
 drivers/gpu/drm/sysfb/corebootdrm.c                |   434 +
 drivers/gpu/drm/sysfb/drm_sysfb.c                  |    24 +
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |     8 +-
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c      |    30 -
 drivers/gpu/drm/sysfb/efidrm.c                     |     8 +-
 drivers/gpu/drm/sysfb/vesadrm.c                    |     8 +-
 drivers/gpu/drm/tegra/hub.c                        |    22 +-
 drivers/gpu/drm/tests/Makefile                     |     1 -
 drivers/gpu/drm/tests/drm_buddy_test.c             |   928 -
 drivers/gpu/drm/tests/drm_connector_test.c         |    80 +-
 drivers/gpu/drm/tests/drm_exec_test.c              |     2 -
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   182 +-
 drivers/gpu/drm/tests/drm_mm_test.c                |     2 -
 drivers/gpu/drm/tilcdc/Kconfig                     |    18 +
 drivers/gpu/drm/tilcdc/Makefile                    |     5 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |   192 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   496 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |    99 +-
 drivers/gpu/drm/tilcdc/tilcdc_encoder.c            |    69 +
 .../tilcdc/{tilcdc_external.h =3D> tilcdc_encoder.h} |     5 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |   179 -
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |   408 -
 drivers/gpu/drm/tilcdc/tilcdc_panel.h              |    15 -
 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c       |   185 +
 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso    |    29 +
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |    35 +-
 drivers/gpu/drm/tilcdc/tilcdc_regs.h               |     8 +-
 drivers/gpu/drm/tiny/hx8357d.c                     |   138 +-
 drivers/gpu/drm/tiny/ili9163.c                     |   138 +-
 drivers/gpu/drm/tiny/ili9225.c                     |   192 +-
 drivers/gpu/drm/tiny/ili9341.c                     |   138 +-
 drivers/gpu/drm/tiny/ili9486.c                     |   139 +-
 drivers/gpu/drm/tiny/mi0283qt.c                    |   138 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c              |   141 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c   |    45 +-
 drivers/gpu/drm/ttm/tests/ttm_device_test.c        |     2 +-
 drivers/gpu/drm/ttm/tests/ttm_mock_manager.c       |    18 +-
 drivers/gpu/drm/ttm/tests/ttm_mock_manager.h       |     4 +-
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c          |    34 +-
 drivers/gpu/drm/ttm/ttm_backup.c                   |     6 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    12 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |   215 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 |    28 +-
 drivers/gpu/drm/tyr/driver.rs                      |    98 +-
 drivers/gpu/drm/tyr/file.rs                        |    34 +-
 drivers/gpu/drm/tyr/gem.rs                         |    18 +-
 drivers/gpu/drm/tyr/gpu.rs                         |    56 +-
 drivers/gpu/drm/tyr/regs.rs                        |    16 +-
 drivers/gpu/drm/tyr/tyr.rs                         |     4 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |    55 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |    51 +-
 drivers/gpu/drm/v3d/v3d_fence.c                    |     2 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |    43 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |     2 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |    57 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |   133 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   |     6 +
 drivers/gpu/drm/v3d/v3d_sysfs.c                    |     2 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |     2 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |     5 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |     2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    36 +-
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |     2 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |    67 +-
 drivers/gpu/drm/vc4/vc4_perfmon.c                  |    51 +-
 drivers/gpu/drm/verisilicon/Kconfig                |    16 +
 drivers/gpu/drm/verisilicon/Makefile               |     5 +
 drivers/gpu/drm/verisilicon/vs_bridge.c            |   371 +
 drivers/gpu/drm/verisilicon/vs_bridge.h            |    39 +
 drivers/gpu/drm/verisilicon/vs_bridge_regs.h       |    54 +
 drivers/gpu/drm/verisilicon/vs_crtc.c              |   191 +
 drivers/gpu/drm/verisilicon/vs_crtc.h              |    31 +
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h         |    60 +
 drivers/gpu/drm/verisilicon/vs_dc.c                |   207 +
 drivers/gpu/drm/verisilicon/vs_dc.h                |    38 +
 drivers/gpu/drm/verisilicon/vs_dc_top_regs.h       |    27 +
 drivers/gpu/drm/verisilicon/vs_drm.c               |   182 +
 drivers/gpu/drm/verisilicon/vs_drm.h               |    28 +
 drivers/gpu/drm/verisilicon/vs_hwdb.c              |   150 +
 drivers/gpu/drm/verisilicon/vs_hwdb.h              |    29 +
 drivers/gpu/drm/verisilicon/vs_plane.c             |   124 +
 drivers/gpu/drm/verisilicon/vs_plane.h             |    72 +
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |   173 +
 .../gpu/drm/verisilicon/vs_primary_plane_regs.h    |    53 +
 drivers/gpu/drm/virtio/virtgpu_prime.c             |     4 +-
 drivers/gpu/drm/vkms/vkms_colorop.c                |    16 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |     8 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |     3 +
 drivers/gpu/drm/vkms/vkms_drv.c                    |     1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |     3 +-
 drivers/gpu/drm/xe/Makefile                        |    12 +-
 drivers/gpu/drm/xe/compat-i915-headers/i915_reg.h  |     6 -
 drivers/gpu/drm/xe/compat-i915-headers/i915_vma.h  |    36 -
 .../gpu/drm/xe/compat-i915-headers/intel_pcode.h   |    11 -
 .../gpu/drm/xe/compat-i915-headers/intel_step.h    |     3 +-
 .../gpu/drm/xe/compat-i915-headers/intel_uncore.h  |    40 +-
 drivers/gpu/drm/xe/display/intel_bo.c              |   109 -
 drivers/gpu/drm/xe/display/intel_fbdev_fb.c        |    39 +-
 drivers/gpu/drm/xe/display/xe_display.c            |    16 +
 .../xe/display/{intel_fb_bo.c =3D> xe_display_bo.c}  |    69 +-
 drivers/gpu/drm/xe/display/xe_display_bo.h         |     9 +
 drivers/gpu/drm/xe/display/xe_display_pcode.c      |    38 +
 drivers/gpu/drm/xe/display/xe_display_pcode.h      |     9 +
 drivers/gpu/drm/xe/display/xe_display_vma.h        |    18 +
 drivers/gpu/drm/xe/display/xe_dsb_buffer.c         |    32 +-
 drivers/gpu/drm/xe/display/xe_dsb_buffer.h         |     9 +
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |   149 +-
 drivers/gpu/drm/xe/display/xe_frontbuffer.c        |    71 +
 drivers/gpu/drm/xe/display/xe_frontbuffer.h        |     9 +
 drivers/gpu/drm/xe/display/xe_initial_plane.c      |    29 +-
 .../gpu/drm/xe/instructions/xe_gfxpipe_commands.h  |    10 +
 drivers/gpu/drm/xe/instructions/xe_mi_commands.h   |    19 +
 drivers/gpu/drm/xe/regs/xe_engine_regs.h           |     8 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |    31 +-
 drivers/gpu/drm/xe/regs/xe_guc_regs.h              |     8 +
 drivers/gpu/drm/xe/regs/xe_hw_error_regs.h         |    86 +-
 drivers/gpu/drm/xe/regs/xe_reg_defs.h              |     5 +-
 drivers/gpu/drm/xe/tests/xe_dma_buf.c              |     7 +-
 .../gpu/drm/xe/tests/xe_gt_sriov_pf_config_kunit.c |    98 +-
 drivers/gpu/drm/xe/tests/xe_guc_buf_kunit.c        |     6 +-
 drivers/gpu/drm/xe/tests/xe_guc_g2g_test.c         |    61 +-
 drivers/gpu/drm/xe/tests/xe_pci_test.c             |     8 +
 drivers/gpu/drm/xe/tests/xe_rtp_test.c             |     3 +-
 drivers/gpu/drm/xe/xe_bb.c                         |    59 +-
 drivers/gpu/drm/xe/xe_bb.h                         |     6 +-
 drivers/gpu/drm/xe/xe_bo.c                         |   279 +-
 drivers/gpu/drm/xe/xe_bo.h                         |    62 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |     6 +
 drivers/gpu/drm/xe/xe_configfs.c                   |    64 +-
 drivers/gpu/drm/xe/xe_configfs.h                   |    16 +-
 drivers/gpu/drm/xe/xe_defaults.h                   |    26 +
 drivers/gpu/drm/xe/xe_devcoredump.c                |     2 +-
 drivers/gpu/drm/xe/xe_device.c                     |   105 +-
 drivers/gpu/drm/xe/xe_device.h                     |    21 +-
 drivers/gpu/drm/xe/xe_device_types.h               |   206 +-
 drivers/gpu/drm/xe/xe_device_wa_oob.rules          |     1 +
 drivers/gpu/drm/xe/xe_dma_buf.c                    |    38 +-
 drivers/gpu/drm/xe/xe_drm_ras.c                    |   186 +
 drivers/gpu/drm/xe/xe_drm_ras.h                    |    15 +
 drivers/gpu/drm/xe/xe_drm_ras_types.h              |    48 +
 drivers/gpu/drm/xe/xe_eu_stall.c                   |    20 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |   244 +-
 drivers/gpu/drm/xe/xe_exec_queue.h                 |     1 +
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |    21 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |    15 +-
 drivers/gpu/drm/xe/xe_force_wake.c                 |    46 +-
 drivers/gpu/drm/xe/xe_force_wake.h                 |    11 +
 drivers/gpu/drm/xe/xe_ggtt.c                       |   389 +-
 drivers/gpu/drm/xe/xe_ggtt.h                       |    14 +-
 drivers/gpu/drm/xe/xe_ggtt_types.h                 |    63 +-
 drivers/gpu/drm/xe/xe_gt.c                         |    63 +-
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                |    44 +-
 drivers/gpu/drm/xe/xe_gt_debugfs.c                 |    26 +
 drivers/gpu/drm/xe/xe_gt_idle.c                    |    25 +
 drivers/gpu/drm/xe/xe_gt_idle_types.h              |     6 +-
 drivers/gpu/drm/xe/xe_gt_mcr.c                     |    30 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |   242 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h         |     4 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c        |    80 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_control.h        |     1 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_control_types.h  |     2 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_service.c        |     2 +
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                |    89 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h                |     3 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf_types.h          |     4 +-
 drivers/gpu/drm/xe/xe_gt_stats.c                   |    70 +-
 drivers/gpu/drm/xe/xe_gt_stats.h                   |     6 +
 drivers/gpu/drm/xe/xe_gt_stats_types.h             |    26 +
 drivers/gpu/drm/xe/xe_gt_topology.c                |    39 +-
 drivers/gpu/drm/xe/xe_gt_types.h                   |    22 +-
 drivers/gpu/drm/xe/xe_guc.c                        |    85 +-
 drivers/gpu/drm/xe/xe_guc_ads.c                    |    11 +
 drivers/gpu/drm/xe/xe_guc_ct.c                     |   142 +-
 drivers/gpu/drm/xe/xe_guc_ct_types.h               |     6 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |     4 +-
 drivers/gpu/drm/xe/xe_guc_fwif.h                   |     6 +-
 drivers/gpu/drm/xe/xe_guc_log.h                    |     6 +-
 drivers/gpu/drm/xe/xe_guc_pagefault.c              |    18 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                     |   126 +-
 drivers/gpu/drm/xe/xe_guc_pc.h                     |     6 +-
 drivers/gpu/drm/xe/xe_guc_rc.c                     |   131 +
 drivers/gpu/drm/xe/xe_guc_rc.h                     |    16 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   183 +-
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c              |   242 +-
 drivers/gpu/drm/xe/xe_heci_gsc.h                   |     6 +-
 drivers/gpu/drm/xe/xe_hw_engine.c                  |    14 +-
 drivers/gpu/drm/xe/xe_hw_engine_class_sysfs.h      |     4 +-
 drivers/gpu/drm/xe/xe_hw_engine_group.c            |     3 +-
 drivers/gpu/drm/xe/xe_hw_error.c                   |   451 +-
 drivers/gpu/drm/xe/xe_hw_fence.c                   |     3 +-
 drivers/gpu/drm/xe/xe_i2c.c                        |    17 +-
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h         |     4 +-
 drivers/gpu/drm/xe/xe_lmtt.c                       |    17 +
 drivers/gpu/drm/xe/xe_lmtt.h                       |     1 +
 drivers/gpu/drm/xe/xe_lrc.c                        |   398 +-
 drivers/gpu/drm/xe/xe_lrc.h                        |     5 +
 drivers/gpu/drm/xe/xe_lrc_types.h                  |     6 +
 drivers/gpu/drm/xe/xe_migrate.c                    |   262 +-
 drivers/gpu/drm/xe/xe_migrate.h                    |     4 +
 drivers/gpu/drm/xe/xe_mmio.c                       |     9 +
 drivers/gpu/drm/xe/xe_mmio.h                       |     8 +-
 drivers/gpu/drm/xe/xe_mmio_types.h                 |    64 +
 drivers/gpu/drm/xe/xe_mocs.c                       |     1 +
 drivers/gpu/drm/xe/xe_module.c                     |    44 +-
 drivers/gpu/drm/xe/xe_nvm.c                        |    12 +-
 drivers/gpu/drm/xe/xe_oa.c                         |    66 +-
 drivers/gpu/drm/xe/xe_oa_types.h                   |     3 -
 drivers/gpu/drm/xe/xe_page_reclaim.c               |    26 +
 drivers/gpu/drm/xe/xe_page_reclaim.h               |     3 +
 drivers/gpu/drm/xe/xe_pagefault.c                  |    72 +-
 drivers/gpu/drm/xe/xe_pagefault_types.h            |    20 +-
 drivers/gpu/drm/xe/xe_pat.c                        |   176 +-
 drivers/gpu/drm/xe/xe_pat.h                        |     5 +-
 drivers/gpu/drm/xe/xe_pci.c                        |    71 +-
 drivers/gpu/drm/xe/xe_pci_types.h                  |     5 +
 drivers/gpu/drm/xe/xe_pcode.c                      |    30 -
 drivers/gpu/drm/xe/xe_pcode.h                      |     8 -
 drivers/gpu/drm/xe/xe_platform_types.h             |     5 +-
 drivers/gpu/drm/xe/xe_pt.c                         |    40 +-
 drivers/gpu/drm/xe/xe_pxp.c                        |     4 +-
 drivers/gpu/drm/xe/xe_query.c                      |     7 +-
 drivers/gpu/drm/xe/xe_reg_sr.c                     |    72 +-
 drivers/gpu/drm/xe/xe_reg_sr.h                     |     7 +
 drivers/gpu/drm/xe/xe_reg_whitelist.c              |    12 +-
 drivers/gpu/drm/xe/xe_res_cursor.h                 |    34 +-
 drivers/gpu/drm/xe/xe_ring_ops.c                   |   143 +-
 drivers/gpu/drm/xe/xe_ring_ops_types.h             |     8 +-
 drivers/gpu/drm/xe/xe_rtp.c                        |    15 +-
 drivers/gpu/drm/xe/xe_rtp.h                        |    23 +-
 drivers/gpu/drm/xe/xe_rtp_types.h                  |     1 +
 drivers/gpu/drm/xe/xe_sa.c                         |    36 +
 drivers/gpu/drm/xe/xe_sa.h                         |     2 +
 drivers/gpu/drm/xe/xe_sched_job.c                  |     4 +-
 drivers/gpu/drm/xe/xe_sched_job_types.h            |     2 +
 drivers/gpu/drm/xe/xe_sleep.h                      |    57 +
 drivers/gpu/drm/xe/xe_soc_remapper.c               |     1 +
 drivers/gpu/drm/xe/xe_sriov.c                      |     2 +-
 drivers/gpu/drm/xe/xe_sriov.h                      |     7 +-
 drivers/gpu/drm/xe/xe_sriov_pf.c                   |    10 +-
 drivers/gpu/drm/xe/xe_sriov_pf_control.c           |    24 +
 drivers/gpu/drm/xe/xe_sriov_pf_control.h           |     1 +
 drivers/gpu/drm/xe/xe_sriov_pf_helpers.h           |     3 +-
 drivers/gpu/drm/xe/xe_sriov_pf_provision.c         |   119 +-
 drivers/gpu/drm/xe/xe_sriov_pf_provision.h         |     4 +
 drivers/gpu/drm/xe/xe_sriov_pf_sysfs.c             |    31 +-
 drivers/gpu/drm/xe/xe_sriov_pf_types.h             |     3 +
 drivers/gpu/drm/xe/xe_sriov_vfio.c                 |     1 +
 drivers/gpu/drm/xe/xe_step.c                       |    74 +-
 drivers/gpu/drm/xe/xe_step.h                       |    10 +-
 drivers/gpu/drm/xe/xe_step_types.h                 |     1 +
 drivers/gpu/drm/xe/xe_svm.c                        |    48 +-
 drivers/gpu/drm/xe/xe_tile.h                       |     4 +-
 drivers/gpu/drm/xe/xe_tile_printk.h                |     4 +-
 drivers/gpu/drm/xe/xe_tile_sriov_vf.c              |   198 +-
 drivers/gpu/drm/xe/xe_tile_sriov_vf.h              |     3 -
 drivers/gpu/drm/xe/xe_tile_sysfs.c                 |     2 +-
 drivers/gpu/drm/xe/xe_tile_types.h                 |   141 +
 drivers/gpu/drm/xe/xe_tlb_inval.c                  |   117 +
 drivers/gpu/drm/xe/xe_tlb_inval.h                  |     8 +
 drivers/gpu/drm/xe/xe_tlb_inval_types.h            |    14 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               |    85 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h         |     4 +-
 drivers/gpu/drm/xe/xe_tuning.c                     |    36 +-
 drivers/gpu/drm/xe/xe_uc.c                         |    30 +-
 drivers/gpu/drm/xe/xe_uc.h                         |     1 -
 drivers/gpu/drm/xe/xe_uc_fw.c                      |     4 +-
 drivers/gpu/drm/xe/xe_userptr.c                    |   155 +-
 drivers/gpu/drm/xe/xe_userptr.h                    |    31 +-
 drivers/gpu/drm/xe/xe_vm.c                         |   519 +-
 drivers/gpu/drm/xe/xe_vm.h                         |    27 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |   322 +-
 drivers/gpu/drm/xe/xe_vm_madvise.h                 |     3 +
 drivers/gpu/drm/xe/xe_vm_types.h                   |    60 +
 drivers/gpu/drm/xe/xe_vram_freq.c                  |     2 +-
 drivers/gpu/drm/xe/xe_wa.c                         |   391 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |    39 +-
 drivers/gpu/drm/xe/xe_wopcm.c                      |    15 +-
 drivers/gpu/nova-core/Kconfig                      |     2 +-
 drivers/gpu/nova-core/bitfield.rs                  |     5 +-
 drivers/gpu/nova-core/dma.rs                       |    54 -
 drivers/gpu/nova-core/driver.rs                    |    17 +-
 drivers/gpu/nova-core/falcon.rs                    |   806 +-
 drivers/gpu/nova-core/falcon/gsp.rs                |    27 +-
 drivers/gpu/nova-core/falcon/hal.rs                |     6 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |    70 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |    12 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |    17 +-
 drivers/gpu/nova-core/fb.rs                        |   101 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs              |    37 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs              |     7 +-
 drivers/gpu/nova-core/fb/hal/tu102.rs              |    17 +-
 drivers/gpu/nova-core/firmware.rs                  |   194 +-
 drivers/gpu/nova-core/firmware/booter.rs           |    87 +-
 drivers/gpu/nova-core/firmware/fwsec.rs            |   181 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   350 +
 drivers/gpu/nova-core/firmware/gsp.rs              |   118 +-
 drivers/gpu/nova-core/firmware/riscv.rs            |    10 +-
 drivers/gpu/nova-core/gfw.rs                       |    11 +-
 drivers/gpu/nova-core/gpu.rs                       |    66 +-
 drivers/gpu/nova-core/gsp.rs                       |   118 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |    82 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   439 +-
 drivers/gpu/nova-core/gsp/cmdq/continuation.rs     |   307 +
 drivers/gpu/nova-core/gsp/commands.rs              |    23 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |   309 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs           |    17 +-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs  |     1 +
 drivers/gpu/nova-core/gsp/sequencer.rs             |    22 +-
 drivers/gpu/nova-core/nova_core.rs                 |    54 +-
 drivers/gpu/nova-core/num.rs                       |    80 +
 drivers/gpu/nova-core/regs.rs                      |   571 +-
 drivers/gpu/nova-core/regs/macros.rs               |   739 -
 drivers/gpu/nova-core/vbios.rs                     |     7 +-
 drivers/gpu/tests/Makefile                         |     4 +
 drivers/gpu/tests/gpu_buddy_test.c                 |  1421 +
 .../{drm/lib/drm_random.c =3D> tests/gpu_random.c}   |    18 +-
 .../{drm/lib/drm_random.h =3D> tests/gpu_random.h}   |    18 +-
 drivers/infiniband/core/ib_core_uverbs.c           |     2 +-
 drivers/infiniband/core/umem_dmabuf.c              |    10 -
 drivers/infiniband/core/uverbs_std_types_dmabuf.c  |     2 +-
 drivers/infiniband/hw/mlx5/mr.c                    |     2 +-
 drivers/iommu/iommufd/pages.c                      |    11 +-
 drivers/iommu/iommufd/selftest.c                   |     2 +-
 drivers/vfio/pci/vfio_pci_dmabuf.c                 |    80 +-
 drivers/vfio/pci/xe/main.c                         |    14 +
 drivers/video/Kconfig                              |     1 +
 fs/proc/meminfo.c                                  |     6 +
 include/drm/bridge/dw_dp.h                         |     7 +
 include/drm/bridge/dw_hdmi_qp.h                    |     2 +-
 include/drm/display/drm_hdmi_helper.h              |     3 +-
 include/drm/drm_atomic.h                           |    20 +-
 include/drm/drm_atomic_state_helper.h              |     3 +
 include/drm/drm_blend.h                            |     4 +-
 include/drm/drm_bridge.h                           |     6 +-
 include/drm/drm_buddy.h                            |   163 +-
 include/drm/drm_client.h                           |     3 +
 include/drm/drm_colorop.h                          |    32 +-
 include/drm/drm_connector.h                        |    49 +-
 include/drm/drm_crtc.h                             |    12 +
 include/drm/drm_fb_helper.h                        |   107 +-
 include/drm/drm_mipi_dbi.h                         |   145 +-
 include/drm/drm_mipi_dsi.h                         |     4 +
 include/drm/drm_mode_config.h                      |     9 +
 include/drm/drm_pagemap.h                          |    21 +
 include/drm/drm_ras.h                              |    75 +
 include/drm/drm_ras_genl_family.h                  |    17 +
 include/drm/drm_simple_kms_helper.h                |   216 +-
 include/drm/drm_suballoc.h                         |     6 +
 include/drm/intel/display_parent_interface.h       |   108 +
 include/drm/intel/i915_drm.h                       |    82 +-
 include/drm/intel/intel_gmd_interrupt_regs.h       |    92 +
 include/drm/intel/intel_gmd_misc_regs.h            |    21 +
 include/drm/intel/intel_pcode_regs.h               |   108 +
 include/drm/intel/pciids.h                         |    12 +
 include/drm/intel/pick.h                           |    51 +
 include/drm/intel/reg_bits.h                       |   139 +
 include/drm/intel/step.h                           |    62 +
 include/drm/intel/xe_sriov_vfio.h                  |    11 +
 include/drm/ttm/ttm_backup.h                       |     2 +-
 include/drm/ttm/ttm_bo.h                           |    28 +-
 include/drm/ttm/ttm_pool.h                         |     7 +-
 include/linux/coreboot.h                           |    90 +
 include/linux/dma-buf.h                            |    17 +-
 include/linux/dma-fence-array.h                    |     1 -
 include/linux/dma-fence-chain.h                    |     1 -
 include/linux/dma-fence.h                          |    97 +-
 include/linux/gpu_buddy.h                          |   241 +
 include/linux/iopoll.h                             |     8 +-
 include/linux/math.h                               |    18 +-
 include/linux/mmu_notifier.h                       |    42 +
 include/linux/mmzone.h                             |     2 +
 include/trace/events/dma_fence.h                   |    35 +-
 include/uapi/drm/amdgpu_drm.h                      |     7 +-
 include/uapi/drm/amdxdna_accel.h                   |    47 +-
 include/uapi/drm/drm_fourcc.h                      |    16 +
 include/uapi/drm/drm_mode.h                        |    84 +
 include/uapi/drm/drm_ras.h                         |    49 +
 include/uapi/drm/msm_drm.h                         |     1 +
 include/uapi/drm/nouveau_drm.h                     |    66 +
 include/uapi/drm/panthor_drm.h                     |    63 +-
 include/uapi/drm/xe_drm.h                          |   268 +-
 include/uapi/linux/const.h                         |    18 +
 include/video/vga.h                                |     1 +
 mm/list_lru.c                                      |     1 +
 mm/mmu_notifier.c                                  |    65 +-
 mm/show_mem.c                                      |     6 +-
 mm/vmstat.c                                        |     2 +
 rust/bindings/bindings_helper.h                    |    14 +
 rust/helpers/device.c                              |     5 +
 rust/helpers/dma-resv.c                            |    14 +
 rust/helpers/drm.c                                 |    56 +-
 rust/helpers/gpu.c                                 |    17 +
 rust/helpers/helpers.c                             |     3 +
 rust/helpers/list.c                                |    17 +
 rust/kernel/device.rs                              |    15 +-
 rust/kernel/dma.rs                                 |   899 +-
 rust/kernel/drm/device.rs                          |    87 +-
 rust/kernel/drm/driver.rs                          |    10 +-
 rust/kernel/drm/file.rs                            |     8 +-
 rust/kernel/drm/gem/mod.rs                         |   104 +-
 rust/kernel/drm/gem/shmem.rs                       |   228 +
 rust/kernel/error.rs                               |     1 +
 rust/kernel/gpu.rs                                 |     6 +
 rust/kernel/gpu/buddy.rs                           |   614 +
 rust/kernel/interop.rs                             |     9 +
 rust/kernel/interop/list.rs                        |   339 +
 rust/kernel/io.rs                                  |   782 +-
 rust/kernel/io/mem.rs                              |    10 +-
 rust/kernel/io/register.rs                         |  1260 +
 rust/kernel/lib.rs                                 |     8 +
 rust/kernel/num/bounded.rs                         |    70 +-
 rust/kernel/pci/io.rs                              |    99 +-
 rust/kernel/uaccess.rs                             |    91 +-
 rust/kernel/workqueue.rs                           |   104 +-
 samples/rust/rust_dma.rs                           |    13 +-
 samples/rust/rust_driver_pci.rs                    |    90 +-
 scripts/Makefile.build                             |     3 +-
 1741 files changed, 165144 insertions(+), 28842 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/bridge/lontium,lt8713sx.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-hdmi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/motorola,mot-panel.yaml
 create mode 100644
Documentation/devicetree/bindings/display/tilcdc/ti,am33xx-tilcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/tilcdc/tilcdc=
.txt
 create mode 100644
Documentation/devicetree/bindings/display/verisilicon,dc.yaml
 rename Documentation/devicetree/bindings/{display/msm/dsi-phy-10nm.yaml
=3D> phy/qcom,dsi-phy-10nm.yaml} (96%)
 rename Documentation/devicetree/bindings/{display/msm/dsi-phy-14nm.yaml
=3D> phy/qcom,dsi-phy-14nm.yaml} (94%)
 rename Documentation/devicetree/bindings/{display/msm/dsi-phy-20nm.yaml
=3D> phy/qcom,dsi-phy-20nm.yaml} (93%)
 rename Documentation/devicetree/bindings/{display/msm/dsi-phy-28nm.yaml
=3D> phy/qcom,dsi-phy-28nm.yaml} (94%)
 rename Documentation/devicetree/bindings/{display/msm/dsi-phy-7nm.yaml
=3D> phy/qcom,dsi-phy-7nm.yaml} (88%)
 rename Documentation/devicetree/bindings/{display/msm/dsi-phy-common.yaml
=3D> phy/qcom,dsi-phy-common.yaml} (91%)
 create mode 100644 Documentation/gpu/drm-ras.rst
 create mode 100644 Documentation/netlink/specs/drm_ras.yaml
 create mode 100644 drivers/accel/amdxdna/amdxdna_iommu.c
 create mode 100644 drivers/gpu/Kconfig
 create mode 100644 drivers/gpu/buddy.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_=
mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_=
mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_=
mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.=
c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.=
h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb=
.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_factory_dc=
n42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_factory_dc=
n42.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_dp_link_encoder.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_dp_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbu=
b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbu=
b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dc=
n42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dc=
n42.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c
 rename drivers/gpu/drm/amd/display/dc/{clk_mgr/dce60/dce60_clk_mgr.h
=3D> resource/dcn42/dcn42_resource_fpu.h} (78%)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_off=
set.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_sh_m=
ask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_0_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pm=
fw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pp=
smc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8713sx.c
 create mode 100644 drivers/gpu/drm/bridge/th1520-dw-hdmi.c
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panthor-rk3588-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panthor-rk3588-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3588-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3588-skips.txt
 create mode 100644 drivers/gpu/drm/drm_ras.c
 create mode 100644 drivers/gpu/drm/drm_ras_genl_family.c
 create mode 100644 drivers/gpu/drm/drm_ras_nl.c
 create mode 100644 drivers/gpu/drm/drm_ras_nl.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_de.c
 delete mode 100644 drivers/gpu/drm/i915/display/intel_dpt_common.c
 delete mode 100644 drivers/gpu/drm/i915/display/intel_dpt_common.h
 delete mode 100644 drivers/gpu/drm/i915/display/intel_dsb_buffer.h
 delete mode 100644 drivers/gpu/drm/i915/display/intel_fb_bo.c
 delete mode 100644 drivers/gpu/drm/i915/display/intel_fb_bo.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_oprom_regs.h
 create mode 100644 drivers/gpu/drm/i915/i915_bo.c
 create mode 100644 drivers/gpu/drm/i915/i915_bo.h
 create mode 100644 drivers/gpu/drm/i915/i915_dpt.c
 create mode 100644 drivers/gpu/drm/i915/i915_dpt.h
 rename drivers/gpu/drm/i915/{display/intel_dsb_buffer.c =3D>
i915_dsb_buffer.c} (63%)
 create mode 100644 drivers/gpu/drm/i915/i915_dsb_buffer.h
 create mode 100644 drivers/gpu/drm/i915/i915_overlay.c
 create mode 100644 drivers/gpu/drm/i915/i915_overlay.h
 create mode 100644 drivers/gpu/drm/imagination/pvr_dump.c
 create mode 100644 drivers/gpu/drm/imagination/pvr_dump.h
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_gem.c
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_gem.h
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_preempt.h
 create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_preempt.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83121a.c
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h
 rename drivers/gpu/drm/panel/{panel-ilitek-ili9806e.c =3D>
panel-ilitek-ili9806e-dsi.c} (82%)
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
 create mode 100644 drivers/gpu/drm/panel/panel-lxd-m9189a.c
 create mode 100644 drivers/gpu/drm/panel/panel-motorola-mot.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt37700f.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_trace.h
 create mode 100644 drivers/gpu/drm/sysfb/corebootdrm.c
 delete mode 100644 drivers/gpu/drm/tests/drm_buddy_test.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_encoder.c
 rename drivers/gpu/drm/tilcdc/{tilcdc_external.h =3D> tilcdc_encoder.h} (5=
1%)
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso
 create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/verisilicon/Makefile
 create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge_regs.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc_regs.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_top_regs.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_drm.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_drm.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_hwdb.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_hwdb.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_primary_plane.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/i915_reg.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/i915_vma.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/intel_pcode.h
 delete mode 100644 drivers/gpu/drm/xe/display/intel_bo.c
 rename drivers/gpu/drm/xe/display/{intel_fb_bo.c =3D> xe_display_bo.c} (52=
%)
 create mode 100644 drivers/gpu/drm/xe/display/xe_display_bo.h
 create mode 100644 drivers/gpu/drm/xe/display/xe_display_pcode.c
 create mode 100644 drivers/gpu/drm/xe/display/xe_display_pcode.h
 create mode 100644 drivers/gpu/drm/xe/display/xe_display_vma.h
 create mode 100644 drivers/gpu/drm/xe/display/xe_dsb_buffer.h
 create mode 100644 drivers/gpu/drm/xe/display/xe_frontbuffer.c
 create mode 100644 drivers/gpu/drm/xe/display/xe_frontbuffer.h
 create mode 100644 drivers/gpu/drm/xe/xe_defaults.h
 create mode 100644 drivers/gpu/drm/xe/xe_drm_ras.c
 create mode 100644 drivers/gpu/drm/xe/xe_drm_ras.h
 create mode 100644 drivers/gpu/drm/xe/xe_drm_ras_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_guc_rc.c
 create mode 100644 drivers/gpu/drm/xe/xe_guc_rc.h
 create mode 100644 drivers/gpu/drm/xe/xe_mmio_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sleep.h
 create mode 100644 drivers/gpu/drm/xe/xe_tile_types.h
 delete mode 100644 drivers/gpu/nova-core/dma.rs
 create mode 100644 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
 create mode 100644 drivers/gpu/nova-core/gsp/cmdq/continuation.rs
 delete mode 100644 drivers/gpu/nova-core/regs/macros.rs
 create mode 100644 drivers/gpu/tests/Makefile
 create mode 100644 drivers/gpu/tests/gpu_buddy_test.c
 rename drivers/gpu/{drm/lib/drm_random.c =3D> tests/gpu_random.c} (59%)
 rename drivers/gpu/{drm/lib/drm_random.h =3D> tests/gpu_random.h} (53%)
 create mode 100644 include/drm/drm_ras.h
 create mode 100644 include/drm/drm_ras_genl_family.h
 create mode 100644 include/drm/intel/intel_gmd_interrupt_regs.h
 create mode 100644 include/drm/intel/intel_gmd_misc_regs.h
 create mode 100644 include/drm/intel/intel_pcode_regs.h
 create mode 100644 include/drm/intel/pick.h
 create mode 100644 include/drm/intel/reg_bits.h
 create mode 100644 include/drm/intel/step.h
 create mode 100644 include/linux/coreboot.h
 create mode 100644 include/linux/gpu_buddy.h
 create mode 100644 include/uapi/drm/drm_ras.h
 create mode 100644 rust/helpers/dma-resv.c
 create mode 100644 rust/helpers/gpu.c
 create mode 100644 rust/helpers/list.c
 create mode 100644 rust/kernel/drm/gem/shmem.rs
 create mode 100644 rust/kernel/gpu.rs
 create mode 100644 rust/kernel/gpu/buddy.rs
 create mode 100644 rust/kernel/interop.rs
 create mode 100644 rust/kernel/interop/list.rs
 create mode 100644 rust/kernel/io/register.rs
