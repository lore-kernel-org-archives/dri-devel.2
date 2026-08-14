Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FC6C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DFC10E5BC;
	Fri, 14 Aug 2026 23:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nu7ziVIl";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A65410F76A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:58:36 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so7275575e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786751915; x=1787356715; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IciWU/aDLaHcZt/8OhEMPCWAuQRlBMduwtoNidgedNY=;
 b=Nu7ziVIlVlN/zzUuTI36dU1iMBmIt062JDlY0KUupQC4+pIn6GUzsnHrurGCxi0O0+
 FvR8PSXChFGFCm9zzmn0PGWP8xciK4+znBcEVYRLAVybEFXCKIjZWaVLjlm6/sJTps9h
 bpnnTcGqCcM/W8B49H7JIR2UhcbGHIrMSyTQDpJw/NOOuJ0uQ8IFofJyPHpx2WCVnkdg
 14Pqx15bl17S0jWalese0KuSoCubDrxGavLzmXvqDMT6+csg8nIgGWbNDp4yM2VnSZuw
 vZOvjIK4a16vFnhVYj2ZmORkmP1L8I4PqCChZt2C/bB1385ye/ozJqfX7JVzXZhBBCbp
 m9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786751915; x=1787356715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IciWU/aDLaHcZt/8OhEMPCWAuQRlBMduwtoNidgedNY=;
 b=h9VWao7IEWZPABg/ZwGsSjlP7bgNe28/4y9rbMYRpvmsZBomCKtmG+glcNo683M8ek
 OkicSuE9PPq+HrdocKclWP4ZkiiwXEs5cG0GK/JWMvWpjT9/q/lmLgWEx+al7yaNM6ZH
 cs92x4wOTn7ETFXwluaryTkVy6RVdA81O003p7xqsBFv8S/KWzBARAdOvixjv6CztmVw
 zsqLBZp0BhRBtwRL74cgSRT0zQvtwjZ0y/nrhxd4Im/F0eCTt/DFpGTMpBHR0lZIqaBm
 bN+ErBFl7Fr5qrkwuKg/kNTo+geTjFfZl//wkom6pZcNmwN8AvwP50R9qEvwuuUqVfnI
 gPYQ==
X-Gm-Message-State: AOJu0YyemgsTHEc1t9n3y+J5W1oP9yOmQx90IqDDaz6WRe38UQzuHY3p
 uZXMtX2QdS50UC5Lt8XTX4aMWdkyijIIIaVaCeEQIODIQDjEeadLGNHp
X-Gm-Gg: AR+sD10nbWLr1iiq1kJo1zh/UE0L3zNFFugU8l2ofxc6eBNJgh9U8VPAY03GrXaZwTB
 AwhdHD8AJQ+TnHO7iwsP/VCjvnC7CDo1AW9wdJ3EwiwD9Df21dUiYT2mV7P5lFYPH6DzYfLpnAZ
 /kgbGJu65eNVzZfY0lSnW7kkiPtTJBgXM13nqBKzykm0pTgMUtqYJcAjPOd/Agsp297lBWTmNTn
 b6BYmBuxVdSO7WLXaI6h8QIs07GEQEGUazAC+Uoji1SS9Zxdd2963aRVxITYNjBExzf0eyQn/lo
 QAnm6XD1fW3RFmqXeZfXoRGoDoPlYfN5u0LKKWcfTFud3O1Ckc+dcScoDEh81hZcjyn9Zk2AQmv
 CR1yKLuv1xzajGiPFHVv0cx0IUzvSi6RFVBEooDw/wqnu1xzEs1Olp7bMc6GTmQ0n+1QlyeNS36
 U6jHtvehjnkhYAa5cogrPaB5+d4O2cHz5cfevO7Jl3YwG24XbvPxR03DpgiXWxPACTdolG
X-Received: by 2002:a05:600c:3b23:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-4998ae1bb69mr69497395e9.12.1786751914839; 
 Fri, 14 Aug 2026 16:58:34 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899753ccsm77751245e9.0.2026.08.14.16.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 16:58:34 -0700 (PDT)
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
Subject: [PATCH 1/7] nouveau/disp: add GB20x HDMI vendor infoframe writer
Date: Sat, 15 Aug 2026 03:56:59 +0400
Message-ID: <20260814235705.59132-2-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
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

GB20x (NVDisplay 5.0) reorganised the SF HDMI packet units and the
legacy VSI unit at 0x6f0100 no longer exists. Per NVIDIA's published
CA71 DISP_SF_USER class header, only three legacy units remain (AVI
at +0x000, GCP at +0x040, ACR at +0x080), and vendor infoframes must
instead be sent through the shared generic infoframe units at
+0x130, which feed a 9-dword data FIFO at +0x3f0/+0x3f4.

Add a VSI writer using the same programming sequence OpenRM uses on
these chips (nvhdmipkt_C971.c, programAdvancedInfoframeC971()): disable
the unit and wait for it to idle, clear the SENT status, write the packet
through the data FIFO with a zero HB3 inserted after the three header
bytes, then enable the unit for every-frame transmission during vblank.

Generic unit 1 is used for the VSI, matching the slot assignment in
NVIDIA's nvkms (NVHDMIPKT_TYPE_SHARED_GENERIC2, unit 0 is reserved
for extended metadata packets and unit 2 for the HDR DRM infoframe,
if those are wired up later).

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/Kbuild   |  1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 62 +++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |  2 +
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c

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
index 000000000000..8fd72bcb6f04
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Valve Corp.
+ */
+#include "priv.h"
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
+void
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
+	/* Clear SENT status, and point the data FIFO at unit 1's slot. */
+	nvkm_mask(device, ctrl, 0x00800000, 0x00800000);
+	nvkm_wr32(device, 0x6f03f0 + hoff, 0x00000001);
+
+	/* The FIFO takes the raw packet, except that a zero HB3 is inserted
+	 * after the three header bytes. A unit sends 36 bytes.
+	 */
+	size = min_t(u32, size, 31);
+	memcpy(buf, data, min_t(u32, size, 3));
+	if (size > 3)
+		memcpy(&buf[4], (u8 *)data + 3, size - 3);
+
+	for (i = 0; i < 36; i += 4) {
+		nvkm_wr32(device, 0x6f03f4 + hoff, buf[i + 0] | buf[i + 1] << 8 |
+						   buf[i + 2] << 16 | buf[i + 3] << 24);
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
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
index 3ba04bead2f9..8906fe8ef404 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
@@ -196,6 +196,8 @@ extern const struct nvkm_ior_func_hda gv100_sor_hda;
 
 void tu102_sor_dp_vcpi(struct nvkm_ior *, int, u8, u8, u16, u16);
 
+void gb202_sor_hdmi_infoframe_vsi(struct nvkm_ior *, int, void *, u32);
+
 int nv50_pior_cnt(struct nvkm_disp *, unsigned long *);
 int nv50_pior_new(struct nvkm_disp *, int);
 void nv50_pior_depth(struct nvkm_ior *, struct nvkm_ior_state *, u32 ctrl);
-- 
2.55.0

