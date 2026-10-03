Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044F9CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 09:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3571F10E06E;
	Sat,  3 Oct 2026 09:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jIcbLQo4";
	dkim-atps=neutral
Received: from mail-qk2-f37.google.com (mail-qk2-f37.google.com
 [74.125.230.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D9C10E06E
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 09:12:36 +0000 (UTC)
Received: by mail-qk2-f37.google.com with SMTP id
 af79cd13be357-93e53145964so8476885a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791018755; cv=none;
 d=google.com; s=arc-20260327;
 b=RJlt02zxCiCo5bx3jYF7/SPlhsEI7oZHVPtlYnidkwofxRuSP0O8gwwm+qNgwrbX0Q
 OFs53gSJAbqui8emxjugCjyyuk6Q4X5eUQSv9vmG7XhLPazt47q2TfcJXJ19Ij2zk8QL
 yZahd5EfP0eM9PkHashAveZFK2RgUWIj9bgoCGuafSl9zWGqtcpon3jNJhm6GLaCQQ8P
 5Fx67Fcug9oyqAl7Im7BA2HSfPOIHkLLCgA3An1uHd25zYeKjmuY0SiQlTcbdLtFEpSo
 jSsAA1iuFGA/b6yPv+Zq2Eqgi+1XhqcLLMlzFSKhfkHDpdBz7UF5Oo1d6fLjD9SsGi4j
 l75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=rc52rTiI8uQA9DrxYgPOUqnoJH9/KQrLX2hPjTUlVqw=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=ny329EDyOlszptAZPmln1pFqa/yJotpq3aBSOoHbohFMhEC5IykzZLY3vOizXmefT2
 gI/yfiNvg9EF/ZfFW1NQbZUtaBQTycEdQv59IWOex1FuFiXieYjuB5gZX+z3ng6nPI77
 aJyfoGccnIMBz0hfsrwpvj4/O3mr2/0giMM+kEtkyF02ETT/eMYOdOJDABuMtFFVFB5u
 KNlC9HpGtxZpxwZPrAz/eAWDQ8NozFYOs5CbNhllm5g5Y4PGnmt81020xgCevWz+W5Pc
 UX7loyhptF1sMgOuuouF0QRdbefhzC4oPONI8TN98Hgy9aLc9s1cKfN2CHgRh9GHDnxL
 ND2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791018755; x=1791623555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rc52rTiI8uQA9DrxYgPOUqnoJH9/KQrLX2hPjTUlVqw=;
 b=jIcbLQo49ylCKmdbS/VkBaMsazR+3Xk5295RVom/7UvCAYhHsn9HKZP89cDtlq5jHg
 dn4q2AvYX7iPj/aPL5lqw/81sxoMGDStkHbCCN52aLzK4Ir+0jJqEVVwAVGGr+FCd9Ut
 eNZmsBRdvGeYsPsQiYl/NMGLgRmC5b3gFove1Y4uggjQ6i0lUXeI/rAAKdwc0DvxqM4r
 zB5/LIoHuJay8Sxte6iU69JBcS2Key8Y/lkjE/tbtwS4ELRaynxg1QDFpzQVlINLiX4D
 0ZSi6Zxadaz2qIrGiLLZwI5mB7V21nXTDAR/ABiBfLzF6IbYPtuoIS5qsot5eWTt0eS2
 9lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791018755; x=1791623555;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rc52rTiI8uQA9DrxYgPOUqnoJH9/KQrLX2hPjTUlVqw=;
 b=KNxnUHg9VskbsK+r2xVWuXwV5nud2yMXI1qBMN7J1ZGb8xncsKQ2TqgHhmC1YF5DSu
 mtZrsN/BDGil94aL/gIjRuxdcI/Z/dgWobv9lHr83moT3iYghEgOtnIU3KTs94gaAL9c
 CZOwwoGUBNARIDv5rl0ZdMYPjfgt1AsE5mqqHfSZyur5KwNMZbP64WIcGbxvdlX1TRwK
 t6HSQ0g4Bc9+VXVxfMCXPXjkyc5mNhgQn3VJNIu3JkVFS6M8RFTiIwzEhsAbIJOHyC9H
 LbPM+Z3jzs9Tp5+s+7tSuk6D8MVPZpKun45adOImuec6fHioZNl3Tn0YB05D20Ozoli/
 6/yA==
X-Gm-Message-State: AFuF++lZQzesAy3rA+7n6B/xiUMRGfLwj+iuDIvotlsqWFBGSx/fowKO
 /tZzz7X9Uv6oAuaEuN3aPvOOmCJz1FuSjQ4ac5gNtYT9XWpJRz7/bkRY0KL3E8zRadgZQ76kN19
 YYYLbYdbJVn/FlCpQrMzkfeb7mcgXRu8=
X-Gm-Gg: AYBFou3F9GZF4OUd51K/SEfJvGl12MJi/l5HerMY5XbMwtsrpfp2yEZ5sXUYR6h13v2
 3tvzNc6iymE/15qmFL22qGWBWSVKMRBIS231FapLFdAM6GjEtvqEytxmwm22B+wK4P+m6AzHJ2D
 WBQOV8SWdu0aBXlEBqobXaOOcomk1XGFpix5zOaDBThK6eO5sjy+4HiA//6XG86QebSceAABRsz
 zuZIsA3QbxEn6VKLYuICAoKunaJ/k5pHYwIO2ojF+K6MMuyabcPuRdsuMC9b7AN0Bm8l/h0qGaE
 8cGQoGDdXCcy9RSJDyrcqFKhz6jtkX7RTTFIsiMxblRvCF7QbJFNVVmBWJb3nx+kh/kffYXclIU
 ot1de/JpbMVw9e8/tu8j6/r0qxjIk1j4vYK/DFLU7Ecrtbs7+fZ8Jdi7tuA5JB+gG2E0+smK/iQ
 ==
X-Received: by 2002:a05:620a:318a:b0:93e:5060:f961 with SMTP id
 af79cd13be357-93e50610185mr385692785a.6.1791018755446; Sat, 03 Oct 2026
 02:12:35 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 3 Oct 2026 19:12:23 +1000
X-Gm-Features: AclHuK9nt0T1kXPiBAGDw1JCyLvcJB04uj1AKTxmnsRHF8j7pv4TbOfJFQfqamM
Message-ID: <CAPM=9tzVwVzu5NsshoL0Jgjs3aSiN_aE44H+H54+FNE1F2GKpw@mail.gmail.com>
Subject: [git pull] drm fixes for 7.3-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
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

Live from Brisbane airport, it's Saturday Night drm fixes. The misc
fixes tree didn't get a PR this week, so I'll probably have that to
you when I see it, there were a few patches in there.

Otherwise amdgpu is the main act, mediatek has a guest spot, and
xe/i915 bring in a fix each.

Regards,
Dave.

drm-fixes-2026-10-03:
drm fixes for 7.3-rc6

xe:
- keep VF LMEM bar size low if no VFs enabled

i915:
- Disable VRR DC balance by default to fix timing issues

mediatek:
- Add missing IS_ERR check for ovl_adaptor platform device
- Fix VID_DOWNSAMPLE_CONFIG register offset
- Fix pdev reference leak in mtk_drm_bind()
- Fix runtime PM leak in mtk_hdmi_ddc_v2_probe()
- Fix ovl adaptor platform device leak

amdgpu:
- dc_state_create_copy() fix
- HDMI RGB limited range fix
- eDP ASSR fix
- DCE 6 fixes
- DCE 8.1 fix
- SI DPM fixes
- Reset fixes
- Workaround for multiple SDMA entities with DCC
- PWM backlight fix
- GPUVM fixes
- Switcheroo fix
- Error handling leak fixes
- GC 6 unload FW leak fix
- SDMA 7.1 fix
- DML frame size limit fix
- RGB vs YCbCr 4:4:4 fix
- DP MST fix
- DC Power module fixes
- MacBookPro14,3 fix

amdkfd:
- SVM fix

radeon:
- sparc64 fix
The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e=
:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-10-03

for you to fetch changes up to 9c979cba980522f044ea2b14d8cab87ea3cddb56:

  Merge tag 'amd-drm-fixes-7.3-2026-10-01' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
(2026-10-03 09:32:49 +1000)

----------------------------------------------------------------
drm fixes for 7.3-rc6

xe:
- keep VF LMEM bar size low if no VFs enabled

i915:
- Disable VRR DC balance by default to fix timing issues

mediatek:
- Add missing IS_ERR check for ovl_adaptor platform device
- Fix VID_DOWNSAMPLE_CONFIG register offset
- Fix pdev reference leak in mtk_drm_bind()
- Fix runtime PM leak in mtk_hdmi_ddc_v2_probe()
- Fix ovl adaptor platform device leak

amdgpu:
- dc_state_create_copy() fix
- HDMI RGB limited range fix
- eDP ASSR fix
- DCE 6 fixes
- DCE 8.1 fix
- SI DPM fixes
- Reset fixes
- Workaround for multiple SDMA entities with DCC
- PWM backlight fix
- GPUVM fixes
- Switcheroo fix
- Error handling leak fixes
- GC 6 unload FW leak fix
- SDMA 7.1 fix
- DML frame size limit fix
- RGB vs YCbCr 4:4:4 fix
- DP MST fix
- DC Power module fixes
- MacBookPro14,3 fix

amdkfd:
- SVM fix

radeon:
- sparc64 fix

----------------------------------------------------------------
Adrian Betschart (2):
      drm/amd/display: Default HDMI RGB output to limited range on CTA mode=
s
      drm/amd/display: Try RGB before YCbCr 4:4:4 in stream validation

Alex Deucher (3):
      drm/amdgpu/gmc12: properly pass flush_type to gmc_v12_0_flush_vm_hub(=
)
      drm/amdgpu: drop userq callback assignment for sdma 7.1
      drm/amdgpu/gmc12.1: properly pass flush_type to gmc_v12_1_flush_vm_hu=
b()

Andrew Martin (1):
      drm/amdkfd: Fix always mapped range mapping to all ACCESS GPUs

Arthur Heymans (1):
      drm/amd/display: Preserve eDP mode on initial ASSR failure

Dave Airlie (4):
      Merge tag 'drm-xe-fixes-2026-10-01' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-10-01' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'mediatek-drm-fixes-20261002' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'amd-drm-fixes-7.3-2026-10-01' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes

Francisco Beltr=C3=A1n Millal=C3=A9n (1):
      drm/amdgpu: reset VI ASIC on MacBookPro14,3

Guangshuo Li (3):
      drm/amdgpu: fix IP instance memory leak on kobject add failure
      drm/amdgpu: fix ACP MFD device leak on init failure
      drm/mediatek: Fix ovl adaptor platform device leak

Haojie Li (1):
      drm/mediatek: Add missing IS_ERR check for ovl_adaptor platform devic=
e

Hari Mishal (1):
      drm/amd/display: guard dc_sink dereferences in MST mode validation

Imre Kaloz (1):
      drm/radeon: Read the VRAM VBIOS signature with readb()

Jesse Zhang (4):
      drm/amdgpu: support non-guilty job save on ring backup
      drm/amdgpu: fix empty fence backup and replay intervals
      drm/amdgpu/gfx12: set KMD_QUEUE for kernel gfx queues
      drm/amdgpu/gfx11: set KMD_QUEUE for kernel gfx queues

Jiangshan Yi (1):
      drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend

Julien Stephan (1):
      drm/mediatek: mtk_hdmi_v2: fix VID_DOWNSAMPLE_CONFIG register offset

Marcin Bernatowicz (1):
      drm/xe/pf: Keep VF LMEM BAR size low if no VFs enabled

Michal Wajdeczko (1):
      drm/xe/pf: Refactor VF LMEM BAR resize helper function

Mitul Golani (1):
      drm/i915/vrr: Disable DC balance by default

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: implement workaround for sdma dcc corruption

Ray Wu (1):
      drm/amd/display: map PWM brightness through custom backlight curve

Sasha Levin (1):
      drm/amd/display: Fix sanitizer check for the DML frame size limit

Simon Polack (1):
      drm/amd/display: Fix stale replay_events after mod_power stream remov=
al

Theo Andersen Carton (1):
      drm/amdgpu: skip the noirq suspend reset for a switcheroo-parked GPU

Timur Krist=C3=B3f (5):
      drm/amd/display: Fix fast updates on DCE 6.x
      drm/amd/display: Fix fast updates on DCE 8.1
      drm/amd/display: Mark DCE 6.4 as not APU
      drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_D=
C
      drm/amd/pm/si: Fix updating clock limits on AC/DC

Wentao Liang (2):
      drm/mediatek: Fix pdev reference leak in mtk_drm_bind()
      drm/mediatek: Fix runtime PM leak in mtk_hdmi_ddc_v2_probe()

Willian Oliveira (1):
      drm/amdgpu/gfx6: fix firmware leak on teardown

 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |  13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |  37 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   9 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |   4 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  13 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  11 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  92 +++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  24 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   6 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 117 +++++++++++++++++=
++++
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   2 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |   2 +-
 .../dc/link/protocols/link_edp_panel_control.c     |   4 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |  13 ++-
 .../amd/display/dc/resource/dce80/dce80_resource.c |   2 +
 drivers/gpu/drm/amd/display/modules/power/power.c  |   2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  39 +++----
 .../gpu/drm/i915/display/intel_display_params.c    |   4 +
 .../gpu/drm/i915/display/intel_display_params.h    |   1 +
 drivers/gpu/drm/i915/display/intel_vrr.c           |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  17 ++-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c         |   4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h        |   2 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |   6 +-
 drivers/gpu/drm/xe/xe_pci_sriov.c                  |  30 ++++--
 34 files changed, 399 insertions(+), 87 deletions(-)
