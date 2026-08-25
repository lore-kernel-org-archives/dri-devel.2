Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4835C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F3E10E14F;
	Tue, 25 Aug 2026 00:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oO1hZxCW";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50D710E14F
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:14:35 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2122096f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787616874; x=1788221674; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aKWhndU6oGEBmmrf0fZrPxFBVmNccpJcJPTMMcFJ1LA=;
 b=oO1hZxCWL56PGsbg3K+Cgp99F8TgazFUUlWbIRIT8nOJAyCFbGCzmSIq8eHXJL2/M7
 dkBLvT+czasep0fTqnt3EOKZtBlR7yfCIji7B+jgkncnjrcStdBCclPL0IzYy/UesGal
 zecD3nUcGWk9i5p1JVyR8Y2NASs8d7znN/8TECHKXo28OLjzImBKf1ngx8sIdHecyeOb
 VbwotPwJZa4eJf0WlKTYhIZ2ezQ/BcIJmSTjkRGMCYIV9lRXLGrydVF/tYkd0UqGwuQ3
 vgByIWPxzVIQ5FtI99I+9tYfPIb42mwnF2BxcMIyRQSc4yBIiVH/DysA42KLVUNQhwEp
 rKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616874; x=1788221674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aKWhndU6oGEBmmrf0fZrPxFBVmNccpJcJPTMMcFJ1LA=;
 b=EV4WLfdu6mK6wrTl4KmwMUwmru1G5upM/HiYfnot0nRY45o/FfCATRzeBtsvruYLkb
 WJN8V+RNQimibaii4dH95ffcYzqzNT9LX9jvRbcpExXvIL72OgV+QX1KGhANvlGBIta8
 NSHF5vzhpoQXxsZdwp8btkzp9aEnFzPNSnX9PnPQk95ZwVSNUbwjsZ/noMh771kH7qvj
 mJWj/t09mDQf78JtVIOahV0aE9JFYlH0lNKJWhwwfsGcwD/oA1vmo/3EpKpZMyuo4hO3
 NDHb0pWFQ52Lb176jDubcxiAwLcs3RboK3BlWSs4fmmO2wpXQVibvJ2jF83WCOCDU5hb
 xHeQ==
X-Gm-Message-State: AFuF++mZBeVs3byxEwhVuwoojRnhARmDiolZqBVMr8t2fT9g6b6QNmyB
 oLy+Qg/cux4sE8V7/w+TKLwXssPR4GDzFrGgn0jhJF5bVmd7Xobs7Zbq
X-Gm-Gg: AR+sD13zy40aGykZ6V9RoZFFk631YaRt923v9KS0xPL9SeZCsL+ImpIOQu9r6cWkqiT
 dB9VrrOETtsKgW76sezSLxTbl+b/kAabyxJpGN/+2CV/RtFB7q71aSY+LrtPSbSY9luBqtO+1r+
 JO3huSuD4xQKehLfJAt2gm1iC/MrYVpztAQP38Pe6CfGwZSWVvV53qanc1X+ZiLArPk58e/cLB/
 og+aZFajYwEc3pg0QIzgP6jRZQxJ1BUY2Jh0iZUeQ35YUUJZqPLMfXZhlzrY/iUr6RYcnVFjwIU
 7RIeJup2fz761HCVd8NLd828KRv9BHfRX12Z4FIVCUV4GAo2VT8CV4wCwhPCKIkSyYANDFc9qy+
 V/Gfm94u23QbX9FjjRZF1yEexMY+E+JW4w9amWXzr27TPl+8FrVx+FAOQecQwvM4VwG+6ueWHdz
 4gy29sxUv2zqmCtJv+NvnXjPLV1rgAJEPLa2iG/Tyym0SeGeyQMqxJn2QLeMuAavod26C7V72Ja
 GBASA==
X-Received: by 2002:a5d:5c86:0:b0:47f:cb39:10c4 with SMTP id
 ffacd0b85a97d-482d9f405bamr3241296f8f.12.1787616873844; 
 Mon, 24 Aug 2026 17:14:33 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:14:32 -0700 (PDT)
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
Subject: [PATCH v3 00/10] nouveau: assorted display fixes (GB20x,
 r570 DP_CONFIG_STREAM, HF-EEODB EDIDs)
Date: Tue, 25 Aug 2026 04:13:58 +0400
Message-ID: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
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

The v2 review asked for a few style changes and pointed out a cleaner
struct alternative, so this v3 does that along with adding the requested
Fixes: and stable tags.

Changes in v3:
- Patch 3: the four .gsp head hooks collapse into a single "const struct
  nvkm_head_func *head" as suggested. r535_head and its four forwarders
  are gone and the chip's own table is handed to nvkm_head_new_(). New
  tu102_gsp_head and (patch 7) gb202_gsp_head. gsp.intr_low_latency moved
  to patch 8, where its only user is.

- Patch 7: depth switch condensed to gv100_head_state()'s form. Commit
  message has also been edited to no longer say the readback is supplied
  through gb202_gsp_dsp.

- Patch 8: GB20x was the last cross-file user of the TU102 vblank enables
  so those are static now and their head.h prototypes are gone.

- Patch 10: a VBIOS embedded EDID that fails drm_edid_valid() no longer
  flips the LVDS connector to disconnected and the probe helper's default
  fallback is no longer skipped. ACPI EDIDs are no longer clamped before
  validation, the returned length is tried first and the clamp is only a
  fallback. 

Link to v2:
https://lore.kernel.org/all/20260820164929.17117-1-mohamedahmedegypt2001@gmail.com/
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
 drivers/gpu/drm/nouveau/nouveau_acpi.c        |  32 ++-
 drivers/gpu/drm/nouveau/nouveau_acpi.h        |  10 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c   | 148 ++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.h   |  12 +-
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  10 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/Kbuild   |   1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/ga102.c  |  13 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 191 ++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/head.h   |   2 +
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |   1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/priv.h   |  17 ++
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  |  86 +++++++-
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 125 +++++-------
 .../nouveau/nvkm/subdev/gsp/rm/r570/disp.c    |  64 ++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |   9 +
 .../nvkm/subdev/gsp/rm/r570/nvrm/disp.h       |   2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |   5 +
 22 files changed, 632 insertions(+), 131 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c

-- 
2.55.0

