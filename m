Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ABECD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 22:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471C810E235;
	Fri,  1 May 2026 22:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mqU0UzQh";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E192010E235
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 22:21:34 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8c70b5594f4so247015785a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 15:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777674094; cv=none;
 d=google.com; s=arc-20240605;
 b=SyRQMScUYmiL7CmJ9NyDlTbyaJ6+EJXTme1kGTioGvFb23W/880E6KVO3fEjnK7n5O
 ImXgwWcCLMFji9J88H56DVTBCnAb05Bptfix5ePM3Ew8NhrCkASBHVw+BHqUr3GpAK7P
 yBxIg+MUEHkkQDqyna35HQ65yveGh2XlL4/s/vxrCnF6E6XB4HhTsjVGkt40ktW+dN+M
 +DaEKEL2jHhuiBcpr0NpV+iKkbwceokwFj3SZ2t3qPKB12pH4ShanQuvNIcJ7tFzmTD/
 zp4M2Co4ueKHYY9BoweSO+lE21WIWeV7GgAs7Hs8JndStqgYOl7D7gUwOdr++HLopzSu
 1GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=EIJxpAftPt6IBXdwWVB9OqBaNJmsCPrKaIVLSbo6fbA=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=F1q7hZ+1WQR+9YhHbBSolWRwAwu8O0Z7KfH/qfP/E04UUIEEgySgYb60uO4ZMde9a2
 4HdNhB40LuYF6Cv2QmuE+WsUWZIoNf0C+v7Kk8fnHe4l9d9dxOBCynkhFm2bi2B10d2r
 IgTU5v+zBLwyafJ5rbEnCymg/YM5vqjTDBM6VQ2EgdIyPRPEG3vcCAvnyxdxZBJxvIM1
 evr5V038LsbZpiL+hP3j1hNljETAH9WDVtdvow2sgS3ehXKzk8OTFGByaxQ2tyzcXe8j
 HyUpoFwCDfIgsy/kOMGJz8oSLLDA9eJuignEpiLmgZo0en0GIhjfr/odbd7unjqwOYmt
 mr9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777674094; x=1778278894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EIJxpAftPt6IBXdwWVB9OqBaNJmsCPrKaIVLSbo6fbA=;
 b=mqU0UzQhcGSGdJCkW95fg52jZh2CeyEW/VxObuvi4e6TmGmI07iKA0cxEG6Cd+MmR7
 6xpIrE3QJ2bMmLCVvCP/T6hnoHoJ5N0HsyR9N9dHq9QOzGuEiHunoM8msuFsOJUvk7PC
 //wgx9kEL/HgEG6tksTRT3kxgAcUY1ZMxdZ0y6e0EST8cCMs9+/w/skYS/3/DsonBfcT
 Ff+jwuCYswVzhBdqAyxX2k9zzYyAwxGMf2Jyt3l2bTkoSXB58Cm/j0wAUyIGg1azaqub
 fsoA79y/EdVxJJ5OhMyQ59Fd1KbhB5Q/B/UYzsUVNkHQhGv+agaMDgBVMcr7KDBYMSWJ
 7SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777674094; x=1778278894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EIJxpAftPt6IBXdwWVB9OqBaNJmsCPrKaIVLSbo6fbA=;
 b=j8Zq935aiE0zE02Kvrt0RG14uTEnuLiE6RjImN5Tyo31eFbXMi2anJSvBCnXwQaAfG
 2Xo/47CQt/qnna2M/D2q54av2yUOwlRzW/akfTx3jKhTWqdQhQp0P6vRZeqYSnfMg5y/
 iB9IP87BaD+VlyuflY02Wd9ggtTkJQxN+wnFI9rslLokeW21NeFOFql3HnGPEpxPfpDQ
 +aREQYJlhgABzEYAsEet7iJyBO0EMkFwHfNt+DiqQ/cQyaci83cMQFP/M82xJM7SVIdP
 0PapayF12kZ88b6msHmvyCNy4OofYnq6/jDgg6E6pJkD9VIoXMjdCdeR3YdWFgbc6U+z
 0UlA==
X-Gm-Message-State: AOJu0YxBDLRL55Pt93cf48ysX0jf4+b/vZLQCToPUKH7IhL7iId/W17a
 yhl+Nbin38hR2a09GVM0GpdRcZMZtE8COtldRdkNd528ODiBsram1sIqcfd3Et7G4d9D6hP0c7G
 kf6i2WxfWoAfj86hkB6KnPi8fXZzRPgY=
X-Gm-Gg: AeBDietl5+x0XsQO087xL/tGvxx9d8+3ewv2jMjlfJWnD7PnUrfI1bOitCFIO4lgdL6
 MF5N2iRVDN1zx6NhN37b7gLTOiIRNGqX74jxEjCFp5oe9t1eNwlH5bznRn0vfL6vo1PR2enAFev
 rcrnFz/TtscnPHvTFfh46jwYGwiZfmZMiEbXUsmUeoxP5b4r+yNFryVmc5jakHeWKBpooa3ga0G
 86bMiwHhvvX0wbqYSkQ+WnXQW3soki4LHlZXJR5aHtMOk1vsVh3CYiRbkhixbQiS77mdotvhNjG
 lEEOEUbI9NJBLdcBDBXCYOalcQcCwV3XtYErlMIPEsv/EKdZyVI7JrkzwygqYl4fjOIHZTbCm8v
 sLg==
X-Received: by 2002:a05:620a:31a1:b0:8cd:e013:bca0 with SMTP id
 af79cd13be357-8fabb3e0c38mr1131684685a.33.1777674092236; Fri, 01 May 2026
 15:21:32 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 2 May 2026 08:21:21 +1000
X-Gm-Features: AVHnY4LidGu7UMp3D6gz_7lXydEOUYJBfmEsVbInp-eg9A4K0dpEEMW6_XMBiHo
Message-ID: <CAPM=9tw9P=MuRdcupYrm9a-gACZtq0sPOdSLjOi9HMr34K6EjQ@mail.gmail.com>
Subject: [git pull] drm fixes for 7.1-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Fixes for rc2, the usual amdgpu/xe double header, I think xe had a
couple of weeks combined due to some maintainer access issues,
otherwise there's just a few misc fixes and documentation fixups.

Regards,
Dave.

drm-fixes-2026-05-02:
drm fixes for 7.1-rc2

core and helpers:
- calculate framebuffer geometry with format helpers
- fix docs

amdgpu:
- GFX12 fix for CONFIG_DRM_DEBUG_MM configs
- Fix DC analog support
- Userq fixes
- GART placement fix
- Aldebaran SMU fixes
- AMDGPU_INFO_READ_MMR_REG fix
- UVD 3.1 fix
- GC 6 TCC fix
- Fix root reservation in amdgpu_vm_handle_fault()
- RAS fix
- Module reload fix for APUs
- Fix build for CONFIG_DRM_FBDEV_EMULATION=3Dn
- IGT DWB regression fix
- GC 11.5.4 fix
- VCN user fence fixes
- JPEG user fence fixes
- SMU 13.0.6 fix
- VCN 3/4 IB parser fixes
- NV3x+ dGPU vblank fix
- DCE6/8 fixes for LVDS/eDP panels without an EDID

amdkfd:
- Fix for when CONFIG_HSA_AMD is not set
- SVM fixes

xe:
- uapi: Add missing pad and extensions check
- uapi: Reject unsafe PAT indices for CPU cached memory
- Drop registration of guc_submit_wedged_fini from xe_guc_submit_wedge
- Xe3p tuning and workaround fixes
- USE drm mm instead of drm SA for CCS read/write
- Fix leaks and null derefs
- Fix Wa_18022495364

appletbdrm:
- allocate protocol buffers with kvzalloc()

dma-buf:
- fix docs

imagination:
- avoid segfault in debugfs

ofdrm:
- put PCI device reference on errors

udl:
- increase USB timeout
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731=
:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-02

for you to fetch changes up to f0997a06e3e32898bcae667d6807fc46ebfd0eec:

  Merge tag 'drm-xe-fixes-2026-04-30' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2026-05-01 12:49:29 +1000)

----------------------------------------------------------------
drm fixes for 7.1-rc2

core and helpers:
- calculate framebuffer geometry with format helpers
- fix docs

amdgpu:
- GFX12 fix for CONFIG_DRM_DEBUG_MM configs
- Fix DC analog support
- Userq fixes
- GART placement fix
- Aldebaran SMU fixes
- AMDGPU_INFO_READ_MMR_REG fix
- UVD 3.1 fix
- GC 6 TCC fix
- Fix root reservation in amdgpu_vm_handle_fault()
- RAS fix
- Module reload fix for APUs
- Fix build for CONFIG_DRM_FBDEV_EMULATION=3Dn
- IGT DWB regression fix
- GC 11.5.4 fix
- VCN user fence fixes
- JPEG user fence fixes
- SMU 13.0.6 fix
- VCN 3/4 IB parser fixes
- NV3x+ dGPU vblank fix
- DCE6/8 fixes for LVDS/eDP panels without an EDID

amdkfd:
- Fix for when CONFIG_HSA_AMD is not set
- SVM fixes

xe:
- uapi: Add missing pad and extensions check
- uapi: Reject unsafe PAT indices for CPU cached memory
- Drop registration of guc_submit_wedged_fini from xe_guc_submit_wedge
- Xe3p tuning and workaround fixes
- USE drm mm instead of drm SA for CCS read/write
- Fix leaks and null derefs
- Fix Wa_18022495364

appletbdrm:
- allocate protocol buffers with kvzalloc()

dma-buf:
- fix docs

imagination:
- avoid segfault in debugfs

ofdrm:
- put PCI device reference on errors

udl:
- increase USB timeout

----------------------------------------------------------------
Aditya Garg (1):
      MAINTAINERS, mailmap: update Aditya Garg's email address

Alex Deucher (1):
      drm/amd/display: properly handle family setting for early GC 11.5.4

Alysa Liu (1):
      drm/amdkfd: validate SVM ioctl nattr against buffer size

Arjan van de Ven (1):
      drm/amdgpu: fix zero-size GDS range init on RDNA4

Ashutosh Desai (1):
      drm/gem: Fix inconsistent plane dimension calculation in
drm_gem_fb_init_with_funcs()

Benjamin Cheng (2):
      drm/amdgpu/vcn3: Avoid overflow on msg bound check
      drm/amdgpu/vcn4: Avoid overflow on msg bound check

Brajesh Gupta (1):
      drm/imagination: Fix segfault when updating ftrace mask

Christian K=C3=B6nig (2):
      drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG
      drm/amdgpu: rework userq fence signal processing

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2026-04-30' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.1-2026-04-30' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2026-04-30' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Gaghik Khachatrian (1):
      drm/amd/display: Update MCIF_ADDR macro to address IGT DWB regression

Geert Uytterhoeven (1):
      drm/color-mgmt: Typo s/R332/RGB332/

Gustavo Sousa (1):
      drm/xe/xe3p_lpg: Add missing indirect ring state feature flag

Hongyan Xu (1):
      drm/amdgpu: avoid double drm_exec_fini() in userq validate

Jia Yao (2):
      drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in madvi=
se
      drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR

Jonathan Cavitt (1):
      drm/xe/vm: Add missing pad and extensions check

Kent Russell (1):
      drm/amdgpu: Only send RMA CPER when threshold is exceeded

Leo Li (1):
      drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs

Lijo Lazar (2):
      drm/amd/pm: Update emit clock logic
      drm/amd/pm: Add fine grained flag to SMU v13.0.6

Mario Limonciello (AMD) (1):
      amdkfd: Only ignore -ENOENT for KFD init failuires

Matt Roper (4):
      drm/xe: Drop redundant rtp entries for Wa_14019988906 & Wa_1401987713=
8
      drm/xe/tuning: Use proper register offset for GAMSTLB_CTRL
      drm/xe: Mark ROW_CHICKEN5 as a masked register
      drm/xe/debugfs: Correct printing of register whitelist ranges

Matthew Brost (1):
      drm/xe: Drop registration of guc_submit_wedged_fini from
xe_guc_submit_wedge()

Maxime Ripard (1):
      Merge drm/drm-fixes into drm-misc-fixes

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: fix root reservation in amdgpu_vm_handle_fault

Prike Liang (1):
      drm/amdgpu: clean up the userq unmap error handler

Roman Li (1):
      drm/amd/display: Restore analog connector support

Sasha Finkelstein (1):
      drm/appletbdrm: Use kvzalloc for big allocations

Satyanarayana K V P (2):
      drm/xe: Add memory pool with shadow support
      drm/xe/vf: Use drm mm instead of drm sa for CCS read/write

Shixiong Ou (1):
      drm/udl: Increase GET_URB_TIMEOUT

Shubhankar Milind Sardeshpande (1):
      drm/amdgpu: Avoid reset in AMDGPU unload path for APUs with GFX
V11 and higher.

Shuicheng Lin (8):
      drm/xe: Fix potential NULL deref in
xe_exec_queue_tlb_inval_last_fence_put_unlocked
      drm/xe/bo: Fix bo leak on unaligned size validation in xe_bo_init_loc=
ked()
      drm/xe/bo: Fix bo leak on GGTT flag validation in xe_bo_init_locked()
      drm/xe: Fix bo leak in xe_dma_buf_init_obj() on allocation failure
      drm/xe: Fix dma-buf attachment leak in xe_gem_prime_import()
      drm/xe: Fix error cleanup in xe_exec_queue_create_ioctl()
      drm/xe/eustall: Fix drm_dev_put called before stream disable in close
      drm/xe/gsc: Fix BO leak on error in query_compatibility_version()

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Timur Krist=C3=B3f (9):
      drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not overlap with VRA=
M
      drm/amdgpu/uvd3.1: Don't validate the firmware when already validated
      drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)
      drm/amd/display: Allow embedded connectors without DDC
      drm/amd/display: Allow DCE link encoder without AUX registers
      drm/amd/display: Allow constructing DCE6 link encoder without DDC
      drm/amd/display: Allow constructing DCE8 link encoder without DDC
      drm/amd/display: Read EDID from VBIOS embedded panel info
      drm/amd/display: Use EDID from VBIOS embedded panel info

Tvrtko Ursulin (1):
      drm/xe/xelp: Fix Wa_18022495364

Xiang Gao (1):
      dma-buf: fix stale @lock references in struct dma_buf documentation

Yang Wang (1):
      drm/amd/pm: fix missing fine-grained dpm table flag on aldebaran

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

YuanShang (1):
      drm/amdkfd: check if vm ready in svm map and unmap to gpu

Yuho Choi (1):
      drm/sysfb: ofdrm: fix PCI device reference leaks

Yury Norov (1):
      drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=3Dn

 .mailmap                                           |   1 +
 MAINTAINERS                                        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  57 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  17 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |  66 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |  10 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |   7 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  26 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  11 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  24 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  44 +++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |  73 +++-
 drivers/gpu/drm/amd/display/dc/dc.h                |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |   3 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |   3 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  94 +++--
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |   4 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |   3 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |   3 +-
 .../amd/display/include/grph_object_ctrl_defs.h    |   4 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   2 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |   2 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |   4 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c         |   2 +-
 drivers/gpu/drm/sysfb/ofdrm.c                      |   2 +
 drivers/gpu/drm/tiny/appletbdrm.c                  |   4 +-
 drivers/gpu/drm/udl/udl_main.c                     |   3 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |   5 +-
 drivers/gpu/drm/xe/Makefile                        |   1 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |   2 +-
 drivers/gpu/drm/xe/xe_bo.c                         |   8 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |   3 +-
 drivers/gpu/drm/xe/xe_dma_buf.c                    |  23 +-
 drivers/gpu/drm/xe/xe_eu_stall.c                   |   4 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |   9 +-
 drivers/gpu/drm/xe/xe_gsc.c                        |   2 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  33 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |   2 +-
 drivers/gpu/drm/xe/xe_mem_pool.c                   | 403 +++++++++++++++++=
++++
 drivers/gpu/drm/xe/xe_mem_pool.h                   |  35 ++
 drivers/gpu/drm/xe/xe_mem_pool_types.h             |  21 ++
 drivers/gpu/drm/xe/xe_migrate.c                    |  56 +--
 drivers/gpu/drm/xe/xe_pci.c                        |   1 +
 drivers/gpu/drm/xe/xe_reg_whitelist.c              |   2 +-
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c               |  54 +--
 drivers/gpu/drm/xe/xe_sriov_vf_ccs_types.h         |   5 +-
 drivers/gpu/drm/xe/xe_tuning.c                     |   2 +-
 drivers/gpu/drm/xe/xe_vm.c                         |   5 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |  47 +++
 drivers/gpu/drm/xe/xe_wa.c                         |   8 -
 include/drm/drm_fb_helper.h                        |   6 +
 include/linux/dma-buf.h                            |   4 +-
 88 files changed, 1085 insertions(+), 269 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_mem_pool.c
 create mode 100644 drivers/gpu/drm/xe/xe_mem_pool.h
 create mode 100644 drivers/gpu/drm/xe/xe_mem_pool_types.h
