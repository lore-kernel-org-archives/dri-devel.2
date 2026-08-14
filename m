Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C1AC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6D110E07C;
	Fri, 14 Aug 2026 23:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HwyZjrW9";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C031010E07C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:58:26 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495590dde14so20848595e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786751905; x=1787356705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=12i2qEk5t59OwBGwHt0k4psCek1hWBpIK5LtDGs5tyQ=;
 b=HwyZjrW9JbDqrtdNCa3vnoUkyvOU60w1Gwf+fmHFmpfOPIjh6YAjH7qeWtAG/vXATT
 VP1wEPfIIXz1FgDAaJmTKHZrWcwDERBFOJ0Zsgun+i/b1icaTsk0H85at4BStBqA4lgk
 O92gNtwPSQbdSBDnnaU9JwgSOxNx1DH1utUNhhwnfI9lbdfS9e597PdZjD/1IH9HmjG9
 mykdGYh0P11Z6pCJ6DgqraDj5b8I3SDmpYG5YqItHs0HIzupx6wbxfp0aooPdJ7v7ffG
 aPWZ556UMQKLlmVYD+vErN2PggV2YzcwASAg6zFTIsb2Nwsf1Rg5lu6Vpvtl/P23/FaX
 Km0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786751905; x=1787356705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=12i2qEk5t59OwBGwHt0k4psCek1hWBpIK5LtDGs5tyQ=;
 b=Oljg8GLYJbl/rRIUB1MC8eXfPMOlJFfPT1j1J91X1sc+CBmp7OPIacDb7hlIyRJ6Qf
 GMXz9zd+5IOWDLP2T/YQccywm29hcLXt9wPkyaByMNK9bZqhnw4QFz2L51KolGxmsBwp
 nboNDP4OqZVcTeFL4SOdfhPXhdictRjVsHzbGLoNgo/CAql4ki5DHADwglvW7MVwPXER
 Xbzp3+sUixwyJkRFj2Gx+tCY7pTSCRMmLHOOmK1zCn0WRKnYPVJ4lSQb4Ska3CPn3WQX
 z87lgukl5f06P78E9a/1w4YsdsYCzCahTwg+QO50t24odOS60CjId1gUcb6QqMWlun27
 vgmw==
X-Gm-Message-State: AOJu0Yx/MnPWNMUUsaDBO9r+7f9zqTvGcGJi5RW54NoL/TvPeWXQffc/
 Zm5qA0UXtX6n5TavhJisIZikBgGigScLPMnBQzbiIXeE+f6SZJAJeP/h
X-Gm-Gg: AR+sD10Q3Wwul5R+qnM/zG6m1+LmkrY4Rx/M7gxPvd0Ge3PMjP0x/1G64EbCp4OgssK
 mzjnz91b/KmwotpJHlClppssa5dph6EkxbEuLVN8e8+hJcXPr1VL6uCB0Vo5aGdicbix5lvAoTg
 Zmdkw41hjJD66POtGyhe0S1ZddFoKvPVGAs3Ji/mvyde1BUiP3eUvGcNHaIZoE+UMYHlqlW1wFd
 mPeNHS8URZNJ0jQ+1/OL/e1qGD2VN4y5IDdrZjjti2KS8r5s0d+/GLP/UaB3A79/jcrGyuij12k
 OzxYAlDKp+MFNYltxkOkc4+U5NLkofsxkcU3PxhDWxs5l/P8Kiq3LToeRrbCn6MDhI44qInCW2/
 SHchDo7x5tCjmgKNnQOvkooC76iNi75qiYx3hFFSEKlJ0Xi0f3np4LO69vyieclRulu5JpL33VM
 mtMixTEkoO1lgTYKuh7jZm0oJxzXyzk2m6OvGHDIC/8z5N0EiXMP3ODzQjPGnUi5SCuro=
X-Received: by 2002:a05:600c:1c07:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49987950d78mr124633925e9.7.1786751904971; 
 Fri, 14 Aug 2026 16:58:24 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899753ccsm77751245e9.0.2026.08.14.16.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 16:58:24 -0700 (PDT)
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
Subject: [PATCH 0/7] nouveau: assorted display fixes (GB20x,
 r570 DP_CONFIG_STREAM, HF-EEODB EDIDs)
Date: Sat, 15 Aug 2026 03:56:58 +0400
Message-ID: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
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
groups. These were created as part of ongoing HDMI 2.1 and display
handling clean-up work, so some of them are not issues now (e.g., the
2.147GHz pixel clock cap) but fixing them is required to get advanced
features such as FRL, DSC, VRR, etc working properly.

Patches 1-3 fix HDMI infoframes on GB20x. Blackwell removed the legacy
SF vendor-infoframe and GCP packet registers, so the MMIO writes land on
dead or moved offsets. Patch 1 adds a vendor infoframe writer for the new
layout, patch 2 switches GB20x over to it, and patch 3 corrects the GCP
AVMute offsets.

Patch 4 fixes DP modesets on r570 firmware. r570 shrank
NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS, so every call built against the
r535 struct is sent with a wrong paramsSize. Route the .sst/.vcpi paths
through per-version RM API hooks built against each firmware's struct.

Patch 5 fixes vblank interrupts on GB20x. The vblank enable moved to a
second top level FE interrupt enable and fires on a separate low-latency
vector that also needs a retrigger write. Without both, heads don't
report vblanks.

Patch 6 fixes pixel clocks above 2.147GHz on GB20x.
HEAD_SET_PIXEL_CLOCK_FREQUENCY carries 31 bits of Hz, and the CA7D class
adds FREQUENCY_HI for the upper bits. Program it instead of truncating
the clock.

Patch 7 converts nouveau's EDID handling to struct drm_edid, reading
through drm_edid_read_custom() on the GSP path. HDMI 2.1 sinks that
declare their real extension-block count through the EEODB no longer have
their EDIDs truncated to the base block's count.

Mohamed Ahmed (7):
  nouveau/disp: add GB20x HDMI vendor infoframe writer
  nouveau/gsp: fix HDMI vendor infoframes on GB20x
  nouveau/gsp: fix HDMI GCP AVMute register offsets on GB20x
  nouveau/gsp: use per-version DP_CONFIG_STREAM params on r570 firmware
  nouveau/gsp: fix vblank interrupts on GB20x
  nouveau/dispnv50: program pixel clocks above 2.147GHz on GB20x
  nouveau: honor HF-EEODB EDIDs by converting to struct drm_edid

 drivers/gpu/drm/nouveau/dispnv50/disp.c       |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c   |  21 ++-
 .../drm/nouveau/include/nvhw/class/clca7d.h   |   4 +
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  95 ++++++++++---
 drivers/gpu/drm/nouveau/nouveau_connector.h   |   7 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/Kbuild   |   1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  |  62 ++++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |   2 +
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 132 +++++++++++++++++-
 .../nouveau/nvkm/subdev/gsp/rm/r570/disp.c    |  64 +++++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |   8 ++
 .../nvkm/subdev/gsp/rm/r570/nvrm/disp.h       |   2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |   5 +
 13 files changed, 371 insertions(+), 34 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c

-- 
2.55.0

