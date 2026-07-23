Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A560C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EB410F2EE;
	Fri, 24 Jul 2026 07:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJpw3ln2";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439CE10E476
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 18:46:12 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-385ea3ce80dso961348a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784832372; x=1785437172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lNzFXtDRL36sjfeetYaoRGkJ3BZXJkrvXWbUMZXEOzM=;
 b=dJpw3ln24INYgRFwekI0TSy9sVVf1WWotIFCGCwXO0oBOqTFzFFQ8sd8F40o8rKXUI
 gH2TGo1dWMmMd5cn2bb6WGOkok7sTEue8pTJ5dlETz3ZWpaRR8Xz9ZUc3wnFIl2xBC4r
 gqaY6D3p1mA2R67+6BQlh+KUfthqJJF3ipVrDVAH+/STR1jBKnbWEK17n6zEiMrC6HnH
 P++nLImKDLpt/yQBfao6/kZQ7TeAW7WdfxW62nJKkHdFhCEETOrrN8RUR7OcPhZdjfzU
 3hp7WmCrtwjmUVOwvJWa1er0nUH10nU1+Yh+71xQ4+6gx2T6jntAcs5BDo4N8g/KBH8Q
 92DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832372; x=1785437172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lNzFXtDRL36sjfeetYaoRGkJ3BZXJkrvXWbUMZXEOzM=;
 b=G1K24OQ3jDgF+kXVYkW2K4W5ZTIMTBMucUkjlmPs27PQpSwBtb+CjuXtLv3w3Gx2q3
 MlQjcD2QffQJhLi3PVYeA8R/Ks4GkqS6jwYaCUyNrSGfof0hCHK1x04sRe5DFHEb1BdB
 ELD1WkWQITSpd69zegsIvqjQMQn+l/cE9clgRoF83sSOrVZd/SkYapflRiMlAKZGeszT
 h73Gqcf+l4YgXrkyEdVV55eg6p7Wwj5Arn4+MUSl+99yYlwWy6qLuM1ZDvlT7kr9KdYi
 KMMPKJJq/HVLYaQiSwMWUE67MAhutXS5AtD4SEeiauelBECQmKM1ycmOXHh+zNTq7FmZ
 Ct3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrl6kgd4BEBuPKofQGba3kC+XiAsXU3HeFhIYdU4hKLmV9wKkJcuBQD7N2wOwqOqokRoPMyb6rnooE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywer3zM0Y5g1fqIIf5nR/TxeZOXfAdzf1DKenp9PeT4qexsMJmA
 AghR+eAMyn/uDC+j21yvv+4rON5r7DA2+Ent/GtWpYMWhxcZXe30uObq
X-Gm-Gg: AR+sD13jS3Jo8cHXnENuXjeuXOp6H/WkXgqja/9QIAVPHFy4+pJGaf8/O7CJnl/m4Nx
 c1Uc//TcVe4U3VwMQ/Bg17Playf+bmaWwdHCY/dT1f3gSunoGLpPbIS4HiSIHGR09CME1w0JNqp
 QZhdrCUvYYgQMgSaMik9IcT2hk7vxKliIA1pF3Wrl+2Sa4V1R1ol70cMjUSB7yveAalzQ7A3k2L
 OwkesnCBh7HG/SwvUMoY7cLdnlOHxlUpRWUfSyp7V5DTaYbFT25hkWtZwNbpm3fh/cFOB9yg6C5
 PFCVquyomM6D/v93gqLo9cJNRV1r9dX75a+oUXPXnpHLJfWF2Nwp2lIFace0ylMUSd9KiI7FSoi
 OnCio7aQoy5hXSwrXD2pufRKcZFRK/R2OKk5Y8lvo+XVD+A2lHrr3utg0uYT++VsAnVeEKGXF
X-Received: by 2002:a17:90b:1d02:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-38ec6499300mr4568453a91.2.1784832371666; 
 Thu, 23 Jul 2026 11:46:11 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:46:11 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: cocci@inria.fr, dri-devel@lists.freedesktop.org,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 Jessica Zhang <jesszhan0024@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 06/36] drm: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:08 +0900
Message-ID: <20260723184538.3888637-7-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c           |  6 +-----
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 14 +++++---------
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |  7 +------
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  6 +-----
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
index 51a0ec043248..52a2334be799 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
@@ -55,11 +55,7 @@ static int imx_drm_atomic_check(struct drm_device *dev,
 		return ret;
 
 	/* Assign PRG/PRE channels and check if all constrains are satisfied. */
-	ret = ipu_planes_assign_pre(dev, state);
-	if (ret)
-		return ret;
-
-	return ret;
+	return ipu_planes_assign_pre(dev, state);
 }
 
 static const struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 364227f5456f..e8fde399acae 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -301,19 +301,15 @@ nv50_dmac_create(struct nouveau_drm *drm,
 	if (ret)
 		return ret;
 
-	ret = nvif_object_ctor(&dmac->base.user, "kmsVramCtxDma", NV50_DISP_HANDLE_VRAM,
-			       NV_DMA_IN_MEMORY,
-			       &(struct nv_dma_v0) {
+	return nvif_object_ctor(&dmac->base.user, "kmsVramCtxDma", NV50_DISP_HANDLE_VRAM,
+				NV_DMA_IN_MEMORY,
+				&(struct nv_dma_v0) {
 					.target = NV_DMA_V0_TARGET_VRAM,
 					.access = NV_DMA_V0_ACCESS_RDWR,
 					.start = 0,
 					.limit = device->info.ram_user - 1,
-			       }, sizeof(struct nv_dma_v0),
-			       &dmac->vram);
-	if (ret)
-		return ret;
-
-	return ret;
+				}, sizeof(struct nv_dma_v0),
+				&dmac->vram);
 }
 
 /******************************************************************************
diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index 2334b77f348c..16a02527285e 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -58,13 +58,8 @@ static int osd101t2587_panel_prepare(struct drm_panel *panel)
 static int osd101t2587_panel_enable(struct drm_panel *panel)
 {
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
-	int ret;
 
-	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
-	if (ret)
-		return ret;
-
-	return ret;
+	return mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
 }
 
 static const struct drm_display_mode default_mode_osd101t2587 = {
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1d6c9a423a41..990805f1fea6 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -64,11 +64,7 @@ static int tilcdc_atomic_check(struct drm_device *dev,
 	 * tilcdc ->atomic_check can update ->mode_changed if pixel format
 	 * changes, hence will we check modeset changes again.
 	 */
-	ret = drm_atomic_helper_check_modeset(dev, state);
-	if (ret)
-		return ret;
-
-	return ret;
+	return drm_atomic_helper_check_modeset(dev, state);
 }
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
-- 
2.43.0

