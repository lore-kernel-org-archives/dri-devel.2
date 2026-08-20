Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37035C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7333C10F100;
	Thu, 20 Aug 2026 16:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l/aoUkug";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16C710F10C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:33 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4998e0916faso181815e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244632; x=1787849432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ycg+tBlFzf10BcsIAnsRc1Aa1/nfomdKMEdD+fHIfbQ=;
 b=l/aoUkugE2v6aJLTRtIKCCSzx52+hP1bG5OHp8PxSAzJ8jWQsOeYpCoeXfLrnXha63
 TwEYlLo4HBa/QGJF5dzIzNHwnJMFf54cqdYys1STZKFMWJtD5PlMvj5BeOZrNE2ikYn3
 fivgvo6LITe4//rFSGTh/n8p51nVsiz/nHYoDM8pAVzcbh2Rt+mZsrbwGjOYCu5WLf1o
 3LpPUUoH/ZfJa/q2Ylj2nZwICnd/PI8j6nVKGa3wO9esPW3IEBw4EfL01Y/QBhP9Oqba
 o5nhg1raKVFzrgGM8iWTh+fOH+EguuDFqnse7PCdtChujkG+nWMtA237TxQXVqQN25+t
 dJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244632; x=1787849432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ycg+tBlFzf10BcsIAnsRc1Aa1/nfomdKMEdD+fHIfbQ=;
 b=jbpjEy7A2q1fT90kK4zdtRwrxAp8clJ9xOX/2S2KBKVwbq5MD3FDXqWH9eEU4D22oX
 AYws7tRvSmf5T9Ucf0eRfB3Myu6dfwh1yr5R3FEnPxysltcgg1kYQrDn3yI4c6Q33Cz5
 reN6+OIYN/BT8yaJoovTWOho9+iwm2rr/m5tpPdtx6Pmkuk3boDXrihWVxm5sDT5N4OV
 i+lNUOWST/JkEn72RYgYA3w3Y2Rd5IlRcF3NaIUaoZLqxX7ektbxzNtTyohOFLw/S7Wj
 OntXCteR6jJme2TA/CAA0GaUODMMIUrApCRTuPQPX6Pgpu+asVrD/jj28lyWn9I6qmW/
 oR5Q==
X-Gm-Message-State: AOJu0Yz7v+jOfYYpghOr/MHCaug23qRk/kmc1xpp3bUpGrH5LAX6OoSR
 Z5knEljAzwUFDTSA2rVJ61M4/o1bVOW/ApOHJ+kNCXy9Nemo6YUtLetY
X-Gm-Gg: AR+sD10MDqAuk6ACCqYdgEBa84bvell5vsYyYyjfxOlypL4F1eLPhZ4CuXA3zX2qmCY
 SwfayO9eWz1fKFQHbqiZ6wwyTtI9He55e2h/e+5hkklPj7HGX8G4F/5a0XS/xQXwOCJmEaCqwn0
 NCIMC4E0Uz5RzMQ6JejFqr+L/fwf7i2/JvC4mRFpwqRUtAAhmPsxIbpM8yc1pCYiObS+/SzCE9f
 c2AvW+IYpmTLrNH1SyoDeF9EqIjxjy+zInCTTIVNztUzTL2ws/4R5FkDNEM8iKfQYYKGKpGREGb
 ErOPTEtEkj+rDVKUYqqrZ3iS0aAlJaKzwk2CJc/BfG6Di9jYVHGeeibUo0BqkN8wqRrtjzBmJ/N
 c6Uw0pROPyvbg3Z5k+n/z2MkC2GBUlRRDoV3CJhbc1fRn4MB+nQimIeE01vBFasXJp5V7071ljQ
 S2giyjTmT0qkDX9tzRavQorbyBdtuo0mpgKJ855Ja/N+XZcjwuTYgXWftRVRXhcpBRvrtfJaX3W
 l7pGQ==
X-Received: by 2002:a05:600c:8108:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-499b82f40b6mr5097465e9.2.1787244632248; 
 Thu, 20 Aug 2026 09:50:32 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:29 -0700 (PDT)
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
Subject: [PATCH v2 04/10] drm/nouveau/disp: fix HDMI vendor infoframes on GB20x
Date: Thu, 20 Aug 2026 20:49:23 +0400
Message-ID: <20260820164929.17117-5-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
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

The GSP path reuses the GV100 direct-MMIO infoframe writers on every
chip. On GB20x that is only half right as while the legacy SF AVI unit is
unchanged, the legacy VSI unit at 0x6f0100 was removed, so
gv100_sor_hdmi_infoframe_vsi() writes into a reserved area and no vendor
infoframe ever reaches the HW. This affects HDMI-VIC signalling which
can impact some 4K modes for legacy HDMI 1.4 sinks.

GB20x (NVDisplay 5.0+) reorganised the SF HDMI packet units. Per NVIDIA's
published C971/CA71 DISP_SF_USER class headers, only three legacy units
remain (AVI at +0x000, GCP at +0x040, ACR at +0x080), and vendor
infoframes must instead be sent through the shared generic infoframe
units at +0x130, whose 9-dword packet slots are loaded through the
shared data port at +0x3f0/+0x3f4.

Add a VSI writer using the same programming sequence OpenRM uses on
these chips (nvhdmipkt_C971.c, programAdvancedInfoframeC971()): disable
the unit and wait for it to idle, clear the SENT status, write the packet
through the data port with a zero inserted in HB3 after the three header
bytes, then enable the unit for every-frame transmission during vblank.
Generic unit 1 is used for the VSI, matching the slot assignment in
NVIDIA's nvkms (NVHDMIPKT_TYPE_SHARED_GENERIC2, unit 0 is reserved
for extended metadata packets and unit 2 for the HDR DRM infoframe,
if those are wired up later).

GB20x so far shared GA10x's display entry point. Give it its own,
gb202_disp_new(), with a gb202_gsp_disp table that supplies the VSI
writer to the GSP path and otherwise carries the same hooks as GA10x.
The following fixes fill in the rest of the GB20x differences there.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../drm/nouveau/include/nvkm/engine/disp.h    |  1 +
 .../gpu/drm/nouveau/nvkm/engine/device/base.c | 10 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/Kbuild   |  1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 91 +++++++++++++++++++
 4 files changed, 98 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h b/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
index 7903d7470d19..01145db32c53 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
@@ -87,4 +87,5 @@ int gp102_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct
 int gv100_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_disp **);
 int tu102_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_disp **);
 int ga102_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_disp **);
+int gb202_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_disp **);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index ea62dc97f118..96c8a5b29999 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -2846,7 +2846,7 @@ nv1b2_chipset = {
 	.pci      = { 0x00000001, gh100_pci_new },
 	.timer    = { 0x00000001, gk20a_timer_new },
 	.vfn      = { 0x00000001, ga100_vfn_new },
-	.disp     = { 0x00000001, ga102_disp_new },
+	.disp     = { 0x00000001, gb202_disp_new },
 	.fifo     = { 0x00000001, ga102_fifo_new },
 };
 
@@ -2862,7 +2862,7 @@ nv1b3_chipset = {
 	.pci      = { 0x00000001, gh100_pci_new },
 	.timer    = { 0x00000001, gk20a_timer_new },
 	.vfn      = { 0x00000001, ga100_vfn_new },
-	.disp     = { 0x00000001, ga102_disp_new },
+	.disp     = { 0x00000001, gb202_disp_new },
 	.fifo     = { 0x00000001, ga102_fifo_new },
 };
 
@@ -2878,7 +2878,7 @@ nv1b5_chipset = {
 	.pci      = { 0x00000001, gh100_pci_new },
 	.timer    = { 0x00000001, gk20a_timer_new },
 	.vfn      = { 0x00000001, ga100_vfn_new },
-	.disp     = { 0x00000001, ga102_disp_new },
+	.disp     = { 0x00000001, gb202_disp_new },
 	.fifo     = { 0x00000001, ga102_fifo_new },
 };
 
@@ -2894,7 +2894,7 @@ nv1b6_chipset = {
 	.pci      = { 0x00000001, gh100_pci_new },
 	.timer    = { 0x00000001, gk20a_timer_new },
 	.vfn      = { 0x00000001, ga100_vfn_new },
-	.disp     = { 0x00000001, ga102_disp_new },
+	.disp     = { 0x00000001, gb202_disp_new },
 	.fifo     = { 0x00000001, ga102_fifo_new },
 };
 
@@ -2910,7 +2910,7 @@ nv1b7_chipset = {
 	.pci      = { 0x00000001, gh100_pci_new },
 	.timer    = { 0x00000001, gk20a_timer_new },
 	.vfn      = { 0x00000001, ga100_vfn_new },
-	.disp     = { 0x00000001, ga102_disp_new },
+	.disp     = { 0x00000001, gb202_disp_new },
 	.fifo     = { 0x00000001, ga102_fifo_new },
 };
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild b/drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild
index e1aecd3fe96c..98d6ca5ac311 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild
@@ -27,6 +27,7 @@ nvkm-y += nvkm/engine/disp/gp102.o
 nvkm-y += nvkm/engine/disp/gv100.o
 nvkm-y += nvkm/engine/disp/tu102.o
 nvkm-y += nvkm/engine/disp/ga102.o
+nvkm-y += nvkm/engine/disp/gb202.o
 
 nvkm-y += nvkm/engine/disp/udisp.o
 nvkm-y += nvkm/engine/disp/uconn.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
new file mode 100644
index 000000000000..fa83aee35ae7
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Valve Corp.
+ */
+#include "priv.h"
+#include "head.h"
+#include "ior.h"
+
+#include <subdev/timer.h>
+
+/* GB20x (NVD5.0) reorganised the SF HDMI packet units. The AVI unit is
+ * unchanged from GV100, but the legacy VSI unit is gone. Vendor infoframes
+ * are sent through the shared generic infoframe units instead. Register
+ * layout per NVIDIA's clc971.h/clca71.h, programming sequence per
+ * nvhdmipkt_C971.c:programAdvancedInfoframeC971().
+ */
+static void
+gb202_sor_hdmi_infoframe_vsi(struct nvkm_ior *ior, int head, void *data, u32 size)
+{
+	struct nvkm_device *device = ior->disp->engine.subdev.device;
+	const u32 hoff = head * 0x400;
+	/* Generic infoframe unit 1, the slot NVIDIA's driver uses for the VSI. */
+	const u32 ctrl = 0x6f0138 + hoff;
+	u8 buf[36] = {};
+	int i;
+
+	/* Disable the unit and wait for it to go idle. */
+	nvkm_mask(device, ctrl, 0x00000001, 0x00000000);
+	if (nvkm_msec(device, 2000,
+		if (!(nvkm_rd32(device, ctrl) & 0x00400000))
+			break;
+	) < 0)
+		return;
+
+	if (!size)
+		return;
+
+	/* Clear SENT status, and point the data port at unit 1's slot. */
+	nvkm_mask(device, ctrl, 0x00800000, 0x00800000);
+	nvkm_wr32(device, 0x6f03f0 + hoff, 0x00000001);
+
+	/* The data port takes the raw packet, except that a zero is inserted
+	 * in HB3 after the three header bytes. A slot is 9 dwords (HB0-3 plus
+	 * up to 32 payload bytes). An HDMI infoframe carries at most PB0-27,
+	 * so the tail stays zero, and we always write the whole slot.
+	 */
+	size = min_t(u32, size, 31);
+	memcpy(buf, data, min_t(u32, size, 3));
+	if (size > 3)
+		memcpy(&buf[4], (u8 *)data + 3, size - 3);
+
+	for (i = 0; i < 36; i += 4) {
+		nvkm_wr32(device, 0x6f03f4 + hoff, buf[i + 0] | buf[i + 1] << 8 |
+						   buf[i + 2] << 16 |
+						   (u32)buf[i + 3] << 24);
+	}
+
+	/* No flip ID or scanline matching. */
+	nvkm_wr32(device, 0x6f013c + hoff, 0x00000000);
+
+	/* ENABLE | RUN_MODE=ALWAYS | LOC=VBLANK | OFFSET=1 | SIZE=0. */
+	nvkm_wr32(device, ctrl, 0x00000041);
+
+	/* Audio priority low (the init value). */
+	nvkm_wr32(device, 0x6f03f8 + hoff, 0x00000002);
+}
+
+/* GB20x is GSP-only. This table supplies the register programming the
+ * GSP-RM display path needs from the chip.
+ */
+static const struct nvkm_disp_func
+gb202_gsp_disp = {
+	.uevent = &gv100_disp_chan_uevent,
+	.ramht_size = 0x2000,
+	.gsp.intr = tu102_disp_intr,
+	.gsp.head_state = gv100_head_state,
+	.gsp.head_rgpos = gv100_head_rgpos,
+	.gsp.vblank_get = tu102_head_vblank_get,
+	.gsp.vblank_put = tu102_head_vblank_put,
+	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	/* The legacy AVI unit is unchanged on GB20x. */
+	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
+	.gsp.hdmi_infoframe_vsi = gb202_sor_hdmi_infoframe_vsi,
+};
+
+int
+gb202_disp_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
+	       struct nvkm_disp **pdisp)
+{
+	return r535_disp_new(&gb202_gsp_disp, device, type, inst, pdisp);
+}
-- 
2.55.0

