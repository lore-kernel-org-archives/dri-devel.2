Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE862606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jpaRwh9i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2273911245D;
	Thu, 22 Oct 2026 09:41:46 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1F810E1F2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 00:25:14 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-917aca1aee5so14164366d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792628714; cv=none;
 d=google.com; s=arc-20260327;
 b=Bhy0lr6+kvjyCQvMnaLoCH8XlXp48CE31znnGoCGYtpqWCoXJoRaQNwR5Zspn4hn4U
 Es/wA5pQOOLrD31wW5H9dAlLgw/0Ww6NLZv0uOAjMow4dyQ//cT2U+grQmfjqCZW3vn4
 fzMWVOZn1hmkqcwrpc5BZTKhm2dkpqpxKpHpupqUzQ3S3oX/M9FHjEX9LJOI4wsnyK6a
 BV8jm0erX4XO+CYjYZbh4hxizGw7mYkoU74QpkNsULwjp/T90Q2ceM4wc4dzs3aP4lKL
 8LuEerm7CWM6vE7PwZvET3BPCRLQtVl7CpMfUoA+ReMzEAGQ8pfJIbRooXhbSZtiS1Fo
 vFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=OW+PyJ8X76LCuOenBQXpTQIPofewTVJbyXKkjPJ1W5M=;
 fh=mXn+Rma8KFs/L8dBNPRX3lBUjJN+WUFN1Nncmu/aBbs=;
 b=E/c7SNrWRZWGCkwgdCKAGlNSyXzYMTb2gDgNRoC27khc+158hpAghNds0pfIefm0gE
 l0XTp0m9PxiXqQaACwxhgAQjQ6VU1ecB1TO8oT1qyO13FeL0QK80eOyFfsQIrbk7toXX
 ofDWboZocj8fXhAxJeo3xeZsiqL3sC/flrQrVehiPJRW2OmPWOspJoskW62PviRW+PyE
 HRPGFQP4Z2KbjKajeZ41VKawR57ekH7MnmdMFVfVpVQILS8XTBWninyccDMTJzVpi1iJ
 lJPYpyJe1/qXmdcLXEkGkBN3ouB5r+VIqxZfSKqggjotGmzfXWmqBGpwf9QuF6JlUjLe
 950Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792628714; x=1793233514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OW+PyJ8X76LCuOenBQXpTQIPofewTVJbyXKkjPJ1W5M=;
 b=jpaRwh9iPRHJu5nZY01++/Rt4vrDQ8PncL8h96hIoMMANrVpUc9HHlWWPB8OmeFuC+
 YUJLrQH75Z8oJEvsjZ8KHUdneZFLKMUYmAKCzJe1HQ3AC1f+lRCvw7ta4mHYy8607fSG
 t1Dip0ejRqdSnixVDBYwvHNbF8lLDOOMizNLBfzxAVAOKYo6oEPGYQ8LnHsfOQW+DbuE
 3WfWO8YaAZMqQ5QiPwA24Ge6VQtJ5VAXIqlr9QMcXOP70mtmLhux6lFeL5mxobvr/Fdi
 IOD2bR+R9JpLniqI5IyUNtOofrDYI/syDoCQcLiQ92FasT3RnJGa7vMJpDYcaL3O/M+O
 O0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792628714; x=1793233514;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OW+PyJ8X76LCuOenBQXpTQIPofewTVJbyXKkjPJ1W5M=;
 b=DGBNmBgMZ85kqiBcz9buos7QYWUMWNCM9bdGLCJ+6aBNbG0mATv/87dUH+5LsCj/E2
 skfnaOW/zXbnJDX/Yhjawku6TWosiVLAoXbmx0bGtCjfU53uDPAuz6v43ZVc7dz8iEMs
 23XoWzGaS4T6QG3VUvEmHNGG2eC5aUNqqm2Etm8q+IOqYrDTN30tALRhJpHf/BlaW6m9
 CWFXTWIqpUUeY8M+I81zzkgXnnVe+Ot+cCPe97sM5sCnv5FK6rTk2/UsT1tpVOMBHUUn
 cUu983h6qABTAW/3wm8xNa9SMT6aPGhlZGLSP14BSEv+6X3eaTckjBLBTGHZ+83vQyMP
 DC1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBPyB12F252bW3bVbwHtrJfXFGeyjUqIZ+V7vA35OQ/MRsSrJp7J9y9CDcViZTpXHO7FEbXAas2zc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIS5rn+y5IcUuPjtCH1TO4tDCv/1HsNn6W7ztwbJXT9DzMD8MxW
 20hZEAOeVdEsjuv2hUJ11Q8WR2nyuO01l1pCmhhgnJF8NbWOhAH2P5KBq0bmxr8FeVASjTQK8sJ
 gh2j9E8WomjjzbYruX1kc3RkOVYlsPoQ=
X-Gm-Gg: AYBFou2O5DkTKjydMdY6k78Xiw85wfWa7brUdtkkUnd2HZCv8S4lZoNzUjDp01Vgn3o
 tx0ll0zjOWXe5xQmAGHakTNRnsNm4XfW9DSRdOjzOvftjtQ9A/H9en22l2yCmR5E/QKAHizZ+Pz
 dD3uuCpyz/sQQRK+OkkbNJ0zy6lH1NucDGssjhaM8StErieG5rUKWGM+9foUKdlF0jsGketuEGL
 Sq+XiSEtYWZyFfyTHLbrhcdHenAuBLmc0TP9E4UFRoOgpkJSeWKGbBlstTsUT5MKAeMaN1uQteQ
 iKi1qIJxkst6UYMowRELWG5hgrLxxMxbE7xiRQojXrIMz66rNdxoHFUDYruQZ8SnSuJjtlHWZPK
 hu0J6WQfNI9cdRij5ZiMbFw+R9PURwdpWL2mf8hHXUH1OJHhSQmC04ICLb4KxomAp8f9gAjml6g
 rxD/UzkDDAVW4KONaZsynbPQ==
X-Received: by 2002:a05:620a:6084:b0:93e:fa30:f1dc with SMTP id
 af79cd13be357-93f57f70353mr732342685a.72.1792628712091; Wed, 21 Oct 2026
 17:25:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 22 Oct 2026 10:24:59 +1000
X-Gm-Features: AclHuK_r9Twsjj4Ro5JRibN_zPrDfctzNnSr4M6jjkKdRXmkp_DXUn04c2eQ2zE
Message-ID: <CAPM=9twkDYDGdznUrXk8c-t1tXD52Df2LsdnF6KFDz_0xoYv7Q@mail.gmail.com>
Subject: [git pull] drm for 7.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

This is the main drm pull request for 7.4.

The merge into your tree from yesterday was pretty clean there was
only 3 minor conflicts that I think you can handle.

This has a bunch of the usual rust shared trees, which you will get
proper contents from device-core and rust trees.

There is one sound patch for an omapdrm interaction.

There is a vgaarb api change that affects it's consumers as well.

Highlights:
core: a lot of atomic refactoring in progress, panic got split into a
core/helpers model
amdgpu: enables HDMI 2.1 FRL and other good things finally, UAlink
over Ethernet support
xe: has a bunch of CRI support, ras error for bad vram, memory
offlining support.
msm: enables a bunch more GPUs.

Otherwise it's a the usual mountain of stuff all over the place, let
me know if there any problems.

Dave.

drm-next-2026-10-21:
drm next for 7.4-rc1

rust:
- I/O tree shared with driver-core
- DMA tree shared with driver-core
- allow aux registration data closures to return covariant
  sub-fields
- Implement Send and Sync for MapleTree
- add pci resource flags and IORESOURCE_MEM_64

drm/rust:
- add dma_fence abstraction
- init DRM registrations and their data in place
- drop unused flags argument to registration

vgaarb:
- rework API to pass a private ptr instead of pci device

sound:
- adapt to omapdrm changes

gem:
- add callback for handle count going to 0

gpusvm:
- share one HMM fault and keep single mappings inline

pagemap:
- Prevent CPU stalls during unbounded pagemap teardown

dma-fence:
- fix docs

vga_switcheroo:
- disconnect from fbcon
- update fbcon from within fbdev emulation

atomic:
- move DRM from state reset callbacks to atomic_create_state
- remove drm_simple_encoder_init

panic:
- split into core and helpers

buddy:
- improve dirty tracking

clients:
- improve vmap handling
- fbdev: Move helpers from drm_kms_helper.ko to drm_client_lib.ko

display:
- export HDMI SCDC status data via debugfs
- rework SCDC for better HDMI 2.0 support
- dp/mst: improve DPCD compliance

edid:
- parse AMD VSDB
- parse ALLM/VRR capabilities
- support detecting panel size

log:
- add drm_warn_ratelimited

sched:
- cleanup interface
- add missing locking
- fix run-queue cleanup
- fix locking

sysfb:
- remove obsolete quirk for Lenovo D330
- fix panel orientation for non-native display modes
- drop drm_class_device_register

colorop:
- provide DRM_COLOR_OP_FIXED_MATRIX

bridge:
- analogix: Support eDP lane mapping
- ti-sn65dsi83: Support LVDS Channel B on SN65DSI84
- Select DRM_PANEL_BRIDGE for various drivers that require it
- add chrontel ch7218a support

panel:
- panel-edp: Support MNE007QS3-F, TM140VDXP15, and KD116N36-30NB-A001
- samsung-s6d16d0: Use mipi_dsi_*_multi() functions
- support Ilitek ILI7836A OLED plus DT bindings
- support Novatek NT36532 plus DT bindings
- convert several drivers to managed cleanup
- fix Kconfig selections
- edp: Add support for BOE NV140FHM-T0A
- samsung: Share test-key helpers
- edp: Support CSOT MNE007QB1-1
- ebbg-ft8719: Fix MODULE_LICENSE() string; Improve initialization
- edp: NV140WU2-M70
- ilitek-ili9882t: Support Ilitek IL79600A plus DT bindings
- simple: Support Truly TFT320240-229-E plus DT bindings; Support BOE
  DV215FHM-R01 plus DT bindings
- Refactor struct drm_panel to contain struct drm_bridge plus fallout in
  various panel drivers
- Add support for BOE Novatek NT51021, Retroid Pocket 6,
  Raydium RM69220 DDIC panels, Sharp LQ138P1JX61 eDP,
  BOE NV140FHD-N43, AUO B140HAN04.0, AUO 0x0db3,
  panels.

amdgpu:
- use AMD VSDB for freesync
- implement YUV-to-RGB with fixed-matrix colorop
- enable FRL for HDMI
- HDMI 2.1 freesync support
- HDMI 2.1 ALLM support
- HDMI 2.1 VRR support
- UALoE (UALink over Ethernet) support
- add syncobj_points to userq signal ioctl
- drop unused kunit tests
- NBIO/GC/MMHUB/SMU updates/fixes
- GPU spatial partitioning updates
- display kunit fixes
- userq fixes
- RGB quantization fixes
- DC RMCM refactor
- DP MST fixes
- USB4 fixes
- add new trace events
- Rework display instance handling
- stack frame size fixes for various compilers/configs
- VCN 4/5 reset fixes
- freesync updates
- cursor refactor
- Fix direct scanout alpha on some DRM_FORMATs
- Expand Mac reserved memory workaround
- Make runtime pm more fine grained

amdkfd:
- updates and fixes
- GC 10 CU occupancy support

radeon:
- eDP fix for DCE3.2 iMacs

xe:
- add drm_ras netlink error event support
- add memory page offlining support
- introduce error threshold to drm_ras
- fix stale GTT mappings on unmap
- reject page faults for non-page fault mode scratch VM
- enable CRI package and VRAM temperatures
- introduce cold reset recovery
- handle CRI+ power interval encoding
- VF migration for multi-queue
- handle exec queue teardown after hot unplug
- alerts and controller enabling modifications
- use IBCv3 on PTL
- VRAM health check
- report GT TDR and VM rebind faults using SIGID
- add multi_queue_active_lrca debugfs
- shrinker: Runtime PM reference for non-system memory
- guc: Add simple KLV decoder helpers
- debugfs: Expose per-engine idle status
- Keep walking on SVM eviction failure
- Nuke PTs only after unlinking contested VMAs
- limit sg segment size to PAGE_SIZE on Xen PV
- keep VF LMEM bar size low if no VFs
- CPU binds and ULLS on migration queue
- New PTL PCI ID
- Enable PXP for NVL-S
- Do not dma_fence_put zero fences in err_out path
- Refresh TTM LRU on SVM prefetch
- export device UID in sysfs

i915:
- rename GEN6_PCODE_DATA to match spec
- fix incorrect RCU teardown order
- fix potential UAF in command parsing
- avoid WARN splat during RPS boosting race
- use simpler min functions
- Fixes to make i915 work well with PREEMPT_RT

i915/display:
- Enable CMRR (Content Match Refresh Rate) in fixed-RR VRR path
- Switch DG2 MPLL to DPLL framework
- DP-HDMI PCON DSC fixes
- limit invalid joiner combinations
- CDCLK related fixes and refactor around PCODE integration
- Gate UHBR SST SDP splitting on sink caps
- add HDMI TMDS audio bandwidth check
- vswing/preemph override
- enable AS SDP Skip frames
- Handle negative configuration index on DP link caps for robustness
- Preparation for enabling SDR plane color pipeline
- An eDP quirk for HP Pavilion Plus
- Introduce PME (Power Management Event) support on display hotplug
- Handle VSC SDP revision 7 in unpack

msm:
- CI:
  - Dropped sc7180 trogdor lazor from the CI
- Core:
  - Fixed msm_ioremap for resources without a name
  - Changed msm.separate_gpu_kms to default to auto selection
- GPU:
  - Enable CLX (Current Limit eXtension) for gen8 to avoid
    exceeding limits on CX/GX rails
  - New GPUs: a830 (Pakala), a845 (Maili), a850 (Hawi),
    x2-85 (Mahua)
  - Fix VBIF halt mask on a306, which was preventing runpm
    suspend
  - Enable THP support for GEM buffers
  - Add modparam to disable waiting on fences in shrinker
  - Drop use of drm_prime_sg_to_page_array()
  - a5xx: don't read the GPMU registers on GPUs without a GPMU
  - a2xx/a3xx/a5xx: hangcheck progress detection
  - a6xx: gmuwrapper runpm fix
  - Calculate reported GMEM size based on active slices
  - Split a6xx/a7xx/a8xx catalog
- DP:
  - Picked up some preparation patches for the MST support
  - Fixed reported status of the link training
- DPU:
  - Fixed CRTC bandwidth computation
  - Fixed DSC programming
  - Fixed encoder disablement path
- DSI:
  - Fixed VM leak in error path
  - Indention fix
- MDP5:
  - Added MSM8952 configuration
  - Dropped incorrect cursor pipe on MSM8976/56
- HDMI:
  - Small fixes

nouveau:
- improve runtime PM on R570 GSP firmware
- various fixes throughout the driver
- dispnv50: support 2.147 GHz pixel clock in GB20x

nova:
- add initial uapi concept
- add initial PRAMIN access support
- add GpuMm centralized memory manager
- add GPU VM and BAR1 support
- add GPU interrupts and GSP events support
- GSP messaging fixes

tyr:
- use bitfield!
- zero unsupported and newly added GPU info fields
- limit doorbell array to 17 entries

exynos:
- FIMD fixes
  - Fix clock leak on resume error path.
  - Fix Sparse warnings by adding missing __iomem annotation.
- VIDI cleanup
  - Replace kmalloc() and copy_from_user() with memdup_user().

amdxdna:
- fix BO handling
- Support AIE2 rev 9
- Fix UAF access in scheduler fences
- Update workqueue interface
- expose busy time via fdinfo

ast:
- support 256-byte EDID

hyperv_drm:
- remove support for pre win10 hosts

komeda:
- fix GLB_CORE_ID usage

omap:
- report HDMI hotplug events to ASoC HDMI codec

panthor:
- provide gpu_cache_flush tracepoint
- improve dma_fence signalling latency
- improve locking
- export scheduling information via debugfs
- Validate user-space input against firmware limits

qaic:
- reject BOs that exceed maximum page count
- add missing include statements

verisilicon:
- fix hardware cursor offsets

vkms:
- implement YUV-to-RGB with fixed-matrix colorop

gma500:
- avoid unsupported ARGB formats in primary plane

hibmc:
- handle vblank interrupts correctly

ivpu:
- add DRM_IVPU_CAP_CMDQ_SET_PRIORITY
- support command-queue priority ioctl
- Simplify NULL-pointer handling in cleanup code

arcpgu:
- replace simple-display pipeline with regular atomic helpers

aspeed:
- replace simple-display pipeline with regular atomic helpers

gm12u320:
- replace simple-display pipeline with regular atomic helpers

imagination:
- various improvement to firmware interaction
- add job to pvr_job_submit_fw trace event

mali-dp:
- fix runtime PM leak

mcde:
- replace simple-display pipeline with regular atomic helpers

p111:
- replace simple-display pipeline with regular atomic helpers
- drop unsupported alpha formats from primary plane

rcar-du:
- support Renesas R-Car V4H DSC
- dsi: Support larger transfers with AXI memory
- Support RZ/G3L SoC

repaper:
- replace simple-display pipeline with regular atomic helpers

rockchip:
- dsi: improve PHY timings

ssd130x:
- support Solomon SSD1351 OLED plus DT bindings
- ssd133x: upgrade color format to RGB565
- ssd132x: Set correct hardware window when clearing screen

tve200:
- replace simple-display pipeline with regular atomic helpers

xen:
- replace simple-display pipeline with regular atomic helpers

v3d:
- improve job handling under perfmon

vc4:
- reliably reset V3D
- drop brcm,vc4-v3d compatible

virtio:
- fix damage handling
- Support ARGB8888 for virtio primary planes.

host1x:
- Support partitioning

imx:
- Replace simple-display with regular atomic helpers

mxsfb:
- Support bus formats plus DT bindings

tegra:
- improve syncobj handling on submit

panfrost:
- add Mali-G68 support
- improve GPU reset handling

rockchip:
- add HDMI 2.0 support to dw-hdmi-qp
- improve HPD handling
The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a=
:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-10-21

for you to fetch changes up to fad06cfaf385787b9ffa2f73f049d42dbe1de57f:

  Merge tag 'drm-misc-next-2026-10-16' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2026-10-21 11:03:26 +1000)

----------------------------------------------------------------
drm next for 7.4-rc1

rust:
- I/O tree shared with driver-core
- DMA tree shared with driver-core
- allow aux registration data closures to return covariant
  sub-fields
- Implement Send and Sync for MapleTree
- add pci resource flags and IORESOURCE_MEM_64

drm/rust:
- add dma_fence abstraction
- init DRM registrations and their data in place
- drop unused flags argument to registration

vgaarb:
- rework API to pass a private ptr instead of pci device
sound:
- adapt to omapdrm changes

gem:
- add callback for handle count going to 0

gpusvm:
- share one HMM fault and keep single mappings inline

pagemap:
- Prevent CPU stalls during unbounded pagemap teardown

dma-fence:
- fix docs

vga_switcheroo:
- disconnect from fbcon
- update fbcon from within fbdev emulation

atomic:
- move DRM from state reset callbacks to atomic_create_state
- remove drm_simple_encoder_init

panic:
- split into core and helpers

buddy:
- improve dirty tracking

clients:
- improve vmap handling
- fbdev: Move helpers from drm_kms_helper.ko to drm_client_lib.ko

display:
- export HDMI SCDC status data via debugfs
- rework SCDC for better HDMI 2.0 support
- dp/mst: improve DPCD compliance

edid:
- parse AMD VSDB
- parse ALLM/VRR capabilities
- support detecting panel size

log:
- add drm_warn_ratelimited

sched:
- cleanup interface
- add missing locking
- fix run-queue cleanup
- fix locking

sysfb:
- remove obsolete quirk for Lenovo D330
- fix panel orientation for non-native display modes
- drop drm_class_device_register

colorop:
- provide DRM_COLOR_OP_FIXED_MATRIX

bridge:
- analogix: Support eDP lane mapping
- ti-sn65dsi83: Support LVDS Channel B on SN65DSI84
- Select DRM_PANEL_BRIDGE for various drivers that require it
- add chrontel ch7218a support

panel:
- panel-edp: Support MNE007QS3-F, TM140VDXP15, and KD116N36-30NB-A001
- samsung-s6d16d0: Use mipi_dsi_*_multi() functions
- support Ilitek ILI7836A OLED plus DT bindings
- support Novatek NT36532 plus DT bindings
- convert several drivers to managed cleanup
- fix Kconfig selections
- edp: Add support for BOE NV140FHM-T0A
- samsung: Share test-key helpers
- edp: Support CSOT MNE007QB1-1
- ebbg-ft8719: Fix MODULE_LICENSE() string; Improve initialization
- edp: NV140WU2-M70
- ilitek-ili9882t: Support Ilitek IL79600A plus DT bindings
- simple: Support Truly TFT320240-229-E plus DT bindings; Support BOE
  DV215FHM-R01 plus DT bindings
- Refactor struct drm_panel to contain struct drm_bridge plus fallout in
  various panel drivers
- Add support for BOE Novatek NT51021, Retroid Pocket 6,
  Raydium RM69220 DDIC panels, Sharp LQ138P1JX61 eDP,
  BOE NV140FHD-N43, AUO B140HAN04.0, AUO 0x0db3,
  panels.

amdgpu:
- use AMD VSDB for freesync
- implement YUV-to-RGB with fixed-matrix colorop
- enable FRL for HDMI
- HDMI 2.1 freesync support
- HDMI 2.1 ALLM support
- HDMI 2.1 VRR support
- UALoE (UALink over Ethernet) support
- add syncobj_points to userq signal ioctl
- drop unused kunit tests
- NBIO/GC/MMHUB/SMU updates/fixes
- GPU spatial partitioning updates
- display kunit fixes
- userq fixes
- RGB quantization fixes
- DC RMCM refactor
- DP MST fixes
- USB4 fixes
- add new trace events
- Rework display instance handling
- stack frame size fixes for various compilers/configs
- VCN 4/5 reset fixes
- freesync updates
- cursor refactor
- Fix direct scanout alpha on some DRM_FORMATs
- Expand Mac reserved memory workaround
- Make runtime pm more fine grained

amdkfd:
- updates and fixes
- GC 10 CU occupancy support

radeon:
- eDP fix for DCE3.2 iMacs

xe:
- add drm_ras netlink error event support
- add memory page offlining support
- introduce error threshold to drm_ras
- fix stale GTT mappings on unmap
- reject page faults for non-page fault mode scratch VM
- enable CRI package and VRAM temperatures
- introduce cold reset recovery
- handle CRI+ power interval encoding
- VF migration for multi-queue
- handle exec queue teardown after hot unplug
- alerts and controller enabling modifications
- use IBCv3 on PTL
- VRAM health check
- report GT TDR and VM rebind faults using SIGID
- add multi_queue_active_lrca debugfs
- shrinker: Runtime PM reference for non-system memory
- guc: Add simple KLV decoder helpers
- debugfs: Expose per-engine idle status
- Keep walking on SVM eviction failure
- Nuke PTs only after unlinking contested VMAs
- limit sg segment size to PAGE_SIZE on Xen PV
- keep VF LMEM bar size low if no VFs
- CPU binds and ULLS on migration queue
- New PTL PCI ID
- Enable PXP for NVL-S
- Do not dma_fence_put zero fences in err_out path
- Refresh TTM LRU on SVM prefetch
- export device UID in sysfs

i915:
- rename GEN6_PCODE_DATA to match spec
- fix incorrect RCU teardown order
- fix potential UAF in command parsing
- avoid WARN splat during RPS boosting race
- use simpler min functions
- Fixes to make i915 work well with PREEMPT_RT

i915/display:
- Enable CMRR (Content Match Refresh Rate) in fixed-RR VRR path
- Switch DG2 MPLL to DPLL framework
- DP-HDMI PCON DSC fixes
- limit invalid joiner combinations
- CDCLK related fixes and refactor around PCODE integration
- Gate UHBR SST SDP splitting on sink caps
- add HDMI TMDS audio bandwidth check
- vswing/preemph override
- enable AS SDP Skip frames
- Handle negative configuration index on DP link caps for robustness
- Preparation for enabling SDR plane color pipeline
- An eDP quirk for HP Pavilion Plus
- Introduce PME (Power Management Event) support on display hotplug
- Handle VSC SDP revision 7 in unpack

msm:
- CI:
  - Dropped sc7180 trogdor lazor from the CI
- Core:
  - Fixed msm_ioremap for resources without a name
  - Changed msm.separate_gpu_kms to default to auto selection
- GPU:
  - Enable CLX (Current Limit eXtension) for gen8 to avoid
    exceeding limits on CX/GX rails
  - New GPUs: a830 (Pakala), a845 (Maili), a850 (Hawi),
    x2-85 (Mahua)
  - Fix VBIF halt mask on a306, which was preventing runpm
    suspend
  - Enable THP support for GEM buffers
  - Add modparam to disable waiting on fences in shrinker
  - Drop use of drm_prime_sg_to_page_array()
  - a5xx: don't read the GPMU registers on GPUs without a GPMU
  - a2xx/a3xx/a5xx: hangcheck progress detection
  - a6xx: gmuwrapper runpm fix
  - Calculate reported GMEM size based on active slices
  - Split a6xx/a7xx/a8xx catalog
- DP:
  - Picked up some preparation patches for the MST support
  - Fixed reported status of the link training
- DPU:
  - Fixed CRTC bandwidth computation
  - Fixed DSC programming
  - Fixed encoder disablement path
- DSI:
  - Fixed VM leak in error path
  - Indention fix
- MDP5:
  - Added MSM8952 configuration
  - Dropped incorrect cursor pipe on MSM8976/56
- HDMI:
  - Small fixes

nouveau:
- improve runtime PM on R570 GSP firmware
- various fixes throughout the driver
- dispnv50: support 2.147 GHz pixel clock in GB20x

nova:
- add initial uapi concept
- add initial PRAMIN access support
- add GpuMm centralized memory manager
- add GPU VM and BAR1 support
- add GPU interrupts and GSP events support
- GSP messaging fixes

tyr:
- use bitfield!
- zero unsupported and newly added GPU info fields
- limit doorbell array to 17 entries

exynos:
- FIMD fixes
  - Fix clock leak on resume error path.
  - Fix Sparse warnings by adding missing __iomem annotation.
- VIDI cleanup
  - Replace kmalloc() and copy_from_user() with memdup_user().

amdxdna:
- fix BO handling
- Support AIE2 rev 9
- Fix UAF access in scheduler fences
- Update workqueue interface
- expose busy time via fdinfo

ast:
- support 256-byte EDID

hyperv_drm:
- remove support for pre win10 hosts

komeda:
- fix GLB_CORE_ID usage

omap:
- report HDMI hotplug events to ASoC HDMI codec

panthor:
- provide gpu_cache_flush tracepoint
- improve dma_fence signalling latency
- improve locking
- export scheduling information via debugfs
- Validate user-space input against firmware limits

qaic:
- reject BOs that exceed maximum page count
- add missing include statements

verisilicon:
- fix hardware cursor offsets

vkms:
- implement YUV-to-RGB with fixed-matrix colorop

gma500:
- avoid unsupported ARGB formats in primary plane

hibmc:
- handle vblank interrupts correctly

ivpu:
- add DRM_IVPU_CAP_CMDQ_SET_PRIORITY
- support command-queue priority ioctl
- Simplify NULL-pointer handling in cleanup code

arcpgu:
- replace simple-display pipeline with regular atomic helpers

aspeed:
- replace simple-display pipeline with regular atomic helpers

gm12u320:
- replace simple-display pipeline with regular atomic helpers

imagination:
- various improvement to firmware interaction
- add job to pvr_job_submit_fw trace event

mali-dp:
- fix runtime PM leak

mcde:
- replace simple-display pipeline with regular atomic helpers

p111:
- replace simple-display pipeline with regular atomic helpers
- drop unsupported alpha formats from primary plane

rcar-du:
- support Renesas R-Car V4H DSC
- dsi: Support larger transfers with AXI memory
- Support RZ/G3L SoC

repaper:
- replace simple-display pipeline with regular atomic helpers

rockchip:
- dsi: improve PHY timings

ssd130x:
- support Solomon SSD1351 OLED plus DT bindings
- ssd133x: upgrade color format to RGB565
- ssd132x: Set correct hardware window when clearing screen

tve200:
- replace simple-display pipeline with regular atomic helpers

xen:
- replace simple-display pipeline with regular atomic helpers

v3d:
- improve job handling under perfmon

vc4:
- reliably reset V3D
- drop brcm,vc4-v3d compatible

virtio:
- fix damage handling
- Support ARGB8888 for virtio primary planes.

host1x:
- Support partitioning

imx:
- Replace simple-display with regular atomic helpers

mxsfb:
- Support bus formats plus DT bindings

tegra:
- improve syncobj handling on submit

panfrost:
- add Mali-G68 support
- improve GPU reset handling

rockchip:
- add HDMI 2.0 support to dw-hdmi-qp
- improve HPD handling

----------------------------------------------------------------
Aaron Kling (6):
      dt-bindings: display: panel: add Ilitek ILI7836A OLED driver
      drm/panel: add Ilitek ILI7836A panel driver
      dt-bindings: display: visionox,vtdr6130: Add Retroid Pocket 6 panel
      drm/panel: visionox-vtdr6130: Add panel orientation support
      drm/panel: visionox-vtdr6130: Modularize panel config
      drm/panel: visionox-vtdr6130: Add Retroid Pocket 6 panel

Aastha Pandey (1):
      arm64: dts: qcom: shikra: Add GPU cooling

Abel Vesa (11):
      arm64: dts: qcom: glymur-crd: Mark the EC reset gpio as reserved
      arm64: dts: qcom: eliza: Add GPU SMMU node
      soc: qcom: pmic_glink: Fix device access from worker during suspend
      arm64: dts: qcom: eliza: Describe the CDSP remoteproc
      arm64: dts: qcom: eliza-mtp: Enable CDSP remoteproc
      arm64: dts: qcom: eliza-cqs-som: Enable CDSP remoteproc
      arm64: dts: qcom: eliza-evk: Add power and volume keys
      arm64: dts: qcom: eliza-mtp: Add support for SD card
      arm64: dts: qcom: eliza-cqs-som: Enable Adreno A722 GPU
      arm64: dts: qcom: eliza: Connect USB3 PHY pipe clock to GCC
      MAINTAINERS: add Abel as reviewer for linux-arm-msm

Abhinav Kumar (3):
      drm/msm/dp: move link-level teardown from display_disable to
display_unprepare
      drm/msm/dp: introduce stream_id for each DP panel
      drm/msm/dp: add support for programming p1/p2/p3 register blocks

Abhishek Thomas Varghese (1):
      arm64: dts: qcom: talos: Add RPi Touch Display 2 5-inch overlay

Adam Azuddin (1):
      drm/appletbdrm: Fix incorrect error message on encoder attach failure

Aditya Sherawat (2):
      arm64: dts: qcom: shikra: Add A704 GPU support
      arm64: dts: qcom: shikra-evk: Enable A704 GPU

Adrian Betschart (3):
      drm/amd/display: Default HDMI RGB output to limited range on CTA mode=
s
      drm/amd/display: Try RGB before YCbCr 4:4:4 in stream validation
      drm/amd/display: Don't replace a sink mode that shares the native tot=
als

Adri=C3=A1n Larumbe (18):
      drm/panfrost: Check another bo field for cache option query
      drm/panfrost: Prevent division by 0
      drm/panfrost: Remove unnecessary header file include
      drm/panfrost: Move shrinker initialization and unplug one level down
      drm/panfrost: Move lock and modparam initialisations into their subsy=
stems
      drm/panfrost: Move debugfs initialisation to relevant subsystems
      drm/panfrost: Skip NULL checks for clock enable/disabling
      drm/panfrost: Consolidate device clock management and reset
      drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/re=
move
      drm/panfrost: Explicitly enable MMU interrupts at device init
      drm/panfrost: Move all DRM device initialisation into device_init()
      drm/panfrost: Warn of RPM get failure at device remove time
      drm/panfrost: Add debugfs knob for manually triggering a GPU reset
      drm/panfrost: Move perfcnt GPU disable sequence into a helper
      drm/panfrost: Skip cache flush/invalidate when enabling perfcnt
      drm/panfrost: Avoid cache flush after perfcnt sample in fully
coherent systems
      drm/panfrost: Introduce a reset lock
      drm/panfrost: Fix races between perfcnt and reset sequence

Akash Goel (2):
      drm/panthor: Fix handling of NO_MMAP BOs
      drm/panthor: Remove redundant drm_gem_create_mmap_offset() call
from BO_MMAP_OFFSET ioctl

Akash Sukhavasi (1):
      drm/panel: samsung-s6d16d0: Use mipi_dsi_*_multi(); fix minor bugs

Akhil P Oommen (12):
      drm/msm/a6xx: Add HFI support for CLX feature
      drm/msm/a6xx: Enable CLX feature on A840
      drm/msm/a8xx: Enable CLX feature on Adreno X2-85
      drm/msm/a6xx: Honor perfmode_bw threshold on A8x
      drm/msm/a6xx: Fix secondary rail vote in ARC votes
      drm/msm/a6xx: Fix RPMH dependency votes
      drm/msm/a6xx: Factor out RPMh arc-vote helpers
      drm/msm/a6xx: Add BX rail support to GMU dependency votes
      drm/msm/a6xx: Clamp MX dependency vote
      drm/msm/a8xx: Add Adreno 850 support
      drm/msm/a6xx: Send THINMEM config to GMU for A850
      dt-bindings: display/msm: Document A850 GPU and GMU

Alan Previn (3):
      drm/xe/gsc: Define GSC for NVL-S
      drm/xe/nvl-s: Enable PXP for NVL-S
      drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

Albert Esteve (3):
      drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
      drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNIT
      drm/amd/display: drop INLINE_IFN_KUNIT

Alessio Belle (5):
      drm/imagination: Remove duplicated CCB control initialisation
      drm/imagination: Manage FW VM context from its init and fini callback=
s
      drm/imagination: Avoid initialisation of unused FW trace buffer point=
er
      drm/imagination: Treat FW connection ctl like other interface structu=
res
      drm/imagination: Don't map FW interface structures unnecessarily

Alex Deucher (17):
      drm/amdgpu/gfx8: only apply compute quantums to KCQs
      drm/amdgpu: switch all IPs to using job for IBs
      drm/amdgpu: require a job to schedule an IB
      Documentation: add initial UALink Documentation
      drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags
      drm/amd/display: fix merge fallout in KUNIT tests
      MAINTAINERS: update git tree for radeon, amdgpu, amdkfd
      drm/amd/display: Bump frame warning limit for all builds of dml
      drm/amdgpu: Add mmhub v5_0_1 ip headers v3
      drm/amdgpu/gmc12: properly pass flush_type to gmc_v12_0_flush_vm_hub(=
)
      drm/amdgpu: drop userq callback assignment for sdma 7.1
      drm/amdgpu/gmc12.1: properly pass flush_type to gmc_v12_1_flush_vm_hu=
b()
      Revert "drm/amd/display: drop INLINE_IFN_KUNIT"
      Revert "drm/amd/display: replace EXPORT_IF_KUNIT with
EXPORT_SYMBOL_IF_KUNIT"
      Revert "drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUN=
IT"
      Revert "drm/amd/display: Attach blend mode property for alpha planes"
      drm/amdgpu: make Mac FB workaround generic

Alex Elder (6):
      arm64: dts: qcom: qcs6490-rb3gen2: clean up PCI function nodes
      arm64: dts: qcom: qcs6490-rb3gen2-industrial-mezzanine: clean up
PCI function nodes
      arm64: dts: qcom: lemans-evk-ifp-mezzanine: clean up PCI function nod=
es
      arm64: dts: qcom: monaco-evk-ifp-mezzanine: clean up PCI function nod=
es
      arm64: dts: qcom: qcs6490-thundercomm-minipc-g1iot: clean up PCI
function nodes
      arm64: dts: qcom: qcs8550-rb5gen2: clean up PCI function nodes

Alex Huang (4):
      drm/edid: Parse AMD VSDB for FreeSync refresh range
      drm/amd/display: Use HDMI FreeSync range from common EDID parser
      drm/amd/display: Clean up FreeSync capability detection
      drm/amd/display: Remove unused DMCU/DMUB EDID CEA parser

Alex Hung (150):
      drm/amd/display: test stream VRR updates
      drm/amd/display: test VRR IRQ parameters
      drm/amd/display: test VRR transitions
      drm/amd/display: test dm_check_cursor_fb
      drm/amd/display: test native cursor state check
      drm/amd/display: test dm_plane_color_pipeline_active
      drm/amd/display: test amdgpu_dm_crtc_get_cursor_mode
      drm/amd/display: Test writeback connector
      drm/amd/display: Test GPU memory allocation
      drm/amd/display: Test EDID quirks and ACPI EDID read
      drm/amd/display: Test execute_synaptics_rc_command failures
      drm/amd/display: Test MST stream feature read failure
      drm/amd/display: Test dm_helpers_submit_i2c_over_aux
      drm/amd/display: Test GPU memory allocate and free helpers
      drm/amd/display: Test dm_helpers_dmub_set_config_sync
      drm/amd/display: Test dm_helpers_is_dp_sink_present
      drm/amd/display: Test dm_helpers_read_local_edid
      drm/amd/display: Test dp_handle_test_pattern_request patterns
      drm/amd/display: Test DMUB reg callbacks
      drm/amd/display: Test VBIOS bounding box
      drm/amd/display: Test dm_init_microcode
      drm/amd/display: Test dm_dmub_sw_init
      drm/amd/display: Test MST sideband message ack path
      drm/amd/display: Test dm_dp_mst_get_modes without a remote EDID
      drm/amd/display: Test dm_dp_mst_get_modes with a remote EDID
      drm/amd/display: Test dm_dp_mst_detect DPCD probe and unplug
      drm/amd/display: Test MST connector register and unregister
      drm/amd/display: Test dm_dp_mst_connector_destroy
      drm/amd/display: Test plane state duplicate and destroy
      drm/amd/display: Test modifier list de-duplication
      drm/amd/display: Test GFX6-8 tiling info from modifiers
      drm/amd/display: Test GFX6-8 tile mode and tile split lookups
      drm/amd/display: Test GFX6-8 modifier calculation
      drm/amd/display: Test GFX6-8 modifier list generation
      drm/amd/display: Test framebuffer prepare and cleanup
      drm/amd/display: Test cursor update and async plane update
      drm/amd/display: Refactor amdgpu_dm_irq_test
      drm/amd/display: Test pageflip completion in the high IRQ handlers
      drm/amd/display: Test writeback handling in dm_crtc_high_irq
      drm/amd/display: Test schedule_dc_vmin_vmax
      drm/amd/display: Test handle_hpd_irq_helper detect and debounce exits
      drm/amd/display: Test HPD RX, HPD init and DMUB callback branches
      drm/amd/display: Test dm_dmub_outbox1_low_irq drain and work guards
      drm/amd/display: Test amdgpu_dm_dce110_register_irq_handlers
      drm/amd/display: Test amdgpu_dm_dcn10_register_irq_handlers
      drm/amd/display: Test ISM idle commit
      drm/amd/display: Test ISM idle exit arms
      drm/amd/display: Test ISM delayed workers
      drm/amd/display: Test colorop error paths
      drm/amd/display: Model ASSERT as path terminator
      drm/amd/display: Test backlight caps validation
      drm/amd/display: Skip ACPI backlight caps test
      drm/amd/display: Test vblank counter and scanout position
      drm/amd/display: Test DM atomic private state helpers
      drm/amd/display: Test affected MST DSC CRTC selection
      drm/amd/display: Test cursor commit
      drm/amd/display: Test vblank event arming
      drm/amd/display: Test page flip interrupt state update
      drm/amd/display: Test CRTC memory domain change detection
      drm/amd/display: Test PSR dirty rectangle filling
      drm/amd/display: Test plane reset decision
      drm/amd/display: Test link and sink dump
      drm/amd/display: Test HDCP update
      drm/amd/display: Test global modeset lock acquisition
      drm/amd/display: Test timing sync trigger
      drm/amd/display: Test IP block teardown and link emulation
      drm/amd/display: Test mod_power stream updates on modeset
      drm/amd/display: Test atomic commit setup
      drm/amd/display: Test MMHUB config read
      drm/amd/display: Test power module init
      drm/amd/display: Test vline0 irq control
      drm/amd/display: Test DMCU firmware load
      drm/amd/display: Test SW init and fini
      drm/amd/display: Test DM late init
      drm/amd/display: Test mode and plane init
      drm/amd/display: Test DM early init
      drm/amd/display: Test DC plane info fill
      drm/amd/display: Test DC plane attributes
      drm/amd/display: Test MST VCPI slot calc
      drm/amd/display: Test vblank IRQ handling
      drm/amd/display: Test self refresh entry
      drm/amd/display: Test GPU reset helpers
      drm/amd/display: Test plane update adapter
      drm/amd/display: Test MST resume guards
      drm/amd/display: Test cached suspend state
      drm/amd/display: Test writeback state transitions
      drm/amd/display: Test atomic validation guards
      drm/amd/display: Fix unused params in flip sched
      drm/amd/display: Validate irq source in DM IRQ handler
      drm/amd/display: Test DM IRQ handler source guard
      drm/amd/display: Fix signedness mismatches in cm3
      drm/amd/display: Test sink stream creation
      drm/amd/display: Test connector init helper
      drm/amd/display: Test HDMI connector init
      drm/amd/display: Test FreeSync caps update
      drm/amd/display: Test connector init
      drm/amd/display: Test forced atomic commit
      drm/amd/display: Test DCC reject for multi-plane format
      drm/amd/display: Test modifier list growth failure
      drm/amd/display: Test pre-GFX9 plane buffer attributes
      drm/amd/display: Test accepted plane atomic check
      drm/amd/display: Test cursor update without DC stream
      drm/amd/display: Test panic flush DCC teardown
      drm/amd/display: Test optional plane property creation
      drm/amd/display: Build MST DSC helpers for KUnit
      drm/amd/display: Test oversized AUX transfer
      drm/amd/display: Test MST connector creation
      drm/amd/display: Test link bandwidth readback
      drm/amd/display: Test cascaded Panamera check
      drm/amd/display: Test DSC caps validation
      drm/amd/display: Test MST port mode support
      drm/amd/display: Test FRL bandwidth lookup
      drm/amd/display: Test DSC precompute helpers
      drm/amd/display: Test DSC recompute check
      drm/amd/display: Test DSC config computation
      drm/amd/display: Test per-link DSC configs
      drm/amd/display: Select KUnit helpers
      drm/amd/display: Fold blending tests into two cases
      drm/amd/display: Fold universal overlay format test
      drm/amd/display: Fold plane modifier list tests
      drm/amd/display: Fold modifier append tests
      drm/amd/display: Fold GFX9 tiling info tests
      drm/amd/display: Fold GFX6-8 tiling and modifier tests
      drm/amd/display: Fold DCC validation tests
      drm/amd/display: Fold DCC block mode tests
      drm/amd/display: Fold plane scaling and cursor tests
      drm/amd/display: Fold plane state check tests
      drm/amd/display: Fix amdgpu_dm's kernel-doc warnings
      drm/amd/display: Test EDID helper paths
      drm/amd/display: Test AUX transfer paths
      drm/amd/display: Test MST topology start
      drm/amd/display: Test unassigned OTG CRTC lookup
      drm/amd/display: Test VRR pageflip completion
      drm/amd/display: Test HPD RX offload work branches
      drm/amd/display: Test HDMI HPD debounce re-detect
      drm/amd/display: Test HPD handler HDCP and detect
      drm/amd/display: Test HPD RX downstream handling
      drm/amd/display: Drop redundant amdgpu_dm_irq tests
      drm/amd/display: Fix KUnit connector warnings
      drm/amd/display: Fix KUnit CRTC warnings
      drm/amd/display: Fix KUnit cursor warning
      drm/amd/display: Fix KUnit VRR warnings
      drm/amd/display: Fix KUnit helper warnings
      drm/amd/display: Fix KUnit IRQ warnings
      drm/amd/display: Fix KUnit MST warnings
      drm/amd/display: Fix KUnit DM warnings
      drm/amd/display: Fix KUnit writeback warnings
      drm/amd/display: Fix KUnit checkpatch warnings
      drm/amd/display: Fix LSDMA divide by zero
      drm/amd/display: Relax DML frame limit with UBSAN

Alex Sierra (7):
      drm/amdgpu: fix master_xcc_ids[] indexing for non-zero xcc_id
      drm/amdkfd: Use dedicated kernel memory for compute MQDs on GFX12.1
      drm/amdkfd: disable debug before retiring MES process context on tear=
down
      Revert "drm/amdgpu: Set default xnack mode for gfx_v12.1 A0/B0"
      drm/amd: force remote MTYPE_NC on GFX12.1 mtype_local=3D0
      drm/amdgpu: log remote memory MTYPE for GC 12.1.0
      drm/amdgpu: disable XNACK replay for all VMIDs on GC 12.1.0 A0

Alexander Koskovich (2):
      dt-bindings: display: panel: Document Raydium RM69220 DDIC
      drm/panel: Add driver for Raydium RM69220 DDIC

Alexander Sverdlin (1):
      dt-bindings: display: simple: Add Truly TFT320240-229-E panel

Alexander Usyskin (1):
      drm/xe/nvm: add system controller region

Alexandre Courbot (2):
      gpu: nova-core: fix incorrect naming/framing of GSP-FMC firmware
      gpu: nova-core: fix warning with NOVA_CORE_SELFTESTS disabled

Alistair Popple (14):
      rust: auxiliary: let registration_data_with() closures return
covariant sub-fields
      gpu: nova-core: Add public driver API to nova-core
      drm: nova: Add DRM registration data
      drm: nova: Add GPU architecture enum to nova-drm UAPI
      drm: nova: Add chipid enum to nova-drm UAPI
      rust: uaccess: add UserSliceWriter::write_truncated()
      drm: nova: Add an info ioctl
      drm: nova: Add usable VRAM size to GPU info
      drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
      drm: nova: Expose a render node
      drm: nova: Report GPU name in GPU info
      drm: nova: Report GPU short name in GPU info
      drm: nova: Report GPU GID in GPU info
      gpu: nova-core: Use bar1_resource_index() in NovaCoreApi::bar1_size()

Allen Li (1):
      drm/amd/display: Skip link off frame count for general UI

Alvin Lee (25):
      drm/amd/display: Update dcn60 clkmgr interfaces
      drm/amd/display: Apply workaround to limit SopCount for now
      drm/amd/display: Disable alt-ch until dependencies are ready
      drm/amd/display: Add hook to disable alt-ch in PMO
      drm/amd/display: Update alt-ch size calculations
      drm/amd/display: Fix DPP PRE_GAM register offset on DCN60
      drm/amd/display: Ensure requested LSDMA BW is within the SOP bound
      drm/amd/display: Add override for LSDMA BW in QoS table
      drm/amd/display: Add override capability for UTM table params
      drm/amd/display: Enable FW locality check in DCN6
      drm/amd/display: Dump clock registers in HW init instead of SW init
      drm/amd/display: Update LLS and UPSP programming paths
      drm/amd/display: Add debug option to force optional UCLK support
      drm/amd/display: Enable back alt-ch
      drm/amd/display: Program DCC as part of address update
      drm/amd/display: Return success status from check_mode_supported
      drm/amd/display: Enable double buffering for DSCCLK updates
      drm/amd/display: Wait response should be based on fw_based_mclk_switc=
h
      drm/amd/display: Re-enable P-State message to SMU
      drm/amd/display: Disable gamcor light sleep before gamcor program
      drm/amd/display: Add temporary programming for port control in dc_ini=
t
      drm/amd/display: Don't round up cursor width to nearest 64
      drm/amd/display: Set cursor_offload for all pipes for a given stream
      drm/amd/display: Assign alt wa bit in fams2 cmd
      drm/amd/display: Add debug option to override low power SR latencies

Amber Lin (3):
      drm/amdgpu: Fix reset_hw_queue on MES 12.1
      drm/amdgpu: Set queue reset method for GC 12.1
      drm/amdgpu: Update queue reset support version

Amin Gattout (1):
      drm/amdgpu: Replace deprecated strcpy with strscpy

Amit Barzilai (6):
      dt-bindings: display: Add Solomon SSD1351 OLED controller
      drm/ssd130x: Change SSD133X color format to RGB565 from RGB332
      drm/ssd130x: Constify ssd130x_write_data() 'values' parameter
      drm/ssd130x: Replace positional ssd130x_spi_id[] initialization with =
C99
      drm/ssd130x: Implement ssd130x_write_cmd() on top of ssd130x_write_cm=
ds()
      drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support

Andreas Kemnade (2):
      drm/omap: dsi: avoid sending bta sync all the time in writes
      drm/omap: dsi: print errors with device prefix

Andrew Martin (1):
      drm/amdkfd: Fix always mapped range mapping to all ACCESS GPUs

Andrzej Kacprowski (6):
      accel/ivpu: Add support for getting and setting command queue priorit=
y
      accel/ivpu: Make BO free helper NULL-safe
      accel/ivpu: Improve HW IP gen and buttress version checks
      accel/ivpu: Drop MTL interrupt clear-with-zero workaround
      accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
      accel/ivpu: Load firmware on cold boot

Andy Shevchenko (1):
      drm/i915/gem: Use simpler versions of min*()

Ankit Nautiyal (20):
      drm/i915/hdmi: Use correct type for output_format parameter
      drm/i915/display: Generalize intel_hdmi_dsc_get_num_slices helper
      drm/i915/{dp,hdmi}: Pass bpc in intel_hdmi_dsc_get_bpp
      drm/i915/hdmi: Add helper to get max FRL rate for an HDMI sink
      drm/i915/dp: Use helpers for getting max FRL rate
      drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1
      drm/i915/dip: Add new file to handle Data Island Packet hardware
      drm/i915/vrr: Use the helper to write EMP_AS_SDP_TL register
      drm/i915/intel_dip: Add check for DP encoder
      drm/i915/dip: Add helper to get AS SDP Transmission Line
      drm/i915/display: Add crtc state for DIP transmission lines
      drm/i915/dip: Store and use AS SDP transmission line from crtc state
      drm/i915/dip: Add HAS_COMMON_SDP_TL macro
      drm/i915/dip: Store SDP transmission lines in crtc_state
      drm/i915/dp: Introduce helpers to enable/disable CMN SDP Transmission=
 line
      drm/i915/dip: Enable Common SDP Transmission line
      drm/i915/dp: Account VSC SDP in min guardband
      drm/i915/dp: Adjust SDP guardband requirement for CMN_SDP_TL
      drm/i915/display: Dump DIP Transmission lines
      drm/i915/display: Update the CMN_SDP_TL in fastset path

Anoop Vijay (4):
      drm/xe/sysctrl: Read mailbox phase bit from hardware
      drm/xe/sysctrl: Add helper to query application status
      drm/xe/sysctrl: Add helper to check oCode firmware readiness
      drm/xe/sysctrl: Allow per-command mailbox response timeout

Antonin Malzieu Ridolfi (1):
      gpu: nova-core: Extract PMC registers definitions

Aric Cyr (1):
      drm/amd/display: only reprogram DRR when v_total values change

Arnd Bergmann (2):
      drm/amd/display: fix unused function warnings
      drm/panel: fix novatek-nt36536 dependencies

Arthur Heymans (1):
      drm/amd/display: Preserve eDP mode on initial ASSR failure

Arun R Murthy (2):
      drm/i915/dp: On DPCD init wake the DPRx for eDP
      drm/i915/dip_regs: Add register definitions for common SDP
Transmission Line

Arunpravin Paneer Selvam (3):
      gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker
      gpu/tests/buddy: add dirty tracker performance KUnit test
      drm/amdgpu: skip the VMID 0 flush for VRAM

Arvind Yadav (5):
      drm/xe: Reject page faults from non-fault-mode scratch VMs
      drm/xe/log: Add GUCSUBMIT component
      drm/xe/guc: Report reset failure using SIGID
      drm/xe/svm: Report terminal page-fault failures using SIGID
      drm/xe/gt: Report GT reset failure using SIGID

Asad Kamal (4):
      drm/amd/pm: add 5s custom timeout for unload messages
      drm/amd/amdgpu: Add soc_v1_0 reset handler
      drm/amd/amdgpu: Allow reset init for smu_v15_0_8
      drm/amdkfd: fix use-after-free and multi-container gap in kfd_dev_map=
ping

Ashutosh Dixit (3):
      drm/xe/mcr: Take vcs1/vecs1 into account for first media slice
      drm/xe/oa: Extend OAM unit hwe assignment for new dGfx
      drm/xe/xe_gt_idle: fix vecs config for powergating info

Ashwin Santhosh (3):
      drm/amd/display: Program OPP formatter for plane-less ODM segments
      drm/amd/display: Promote DC to 3.2.400
      drm/amd/display: Promote DC to 3.2.401

Austin Zheng (16):
      drm/amd/display: Make Struct In DCN42 SOC BB Header Static
      drm/amd/display: Refactor Per-DPM Derate Logic
      drm/amd/display: Update Derates And Set Default Per-DPM Derates
      drm/amd/display: Unify CalculateFlipSchedule Logic
      drm/amd/display: Update soc_and_ip_translator To Use Updated
Per-DPM Derate Organization
      drm/amd/display: Fix CalculateFlipSchedule Calculation
      drm/amd/display: Preparations To Move DML Wrapper Out Of DML
      drm/amd/display: Clean up Per-DPM Struct
      drm/amd/display: Fix Order Of Operation In Calculate Flip Schedule
      drm/amd/display: Remove const Qualifier From Non-Pointer Fields
      drm/amd/display: Move DML Wrapper into its own Component
      drm/amd/display: Set DISPCLK per surface in DML
      drm/amd/display: Update Urgent Burst Calculation To Account For
Unbounded Requests
      Revert "drm/amd/display: Unify CalculateFlipSchedule Logic"
      drm/amd/display: Update DML fields used for mode support
      drm/amd/display: Add Back Unified CalculateFlipSchedule

Badal Nilawar (1):
      drm/xe/cri: Expose device UID through sysfs

Baineng Shou (1):
      dma-buf/test: add KUnit case for dma_fence_dedup_array() empty input

Balasubramani Vivekanandan (1):
      drm/xe/xe_gt_idle: Add CCS to the powergating info print

Bartosz Golaszewski (1):
      drm/xe/i2c: Re-apply use device_create_managed_software_node()

Ben Dooks (2):
      soc: qcom: smsm: fix __iomem annotations
      soc: qcom: smp2p: fix __iomem annotation on entry->value pointer

Bhaskar Reddy Valluru (2):
      drm/msm/a8xx: Add Adreno 845 support
      dt-bindings: display/msm: Document A845 GPU and GMU

Bhawanpreet Lakha (32):
      drm/amd/display: Cover crtc duplicate_state stream and null guard
      drm/amd/display: Cover crtc destroy callback
      drm/amd/display: Add reset_state existing-state branch test
      drm/amd/display: Add amdgpu_dm_crtc_late_register test
      drm/amd/display: Add amdgpu_dm_crtc_init tests
      drm/amd/display: Add KUnit tests for amdgpu_dm_crtc_helper_atomic_che=
ck
      drm/amd/display: Cover MST path in encoder atomic_check
      drm/amd/display: Cover amdgpu_dm_encoder_init
      drm/amd/display: Cover MST-start failure in detect_mst
      drm/amd/display: Cover amdgpu_dm_update_connector_after_detect
      drm/amd/display: Cover HDMI infoframe/freesync timing paths
      drm/amd/display: Add amdgpu_dm_connector_poll KUnit tests
      drm/amd/display: Cover hide_secondary_tile_from_userspace
      drm/amd/display: Cover dm_validate_stream_and_context
      drm/amd/display: Cover amdgpu_dm_create_validate_stream_for_sink
      drm/amd/display: Cover amdgpu_dm_connector_mode_valid
      drm/amd/display: Cover mode_valid EDID mgmt path
      drm/amd/display: Cover amdgpu_dm_fill_hdr_info_packet
      drm/amd/display: Cover amdgpu_dm_connector_atomic_check
      drm/amd/display: Cover atomic_check modeset triggers
      drm/amd/display: Cover funcs_force valid EDID path
      drm/amd/display: Cover amdgpu_dm_connector_get_modes
      drm/amd/display: Cover create_eml_sink valid EDID path
      drm/amd/display: Cover amdgpu_set_panel_orientation
      drm/amd/display: Cover amdgpu_dm_prune_primary_tile_modes
      drm/amd/display: Cover add_fs_modes mode generation
      drm/amd/display: Cover add_fs_modes illegal timing skip
      drm/amd/display: Cover hdmi_frl_status_polling_work
      drm/amd/display: Cover amdgpu_dm_i2c_xfer
      drm/amd/display: Cover amdgpu_dm_create_i2c
      drm/amd/display: Cover dm_restore_drm_connector_state
      drm/amd/display: Cover EDID CEA parsing helpers

Bibek Kumar Patro (1):
      arm64: dts: qcom: shikra: Add Adreno SMMU node

Biju Das (7):
      drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val to hw_info
      drm: renesas: rzg2l_mipi_dsi: Add activation_dly to hw_info
      drm: renesas: rzg2l_mipi_dsi: Move global timings into hardware
info struct
      drm: renesas: rzg2l_mipi_dsi: Add support for DSI PWRRDY
      drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI support
      drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU support
      drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder

Bjorn Andersson (6):
      Merge branch
'20260806-eliza-mm-cc-v9-v10-1-6ba52dd14343@oss.qualcomm.com' into
HEAD
      arm64: dts: qcom: hamoa-pmics: Mark pmk8550_vadc thermal sensor provi=
der
      arm64: dts: qcom: hamoa-crd: Add thermal control
      dt-bindings: arm: qcom: Add Asus Zenbook A14 (UX3407NA)
      arm64: dts: qcom: glymur: Add Asus Zenbook A14 (UX3407NA)
      firmware: qcom: scm: Allow QSEECOM on Asus Zenbook A14 (UX3407NA)

Bokun Zhang (2):
      drm/amdgpu: Add VCN v5.0.2 SRIOV code path
      drm/amdgpu: Add JPEG v5.0.2 SRIOV code path

Boris Brezillon (9):
      drm/panthor: Make panthor_irq::state a non-atomic field
      drm/panthor: Move the register accessors before the IRQ helpers
      drm/panthor: Replace the panthor_irq macro machinery by inline helper=
s
      drm/panthor: Don't update might_have_idle_groups in
process_idle_event_locked()
      drm/panthor: Get rid of panthor_group::fatal_lock
      drm/panthor: Protect events processing with a separate spinlock
      drm/panthor: Don't defer job completion checks
      drm/panthor: Don't defer FW event processing
      drm/panthor: Automate CSG IRQ processing at group unbind time

Boyuan Zhang (1):
      drm/amdgpu/jpeg: fix jpeg_v5_0_2_is_idle detection

Brajesh Gupta (1):
      drm/imagination: Add job type info to pvr_job_submit_fw trace event

Brian Nguyen (1):
      drm/xe: Implement print vfunc for page fault info logging

Caden Chien (2):
      drm/amdgpu/vpe: add vpe v3.0.0 support
      drm/amdgpu/vpe: add vpe v3.0.1 support

Candice Li (10):
      drm/amdgpu: factor PSP v1.0 firmware bin descriptor parsing
      drm/amdgpu: load standalone RL firmware on psp v15_0_8
      drm/amdgpu: load TA firmware for psp v15_0_8
      drm/amdgpu: update UMC active_mask to u64
      drm/amdgpu: add ext_umc_mask to RAS TA init
      drm/amd/ras: add ext_umc_mask to RAS TA init
      drm/amdgpu: declare MEC_1 and RLC firmware in gfx_v12_1
      drm/amdgpu: enable RAS on psp v15_0_8
      drm/amd/ras: enable UniRAS for psp v15_0_8
      drm/amd/ras: use PCRU0 C2PMSG for Uniras on psp v15_0_3

Casey Connolly (1):
      drm/panel: ebbg-ft8719: Set prepare_prev_first

Ce Sun (2):
      drm/amdgpu/ras: allow ClearMcaOnRead during GPU recover resume
      drm/amdgpu : Update psp 13_0_15 ip block support for uniras

Chaitanya Kumar Borah (11):
      drm/i915/dp_mst: Remove duplicate intel_pfit_compute_config() call
      drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
      drm/i915/hdmi: Move audio compute config after format selection
      drm/i915/audio: Prune ELD SADs based on HDMI audio bandwidth
      drm/i915/color: Add CSC on SDR plane color pipeline
      drm/i915/display: extract glk_plane_color_ctl_input_csc helper
      drm/i915/display: simplify glk_plane_color_ctl_input_csc
      drm/i915/display: Program CSC on SDR planes based on Fixed Matrix Col=
orop
      drm/i915/color: Add support for 1D LUT in SDR planes
      drm/i915/color: Add color pipeline support for SDR planes
      drm/i915/color: Add YUV buffer support on HDR planes

Chaoyi Chen (2):
      drm/rockchip: dsi: Add maximum per lane bit rate calculation
      drm/rockchip: dsi: Add dphy_get_timing support for multiple PHY types

Charlene Liu (5):
      drm/amd/display: fix HPD program filter programming
      drm/amd/display: add a NULL pointer check
      drm/amd/display: Make sure streamclk gating is off when enabling stre=
amclk
      drm/amd/display: avoid to write signal specific for tmds
      drm/amd/display: Fix zero dlg_reg write to program_ext_vblank

Chen-Yu Tsai (4):
      drm/verisilicon: Switch to drm_fb_dma_get_addr() for framebuffer addr=
esses
      drm/tidss: dispc: Switch to drm_fb_dma_get_gem_addr() for
framebuffer addresses
      drm/sysfb: Use iosys_map_memset() to clear buffer
      drm/exynos/fimd: fix register offset type in fimd_trigger()

Cheng, Tony (1):
      drm/amd/display: Keep public DC lifecycle APIs stable beside Core 2

Chengjun Yao (1):
      drm/amdgpu: fix rmmio iounmap skipped on device removal

Chenyu Chen (2):
      drm/amd/display: Add CACP ACE curve area debugfs for IGT validation
      drm/amd/display: Use unsigned types for FRL cap check params and
HPO read_state

Christian Hergert (2):
      drm/virtio: preserve damage clips for rendered resources
      drm/virtio: Recalculate ignore_damage_clips on every update

Christian K=C3=B6nig (7):
      drm/amdgpu: start to move VM internals into amdgpu_vm_internal.h
      drm/amdgpu: remove unecessary parameters from trace_amdgpu_vm_update_=
ptes
      drm/i915: fix incorrect RCU teardown order
      MAINTAINERS: change TTM maintainers to Natalie and Arun
      drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock uses
      drm/amdgpu: rework eviction lock handling into critical section v3
      drm/sched: document the RCU dependency

Clay King (1):
      drm/amd/display: adjust floating point format for gamut remap when ne=
eded

Colin Ian King (1):
      drm/amd/display: Fix spelling mistake "optmization" -> "optimization"

Cristian Ciocaltea (48):
      video/hdmi: Introduce HDMI version enum
      drm/connector: hdmi: Handle reset() state allocation failure
      drm/display: hdmi: Rename drmm_connector_hdmi_init() to *_ini2()
      drm/connector: Add drmm_connector_hdmi_init() with new signature
      drm/display: bridge_connector: Convert to drmm_connector_hdmi_init()
      drm/probe-helper: Introduce .force_ctx() connector callback
      drm/connector: Add HDMI 2.0 scrambler infrastructure
      drm/display: scdc-helper: Add macro for connector-prefixed debug mess=
ages
      drm/display: scdc-helper: Add helper to set SCDC version information
      drm/display: hdmi: Add HDMI 2.0 scrambling management helpers
      drm/display: hdmi: Advertise SCDC source version when scrambling
      drm/bridge: Remove redundant error check in drm_bridge_helper_reset_c=
rtc()
      drm/bridge: Add bridge ops for source-side HDMI 2.0 scrambling
      drm/display: bridge_connector: Use cached connector status in .get_mo=
des()
      drm/display: bridge_connector: Switch to .detect_ctx() connector help=
er
      drm/display: bridge_connector: Wire up HDMI 2.0 scrambler callbacks
      drm/display: hdmi-state-helper: Add source TMDS rate validation
      drm/display: hdmi-state-helper: Pass acquire ctx to hotplug helpers
      drm/display: hdmi-state-helper: Add
drm_atomic_helper_connector_hdmi_force_ctx()
      drm/display: hdmi-state-helper: Sync SCDC state on hotplug
      drm/display: hdmi-state-helper: Set HDMI scrambling requirement
      drm/display: bridge_connector: Switch to .force_ctx() connector helpe=
r
      drm/bridge: dw-hdmi-qp: Demote i2c bus error messages to debug level
      drm/bridge: dw-hdmi-qp: Provide .{enable,disable}_hpd() PHY ops
      drm/bridge: dw-hdmi-qp: Remove unused workqueue include and define
      drm/bridge: dw-hdmi-qp: Add HDMI 2.0 scrambling support
      drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper
      drm/rockchip: dw_hdmi_qp: Fix invalid drvdata access in PM ops
      drm/rockchip: dw_hdmi_qp: Cancel pending HPD work on suspend
      drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() mes=
sages
      drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind=
()
      drm/rockchip: dw_hdmi_qp: Avoid spurious HPD IRQ thread wakeups
      drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ in io_init
      drm/rockchip: dw_hdmi_qp: Implement .{enable,disable}_hpd() PHY ops
      drm/rockchip: dw_hdmi_qp: Factor out HPD interrupt (un)mask helpers
      drm/rockchip: dw_hdmi_qp: Control the HPD IRQ line via the bridge HPD=
 ops
      drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD reports
      drm/bridge: dw-hdmi-qp: Drop unused .setup_hpd() phy op
      drm/rockchip: rk3066_hdmi: Convert to devm_drm_bridge_alloc() API
      drm/bridge: lontium-lt8713sx: Drop redundant bridge funcs assignment
      drm/bridge: adv7511: Advertise HDMI 1.2 capabilities
      drm/bridge: inno-hdmi: Advertise HDMI 1.2 capabilities
      drm/bridge: ite-it6263: Drop redundant .mode_valid hook
      drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities
      drm/bridge: ite-it66121: Advertise HDMI 1.2 capabilities
      drm/bridge: lontium-lt9611: Advertise HDMI 1.4 capabilities
      drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities
      drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()

Dale Whinham (2):
      arm64: dts: qcom: x1-denali: Add audio playback over DisplayPort
      arm64: dts: qcom: x1-denali: Add volume up/down GPIO keys

Damon Ding (5):
      dt-bindings: display: bridge: analogix-dp: Add data-lanes
support for endpoint
      drm/dp: Add helper to validate DP lane counts
      drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
      drm/bridge: analogix_dp: Add validation for samsung,lane-count proper=
ty
      drm/bridge: analogix_dp: Add support for optional data-lanes mapping

Dan Carpenter (3):
      drm/xe: tests: fix error message in xe_migrate_sanity_test()
      soc: qcom: smem: Fix signedness bug in smem_dram_parse()
      drm/amd/pm: delete a stray tab

Daniel Charles (2):
      drm/xe/xe3p: Force non-compressible memory reads to 256B overfetches
      drm/xe: Add focused VM teardown and page fault tracing

Daniel Drake (1):
      drm/vc4: Set DRM DMA device directly from HVS and V3D

Daniele Ceraolo Spurio (2):
      drm/xe/pxp: add termination on resume
      drm/xe: Do not apply WA 14025883347 to media 3503

Danila Tikhonov (1):
      arm64: dts: qcom: sm7325-nothing-spacewar: Add ath11k calibration-var=
iant

Danilo Krummrich (15):
      Merge tag 'v7.3-rc1' into drm-rust-next
      rust: debugfs: drop 'static bound from ScopedDir file creation method=
s
      rust: dma: tie CoherentHandle to the device's bound lifetime
      samples: rust_dma: separate driver type from driver data
      rust: dma: tie Coherent and CoherentBox to the device's bound lifetim=
e
      Merge tag 'rust-io-7.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core
into drm-rust-next
      Merge tag 'rust-dma-7.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core
into drm-rust-next
      gpu: nova-core: align Bar1 alias with Bar0
      gpu: nova-core: remove unnecessary Arc around BarUser
      gpu: nova-core: mm: get rid of Arc<BarUser> in BarUserAccess
      gpu: nova-core: mm: fix lifetime name in BarUser
      gpu: nova-core: use a single try_pin_init!() block in probe()
      drm: nova: Move VRAM BAR size query to GPU info
      rust: drm: Return impl PinInit from drm::Registration::new()
      rust: drm: Remove unused flags argument from Registration::new()

Dave Airlie (23):
      Merge tag 'drm-xe-next-2026-08-31-1' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'drm-misc-next-2026-09-03' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'drm-intel-next-2026-09-03' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-misc-next-2026-09-10' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-next-7.4-2026-09-10' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next
      Merge tag 'drm-misc-next-2026-09-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-next-7.4-2026-09-17' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next
      Merge tag 'drm-xe-next-2026-09-18' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Backmerge tag 'v7.3-rc4' into drm-next
      Merge tag 'drm-misc-next-2026-09-24' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-next-7.4-2026-09-24' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next
      PCI/VGA: pass a data pointer to be used in the decode callback (v2)
      Merge tag 'topic/pci-vgaarb-rework-2026-10-01' of
https://gitlab.freedesktop.org/drm/kernel into drm-next
      Merge tag 'exynos-drm-next-for-v7.4' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-next
      Merge tag 'drm-intel-gt-next-2026-10-01' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-xe-next-2026-10-01' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'drm-misc-next-2026-10-02' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      BackMerge tag 'v7.3-rc6' into drm-next
      Merge tag 'drm-intel-next-2026-10-02' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'amd-drm-next-7.4-2026-10-08' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next
      Merge tag 'drm-msm-next-2026-10-11' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge tag 'drm-rust-next-2026-10-11' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
      Merge tag 'drm-misc-next-2026-10-16' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next

David Belanger (2):
      drm/kfd: Add CU occupancy support to GFX10 and GFX10.3
      drm/amdkfd: Disable gfxoff for CU occupancy

David Carlier (1):
      drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink import

David Francis (3):
      drm/amdgpu: Add trace events for pid register/deregister
      drm/amdkfd: Avoid integer underflow with ffs in EOP ring size calc
      drm/amdkfd: Avoid integer underflow in EOP ring size calculation.

David Heidelberg (4):
      arm64: dts: qcom: sdm845-google: Set i2c3 frequency to 400 kHz
      arm64: dts: qcom: sdm845-google: Improve NFC pins description
      drm/panel: ebbg-ft8719: Fix the MODULE_LICENSE() string
      drm/panel: ebbg-ft8719: Split initialization into enable/disable fn

David Rosca (2):
      drm/amdgpu/userq: Add syncobj_points to signal ioctl
      drm/amdgpu: Bump version for userq timeline syncobj fixes

David Yat Sin (1):
      drm/amdgpu: Flush the pasid on all XCCs in parallel

David Zhang (1):
      accel/amdxdna: Reject device heap BO when dev_mem_size is not set

Dawid Osuchowski (3):
      drm/print: add drm_warn_ratelimited logging macro
      accel/ivpu: Use drm_warn_ratelimited macro
      accel/ivpu: Convert hw_ip_gen/btrs_gen to enum types

Deborah Brouwer (3):
      drm/tyr: gpu_info: zero out new/unused fields
      MAINTAINERS: add rust-for-linux list for Tyr
      drm/tyr: reduce size of doorbell array

Deepanshu Kartikey (1):
      drm/i915: Guard against NULL driver_data in i915_pci_probe()

Deepti Jaggi (2):
      arm64: dts: qcom: Add device tree for Nord GearVM variant
      arm64: dts: qcom: Add device tree for Nord Ride board

Dillon Varone (13):
      drm/amd/display: Add support for overriding UTM client QC profile
      drm/amd/display: Rename carried dce clock manager functions for dcn10
      drm/amd/display: Fix mismatch number of OPP/DPP accounting
      drm/amd/display: Populate vblank_nom according to bounding box
      drm/amd/display: Guard DAL port idle optimizations by ASIC rev
      drm/amd/display: Re-enable multi-dwb support
      drm/amd/display: Change RBBMIF timeout control conditions
      drm/amd/display: Add immediate restore to FAMS2 for DRR
      drm/amd/display: Cleanup DMUB command submission interfaces
      drm/amd/display: Add more diagnostic logs for DMU
      drm/amd/display: Add dcn60 revision specific clock overrides
      drm/amd/display: Fix VTG programming for dcn60
      drm/amd/display: Add dcn42b project id

Diogo Silva (15):
      drm/exynos: remove dependency on DRM simple helpers
      drm/xlnx/zynqmp_dpsub: remove dependency on DRM simple helpers
      drm/tegra: remove dependency on DRM simple helpers
      drm/fsl-dcu: remove dependency on DRM simple helpers
      drm/kmb: remove dependency on DRM simple helpers
      drm/virtio: remove dependency on DRM simple helpers
      drm/tidss: remove dependency on DRM simple helpers
      drm/imx: remove dependency on DRM simple helpers
      drm/mediatek: remove dependency on DRM simple helpers
      drm/renesas/shmobile: remove dependency on DRM simple helpers
      drm/hisilicon/kirin: remove dependency on DRM simple helpers
      drm/arm/komeda: remove dependency on DRM simple helpers
      drm/meson: remove dependency on DRM simple helpers
      Documentation/gpu: remove completed drm_simple_encoder_init() todo
      drm/drm_simple: remove deprecated drm_simple_encoder_init function

Dmitriy Chumachenko (1):
      drm/amdgpu: check ras and obj before dereference

Dmitry Baryshkov (5):
      drm/msm/mdp5: drop cursor pipe for msm8x76
      drm/msm/a5xx: don't read the GPMU registers on GPUs without a GPMU
      drm/msm/a2xx: Add hangcheck progress detection
      drm/msm/a3xx: Add hangcheck progress detection
      drm/msm/a5xx: Add hangcheck progress detection

Dmytro Laktyushkin (1):
      drm/amd/display: Enable dcn42 pstate pmo

Dominik Kaszewski (3):
      drm/amd/display: Add lock-free memory pool
      drm/amd/display: Fix compound literal stackframe limit
      drm/amd/display: Add missing message to static_assert

Donggeun Yoo (2):
      drm/sched: Drop the unused entity argument from drm_sched_fence_alloc=
()
      drm/sched: Free the run queues at the end of drm_sched_fini()

Dorinda Bassey (1):
      drm/virtio: add ARGB8888 support for primary planes

Dr. David Alan Gilbert (4):
      drm/amdgpu: Remove is_idle test case
      drm/amdgpu: Remove is_idle (trivial cases)
      drm/amdgpu: Remove is_idle (non trivial functions)
      drm/amdgpu: Remove is_idle

Ed Maste (1):
      drm/amd/amdgpu: Add newlines in drm_dbg format strings

Edwin Peer (1):
      rust: dma_fence: gate abstractions on CONFIG_DMA_SHARED_BUFFER

Eliot Courtney (3):
      gpu: nova-core: mm: Implement Alignable and Debug for VramAddress
      gpu: nova-core: mm: Add the memory management HAL
      gpu: nova-core: Add self-test assertion macros and config option

Emily Deng (1):
      drm/amdgpu/psp: wait for TOS ready on all AIDs in v15_0_3 ring create

Eric Huang (7):
      drm/amdgpu: add new mes misc api for gfx11
      drm/amdkfd: workaround 100% gpu usage issue for gfx11
      drm/amdgpu/userq: create the same workaround of oversubscription time=
r
      drm/amdgpu: correct oversubscription timer interval for gfx11
      drm/amdgpu: fix oversubscription timer for sr-iov
      drm/amdgpu: fix atomics on DF 5.0.2
      drm/amdgpu: specify cwsr_enable usage doc

Erick Karanja (1):
      drm/v3d: Restrict v3d_perfmon_stop_locked() to v3d_perfmon.c

Esben Haabendal (1):
      drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

Eva Crystal (2):
      accel/amdxdna: clear the mailbox channel pointer when starting it fai=
ls
      accel/amdxdna: document trusted mailbox ring geometry and drop
the power-of-two check

Fabio Estevam (1):
      drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable delay

Fabio Piparo (1):
      drm/ssd130x: Set the address window in ssd132x_clear_screen()

Fangzhi Zuo (15):
      drm/amd/display: Force FreeSync range minimum on quirky panels
      drm/amd/display: restore FRL cap on non-destructive HDMI link verify
      drm/amd/display: Add HDMI 2.1 FreeSync support for AMD VSDB
      drm/amd/display: Add HDMI 2.1 VRR support for HF-VSDB
      drm/amd/display: Enable HDMI ALLM for Gaming-VRR
      drm/amd/display: Enable HDMI FRL by default
      drm/amd/display: Emit VTEM for HF-VSDB VRR on TMDS links
      drm/amd/display: Exit IPS before connector detection on resume
      drm/amd/display: Fix HF-VSDB DSC bpc detection to be cumulative
      drm/amd/display: Fix NULL deref of new_stream->sink in VTEM guard
      drm/amd/display: Force DSC to 8bpp for MST DP tunneling over USB4
      drm/amd/display: Force DSC to 8bpp for SST DP tunneling over USB4
      drm/amd/display: Restore FreeSync VCP code check for HDMI/PCON sinks
      drm/amd/display: Serialize HDMI FRL status polling against link detec=
t
      drm/amd/display: Skip HDMI FRL status polling while link is down

Feifei Xu (12):
      drm/amdgpu: Disable SDMA Hang WatchDog in SDMA_v7_1
      drm/amdgpu: add amdgpu_discovery_log_bad_signature helper
      drm/amdgpu: add MEM_RESERVED_INFO to discovery table
      drm/amdgpu: Add NPS_INFO case to amdgpu_discovery_table_check
      drm/amdgpu: add amdgpu_discovery_get_mem_reserved_info_table
      drm/amdgpu: add amdgpu_discovery_get_mem_reserved_region_by_id
      drm/amdgpu: add get_fw_reserved_info implementation
      drm/amdgpu: set reserve_tmr in amdgpu_discovery_get_tmr_info
      drm/amdgpu: query the reserved info with get_fw_reserved_info
      drm/amdgpu: add amdgpu_discovery_dump_mem_reserved_info_table
      drm/amdgpu: add mem_reserved_info sysfs attribute
      drm/amdgpu/discovery: skip MEM_RESERVED_INFO on unsupported ASICs

Felix Kuehling (18):
      drm/amdgpu: Make extra space in psp->cmd_buf_bo usable
      drm/amdgpu: Add sysfs API for UALink information
      drm/amdgpu: Add sysfs API for UALink physical pod setup
      drm/amdgpu: Add sysfs API for UALink virtual pod config
      drm/amdgpu: Add sysfs API for UALink station configuration
      drm/amdgpu: Implement PSP cmd UAL_GET_CONFIG
      drm/amdgpu: Query initial UALink config from PSP
      drm/amdgpu: Implement PSP cmd UAL_SET_PPOD_CONFIG
      drm/amdgpu: Set physical pod configuration to PSP
      drm/amdgpu: Implement PSP cmd UAL_SET_VPOD_CONFIG
      drm/amdgpu: Set virtual pod configuration to PSP
      drm/amdgpu: Implement PSP cmd UAL_SET_STATION_CONFIG
      drm/amdgpu: Set UALink station config to PSP
      drm/amdgpu: Implement PSP cmd UAL_SET_NPA_CONFIG
      drm/amdgpu: Enable/disable NPA address translation using PSP
      drm/amdgpu: Prevent double-free of drm_exec
      drm/amdgpu: Pin page tables in NPA VMs
      drm/amdgpu: Initialize NPA PT/PDs to noretry

Francesco Dolcini (2):
      dt-bindings: lcdif: Add endpoint bus-width property
      drm: mxsfb: Add optional DPI output bus-width configuration

Francis Marlou Pacaro (1):
      drm/amd/display: fix MALL hysteresis timer underflow at high refresh =
rates

Francisco Beltr=C3=A1n Millal=C3=A9n (1):
      drm/amdgpu: reset VI ASIC on MacBookPro14,3

Frank Bodammer (1):
      drm/panel: simple: Add support for Truly TFT320240-229-E panel

Frank Min (7):
      drm/amdgpu: add GDDR7 vram name
      drm/amdgpu: add debug info for psp ip key mgr ucode
      drm/amdgpu: update FIRMWARE ID for soc24
      drm/amdgpu: add hdp v8 ip block
      drm/amdgpu: Add support for PSP version 15.0.3
      drm/amdgpu: Add firmware type retrieval in PSP v15.0.3
      drm/amdgpu: add infrastructrure for handling mp5 firmware

Fudongwang (1):
      drm/amd/display: Change default SR z8 exit/enter value

Gabe Teeger (7):
      drm/amd/display: clamp force_min_dcfclk to dcn42b range
      drm/amd/display: Enable min dispclk ODM on DCN42
      drm/amd/display: Force min DCFCLK on AC for DCN42B
      drm/amd/display: Enable power gating on dcn42b
      drm/amd/display: Bound DSC power gating loop by num_dsc
      drm/amd/display: Remove MALL capabilities from DCN42B
      drm/amd/display: Remove MALL capabilities from DCN42B bounding box

Gaghik Khachatrian (2):
      drm/amd/display: gate DCE ASIC code behind CONFIG_DRM_AMD_DC_DCE
      drm/amd/display: Add passthrough visual confirm

Gajendra Uttamchand (1):
      drm/xe/lrc: document sentinel and make CTX_TIMESTAMP read TOCTOU-safe

Gang Ba (2):
      drm/amdkfd: Fix TCP XNACK scoreboard reset race
      drm/amdkfd: Fix TCP XNACK scoreboard reset race on MI300

Gangliang Xie (7):
      drm/amdgpu: add handler for nHT error
      drm/amdgpu: add ta loading in psp v15_0_3
      drm/amd/ras: add support for umc v13
      drm/amd/ras: add support for GC 13
      drm/amd/ras: add support for smu v15_0_3
      drm/amd/ras: add support for nbio v7_10_0
      drm/amd/ras: add support for psp v15_0_3

Gary Guo (20):
      gpu: nova-core: fix barrier usage in CPU->GSP messaging path
      gpu: nova-core: fix barrier usage in GSP->CPU messaging path
      rust: io: register: reimplement as proc macro
      rust: mem: add `transmute` with deferred size check
      rust: mem: add `AsRepr` and `AsReprMut`
      rust: io: perform conversions using `AsRepr`
      rust: io: support register projections
      rust: io: register: allow explicit base type specification
      gpu: nova-core: specify base type for registers
      drm/tyr: specify base type for registers
      samples: rust: pci: specify base type for registers
      rust: io: register: make register have a typed base
      rust: io: register: support fixed offset register without bitfield
      gpu: nova-core: use projection for PFALCON and PFALCON2 registers
      gpu: nova-core: convert hshub0 from relative register to projection
      rust: io: register: remove relative registers
      rust: io: register: remove `Register` trait and cleanup macro
      rust: io: register: unify handling of register with/without bitfields
      rust: io: add static `cast()` method for views
      drm/tyr: use `bitfield!` instead of `register!` for non-registers

Gaurav Kohli (1):
      arm64: dts: qcom: eliza: Add GPU cooling

Geert Uytterhoeven (1):
      firmware: QCOM interfaces should depend on ARCH_QCOM

George Karagounis (1):
      accel/amdxdna: Replace create_singlethread_workqueue with
alloc_ordered_workqueue

Gopikrishna Garmidi (2):
      soc: qcom: smem: fix 32-bit overflow in DDR frequency calculation
      drm/panel-edp: Add Sharp LQ138P1JX61 (Surface Laptop 8th Ed.)

Gourav Kumar (1):
      soc: qcom: ubwcg: Add Nord UBWC config

Greg Ociepka (2):
      arm64: dts: qcom: glymur: Add missing USB clock, power and bandwidth =
votes
      arm64: dts: qcom: glymur: Mark USB controllers dma-coherent

Guangshuo Li (2):
      drm/amdgpu: fix IP instance memory leak on kobject add failure
      drm/amdgpu: fix ACP MFD device leak on init failure

Haikun Zhou (2):
      drm/panel-edp: Support MNE007QS3-F and TM140VDXP15 edp panel
      drm/panel-edp: Support NV140WU2-M70 edp panel

Hansen Dsouza (1):
      drm/amd/display: Add debug bit for force p2cpm

Hao-Qun Huang (1):
      accel/qaic: reject BO sizes that overflow page count

Haojie Li (3):
      dma-buf: fix coding style in dma_resv_get_singleton
      dma-buf: fix comment in dma_buf_llseek to match implementation
      drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info

Hardeep Sharma (3):
      dt-bindings: firmware: qcom,scm: Document SCM on Kuno SoC
      soc: qcom: geni-se: allow selection on 32-bit ARM Qualcomm SoCs
      dt-bindings: arm: qcom: Document Kuno IDP board

Hari Mishal (4):
      drm/amd/display: fix division by zero in get_estimated_bw()
      drm/amd/pm: bound SCLK FCW range entries to the table size
      drm/amdgpu/atom: bound the VBIOS date, part number, version and
build getters
      drm/amd/display: guard dc_sink dereferences in MST mode validation

Harish Kasiviswanathan (3):
      drm/amdkfd: Don't use DEVICE_COHERENT on GFX12.1
      drm/amdgpu: Add helper function to check psp xgmi ta
      drm/amdgpu: Add ual_config_state to ual_get_config

Harry VanZyllDeJong (1):
      drm/amd/display: eDP panel polarity control and test support

Harry Wentland (13):
      drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
      drm/vkms: Add fixed matrix colorop to color pipeline
      drm/vkms: Add atomic check and matrix handling for fixed matrix color=
op
      drm/amd/display: Add fixed matrix colorop to color pipeline
      drm/amd/display: Implement fixed matrix colorop color space mapping
      drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
      drm/amd/display: Check actual state during commit_tail
      drm/amd/display: Set color_space to plane_infos
      drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22=
/HLG
      drm/amd/display: pull colorops into state when recreating a plane
      dm/amdgpu: fix malformed link_settings debugfs output
      drm/amd/display: enable shaper when programming 3DLUT
      drm/amd/display: log MCM shaper and 3D LUT mode in the DTN log

Hawking Zhang (26):
      drm/amd/display: use GNU make rwildcard instead of find
      drm/amdgpu: Init partition_mode and xcc_mask for GFX_IMU_PARTITION_SW=
ITCH
      drm/amdgpu/gfxhub_v12_1: Remove obsolete programming
      drm/amdgpu/mmhub_v4_2: Remove obsolete programming
      drm/amdgpu: Add gc_info_v1_5 table for soc_v1_0
      drm/amdgpu: Use max SA WGP count for GC info v1.5 CU config
      drm/amdgpu: Use discovered mmhub inst_mask for v4_2_0
      drm/amdgpu: Use mmhub inst_mask for gmc v12_1 vmhub setup
      drm/amdgpu: Use global addr for mmhub v4_2 reg access
      drm/amdgpu: Report vm fault status HI32 when avaialble
      drm/amdgpu: Enable translate further for gc v12_1 v3
      drm/amdgpu: Init mcm_addr look up table
      drm/amdgpu: Add soc v2_0 ih client id table
      drm/amdgpu: Add osssys v8_0_1 ip headers v3
      drm/amdgpu: Add ih v8_0 support
      drm/amdgpu/discovery: Add ih v8_0 ip block
      drm/amdgpu: Add nbif v7_10_0 ip headers v4
      drm/amdgpu: Add pcie v6_1_3 ip headers v4
      drm/amdgpu: Add nbif v7_10 support
      drm/amdgpu: Add smuio v15_0_3 ip headers v4
      drm/amdgpu: Add smuio v15_0_3 support
      drm/amdgpu: Add hdp v8_0_1 ip headers v3
      drm/amdgpu: Add lsdma v8_0_1 ip headers
      drm/amdgpu: Add mp v15_0_3 ip headers v4
      drm/amdgpu: Add vpe v3_0_0 ip headers v4
      drm/amdgpu: Add mmhub v5_0 support

Heikki Krogerus (3):
      i2c: designware: Global register definitions
      drm/xe/i2c: Fix the interrupt handling
      drm/xe/i2c: Keep the i2c controller always enabled

Himal Prasad Ghimiray (4):
      drm/pagemap: Add helper to access backing devmem allocation
      drm/gpusvm: Add devmem callback to get_pages
      drm/xe: Bump prefetch BO LRU via GPUSVM devmem callback
      drm/xe: Bump prefetch BO LRU for already-valid ranges

Honglei Huang (6):
      drm/gpusvm: move dma_addr allocation before the notifier lock
      drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper
      drm/gpusvm: let drm_gpusvm_get_pages() map an array of pages
      drm/gpusvm: make the DMA mapping step in get_pages() optional
      drm/gpusvm: keep a single DMA mapping inline for THP
      drm/gpusvm: keep an IOVA mapped range dma address inline

Hongyan Xu (1):
      soc: qcom: apr: clean up failed service registrations

Hongyang Zhao (2):
      arm64: dts: qcom: qcs6490-rubikpi3: Add 3.3 V output supply
      arm64: dts: qcom: qcs6490-rubikpi3: Add IMX219 camera overlays

Horatio Zhang (4):
      drm/amdgpu: Init soc_v1_0 rev_id from IP discovery die_id
      drm/amdgpu: skip IMU microcode request for GC 12.1
      drm/amdkfd: allow 255 queues per process on GFX 12.1.0
      drm/amdgpu: retire the legacy MES design for GFX 12.1

Hsieh Hung-En (2):
      drm/panel: ronbo-rb070d30: Use mipi_dsi_*_multi() functions
      drm/panel: ronbo-rb070d30: Ignore DCS errors in disable()

Huang, Leon (1):
      drm/amd/display: Forward periodic ABM keep-alive scenario to DMU

Icenowy Zheng (7):
      drm: verisilicon: fix cursor offset field update
      arm64: dts: qcom: sc8280xp-crd: set GPI DMA channels
      arm64: dts: qcom: sc8280xp-huawei-gaokun3: set GPI DMA channels
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: set GPI DMA channels
      arm64: dts: qcom: sc8280xp-microsoft-arcata: set GPI DMA channels
      arm64: dts: qcom: sc8280xp-microsoft-blackrock: set GPI DMA channels
      arm64: dts: qcom: sc8280xp: remove GPI DMA channel masks

Ilia Levi (5):
      drm/xe/mmio_gem: forbid VMA split
      drm/xe/mmio_gem: use write-back mapping for dummy page
      drm/xe/mmio_gem: simplify fault handler loop
      drm/xe/mmio_gem: cache the dummy page per object
      drm/xe/mmio_gem: fix destroy flow

Ilya Bakoulin (5):
      drm/amd/display: Clear HUBPREQ_DEBUG_DB on DCN6
      drm/amd/display: Fix missing APG regs for DCN60 HDMI
      drm/amd/display: Fix HDMI FRL audio enable
      drm/amd/display: Fix HDMI2.2 LT timeout duration
      drm/amd/display: Add HDMI RR and SCDC skips

Imre Deak (2):
      drm/i915/dp_mst: Fix configuring FEC for a disconnected stream
      drm/i915/dp_mst: Fix configuring TUs for a disconnected stream

Imre Kaloz (2):
      drm/radeon: Read the VRAM VBIOS signature with readb()
      drm/radeon: add a connector table for the Sun XVR-300

Ivan Lipski (10):
      drm/amd/display: Refactor hdmi_frl_status_polling_work for Kunit test=
ing
      drm/amd/display: Guard amdgpu_dm_irq_schedule_work against NULL irq_w=
q
      drm/amd/display: Fix DCN5/6 DML2 compilation warnings
      drm/amd/display: Honor forced RGB pixel encoding
      drm/amd/display: Expose 3 overlay planes on DCN6
      drm/amd/display: Remove DCN6 DCFCLK num assert
      drm/amd/display: Resync cursor cache after offload abort on DCN60
      drm/amd/display: Bump frame warning limit for clang builds of dml
      drm/amd/display: Enable DMUB HW cursor offload
      drm/amd/display: Send HDMI VRR metadata in VTEM info packet slot

Ivaylo Dimitrov (1):
      drm/omap: Report HDMI hotplug events to the ASoC HDMI codec

Jackson He (1):
      drm/amd/display: Remove unused copyright notice

Jake Steinman (1):
      drm/i915/psr: clear the Panel Replay error status register

James Calligeros (1):
      drm/fourcc: Add Apple Interchange layout format modifier

James Lin (8):
      drm/amd/display: Fall back to overlay cursor on dcn4x when top
plane doesn't fill CRTC
      drm/amd/display: Avoid NULL hubp deref for remaining mpcc_id assignme=
nt
      drm/amd/display: Rename lock_and_validation_needed to
needs_dc_state_realloc
      drm/amd/display: Attach only plane updates that actually changed
      drm/amd/display: Request DMUB HW cursor offload
      drm/amd/display: Send stream_update to DC only when it changed
      drm/amd/display: Drop dead update_type param from
update_planes_and_stream_adapter
      drm/amd/display: Cast DP DTO pixel clock math to avoid overflow
and narrowing

James Zhu (3):
      drm/amdkfd: enhance host trap process in 1st trap handler
      drm/amdkfd: add stochastic in 1st trap handler
      drm/amdkfd: enable trap ID work around

Jammy Huang (1):
      drm/ast: DisplayPort edid supports 256 bytes

Jan Paszkowski (1):
      arm64: dts: qcom: sm8350-sony-xperia-sagami: enable UFS

Jani Nikula (38):
      drm/xe/display: remove unnecessary includes
      drm/i915/dpt: remove unused include
      drm/{i915,xe}/display: move transient data flush call to display
parent interface
      drm/xe/display: drop redundant intel_hpd_poll_fini() call
      drm/xe/display: drop redundant intel_hdcp_component_fini() call
      drm/xe/display: drop redundant intel_audio_deinit() call
      drm/{i915,xe}/display: add core workaround query to display
parent interface
      drm/i915/display: Limit max joined dotclock on joiner pipes available
      drm/i915/dp: Limit for_each_joiner_candidate() on joiner pipes availa=
ble
      drm/i915/dp: Limit compute config joining to pipes that can actually =
join
      drm/i915/debugfs: Reject invalid force_joined_pipes harder
      drm/i915/dp: use EXPORT_SYMBOL_IF_KUNIT() for kunit helpers
      drm/i915/display: stop using the configurable fence timeout
      drm/i915/display: use struct intel_atomic_state *state variable namin=
g
      drm/i915/display: reduce indent in intel_atomic_commit_fence_wait()
      drm/i915/display: debug log about fence wait errors
      drm/i915/lspcon: use u8 variable to hold 1-byte DPCD reads
      drm/i915/lspcon: switch to drm_dp_dpcd_{read_byte, write_byte, write_=
data}
      drm/i915/alpm: switch to drm_dp_dpcd_{read_byte, write_byte}
      drm/i915/ddi: switch to drm_dp_dpcd_write_byte()
      drm/i915/lspcon: switch to drm_dp_dpcd_{read_byte, read_data,
write_byte, write_data}()
      drm/i915/dp: switch to drm_dp_dpcd_{read_byte, read_data,
write_byte, write_data}
      drm/i915/hdcp: switch to drm_dp_dpcd_{read_byte, read_data, write_dat=
a}()
      drm/i915/dp: switch link training to drm_dp_dpcd_{read_byte,
read_data, write_byte, write_data}()
      drm/i915/dp-mst: switch to drm_dp_dpcd_read_byte()
      drm/i915/dp-test: switch to drm_dp_dpcd_{read_byte, read_data,
write_byte, write_data}()
      drm/i915/psr: switch to drm_dp_dpcd_{read_byte, read_data,
write_byte, write_data}()
      drm/xe/display: reduce includes in xe_display.c
      drm/intel: move i915_gtt_view_types.h to include/drm/intel
      drm/intel: rename i915_gtt_view_is_*() helpers to intel_gtt_view_is_*=
()
      drm/intel: rename i915_gtt_view* struct/enum to intel_gtt_view*
      drm/intel: add intel_gtt_view_is_partial() for completeness
      drm/xe/display: use intel_gtt_view_is_*() helpers more
      drm/i915/gem: use intel_gtt_view_is_*() helpers more
      drm/i915/vma: use intel_gtt_view_is_*() helpers more
      drm/i915/selftests: use intel_gtt_view_is_*() helpers more
      drm/i915/debugfs: use the intel_gtt_view_is_*() helpers more
      drm/intel: rename I915_GTT_VIEW_* enumerations to INTEL_GTT_VIEW_*

Janusz Krzysztofik (1):
      drm/i915/selftests: Wait longer for request to start

Jason Pettit (3):
      dt-bindings: arm: qcom: Add HP EliteBook X G2q 14 AI
      arm64: dts: qcom: Add HP EliteBook X G2q 14 AI
      firmware: qcom: scm: Allow QSEECOM on HP EliteBook X G2q 14 AI

Jasper Korten (1):
      drm/panel-edp: Add AUO B140HAN04.0 panel entry

Jay Cornwall (2):
      drm/amdkfd: gfx12.1 add no-op prefetch on trap entry
      drm/amdkfd: Preserve v1 in gfx12.1 trap workaround

Jens Glathe (2):
      arm64: dts: qcom: sc8280xp-x13s: Enable HBR3 on external DPs
      arm64: dts: qcom: sc8280xp-x13s: Add DP0/DP1 audio playback support

Jesse Zhang (31):
      drm/amdgpu/sdma: add detect_hung_queue callback
      drm/amdgpu/sdma6: implement detect_hung_queue
      drm/amdgpu/sdma7: implement detect_hung_queue
      drm/amdgpu/userq: reset a hung SDMA user queue over MMIO
      drm/amdgpu/mes12: clear event log on resume to avoid MES page fault
      drm/amdgpu: support non-guilty job save on ring backup
      drm/amdgpu: fix empty fence backup and replay intervals
      drm/amdgpu/gfx: add a detect_hung_queue callback
      drm/amdgpu/gfx12: implement detect_hung_queue
      drm/amdgpu/gfx11: implement detect_hung_queue
      drm/amdgpu/gfx: export amdgpu_gfx_mqd_reset_restore
      drm/amdgpu/mes12: restore collateral gfx queues after pipe reset
      drm/amdgpu/mes11: restore collateral gfx queues after pipe reset
      drm/amdgpu/mes11: read the gfx user queue VMID for MMIO reset
      drm/amdgpu/mes12: read the gfx user queue VMID for MMIO reset
      drm/amdgpu/gfx12: set KMD_QUEUE for kernel gfx queues
      drm/amdgpu/gfx11: set KMD_QUEUE for kernel gfx queues
      drm/amdgpu: factor out the MES user queue reset body
      drm/amdgpu/gfx: add a shared gfx pipe reset helper
      drm/amdgpu/gfx: add a gfx ME pipe reset capability helper
      drm/amdgpu/gfx: preserve collateral rings during gfx pipe reset
      drm/amdgpu/userq: fix reading the WPTR at a non-zero BO offset
      drm/amdgpu/userq: preserve kernel rings during gfx pipe reset
      drm/amdgpu/mes11: gate gfx pipe reset on PER_PIPE
      drm/amdgpu/mes12: gate gfx pipe reset on PER_PIPE
      drm/amdgpu/gfx11: defer gfx pipe reset enablement
      drm/amdgpu/gfx12: defer gfx pipe reset enablement
      drm/amdgpu/userq: reject mappings without a backing BO
      drm/amdgpu/userq: only accept doorbell BOs as queue doorbell
      drm/amdgpu/userq: return the memdup_user() error for the user MQD
      drm/ttm: return an error when kmapping a BO without pages

Jia Yao (3):
      drm/xe/guc_ads: allocate UM queues in a separate BO
      drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
      drm/xe/guc_ads: use uncached mapping for UM queue BO

Jiahao Li (2):
      drm/amd/ras: overlap VF RAS_CMD buffer and legacy RAS telemetry
memory regions
      drm/amdgpu: add new interface in guest driver for getting RAS
capability when uniras enabled

Jiangshan Yi (2):
      drm/amdgpu: remove redundant NULL check in amdgpu_cs_vm_handling
      drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend

Jie Gan (2):
      dt-bindings: arm: add CTCU device for shikra
      arm64: dts: qcom: shikra: Add coresight nodes

Jie Zhang (5):
      drm/msm/a8xx: Add support for Adreno 830 GPU
      dt-bindings: display/msm: Document Adreno 830 GPU/GMU
      dt-bindings: display/msm/gmu: Fix Glymur's compatible
      drm/msm/a8xx: Add Mahua GPU support
      dt-bindings: display/msm: gpu: Document Mahua GPU/GMU

Jinzhou Su (1):
      drm/amdgpu: Fix NULL pointer issue during ualink init

Joel Fernandes (25):
      gpu: nova-core: mm: Add VramAddress type
      gpu: nova-core: mm: Add PRAMIN window registers
      gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRA=
M
      docs: gpu: nova-core: Document the PRAMIN aperture mechanism
      gpu: nova-core: mm: Add GpuMm centralized memory manager
      gpu: nova-core: mm: Add PRAMIN aperture self-tests
      rust: maple_tree: implement Send and Sync for MapleTree
      rust: pci: add resource_flags accessor
      gpu: nova-core: mm: Add common types for virtual memory management
      gpu: nova-core: mm: Add buddy allocator and TLB to GpuMm
      gpu: nova-core: mm: Add common types for all page table formats
      gpu: nova-core: mm: pagetable: Add PteOps trait
      gpu: nova-core: mm: pagetable: Add PdeOps trait
      gpu: nova-core: mm: pagetable: Add DualPdeOps trait
      gpu: nova-core: mm: Add MMU v2 page table types
      gpu: nova-core: mm: Add MMU v3 page table types
      gpu: nova-core: mm: pagetable: Add MmuConfig trait
      gpu: nova-core: mm: Add page table walker for MMU v2/v3
      gpu: nova-core: mm: Add Virtual Memory Manager
      gpu: nova-core: mm: Add virtual address range tracking to VMM
      gpu: nova-core: mm: Add multi-page mapping API to VMM
      gpu: nova-core: Add BAR1 aperture type and size constant
      gpu: nova-core: mm: Add BAR1 user interface
      gpu: nova-core: mm: Add BAR1 memory management self-tests
      gpu: nova-core: add the GIN interrupt tree and allocate its vectors

John Hubbard (22):
      gpu: nova-core: gsp: fix a broken doc link on GspMessage
      gpu: nova-core: extract radix3 page table into its own module
      gpu: nova-core: generalize radix3 buffer names
      gpu: nova-core: revise radix3 documentation and comments
      gpu: nova-core: zero-pad radix3 page table levels to page boundary
      gpu: nova-core: rename the FbRanges elf field to fw_image
      gpu: nova-core: set MCTP transport header version to 1
      gpu: nova-core: gsp: give the command queue its own BAR0 mapping
      gpu: nova-core: restore the "Probe Nova Core GPU driver" debug print
      rust: pci: declare IrqType and IrqTypes with impl_flags
      gpu: nova-core: add the GIN vector, leaf and subtree types
      gpu: nova-core: add the GIN CPU interrupt tree and MSI EOI registers
      gpu: nova-core: add the per-architecture GIN CPU interrupt HAL
      gpu: nova-core: move wait for GFW boot code to associated function
      gpu: nova-core: add an interrupt delivery self-test
      gpu: nova-core: log GSP events instead of discarding them
      gpu: nova-core: return ENOMSG for an unmatched GSP message
      gpu: nova-core: bound a GSP wait by a single deadline
      gpu: nova-core: add the falcon interrupt registers and HAL methods
      gpu: nova-core: service GSP events from the SWGEN0 interrupt
      gpu: nova-core: add KUnit tests for the interrupt tree
      gpu: nova-core: document the GIN interrupt controller and GSP events

Jonathan Cavitt (3):
      drm/xe/pagefault: Add SRCID to pagefault struct
      drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report
      drm/xe/vm: Do not dma_fence_put zero fences in err_out path

Joonhoe Kim (3):
      drm/msm/dpu: disable the slave encoder before the master
      drm/msm/dpu: compute the CRTC bandwidth from the state being checked
      drm/msm/dpu: round up the compressed INTF width

Joshua Aberback (2):
      drm/amd/display: Remove unnecessary includes
      drm/amd/display: Revert "avoid to write signal specific for tmds"

Jozef Wludzik (1):
      accel/ivpu: Synchronize context abort work with device reset

Juasheem Sultan (1):
      drm/i915/dp: Handle VSC SDP revision 7 in unpack

Juerg Haefliger (1):
      drm/panel-edp: Add AUO 0x0db3 panel

Julia Lawall (1):
      drm/nouveau/bios/init: drop unneeded semicolon

Jun Lei (1):
      drm/amd/display: Add opt-out for DCN6 OutstandingRequests
mode-support check

Jun Yan (1):
      drm/panel-edp: Add BOE NV140FHD-N43 panel

Junjie Cao (2):
      dt-bindings: display: panel: Add Novatek NT36532
      drm/panel: Add Novatek NT36532 panel driver

Kamal Wadhwa (1):
      arm64: dts: qcom: glymur-crd: Update VREG l2b_e0 and l9b_e0
voltage for SD-card

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: Skip accessing psp rum time db for APUs

KancyJoe (1):
      arm64: dts: qcom: sm8650-ayaneo-pocket-s2: add display nodes

Karl Mehltretter (3):
      dma-fence: Fix dma_fence_enable_signaling() reference in kernel-doc
      drm/amdgpu: Initialize UALink handle uniqueness state
      gpu: buddy: Drop the stale @p line from the gpu_buddy_print() kernel-=
doc

Karol Wachowski (8):
      accel/ivpu: Split HW IP generation dispatch into helpers
      accel/ivpu: Limit DMA address width to 42 bits on 40XX and later
      accel/ivpu: Cache FW API version and simplify API check macros
      accel/ivpu: Add test mode to enable the FREQ_CHANGE interrupt
      accel/ivpu: Merge NPU IP register headers
      accel/ivpu: Merge identical 37xx and 40xx IP functions
      accel/ivpu: Merge buttress register headers
      accel/ivpu: Extend tile fuse config to 7 bits

Karthi Kandasamy (1):
      drm/amd/display: Skip eDP teardown while forced PSR is active

Karthik Poosa (4):
      drm/xe/hwmon: handle CRI+ power interval encoding
      drm/xe/hwmon: Enable package and vram temperatures for CRI
      drm/xe/pcode: Increase default pcode mailbox timeout to 10ms
      drm/xe/hwmon: Use shared pcode default timeout for power limit write

Kathiravan Thirumoorthy (1):
      soc: qcom: llcc: Update the SCT table for IPQ5424

Kevin Wang (3):
      drm/amd/pm: fix gpu metrics energy accumulator for smu 13.0.0/13.0.7
      drm/amd/pm: report energy accumulator for smu 13.0.0
      drm/amd/pm: report energy accumulator for smu 14.0.3

Khalid Faisal Ansari (1):
      arm64: dts: qcom: shikra: enable ST33 TPM

Klara Modin (1):
      rust/drm/gem: initialize callbacks with ..pin_init::zeroed()

Konrad Dybcio (10):
      dt-bindings: display: panel: samsung,s6e8aa5x01: Allow common propert=
ies
      soc: qcom: smem: support Glymur DRAM info
      arm64: dts: qcom: agatti: Flatten the USB node
      arm64: dts: qcom: sm8750: Add GPU clock & IOMMU nodes
      arm64: dts: qcom: glymur-asus-zenbook-a16: Fix up the mic sample rate
      arm64: dts: qcom: x1e80100-medion-sprchrgd-14-s1: Drop NOP override
      dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x Gen11
      arm64: dts: qcom: glymur: Add Lenovo Yoga Slim 7x Gen11
      firmware: qcom: scm: Allow QSEECOM on Yoga Slim 7x Gen11
      arm64: dts: qcom: hamoa: Extend QMPPHY description for USB4

Krishna Chaitanya Chundru (3):
      arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes
      arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

Krzysztof Karas (3):
      drm/i915/selftest: Fix a typo in alloc_workqueue call
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

Krzysztof Kozlowski (10):
      arm64: dts: qcom: sdm845-oneplus: Drop redundant status=3Dokay
      drm/bridge: lontium: Drop redundant vendor prefix from I2C device nam=
e
      dt-bindings: display: Use consistent indentation in the example
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failur=
e
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during
.atomic_pre_enable()
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_dis=
able
      drm/msm/hdmi_bridge: Drop redundant initialization in
msm_hdmi_bridge_init()
      drm/msm: Properly handle msm_ioremap() without name
      drm/msm/dsi: Fix indentation of if block in dsi_mgr_bridge_mode_valid=
()
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies

Kuldeep Singh (1):
      arm64: dts: qcom: shikra: Add ICE, TRNG and QCE nodes

Lalit Shankar Chowdhury (3):
      drm/i915/fb: replace kmalloc_array with kmalloc_objs
      drm/i915: use string choice helpers
      drm/amdgpu: replace kcalloc() with kzalloc_objs()

Le Ma (10):
      drm/amdgpu: skip xgmi operations for non-xgmi multi-node configs
      drm/amdgpu: disable GFX clockgating for GC 12.1.0
      drm/amdgpu: add get_rom_offset callback for NBIO 6.3.2
      drm/amdgpu: handle MMHUB harvest information from ip discovery
      drm/amdgpu: handle LSDMA instance and harvest information from
ip discovery
      drm/amdgpu: init NPS supported modes for GC 12.1.0
      drm/amdgpu: add memory partition sysfs init/fini for GC 12.1.0
      drm/amdgpu: free memory partition info on gmc v12 sw_fini
      drm/amdgpu: add NPS2 memory cap for soc v1.0 DPX mode
      drm/amdgpu: extend PSP command polling sleep range

Leo Chen (1):
      drm/amd/display: Cap DML2.1 vmin ODM combine at 2:1 for eDP

Leo Li (3):
      drm/amd/display: Atomize IRQ register read/modify/write ops
      drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs
      drm/amd/display: disable self-refresh on tearing flips

Lijo Lazar (33):
      drm/amdgpu: Use partition switch shadow register
      drm/amdgpu: Add workaround to enable GCv12.1 MGCG
      drm/amdgpu: Use 100M as refclock for SOCv1.0
      drm/amdgpu: Add psp interrupt handling
      drm/amdgpu: Add PSP v15.0.8 interrupt handler
      drm/amdgpu: Skip showing available NPS modes
      drm/amd/pm: Implement notify_ac_dc callback for swsmu
      drm/amdgpu: Remove gfxoff calls in GC v12.1
      drm/amdgpu: Add psp ualink command interfaces
      drm/amdgpu: Fetch asp ualink interface version
      drm/amdgpu: Separate out ualink init sequences
      drm/amdgpu: Add ualink as separate ip block
      drm/admgpu: Seggregate ualink nht messaging
      drm/amdgpu: Assign accel state based on ASP config
      drm/amdgpu: Drop duplicate vpod check functions
      drm/amdgpu: Add support to send ASP completion
      drm/amdgpu: Add handlers for ualink notifications
      drm/amdgpu: Improve ualink state transitions
      drm/amdgpu: Use uniform logic for inband/sideband
      drm/amdgpu: Add name for ualink ip block
      drm/amdgpu: Move ualink ip version related changes
      drm/amdgpu: Add hw_fini for ualink
      drm/amdgpu: Expose ualink info under each xcp
      drm/amd/pm: Separate PPT limit restore from smu_set_ac_dc
      drm/amdgpu: Fix kfd device lock during partition
      drm/amdgpu: remove unused kfd lock wrappers
      drm/amdgpu: Move GC v12.1 spm vmid init to hw init
      drm/amd/pm: Fix SMUv14/15 power context allocation
      drm/amd/pm: Drop redundant power_context_size
      drm/amd/pm: Create NPM sysfs files from capability
      drm/amd/pm: Add NPM status sensor
      drm/amd/pm: Fix metrics formatting in SMUv15.0.8
      drm/amdgpu: Add package type mapping for EAM

Likun Gao (9):
      drm/amdgpu: add sdma debug parameter
      drm/amdgpu: Correct GFX_IMU_PARTITION_SWITCH value for gc 12_1
      drm/amdgpu: remove retired cp cmd pkg for gc v12_1
      drm/amdgpu: clean up vm flush func for gc v12_1
      drm/amdgpu: update mcm_addr_lut data for imu v12_1
      drm/amdgpu: update mcm_addr_lut data for imu v12_1
      drm/amdgpu: correct mcm_addr_lut value for gc v12_1
      drm/amdgpu: Add gc_info_v1_4 table support
      drm/amdgpu: add support for lsdma v8

Lin Cao (6):
      drm/amdgpu: fix ip discovery table validation
      drm/amdgpu: add new MEC2 firmware loading framework
      drm/amdgpu: Add GFX FW list to PSP_15_0_3 under SRIOV
      drm/amdgpu: Add VPE FW list to PSP_15_0_3 under SRIOV
      drm/amdgpu: Allocate VPE cmdbuf from VRAM
      drm/amdgpu: skip vpe dpm enable if dpm_enabled flag is false

Linlin Yang (1):
      drm/amd/display: fix misspelling of "overridden"

Linmao Li (3):
      drm/xe/oa: Fix sync entry leak on OA config emit failure
      drm/xe/oa: Check managed mutex initialization errors
      soc: qcom: smem: Fix byte order in v3 14-frequency parser

Linus Walleij (4):
      drm/panel: samsung: Add shared test key helpers
      drm/panel: samsung-s6e88a0-ams452ef01: Use test key helpers
      dt-bindings: display: faraday,tve200: Use a level-high interrupt
      dt-bindings: display: ste,mcde: Allow power domains

Lizhi Hou (10):
      accel/amdxdna: Fix unexpected wait when flushing notifier_wq
      accel/amdxdna: Fix possible use-after-free when freeing device BO
      accel/amdxdna: Disable BO import via flink
      accel/amdxdna: Fix potential deadlock in BO open and close callbacks
      accel/amdxdna: Fix unsafe use of handle_mm_fault()
      accel/amdxdna: Fully initialize map structure before registering noti=
fier
      accel/amdxdna: Fix race between unmap and free BO
      accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults
      accel/amdxdna: Preallocate hardware context schedulers
      accel/amdxdna: Add support for AIE2 revision 9

Lu Yao (3):
      drm/xe/oa: Remove sysfs entry on idr_alloc failure in
xe_oa_add_config_ioctl()
      drm/amd/display: Fix wrong plane index in dcn6 writeback latency loop
      drm/amdkfd: drop KFD_QUEUE_TYPE_DIQ note

Luca Ceresoli (42):
      drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: don't select unused DRM_=
PANEL
      drm/bridge: ti-sn65dsi86: don't select unused DRM_PANEL, select
DRM_PANEL_BRIDGE
      drm/bridge: ti-sn65dsi83: select DRM_PANEL_BRIDGE
      drm/bridge: parade-ps8640: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm: of: drm_of_find_panel_or_bridge: simplify freeing the
remote node pointer
      drm: of: drm_of_find_panel_or_bridge: simplify error return paths
      drm/mcde: dsi: simplify device_node management using scoped
for_each variant
      drm/omap: dsi: remove unused includes
      drm/tve200: remove unused includes
      drm/bridge: tc358764: don't select unused DRM_PANEL
      drm/bridge: ti-dlpc3433: don't depend on DRM_PANEL, select
DRM_PANEL_BRIDGE
      drm/bridge: nxp-ptn3460: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: parade-ps8622: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: tc358775: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: tc358767: select DRM_PANEL_BRIDGE
      drm/bridge: tc358768: select DRM_PANEL_BRIDGE
      drm/bridge: ssd2825: select DRM_PANEL_BRIDGE
      drm/bridge: tc358764: select DRM_PANEL_BRIDGE
      drm: of: move drm_of_find_panel_or_bridge() from drm_of.c to drm_pane=
l.c
      drm: of: remove now unnecessary forward declarations
      drm/panel: move to a new module
      drm/bridge: panel: move all code to drm_panel.c
      drm/panel: embed a drm_bridge into every drm_panel
      drm/bridge: remove devm_drm_put_bridge()
      drm/panel: deprecate panel-bridge APIs
      drm/todo: add entry for removing the panel_bridge API
      drm/bridge: tc358767: don't create a panel_bridge
      drm/bridge: waveshare-dsi: don't create a panel_bridge
      drm/mcde: dsi: remove unused includes
      drm/mcde: dsi: don't create a panel_bridge
      drm/bridge: fsl-ldb: don't create a panel_bridge
      drm/bridge: samsung-dsim: don't create a panel_bridge
      drm/bridge: tc358768: don't create a panel_bridge
      drm/bridge: ssd2825: don't create a panel_bridge
      drm/omap: dss: don't create a panel_bridge
      drm/tve200: don't create a panel_bridge
      drm/bridge: analogix_dp: don't create a panel_bridge
      drm/imx/lcdc: stop using deprecated devm_drm_of_get_bridge()
      drm: verisilicon: stop using deprecated devm_drm_of_get_bridge()
      drm/bridge: dw-mipi-dsi: stop using deprecated devm_drm_of_get_bridge=
()
      drm/bridge: dw-mipi-dsi2: stop using deprecated devm_drm_of_get_bridg=
e()
      drm: renesas: shmobile: stop using deprecated devm_drm_of_get_bridge(=
)

Luca Coelho (8):
      drm/i915/display: harden masks in HSW_AUD_PIN_ELD_CP_VLD macros
      drm/i915/display: harden shifts in ICL_DPCLKA_CFGCR0_DDI_CLK_SEL macr=
os
      drm/i915/display: harden shift in intel_ddi_compute_config_late()
      drm/i915/display: remove unnecessary PHY_NONE definition
      drm/i915/display: consolidate Gen9 clock gating initialization
      drm/i915/display: consolidate remaining clock gating initialization
      drm/i915/display: remove unnecessary clock_gating include from
intel_display.c
      drm/i915/display: check configuration index before shifting

Luca Weiss (11):
      dt-bindings: net: wireless: ath11k: Document WCN6755 WiFi
      arm64: dts: qcom: kodiak: Sort pinctrl subnodes by pins
      arm64: dts: qcom: kodiak: Add camera mclk pinctrl definitions
      arm64: dts: qcom: qcs6490-rb3gen2-vision-mezzanine: Use common pinctr=
l
      dt-bindings: interconnect: qcom-bwmon: Add Milos cpu-bwmon compatible
      arm64: dts: qcom: sm7225-fairphone-fp4: Disable PMK8350 PON
      dt-bindings: bluetooth: qcom,wcn6750-bt: Document WCN6755 Bluetooth
      arm64: dts: qcom: milos: Split up uart11 pinctrl
      arm64: dts: qcom: milos: Add WCN6755 WiFi node
      arm64: dts: qcom: milos-fairphone-fp6: Enable Bluetooth
      arm64: dts: qcom: milos-fairphone-fp6: Enable WiFi

Luo Jie (3):
      arm64: dts: qcom: ipq5018: Add pinctrl for MDIO bus
      arm64: dts: qcom: ipq5018: Enable mdio0 for SoC-integrated EPHY
      arm64: dts: qcom: ipq5018-rdp432-c2: Enable mdio1 and add QCA8081 PHY

Lyude Paul (9):
      drm/nouveau: Fix cleanup bug in nouveau_drm_device_new()
      drm/nouveau: Print the nouveau.atomic parameter in
nouveau_display_options()
      drm/nouveau: Fix drm_driver struct/nouveau.atomic parameter handling
      drm/nouveau/kms: Only allow enabling atomic modesetting on nv50+
      drm/nouveau/kms/nv50-: Enable atomic modesetting by default
      Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
      drm/nouveau/gsp/r570: Set GcOff =3D 0 in fbsr
      drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP
      drm/nouveau/gsp: Increase delay for magic sleep in r535_gsp_fini()

Maarten Lankhorst (3):
      drm/i915/gt: Fix selftests on PREEMPT_RT
      drm/i915/gt: Set stop_timeout() correctly on PREEMPT-RT
      drm/i915: Use sleeping selftests for igt_atomic on PREEMPT_RT

Mahadevan P (1):
      drm/msm: default separate_gpu_kms to auto selection

Mallesh Koujalagi (6):
      drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
      drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
      drm/xe: Handle PUNIT errors by requesting cold-reset recovery
      drm/xe/ras: Use fault-inject to trigger cold-reset wedge
      drm/xe/log: Add structured SIGID error logging infrastructure
      drm/drv: Convert wedged event string building to seq_buf

Mangesh Gadre (3):
      drm/amdgpu: Updated compute partition validation
      drm/amdgpu: add DPX mode for 6-XCC configuration
      drm/amdgpu: skip DPX mode for unsupported GC parts

Manuel Ebner (1):
      Documentation: nova: Fix bracket

Manush Prajwal (1):
      cgroup/dmem: fix comment typos in dmem.c

Marcin Bernatowicz (2):
      drm/xe/uc: Apply RCS/CCS yield policy to SR-IOV VFs
      drm/xe/pf: Keep VF LMEM BAR size low if no VFs enabled

Marek Czernohous (4):
      drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
      drm/nouveau: disable the fence uevent work instead of just cancelling=
 it
      drm/nouveau: cancel the DP IRQ work before freeing the connector
      drm/nouveau: don't dereference outp before checking it in nouveau_dp_=
irq

Marek Vasut (8):
      drm: of: Fix drm_of_get_data_lanes_count_ep() return value documentat=
ion
      dt-bindings: display: bridge: Document Renesas R-Car V4H DSC bindings
      drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H DSC driver
      drm/rcar-du: dsi: Implement DSI command TX using AXI memory access
      dt-bindings: display: panel: Document 10" Raspberry Pi Touch Display =
2
      drm/panel: ilitek-ili9882t: Make enable GPIO optional
      drm/panel: ilitek-ili9882t: Set prepare_prev_first
      drm/panel: ilitek-ili9882t: Add support for Ilitek IL79600A-based pan=
els

Mario Limonciello (6):
      drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
      drm/amdkfd: fix scope of mqd_mgr dereference in pqm_debugfs_mqds
      drm/radeon: restore eDP panel power sequencer on Apple DCE3.2 iMacs
      drm/amdgpu: Fix GPU PCIe link capability reporting
      drm/amdgpu: Skip KFD mapping clear before initialization
      drm/amdgpu: Reuse cached PCIe link device

Markuss Broks (1):
      drm/panfrost: add Mali-G68 support

Martin Tsai (1):
      drm/amd/display: allow skipping link bandwidth clear

Matt Atwood (1):
      drm/xe/ptl: Add a new PTL PCI ID

Matt Coster (4):
      drm/imagination: Explicitly set CACHED flag on META FW
      drm/imagination: Unify repeated register defines
      drm/imagination: Move FWCORE_* macros to register defines
      drm/imagination: Collect KCCB initialisation

Matt Roper (3):
      drm/xe: Consolidate semaphore instruction definitions
      drm/xe: Drop old Xe GT ID macros
      Revert "drm/xe: Set mask bits for CCS_MODE register"

Matteo Kloiber (1):
      gpu: nova-core: declare unlimited DMA max segment size

Matthew Auld (8):
      drm/xe/migrate: support 4K PTEs for identity map
      drm/xe/vram: report FLAT_CCS base misalignment
      drm/xe/vram: revamp CPU VRAM mapping
      drm/xe: add force option for global invalidation
      drm/xe/vram: add early VRAM health check
      drm/xe/mmio_gem: reject VM_EXEC and drop VM_DONTCOPY
      drm/xe: convert PCI barrier mmap to use xe_mmio_gem
      drm/xe/vm: nuke PTs only after unlinking contested VMAs

Matthew Brost (41):
      Merge drm/drm-next into drm-xe-next
      drm/xe: Fine grained page fault locking
      drm/xe: Allow prefetch-only VM bind IOCTLs to use VM read lock
      drm/xe: Thread prefetch of SVM ranges
      drm/xe: Use a single page-fault queue with multiple workers
      drm/xe: Add num_pf_work modparam
      drm/xe: Engine class and instance into a u8
      drm/xe: Track pagefault worker runtime
      drm/xe: Chain page faults via queue-resident cache to avoid fault sto=
rms
      drm/xe: Add pagefault chaining stats
      drm/xe: Add debugfs pagefault_info
      drm/xe: batch CT pagefault acks with periodic flush
      drm/xe: Track parallel page fault activity in GT stats
      drm/xe: Order ring writes before ring tail updates
      Merge drm/drm-next into drm-xe-next
      drm/xe: Add mnemonic error reason to page fault diagnostics
      drm/xe: Keep walking on SVM eviction failure
      drm/xe: reference VM from PT BOs
      drm/xe: Drop struct xe_migrate_pt_update argument from
populate/clear vfuns
      drm/xe: Add xe_migrate_update_pgtables_cpu_execute helper
      drm/xe: Decouple exec queue idle check from LRC
      drm/xe: Add job count to GuC exec queue snapshot
      drm/xe: Update xe_bo_put_deferred arguments to include writeback flag
      drm/xe: Update scheduler job layer to support PT jobs
      drm/xe: Add helpers to access PT ops
      drm/xe: Add struct xe_pt_job_ops
      drm/xe: Update GuC submission backend to run PT jobs
      drm/xe: Store level in struct xe_vm_pgtable_update
      drm/xe: Don't use migrate exec queue for page fault binds
      drm/xe: Enable CPU binds for jobs
      drm/xe: Remove unused arguments from xe_migrate_pt_update_ops
      drm/xe: Make bind queues operate cross-tile
      drm/xe: Add CPU bind layer
      drm/xe: Add device flag to enable PT mirroring across tiles
      drm/xe: Add ULLS support to LRC
      drm/xe: Add ULLS migration job support to migration layer
      drm/xe: Add ULLS migration job support to ring ops
      drm/xe: Add ULLS migration job support to GuC submission
      drm/xe: Enter ULLS for migration jobs upon page fault or SVM prefetch
      drm/xe: add migrate ULLS period configfs attribute
      drm/xe: Document ULLS for migration jobs

Matthew Stewart (1):
      drm/amd/display: Fix DCN42B plane alpha

Mattia Tadini (1):
      drm/amd/display: only clear the hotplug sources the ASIC has

Maulik Shah (3):
      soc: qcom: rpmh-internal: fix kernel-doc issues in rpmh-internal.h
      soc: qcom: rpmh: fix kernel-doc issues in rpmh.c
      soc: qcom: rpmh-rsc: fix kernel-doc issues in rpmh-rsc.c

Max Zhen (2):
      accel/amdxdna: eliminate GFP_KERNEL allocation from mailbox send path
      accel/amdxdna: Expose NPU device busy time via DRM fdinfo

Maxime Ripard (166):
      drm/simple-kms: Add create_plane_state hook
      drm/gem-atomic-helper: Create drm_gem_create_shadow_plane_state()
      drm/gem-atomic-helper: Convert simple-kms shadow helpers to
create_plane_state
      drm/gem-atomic-helper: Switch DRM_GEM_SHADOW_PLANE_FUNCS to
atomic_create_state
      drm/gem-atomic-helper: Remove drm_gem_reset_shadow_plane()
      drm/sysfb: Convert to atomic_create_state
      drm/simple-kms: Switch to atomic_create_state
      drm/ssd130x: Convert to atomic_create_state
      drm/st7920: Convert to atomic_create_state
      drm/appletbdrm: Convert to atomic_create_state
      drm/hdlcd: Convert to atomic_create_state
      drm/imx/dcss: Convert to atomic_create_state
      drm/ingenic: Convert to atomic_create_state
      drm/meson: Convert to atomic_create_state
      drm/msm/mdp4: Convert to atomic_create_state
      drm/sun4i: sun8i: Convert to atomic_create_state
      drm/komeda: Convert to atomic_create_state
      drm/malidp: Convert to atomic_create_state
      drm/msm/dpu1: Convert to atomic_create_state
      drm/msm/mdp5: Convert to atomic_create_state
      drm/vc4: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/adp: Switch to drm_atomic_helper_crtc_create_state
      drm/arm: hdlcd: Switch to drm_atomic_helper_crtc_create_state
      drm/armada: Switch to drm_atomic_helper_crtc_create_state
      drm/exynos: Switch to drm_atomic_helper_crtc_create_state
      drm/fsl-dcu: Switch to drm_atomic_helper_crtc_create_state
      drm/gud: Switch to drm_atomic_helper_crtc_create_state
      drm/hisilicon: hibmc: Switch to drm_atomic_helper_crtc_create_state
      drm/hisilicon: kirin: Switch to drm_atomic_helper_crtc_create_state
      drm/hyperv: Switch to drm_atomic_helper_crtc_create_state
      drm/imx: dc: Switch to drm_atomic_helper_crtc_create_state
      drm/imx: dcss: Switch to drm_atomic_helper_crtc_create_state
      drm/ingenic: Switch to drm_atomic_helper_crtc_create_state
      drm/kmb: Switch to drm_atomic_helper_crtc_create_state
      drm/meson: Switch to drm_atomic_helper_crtc_create_state
      drm/msm: mdp4: Switch to drm_atomic_helper_crtc_create_state
      drm/mxs: mxsfb: Switch to drm_atomic_helper_crtc_create_state
      drm/qxl: Switch to drm_atomic_helper_crtc_create_state
      drm/renesas: shmobile: Switch to drm_atomic_helper_crtc_create_state
      drm/simple-kms: Remove unused reset_crtc hook
      drm/simple-kms: Switch to drm_atomic_helper_crtc_create_state
      drm/sitronix: st7571: Switch to drm_atomic_helper_crtc_create_state
      drm/sprd: Switch to drm_atomic_helper_crtc_create_state
      drm/sti: Switch to drm_atomic_helper_crtc_create_state
      drm/stm: Switch to drm_atomic_helper_crtc_create_state
      drm/sun4i: Switch to drm_atomic_helper_crtc_create_state
      drm/tests: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: appletbdrm: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: bochs: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: cirrus: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: pixpaper: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: sharp: Switch to drm_atomic_helper_crtc_create_state
      drm/udl: Switch to drm_atomic_helper_crtc_create_state
      drm/vbox: Switch to drm_atomic_helper_crtc_create_state
      drm/verisilicon: Switch to drm_atomic_helper_crtc_create_state
      drm/virtio: Switch to drm_atomic_helper_crtc_create_state
      drm/xlnx: Switch to drm_atomic_helper_crtc_create_state
      drm/mipi-dbi: Switch to drm_atomic_helper_crtc_create_state
      sysfb: Convert to create_state
      drm/komeda: Convert to atomic_create_state
      drm/malidp: Convert to atomic_create_state
      drm/ast: Convert to atomic_create_state
      drm/atmel-hlcdc: Convert to atomic_create_state
      drm/imx: ipuv3: Convert to atomic_create_state
      drm/mgag200: Convert to atomic_create_state
      drm/msm: dpu1: Convert to atomic_create_state
      drm/msm: mdp5: Convert to atomic_create_state
      drm/mxsfb: lcdif: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/omapdrm: Convert to atomic_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/rzg2l-du: Convert to atomic_create_state
      drm/rockchip: vop: Convert to atomic_create_state
      drm/rockchip: vop2: Convert to atomic_create_state
      drm/solomon: ssd130x: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/vc4: Convert to atomic_create_state
      drm/vkms: Convert to atomic_create_state
      drm/vmwgfx: Convert to atomic_create_state
      drm/crtc: Introduce hw_reset helper hook
      drm/amdgpu: vkms: Switch to drm_atomic_helper_crtc_create_state
      drm/logicvc: Switch to drm_atomic_helper_crtc_create_state
      drm/tilcdc: Move hardware reset to hw_reset hook
      drm/tilcdc: Switch to drm_atomic_helper_crtc_create_state
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/loongson: Move hardware reset to hw_reset hook
      drm/loongson: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/sitronix: st7920: Convert to atomic_create_state
      drm/atomic: colorop: Rename state to state_to_destroy
      drm/atomic: Fix unused but set warning in state iterator macros
      drm/atomic_helper: Skip over NULL private_obj pointers
      drm/bridge: Implement atomic_print_state
      drm/atomic: Only call atomic_destroy_state on a !NULL pointer
      drm/atomic_helper: Pass nonblock to commit_tail
      drm/atomic: Convert drm_priv_to_bridge_state to container_of_const
      drm/simple-kms: Remove unused reset_plane hook
      drm/vkms: Move frame_info into vkms_plane_state
      drm/vkms: Convert to atomic_create_state
      drm/gem-atomic-helper: Remove __drm_gem_reset_shadow_plane()
      drm/amdgpu: Convert to atomic_create_state
      drm/fsl-dcu: Convert to atomic_create_state
      drm/hisilicon/kirin: Convert to atomic_create_state
      drm/imx/dc: Convert to atomic_create_state
      drm/kmb: Convert to atomic_create_state
      drm/logicvc: Convert to atomic_create_state
      drm/loongson: Convert to atomic_create_state
      drm/lcdif: Convert to atomic_create_state
      drm/mxsfb: Convert to atomic_create_state
      drm/qxl: Convert to atomic_create_state
      drm/rockchip: Convert to atomic_create_state
      drm/sprd: Convert to atomic_create_state
      drm/sti: Convert to atomic_create_state
      drm/stm: Convert to atomic_create_state
      drm/tests: kunit: Convert to atomic_create_state
      drm/tilcdc: Convert to atomic_create_state
      drm/vboxvideo: Convert to atomic_create_state
      drm/verisilicon: Convert to atomic_create_state
      drm/virtio: Convert to atomic_create_state
      drm/xlnx: Convert to atomic_create_state
      drm/amdgpu_dm: Convert to atomic_create_state
      drm/armada: Convert to atomic_create_state
      drm/atmel-hlcdc: Drop spurious csc_init call from reset
      drm/atmel-hlcdc: Convert to atomic_create_state
      drm/exynos: Convert to atomic_create_state
      drm/imx/ipuv3: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/omap: Convert to atomic_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/rz-du: Convert to atomic_create_state
      drm/shmobile: Convert to atomic_create_state
      drm/sun4i: layer: Convert to atomic_create_state
      drm/vmwgfx: Convert to atomic_create_state
      drm/amdgpu_dm: tests: Fix wrong variable declaration after merge conf=
lict
      drm/arcgpu: Switch to drm_atomic_helper_crtc_create_state
      drm/aspeed: Switch to drm_atomic_helper_crtc_create_state
      drm/gm12u320: Switch to drm_atomic_helper_crtc_create_state
      drm/mcde: Switch to drm_atomic_helper_crtc_create_state
      drm/pl111: Switch to drm_atomic_helper_crtc_create_state
      drm/repaper: Switch to drm_atomic_helper_crtc_create_state
      drm/tve200: Switch to drm_atomic_helper_crtc_create_state
      drm/xen: Switch to drm_atomic_helper_crtc_create_state
      drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
      drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
      drm/crtc: Remove reset
      drm/arcgpu: Switch to drm_atomic_helper_plane_create_state
      drm/aspeed: Switch to drm_atomic_helper_plane_create_state
      drm/mcde: Switch to drm_atomic_helper_plane_create_state
      drm/pl111: Switch to drm_atomic_helper_plane_create_state
      drm/tve200: Switch to drm_atomic_helper_plane_create_state
      drm/xen: Switch to drm_atomic_helper_plane_create_state
      drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()
      drm/atomic-state-helper: Remove __drm_atomic_helper_plane_reset()
      drm/plane: Remove reset
      drm/arm: komeda: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: lontium-lt8912b: Switch to
drm_atomic_helper_connector_create_state
      drm/bridge: megachips: Switch to drm_atomic_helper_connector_create_s=
tate
      drm/hyperv: Switch to drm_atomic_helper_connector_create_state
      drm/imx: ipuv3: Switch to drm_atomic_helper_connector_create_state
      drm/solomon: ssd130x: Switch to drm_atomic_helper_connector_create_st=
ate
      drm/sysfb: Switch to drm_atomic_helper_connector_create_state
      drm/vc4: Switch to drm_atomic_helper_connector_create_state
      drm/malidp: Convert to atomic_create_state
      drm/adp: Switch to drm_atomic_helper_connector_create_state

Ma=C3=ADra Canal (15):
      drm/v3d: Remove the now-redundant reset lock
      drm/sysfs: Remove drm_class_device_(un)register()
      drm/vc4: Drop the undocumented brcm,vc4-v3d compatible
      dt-bindings: display: bcm2835-v3d: Add an optional reset line
      drm/vc4: Use the reset controller to recover from a GPU hang
      ARM: dts: bcm2835: Add the V3D reset line
      drm/v3d: Skip perfmon serialization while the device has no perfmon
      drm/v3d: Skip perfmon serialization while a global perfmon is set
      drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
      drm: Add drm_timeout_rel_to_jiffies()
      drm/amdgpu: Use drm_timeout_abs_to_jiffies()
      drm/v3d: Use drm_timeout_rel_to_jiffies()
      drm/i915: Use drm_timeout_rel_to_jiffies()
      drm/vc4: Use drm_timeout_rel_to_jiffies()
      drm: Rename drm_utils.h to drm_panel_quirks.h

Meera Patel (1):
      drm/amd/display: Fix DPREFCLK override when SMU isn't present or
ready for DCN315

Melissa Wen (10):
      drm/amd/display: use halving distribution for all encode-to-linear cu=
rves
      drm/amd/display: use translate_curve_to_degamma_hw_format on DCN30
      drm/amd/display: assign missing trace entry in amdgpu_dm_dc_clocks_st=
ate
      drm/amd/display: remove duplicated prev_p_state_change_support assign=
ment
      drm/amd/display: fix vready offset assignment in
dcn_optc_lock_unlock_state
      drm/amd/display: declare amdgpu_dm_atomic_state_template as an event =
class
      drm/amd/display: use right type for amdgpu_dc_performance event entri=
es
      drm/amd/display: remove redundant cast on amdgpu_dc_reg_template prin=
tk
      drm/amd/display: copy function name into dcn_fpu trace event
      drm/amd/display: copy function name into
dcn_optc_lock_unlock_state trace event

Michael Kelley (1):
      drm_hyperv: Remove support for synth video protocol of old Hyper-V ho=
sts

Michal Wajdeczko (53):
      drm/xe/pf: Add _locked variant of the GGTT bulk config function
      drm/xe/pf: Add _locked variant of the contexts bulk config function
      drm/xe/pf: Add _locked variant of the doorbells bulk config function
      drm/xe: Use guard(spinlock_irqsave) in pagefault handler
      drm/xe: Remove redundant full pagefault queue check
      drm/xe: Introduce xe_any helpers
      drm/xe/log: Introduce structured component/location identifiers
      drm/xe/log: Add component/location decorations to dmesg
      drm/xe/log: Add SIGID log helpers for severity
      drm/xe/log: Add SIGID log helpers for location
      drm/xe/log: Add SIGID log helpers for location & severity
      drm/xe/log: Add SIGID log helpers for components
      drm/xe/log: Add SIGID log helpers for component & severity
      drm/xe/log: Add SIGID log helpers for errno-only
      drm/xe/log: Index all SIGID printk messages
      drm/xe/log: Add hardware error signatures
      drm/xe/log: Extend components list with hardware items
      drm/xe/ras: Check RAS and LOG component definitions
      drm/xe/kunit: Setup driver data in the test device
      drm/xe/tests: Add Kunit tests for xe_log
      drm/xe/tests: Add kunit tests for xe_any
      drm/xe: Report 'probe blocked' status using SIGID
      drm/xe: Report all probe errors using SIGID
      drm/xe/survivability: Report 'boot status' using SIGID
      drm/xe/survivability: Report sysfs failure in one place
      drm/xe/survivability: Report 'boot status' on sysfs failure
      drm/xe/survivability: Report 'Boot Mode enabled' status using SIGID
      drm/xe/survivability: Report 'Runtime Mode enabled' status using SIGI=
D
      drm/xe: Report 'device wedged' errors using SIGID
      drm/xe/pcode: Report 'Mailbox failed' error using SIGID
      drm/xe/pcode: Report 'timeout, retrying' error using SIGID
      drm/xe/pcode: Report 'initialization timedout' error using SIGID
      drm/xe/guc: Report 'GuC mmio' errors using SIGID
      drm/xe/gt: Report 'reset failed' errors using SIGID
      drm/xe/gt: Report 'Fault response' pagefault error using SIGID
      drm/xe/gt: Report 'Queue full' pagefault error using SIGID
      drm/xe/pci: Report 'cannot re-enable' error using SIGID
      drm/xe/tests: Fix default subplatform selection
      drm/xe/tests: Fix subplatform selection
      drm/xe: Drop unused parameter from xe_info_init
      drm/xe: Keep reference to device descriptor
      drm/xe: Drop redundant parameters from xe_info_init_early
      drm/xe: Drop redundant parameter from xe_probe_info_early
      drm/xe: Drop redundant parameter from xe_probe_info and friends
      drm/xe/log: Relax location ID recognition
      drm/xe/pf: Refactor VF LMEM BAR resize helper function
      drm/xe/pf: Add _locked variant of the priority config function
      drm/xe/pf: Add _locked variant of the release config function
      drm/xe/pf: Add _locked variant of the fair sched config function
      drm/xe/guc: Add simple KLV decoder helpers
      drm/xe/tests: Add kunit tests for KLV decoders
      drm/xe/pf: Use KLV decode helpers to parse migration packet
      drm/xe/pf: Move locking to xe_sriov_pf_reprovision_default

Micha=C5=82 Grzelak (10):
      drm/i915/pcode: rename GEN6_PCODE_DATA to match spec
      drm/xe/pcode: match argument naming with PCODE_DATAx
      drm/i915/bios: search for VBT #57 by default
      drm/i915/bios: store VBT #57's metadata in intel_vbt_data
      drm/i915/bios: print VS/PE-O port info
      drm/i915/bios: de/allocate VS/PE-O buffers for each port
      drm/i915/buf_trans: add vfunc for VS/PE-O
      drm/i915: override Snps's VS/PE when requested
      drm/i915: override Combo's VS/PE when requested
      drm/i915/bios: remove VS/PE-O warning

Micha=C5=82 Winiarski (2):
      drm/xe: Fix memory leak in exec_queue_set_hang_replay_state()
      drm/xe: Reject duplicated properties for EXEC_QUEUE_SET_PROPERTY

Michel D=C3=A4nzer (1):
      drm/amd/display: Consult MCCS FreeSync cap only if requested & suppor=
ted

Mika Kahola (5):
      drm/i915/display: Split out DG2 MPLLB enable helper
      drm/i915/display: Add DG2 MPLLB DPLL manager support
      drm/i915/display: Prepare DG2 DDI and compute paths for DPLL framewor=
k
      drm/i915/display: Switch DG2 to use DPLL framework
      drm/i915/display: Reset use_flipq when duplicating crtc state

Mika Penttil=C3=A4 (1):
      drm/tests: hdmi: fix infoframes tests

Mike Lothian (1):
      drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments

Mikhail Gavrilov (1):
      drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks

Mikko Perttunen (12):
      dt-bindings: display: tegra: Make non-vm registers optional
      dt-bindings: display: tegra: Add channel/syncpoint range properties
      gpu: host1x: Support running without hv/common registers
      gpu: host1x: Allow limiting usable channel and syncpoint ranges
      gpu: host1x: Memory context stealing
      gpu: host1x: Add option for disabling context stealing
      drm/tegra: Fix syncobj_in wait return value check
      drm/tegra: Don't pass an ERR_PTR to drm_syncobj_replace_fence()
      drm/tegra: Drop reference on postfence
      drm/tegra: Remove unused includes from submit.c
      gpu: host1x: Add host1x_fence_extract()
      drm/tegra: Wait for syncpoint syncobj_in fences in hardware

Mitul Golani (12):
      drm/i915/psr: Do not enable PSR2 when CMRR is enabled
      drm/i915/vrr: Restrict CMRR enable condition to VRR-TG-default platfo=
rms
      drm/i915/vrr: Add per-CRTC vrr/cmrr debugfs control
      drm/i915/vrr: Update AS_SDP target_rr_divider based on CMRR config re=
quest
      drm/i915/display: Move CMRR crtc_state members under VRR
      drm/i915/vrr: Compute CMRR fractional timings generically
      drm/i915/vrr: Latch CMRR ratio via atomic commit on debugfs write
      drm/i915/vrr: Program CMRR enable/disable from transcoder timings
      drm/i915/vrr: Dump CMRR state in the crtc state dump
      drm/i915/vrr: Enable CMRR
      drm/i915/dp: Gate UHBR SST SDP splitting on sink capability
      drm/i915/vrr: Disable DC balance by default

Mohamed Ahmed (2):
      drm/nouveau/dispnv50: program pixel clocks above 2.147GHz on GB20x
      drm/nouveau: honor HF-EEODB EDIDs by converting to struct drm_edid

Mohammad Shahid (1):
      drm/exynos: vidi: use memdup_user() instead of kmalloc() and
copy_from_user()

Monish Chunara (1):
      dt-bindings: mmc: sdhci-msm: Document the Glymur compatible

Muhammed Sariyildiz (1):
      drm/nouveau/clk/gk20a: fix undefined behaviour in signed left shift

Mukesh Ojha (1):
      firmware: qcom: scm: Use devm_of_reserved_mem_device_init()

Mukul Joshi (63):
      drm/amdkfd: Update SDMA engines reporting for GFX 12.1
      drm/amdgpu: Unmap KIQ during driver unload on GFX 12.1
      drm/amdkfd: set CP_IQ_WAIT_TIME2.QUE_SLEEP on GFX 12.1
      drm/amdkfd: Skip pairwise CU mask check for GFX12.1
      drm/amdgpu: Update no-retry PTE flags for GFX12
      drm/amdgpu: Drop BUG_ON in PDE address verification for GFX 12.1
      drm/amdgpu: Add UALink manager core infrastructure
      drm/amdgpu: Add a new NPA Address space
      drm/amdgpu: Add address allocator for NPA addresses
      drm/amdgpu: Initialize VM for NPA addr management
      drm/amdgpu: Rework VMID reservation logic
      drm/amdgpu: Reserve VMID for NPA VM
      drm/amdgpu: Use reserved VMID for NPA VM
      drm/amdgpu: Enable UALink Manager when pod becomes active
      drm/amdgpu: Create a drm client for UALink NPA BOs
      drm/amdgpu: Control NPA DMA-buf importing
      drm/amdgpu: Add ualink handle to BOs
      drm/amdgpu: Implement UALink handle export
      drm/amdgpu: Add connection state management
      drm/amdgpu: Implement UALink handle import ioctl
      drm/amdgpu: Implement mechanism to revoke exported memory
      drm/amdgpu: lock UALink import invalidation via drm_exec
      drm/amdgpu: Cleanup exported UALink handles
      drm/amdgpu: Cleanup imported UALink handles
      drm/amdgpu: Handle connection reset
      drm/amdgpu: Setup PTE mappings for NPA addresses
      drm/amdgpu: Add handling for remote interrupts
      drm/amdgpu: Send TLB shootdown on exported memory unmap
      drm/amdgpu: Handle local GPUs in UALink import
      drm/amdgpu: Add debugfs to drop UALink protocol messages
      drm/amdgpu: Temporarily disable sending remote TLB shootdowns
      drm/amdgpu: Temporarily Flush TLB on NPA mapping always
      drm/amdgpu: fix NPA-RELEASE race in UALink exporter cleanup
      drm/amdgpu: initialize UALink importer node list head
      drm/amdgpu: Fix initialization flags for UALink XAs
      drm/amdgpu: fix dma_buf leak in UALink exporter cleanup
      drm/amdgpu: Fix uninitialized fence in UALink NPA unmap
      drm/amdgpu: Use vm->last_update fence in UALink NPA unmap paths
      drm/amdgpu: always use MTYPE_UC for remote memory on GFX 12.1
      drm/amdkfd: program compute MQD coherent_aql_mtype on GFX 12.1
      drm/amdgpu: Fix GART and SDMA entity leak on vPod reconfiguration
      drm/amdgpu: Add UALink diagnostic logging for vpod commit/activation
      drm/amdgpu: Handle UALink vPod reconfiguration while ACTIVE
      drm/amdgpu: Cleanup UALink XA entries on manager stop
      drm/amdgpu: Handle concurrent UALINK handle import race
      drm/amdgpu: create UALink NPA import BO directly in the NPA domain
      drm/amdgpu: add mtype_remote module parameter
      drm/amdgpu: Honor mtype overrides for NPA remote memory
      drm/gem: Add callback for when handle count goes to 0
      drm/amdgpu: Add ioctl infra for exporting/importing UALink handles
      drm/amdgpu: Don't ignore LSDMA copy errors during remote interrupt se=
nd
      drm/amdgpu: Reset UALink connection on failed TLB-shootdown send
      drm/amdgpu: Fix missed connection cleanup on HELLO reset for UALink
      drm/amdkfd: set CP_HQD_PQ_CONTROL.SCOPE to SYSTEM for GFX 12.1
      drm/amd: set CP_HQD_PQ_CONTROL.SCOPE for PM4 and KCQs on GFX 12.1
      drm/amdgpu: Reject UALink handle ioctl on devices without UALink
      drm/amdgpu: Fix BO reference leak in UALink export error path
      drm/amdgpu: Fix race on ualink_handle_lo in UALink handle export
      drm/amdgpu: re-check connection state before sending NPA-REVOKE
      drm/amdgpu: Fix NPA BO memory accounting stats during import invalida=
tion
      drm/amdgpu: place VRAM-capable dma-buf imports in the PREEMPT domain
      drm/amdgpu: Add SOC_V1_0_DIE_REV_AID() helper
      drm/amdgpu: Use MTYPE_UC for ext-coherent local memory on AID A0 non-=
SPX

Muzaffer Kadir (2):
      dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
      drm: msm: mdp5: Add MDP5 configuration for MSM8952

Myeonghun Pak (1):
      accel/qaic: Cancel Sahara read data work on removal

Nathan Chancellor (2):
      drm/amd/display: Shorten hdmi_frl_status_polling_workqueue
      drm/amd/ras: Adjust second parameter of mp1_v13_0_eeprom_send_msg()

Neil Armstrong (1):
      arm64: dts: qcom: sm8650-ayaneo-pocket-s2: switch sound card to
ayaneo,pocket-s2-sndcard

Nemesa Garg (8):
      drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable
      drm/i915/cursor: Check joiner cursor commit status
      drm/i915/cursor: Add helper to update cursor plane
      drm/i915/cursor: Handle secondary cursor state
      drm/i915/cursor: Program secondary cursor planes
      drm/i915/cursor: Allow joiner cursor fast path update
      Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable"
      drm/i915/psr: Clear stale sel fetch enable bits on sel fetch disable

Nevenko Stupar (1):
      drm/amd/display: Fix DC Hub reference frequency assert range

Nicholas Kazlauskas (5):
      drm/amd/display: Fix crash in DCN5/6 calcs when GPUVM enabled
      drm/amd/display: Fix HostVM init and SOCBB VM config for DCN6
      drm/amd/display: Adjust vblank_nom policy for HW SDP tranmission reqs
      drm/amd/display: Fix missing gaps for link lock with inbox0
      drm/amd/display: Update default clocks for DCN60 lite3 variant

Nickolay Goppen (3):
      dt-bindings: display: panel: Add Novatek NT51021
      drivers: gpu: drm: panel: Add BOE NT51021 driver
      MAINTAINERS: Add myself and Ryan Brue as maintainers of NT51021
panel driver

Nicolas Frattaroli (9):
      drm/scdc-helper: Don't use ssize_t return type for scdc_read/write
      drm/scdc-helper: Add scdc_status debugfs entry
      drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields
      drm/debugfs: Move HDMI debugfs registration to state helper
      drm/display: hdmi-state-helper: Init SCDC debugfs for HDMI
      drm/panthor: Add tracepoint for cache flushing
      drm/panthor: Revisit reqs_lock handling in flush/reset paths
      drm/panthor: Take reqs_lock in soft_reset for clearing pending_reqs
      drm/panthor: Display priorities of panthor groups over debugfs

Niranjana Vishwanathapura (4):
      drm/xe: split VF pause into prepare and revert phases
      drm/xe/multi_queue: handle CGP_SYNC wait timeout during VF recovery
      drm/xe/multi_queue: track and recover lost CGP updates across VF migr=
ation
      drm/xe/multi_queue: replay dynamic CGP updates lost during VF migrati=
on

Nitin Gote (3):
      drm/xe/guc: rework exec queue teardown PM/unplug handling
      drm/xe: remove EXEC_QUEUE_FLAG_PERMANENT
      drm/xe: don't WARN on kernel job timeout when device already wedged

Oleg Keri (2):
      arm64: dts: qcom: glymur-lenovo-yoga-slim7x: add the camera privacy s=
witch
      drm/msm/dp: don't report link training success after a reinit

Omokefe Emmanuel Onanaroghene (1):
      drm/amd/display: fix kernel-doc warnings for amdgpu_display_manager

Osama Abdelkader (6):
      drm/bridge: chipone-icn6211: use devm_mipi_dsi_attach
      drm/panel: Use managed helpers in Samsung panels
      drm/panel: Use managed helpers in Himax and Ilitek panels
      drm/panel: Use managed helpers in display vendor panels
      drm/panthor: validate userspace queue count against initialized
firmware slot count
      drm/panthor: Fix TOCTOU race between GROUP_REGISTERED check and erase

Ovidiu Bunea (8):
      drm/amd/display: Decide zstate_support based off Z8 global support
      drm/amd/display: Add DC_BLS command
      drm/amd/display: Notify DMU to allow DCHVM<->rIOMMU SDP port
disconnection for DCN42
      drm/amd/display: Send DPM0 clock values to DMU
      drm/amd/display: Set mpc_tree_params->opp_id during OPP resource cons=
truct
      drm/amd/display: Remove SDPIF_PORT_CONTROL programming for DCN31/35/4=
2
      drm/amd/display: Add condition to skip MALL calculations if
there is no MALL
      drm/amd/display: Add urgent watermark override for DCN42

Pan Chuang (11):
      drm/bridge: analogix_dp: Remove redundant dev_err()
      drm/bridge: cdns-mhdp8546: Remove redundant dev_err()
      drm/bridge: lt9611: Remove redundant dev_err()
      drm/bridge: samsung-dsim: Remove redundant dev_err()
      drm/bridge: synopsys: dw-dp: Remove redundant dev_err_probe()
      drm/bridge: tc358767: Remove redundant dev_err()
      drm/bridge: it6505: Remove redundant dev_err()
      drm/bridge/sii8620: Remove redundant dev_err_probe()
      drm/bridge: ti-sn65dsi83: Remove redundant dev_err_probe()
      accel: ethosu: Remove redundant dev_err()
      soc: qcom: Remove redundant dev_err()

Peichen Huang (2):
      drm/amd/display: add wait stream regen event
      drm/amd/display: Do not use panel_inst in pr

Perry Yuan (1):
      drm/amdkfd: don't gate userptr cleanup on the owning mm

Philip Yang (20):
      drm/amdgpu: LSDMA supports multiple threads
      drm/amdgpu: LSDMA check PIO error status
      drm/amdgpu: Fix MES wb status pointer overwriting adjacent wb slot
      drm/amdgpu: Fix GMC v12.1.0 MID1 page fault vmhub selection
      drm/amdgpu: Fix UALink vPod double-activation
      drm/amdgpu: Add UALink remote state structures and API declarations
      drm/amdgpu: Add UALink NPA address layout helpers
      drm/amdgpu: Add UALink NPA address computation for ring buffers
      drm/amdgpu: Add UALink NPA VM mapping for ring buffers
      drm/amdgpu: Add UALink SDMA scheduler entities
      drm/amdgpu: Add UALink GART helpers for NPA address access
      drm/amdgpu: Add UALink ring buffer allocation and firmware init
      drm/amdgpu: Add UALink remote command packets and SDMA dispatch
      drm/amdgpu: Add UALink firmware writeback address configuration
      drm/amdgpu: Add UALink cross-GPU TLB shootdown and remote interrupt
      drm/amdgpu: Add UALink software init, teardown, and reset
      drm/amdgpu: Add UALink IH ring and enable interrupt
      drm/amdgpu: UALink use LSDMA to send remote interrupt command
      drm/amdgpu: Increase UALink soft ring size
      drm/amdgpu: Resync UALink ring wptr after reboot

Philipp Stanner (5):
      drm/sched: Lock drm_sched_entity_is_idle()
      rust: Add dma_fence abstractions
      MAINTAINERS: Add entry for Rust dma-buf
      drm/sched: Remove forgotten header
      drm/sched: Protect entity->last_scheduled with spinlock

Pierre-Eric Pelloux-Prayer (8):
      drm/amdgpu: use pm_runtime_resume_and_get amdgpu_gem_create_ioctl
      drm/amdgpu: implement workaround for sdma dcc corruption
      drm/amdgpu: use pm_runtime_resume_and_get for ctx ioctl
      drm/amdgpu: rework runtime pm management for cs
      drm/amdgpu: push down runtime pm handling in amdgpu_gem_create_ioctl
      drm/amdgpu: handle runtime pm in amdgpu_gem_userptr_ioctl
      drm/amdgpu: prevent suspend in fault handler
      drm/amdgpu: get rid of amdgpu_drm_ioctl

Piotr Maziarz (11):
      drm/amd/display: Refactor DPP_PROGRAM_UPSP to drop pipe_ctx
      drm/amd/display: Remove phantom SW state ops from block sequence
      drm/amd/display: fix cursor refactor fallout and sync UT headers
      drm/amd/display: clamp cursor hotspot at the register write
      drm/amd/display: Rename build_cursor_position to
dcn10_build_cursor_pos_update_params
      drm/amd/display: Flatten OPP_SET_DISP_PATTERN_GENERATOR parameters
      drm/amd/display: Remove OPP_SET_MPCC_DISCONNECT_PENDING
      drm/amd/display: Rename HUBBUB_FORCE_PSTATE_CHANGE_CONTROL wait field
      drm/amd/display: Drop disallow_self_refresh_applied output param
      drm/amd/display: Dispatch HUBBUB_SOFT_RESET through hubbub_funcs
      drm/amd/display: Remove dead self-refresh BLS steps

Piotr Pi=C3=B3rkowski (2):
      drm/xe: Add dbg_ratelimited printk wrappers
      drm/xe/mert: Rate limit VF LMTT fault debug log

Pranay Samala (2):
      drm/i915/color: Extract HDR post-CSC LUT programming to helper functi=
on
      drm/i915/color: Program Plane Post CSC registers for SDR planes

Prike Liang (5):
      drm/amdgpu: use underscores in TLB fence driver and timeline names
      drm/amdgpu: clean up the userq support redundant check
      drm/amdgpu: skip gfx switch_power_profile during GPU reset
      drm/amdgpu: move userq fence wait out of signalling section
      drm/amd/display: fix dml-wrapper file discovery for out-of-tree build=
s

Priya Hosur (1):
      drm/amdkfd: Add TLB flush after MES queue eviction/suspension

Puranam V G Tejaswi (2):
      arm64: dts: qcom: eliza: Add GPU nodes
      arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU

Qiang Yu (6):
      arm64: dts: qcom: glymur: Add PCIe3 PHY and PCIe3a controller nodes
      arm64: dts: qcom: glymur-crd: Add PHY supplies for pcie3_phy
      arm64: dts: qcom: mahua: Replace pcie3a/pcie3_phy with dedicated
pcie3b_phy
      arm64: dts: qcom: mahua-crd: Add PHY supplies for pcie3b_phy
      arm64: dts: qcom: hamoa: Drop unused #reset-cells from TCSR node
      arm64: dts: qcom: hamoa/purwa: Add QREF regulator supplies

Raag Jadav (11):
      drm/xe/ras: Validate sysctrl response
      drm/xe/ras: Fix boot-time ras error processing
      drm/xe/drm_ras: Move has_drm_ras check to drm_ras layer
      drm/xe: Fix xe_device_probe() failure
      drm/xe/pci_error: Allow debugging PCI errors
      drm/ras: Cancel and free message on get counter failure
      drm/ras: Introduce error threshold
      drm/xe/ras: Add support for error threshold
      drm/xe/drm_ras: Wire up error threshold callbacks
      drm/xe/sysctrl: Reuse xe_sysctrl_create_command()
      drm/xe/i2c: Disable IRQ on unbind

Rafal Ostrowski (7):
      drm/amd/display: Remove RMCM tetrahedral cube from dc_plane_state
      drm/amd/display: Refactor RMCM into a separate module
      drm/amd/display: Unify fast update classification paths
      drm/amd/display: Drop pipe_ctx from hwss block sequence operations
      drm/amd/display: refactor hwss SET_CURSOR_POSITION block sequence
      drm/amd/display: Refactor DMUB fast lock sequencing
      drm/amd/display: Prepare DSC configuration before BLS execution

Rahul Pon (1):
      drm/msm/a8xx: report the GMEM size of the active slices

Randy Dunlap (1):
      Documentation/gpu: fix location of drm_panel kernel-doc

Raveendra Talabattula (1):
      drm/komeda: Fix bits parsing of GLB_CORE_ID

Raviteja Laggyshetty (1):
      arm64: dts: qcom: x1e80100: Add clocks for QoS configuration

Ray Wu (4):
      drm/amd/display: Align KUnit tests Makefile license header
      drm/amd/display: Flush ISM work before releasing the stream
      drm/amd/display: map PWM brightness through custom backlight curve
      drm/amd/display: Attach blend mode property for alpha planes

Relja Vojvodic (4):
      drm/amd/display: Update and revert FRL LT Timeout behaviour
      drm/amd/display: Update HDMI link rate and DSC handling for DCN60
      drm/amd/display: Block DSC Padding on DP
      drm/amd/display: Update link training no timeout behaviour on HDMI

Reza Kurniawan (3):
      arm64: dts: qcom: msm8917-xiaomi-riva: Enable debug UART console
      arm64: dts: qcom: msm8917-xiaomi-riva: Add GPIO haptic vibrator
      arm64: dts: qcom: msm8917-xiaomi-riva: Add notification LED support

Riana Tauro (2):
      drm/drm_ras: Add drm_ras netlink error event
      drm/xe/xe_ras: Report correctable/uncorrectable error events to users=
pace

Richard Acayan (1):
      arm64: dts: qcom: sdm670-google: Add NFC support

Rob Clark (17):
      drm/gem: Drop ticket arg to lru_scan()
      Merge tag 'qcom-arm64-for-7.4' into msm-next-merge-qcom-drivers-for-7=
.4
      Merge tag 'qcom-drivers-for-7.4' into msm-next-merge-qcom-drivers-for=
-7.4
      drm/msm: Enable THP for GEM buffers
      drm/msm/gem: Add modparam to disable shrinker blocking
      drm/msm/dpu: Fix GAMMA LUT for sm8750 related DPUs
      drm/msm: Sync registers from mesa
      drm/msm/gem: Add helper to check if resident
      drm/msm/gem: Mmap imported dma-bufs via the exporter
      drm/msm/gem: Use get_pages() directly in vmap path
      drm/msm/gem: Stop exposing a page array
      drm/msm/gem: Stop calling get_pages() for imported dma-bufs
      drm/msm/gem: Drop use of drm_prime_sg_to_page_array()
      Revert "dt-bindings: display/msm: Document A845 GPU and GMU"
      Revert "dt-bindings: display/msm: Document A850 GPU and GMU"
      drm/msm/a6xx: Move a702/a704 to a6xx list
      drm/msm/a6xx: Split out a7xx/a8xx device tables

Rodrigo Vivi (3):
      MAINTAINERS: Add entries for drm_ras
      drm/amd/display: Drop KUnit tests for removed parse_hdmi_amd_vsdb()
      Merge drm/drm-next into drm-intel-next

Roman Demidov (2):
      drm/msm/a6xx: fix use-after-free of OPP in a6xx_pm_resume
      drm/msm/a6xx: check pm_runtime_resume_and_get during resume

Roman Li (3):
      drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
      drm/amd/display: Fix backlight control for luminance-capable OLED
      drm/amd/display: Apply debug bit for force p2cpm

Roshan Kumar (1):
      drm/pl111: drop alpha formats the hardware cannot scan out

Ruslan Vagner (1):
      drm/amd: fix comment typos in amdgpu and radeon

Sachin Gupta (2):
      arm64: dts: qcom: lemans-pmics: Enable PMIC MBG thermal monitor
      arm64: dts: qcom: monaco-pmics: Enable PMIC MBG thermal monitor

Saleel Kudchadker (1):
      drm/amdkfd: align SDMA doorbell base for shader doorbell writes

Sam Day (1):
      drm/msm/a3xx: fix VBIF halt mask for A306/A306A

Samson Tam (4):
      drm/amd/display: Move custom float structures from opp.h to custom_fl=
oat.h
      drm/amd/display: Remove fixpt and custom float duplicated code
      drm/amd/display: Remove internal references
      Revert "drm/amd/display: Fix CalculateFlipSchedule Calculation"

Sasha Levin (2):
      drm/panel: select DRM_KMS_HELPER
      drm/amd/display: Fix sanitizer check for the DML frame size limit

Satyajit Roy (3):
      drm/amd/display: Propagate HDMI RGB quantization selectability
      drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
      drm/amd/display: Rebuild InfoFrames on output color space changes

Sean Chang (3):
      drm/ttm: drop stale @ctx kernel-doc entry
      drm/ttm: make ttm_swap_ops static
      drm: bridge: dw_hdmi: Fix constant truncation warning on phy_mask

Sebastian Andrzej Siewior (4):
      drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable()
+ spin_lock()
      drm/i915: Drop the irqs_disabled() check
      drm/i915/guc: Consider also RCU depth in busy loop.
      drm/i915: Use %p for pointer formatting

Shaoyun Liu (1):
      drm/amdgpu: move tlb invalidation to mes sched pipe

Shawn Guo (6):
      arm64: dts: qcom: Drop deprecated qcom,bus-id from SPMI nodes
      arm64: dts: qcom: Drop redundant qcom-rpmpd.h includes
      arm64: dts: qcom: Add device tree for Nord SoC series
      arm64: dts: qcom: Add device tree for Nord Embedded variant
      dt-bindings: arm: qcom: Document Nord reference boards
      arm64: dts: qcom: Add device tree for Nord RRD board

Shiwu Zhang (5):
      drm/amdgpu: retire rb settings from gfx v12.1.0
      drm/amdgpu: retire tcc info and tcp harvest from gfx v12.1.0
      drm/amdgpu: retire get_gb_add_config for gfx_v12_1_0
      drm/amdgpu: add mec FW support for silicon rev 0
      drm/amdgpu: enlarge the waiting time for psp cmd

Shixiong Ou (4):
      drm/log: Batch vmap/vunmap and flush for record drawing
      drm/sched: Fix incorrect test description in drm_sched_basic_cases
      drm/sysfb: Clear entire framebuffer in atomic_disable
      drm/gma500: Create the primary plane in the driver

Shubhankar Milind Sardeshpande (4):
      Revert "drm/amdgpu: add support for NBIO IP version 7.11.5"
      drm/amdgpu: Add NBIO 7.11.5 header files
      drm/amdgpu: Add NBIO 7.11.5 support
      drm/amd/pm: compute SMU v15.0.0 gpu_metrics from accumulator table

Shuicheng Lin (6):
      drm/xe/mmio_gem: Revoke drm_vma_node on xe_mmio_gem destroy
      drm/xe/shrinker: Return the freed page count through a parameter
      drm/xe/shrinker: Take a runtime PM ref before shrinking non-system me=
mory
      drm/xe/tlb_inval: Treat wedged-device invalidations as complete
      drm/xe/madvise: Remove unreachable madvise_funcs NULL check
      drm/xe: Remove no-op ternary in emit_flush_invalidate()

Shujath Mohd (1):
      arm64: dts: qcom: sdm845-sony-xperia-tama: Fix Bluetooth UART pinctrl

Shuvam Pandey (1):
      accel/qaic: Protect perf stats BO state with bo->lock

Sidong Yang (3):
      accel/rocket: Don't tear down the scheduler when drm_sched_init() fai=
ls
      accel/rocket: Use an unsigned index to copy the job's tasks
      accel/rocket: Validate task regcmd address and count on submission

Simon Polack (1):
      drm/amd/display: Fix stale replay_events after mod_power stream remov=
al

Simon Wright (1):
      drm/bridge: dw-hdmi-qp: use drm_hdmi_acr_get_n_cts() helper for
audio N/CTS

Sk Anirban (3):
      drm/i915/selftests: Report missing RC0 power as an error
      drm/xe/debugfs: Expose per-engine idle status
      drm/xe/gt_throttle: Report power brake as a throttle reason on CRI

Sonny Jiang (13):
      drm/amdgpu: Config VCN instance for soc_v1_0"
      drm/amdgpu: Config JPEG instance for soc_v1_0
      drm/amdgpu: correct VCN V5_0_2 doorbell range_size
      drm/amdgpu: Correct VCN V5_0_2 doorbell index setting
      drm/amdgpu: VCN 5_0_2 add support for multi-instance
      drm/amdgpu: VCN 5_0_2 disable VCN_RRMT
      drm/amdgpu: VCN 5_0_2 enable multi-instance
      drm/amdgpu: JPEG 5_0_2 Add multi-instance interrupt support
      drm/amdgpu: VCN 5_0_2 correct process interrupt warn message
      drm/amdgpu: JPEG 5_0_2 set inst_per_aid to 2
      drm/amdgpu: Jpeg 5_0_2 enable doorbell
      drm/amdgpu: Jpeg uses shard VM invalidation engine
      drm/amdgpu: JPEG 5_0_2 enable multi-instance

Sreeshankar K (3):
      soc: qcom: socinfo: Add SM7250 SoC ID
      dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
      dt-bindings: arm: cpus: Document Kryo 475 CPUs

Sridevi Arvindekar (3):
      drm/amd/display: Fix audio test errors
      drm/amd/display: Fixes for HPO test regressions
      drm/amd/display: Handle virtual link encoder

Srinivas Kandagatla (1):
      drm/panel-edp: add CSOT MNE007QB1-1 entry

Srinivasan Shanmugam (5):
      drm/amd/pm: Remove unused functions in smu_v15_0
      drm/amd/display: Fix NULL dereference in dcn50/dcn60 init_hw
      drm/amd/display: Fix redundant NULL check on dc->clk_mgr in
dcn42_prepare_bandwidth
      drm/amdgpu: Fix NULL dereference in amdgpu_ualink_info_set_accel_stat=
e
      drm/amd/display: Fix null deref of link_enc in
dce110_enable_tmds_link_output

Stanley.Yang (1):
      drm/amd/ras: add supported aca blocks mapping

Sujaritha Sundaresan (1):
      drm/xe/guc: Let xe_guc_ct_send_locked() callers reserve G2H credit

Sunil Khatri (22):
      drm/amdgpu/userq: use fence_val instead or rptr
      drm/amdgpu/userq: use fence_val instead or rptr
      drm/amdgpu: make amdgpu_vm_bo_lookup_mapping() take a raw address
      drm/amdgpu/userq: update the kernel docs for amdgpu_userq_fence_read_=
wptr
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT
      drm/amdgpu: fix Idle BOs list in VM debugfs status info
      drm/amdgpu: fix byte/dword unit mismatch in coredump IB dump
      drm/amdgpu: update the fw version for gfx11 userqueues
      drm/amdgpu: update the fw version for gfx12 userqueues
      drm/amdgpu/userq: add a warning if fw does not support userqueues
      drm/amdgpu/userq: dont overwrite the error of subsequent map call
      drm/amdgpu/userq: fix double jiffies conversion in hang detect timeou=
t
      drm/amdgpu/vcn5.0.1: fix video_timeout unit mismatch in jpeg reset wa=
it
      drm/amdgpu/vcn4.0.3: fix video_timeout unit mismatch in jpeg reset wa=
it
      drm/amdgpu/mes12: add more debug info on MES packet failure
      drm/amdgpu/mes11: add more debug info on MES packet failure
      drm/amdgpu/mes12.1: add more debug info on MES packet failure
      drm/amdgpu: move vmid_mask_gfxhub/vmid_mask_mmhub to vm_manager
      drm/amdgpu: fix the indentation of fault_info member
      drm/amdgpu: rename amdgpu_vmid_mgr to amdgpu_kq_vmid_mgr
      drm/amdgpu: add amdgpu_vmid_uq_mask_init() helper
      drm/amdgpu: exclude npa_vmid from the userq vmids too

Suraj Kandpal (14):
      drm/i915/ddi: add helper to compute DDI clock frequency
      drm/i915/cx0: program DDI_CLK_VALFREQ with DDI clock frequency
      drm/i915/lt_phy: program DDI_CLK_VALFREQ with DDI clock frequency
      drm/dp: Add EDP_20 rev definition
      drm/i915/xe3p_lpd: Update CURSOR_BUF/WM masks
      drm/i915/xe3plpd: Map AUX power domains to DC_off
      drm/i915/lspcon: log DPCD access errors
      drm/i915/alpm: log DPCD access errors
      drm/i915/ddi: log DPCD access errors
      drm/i915/backlight: log DPCD access errors
      drm/i915/dp: log DPCD access errors
      drm/i915/linktraining: log link training DPCD access errors
      drm/i915/dptest: log DPCD access errors
      drm/i915/psr: log DPCD access errors

Szymon Aceda=C5=84ski (1):
      drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV

Taimur Hassan (10):
      drm/amd/display: Promote DC to 3.2.393
      drm/amd/display: [FW Promotion] Release 0.1.71.0
      drm/amd/display: Promote DC to 3.2.394
      drm/amd/display: Promote DC to 3.2.395
      drm/amd/display: Promote DC to 3.2.396
      drm/amd/display: [FW Promotion] Release 0.1.74.0
      drm/amd/display: Promote DC to 3.2.397
      drm/amd/display: Promote DC to 3.2.398
      drm/amd/display: [FW Promotion] Release 0.1.76.0
      drm/amd/display: Promote DC to 3.2.399

Taimuraz Kaitmazov (2):
      accel/amdxdna: do not warn when a sync request is rejected
      accel/amdxdna: do not fail a sync for a BO with no debug context

Tales A. Mendon=C3=A7a (3):
      drm/xe: Capture devcoredump on TLB invalidation timeout
      drm/xe: Log when a timed out TLB invalidation ack finally arrives
      drm/xe: Implement Wa_22016122933

Tangudu Tilak Tirumalesh (6):
      drm/xe/ggtt: fault on unmapped GGTT for multi-queue platforms
      drm/xe/tlb_inval: add xe_tlb_inval_ggtt_full() GGTT invalidation help=
er
      drm/xe/ggtt: invalidate engine GGTT TLBs for multi-queue GTs
      drm/xe: harden adjust_idledly() against divide-by-zero and overflow
      drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms
      drm/xe/xe3p_lpg: Add support for Wa_16030224309

Taniya Das (7):
      dt-bindings: clock: qcom,milos-camcc: Add missing power-domains suppo=
rt
      dt-bindings: clock: qcom,milos-videocc: Add missing power-domains sup=
port
      dt-bindings: clock: qcom: Add video clock controller on Qualcomm Eliz=
a SoC
      dt-bindings: clock: qcom: document the Eliza GPU Clock Controller
      dt-bindings: clock: qcom: Add support for CAMCC for Eliza
      arm64: dts: qcom: milos: Add power-domains for camcc and videocc
      arm64: dts: qcom: eliza: Add support for MM clock controllers

Tao Zhou (2):
      drm/amd/ras: set pa base and lfb size for uniras
      drm/amd/ras: do not fail hw_init on ras eeprom errors

Tejas Upadhyay (16):
      drm/xe: Link VRAM resource allocation with gpu buddy
      drm/xe: Link LRC BO and its execution queue with safe lifetime rules
      drm/xe: Export xe_ttm_bo_purge()
      drm/xe: Handle NULL resource and allow purging of VRAM pages
      drm/xe/bo: Make xe_bo_is_user() public
      drm/xe: Guard teardown paths against purged BOs
      drm/xe/vram: Extract buddy allocation and free helpers
      drm/xe/vram: Add page offline data structures and lifecycle
      drm/xe/vram: Add VRAM page offline fault handler
      drm/xe/configfs: Add disable_vram_page_offline attribute
      drm/xe/ras: Cache disable_vram_page_offline policy at init
      drm/xe/vram: Check disable_vram_page_offline policy in fault handler
      drm/xe: Expose bad VRAM pages via debugfs
      drm/xe/uapi: Expose ban reason in EXEC_QUEUE_GET_PROPERTY_BAN
      drm/xe: Add fault-inject based VRAM page offline injection
      drm/xe: Skip clearing purged page-table BOs

Terry Hsiao (1):
      drm/panel-edp: Add BOE NV140FHM-T0A

Thadeu Lima de Souza Cascardo (1):
      Revert "drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info"

Theo Andersen Carton (1):
      drm/amdgpu: skip the noirq suspend reset for a switcheroo-parked GPU

Thomas Hellstr=C3=B6m (3):
      drm/gpusvm: Assign maintainers to the DRM GPUSVM helpers
      drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches
      drm/xe: Make p2pdma distance check verbose via dynamic debug

Thomas Zimmermann (31):
      Merge drm/drm-next into drm-misc-next
      Merge drm/drm-next into drm-misc-next
      drm/hibmc: Return IRQ_NONE for unhandled interrupts
      drm/hibmc: Set up vblank event to be send on the next vblank
      firmware/sysfb: Remove rotation quirk for Lenovo D330
      drm/edid: Add drm_edid_detect_panel_size()
      drm/sysfb: Use preferred panel size for panel orientation quirks
      drm/edid: Include <linux/fb.h>
      drm/client: Add acquire_outputs callback; implement for fbdev emulati=
on
      vga_switcheroo: Add pre_switch callback to client ops
      vga_switcheroo: Add post_switch callback to client ops
      drm: Implement struct vga_switcheroo_client_ops.pre_switch
      drm: Implement vga_switcheroo_client_ops.post_switch
      vga-switcheroo: Remove unused interfaces
      drm/panic: Do not use un-escaped URL as format string
      drm/panic: Test address from kmap op for NULL
      drm/panic: Return -EINVAL if font is not available
      drm/panic: Return errno codes if panic output fails
      drm/panic: Pass colors to draw_panic_dispatch()
      drm/panic: Pass global module parameters to drm_panic_dispatch()
      drm/panic: Return from screen_user if display is too small
      drm/panic: Retry in dispatch function if panic output fails
      drm/panic: Split draw_panic_plane()
      drm/panic: Restrict to primary planes
      drm/panic: Display panic screen via per-plane callback
      drm/panic: Internalize panic locking in DRM core and helpers
      drm/panic: Move panic display code into helper library
      drm/panic: Compile KUnit tests as module
      Merge drm/drm-next into drm-misc-next
      drm/fbdev: Move fbdev module parameters next to module init
      drm/fbdev: Move fbdev helpers into client library

Thorsten Blum (3):
      drm/i915: Fix memory leak in query_perf_config_list()
      gpu: nova-core: gsp: use KVVec::zeroed() for payload buffers
      gpu: nova-core: fsp: use KVec::zeroed() in recv_msg()

Timur Krist=C3=B3f (32):
      drm/amdgpu/ttm: Make buffer copy source readonly
      drm/amdgpu: Respect noretry flag for retry faults on GFX12.1
      drm/amdgpu/gfxhub: Enable retry fault interrupts in
L2_PROTECTION_FAULT_CNTL2
      drm/amdgpu/ih: Don't perturb HW registers when accessing soft IH ring
      drm/amdgpu/ih6.1: Use IH_SW_RING_SIZE for soft IH ring instead
of PAGE_SIZE
      drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring instead
of PAGE_SIZE
      drm/amdgpu/gmc11: Pass cam_index to retry fault handler
      drm/amdgpu/gmc12: Pass cam_index to retry fault handler
      drm/amdgpu/gmc12: Use AMDGPU_PTE_IS_PTE flag for init_pte_flags on GF=
X12.0
      drm/amdgpu/vm: Use init PTE flags in amdgpu_vm_handle_fault()
      drm/amdgpu/ih6.0: Enable retry CAM on Navi 3 dGPUs
      drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs
      drm/amdgpu/sdma: Remove unimplemented soft_reset() for SDMA and SI DM=
A
      drm/amdgpu/sdma: Remove superfluous rlc_resume and rlc_stop functions
      drm/amdgpu/sdma: Fix executing duplicate commands after recovery
on SDMA v4.4.2
      drm/amdgpu/sdma: Remove unnecessary guilty tracking of SDMA queues
      drm/amdgpu: Add amdgpu_ring_clear_ring_and_ptrs()
      drm/amdgpu/sdma: Clear SDMA rings after reset before starting them
      drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
      drm/amdgpu/sdma: Always handle kernel queues in amdgpu_sdma_reset_eng=
ine()
      drm/amdgpu/sdma: Use common SDMA legacy queue reset on SDMA v4.4.2
      drm/amdgpu/gmc: Use amdgpu_gmc_handle_retry_fault() for GMC v12.1
      drm/amd/display: Fix fast updates on DCE 6.x
      drm/amd/display: Fix fast updates on DCE 8.1
      drm/amd/display: Mark DCE 6.4 as not APU
      drm/amdgpu: Delete unimplemented DM soft_reset() code
      drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_D=
C
      drm/amdgpu: Delete SI/CIK/VI IH soft_reset() code
      drm/amdgpu: Delete unimplemented IH soft_reset() code
      drm/amdgpu: Delete GMC v6-v7 soft_reset() code
      drm/amdgpu: Delete unimplemented GMC v9 soft_reset() code
      drm/amd/pm/si: Fix updating clock limits on AC/DC

Timur Tabi (1):
      gpu: nova-core: write initial RPCs before booting GSP-RM

Tom Chung (4):
      drm/amd/display: test native cursor mode on a disabled CRTC
      drm/amd/display: set base.enable in cursor mode tests
      drm/amd/display: Restore the native cursor mode early return for
disabled CRTCs
      drm/amd/display: Add inbox0 HW lock helpers for DCN35

Tomasz Paku=C5=82a (2):
      drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB
      drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB

Tomasz Rusinowicz (1):
      accel/ivpu: Move register poll timeouts to vdev->timeout

Tomasz Siemek (10):
      drm/amd/display: Move periodic interrupt calculations to HWSS
      drm/amd/display: Refactor HUBP_WAIT_FOR_DCC_META_PROP to drop pipe_ct=
x
      drm/amd/display: Use mpcc_id instead of hubp instance
      drm/amd/display: Refactor DPP_SET_INPUT_TRANSFER_FUNC to drop pipe_ct=
x
      drm/amd/display: Split OPTC_PIPE_CONTROL_LOCK into smaller HWSS block=
s
      drm/amd/display: Move cursor SDR white level calculation out of
hwss executor
      drm/amd/display: Remove pipe_ctx param from MPC_VISUAL_CONFIRM
      drm/amd/display: Refactor DC_SEND_CURSOR_INFO_TO_DMU to drop pipe_ctx
      drm/amd/display: Decouple cursor offload hwss executors from pipe con=
text
      drm/amd/display: Decouple HUBP_UPDATE_PLANE_ADDR from pipe_ctx

Tomi Valkeinen (2):
      ASoC: ti: omap-hdmi: Fix build error from a merge commit
      drm/rcar-du: dsi: Support DSC in the pipeline

Tony Cheng (13):
      drm/amd/display: Add instance field to struct mpc
      drm/amd/display: Add instance field to struct dccg
      drm/amd/display: Add SPDX license identifier to dcn30_dpp_cm.c
      drm/amd/display: add SPDX-License-Identifier
      drm/amd/display: Add inst field to struct hubbub
      drm/amd/display: Add inst field to struct clk_mgr
      drm/amd/display: Add inst field to struct abm
      drm/amd/display: Add inst field to struct dmub_psr
      drm/amd/display: Add inst field to struct dmub_replay
      drm/amd/display: Add inst field to struct pg_cntl
      drm/amd/display: Add inst field to encoder structs
      drm/amd/display: Add inst field to clock_source and dio
      drm/amd/display: Move struct dtbclk_dto_params to dc_hw_types.h

Tony Qi (2):
      drm/amd/display: Add max_downscale_src_width debugfs for IGT validati=
on
      drm/amd/display: Revert "request DMUB HW cursor offload"

Tvrtko Ursulin (7):
      drm/amdgpu: Add SDMA ring init helper
      drm/amdgpu: Add amdgpu_sdma_types.h header
      drm/amdgpu: Convert SDMA instance and index to direct lookup
      drm/amdgpu: Cache the SDMA CSA address
      drm/amdgpu: Extend logical to device instance lookup to all devices
      drm/amdgpu: Use memset32 for SDMA padding
      drm/sched: Document entity->stopped is protected by entity->lock

Uma Shankar (4):
      drm/i915/display: Enable periodic AS SDP skip frames
      drm/i915/display: Force disable DC3co when AS SDP skip frames is enab=
led
      drm/i915/display: Reprogram AS SDP skip frames on seamless VRR transi=
tions
      drm/i915/display: Gate periodic AS SDP skip frames behind a debugfs k=
nob

Umang Chheda (3):
      dt-bindings: arm: qcom: Add monaco-ac-evk support
      arm64: dts: qcom: monaco: Add monaco-ac EVK board
      arm64: dts: qcom: monaco-ac-evk: Add IFP mezzanine

Umesh Nerlige Ramappa (1):
      drm/xe/pcode: Use int instead of u32 for mailbox status

Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
      soc: qcom: apr: Drop unused apr_device_id

Varun Gupta (8):
      drm/xe: Add debugfs knob to control GPGPU preemption granularity
      drm/xe: Guard page-fault worker with runtime PM check
      drm/xe: Add multi_queue_active_lrca debugfs
      drm/pagemap: Prevent CPU stalls during unbounded pagemap teardown
      drm/pagemap: Drop ratelimiting from dev_unhold_work debug trace
      drm/xe: Park on the ULLS semaphore before publishing the next job's t=
ail
      drm/xe/guc: Publish the ring tail when replaying a chained ULLS job
      drm/xe/guc: Rewind the LRC ring head when replaying a ULLS job

Vasilij Markin (1):
      drm/appletbdrm: Add suspend and resume support

Victor Lu (1):
      drm/amdgpu: Check for PCIe atomic ops support when reading pf2vf data

Vignesh Raman (1):
      drm/ci: Remove sc7180-trogdor-lazor-limozeen job

Viken Dadhaniya (5):
      soc: qcom: geni-se: Fix endian conversion for serial_protocol compari=
son
      soc: qcom: geni-se: Widen fw_size to u32 to prevent wrap-around
      soc: qcom: geni-se: Fix fw_end computed before round-up;
propagate size to caller
      soc: qcom: geni-se: Fix write to read-only firmware buffer
      arm64: dts: qcom: talos-evk-som: Add firmware-name to QUPv3 nodes

Ville Syrj=C3=A4l=C3=A4 (18):
      drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+
      drm/i915/cdclk: Introduce has_cd2x_pipe_select()
      drm/i915/cdclk: Fix dg2_power_well_count() return type
      drm/i915/cdclk: Don't bail if pcode post nofify fails
      drm/i915/cdclk: Pass CDCLK in MHz to pcode on DG2
      drm/i915/cdclk: Do the DG2 CDCLK/pipe power well notify properly
      drm/i915/cdclk: Notify DG2 pcode about pipe power wells
regardless of CDCLK
      drm/i915/cdclk: Stop forcing voltage level to 3 all the time on DG2
      drm/i915/cdclk: Drop pointless platform check from bxt_set_cdclk()
      drm/i915/cdclk: s/intel_/dg2_/ for DG2 specific stuff
      drm/i915/cdclk: Unify the pcode pre/post notify in bxt_set_cdclk()
      drm/i915/cdclk: Unify pcode related debugs
      drm/i915/cdclk: Extract bdw_cdclk_pcode_{pre,post}_notify()
      drm/i915/cdclk: Extract skl_cdclk_pcode_{pre,post}_notify()
      drm/i915/cdclk: Extract bxt_cdclk_pcode_{pre,post}_notify()
      drm/i915/cdclk: Introduce CDCLK .{pre,post}_notify() vfuncs
      drm/i915/cdclk: Hoist intel_cdclk_{pre,post}_notify() calls upwards
      drm/i915: Perform full wedge on display reset

Vinay Belgaumkar (4):
      drm/xe: Use IBC v3 on PTL
      drm/xe: Add debugfs for IA/GT bias
      drm/xe: Fix a bug in pc_adjust_freq_bounds()
      drm/xe: Poll GT for C6 before D3

Vincenzo Frascino (1):
      drm/komeda: Set display/writeback clone masks

Vinod Govindapillai (6):
      drm/xe/pm: introduce PM PME support
      drm/i915: add pme_enabled() to the parent interface
      drm/i915/xe: plug the pme_enabed implementation for xe
      drm/i915/irq: conditional HPD IRQ resets based on PME capability
      drm/i915/hotplug: avoid HPD polling if the device is PME capable
      drm/i915/fbc: remove uint16 from supported fbc formats in xe3plpd

Vishnu Saini (2):
      dt-bindings: display: simple: Add boe,dv215fhm-r01 compatible
      drm/panel: simple: Add BOE DV215FHM-R01 panel

Vitaly Prosyak (4):
      drm/amdgpu: cancel hang_detect_work before taking userq_mutex
      drm/amdgpu: reserve eviction-fence slot at WPTR caller
      drm/amdgpu: reserve root PD fence slots for userq eviction-fence rear=
m
      drm/amdgpu: serialize vblank counter reads against GPU reset

Vladimir Marioukhine (1):
      drm/amdkfd: implement restore_mqd callbacks for GFX12/12.1

Wang, Sung-huai (1):
      drm/amd/display: Add is_odm_enabled callback to skip init_odm on
active ODM pipes

Wangao Wang (2):
      soc: qcom: ubwc: Add configuration for Hawi
      soc: qcom: ubwc: Add configuration for Maili

Wayne Lin (1):
      drm/amd/display: Extend DMUB wait for DIG PHY programming commands

Wei Deng (4):
      arm64: dts: qcom: hamoa: Add graph port/endpoint anchors to
pcie4_port0 and uart14
      arm64: dts: qcom: hamoa: Add compatible to the PCIe Root Port
      arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connecto=
r
      arm64: dts: qcom: purwa-iot-evk: Describe the PCIe M.2 Key E connecto=
r

Wei-Guang Li (1):
      drm/amd/display: Add Replay cumulative residency query

Wenjing Liu (12):
      drm/amd/display: Fix DCN6 peak bandwidth measurement overshoot
      drm/amd/display: Guard against empty DCN6 UTM QoS table
      drm/amd/display: Add utm_support capability flag
      drm/amd/display: Add stressed peak bandwidth probe with DMA contentio=
n
      drm/amd/display: Add dml2_core_dcn6_calcs function pointer table
      drm/amd/display: Route DCN6 mode support calcs through function
pointer table
      drm/amd/display: Route DCN6 mode programming calcs through
function pointer table
      drm/amd/display: Add urgent assertion counter probe
      drm/amd/display: Fix peak bandwidth measurement sequence
      drm/amd/display: Synchronize UTM overrides with SMU
      drm/amd/display: Consolidate bandwidth overrides
      drm/amd/display: Fix DCN60 UTM QoS override for invalid PMFW table

Wentao Liang (8):
      drm/mali-dp: Fix runtime PM leak in malidp_crtc_atomic_enable()
      drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
      drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()
      drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()
      drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
      drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()
      drm/msm: Fix vm_bo use-after-free in with_vm_locks()
      drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()

William Palacek (1):
      drm/amdkfd: skip migration when the fault window is already in VRAM

Willian Oliveira (2):
      drm/amdgpu/gfx8: fix register_list_format leak in gfx_v8_0_init_micro=
code
      drm/amdgpu/gfx6: fix firmware leak on teardown

Wojciech Dubowik (1):
      drm/bridge: ti-sn65dsi83: Simplify error condition logic

Xiang Liu (39):
      drm/amd/ras: Rename CPER section descriptor struct
      drm/amd/ras: register mce notifier to obtain ras error info
      drm/amd/ras: Introduce BOOT CPER encoding function
      drm/amdgpu/ras: prepare ras_psp for ras_mgr-owned TA reload
      drm/amdgpu/ras: reload RAS TA from ras mgr resume
      drm/amd/ras: add PCIE_PL ACA block mapping
      drm/amd/ras: map boot log events to CPER type
      drm/amd/ras: add rascore BERT record walker
      drm/amd/ras: process cached BERT boot errors
      drm/amd/ras: add missing ras core block names
      drm/amd/ras: add BERT CPER table helpers
      drm/amd/ras: record crashdump BERT sections as boot CPER
      drm/amd/ras: move BERT boot errors to BERT sw init
      drm/amd/ras: allow waking RAS processing without an event
      drm/amd/ras: classify ACA v5 MCE status
      drm/amd/ras: preserve CPU MCE context in the log ring
      drm/amd/ras: define processor and memory CPER formats
      drm/amd/ras: generate AMD crashdump CPER records
      drm/amd/ras: generate processor CPER records
      drm/amd/ras: generate Platform Memory CPER records
      drm/amd/ras: collect CPU MCE metadata
      drm/amd/ras: parse and route BERT sections
      drm/amd/ras: assign BERT platform record ownership
      drm/amd/ras: fix CPER command record retrieval
      drm/amd/ras: request GFX RAS features through ras_mgr
      drm/amd/ras: use the per-ASIC reserved VRAM size for the bad
page threshold
      drm/amd/ras: keep the established socket id layout on older parts
      drm/amd/ras: skip the RAS firmware reload when the block is down
      drm/amd/ras: tolerate an unsupported MCA debug mode control
      drm/amd/ras: drop the RAS module state when its sw init fails
      drm/amd/ras: tell KFD the reset came from an ECC error
      drm/amd/ras: record the fatal state on every device of the hive
      drm/amd/ras: skip poison banks read through the UE channel
      drm/amd/ras: drop the ras_ prefix from the ACA v5 file names
      drm/amd/ras: report the banks the scrubber logged
      drm/amd/ras: report how far a CPER record query got
      drm/amd/ras: take a log batch id only once there is something to log
      drm/amd/ras: apply the MCA debug mode on every RAS resume
      drm/amdgpu: don't leak bo_va when gem_object_open fails

Xiao Lu (1):
      drm/dp/mst: reject DPCD read/write on ports with ddps=3D0

Xilin Wu (6):
      arm64: dts: qcom: sc8280xp: Add more thermal zones
      arm64: dts: qcom: sc8280xp: Mark FastRPC context banks as dma-coheren=
t
      drm/msm/dp: Serialize HPD state updates
      drm/msm/dp: Initialize the debugfs connector pointer
      dt-bindings: display: bridge: simple: document Chrontel CH7218A
      drm/bridge: simple: add Chrontel CH7218A

Xueyao An (1):
      arm64: dts: qcom: shikra: Unreserve GPIOs 14-17 blocking SPI5 access

Yang Wang (3):
      drm/amdgpu: fix ASP 15.0.3 runtime DB offset
      drm/amdgpu: expose MP5 firmware version in sysfs
      drm/amdgpu: support MP5 in firmware info queries

Yi-Ling Chen (1):
      drm/amd/display: Add option for certain panels to disable FEC

YiPeng Chai (86):
      drm/amd/ras: Add ras notification event
      drm/amd/ras: add interface to support parsing aca bank ecc info
      drm/amd/ras: Parse error type of MCE and encode CPER
      drm/amd/ras: Add interface to get ras eeprom table version
      drm/amd/ras: Add dedicated interface to obtain cper info
      drm/amd/ras: optimize mp1 dump bank interface
      drm/amd/ras: support separate logging of gfx aid and xcd errors
      drm/amd/ras: Optimize and remove redundant code
      drm/amd/ras: Supports recording data source timestamps to EEPROM
      drm/amd/ras: Improve function interface to record different types of =
data
      drm/amd/ras: Change variable name to avoid confusion
      drm/amd/ras: add common interface to query ras subunit version
      drm/amd/ras: Add aca parser v5_0
      drm/amd/ras: Add fifo to cache ras data from mce notification
      drm/amd/ras: Add mce ras error type
      drm/amd/ras: Handling ras mce notification event
      drm/amd/ras: Add ras ip configuration for A + A
      drm/amd/ras: Add ras_psp v15_0 for A + A
      drm/amd/ras: Add ras block id mapping
      drm/amd/ras: Support querying RAS driver capabilities
      drm/amd/ras: Add ras command to obtain ras capabilities
      drm/amd/ras: Support poison consumption handling for A + A sriov gues=
t
      drm/amdgpu: Handle ras interrupts using unified interface
      drm/amdgpu: Support obtaining ras capabilities
      drm/amd/ras: Remove unused function interfaces
      drm/amd/ras: Isolate ras mce handler with CONFIG_X86_MCE_AMD
      drm/amd/ras: add interface to query nps mode and vram type
      drm/amd/ras: add helper to convert aca bank to eeprom record
      drm/amd/ras: ras mp1 introduces common interfaces
      drm/amd/ras: Support retrieving bad page info from mp1_v15_0
      drm/amd/ras: add interfaces to manage multiple EEPROMs
      drm/amd/ras: Refactor EEPROM parameter config to support
multiple ras EEPROMs
      drm/amd/ras: Ras eeprom supports new eeprom management interfaces
      drm/amd/ras: switch to use new eeprom management interfaces
      drm/amdgpu/ras: Rework fw eeprom handling for new management interfac=
e
      drm/amd/ras: unify umc record logging paths for runtime and preload
      drm/amd/ras: add interface to obtain FW eeprom records at runtime
      drm/amd/ras: preload and handle bad pages at boot time
      drm/amd/ras: add interface to report bad page info
      drm/amd/ras: Support obtaining bad page info at boot time for
ras_mp1_v15_0
      drm/amd/ras: Add gpu rma exception handling
      drm/amd/ras: use record count instead of bad page count for
EEPROM threshold checking
      drm/amd/ras: remove unused code from ras eeprom
      drm/amd/ras: Add null check to prevent null pointer exception
      drm/amdgpu: Add bad page preloading and pre-reservation support
      drm/amdgpu: fix duplicate ras debugfs node creation on driver reload
      drm/amdgpu: refactor memory handling to support both external
and internal allocation
      drm/amdgpu/ras: support loading RAS RL and TA firmware in RAS module
      drm/amdgpu: add switch to select firmware loading path for RAS RL and=
 TA
      drm/amd/pm: update RAS-specific interface to support multi-parameter
      drm/amd/ras: update mp1_v13_0 to use smu ras multi-parameter interfac=
e
      drm/amd/ras: support multi-parameter communication with mp1 in
ras_mp1_v15_0
      drm/amd/ras: harden error handling and fix resource/lock issues
      drm/amd/ras: fix silent error swallowing in get_record_count paths
      drm/amd/ras: add address translation interface for umc_v15_0
      drm/amd/ras: fix driver unload failure when uniras is enabled
      drm/amd/ras: use single socket per GPU device to store ACA RAS error =
info
      drm/amd/ras: update aca bank decoding for A + A
      drm/amd/ras: add management interface to support psp bad page
address translation
      drm/amdgpu/ras: use flip-bit mask to generalize bad page address
derivation
      drm/amd/ras: introduce row page address buffer alloc/free interfaces
      drm/amd/ras: limit eeprom ras table validation to init and post-write
      drm/amd/ras: resolve compiler warning for stack frame exceeding 1024 =
bytes
      drm/amd/ras: replace variable with function to check poison support
      drm/amd/ras: update interface to support multiple ras query methods
      drm/amd/ras: improve ras log timestamp precision
      drm/amd/ras: add module parameter for uniras
      drm/amdgpu: extend ras feature mask to 64-bit for A + A
      drm/amd/ras: refactor ras cper to simplify adding new cper events
      drm/amd/ras: fix ras cmd returning incorrect cper count
      drm/amd/ras: unify variable naming conventions
      drm/amd/ras: add interface and improve extensibility
      drm/amd/ras: populate cper aca register info for rma device
      drm/amd/ras: filter out invalid pages from extended page addresses
      drm/amd/ras: fix and improve bad page count calculation
      drm/amd/ras: increase page buffer size for A+A
      drm/amd/pm: Add GetRmaStatus message
      drm/amd/ras: retrieve ras error info via common interface and
message for mp1_v13_0
      drm/amd/ras: add pmfw-managed eeprom support for mp1_v13_0
      drm/amd/ras: support aca debug mode for mp1 v13_0
      drm/amd/ras: add MP1 RAS feature status query
      drm/amd/ras: use common mp1 ras interface for v13
      drm/amd/ras: remove obsolete ras mp1 v13 manager code
      drm/amd/ras: add error log for unhandled gpu mce data
      drm/amd/ras: suppress warning for unsupported early init service
      drm/amd/ras: use __le32 pointer type to resolve the sparse warnings

Yogesh Mohan Marimuthu (1):
      drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding for
32bit compile

Yongqiang Sun (3):
      drm/amdgpu: update MES v11/v12 API for mes_dbgext
      drm/amdgpu: add mes_dbgext core support
      drm/amdgpu: wire mes_dbgext on gfx11 and gfx12

Yongxing Mou (5):
      drm/panel-edp: Add support for BOE panel used in KD116N36-30NB-A001
      drm/msm/dp: Pass panel to msm_dp_ctrl_config_msa()
      drm/msm/dp: drop redundant config_ctrl_link() from msm_dp_ctrl_on_str=
eam()
      drm/msm/dp: add MST stream register definitions
      drm/msm/dp: add stream-aware link register accessors

Youssef Samir (5):
      accel/qaic: Add missing <linux/device-id/mhi.h> to sahara and timesyn=
c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_debugfs.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_ras.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_ssr.c

YuBiao Wang (7):
      drm/amdgpu: recompute the dw estimate after allocating a new VM updat=
e job
      drm/amdgpu: add sriov microcode init for MP0 15.0.8
      drm/amdgpu: fix VFI XCC addressing for gmc v12_1 VM invalidation
      drm/amdgpu: skip PF-only programming on the VF
      drm/amdgpu: skip MGCG programming on a VF for gfx v12_1
      drm/amdgpu: fix the unit of the SR-IOV IP discovery size check
      drm/amdgpu/gfx12: read xccs-per-xcp from RLC_IMU_AID_CONFIG for VFI

YuanShang (1):
      drm/amdkfd: mark queues as reset after a full GPU reset

Yuling Li (1):
      drm/amd/display: Fix cursor disable with horizontally split planes

Zack McKevitt (1):
      accel/qaic: Add support for AI200 virtual functions

Ze Huang (10):
      drm/gm12u320: replace struct drm_simple_display_pipe with
regular atomic helpers
      drm/pl111: replace struct drm_simple_display_pipe with regular
atomic helpers
      drm/arcpgu: replace struct drm_simple_display_pipe with regular
atomic helpers
      drm/aspeed: replace struct drm_simple_display_pipe with regular
atomic helpers
      drm/mcde: replace struct drm_simple_display_pipe with regular
atomic helpers
      drm/repaper: replace struct drm_simple_display_pipe with regular
atomic helpers
      drm/tve200: replace struct drm_simple_display_pipe with regular
atomic helpers
      drm/xen: replace struct drm_simple_display_pipe with regular
atomic helpers
      drm/imx/lcdc: avoid duplicate clk_per enable
      drm/imx: replace struct drm_simple_display_pipe with regular
atomic helpers

ZhenGuo Yin (1):
      drm/amdgpu: fall back to RCC_HW_DEBUG for VF frame buffer size

Zhenhao Wan (3):
      drm/nouveau: reject zero-size notifier object allocation
      drm/nouveau/svm: drain fault handler before freeing svmm
      drm/nouveau: prevent NULL deref of gr in GETPARAM_GRAPH_UNITS

Zhigang Luo (6):
      drm/amdgpu: add SRAT lookup for GPU-local memory
      drm/amdgpu: add helper for VRAM in system physical memory
      drm/amdgpu: fetch the A+A VF VBIOS from the SRAT HBM range
      drm/amdgpu: take the A+A VF GMC aperture from SRAT
      drm/amdgpu: mark A+A VF VRAM mappings as system memory
      drm/amdkfd: mark A+A VF VRAM PTEs as system memory

bui duc phuc (1):
      soc: qcom: llcc-qcom: Handle errors from optional IRQ lookup

jiawen (1):
      drm/exynos: fimd: fix clock leak on resume error path

liupeng (1):
      drm/nouveau: Fix typos in comments

 .../ABI/testing/sysfs-driver-intel-xe-gpu          |    10 +
 Documentation/accel/amdxdna/amdnpu.rst             |     1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |     1 +
 .../bindings/arm/qcom,coresight-ctcu.yaml          |     1 +
 .../devicetree/bindings/arm/qcom-soc.yaml          |     4 +-
 Documentation/devicetree/bindings/arm/qcom.yaml    |    15 +
 .../bindings/clock/qcom,milos-camcc.yaml           |    39 +-
 .../bindings/clock/qcom,milos-videocc.yaml         |    29 +-
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |     3 +
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |    10 +-
 .../bindings/display/brcm,bcm2835-v3d.yaml         |     3 +
 .../bindings/display/bridge/analogix,dp.yaml       |    19 +-
 .../display/bridge/fsl,imx8qxp-pxl2dpi.yaml        |     4 +-
 .../bindings/display/bridge/lontium,lt8912b.yaml   |     8 +-
 .../bridge/megachips,stdp2690-ge-b850v3-fw.yaml    |     2 +-
 .../bindings/display/bridge/nxp,tda998x.yaml       |     2 +-
 .../display/bridge/renesas,r8a779g0-dsc.yaml       |    96 +
 .../bindings/display/bridge/simple-bridge.yaml     |     1 +
 .../bindings/display/bridge/toshiba,tc358764.yaml  |     2 +-
 .../bindings/display/bridge/toshiba,tc358775.yaml  |    12 +-
 .../bindings/display/faraday,tve200.yaml           |     2 +-
 .../devicetree/bindings/display/fsl,lcdif.yaml     |    12 +-
 .../devicetree/bindings/display/himax,hx8357.yaml  |     2 +-
 .../bindings/display/imx/fsl,imx-lcdc.yaml         |     2 +-
 .../bindings/display/imx/fsl,imx6q-ldb.yaml        |    54 +-
 .../bindings/display/mediatek/mediatek,ethdr.yaml  |    90 +-
 .../bindings/display/mediatek/mediatek,hdmi.yaml   |    24 +-
 .../devicetree/bindings/display/msm/gmu.yaml       |     8 +-
 .../devicetree/bindings/display/msm/gpu.yaml       |     3 +
 .../devicetree/bindings/display/msm/hdmi.yaml      |     4 +-
 .../devicetree/bindings/display/msm/qcom,mdp5.yaml |     1 +
 .../bindings/display/panel/ilitek,il79900a.yaml    |    13 +-
 .../bindings/display/panel/ilitek,ili7836a.yaml    |    58 +
 .../bindings/display/panel/novatek,nt36532.yaml    |    83 +
 .../bindings/display/panel/novatek,nt51021.yaml    |    87 +
 .../panel/panel-simple-lvds-dual-ports.yaml        |     2 +
 .../bindings/display/panel/panel-simple.yaml       |     2 +
 .../bindings/display/panel/raydium,rm69220.yaml    |    74 +
 .../bindings/display/panel/samsung,ams495qa01.yaml |     2 +-
 .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       |     2 +-
 .../bindings/display/panel/visionox,vtdr6130.yaml  |     8 +-
 .../display/rockchip/rockchip,analogix-dp.yaml     |     1 +
 .../bindings/display/sitronix,st7567.yaml          |     4 +-
 .../bindings/display/solomon,ssd1351.yaml          |    42 +
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |    46 +-
 .../devicetree/bindings/display/st,stm32-ltdc.yaml |     6 +-
 .../bindings/display/st,stm32mp25-lvds.yaml        |     4 +-
 .../devicetree/bindings/display/ste,mcde.yaml      |     5 +
 .../display/tegra/nvidia,tegra20-host1x.yaml       |    52 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |     1 +
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |     1 +
 .../devicetree/bindings/mmc/qcom,sdhci-msm.yaml    |     1 +
 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    |    10 +-
 .../bindings/net/wireless/qcom,ath11k.yaml         |    16 +-
 Documentation/gpu/amdgpu/index.rst                 |     1 +
 Documentation/gpu/amdgpu/ualink.rst                |    75 +
 Documentation/gpu/drm-kms-helpers.rst              |    19 +-
 Documentation/gpu/drm-kms.rst                      |     3 +
 Documentation/gpu/drm-ras.rst                      |    39 +
 Documentation/gpu/drm-uapi.rst                     |    93 +-
 Documentation/gpu/nova/core/fsp.rst                |     2 +
 Documentation/gpu/nova/core/interrupts.rst         |   603 +
 Documentation/gpu/nova/core/pramin.rst             |   128 +
 Documentation/gpu/nova/core/todo.rst               |     2 +-
 Documentation/gpu/nova/index.rst                   |     2 +
 Documentation/gpu/todo.rst                         |    48 +-
 Documentation/gpu/xe/index.rst                     |     1 +
 Documentation/gpu/xe/xe_migrate.rst                |     3 +
 Documentation/gpu/xe/xe_sigid.rst                  |    14 +
 Documentation/netlink/specs/drm_ras.yaml           |    80 +
 MAINTAINERS                                        |    76 +-
 arch/arm/boot/dts/broadcom/bcm2835-common.dtsi     |     1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    27 +
 arch/arm64/boot/dts/qcom/agatti.dtsi               |    76 +-
 arch/arm64/boot/dts/qcom/eliza-cqs-som.dtsi        |    15 +
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi            |   243 +
 arch/arm64/boot/dts/qcom/eliza-mtp.dts             |    34 +
 arch/arm64/boot/dts/qcom/eliza.dtsi                |   774 +-
 .../dts/qcom/glymur-asus-zenbook-a14-ux3407na.dts  |  1140 +
 .../dts/qcom/glymur-asus-zenbook-a16-ux3607oa.dts  |     2 +-
 arch/arm64/boot/dts/qcom/glymur-crd.dts            |     8 +
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi           |    13 +-
 .../boot/dts/qcom/glymur-hp-elitebook-x-g2q.dts    |   940 +
 .../boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts    |  1221 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               |   396 +-
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts         |   134 +-
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi        |    21 +
 .../qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts  |    21 +
 arch/arm64/boot/dts/qcom/hamoa-pmics.dtsi          |     1 +
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |    40 +-
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts     |    10 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |    21 +-
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  1413 +-
 .../boot/dts/qcom/lemans-evk-ifp-mezzanine.dtso    |    12 +-
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi         |   116 +
 arch/arm64/boot/dts/qcom/mahua-crd.dts             |     5 +
 arch/arm64/boot/dts/qcom/mahua.dtsi                |    89 +
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |   191 +
 arch/arm64/boot/dts/qcom/milos.dtsi                |    86 +-
 arch/arm64/boot/dts/qcom/monaco-ac-evk.dts         |   938 +
 .../boot/dts/qcom/monaco-evk-ifp-mezzanine.dtso    |    12 +-
 arch/arm64/boot/dts/qcom/monaco-pmics.dtsi         |    62 +
 arch/arm64/boot/dts/qcom/monaco.dtsi               |     1 -
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts   |    35 +
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi        |  1820 +
 arch/arm64/boot/dts/qcom/nord-gearvm.dtsi          |  2848 +
 arch/arm64/boot/dts/qcom/nord-ride.dts             |   254 +
 arch/arm64/boot/dts/qcom/nord-rrd.dts              |   424 +
 arch/arm64/boot/dts/qcom/nord.dtsi                 |  4605 ++
 arch/arm64/boot/dts/qcom/purwa-iot-evk.dts         |   133 +-
 arch/arm64/boot/dts/qcom/purwa-iot-som.dtsi        |    21 +
 .../qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso |    24 +-
 .../dts/qcom/qcs6490-rb3gen2-vision-mezzanine.dtso |    13 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |    12 +-
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |    12 +-
 .../qcs6490-thundercomm-rubikpi3-cam1-imx219.dtso  |   115 +
 .../qcs6490-thundercomm-rubikpi3-cam2-imx219.dtso  |   115 +
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |    23 +
 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts       |    12 +-
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             |     1 -
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |     3 +
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts      |     3 +
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |    37 +
 .../boot/dts/qcom/sc8280xp-microsoft-arcata.dts    |     3 +
 .../boot/dts/qcom/sc8280xp-microsoft-blackrock.dts |     3 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   574 +-
 arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi |    42 +
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi |    36 +-
 .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi |     1 -
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     |     2 +
 arch/arm64/boot/dts/qcom/sdx75.dtsi                |     2 -
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi       |     1 -
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi           |    18 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi       |     1 -
 arch/arm64/boot/dts/qcom/shikra.dtsi               |  1490 +-
 arch/arm64/boot/dts/qcom/sm4450.dtsi               |     1 -
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |     4 +
 .../boot/dts/qcom/sm7325-nothing-spacewar.dts      |     2 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |     1 -
 .../boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi   |    17 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |     1 -
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |     1 -
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |     2 -
 .../boot/dts/qcom/sm8650-ayaneo-pocket-s2.dts      |   232 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |     2 -
 arch/arm64/boot/dts/qcom/sm8750.dtsi               |    70 +-
 .../boot/dts/qcom/talos-evk-rpi-display-2-5in.dtso |    88 +
 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi        |     4 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |     1 -
 arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi |    21 +
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi  |    21 +
 arch/arm64/boot/dts/qcom/x1-crd.dtsi               |    21 +
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi        |    21 +
 arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi   |    21 +
 arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi  |    89 +-
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts       |    21 +
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |    21 +
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |   119 +
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |    21 +
 .../dts/qcom/x1e80100-honor-magicbook-art-14.dts   |    21 +
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |    21 +
 .../dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts    |    25 +-
 .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  |    21 +
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          |    21 +
 .../boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts |    21 +
 .../boot/dts/qcom/x1p42100-microsoft-sp12in.dts    |    21 +
 drivers/accel/amdxdna/aie.c                        |    39 +
 drivers/accel/amdxdna/aie.h                        |     4 +
 drivers/accel/amdxdna/aie2_ctx.c                   |   132 +-
 drivers/accel/amdxdna/aie2_error.c                 |     9 +-
 drivers/accel/amdxdna/aie2_message.c               |    19 +-
 drivers/accel/amdxdna/aie2_msg_priv.h              |     1 +
 drivers/accel/amdxdna/aie2_pci.c                   |    30 +-
 drivers/accel/amdxdna/aie2_pci.h                   |     8 +-
 drivers/accel/amdxdna/aie4_pci.c                   |     8 +-
 drivers/accel/amdxdna/amdxdna_error.h              |    10 +
 drivers/accel/amdxdna/amdxdna_gem.c                |   465 +-
 drivers/accel/amdxdna/amdxdna_gem.h                |     6 +-
 drivers/accel/amdxdna/amdxdna_mailbox.c            |   221 +-
 drivers/accel/amdxdna/amdxdna_mailbox.h            |     9 +-
 drivers/accel/amdxdna/amdxdna_mailbox_helper.c     |     2 +-
 drivers/accel/amdxdna/amdxdna_mailbox_helper.h     |     1 -
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |     6 +
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |     9 +
 drivers/accel/amdxdna/npu4_regs.c                  |     1 +
 drivers/accel/ethosu/ethosu_drv.c                  |     2 +-
 drivers/accel/ethosu/ethosu_job.c                  |     4 +-
 drivers/accel/ivpu/ivpu_drv.c                      |    98 +-
 drivers/accel/ivpu/ivpu_drv.h                      |    72 +-
 drivers/accel/ivpu/ivpu_fw.c                       |   106 +-
 drivers/accel/ivpu/ivpu_fw.h                       |     3 +-
 drivers/accel/ivpu/ivpu_gem.c                      |     5 +-
 drivers/accel/ivpu/ivpu_hw.c                       |    33 +-
 drivers/accel/ivpu/ivpu_hw.h                       |     8 +-
 drivers/accel/ivpu/ivpu_hw_40xx_reg.h              |   195 -
 drivers/accel/ivpu/ivpu_hw_btrs.c                  |    56 +-
 drivers/accel/ivpu/ivpu_hw_btrs.h                  |     3 -
 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h          |    83 -
 .../{ivpu_hw_btrs_lnl_reg.h =3D> ivpu_hw_btrs_reg.h} |    84 +-
 drivers/accel/ivpu/ivpu_hw_ip.c                    |   490 +-
 drivers/accel/ivpu/ivpu_hw_ip.h                    |     3 +-
 .../ivpu/{ivpu_hw_37xx_reg.h =3D> ivpu_hw_ip_reg.h}  |    71 +-
 drivers/accel/ivpu/ivpu_ipc.c                      |    11 +-
 drivers/accel/ivpu/ivpu_job.c                      |    98 +-
 drivers/accel/ivpu/ivpu_job.h                      |     5 +-
 drivers/accel/ivpu/ivpu_mmu.c                      |    12 +-
 drivers/accel/ivpu/ivpu_ms.c                       |    17 +-
 drivers/accel/ivpu/ivpu_pm.c                       |     1 -
 drivers/accel/qaic/mhi_controller.c                |   192 +-
 drivers/accel/qaic/qaic.h                          |     1 +
 drivers/accel/qaic/qaic_data.c                     |    22 +-
 drivers/accel/qaic/qaic_debugfs.c                  |     1 +
 drivers/accel/qaic/qaic_drv.c                      |    48 +
 drivers/accel/qaic/qaic_ras.c                      |     1 +
 drivers/accel/qaic/qaic_ssr.c                      |     1 +
 drivers/accel/qaic/qaic_timesync.c                 |     1 +
 drivers/accel/qaic/sahara.c                        |     2 +
 drivers/accel/rocket/rocket_gem.c                  |     2 +-
 drivers/accel/rocket/rocket_job.c                  |    28 +-
 drivers/dma-buf/dma-buf.c                          |     2 +-
 drivers/dma-buf/dma-resv.c                         |     2 +-
 drivers/dma-buf/st-dma-fence-unwrap.c              |    10 +
 drivers/firmware/efi/sysfb_efi.c                   |     9 -
 drivers/firmware/qcom/Kconfig                      |     4 +-
 drivers/firmware/qcom/qcom_scm.c                   |    25 +-
 drivers/gpu/buddy.c                                |  1343 +-
 drivers/gpu/drm/Kconfig                            |    16 +-
 drivers/gpu/drm/Kconfig.debug                      |     1 +
 drivers/gpu/drm/Makefile                           |     8 +-
 drivers/gpu/drm/adp/adp-mipi.c                     |     1 +
 drivers/gpu/drm/adp/adp_drv.c                      |     2 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |    17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |     6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   136 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h           |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |     8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c   |     3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c    |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |   151 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h |     6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   |     1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |    36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |    55 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   100 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h        |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   144 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   409 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |    14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |    25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    89 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h            |     6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   135 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   157 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   280 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   124 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |    73 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |    29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c          |    45 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c             |    68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h             |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    70 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h            |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c            |     6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c          |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h          |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   861 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |     5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   643 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    88 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   113 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h     |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    50 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |    36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |   169 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |   165 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h     |   163 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |    45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c   |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    72 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |  6592 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h         |   427 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    38 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |     5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |    46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |    61 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |    77 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    90 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   127 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   131 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h    |   167 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |    71 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c   |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |    66 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h            |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |    49 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |    42 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |    29 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |     7 -
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |    43 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    68 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |    43 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |     6 -
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |     6 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |     6 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    50 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   113 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   117 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   830 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h         |    39 -
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    39 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   153 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   150 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |   112 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |    45 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c        |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c          |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          |    65 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           |     3 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c         |     9 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    12 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |    18 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   119 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |   293 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h             |     2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |    92 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |    90 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    19 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    21 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c              |   132 +
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h              |    31 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |    43 -
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               |    46 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |    23 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c               |    50 +-
 drivers/gpu/drm/amd/amdgpu/ih_v8_0.c               |   781 +
 drivers/gpu/drm/amd/amdgpu/ih_v8_0.h               |    28 +
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c             |    91 +-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |     2 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |     2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |     2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |     2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |     4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h           |     8 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |   265 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |     1 -
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c            |    27 +-
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c            |   138 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h            |    31 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |    95 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h         |     4 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   237 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   217 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   286 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |   377 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c            |   603 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h            |    28 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |    18 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |   155 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c            |   350 +
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h            |    32 +
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c           |    18 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c          |   351 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h          |    32 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |     6 -
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   167 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c           |   836 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h           |    32 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c           |   146 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |   105 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   113 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   126 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   252 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   143 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |   135 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |   145 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |   144 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |   117 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |     6 -
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    38 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |    31 -
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c         |    84 +
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h         |    30 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |     6 -
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |     6 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |     6 -
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |     6 -
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |   476 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h              |    27 +
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h             |     1 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |    44 -
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c           |   143 +
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h           |    30 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |     8 -
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |     8 -
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |     8 -
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |     5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |     3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |    17 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |    24 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |    22 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |    24 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |    24 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |    20 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |   351 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |    15 -
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |    15 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |     6 -
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c              |   351 +
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h              |    29 +
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |    90 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm |   122 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    21 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   219 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     4 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |     6 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |    25 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |    53 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |    31 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |     9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    46 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |    10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    35 +-
 drivers/gpu/drm/amd/display/Kconfig                |    12 +-
 drivers/gpu/drm/amd/display/Makefile               |     1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   487 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   183 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |    35 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |     1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |    86 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |   137 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |    29 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   422 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |    11 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    87 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |     9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |    63 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h   |     6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    88 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |    47 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |    15 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |    63 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    32 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |    30 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |     9 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |    21 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |     2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    73 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |    25 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   129 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |    14 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    35 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |    99 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |    72 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |    16 +
 .../drm/amd/display/amdgpu_dm/tests/.kunitconfig   |     1 -
 .../gpu/drm/amd/display/amdgpu_dm/tests/Makefile   |     4 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |    53 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   232 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  4712 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   813 +-
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   736 +
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   578 +-
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   429 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  1129 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |  2308 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   436 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |  2791 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |  2660 +-
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   228 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  4292 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   334 +
 drivers/gpu/drm/amd/display/dc/Makefile            |     8 +-
 .../drm/amd/display/dc/bios/command_table_helper.c |     7 +-
 .../amd/display/dc/bios/command_table_helper2.c    |     2 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |     8 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |     4 +
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |    12 +-
 .../amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c   |   181 +
 .../amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h   |    29 +
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c |     9 +-
 .../drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c |     6 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |    12 +-
 .../amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c |     6 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |     5 +-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |     8 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |     8 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |    10 +-
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |    10 +-
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |    14 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |    10 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |    18 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |    12 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    19 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |    33 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |     5 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |    54 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h  |   345 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |   478 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h   |    17 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c       |   184 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h       |   167 +-
 .../display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h |    78 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   422 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |     2 +
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  1635 +-
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |    30 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   245 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |     6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   180 +-
 .../gpu/drm/amd/display/dc/core2/CMakeLists.txt    |    10 +
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c    |    34 +
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h    |    19 +
 .../gpu/drm/amd/display/dc/core2/dc_core2_init.c   |    13 +
 .../gpu/drm/amd/display/dc/core2/dc_core2_init.h   |    10 +
 drivers/gpu/drm/amd/display/dc/dc.h                |    73 +-
 .../amd/display/dc/dc_api_dispatch/CMakeLists.txt  |     9 +
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.c  |    32 +
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.h  |    19 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   291 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |    58 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |     1 +
 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c    |    80 -
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    30 +-
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c    |   281 +
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h    |   107 +
 drivers/gpu/drm/amd/display/dc/dc_probe.h          |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    14 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |     8 +-
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h |     4 +
 .../drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c   |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c |     2 +
 .../drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c   |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c |     1 +
 .../drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c   |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |     2 +
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c   |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    15 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |     2 +-
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c |     5 +
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h |     4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |     2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |    12 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    11 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   121 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |     1 +
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |    18 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |     1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h      |     1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |    28 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h   |     3 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c  |     2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |     8 +-
 .../drm/amd/display/dc/dcn301/dcn301_panel_cntl.c  |     1 +
 .../drm/amd/display/dc/dcn31/dcn31_panel_cntl.c    |     1 +
 .../gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c   |     1 +
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |    12 +-
 .../display/dc/dio/dcn10/dcn10_stream_encoder.c    |     2 +
 .../amd/display/dc/dio/dcn20/dcn20_link_encoder.c  |     2 +
 .../display/dc/dio/dcn20/dcn20_stream_encoder.c    |     2 +
 .../display/dc/dio/dcn30/dcn30_dio_link_encoder.c  |     2 +
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c        |     2 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c        |     2 +
 .../display/dc/dio/dcn31/dcn31_dio_link_encoder.c  |     2 +
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c      |     2 +
 .../display/dc/dio/dcn32/dcn32_dio_link_encoder.c  |     2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c        |     2 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c        |     2 +
 .../display/dc/dio/dcn35/dcn35_dio_link_encoder.c  |     2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c        |     2 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c        |     2 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c      |     1 +
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.c  |     6 +-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c        |     2 +
 .../display/dc/dio/dcn60/dcn60_dio_link_encoder.c  |     2 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c        |     2 +
 .../display/dc/dio/virtual/virtual_link_encoder.c  |     3 +
 .../dc/dio/virtual/virtual_stream_encoder.c        |     1 +
 .../gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c   |     1 -
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |    18 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |     2 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |     2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |     4 +-
 .../gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c  |     8 +-
 .../gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c   |     1 -
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |    17 +-
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.h    |   106 -
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |    39 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |    37 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h  |    27 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h  |    12 +
 .../dc/dml2_0/dml21/inc/dml_top_dchub_registers.h  |     1 +
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |     1 +
 .../dml2_0/dml21/inc/dml_top_soc_parameter_types.h |    28 +-
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |    15 +
 .../dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c   |     4 +-
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c   |     1 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |     4 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |   222 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.h     |     1 +
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |    18 +-
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.h     |    23 +
 .../dml2_core/dml2_core_dcn5_calcs_display_pipe.c  |     2 +-
 .../dml2_core/dml2_core_dcn5_funcs_initialize.c    |     2 +-
 .../dml2_core_dcn5_funcs_mode_programming.c        |     4 +
 .../dml2_core/dml2_core_dcn5_funcs_mode_support.c  |    32 +-
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs.c     |    63 +-
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs.h     |   468 +
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c     |    88 +-
 .../dml2_core/dml2_core_dcn6_funcs_initialize.c    |     4 +
 .../dml2_core_dcn6_funcs_mode_programming.c        |    52 +-
 .../dml2_core_dcn6_funcs_mode_programming.h        |    31 +
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.c  |   350 +-
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.h  |   324 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |     1 +
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |    11 +-
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   106 +-
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |     1 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |     1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |    11 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |     1 +
 .../alternate_pstate_shared_lib.c                  |    22 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c       |     1 +
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c    |     4 +-
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c     |    15 +-
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c  |     1 +
 .../dml21/src/inc/dml2_internal_shared_types.h     |    19 +
 .../gpu/drm/amd/display/dc/dml2_wrapper/Makefile   |    62 +
 .../dml21_wrapper}/dml21_translation_helper.c      |    46 +-
 .../dml21_wrapper}/dml21_translation_helper.h      |     7 +-
 .../dml21_wrapper}/dml21_utils.c                   |    24 +-
 .../dml21_wrapper}/dml21_utils.h                   |     7 +-
 .../dml21_wrapper}/dml21_wrapper.c                 |     2 +-
 .../dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h  |   107 +
 .../dml21_wrapper}/dml21_wrapper_fpu.c             |    19 +-
 .../dml21_wrapper}/dml21_wrapper_fpu.h             |     7 +-
 .../dml2_dc_resource_mgmt.c                        |    60 +-
 .../dml2_dc_resource_mgmt.h                        |     0
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_dc_types.h    |     0
 .../{dml2_0 =3D> dml2_wrapper}/dml2_internal_types.h |     2 +-
 .../{dml2_0 =3D> dml2_wrapper}/dml2_mall_phantom.c   |    70 +-
 .../{dml2_0 =3D> dml2_wrapper}/dml2_mall_phantom.h   |     0
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_policy.c      |     2 +-
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_policy.h      |     0
 .../dml2_translation_helper.c                      |    20 +-
 .../dml2_translation_helper.h                      |     0
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_utils.c       |    28 +-
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_utils.h       |     0
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_wrapper.c     |     6 +-
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_wrapper.h     |     0
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_wrapper_fpu.c |    45 +-
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_wrapper_fpu.h |     0
 drivers/gpu/drm/amd/display/dc/dpp/Makefile        |     2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h   |    22 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |    12 +-
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h |     2 +
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |    19 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c   |    20 +-
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h   |    14 +-
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |     3 +-
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h   |    10 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c    |   115 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |     8 +
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |    48 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h   |    13 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c   |     1 +
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |    34 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h |     5 +-
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c   |    45 +-
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h   |     3 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |     3 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |     7 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     4 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     4 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c    |     8 +-
 .../dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c  |     2 +
 .../dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c    |    11 +-
 .../dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c    |   142 +-
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c |     2 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h |    11 +-
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |     7 +-
 .../amd/display/dc/hubbub/dcn201/dcn201_hubbub.c   |     2 +
 .../drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c |     2 +
 .../drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c |     2 +
 .../amd/display/dc/hubbub/dcn301/dcn301_hubbub.c   |     2 +
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |     6 +-
 .../drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c |     2 +
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |    16 +-
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |     3 +
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c |    57 +-
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h |     7 +-
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |   250 +-
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h |    19 +-
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |     4 +-
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h |     3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |     5 +-
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h |     3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c |    11 +-
 .../gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h |     2 +-
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |     7 +-
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h |     3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c |     1 +
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |   114 +-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |     5 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |     6 +-
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c |    28 +-
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h |     3 +-
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c |     9 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile       |     6 +
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c    |    46 +-
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h    |    12 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |    39 +-
 .../drm/amd/display/dc/hwss/dce60/dce60_hwseq.c    |     8 +-
 .../drm/amd/display/dc/hwss/dce80/dce80_hwseq.c    |     3 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   291 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h    |    22 +-
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c |     6 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   306 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h    |    26 +-
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c |     5 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c  |    64 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h  |     7 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_init.c   |     6 +-
 .../gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c |     5 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    61 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h    |     8 +-
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |     5 +-
 .../drm/amd/display/dc/hwss/dcn301/dcn301_init.c   |     5 +-
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |     5 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |    22 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |     5 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |   142 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h    |    12 +-
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |     7 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |   147 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h    |    16 +-
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |     7 +-
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |     7 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   431 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    26 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |     7 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   346 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |    23 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |    12 +-
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |    24 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |   249 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h    |     5 +-
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |    14 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |   392 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |    28 +-
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h  |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |     2 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    13 +-
 drivers/gpu/drm/amd/display/dc/inc/custom_float.h  |    21 +-
 .../gpu/drm/amd/display/dc/inc/dc_core_interface.h |    31 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |     1 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |     9 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |    10 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h        |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |    10 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |     5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |     6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |    10 -
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |    65 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |    17 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h    |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h       |   140 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |     2 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |     1 +
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |     9 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |    20 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |     2 +
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |    21 -
 .../amd/display/dc/irq/dce110/irq_service_dce110.h |     9 -
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |    28 +
 drivers/gpu/drm/amd/display/dc/irq/irq_service.h   |     9 +
 .../amd/display/dc/link/hwss/link_hwss_hpo_dp.c    |    23 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |     8 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |    15 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |     7 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |     9 +-
 .../display/dc/link/protocols/link_dp_capability.c |     3 +-
 .../dc/link/protocols/link_dp_panel_replay.c       |    36 +-
 .../dc/link/protocols/link_dp_panel_replay.h       |     2 +-
 .../display/dc/link/protocols/link_dp_training.c   |    20 +-
 .../dc/link/protocols/link_edp_panel_control.c     |   103 +-
 .../dc/link/protocols/link_edp_panel_control.h     |     6 +
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |    86 +-
 .../gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   |     1 +
 .../gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   |     1 +
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |     1 +
 .../gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c   |     1 +
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |    19 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   |   680 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h   |   714 +-
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c   |    41 +-
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h   |   238 -
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c   |     7 +-
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h   |     3 +-
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |    10 +
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h |     1 +
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c |     1 +
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c |    83 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |    19 +
 .../drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c    |     1 +
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |     5 +
 drivers/gpu/drm/amd/display/dc/resource/Makefile   |     4 +
 .../display/dc/resource/dce112/dce112_resource.c   |    62 -
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |     2 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |     2 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |     2 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |     2 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |     2 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |    62 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |   131 +-
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |    66 +-
 .../amd/display/dc/resource/dcn60/dcn60_resource.h |     9 +-
 drivers/gpu/drm/amd/display/dc/rmcm/Makefile       |    44 +
 .../gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c |   867 +
 .../gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h |   717 +
 .../gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c |   251 +
 .../{dc_edid_parser.h =3D> rmcm/dcn60/dcn60_rmcm.h}  |    23 +-
 .../dcn401/dcn401_soc_and_ip_translator.c          |     6 +-
 .../dcn60/dcn60_soc_and_ip_translator.c            |    45 +-
 drivers/gpu/drm/amd/display/dc/sspl/Makefile       |     5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c       |   130 +-
 .../amd/display/dc/sspl/dc_spl_isharp_filters.c    |    10 +-
 .../amd/display/dc/sspl/dc_spl_scl_easf_filters.c  |    88 +-
 .../drm/amd/display/dc/sspl/dc_spl_scl_filters.c   |    24 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h |    60 +-
 .../gpu/drm/amd/display/dc/sspl/spl_custom_float.c |   152 -
 .../gpu/drm/amd/display/dc/sspl/spl_custom_float.h |    29 -
 .../gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c   |   495 -
 .../gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h   |   526 -
 .../gpu/drm/amd/display/dc/sspl/spl_namespace.h    |    17 +
 drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h |    44 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |    60 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   189 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |    74 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  |    82 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h  |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  |    82 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h  |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c  |    82 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h  |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c |    86 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  |    86 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h  |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c  |    86 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h  |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |    63 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     5 +
 .../drm/amd/display/include/link_service_types.h   |     1 +
 .../drm/amd/display/modules/color/color_gamma.c    |     3 +-
 .../drm/amd/display/modules/inc/mod_info_packet.h  |     4 +
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |     4 +
 .../amd/display/modules/info_packet/info_packet.c  |   109 +
 .../drm/amd/display/modules/power/power_replay.c   |    19 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |     6 +-
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h |     4 +
 .../amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h    |     8 +-
 .../amd/include/asic_reg/hdp/hdp_8_0_1_offset.h    |   213 +
 .../amd/include/asic_reg/hdp/hdp_8_0_1_sh_mask.h   |   665 +
 .../include/asic_reg/lsdma/lsdma_8_0_1_offset.h    |   385 +
 .../include/asic_reg/lsdma/lsdma_8_0_1_sh_mask.h   |  1399 +
 .../include/asic_reg/mmhub/mmhub_5_0_1_offset.h    |  1494 +-
 .../include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h   |  7489 ++-
 .../drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h |  1105 +
 .../amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h    |  1646 +
 .../amd/include/asic_reg/nbif/nbif_7_10_0_offset.h | 15938 +++++
 .../include/asic_reg/nbif/nbif_7_10_0_sh_mask.h    | 60316 +++++++++++++++=
+++
 .../amd/include/asic_reg/nbio/nbio_7_11_5_offset.h | 11074 ++++
 .../include/asic_reg/nbio/nbio_7_11_5_sh_mask.h    | 63248 +++++++++++++++=
++++
 .../amd/include/asic_reg/oss/osssys_8_0_1_offset.h |   275 +
 .../include/asic_reg/oss/osssys_8_0_1_sh_mask.h    |   984 +
 .../amd/include/asic_reg/pcie/pcie_6_1_3_offset.h  |  1755 +
 .../amd/include/asic_reg/pcie/pcie_6_1_3_sh_mask.h | 10821 ++++
 .../include/asic_reg/smuio/smuio_15_0_3_offset.h   |    79 +
 .../include/asic_reg/smuio/smuio_15_0_3_sh_mask.h  |   164 +
 .../amd/include/asic_reg/vpe/vpe_3_0_0_offset.h    |   877 +
 .../amd/include/asic_reg/vpe/vpe_3_0_0_sh_mask.h   |  2661 +
 drivers/gpu/drm/amd/include/discovery.h            |   159 +-
 .../amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h |    30 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |     4 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    17 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |    18 +
 drivers/gpu/drm/amd/include/mes_v12_api_def.h      |    17 +
 drivers/gpu/drm/amd/include/soc_v2_0_ih_clientid.h |    51 +
 drivers/gpu/drm/amd/include/v12_structs.h          |     2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |    26 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |    56 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |     3 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c         |     6 -
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |     7 -
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |     6 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    |     3 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |    49 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |    23 +-
 .../pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h |    46 -
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h  |     1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |     1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |     6 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |     2 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |     6 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |     2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |    24 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |    10 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |     1 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |     8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   174 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   270 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |    21 +-
 drivers/gpu/drm/amd/ras/core/Makefile              |    11 +-
 drivers/gpu/drm/amd/ras/core/aca.c                 |   353 +-
 drivers/gpu/drm/amd/ras/core/aca.h                 |    44 +-
 drivers/gpu/drm/amd/ras/core/aca_v1_0.c            |    41 +-
 drivers/gpu/drm/amd/ras/core/aca_v5_0.c            |   448 +
 drivers/gpu/drm/amd/ras/core/aca_v5_0.h            |    62 +
 drivers/gpu/drm/amd/ras/core/cmd.c                 |   147 +-
 drivers/gpu/drm/amd/ras/core/cmd.h                 |    32 +-
 drivers/gpu/drm/amd/ras/core/core.c                |   309 +-
 drivers/gpu/drm/amd/ras/core/eeprom.c              |   510 +-
 drivers/gpu/drm/amd/ras/core/eeprom.h              |    27 +-
 drivers/gpu/drm/amd/ras/core/eeprom_fw.c           |   640 +-
 drivers/gpu/drm/amd/ras/core/eeprom_fw.h           |    67 +-
 drivers/gpu/drm/amd/ras/core/log_ring.c            |    56 +-
 drivers/gpu/drm/amd/ras/core/log_ring.h            |    46 +-
 drivers/gpu/drm/amd/ras/core/ras.h                 |   138 +-
 drivers/gpu/drm/amd/ras/core/ras_bert.c            |   546 +
 drivers/gpu/drm/amd/ras/core/ras_bert.h            |    33 +
 drivers/gpu/drm/amd/ras/core/ras_cper.c            |   844 +-
 drivers/gpu/drm/amd/ras/core/ras_cper.h            |   177 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c      |   419 +
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h      |   124 +
 drivers/gpu/drm/amd/ras/core/ras_gfx.c             |    13 +-
 drivers/gpu/drm/amd/ras/core/ras_mce.c             |   151 +
 drivers/gpu/drm/amd/ras/core/ras_mce.h             |    51 +
 drivers/gpu/drm/amd/ras/core/ras_mp1.c             |   171 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1.h             |    87 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c       |   175 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c       |   249 +
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h       |    30 +
 drivers/gpu/drm/amd/ras/core/ras_nbio.c            |    12 +-
 drivers/gpu/drm/amd/ras/core/ras_process.c         |    36 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.c             |   603 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.h             |   111 +-
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c       |    76 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c       |   133 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h       |    31 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.c     |   114 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.h     |    31 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c             |   639 +-
 drivers/gpu/drm/amd/ras/core/ras_umc.h             |    52 +-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c       |   143 +-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h       |     3 -
 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c       |   221 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h       |    70 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c       |   220 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h       |    69 +
 drivers/gpu/drm/amd/ras/core/ta_if.h               |    35 +
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile           |     6 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c  |   191 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h  |    30 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |    38 +
 .../drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c    |   142 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c   |   276 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h   |    31 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |   373 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h   |     8 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c   |   107 +
 .../{amdgpu_ras_mp1_v13_0.h =3D> amdgpu_ras_mp1.h}   |     8 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c |   154 -
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c   |     9 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c   |   100 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |    42 +-
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h          |     9 +-
 .../gpu/drm/arm/display/include/malidp_product.h   |    10 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |    28 +-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |    18 +-
 .../drm/arm/display/komeda/komeda_wb_connector.c   |    35 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |     4 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |    19 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |    18 +-
 drivers/gpu/drm/arm/malidp_planes.c                |    18 +-
 drivers/gpu/drm/armada/armada_crtc.c               |     2 +-
 drivers/gpu/drm/armada/armada_fbdev.c              |     2 +-
 drivers/gpu/drm/armada/armada_overlay.c            |    39 +-
 drivers/gpu/drm/armada/armada_plane.c              |    15 +-
 drivers/gpu/drm/armada/armada_plane.h              |     2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx.h                |    11 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c           |   203 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |     3 +-
 drivers/gpu/drm/ast/ast_dp.c                       |    24 +-
 drivers/gpu/drm/ast/ast_mode.c                     |    20 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |    19 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |    33 +-
 drivers/gpu/drm/bridge/Kconfig                     |    25 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |    22 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |     1 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |   128 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |     4 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |    15 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h  |     4 +
 drivers/gpu/drm/bridge/aux-bridge.c                |     1 +
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |     1 +
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |     1 -
 drivers/gpu/drm/bridge/chipone-icn6211.c           |     8 +-
 drivers/gpu/drm/bridge/fsl-ldb.c                   |    19 +-
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c            |     1 +
 drivers/gpu/drm/bridge/inno-hdmi.c                 |     1 +
 drivers/gpu/drm/bridge/ite-it6263.c                |    33 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |     4 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |    13 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |     3 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |     2 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            |     2 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |    22 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |     2 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |     2 +-
 drivers/gpu/drm/bridge/panel.c                     |   563 -
 drivers/gpu/drm/bridge/samsung-dsim.c              |    28 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |     3 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |     5 +
 drivers/gpu/drm/bridge/ssd2825.c                   |    23 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |     4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |   368 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |     2 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |    11 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |    11 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    68 +-
 drivers/gpu/drm/bridge/tc358768.c                  |    25 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |    79 +-
 drivers/gpu/drm/bridge/ti-tdp158.c                 |     1 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |    17 +-
 drivers/gpu/drm/ci/build.sh                        |     1 -
 drivers/gpu/drm/ci/test.yml                        |    10 -
 .../msm-sc7180-trogdor-lazor-limozeen-fails.txt    |    22 -
 .../msm-sc7180-trogdor-lazor-limozeen-flakes.txt   |    20 -
 .../msm-sc7180-trogdor-lazor-limozeen-skips.txt    |    30 -
 drivers/gpu/drm/clients/Makefile                   |     3 +-
 drivers/gpu/drm/clients/drm_fbdev_client.c         |    25 +-
 .../drm_fbdev_helper.c}                            |    34 +-
 drivers/gpu/drm/clients/drm_log.c                  |    54 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   187 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |     6 +
 drivers/gpu/drm/display/drm_hdmi_helper.c          |   304 +
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |   239 +-
 drivers/gpu/drm/display/drm_scdc_helper.c          |   359 +-
 drivers/gpu/drm/drm_atomic.c                       |    36 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    10 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |    86 -
 drivers/gpu/drm/drm_atomic_uapi.c                  |     7 +
 drivers/gpu/drm/drm_bridge.c                       |    44 +-
 drivers/gpu/drm/drm_bridge_helper.c                |     2 -
 drivers/gpu/drm/drm_buddy.c                        |     3 +-
 drivers/gpu/drm/drm_client_event.c                 |    18 +
 drivers/gpu/drm/drm_colorop.c                      |   107 +
 drivers/gpu/drm/drm_connector.c                    |   155 +-
 drivers/gpu/drm/drm_crtc_helper_internal.h         |     9 +
 drivers/gpu/drm/drm_crtc_internal.h                |     2 -
 drivers/gpu/drm/drm_debugfs.c                      |   157 -
 drivers/gpu/drm/drm_drv.c                          |    34 +-
 drivers/gpu/drm/drm_edid.c                         |   237 +-
 drivers/gpu/drm/drm_fbdev_dma.c                    |     2 +-
 drivers/gpu/drm/drm_fbdev_shmem.c                  |     2 +-
 drivers/gpu/drm/drm_fbdev_ttm.c                    |     2 +-
 drivers/gpu/drm/drm_gem.c                          |    19 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   100 +-
 drivers/gpu/drm/drm_gpusvm.c                       |   465 +-
 drivers/gpu/drm/drm_kms_helper_common.c            |    53 +
 drivers/gpu/drm/drm_mode_config.c                  |    21 +-
 drivers/gpu/drm/drm_modeset_helper.c               |     2 +
 drivers/gpu/drm/drm_of.c                           |    75 +-
 drivers/gpu/drm/drm_pagemap.c                      |    18 +-
 drivers/gpu/drm/drm_panel.c                        |   664 +-
 drivers/gpu/drm/drm_panel_backlight_quirks.c       |     2 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |     2 +-
 drivers/gpu/drm/drm_panic.c                        |   927 +-
 drivers/gpu/drm/drm_panic_helper.c                 |   919 +
 .../{drm_panic_qr.rs =3D> drm_panic_helper_qr.rs}    |     4 +-
 drivers/gpu/drm/drm_panic_internal.h               |    69 +
 drivers/gpu/drm/drm_probe_helper.c                 |    15 +-
 drivers/gpu/drm/drm_ras.c                          |   278 +-
 drivers/gpu/drm/drm_ras_nl.c                       |    33 +
 drivers/gpu/drm/drm_ras_nl.h                       |     8 +
 drivers/gpu/drm/drm_simple_kms_helper.c            |    37 +-
 drivers/gpu/drm/drm_syncobj.c                      |    35 +-
 drivers/gpu/drm/drm_sysfs.c                        |    32 -
 drivers/gpu/drm/drm_timeout.c                      |    95 +
 drivers/gpu/drm/exynos/exynos_dp.c                 |    36 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |     2 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |     3 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |     2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |     3 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |    22 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    15 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |     3 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |     2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |     2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    10 +-
 drivers/gpu/drm/gma500/fbdev.c                     |     2 +-
 drivers/gpu/drm/gma500/psb_intel_display.c         |    34 +-
 drivers/gpu/drm/gud/gud_drv.c                      |     2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |    18 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |     5 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |     9 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |     4 +-
 drivers/gpu/drm/hyperv/hyperv_drm.h                |     1 -
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |     6 +-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c          |    44 +-
 drivers/gpu/drm/i915/Makefile                      |     1 +
 drivers/gpu/drm/i915/display/i9xx_plane.c          |     3 +
 drivers/gpu/drm/i915/display/intel_alpm.c          |   166 +-
 drivers/gpu/drm/i915/display/intel_alpm.h          |     3 +
 drivers/gpu/drm/i915/display/intel_atomic.c        |     1 +
 drivers/gpu/drm/i915/display/intel_audio.c         |   153 +
 drivers/gpu/drm/i915/display/intel_audio_regs.h    |    16 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |   262 +-
 drivers/gpu/drm/i915/display/intel_bios.h          |    14 +
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   326 +-
 drivers/gpu/drm/i915/display/intel_cmtg.c          |     2 +-
 drivers/gpu/drm/i915/display/intel_color.c         |    76 +-
 .../gpu/drm/i915/display/intel_color_pipeline.c    |    34 +-
 .../gpu/drm/i915/display/intel_crtc_state_dump.c   |    12 +
 drivers/gpu/drm/i915/display/intel_cursor.c        |   296 +-
 drivers/gpu/drm/i915/display/intel_cursor_regs.h   |     8 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |     5 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |    73 +-
 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c |    90 +-
 drivers/gpu/drm/i915/display/intel_dip.c           |   215 +
 drivers/gpu/drm/i915/display/intel_dip.h           |    53 +
 drivers/gpu/drm/i915/display/intel_dip_regs.h      |    38 +
 drivers/gpu/drm/i915/display/intel_display.c       |   136 +-
 drivers/gpu/drm/i915/display/intel_display.h       |     3 +-
 .../drm/i915/display/intel_display_clock_gating.c  |    67 +-
 .../drm/i915/display/intel_display_clock_gating.h  |    16 +-
 drivers/gpu/drm/i915/display/intel_display_core.h  |     7 +
 .../gpu/drm/i915/display/intel_display_debugfs.c   |    21 +-
 drivers/gpu/drm/i915/display/intel_display_irq.c   |    18 +-
 .../gpu/drm/i915/display/intel_display_limits.h    |     1 +
 .../gpu/drm/i915/display/intel_display_params.h    |     5 +
 drivers/gpu/drm/i915/display/intel_display_power.c |     9 +
 .../gpu/drm/i915/display/intel_display_power_map.c |    42 +-
 .../drm/i915/display/intel_display_power_well.c    |     6 +-
 drivers/gpu/drm/i915/display/intel_display_regs.h  |    18 +-
 drivers/gpu/drm/i915/display/intel_display_rpm.c   |     7 +
 drivers/gpu/drm/i915/display/intel_display_rpm.h   |     1 +
 drivers/gpu/drm/i915/display/intel_display_types.h |    41 +-
 drivers/gpu/drm/i915/display/intel_display_wa.c    |     4 +-
 drivers/gpu/drm/i915/display/intel_display_wa.h    |     9 -
 drivers/gpu/drm/i915/display/intel_dp.c            |   331 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |    78 +-
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c       |   176 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |    54 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |     6 +-
 drivers/gpu/drm/i915/display/intel_dp_test.c       |    77 +-
 drivers/gpu/drm/i915/display/intel_dpll.c          |    22 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   221 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |    22 +
 drivers/gpu/drm/i915/display/intel_fb.c            |    20 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |    12 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |     2 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |     3 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |    53 +-
 drivers/gpu/drm/i915/display/intel_hdmi.h          |    11 +-
 drivers/gpu/drm/i915/display/intel_hotplug.c       |     5 +
 drivers/gpu/drm/i915/display/intel_hti.c           |     3 -
 drivers/gpu/drm/i915/display/intel_lspcon.c        |    82 +-
 .../gpu/drm/i915/display/intel_modeset_verify.c    |     1 -
 drivers/gpu/drm/i915/display/intel_parent.c        |    14 +-
 drivers/gpu/drm/i915/display/intel_parent.h        |     9 +-
 drivers/gpu/drm/i915/display/intel_plane.c         |    53 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |    86 +-
 drivers/gpu/drm/i915/display/intel_psr_regs.h      |     2 +
 drivers/gpu/drm/i915/display/intel_snps_phy.c      |    60 +-
 drivers/gpu/drm/i915/display/intel_snps_phy.h      |     2 +
 drivers/gpu/drm/i915/display/intel_tdf.h           |    25 -
 drivers/gpu/drm/i915/display/intel_vga.c           |     7 +-
 drivers/gpu/drm/i915/display/intel_vrr.c           |   409 +-
 drivers/gpu/drm/i915/display/intel_vrr.h           |     2 +
 drivers/gpu/drm/i915/display/intel_vrr_regs.h      |     6 -
 drivers/gpu/drm/i915/display/skl_universal_plane.c |    61 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |     4 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |    14 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |    10 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c           |    17 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |     4 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |     2 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |    17 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |     8 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |     3 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c       |     8 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |     2 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c             |     4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             |     2 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |     4 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |     2 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |    22 +-
 drivers/gpu/drm/i915/i915_dpt.c                    |     3 -
 drivers/gpu/drm/i915/i915_drv.h                    |     2 -
 drivers/gpu/drm/i915/i915_fb_pin.c                 |     6 -
 drivers/gpu/drm/i915/i915_gem.c                    |     6 +-
 drivers/gpu/drm/i915/i915_gem.h                    |     6 +-
 drivers/gpu/drm/i915/i915_gtt_view_types.h         |    74 -
 drivers/gpu/drm/i915/i915_overlay.c                |     5 -
 drivers/gpu/drm/i915/i915_reg.h                    |     2 +-
 drivers/gpu/drm/i915/i915_request.c                |     2 -
 drivers/gpu/drm/i915/i915_switcheroo.c             |    11 +-
 drivers/gpu/drm/i915/i915_vma.c                    |    44 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    12 +-
 drivers/gpu/drm/i915/i915_vma_types.h              |    29 +-
 drivers/gpu/drm/i915/intel_clock_gating.c          |    30 +-
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c        |     2 +-
 drivers/gpu/drm/i915/intel_pcode.c                 |    14 +-
 drivers/gpu/drm/i915/intel_pcode.h                 |     2 +-
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c     |     2 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |    60 +-
 drivers/gpu/drm/i915/selftests/igt_atomic.c        |     7 +
 drivers/gpu/drm/i915/vlv_iosf_sb.c                 |     6 +-
 drivers/gpu/drm/imagination/pvr_ccb.c              |    43 +-
 drivers/gpu/drm/imagination/pvr_device.c           |    25 +-
 drivers/gpu/drm/imagination/pvr_fw.c               |   153 +-
 drivers/gpu/drm/imagination/pvr_fw.h               |    20 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.c          |    18 +-
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |    40 +-
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |    22 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c         |     1 -
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h    |   920 +-
 drivers/gpu/drm/imagination/pvr_rogue_defs.h       |    22 +-
 drivers/gpu/drm/imagination/pvr_rogue_riscv.h      |     2 -
 drivers/gpu/drm/imagination/pvr_trace.h            |    14 +-
 drivers/gpu/drm/imx/dc/dc-crtc.c                   |     2 +-
 drivers/gpu/drm/imx/dc/dc-kms.c                    |     9 +-
 drivers/gpu/drm/imx/dc/dc-plane.c                  |     2 +-
 drivers/gpu/drm/imx/dcss/Kconfig                   |     1 +
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               |     2 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c              |     2 +-
 drivers/gpu/drm/imx/ipuv3/imx-tve.c                |     2 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c             |    18 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            |    21 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                |   261 +-
 drivers/gpu/drm/ingenic/Kconfig                    |     1 +
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |     4 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |     2 +-
 drivers/gpu/drm/kmb/kmb_crtc.c                     |     2 +-
 drivers/gpu/drm/kmb/kmb_dsi.c                      |     9 +-
 drivers/gpu/drm/kmb/kmb_plane.c                    |     2 +-
 drivers/gpu/drm/lima/lima_gem.c                    |     2 +-
 drivers/gpu/drm/logicvc/Kconfig                    |     1 +
 drivers/gpu/drm/logicvc/logicvc_crtc.c             |     2 +-
 drivers/gpu/drm/logicvc/logicvc_layer.c            |     2 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c               |    30 +-
 drivers/gpu/drm/loongson/lsdc_drv.c                |     4 +-
 drivers/gpu/drm/loongson/lsdc_plane.c              |     2 +-
 drivers/gpu/drm/mcde/Kconfig                       |     2 +-
 drivers/gpu/drm/mcde/mcde_display.c                |   273 +-
 drivers/gpu/drm/mcde/mcde_drm.h                    |    12 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |     3 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |    51 +-
 drivers/gpu/drm/mediatek/mtk_crtc.c                |    18 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    10 +-
 drivers/gpu/drm/mediatek/mtk_plane.c               |    21 +-
 drivers/gpu/drm/meson/meson_crtc.c                 |     2 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |    11 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |    11 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |    11 +-
 drivers/gpu/drm/meson/meson_overlay.c              |     2 +-
 drivers/gpu/drm/meson/meson_plane.c                |     2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |     8 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |    15 +-
 drivers/gpu/drm/msm/Makefile                       |     2 +
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |    18 +
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |    30 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    76 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |     2 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  1440 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   231 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |     1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |    42 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |    17 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |    96 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |     1 +
 drivers/gpu/drm/msm/adreno/a7xx_catalog.c          |   502 +
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c          |  1846 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |    21 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |     6 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |     3 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |    35 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |    17 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |    10 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |     4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |     2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    18 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |     2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |    14 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |     2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |    81 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |    20 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |    16 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   164 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |     8 +-
 drivers/gpu/drm/msm/dp/dp_debug.c                  |     1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   116 +-
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   191 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |    17 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |    56 +
 drivers/gpu/drm/msm/dsi/dsi.c                      |     3 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |     2 +
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |     2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |    34 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                |    16 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |     2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |    89 +-
 drivers/gpu/drm/msm/msm_drv.h                      |     6 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |     2 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   107 +-
 drivers/gpu/drm/msm/msm_gem.h                      |    10 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |     9 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |    31 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |     8 +-
 drivers/gpu/drm/msm/msm_io_utils.c                 |     6 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |    15 +
 drivers/gpu/drm/msm/registers/adreno/a2xx.xml      |    25 +-
 drivers/gpu/drm/msm/registers/adreno/a5xx.xml      |    17 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |    89 +-
 .../gpu/drm/msm/registers/adreno/adreno_pm4.xml    |    41 +-
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  |    19 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |    43 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |     2 +
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |    18 +-
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |     5 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |     5 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            |    14 +-
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c        |    21 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |    17 +-
 .../gpu/drm/nouveau/include/nvhw/class/clca7d.h    |     4 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h  |     1 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |     6 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |    32 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.h             |    10 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c             |     2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   152 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h        |    12 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c               |     6 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   114 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c             |     2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |     2 +-
 drivers/gpu/drm/nouveau/nouveau_led.c              |     2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c              |    13 +
 drivers/gpu/drm/nouveau/nouveau_vga.c              |    34 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c    |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild     |     1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c    |    35 +
 drivers/gpu/drm/nova/driver.rs                     |    37 +-
 drivers/gpu/drm/nova/file.rs                       |   129 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |   361 +-
 drivers/gpu/drm/omapdrm/dss/hdmi.h                 |     6 +
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |    29 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |    37 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_common.c          |    14 +
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |     1 -
 drivers/gpu/drm/omapdrm/dss/output.c               |    42 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |    17 +-
 drivers/gpu/drm/omapdrm/omap_debugfs.c             |     2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |     1 -
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |     2 +-
 drivers/gpu/drm/omapdrm/omap_plane.c               |    13 +-
 drivers/gpu/drm/panel/Kconfig                      |    54 +-
 drivers/gpu/drm/panel/Makefile                     |     4 +
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c          |    23 +-
 drivers/gpu/drm/panel/panel-edp.c                  |    10 +
 drivers/gpu/drm/panel/panel-himax-hx83102.c        |    24 +-
 drivers/gpu/drm/panel/panel-himax-hx83112a.c       |    26 +-
 drivers/gpu/drm/panel/panel-himax-hx83112b.c       |    23 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c         |    26 +-
 drivers/gpu/drm/panel/panel-ilitek-ili7836a.c      |   297 +
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c       |    21 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c |    12 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h |     1 -
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c  |    16 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c  |     6 -
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |    15 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c      |   258 +-
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c       |    19 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |    32 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c |    20 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c |    20 +-
 drivers/gpu/drm/panel/panel-novatek-nt36532.c      |   431 +
 drivers/gpu/drm/panel/panel-novatek-nt51021.c      |   875 +
 drivers/gpu/drm/panel/panel-raydium-rm69220.c      |   417 +
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |    14 +-
 drivers/gpu/drm/panel/panel-samsung-dsi.h          |    38 +
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |    74 +-
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c      |    20 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c      |    20 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c   |    91 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      |    30 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      |    90 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   |    31 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c  |    13 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c  |     6 -
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |    12 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.h      |     1 -
 .../drm/panel/panel-samsung-s6e88a0-ams427ap24.c   |    20 +-
 .../drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |    26 +-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |    19 +-
 .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  |    46 +-
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      |    35 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |    31 +-
 drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c    |    20 +-
 drivers/gpu/drm/panel/panel-simple.c               |    60 +
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c      |    20 +-
 .../gpu/drm/panel/panel-sony-tulip-truly-nt35521.c |    20 +-
 drivers/gpu/drm/panel/panel-visionox-r66451.c      |    23 +-
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |    21 +-
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c    |   221 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |     2 +-
 drivers/gpu/drm/panfrost/panfrost_device.c         |   292 +-
 drivers/gpu/drm/panfrost/panfrost_device.h         |     5 +
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   202 +-
 drivers/gpu/drm/panfrost/panfrost_drv.h            |     9 -
 drivers/gpu/drm/panfrost/panfrost_features.h       |     2 +
 drivers/gpu/drm/panfrost/panfrost_gem.c            |    64 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h            |    10 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c   |     9 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |     5 +
 drivers/gpu/drm/panfrost/panfrost_issues.h         |     8 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |   103 +-
 drivers/gpu/drm/panfrost/panfrost_job.h            |     4 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |    14 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |   321 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h        |     1 +
 drivers/gpu/drm/panthor/panthor_device.h           |   286 +-
 drivers/gpu/drm/panthor/panthor_drv.c              |     8 +-
 drivers/gpu/drm/panthor/panthor_fw.c               |    22 +-
 drivers/gpu/drm/panthor/panthor_gem.c              |    17 +-
 drivers/gpu/drm/panthor/panthor_gpu.c              |   117 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |    44 +-
 drivers/gpu/drm/panthor/panthor_mmu.h              |     3 +-
 drivers/gpu/drm/panthor/panthor_pwr.c              |    24 +-
 drivers/gpu/drm/panthor/panthor_sched.c            |   608 +-
 drivers/gpu/drm/panthor/panthor_sched.h            |     5 +
 drivers/gpu/drm/panthor/panthor_trace.h            |    38 +
 drivers/gpu/drm/pl111/Kconfig                      |     1 +
 drivers/gpu/drm/pl111/pl111_display.c              |   207 +-
 drivers/gpu/drm/pl111/pl111_drm.h                  |     5 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |    19 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |    18 -
 drivers/gpu/drm/qxl/qxl_display.c                  |     6 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |    36 +
 drivers/gpu/drm/radeon/radeon_combios.c            |    51 +
 drivers/gpu/drm/radeon/radeon_device.c             |    20 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c              |     2 +-
 drivers/gpu/drm/radeon/radeon_fence.c              |     4 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |     3 +-
 drivers/gpu/drm/renesas/rcar-du/Kconfig            |    12 +
 drivers/gpu/drm/renesas/rcar-du/Makefile           |     1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c         |   153 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     |    17 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |    17 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c    |    19 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      |    17 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |    51 +-
 drivers/gpu/drm/renesas/rz-du/Kconfig              |    13 +
 drivers/gpu/drm/renesas/rz-du/Makefile             |     1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c      |    15 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c       |    24 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h       |     3 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c   |    24 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c       |    15 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |   162 +-
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c         |   275 +
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h    |    25 +
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |    17 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c |    19 +-
 drivers/gpu/drm/rockchip/Kconfig                   |     2 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |    11 -
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |    66 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |   205 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |    10 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |     2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    20 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |    20 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |    61 +-
 drivers/gpu/drm/scheduler/sched_fence.c            |     3 +-
 drivers/gpu/drm/scheduler/sched_internal.h         |     3 +-
 drivers/gpu/drm/scheduler/sched_main.c             |    14 +-
 drivers/gpu/drm/scheduler/tests/tests_basic.c      |     2 +-
 drivers/gpu/drm/sitronix/st7571.c                  |     3 +-
 drivers/gpu/drm/sitronix/st7920.c                  |    24 +-
 drivers/gpu/drm/solomon/ssd130x-spi.c              |    25 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |   475 +-
 drivers/gpu/drm/solomon/ssd130x.h                  |    10 +-
 drivers/gpu/drm/sprd/sprd_dpu.c                    |     4 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |     2 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |     2 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |     2 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |     2 +-
 drivers/gpu/drm/stm/Kconfig                        |     1 +
 drivers/gpu/drm/stm/ltdc.c                         |     6 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |     2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    24 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |    21 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |     2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |     2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |    14 +-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          |    70 +-
 drivers/gpu/drm/sysfb/efidrm.c                     |    17 +-
 drivers/gpu/drm/sysfb/ofdrm.c                      |    18 +-
 drivers/gpu/drm/sysfb/vesadrm.c                    |    18 +-
 drivers/gpu/drm/tegra/dc.c                         |    18 +-
 drivers/gpu/drm/tegra/dsi.c                        |    16 +-
 drivers/gpu/drm/tegra/fbdev.c                      |     2 +-
 drivers/gpu/drm/tegra/plane.c                      |    28 +-
 drivers/gpu/drm/tegra/rgb.c                        |    16 +-
 drivers/gpu/drm/tegra/submit.c                     |   145 +-
 drivers/gpu/drm/tegra/uapi.c                       |    51 +-
 drivers/gpu/drm/tegra/uapi.h                       |     3 +-
 drivers/gpu/drm/tests/Makefile                     |     1 +
 drivers/gpu/drm/tests/drm_connector_test.c         |    42 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |    56 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |     4 +-
 .../{drm_panic_test.c =3D> drm_panic_helper_test.c}  |    75 +-
 drivers/gpu/drm/tidss/Kconfig                      |     1 +
 drivers/gpu/drm/tidss/tidss_dispc.c                |    38 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |     2 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |    10 +-
 drivers/gpu/drm/tidss/tidss_plane.c                |     2 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |     7 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |     2 +-
 drivers/gpu/drm/tiny/appletbdrm.c                  |    64 +-
 drivers/gpu/drm/tiny/arcpgu.c                      |   201 +-
 drivers/gpu/drm/tiny/bochs.c                       |     6 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |     2 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |   138 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |     2 +-
 drivers/gpu/drm/tiny/repaper.c                     |   138 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |     2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |     3 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    11 +-
 drivers/gpu/drm/ttm/ttm_module.c                   |     1 -
 drivers/gpu/drm/tve200/Kconfig                     |     2 +-
 drivers/gpu/drm/tve200/tve200_display.c            |   220 +-
 drivers/gpu/drm/tve200/tve200_drm.h                |     7 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |    41 +-
 drivers/gpu/drm/tyr/driver.rs                      |   114 +-
 drivers/gpu/drm/tyr/fw.rs                          |     7 +-
 drivers/gpu/drm/tyr/gpu.rs                         |     6 +-
 drivers/gpu/drm/tyr/regs.rs                        |    57 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |     2 +-
 drivers/gpu/drm/v3d/v3d_bo.c                       |     3 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |    32 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |     3 -
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |    13 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |     4 -
 drivers/gpu/drm/v3d/v3d_submit.c                   |    19 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |     6 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c          |     2 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c        |     2 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |     3 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |    14 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    29 -
 drivers/gpu/drm/vc4/vc4_drv.h                      |    15 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |    43 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |     5 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |    10 +
 drivers/gpu/drm/vc4/vc4_irq.c                      |     7 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |    15 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |     4 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |    44 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c            |    11 +-
 drivers/gpu/drm/verisilicon/vs_bridge.h            |     1 -
 drivers/gpu/drm/verisilicon/vs_crtc.c              |     2 +-
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |    10 +-
 drivers/gpu/drm/verisilicon/vs_plane.c             |    34 +-
 drivers/gpu/drm/verisilicon/vs_plane.h             |     4 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |     9 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |    14 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |    15 +-
 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py   |    87 +
 drivers/gpu/drm/vkms/tests/vkms_format_test.c      |    40 +-
 drivers/gpu/drm/vkms/vkms_colorop.c                |    66 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |    36 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    18 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |     2 +-
 drivers/gpu/drm/vkms/vkms_formats.c                |   112 +-
 drivers/gpu/drm/vkms/vkms_formats.h                |     2 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |    91 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    39 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |     6 +-
 drivers/gpu/drm/xe/Makefile                        |     6 +-
 drivers/gpu/drm/xe/abi/guc_actions_slpc_abi.h      |     1 +
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |     1 +
 drivers/gpu/drm/xe/abi/xe_log_abi.h                |   200 +
 drivers/gpu/drm/xe/abi/xe_sigid_abi.h              |   172 +
 .../gpu/drm/xe/compat-i915-headers/i915_config.h   |    16 -
 .../xe/compat-i915-headers/i915_gtt_view_types.h   |     7 -
 drivers/gpu/drm/xe/display/xe_display.c            |    32 +-
 drivers/gpu/drm/xe/display/xe_display_pcode.c      |     4 +-
 drivers/gpu/drm/xe/display/xe_display_rpm.c        |     8 +-
 drivers/gpu/drm/xe/display/xe_display_wa.c         |    13 +-
 drivers/gpu/drm/xe/display/xe_display_wa.h         |     9 +
 drivers/gpu/drm/xe/display/xe_dsb_buffer.c         |     2 +-
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |    30 +-
 drivers/gpu/drm/xe/display/xe_panic.c              |     3 +-
 drivers/gpu/drm/xe/display/xe_tdf.c                |    15 -
 drivers/gpu/drm/xe/instructions/xe_mi_commands.h   |     7 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |    36 +-
 drivers/gpu/drm/xe/regs/xe_lrc_layout.h            |     2 +
 drivers/gpu/drm/xe/regs/xe_regs.h                  |     2 +
 drivers/gpu/drm/xe/tests/Makefile                  |     1 +
 drivers/gpu/drm/xe/tests/xe_any_kunit.c            |   213 +
 .../gpu/drm/xe/tests/xe_guc_klv_helpers_kunit.c    |   303 +
 drivers/gpu/drm/xe/tests/xe_kunit_helpers.c        |     4 +
 drivers/gpu/drm/xe/tests/xe_log_kunit.c            |   553 +
 drivers/gpu/drm/xe/tests/xe_pci.c                  |    25 +-
 drivers/gpu/drm/xe/xe_any.h                        |   137 +
 drivers/gpu/drm/xe/xe_bo.c                         |    80 +-
 drivers/gpu/drm/xe/xe_bo.h                         |    13 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |    10 +-
 drivers/gpu/drm/xe/xe_configfs.c                   |   139 +-
 drivers/gpu/drm/xe/xe_configfs.h                   |     4 +
 drivers/gpu/drm/xe/xe_cpu_bind.c                   |   296 +
 drivers/gpu/drm/xe/xe_cpu_bind.h                   |   111 +
 drivers/gpu/drm/xe/xe_debugfs.c                    |    66 +
 drivers/gpu/drm/xe/xe_debugfs.h                    |     4 +
 drivers/gpu/drm/xe/xe_defaults.h                   |     1 +
 drivers/gpu/drm/xe/xe_devcoredump.c                |    50 +-
 drivers/gpu/drm/xe/xe_devcoredump.h                |    15 +-
 drivers/gpu/drm/xe/xe_device.c                     |   164 +-
 drivers/gpu/drm/xe/xe_device.h                     |     2 +-
 drivers/gpu/drm/xe/xe_device_sysfs.c               |    36 +
 drivers/gpu/drm/xe/xe_device_types.h               |    70 +-
 drivers/gpu/drm/xe/xe_dma_buf.c                    |    22 +-
 drivers/gpu/drm/xe/xe_drm_client.c                 |     2 +-
 drivers/gpu/drm/xe/xe_drm_ras.c                    |    65 +
 drivers/gpu/drm/xe/xe_drm_ras.h                    |     3 +
 drivers/gpu/drm/xe/xe_drm_ras_types.h              |     3 +
 drivers/gpu/drm/xe/xe_exec_queue.c                 |   239 +-
 drivers/gpu/drm/xe/xe_exec_queue.h                 |    16 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |    36 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |     4 +-
 drivers/gpu/drm/xe/xe_ggtt.c                       |    74 +-
 drivers/gpu/drm/xe/xe_gsc.c                        |     3 +-
 drivers/gpu/drm/xe/xe_gt.c                         |    24 +-
 drivers/gpu/drm/xe/xe_gt.h                         |    13 +
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                |     6 -
 drivers/gpu/drm/xe/xe_gt_debugfs.c                 |   252 +-
 drivers/gpu/drm/xe/xe_gt_idle.c                    |    84 +-
 drivers/gpu/drm/xe/xe_gt_idle.h                    |     1 +
 drivers/gpu/drm/xe/xe_gt_printk.h                  |     3 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |   299 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h         |    10 +
 drivers/gpu/drm/xe/xe_gt_sriov_printk.h            |     3 +
 drivers/gpu/drm/xe/xe_gt_stats.c                   |     7 +
 drivers/gpu/drm/xe/xe_gt_stats_types.h             |    22 +
 drivers/gpu/drm/xe/xe_gt_types.h                   |    29 +
 drivers/gpu/drm/xe/xe_guc.c                        |    34 +-
 drivers/gpu/drm/xe/xe_guc.h                        |     2 +
 drivers/gpu/drm/xe/xe_guc_ads.c                    |     9 +-
 drivers/gpu/drm/xe/xe_guc_capture.c                |     2 -
 drivers/gpu/drm/xe/xe_guc_ct.c                     |   114 +-
 drivers/gpu/drm/xe/xe_guc_ct.h                     |    38 +-
 drivers/gpu/drm/xe/xe_guc_engine_activity.c        |     6 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |    32 +-
 drivers/gpu/drm/xe/xe_guc_hwconfig.c               |     2 +-
 drivers/gpu/drm/xe/xe_guc_klv_helpers.c            |    78 +
 drivers/gpu/drm/xe/xe_guc_klv_helpers.h            |     5 +
 drivers/gpu/drm/xe/xe_guc_log.c                    |     7 +-
 drivers/gpu/drm/xe/xe_guc_pagefault.c              |    80 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                     |    18 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   472 +-
 drivers/gpu/drm/xe/xe_guc_submit.h                 |     5 +
 drivers/gpu/drm/xe/xe_guc_submit_types.h           |     2 +
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c              |    29 +
 drivers/gpu/drm/xe/xe_guc_types.h                  |     6 +
 drivers/gpu/drm/xe/xe_hwmon.c                      |    95 +-
 drivers/gpu/drm/xe/xe_log.c                        |   247 +
 drivers/gpu/drm/xe/xe_log.h                        |   194 +
 drivers/gpu/drm/xe/xe_lrc.c                        |   112 +-
 drivers/gpu/drm/xe/xe_lrc.h                        |     5 +
 drivers/gpu/drm/xe/xe_lrc_types.h                  |     4 +
 drivers/gpu/drm/xe/xe_mert.c                       |     2 +-
 drivers/gpu/drm/xe/xe_migrate.c                    |   884 +-
 drivers/gpu/drm/xe/xe_migrate.h                    |    95 +-
 drivers/gpu/drm/xe/xe_mmio.c                       |     5 +-
 drivers/gpu/drm/xe/xe_mmio_gem.c                   |     7 +-
 drivers/gpu/drm/xe/xe_module.c                     |     4 +
 drivers/gpu/drm/xe/xe_module.h                     |     1 +
 drivers/gpu/drm/xe/xe_nvm.c                        |     1 +
 drivers/gpu/drm/xe/xe_oa.c                         |     7 +-
 drivers/gpu/drm/xe/xe_pagefault.c                  |   841 +-
 drivers/gpu/drm/xe/xe_pagefault.h                  |   137 +
 drivers/gpu/drm/xe/xe_pagefault_types.h            |   211 +-
 drivers/gpu/drm/xe/xe_pci.c                        |   101 +-
 drivers/gpu/drm/xe/xe_pci_error.c                  |    13 +-
 drivers/gpu/drm/xe/xe_pci_types.h                  |     4 +-
 drivers/gpu/drm/xe/xe_pcode.c                      |    27 +-
 drivers/gpu/drm/xe/xe_pcode.h                      |     6 +-
 drivers/gpu/drm/xe/xe_pm.c                         |    68 +
 drivers/gpu/drm/xe/xe_pm.h                         |     3 +
 drivers/gpu/drm/xe/xe_printk.h                     |     3 +
 drivers/gpu/drm/xe/xe_pt.c                         |   813 +-
 drivers/gpu/drm/xe/xe_pt.h                         |    12 +-
 drivers/gpu/drm/xe/xe_pt_types.h                   |    49 +-
 drivers/gpu/drm/xe/xe_pxp_submit.c                 |     5 +-
 drivers/gpu/drm/xe/xe_ras.c                        |   245 +-
 drivers/gpu/drm/xe/xe_ras.h                        |     2 +
 drivers/gpu/drm/xe/xe_ras_types.h                  |    50 +
 drivers/gpu/drm/xe/xe_res_cursor.h                 |     5 +-
 drivers/gpu/drm/xe/xe_ring_ops.c                   |    90 +-
 drivers/gpu/drm/xe/xe_ring_ops_types.h             |    24 +
 drivers/gpu/drm/xe/xe_sched_job.c                  |   101 +-
 drivers/gpu/drm/xe/xe_sched_job.h                  |    56 +
 drivers/gpu/drm/xe/xe_sched_job_types.h            |    49 +-
 drivers/gpu/drm/xe/xe_sriov_packet.c               |    31 +-
 drivers/gpu/drm/xe/xe_sriov_pf_provision.c         |     4 +-
 drivers/gpu/drm/xe/xe_sriov_printk.h               |     3 +
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c               |     1 -
 drivers/gpu/drm/xe/xe_survivability_mode.c         |    85 +-
 drivers/gpu/drm/xe/xe_svm.c                        |   250 +-
 drivers/gpu/drm/xe/xe_svm.h                        |    97 +-
 drivers/gpu/drm/xe/xe_sync.c                       |    20 +-
 drivers/gpu/drm/xe/xe_sysctrl.c                    |    92 +
 drivers/gpu/drm/xe/xe_sysctrl.h                    |     2 +
 drivers/gpu/drm/xe/xe_sysctrl_event.c              |    28 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c            |     7 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |    52 +
 drivers/gpu/drm/xe/xe_tile_printk.h                |     3 +
 drivers/gpu/drm/xe/xe_tile_sriov_printk.h          |     3 +
 drivers/gpu/drm/xe/xe_tile_types.h                 |     4 +
 drivers/gpu/drm/xe/xe_tlb_inval.c                  |    96 +-
 drivers/gpu/drm/xe/xe_tlb_inval.h                  |     1 +
 drivers/gpu/drm/xe/xe_tlb_inval_job.c              |    28 +-
 drivers/gpu/drm/xe/xe_tlb_inval_job.h              |     4 +-
 drivers/gpu/drm/xe/xe_tlb_inval_types.h            |    27 +
 drivers/gpu/drm/xe/xe_trace.h                      |     2 +-
 drivers/gpu/drm/xe/xe_trace_bo.h                   |    58 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               |   600 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h               |     3 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h         |    40 +
 drivers/gpu/drm/xe/xe_tuning.c                     |     4 +
 drivers/gpu/drm/xe/xe_uc_fw.c                      |     1 +
 drivers/gpu/drm/xe/xe_userptr.c                    |    21 +-
 drivers/gpu/drm/xe/xe_vm.c                         |   570 +-
 drivers/gpu/drm/xe/xe_vm.h                         |     3 +
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |     6 -
 drivers/gpu/drm/xe/xe_vm_types.h                   |    56 +-
 drivers/gpu/drm/xe/xe_vram.c                       |   255 +-
 drivers/gpu/drm/xe/xe_vram.h                       |    10 +
 drivers/gpu/drm/xe/xe_wa.c                         |     4 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |     2 +
 drivers/gpu/drm/xe/xe_wait_user_fence.c            |     2 +-
 drivers/gpu/drm/xen/xen_drm_front.h                |     6 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |   188 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |    18 +-
 drivers/gpu/host1x/channel.c                       |     6 +-
 drivers/gpu/host1x/context.c                       |   383 +-
 drivers/gpu/host1x/context.h                       |    18 +-
 drivers/gpu/host1x/dev.c                           |    52 +-
 drivers/gpu/host1x/dev.h                           |     3 +
 drivers/gpu/host1x/fence.c                         |    43 +
 drivers/gpu/host1x/hw/cdma_hw.c                    |     3 +
 drivers/gpu/host1x/hw/channel_hw.c                 |     3 +-
 drivers/gpu/host1x/hw/debug_hw_1x06.c              |     3 +
 drivers/gpu/host1x/syncpt.c                        |    21 +-
 drivers/gpu/nova-core/Kconfig                      |    15 +
 drivers/gpu/nova-core/api.rs                       |    73 +
 drivers/gpu/nova-core/driver.rs                    |   125 +-
 drivers/gpu/nova-core/falcon.rs                    |   164 +-
 drivers/gpu/nova-core/falcon/fsp.rs                |    67 +-
 drivers/gpu/nova-core/falcon/gsp.rs                |    98 +-
 drivers/gpu/nova-core/falcon/hal.rs                |    22 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |    76 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |    55 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |    37 +-
 drivers/gpu/nova-core/fb.rs                        |    22 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |    59 +-
 drivers/gpu/nova-core/fb/regs.rs                   |    34 +-
 drivers/gpu/nova-core/firmware.rs                  |     3 +-
 drivers/gpu/nova-core/firmware/booter.rs           |     2 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |    30 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |   119 +-
 .../gpu/nova-core/firmware/{fsp.rs =3D> gsp_fmc.rs}  |    59 +-
 drivers/gpu/nova-core/firmware/radix3.rs           |   144 +
 drivers/gpu/nova-core/firmware/riscv.rs            |     8 +-
 drivers/gpu/nova-core/fsp.rs                       |    45 +-
 drivers/gpu/nova-core/gpu.rs                       |   354 +-
 drivers/gpu/nova-core/gpu/regs.rs                  |    86 +
 drivers/gpu/nova-core/gsp.rs                       |    39 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |    26 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   264 +-
 drivers/gpu/nova-core/gsp/cmdq/continuation.rs     |     6 +-
 drivers/gpu/nova-core/gsp/commands.rs              |    48 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |    18 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs           |    28 +
 drivers/gpu/nova-core/gsp/hal.rs                   |    16 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs             |    16 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |    41 +-
 drivers/gpu/nova-core/gsp/regs.rs                  |     9 +-
 drivers/gpu/nova-core/gsp/sequencer.rs             |    14 +-
 drivers/gpu/nova-core/irq.rs                       |    29 +
 drivers/gpu/nova-core/irq/doorbell_test.rs         |   251 +
 drivers/gpu/nova-core/irq/gsp.rs                   |   195 +
 drivers/gpu/nova-core/irq/hal.rs                   |    67 +
 drivers/gpu/nova-core/irq/hal/gh100.rs             |    40 +
 drivers/gpu/nova-core/irq/hal/tu102.rs             |    43 +
 drivers/gpu/nova-core/irq/interrupt_tree.rs        |   682 +
 drivers/gpu/nova-core/irq/regs.rs                  |    88 +
 drivers/gpu/nova-core/mctp.rs                      |    16 +-
 drivers/gpu/nova-core/mm.rs                        |   335 +
 drivers/gpu/nova-core/mm/bar_user.rs               |   420 +
 drivers/gpu/nova-core/mm/hal.rs                    |    56 +
 drivers/gpu/nova-core/mm/hal/gb100.rs              |    35 +
 drivers/gpu/nova-core/mm/hal/gh100.rs              |    35 +
 drivers/gpu/nova-core/mm/hal/tu102.rs              |    37 +
 drivers/gpu/nova-core/mm/pagetable.rs              |   424 +
 drivers/gpu/nova-core/mm/pagetable/map.rs          |   345 +
 drivers/gpu/nova-core/mm/pagetable/ver2.rs         |   275 +
 drivers/gpu/nova-core/mm/pagetable/ver3.rs         |   421 +
 drivers/gpu/nova-core/mm/pagetable/walk.rs         |   244 +
 drivers/gpu/nova-core/mm/pramin.rs                 |   312 +
 drivers/gpu/nova-core/mm/regs.rs                   |    70 +
 drivers/gpu/nova-core/mm/tlb.rs                    |   120 +
 drivers/gpu/nova-core/mm/vmm.rs                    |   346 +
 drivers/gpu/nova-core/nova_core.rs                 |     5 +
 drivers/gpu/nova-core/num.rs                       |     2 +-
 drivers/gpu/nova-core/regs.rs                      |   326 +-
 drivers/gpu/nova-core/selftest.rs                  |    64 +
 drivers/gpu/nova-core/vbios.rs                     |    11 +-
 drivers/gpu/tests/gpu_buddy_test.c                 |   160 +-
 drivers/gpu/vga/vga_switcheroo.c                   |    41 +-
 drivers/pci/vgaarb.c                               |    13 +-
 drivers/soc/qcom/Kconfig                           |     1 -
 drivers/soc/qcom/apr.c                             |    75 +-
 drivers/soc/qcom/llcc-qcom.c                       |    60 +-
 drivers/soc/qcom/pmic_glink_altmode.c              |     4 +-
 drivers/soc/qcom/qcom-geni-se.c                    |    49 +-
 drivers/soc/qcom/qcom_aoss.c                       |     4 +-
 drivers/soc/qcom/rpmh-internal.h                   |    16 +-
 drivers/soc/qcom/rpmh-rsc.c                        |     4 +-
 drivers/soc/qcom/rpmh.c                            |    40 +-
 drivers/soc/qcom/smem_dramc.c                      |    81 +-
 drivers/soc/qcom/smp2p.c                           |    12 +-
 drivers/soc/qcom/smsm.c                            |    20 +-
 drivers/soc/qcom/socinfo.c                         |     1 +
 drivers/soc/qcom/ubwc_config.c                     |    10 +
 drivers/vfio/pci/vfio_pci_core.c                   |     9 +-
 drivers/video/fbdev/core/fbcon.c                   |     8 -
 drivers/video/fbdev/efifb.c                        |     2 +-
 include/drm/bridge/analogix_dp.h                   |     1 -
 include/drm/bridge/dw_hdmi_qp.h                    |     4 +-
 .../drm_fbdev_helper.h}                            |     4 +-
 include/drm/display/drm_dp.h                       |     1 +
 include/drm/display/drm_dp_helper.h                |     6 +
 include/drm/display/drm_hdmi_helper.h              |    15 +
 include/drm/display/drm_hdmi_state_helper.h        |    11 +-
 include/drm/display/drm_scdc.h                     |    21 +-
 include/drm/display/drm_scdc_helper.h              |   105 +-
 include/drm/drm_atomic.h                           |    89 +-
 include/drm/drm_atomic_state_helper.h              |     6 -
 include/drm/drm_bridge.h                           |   103 +-
 include/drm/drm_client.h                           |    14 +
 include/drm/drm_client_event.h                     |     3 +
 include/drm/drm_colorop.h                          |   127 +
 include/drm/drm_connector.h                        |   216 +-
 include/drm/drm_crtc.h                             |    12 -
 include/drm/drm_device.h                           |     1 +
 include/drm/drm_edid.h                             |     2 +
 include/drm/drm_gem.h                              |    14 +-
 include/drm/drm_gem_atomic_helper.h                |    13 +-
 include/drm/drm_gpusvm.h                           |    77 +-
 include/drm/drm_mipi_dbi.h                         |     2 +-
 include/drm/drm_mode_config.h                      |     4 +-
 include/drm/drm_modeset_helper_vtables.h           |    53 +-
 include/drm/drm_of.h                               |    15 +-
 include/drm/drm_pagemap.h                          |     7 +
 include/drm/drm_panel.h                            |    99 +-
 include/drm/{drm_utils.h =3D> drm_panel_quirks.h}    |    10 +-
 include/drm/drm_panic.h                            |   117 +-
 include/drm/drm_panic_helper.h                     |    41 +
 include/drm/drm_plane.h                            |    69 +-
 include/drm/drm_print.h                            |     3 +
 include/drm/drm_ras.h                              |    34 +
 include/drm/drm_simple_kms_helper.h                |     7 +-
 include/drm/drm_sysfs.h                            |     4 -
 include/drm/drm_timeout.h                          |    17 +
 include/drm/gpu_scheduler.h                        |    10 +-
 include/drm/intel/display_parent_interface.h       |    24 +-
 include/drm/intel/gtt_view_types.h                 |    79 +
 include/drm/intel/pciids.h                         |     1 +
 include/drm/ttm/ttm_resource.h                     |     2 +-
 include/dt-bindings/arm/qcom,ids.h                 |     1 +
 .../dt-bindings/clock/qcom,eliza-cambistmclkcc.h   |    32 +
 include/dt-bindings/clock/qcom,eliza-camcc.h       |   151 +
 include/dt-bindings/clock/qcom,eliza-gpucc.h       |    51 +
 include/dt-bindings/clock/qcom,eliza-videocc.h     |    37 +
 include/linux/device-id/apr.h                      |    21 -
 include/linux/dma-fence.h                          |     2 +-
 include/linux/gpu_buddy.h                          |   101 +-
 include/linux/hdmi.h                               |    12 +
 include/linux/host1x.h                             |    53 +-
 include/linux/mod_devicetable.h                    |     1 -
 include/linux/soc/qcom/apr.h                       |     4 +-
 include/linux/soc/qcom/llcc-qcom.h                 |     4 +
 include/linux/soc/qcom/ubwc.h                      |     3 +
 include/linux/vga_switcheroo.h                     |    29 +-
 include/linux/vgaarb.h                             |     8 +-
 include/sound/omap-hdmi-audio.h                    |     1 +
 include/uapi/drm/amdgpu_drm.h                      |    43 +
 include/uapi/drm/drm_fourcc.h                      |    24 +
 include/uapi/drm/drm_mode.h                        |    12 +
 include/uapi/drm/drm_ras.h                         |    18 +
 include/uapi/drm/ivpu_accel.h                      |    17 +-
 include/uapi/drm/nova_drm.h                        |   146 +-
 include/uapi/drm/panfrost_drm.h                    |    29 +-
 include/uapi/drm/tegra_drm.h                       |     4 +-
 include/uapi/drm/xe_drm.h                          |    22 +-
 kernel/cgroup/dmem.c                               |     4 +-
 rust/bindings/bindings_helper.h                    |     5 +-
 rust/helpers/dma_fence.c                           |    49 +
 rust/helpers/helpers.c                             |     1 +
 rust/helpers/pci.c                                 |     6 +
 rust/kernel/auxiliary.rs                           |    17 +-
 rust/kernel/bitfield.rs                            |     9 +
 rust/kernel/debugfs.rs                             |    26 +-
 rust/kernel/debugfs/entry.rs                       |     4 +-
 rust/kernel/debugfs/file_ops.rs                    |    29 +-
 rust/kernel/device_id.rs                           |     3 +-
 rust/kernel/dma.rs                                 |   141 +-
 rust/kernel/dma_buf/dma_fence.rs                   |  1022 +
 rust/kernel/dma_buf/mod.rs                         |    14 +
 rust/kernel/drm/driver.rs                          |    75 +-
 rust/kernel/drm/gem/mod.rs                         |    13 +-
 rust/kernel/drm/gem/shmem.rs                       |     5 +-
 rust/kernel/io.rs                                  |   220 +-
 rust/kernel/io/register.rs                         |   803 +-
 rust/kernel/io/resource.rs                         |     8 +
 rust/kernel/lib.rs                                 |     3 +
 rust/kernel/maple_tree.rs                          |    30 +-
 rust/kernel/mem.rs                                 |   234 +
 rust/kernel/pci.rs                                 |    14 +
 rust/kernel/pci/irq.rs                             |    68 +-
 rust/kernel/sync/atomic.rs                         |     4 +-
 rust/kernel/uaccess.rs                             |    18 +-
 rust/macros/io/mod.rs                              |     3 +
 rust/macros/io/register.rs                         |   296 +
 rust/macros/lib.rs                                 |     9 +
 samples/rust/rust_dma.rs                           |    30 +-
 samples/rust/rust_driver_pci.rs                    |     4 +
 sound/soc/ti/omap-hdmi.c                           |    51 +-
 2024 files changed, 312862 insertions(+), 37418 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-gpu
 create mode 100644
Documentation/devicetree/bindings/display/bridge/renesas,r8a779g0-dsc.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili7836a.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
 create mode 100644
Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
 create mode 100644 Documentation/gpu/amdgpu/ualink.rst
 create mode 100644 Documentation/gpu/nova/core/interrupts.rst
 create mode 100644 Documentation/gpu/nova/core/pramin.rst
 create mode 100644 Documentation/gpu/xe/xe_sigid.rst
 create mode 100644
arch/arm64/boot/dts/qcom/glymur-asus-zenbook-a14-ux3407na.dts
 create mode 100644 arch/arm64/boot/dts/qcom/glymur-hp-elitebook-x-g2q.dts
 create mode 100644 arch/arm64/boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-ac-evk.dts
 create mode 100644 arch/arm64/boot/dts/qcom/nord-embedded.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/nord-gearvm.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/nord-ride.dts
 create mode 100644 arch/arm64/boot/dts/qcom/nord-rrd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/nord.dtsi
 create mode 100644
arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3-cam1-imx219.dtso
 create mode 100644
arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3-cam2-imx219.dtso
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-rpi-display-2-5in.dt=
so
 delete mode 100644 drivers/accel/ivpu/ivpu_hw_40xx_reg.h
 delete mode 100644 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h
 rename drivers/accel/ivpu/{ivpu_hw_btrs_lnl_reg.h =3D> ivpu_hw_btrs_reg.h}=
 (58%)
 rename drivers/accel/ivpu/{ivpu_hw_37xx_reg.h =3D> ivpu_hw_ip_reg.h} (73%)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_=
mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_=
mgr.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim=
.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapp=
er.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D>
dml2_wrapper/dml21_wrapper}/dml21_translation_helper.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D>
dml2_wrapper/dml21_wrapper}/dml21_translation_helper.h (94%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D>
dml2_wrapper/dml21_wrapper}/dml21_utils.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D>
dml2_wrapper/dml21_wrapper}/dml21_utils.h (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D>
dml2_wrapper/dml21_wrapper}/dml21_wrapper.c (100%)
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D>
dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D>
dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.h (95%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_dc_resource_mgmt.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_dc_resource_mgmt.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_dc_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_internal_types.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_mall_phantom.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_mall_phantom.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_policy.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_policy.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_translation_helper.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_translation_helper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_utils.c (98%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_utils.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_wrapper.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_wrapper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_wrapper_fpu.c (93%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D>
dml2_wrapper}/dml2_wrapper_fpu.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c
 rename drivers/gpu/drm/amd/display/dc/{dc_edid_parser.h =3D>
rmcm/dcn60/dcn60_rmcm.h} (71%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_namespace.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_8_0_1_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_8_0_1_sh_m=
ask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_8_0_1_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_8_0_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offse=
t.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_ma=
sk.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_7_10_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_7_10_0_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_5_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_5_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/oss/osssys_8_0_1_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/oss/osssys_8_0_1_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/pcie/pcie_6_1_3_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/pcie/pcie_6_1_3_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_3_0_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_3_0_0_sh_m=
ask.h
 create mode 100644
drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h
 create mode 100644 drivers/gpu/drm/amd/include/soc_v2_0_ih_clientid.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/aca_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/aca_v5_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_bert.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_bert.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mce.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mce.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
 rename drivers/gpu/drm/amd/ras/ras_mgr/{amdgpu_ras_mp1_v13_0.h =3D>
amdgpu_ras_mp1.h} (86%)
 delete mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
 delete mode 100644 drivers/gpu/drm/bridge/panel.c
 delete mode 100644
drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
 delete mode 100644
drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
 delete mode 100644
drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-skips.txt
 rename drivers/gpu/drm/{drm_fb_helper.c =3D> clients/drm_fbdev_helper.c} (=
97%)
 create mode 100644 drivers/gpu/drm/drm_panic_helper.c
 rename drivers/gpu/drm/{drm_panic_qr.rs =3D> drm_panic_helper_qr.rs} (99%)
 create mode 100644 drivers/gpu/drm/drm_panic_internal.h
 create mode 100644 drivers/gpu/drm/drm_timeout.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_dip.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_dip.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_dip_regs.h
 delete mode 100644 drivers/gpu/drm/i915/display/intel_tdf.h
 delete mode 100644 drivers/gpu/drm/i915/i915_gtt_view_types.h
 create mode 100644 drivers/gpu/drm/msm/adreno/a7xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_catalog.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36532.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt51021.c
 create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm69220.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-dsi.h
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.h
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
 rename drivers/gpu/drm/tests/{drm_panic_test.c =3D>
drm_panic_helper_test.c} (77%)
 create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
 create mode 100644 drivers/gpu/drm/xe/abi/xe_log_abi.h
 create mode 100644 drivers/gpu/drm/xe/abi/xe_sigid_abi.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/i915_config.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/i915_gtt_view_ty=
pes.h
 create mode 100644 drivers/gpu/drm/xe/display/xe_display_wa.h
 delete mode 100644 drivers/gpu/drm/xe/display/xe_tdf.c
 create mode 100644 drivers/gpu/drm/xe/tests/xe_any_kunit.c
 create mode 100644 drivers/gpu/drm/xe/tests/xe_log_kunit.c
 create mode 100644 drivers/gpu/drm/xe/xe_any.h
 create mode 100644 drivers/gpu/drm/xe/xe_cpu_bind.c
 create mode 100644 drivers/gpu/drm/xe/xe_cpu_bind.h
 create mode 100644 drivers/gpu/drm/xe/xe_log.c
 create mode 100644 drivers/gpu/drm/xe/xe_log.h
 create mode 100644 drivers/gpu/nova-core/api.rs
 rename drivers/gpu/nova-core/firmware/{fsp.rs =3D> gsp_fmc.rs} (67%)
 create mode 100644 drivers/gpu/nova-core/firmware/radix3.rs
 create mode 100644 drivers/gpu/nova-core/gpu/regs.rs
 create mode 100644 drivers/gpu/nova-core/irq.rs
 create mode 100644 drivers/gpu/nova-core/irq/doorbell_test.rs
 create mode 100644 drivers/gpu/nova-core/irq/gsp.rs
 create mode 100644 drivers/gpu/nova-core/irq/hal.rs
 create mode 100644 drivers/gpu/nova-core/irq/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/irq/hal/tu102.rs
 create mode 100644 drivers/gpu/nova-core/irq/interrupt_tree.rs
 create mode 100644 drivers/gpu/nova-core/irq/regs.rs
 create mode 100644 drivers/gpu/nova-core/mm.rs
 create mode 100644 drivers/gpu/nova-core/mm/bar_user.rs
 create mode 100644 drivers/gpu/nova-core/mm/hal.rs
 create mode 100644 drivers/gpu/nova-core/mm/hal/gb100.rs
 create mode 100644 drivers/gpu/nova-core/mm/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/mm/hal/tu102.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/map.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver2.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver3.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/walk.rs
 create mode 100644 drivers/gpu/nova-core/mm/pramin.rs
 create mode 100644 drivers/gpu/nova-core/mm/regs.rs
 create mode 100644 drivers/gpu/nova-core/mm/tlb.rs
 create mode 100644 drivers/gpu/nova-core/mm/vmm.rs
 create mode 100644 drivers/gpu/nova-core/selftest.rs
 rename include/drm/{drm_fb_helper.h =3D> clients/drm_fbdev_helper.h} (99%)
 rename include/drm/{drm_utils.h =3D> drm_panel_quirks.h} (57%)
 create mode 100644 include/drm/drm_panic_helper.h
 create mode 100644 include/drm/drm_timeout.h
 create mode 100644 include/drm/intel/gtt_view_types.h
 create mode 100644 include/dt-bindings/clock/qcom,eliza-cambistmclkcc.h
 create mode 100644 include/dt-bindings/clock/qcom,eliza-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,eliza-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,eliza-videocc.h
 delete mode 100644 include/linux/device-id/apr.h
 create mode 100644 rust/helpers/dma_fence.c
 create mode 100644 rust/kernel/dma_buf/dma_fence.rs
 create mode 100644 rust/kernel/dma_buf/mod.rs
 create mode 100644 rust/kernel/mem.rs
 create mode 100644 rust/macros/io/mod.rs
 create mode 100644 rust/macros/io/register.rs
