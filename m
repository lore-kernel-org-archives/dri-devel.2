Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19B7C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2301610E5D9;
	Thu, 20 Aug 2026 16:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="De2DLGt6";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341C610E5D9
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:07 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-499acf0fb55so175965e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244605; x=1787849405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b/XzkJMAMDS2ueXQJTvap6+2xTZ8Vp4wtACgU8QnbIo=;
 b=De2DLGt6gpWYsYa9n1x5IWa6SHjrtAvoRPg07oaHqfZi05kS9u9WYKume4aXSDBuym
 W9CO/8gT+6WqWhWdOgWoevpxXLCC+GQThn0guKr5IvY5YL8OaEzzNfRHFrJz/njZYGDM
 Xy8z3z/052W6djsByZtPYq+ffEUWcSMekzAhBwGzBF8xpNx00wvY9kiEyrdeWBiBIEdx
 lii5HdZLIcVkglgHQxiQXp84XmRhYaDi66ysKWKQ1lbAMKUiVMuu9ZoZYF/WPcy3pGrV
 c8vDkIZ/hjeKhZ7t/I2ayFEBrdib7sn0qtPwhshdkFeZfUx9eCVTg4kSMXzueuGZVE1g
 UaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244605; x=1787849405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b/XzkJMAMDS2ueXQJTvap6+2xTZ8Vp4wtACgU8QnbIo=;
 b=fAUL5EKJtiGq5Y/l/Hg0I7axj2fKbFlriG/l80oKTCkHEmuIJc7178xKYAmVzdC1Bn
 3YSEEIWB9U6r4EpNTsje/fiGHNmlIeVVh7Hi1xmrYT+BPHM4JX64K1dBrI/7Mk6JCZ94
 wbMX8Zm9oVNhbvvNGDEhvdlDP/tpa4vbisR5zHZ5bYcdqEB7NVKTG6myRqJ65uHKE58I
 SsP3B9zRh5eQWHvSEXRBAlN8jsUkmmeRr+yLgrHEp2M4iPq/jZ5qAA1kbV13FsqW0ceN
 ifQaQ5257cX3uXc86DElNDEGhbjnjRc1MxKzmOOPR3BjfZwMXUfoquiGtwCeGp+AbAJZ
 v6Xg==
X-Gm-Message-State: AOJu0YzuuMG1DHOimMYqogZtGGWpfw8m/LeoqNAugEa31rn4OnB6GeQg
 kFS98rAz/1MLI3yuGnXPW/OUqOHje7neVGWqD29anuz3JfuEehALkEoK
X-Gm-Gg: AR+sD11R9smnPscvm8yIbWrK/wbva2dXLwLIEy1b4QkmEFhjmLdMEdor1ZCNzpenBOy
 ewmBkTfy6hAP9qoVgGcClExO39CZMIjPaDud3Q5nbD2rYj8XyJjYn5nI+WvLHiAwwELa/syhgRh
 e/zRx0tQ1iFc+YUxjAB0hJjiDAc8oqZ/z6F/8UPx0+oWxnfRNQ5NffMnlT3R3BAioqRW2T1TtDn
 W66Nk6yCjjSjrp1VEgIZIZIKwtDYuIZR6Cx4gMOIKJ8VTG0Z3BwTuhtEHavD703Fi72X17ys+tL
 H/ae1+XjgT1hFurHTotFsjwtzmJFC98UW7SLo4oB2ejtEjmEkMAhMTj20kqMDQE7xvehPABkmq4
 8FxJnbhLw8FbzUc8dfJrVCgJqE0cLa1xa+rOiyCjp8Emg09FlbF6YQ3R84Q3r74kzMqZotmDAOi
 q0vuO14RcNz+nCcgQguilcnW8b0IylIwo9D1qpMCT98iKgvMsr/zbXn7MIuECYds9GGpGf56lW0
 sb1qA==
X-Received: by 2002:a05:600c:8108:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-499b82f40b6mr5030315e9.2.1787244605367; 
 Thu, 20 Aug 2026 09:50:05 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:03 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v2 00/10] nouveau: assorted display fixes (GB20x,
 r570 DP_CONFIG_STREAM, HF-EEODB EDIDs)
Date: Thu, 20 Aug 2026 20:49:19 +0400
Message-ID: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Several fixes for GSP-driven displays consisting of four independent
groups. These were created as part of ongoing HDMI 2.1 bring up and
display handling clean-up work, so some of them are not issues now
(e.g., the 2.147GHz pixel clock cap) but fixing them is required to get
advanced features such as FRL, DSC, VRR, etc working properly.

The v1 review asked for the RM vs register programming split to be made
explicit instead of growing more per-chip code inside the RM layer, so
patches 1-3 do that first. No functional change, and then each GB20x fix
(patches 4-8) supplies its hook from a new engine/disp/gb202.c.

Changes in v2:
- Rebased onto drm-misc-next.

- New patches 1-3: move the GSP path's direct MMIO helpers to
  engine/disp/ and route them through a per-chip nvkm_disp_func.gsp hook
  table. GB20x now has its own gb202_disp_new() instead of display-class
  checks in rm/r535/disp.c.

- Patch 4 (was 1+2): merged. Dropped a stray .frl_train reference that
  broke the build, no longer drops .scdc, and fixed an undefined shift
  when packing byte 3 of each infoframe data word.

- Patch 5 (was 3): the GCP subpack write is now a masked write so
  SB1_CTRL keeps its hardware-controlled default.

- Patch 6 (was 4): the vcpi hook returns its control status like the
  other RM API entries instead of WARN_ONs under the HAL.

- New patch 7: the head-state readback fix is split out. The core channel
  state mirror uses a 0x800 per-head stride on GB20x, fixing scanout pos
  and timings readback for heads >= 1.

- Patch 8 (was 5): reworked onto the new hook table. The low-latency
  vector is exposed as a second DISP interrupt instance by the r570
  engine index translation and re-armed after servicing.

- Patch 9 (was 6): the two HI methods are pushed as one method pair, and
  the class-header defines stay offset-sorted.

- Patch 10 (was 7): OF EDIDs now go through drm_edid_connector_update(),
  and all firmware provided EDIDs (OF, ACPI, VBIOS embedded) are
  validated with drm_edid_valid(). ACPI reads are bounded by the length
  _DDC actually returned. Fixed a runtime-PM reference leak when the RM
  EDID read fails. No raw struct edid is kept anymore and all the old
  raw struct edid consumers are converted to the new API (the SPWG
  dual-link byte is cached at EDID-set time as there is no new drm API
  alternative for it). get_modes() re-syncs the EDID property only when
  the probe helper cleared it.

- Commit messages reworded throughout.

Link to v1:
https://lore.kernel.org/all/20260814235705.59132-1-mohamedahmedegypt2001@gmail.com/


Mohamed Ahmed (10):
  drm/nouveau/disp: move GSP head-timing ISR and vblank helpers to
    tu102.c
  drm/nouveau/disp: move the GSP HDMI GCP AVMute write to engine/disp
  drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func
    hooks
  drm/nouveau/disp: fix HDMI vendor infoframes on GB20x
  drm/nouveau/disp: fix HDMI GCP AVMute register offsets on GB20x
  drm/nouveau/gsp: use per-version DP_CONFIG_STREAM params on r570
    firmware
  drm/nouveau/disp: fix head state readback on GB20x
  drm/nouveau/gsp: fix vblank interrupts on GB20x
  drm/nouveau/dispnv50: program pixel clocks above 2.147GHz on GB20x
  drm/nouveau: honor HF-EEODB EDIDs by converting to struct drm_edid

 drivers/gpu/drm/nouveau/dispnv04/dfp.c        |   5 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |   4 +-
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c   |  21 +-
 .../drm/nouveau/include/nvhw/class/clca7d.h   |   4 +
 .../drm/nouveau/include/nvkm/engine/disp.h    |   1 +
 drivers/gpu/drm/nouveau/nouveau_acpi.c        |  21 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.h        |  10 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c   | 147 ++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.h   |  12 +-
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  10 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/Kbuild   |   1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/ga102.c  |  16 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 192 ++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/head.h   |   3 +
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |   1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/priv.h   |  20 ++
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  |  81 +++++++-
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 121 ++++++-----
 .../nouveau/nvkm/subdev/gsp/rm/r570/disp.c    |  64 ++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |   9 +
 .../nvkm/subdev/gsp/rm/r570/nvrm/disp.h       |   2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |   5 +
 22 files changed, 637 insertions(+), 113 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c

-- 
2.55.0

