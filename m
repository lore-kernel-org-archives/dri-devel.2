Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FB3C55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBB710F429;
	Fri, 31 Jul 2026 21:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oqT9Md2f";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A964710F429
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:40:26 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-81e6f2ee60bso33926777b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785534025; cv=none;
 d=google.com; s=arc-20260327;
 b=hp4QKkFfaMvTjm0lU/NLtt75VgQctn/OKsdxcxfLj3C5lbyMWAgJoE8M1LUzSjwKyK
 x3E20fk68A+7OybNvw5P/qsGkg4WX4r2iSwQC91/SL7Tf9LeTUg1EUK7gMXRS7f0y9Jh
 GMukLCtR7uZJEXVdntPX/Y1e1fcwkOGStUF+s+58vMS1RL0lvDtmqUY52VZgyFi2z5pu
 ildnTLsfPNiIkSn9Q/YeOFwJ8AEXniHjNISbZTLiO0cFIutB+vp30WEkeYSBpuFzPPMo
 KR0jco2+wKhH5uD0/CbSJKESR3rvgx+NTgID8RVQ34MmE6Ce27k+SExYJFI6LQRnymc3
 12vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=q+vEsJSiaCnlqA51ZkD1dUcqUAdIyuij55Tf1znwSso=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=BCmB5r8f8ROAJAyT8A1V6MGo/+EGvl/3lI2U/z2R5PjhRRE0zH/1HpbW9SUt7ZE341
 6Ulsqdxy7W0ML49HTe3z8VtRnCkPQZ+usU2Cykz5kvA478flKZHsQtXR2KZDGlIK5LgZ
 HQNJKoiNt+lJT+Lc4vNiIHCBWgQggDwB+CxIck7VDj/LNYmgX+kTzy/4L/ia8dUAW9Jz
 bMRyknUTS6VykWRMOLAmI1Nv6VxN5Q+eA6OGPLqS531C1VD7tu3JCU7oVSqrWb9WUqhO
 QwlarqfNb2w3eWYiJ8sowwqe6F+Bx26N1SgkPzgXfyBU62o3nCdYyjL9TaMq/9C1p1Xa
 +FIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785534025; x=1786138825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q+vEsJSiaCnlqA51ZkD1dUcqUAdIyuij55Tf1znwSso=;
 b=oqT9Md2fNaLT3AnJ14OpMKdqxQVE0mogcWQDcQ7tiIiDRvhpmQJ4lXxptKTPpPHNyI
 gBVVsOKP6euVtySi806GsF5QkF2Xs63uZiNtTW2zJghsD42F7R55zcWABuaQ7vFhbn/E
 9ZXGexNxH89gXYlmWkm+HZwQc9gZxtMxxbbty11ponM7cy8Avm3Myd7gFISuBUi1IMky
 tX5kr5VsHMoUyBAEee6XvAtiT4jQrc5tvy9dNWMMIeqsc/tR5t/B/Y7gEPgvuNWJ4b5A
 NQ1mukjMy6dPeVTT9WHbfDfCQwO2j7ZHCNGkGWzMLZN75/5VXPcg5ZY9KrQz/1KhudoF
 9XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785534025; x=1786138825;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q+vEsJSiaCnlqA51ZkD1dUcqUAdIyuij55Tf1znwSso=;
 b=c2Pi9ty8nUaZXLMf2a0kdYODEwFSOLjX5rrCbvWuyNzFNs97WTvszxOA7GMQYJ+7XR
 t3G+YSObm8aLt2JD29ZBUFblK1FL7v3ZUdzw1kP4HE31exeSdQfgbu6UuAh81DVWiocQ
 UkTmBJTUnjABmugkEpqlEmjwT4BjBtcLz5iXTTbxncXxP38MIg5UqTi+Ip0DlayZpV68
 pKYAtGn36KJMqho1+Q7Ut219IDB/yxxThIXFVxax0la1OfatFY4iAd2QGXWz40CanhuE
 byJemRnoiQHaNESEVF9o7OtPYposqnrB7oZx/9+tYlDBDmBLmK8ZERR7NanKJaI2twa/
 vRBg==
X-Gm-Message-State: AOJu0Yy3H8tJuBBUjk8DwVSE9pZfVQe+OO5ZlcLDDtToM+FYxvtrP5qB
 /unx6ldNISsTHOnkk39d3FfO+u3AAOqitVXdcZKfPSh0Oy1lsOlB5Q3JZKOyhbkaKeQVl+Ti/fF
 fae4pFmVEsEL0GxYlEO/DMcf9SUwaowA=
X-Gm-Gg: AR+sD10dJC1IboVg8Af3cYMYpO5utRpqbeUrHyXF9pIsB/eXdnHsBNsTRrrgf3tm3E3
 YliXLC3MQbjtVwYUqB7wZyzy2l0+CALCh9omAjpn01/PlXRcO7mfIF3hsSsY6KL9/tIOEZZG60g
 a+3dG+spftj3OzJ7SnScaQI0LOYZGbymN+C1Ai3gD49uF3vSchClogjK7JBmoZ1ShncRT6H6bDv
 9uC4viWewzxXqK6HJBGKTSYC/Q2QmKIhV3KpKzJIDiYcM2daGwGFsFyWcMum3eSCvN3IzrF7pAj
 se3tMX1NJOd9rFz82Vy0sFkTwGpVz478ZEYZa1+Fp3nuSLTkQSqim6Yko45ALkjc+Kt6v+jz12O
 sk0Jx3WMgMiFJjIBz1X0jJmT6soJcHw==
X-Received: by 2002:a05:690c:6701:b0:81e:abe2:e022 with SMTP id
 00721157ae682-81fd4d6e458mr19241747b3.5.1785534025418; Fri, 31 Jul 2026
 14:40:25 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 1 Aug 2026 07:40:13 +1000
X-Gm-Features: AUfX_mz6FyEBlH1ro3oaOsSmyPWXXsbEsBAEnDF_nl_jjkAdxI0zjFlsScePblo
Message-ID: <CAPM=9tz1+pHw3py72tM-DaE6oFQUdbc9XrG9DHJnh=RQNe5+Tw@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc6
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

Hey Linus,

Weekly pulls request. As expected there is more AMD this week since
Alex was off last week, vmwgfx looks to have been hit with the AI
stick a bit and mediatek as well. Otherwise some minor fixes across
the board, the new normal definitely seems to be a thing.

Regards,
Dave.

drm-fixes-2026-08-01:
drm fixes for 7.2-rc6

dp:
- Restrict some DP bandwidth calculations to HDMI DFP.

bridge:
- Fix small leak in bridge/display-connector

mediatek:
- Check CRTC state before freeing
- mtk_hdmi: Fix DDC adapter double put in v2
- mtk_hdmi_common: take i2c adapter module reference
- mtk_dsi: Enable HS clock only at pre-enable
- ovl_adaptor: balance component registrations

amdgpu:
- VCN 5.3 fix
- UserQ fixes
- GEM close optimization
- HDMI AV mute fix
- UML build fixes
- GFXOFF residency metrics fixes
- SMU 15 fixes
- debug_vm fix
- PSP 15 fixes
- NBIO 7.11.5 fix
- pptable use after free fix
- gpu metrics fetch fix
- DC viewport fix
- DML2.1 fix
- i2c retimer spam fix
- UMD profile pstate fix
- Power metrics format cleanup
- GTT size fix on APUs
- DC context logging fix
- PM sysfs fix for APUs
- Follow on pageflip timeout fix

amdkfd:
- Various bounds checking fixes
- Mutex locking fix

i915/xe:
- Check no-DMA huge-pte cases before DMA segment test
- sink FRL rate fix
- 200ms fix for TMDS scrambler status

vmwgfx:
- Improve various size checks and limit checks.
- Fix oops when submitting  invalid execbuf ioctl.
- Correctly lock in vmfwgx fence signaling path.
- More validation of execbuf ioctl.
- Fix oops in vmwgfx vkms init failure path.
- Overflow handling in shader path.

panthor:
- Improve firmware validation

imagination:
- Improve imagination trace points.

qaic:
- Fix QAIC transaction length check.
The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff=
:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-08-01

for you to fetch changes up to 256325820a46b2d69e04b4911f0d95c0bd50fb32:

  Merge tag 'drm-intel-fixes-2026-07-30' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
(2026-07-31 14:44:15 +1000)

----------------------------------------------------------------
drm fixes for 7.2-rc6

dp:
- Restrict some DP bandwidth calculations to HDMI DFP.

bridge:
- Fix small leak in bridge/display-connector

mediatek:
- Check CRTC state before freeing
- mtk_hdmi: Fix DDC adapter double put in v2
- mtk_hdmi_common: take i2c adapter module reference
- mtk_dsi: Enable HS clock only at pre-enable
- ovl_adaptor: balance component registrations

amdgpu:
- VCN 5.3 fix
- UserQ fixes
- GEM close optimization
- HDMI AV mute fix
- UML build fixes
- GFXOFF residency metrics fixes
- SMU 15 fixes
- debug_vm fix
- PSP 15 fixes
- NBIO 7.11.5 fix
- pptable use after free fix
- gpu metrics fetch fix
- DC viewport fix
- DML2.1 fix
- i2c retimer spam fix
- UMD profile pstate fix
- Power metrics format cleanup
- GTT size fix on APUs
- DC context logging fix
- PM sysfs fix for APUs
- Follow on pageflip timeout fix

amdkfd:
- Various bounds checking fixes
- Mutex locking fix

i915/xe:
- Check no-DMA huge-pte cases before DMA segment test
- sink FRL rate fix
- 200ms fix for TMDS scrambler status

vmwgfx:
- Improve various size checks and limit checks.
- Fix oops when submitting  invalid execbuf ioctl.
- Correctly lock in vmfwgx fence signaling path.
- More validation of execbuf ioctl.
- Fix oops in vmwgfx vkms init failure path.
- Overflow handling in shader path.

panthor:
- Improve firmware validation

imagination:
- Improve imagination trace points.

qaic:
- Fix QAIC transaction length check.

----------------------------------------------------------------
Alan Swanson (1):
      drm/amd/display: Silence link_dpms I2C retimer failures

Alessio Belle (1):
      drm/imagination: Fix value of HWRT address in pvr_job_create tracepoi=
nt

Alex Deucher (1):
      drm/amd/display: check if dml21_add_phantom_plane() is successful

Alex Hung (2):
      drm/amdgpu: Fix __rcu fence pointer accesses
      drm/amdgpu: Pack nested ucode_info struct

Alexander Kaplan (2):
      drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs
      drm/i915/dp: Ignore the sink's DSC max FRL rate without a PCON DSC en=
coder

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable

Bob Zhou (1):
      drm/amdgpu: skip clearing empty freed VM list on GEM close

Brajesh Gupta (1):
      drm/imagination: Update the trace point pvr_job_submit_fw()

Candice Li (1):
      drm/amdgpu: restore UMD profile pstate after runtime resume

Dave Airlie (6):
      Merge tag 'mediatek-drm-fixes-20260729' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'amd-drm-fixes-7.2-2026-07-29' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2026-07-30' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-07-30' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.2-2026-07-30' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2026-07-30' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes

David Francis (1):
      drm/amdkfd: Handle invalid event type in CRIU event restore

Fares Soliman (1):
      drm/amdgpu: Update message IDs to PMFW to correctly gather
GFXOFF residency logs

Gang Ba (1):
      drm/amdkfd: Fix missing authorization check in KFD_IOC_DBG_TRAP_DISAB=
LE

George Zhang (1):
      drm/amd/display: Fix divide-by-zero in calculate_mcache_setting
on zero viewport

Guangshuo Li (1):
      drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2

Harkirat Gill (1):
      drm/amdgpu: cap GTT size to physical RAM on APUs

Himal Prasad Ghimiray (1):
      drm/xe/pt: check no-DMA huge-pte cases before DMA segment test

Jerome Tollet (1):
      drm/i915/hdmi: Poll for 200 msec for TMDS_Scrambler_Status

Jiri Slaby (SUSE) (1):
      drm/amd/display: use proper context for logging

Johan Hovold (1):
      drm/mediatek: mtk_hdmi_common: take i2c adapter module reference

Jose Maria Casanova Crespo (1):
      drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO =
size

Kanala Ramalingeswara Reddy (2):
      drm/amdgpu: Update driver if header for SMU V15.0.5
      drm/amdgpu: enable mode2 reset for SMU IP v15.0.5

Laurent Pinchart (1):
      drm/bridge: display-connector: Fix I2C adapter resource leak

Leo Li (1):
      drm/amd/display: Exit idle optimizations before programming

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes

Ma=C3=ADra Canal (1):
      drm/vc4: Zero the tile state data array before each BIN job

Muhammad Bilal (1):
      accel/qaic: use sizeof(*trans_hdr) for transaction length check

Myeonghun Pak (1):
      drm/mediatek: ovl_adaptor: balance component registrations

Osama Abdelkader (2):
      drm/panthor: reject firmware sections with oversized data
      drm/panthor: validate firmware interface structure sizes

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini

Ray Wu (2):
      drm/amd/display: Increase HDMI AV mute wait from 2 to 3 frames
      drm/amd/display: Add AV mute wait frames to dce110_set_avmute

Ruoyu Wang (1):
      drm/mediatek: Check CRTC state before freeing

Shubhankar Milind Sardeshpande (2):
      drm/amdgpu: Enable support for PSP 15_0_5
      drm/amdgpu: Fix NBIO 7.11.5 offsets

Sunil Khatri (1):
      drm/amdgpu: dont pin wptr bo instead use eviction fence

Suresh Guttula (1):
      drm/amdgpu : update mmhub eco sec lvl for vcn5_3

Vladimir Marioukhine (1):
      drm/amdkfd: fix QID bit leak in pqm_create_queue()

William Palacek (3):
      drm/amdkfd: Add bounds check for CRAT subtype length
      drm/amdkfd: fix uint32_t overflow in EOP ring buffer size alignment
      drm/amdkfd: hold event_mutex while checkpointing CRIU events

Yang Wang (4):
      drm/amd/pm: fix pptable use-after-free
      drm/amd/pm: fix torn gpu metrics reads
      drm/amd/pm: use milliwatts for GPU power sensors
      drm/amd/pm: hide pp_table sysfs on APUs

Zack Rusin (12):
      drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size
      drm/vmwgfx: reject DX_BIND_QUERY without a DX context
      drm/vmwgfx: clamp dirty-page range with min, not max
      drm/vmwgfx: take fman->lock around fence list mutation in fifo_down
      drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
      drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
      drm/vmwgfx: bound DMA command body size against suffix pointer
      drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms init failure
      drm/vmwgfx: enforce cursor size limits for MOB cursors
      drm/vmwgfx: skip hash_del_rcu when validation context has no hash tab=
le
      drm/vmwgfx: use check_add_overflow for shader size+offset bound
      drm/vmwgfx: validate external BO copy bounds for both stride paths

 drivers/accel/qaic/qaic_control.c                  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  30 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  15 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  32 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  19 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |  24 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  17 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           | 132 ++++++------
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |  93 +++++++--
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |  26 +++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   9 +
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  23 ++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  78 ++++---
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  20 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |  15 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |  31 ++-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  21 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |  16 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  16 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   6 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  39 +++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  29 +--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   6 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |   4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |   2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |   5 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |   5 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   2 +-
 .../pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h |  38 ++++
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |   2 +-
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   8 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   7 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  59 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   | 223 +++++++++++++++++=
+++-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |   3 +-
 drivers/gpu/drm/bridge/display-connector.c         |  11 +-
 drivers/gpu/drm/display/drm_dp_helper.c            |  12 ++
 drivers/gpu/drm/i915/display/intel_ddi.c           |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   9 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  26 +++
 drivers/gpu/drm/i915/display/intel_hdmi.h          |   2 +
 drivers/gpu/drm/imagination/pvr_queue.c            |   7 +-
 drivers/gpu/drm/imagination/pvr_trace.h            |  16 +-
 drivers/gpu/drm/mediatek/mtk_crtc.c                |   6 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c    |   7 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   5 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c         |  11 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |   8 -
 drivers/gpu/drm/panthor/panthor_fw.c               |  47 +++--
 drivers/gpu/drm/vc4/vc4_irq.c                      |   2 +-
 drivers/gpu/drm/vc4/vc4_validate.c                 |  29 ++-
 drivers/gpu/drm/vmwgfx/ttm_object.c                |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |  39 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c       |  49 ++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  20 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |  13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c         |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |  13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |   3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c               |  17 +-
 drivers/gpu/drm/xe/xe_pt.c                         |  13 +-
 92 files changed, 1172 insertions(+), 375 deletions(-)
