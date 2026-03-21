Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A841099B58
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 00:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E04A10E114;
	Sat, 21 Mar 2026 00:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyfeeoFe";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09F410E114
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 00:31:05 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-89c4feaaeb4so27546316d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 17:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774053065; cv=none;
 d=google.com; s=arc-20240605;
 b=Smw8DFIMXhC2qmohJoj4wW+CvF+ucIDjkttumaTbCTGdZ8nDz2uz4Db00v0q6u3Pbg
 VZDE/m9rHQEgFV1l6cQAUlgasO8wcW7NAiOhzaiL9u3iFbLTLDxeqEjXB6AqYd1ZXldl
 wbW1iiTWIoDlzfnPWIVUA2Tt1baoY5/eXQweEs6S8Ni4pkNdT2ED0TZUEAcCMMmaSNVf
 SVlx6oCmnGflrUEvZbfEPh30JC5T6YUTxF+HDWfs0MWuFfkJSQta+lsEkohj0shY7r0W
 7DbIO1QK2z0jBZq/bjYlFK7/Xc1nyg3fjF1G3fB5cQ607O+yGG2SlBNJI6SJLW2zwaoY
 9a9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=FfhdVdGBrv2XOPAqnyvoZrQEqcyW5wlTCi7XTcz8ACU=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=KRWLVUGWY7LDMPxB52yVrzfM8HpoyoSA9mlaDQCKkxhVSOmcpNEXOFH/rWLF9Ww5UX
 wLHjvlZ6p6PSBE0oVFjAsMbAGNUh3iVZr5gQlXXOfPnhBsRCW8vGQOnQ+SwuXZOXGjrN
 Ro4+YCMhjj22TtYFsTujIF0hwiGXKX/KuoSEexedAucYcbgl/ktjRrz3awdFXp7lKLH7
 MjTwx+LfSTFuJXK4cS+kzNhzMzWn/UuSiFCSjE3uCKp/oxATgr7GG0Uh4nK7+7V2g1pf
 8fCaT8FQ+QtWXri2vf+C1NDAhK3z7q3mq1mtNTJFDInAYvjaB2SdEtkpATCenxvFF42+
 yeHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774053065; x=1774657865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FfhdVdGBrv2XOPAqnyvoZrQEqcyW5wlTCi7XTcz8ACU=;
 b=iyfeeoFeDsocQrkPTXxnQietep+fSme73hG1UI5vfVHHovdRmDZaux5+jlYRq5TVUa
 m+edAzwAXAkt6qVc3ut2Mi79C0gH7O2dAMltM/RMtEXarmcJLrGLmg5wS37qbtBuAoRY
 7Vchzh8eTELana3ehKOkOmjumtN3fDple1PC8VipKsXdaj9aawVFCda7ScRt78fOMMs4
 vcgc5uW2yctOrr6KbGbxL0Ev9kcNfnpJNs0A2sZeWP+opHhgsdYp1Nawpi2PXLQzmzE2
 K7LQlkC7hKRzzPzixeS7/PReTLg1jgcj3d6ev2Xzuduok/l+ajglhTu0CeDIGeMSG7E+
 YxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774053065; x=1774657865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfhdVdGBrv2XOPAqnyvoZrQEqcyW5wlTCi7XTcz8ACU=;
 b=kYPiStb0OAGlfmiwxsSfTodVEsdzdHU3xQ2Cv6INmcw7cRTmn6YoZte33KkWlK+7YR
 SKyZoImJFDKHQ563LsV9WhWn22rXe05g+S+nbq/3J0BENiUkqsraoo6FqjYixubePX8+
 P8pfY/3brukDd+pkkzddlJ4PdDQsuLKJB8DVBLUvDOtnzX7xYNGXF/e7n7iwKcbHe4cI
 1oajX1let7GSEPXhCi1bWHulxSsTeAgyEEqPsNWpkqvtGg9QRABdOWBFowOQutOy6gWH
 0PF8uy0KqXdkUGu1BOxjJwmv19idewy1vaMhz392SI8DxyqyTx5jnhE942pNqnyRikkd
 6jhw==
X-Gm-Message-State: AOJu0YzoaQkwMJ2ylNYb66XqYUQdbCaciVPbub1QQM9AX4Nnrj1ZpSvv
 1FL+Z1W+e+Errk1OZiaTNhZs2WXjFcqt4ZHdv9EVB9YP5AafHrUig/2fENYAyKz+7t7Zh5q7rGM
 6xHdeRKomvui8YnoqLsBKl7WWAeDI5Bs=
X-Gm-Gg: ATEYQzx5gzScTHpZPi6YLTn7p3GxpGBo1gn2TrozsQ/SzZCLCFqcqkQobUfqFfcl7UX
 S+Q0WxPhlyyw7OOcsyAPmLvAPNxHLCDgcuSPB8s5p9bL2NKUal85uVSSubShtURUTFXmc3ypkfH
 9pLmLZTCnRnEgNVDxGqjdNBmSt85I0n6T3NIRAaFipfnzgEMbJN/MYSnpGgWCLNCUhG4DHBmu7/
 /dOTG57yzrFIs/++psYMEm2ucnDeE6B922pxIhB5fbvPfw/6PBSrBPWa3xinxyQTbSplTi7LzKc
 B3W/Ss4h1ZIRodbs6q2BiBVWt0nrbFZ12juzDbOLUPm56DLemzGZCJJMjwoHUYSL1WErdWnymUM
 VAOG6
X-Received: by 2002:a05:6214:4612:b0:89c:866e:5434 with SMTP id
 6a1803df08f44-89c866e5543mr73309656d6.57.1774053064618; Fri, 20 Mar 2026
 17:31:04 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 21 Mar 2026 10:30:53 +1000
X-Gm-Features: AaiRm53wcNnfsBa34NfX1geJ_YP2OviPDH485QpugabQGoAh2umWRY2jIxvwCgI
Message-ID: <CAPM=9twty3xn1KRnsyHDEPMA3c6m3JZOOoh7GuW3gaLPt7-ivA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.0-rc5
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

Regular weekly pull request, from sunny San Diego. Usual suspects in
xe/i915/amdgpu with small fixes all over, then some minor fixes across
a few other drivers. It's probably a bit on the heavy side, but most
of the fix seem well contained,

Regards,
Dave.

drm-fixes-2026-03-21:
drm fixes for 7.0-rc5

core:
- drm_dev_unplug UAF fix

pagemap:
- lock handling fix

xe:
- A number of teardown fixes
- Skip over non-leaf PTE for PRL generation
- Fix an unitialized variable
- Fix a missing runtime PM reference

i915/display:
- Fix #15771: Screen corruption and stuttering on P14s w/ 3K display
- Fix for PSR entry setup frames count on rejected commit
- Fix OOPS if firmware is not loaded and suspend is attempted
- Fix unlikely NULL deref due to DC6 on probe

amdgpu:
- Fix gamma 2.2 colorop TFs
- BO list fix
- LTO fix
- DC FP fix
- DisplayID handling fix
- DCN 2.01 fix
- MMHUB boundary fixes
- ISP fix
- TLB fence fix
- Hainan pm fix

radeon:
- Hainan pm fix

vmwgfx:
- memory leak fix
- doc warning fix

imagination:
- deadlock fix
- interrupt handling fixes

dw-hdmi-qp:
- multi channel audio fix
The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c=
:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-03-21

for you to fetch changes up to a6e77320badd1444b0429ff8b6f338b750a1dc4f:

  Merge tag 'drm-xe-fixes-2026-03-19' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2026-03-21 02:17:59 +1000)

----------------------------------------------------------------
drm fixes for 7.0-rc5

core:
- drm_dev_unplug UAF fix

pagemap:
- lock handling fix

xe:
- A number of teardown fixes
- Skip over non-leaf PTE for PRL generation
- Fix an unitialized variable
- Fix a missing runtime PM reference

i915/display:
- Fix #15771: Screen corruption and stuttering on P14s w/ 3K display
- Fix for PSR entry setup frames count on rejected commit
- Fix OOPS if firmware is not loaded and suspend is attempted
- Fix unlikely NULL deref due to DC6 on probe

amdgpu:
- Fix gamma 2.2 colorop TFs
- BO list fix
- LTO fix
- DC FP fix
- DisplayID handling fix
- DCN 2.01 fix
- MMHUB boundary fixes
- ISP fix
- TLB fence fix
- Hainan pm fix

radeon:
- Hainan pm fix

vmwgfx:
- memory leak fix
- doc warning fix

imagination:
- deadlock fix
- interrupt handling fixes

dw-hdmi-qp:
- multi channel audio fix

----------------------------------------------------------------
Alessio Belle (3):
      drm/imagination: Fix deadlock in soft reset sequence
      drm/imagination: Synchronize interrupts before suspending the GPU
      drm/imagination: Disable interrupts before suspending the GPU

Alex Deucher (11):
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

Alex Hung (1):
      drm/amd/display: Fix gamma 2.2 colorop TFs

Andy Nguyen (1):
      drm/amd: fix dcn 2.01 check

Ashutosh Dixit (1):
      drm/xe/oa: Allow reading after disabling OA stream

Brian Nguyen (1):
      drm/xe: Skip over non leaf pte for PRL generation

Calvin Owens (1):
      drm/amd/display: Fix uninitialized variable use which breaks full LTO

Daniele Ceraolo Spurio (1):
      drm/xe/guc: Fail immediately on GuC load error

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2026-03-19' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-03-19' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.0-2026-03-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2026-03-19' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Ian Forbes (1):
      drm/vmwgfx: Don't overwrite KMS surface dirty tracker

Imre Deak (1):
      drm/i915/dmc: Fix an unlikely NULL pointer deference at probe

Jesse.Zhang (1):
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion

Jonas Karlman (1):
      drm/bridge: dw-hdmi-qp: fix multi-channel audio output

Jonathan Cavitt (1):
      drm/pagemap_util: Ensure proper cache lock management on free

Jouni H=C3=B6gander (2):
      drm/i915/psr: Disable PSR on update_m_n and update_lrr
      drm/i915/psr: Compute PSR entry_setup_frames into intel_crtc_state

Maarten Lankhorst (1):
      drm: Fix use-after-free on framebuffers and property blobs when
calling drm_dev_unplug

Matthew Brost (4):
      drm/xe: Always kill exec queues in xe_guc_submit_pause_abort
      drm/xe: Forcefully tear down exec queues in GuC submit fini
      drm/xe: Trigger queue cleanup if not in wedged mode 2
      drm/xe: Open-code GGTT MMIO access protection

Pratap Nirujogi (1):
      drm/amdgpu: Fix ISP segfault issue in kernel v7.0

Rahul Bukte (1):
      drm/i915/gt: Check set_default_submission() before deferencing

Randy Dunlap (1):
      drm/vmwgfx: fix kernel-doc warnings in vmwgfx_drv.h

Sanjay Yadav (1):
      drm/xe: Fix missing runtime PM reference in ccs_mode_store

Srinivasan Shanmugam (1):
      drm/amd/display: Fix DisplayID not-found handling in
parse_edid_displayid_vrr()

Umesh Nerlige Ramappa (1):
      drm/xe/lrc: Fix uninitialized new_ts when capturing context timestamp

Xi Ruoyao (1):
      drm/amd/display: Wrap dcn32_override_min_req_memclk() in
DC_FP_{START, END}

Zhanjun Dong (1):
      drm/xe/guc: Ensure CT state transitions via STOP before DISABLED

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              | 21 +++--
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |  9 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c          |  3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c          |  3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c          |  3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |  3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  6 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |  8 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |  3 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |  2 +-
 drivers/gpu/drm/drm_file.c                         |  5 +-
 drivers/gpu/drm/drm_mode_config.c                  |  9 ++-
 drivers/gpu/drm/drm_pagemap_util.c                 | 14 ++--
 .../drm/i915/display/intel_display_power_well.c    |  2 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |  1 +
 drivers/gpu/drm/i915/display/intel_dmc.c           |  3 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  7 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  3 +-
 drivers/gpu/drm/imagination/pvr_device.c           | 17 ----
 drivers/gpu/drm/imagination/pvr_power.c            | 51 +++++++++---
 drivers/gpu/drm/radeon/si_dpm.c                    |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                | 93 +++++++++++++-----=
----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  3 +-
 drivers/gpu/drm/xe/xe_ggtt.c                       | 10 +--
 drivers/gpu/drm/xe/xe_ggtt_types.h                 |  5 +-
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                |  2 +
 drivers/gpu/drm/xe/xe_guc.c                        | 32 ++++++--
 drivers/gpu/drm/xe/xe_guc.h                        |  1 +
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  1 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 86 ++++++++++++++----=
--
 drivers/gpu/drm/xe/xe_lrc.c                        |  4 +-
 drivers/gpu/drm/xe/xe_oa.c                         |  7 +-
 drivers/gpu/drm/xe/xe_pt.c                         | 38 ++++++---
 41 files changed, 325 insertions(+), 167 deletions(-)
