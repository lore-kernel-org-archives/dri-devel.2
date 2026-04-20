Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD73F3ED73
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B2610E03F;
	Mon, 20 Apr 2026 05:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FkxwOLft";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1107210E03F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 05:20:35 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so10425975ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 22:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776662434; x=1777267234; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GzRXCJv6s7nBaWaSPV26wDLtfWq6m8la+VtHkby4pFA=;
 b=FkxwOLftFwx7iP/8EcPE/Ce8YeRwo16YGwfodXA5rMzQQW378+99vmxX2bMU/pmnBF
 gsnSL6ZWBacuR7/+0R1WXGDKNTkDbUeRp0GKrkT92iTT5v0PAr1Qd97KWFgUyUGiz83d
 2872wdRn61zzzAZYZ1zxmrGqlLaqiZhwpdQQfmv8oxAHXLkyW1+alDJBjXNofsVDU5LG
 x9FCaH2dEnMWoEQN10EsESdFQIlUTjQKflmFXHLWzy9Ac5rwgcHN+wlRG9HTB5zg2EXd
 cRiIHrHTfhiKMnnORb/l1pm68+BJlvS7ZydgNxXklOj2rpJ7lrsK6gtiEzt5W02fNjHy
 k5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776662434; x=1777267234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzRXCJv6s7nBaWaSPV26wDLtfWq6m8la+VtHkby4pFA=;
 b=quwvGnHFcImAXggoAxFksSL4qwIJKK5aWaHobl7LhVwRG1BSHVuPSK+eHKTelgWZeh
 90itqChLech79yyX0yExkhCcjD+vcSGfGfc4noDoLJuxkmZ0OVVeQIKCvwTU5e/+T8TD
 fC3nU5gZh27DS0wvoAi2weoOrCdVQcGlzCT/z2rNCt1ylimDxUV1OV4XyAv+SaDUNl9o
 vx5q/0zL6Vc295bBuvBYukXWH9bl/8VylEyWW6u5rZNoNWdsgsIcSfVlOovEGuBXYGR7
 ZqpKeLuDJsfddXOkKpYKlP/d2/aUMKTe4PVfB1qTFkjcOzjWX22zJ93/vqEaWobPS7JH
 T4wg==
X-Gm-Message-State: AOJu0Yx8lQG0F/yA6DmPDzSQg1QIDlvLBWqjECtJH5qCI7Ww3MRZ6v8I
 szoSh77I3AJIHT6DwsGUfhPogNKjO0nLHBY4ZrC6wuTBd9Ohi76qd3gE
X-Gm-Gg: AeBDievTQizcuXAcCGnsUeqHxdqYVJ39ceDU7QjzImDqNu126EAH6oXBI6lrt2VdSmc
 p67XUZD4BwahRM6UevwGa/Ij/vWu+dXqvDo4HuuS5v6NT+hXoqcBV/qHdvrvLyyCd2LI04PbGtd
 VcAqq2dCBXJFmDU46AgFqSYq+B0iiLqMuUfwGRXqny20Y/B2xJyp2qBT+Cx/am+VEueo+FS6YMe
 RhT8qTViUyqYLclpDV7pZU5TwJ3+gINTUgb/BjPgSI2vSROAy9Jvsfc7nnrh1IRtiDIgcnSI+pZ
 5hwioy6rIX373ERaD165axYB2qWiK6/mcraOH7+EFVs9V2g/LZg0eoyKBrUhAdaYIBi4pafuHAc
 v1qnF2O021ElSBE1dC+0KXh1TLFoFC01V1nIeev1w944rRVHZzWJfbKUUD04N743z/gtXW95TJi
 IK+XkMiU2Bnhm/7Q94X1qdgbHQ/txL9PFh14FvYgmdYu01wJl46+Q=
X-Received: by 2002:a17:903:124c:b0:2b2:57df:264d with SMTP id
 d9443c01a7336-2b5f9f61ad2mr132449745ad.33.1776662434501; 
 Sun, 19 Apr 2026 22:20:34 -0700 (PDT)
Received: from rahul-mintos.ban-spse ([165.204.156.251])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm87965555ad.68.2026.04.19.22.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 22:20:34 -0700 (PDT)
From: Abhishek Rajput <abhiraj21put@gmail.com>
To: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 abhiraj21put@gmail.com
Subject: [PATCH] drm/mediatek: Convert legacy DRM logging to drm_* helpers in
 mtk_dsi.c
Date: Mon, 20 Apr 2026 10:50:08 +0530
Message-ID: <20260420052008.5417-1-abhiraj21put@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Replace DRM_INFO(), DRM_WARN() and DRM_ERROR() calls in
drivers/gpu/drm/mediatek/mtk_dsi.c with the corresponding
drm_info(), drm_warn() and drm_err() helpers.

The drm_*() logging helpers take a struct drm_device * argument,
allowing the DRM core to prefix log messages with the correct device
name and instance. This is required to correctly distinguish log
messages on systems with multiple GPUs.

This change aligns the radeon driver with the DRM TODO item:
"Convert logging to drm_* functions with drm_device parameter".

Signed-off-by: Abhishek Rajput <abhiraj21put@gmail.com>

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 0e2bcd5f67b7..a67ad575f5f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -510,6 +510,7 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
 	u32 delta;
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 	struct videomode *vm = &dsi->vm;
+	struct drm_device *drm = dsi->bridge.dev;
 
 	if (dsi->format == MIPI_DSI_FMT_RGB565)
 		dsi_tmp_buf_bpp = 2;
@@ -543,7 +544,7 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
 					     horizontal_backporch_byte /
 					     horizontal_front_back_byte;
 	} else {
-		DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\n");
+		drm_warn(drm, "HFP + HBP less than d-phy, FPS will under 60Hz\n");
 	}
 
 	if ((dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) &&
@@ -623,12 +624,13 @@ static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
 {
 	s32 ret = 0;
 	unsigned long jiffies = msecs_to_jiffies(timeout);
+	struct drm_device *drm = dsi->bridge.dev;
 
 	ret = wait_event_interruptible_timeout(dsi->irq_wait_queue,
 					       dsi->irq_data & irq_flag,
 					       jiffies);
 	if (ret == 0) {
-		DRM_WARN("Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
+		drm_warn(drm, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
 
 		mtk_dsi_enable(dsi);
 		mtk_dsi_reset_engine(dsi);
@@ -663,9 +665,10 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
 {
 	mtk_dsi_irq_data_clear(dsi, irq_flag);
 	mtk_dsi_set_cmd_mode(dsi);
+	struct drm_device *drm = dsi->bridge.dev;
 
 	if (!mtk_dsi_wait_for_irq_done(dsi, irq_flag, t)) {
-		DRM_ERROR("failed to switch cmd mode\n");
+		drm_err(drm, "failed to switch cmd mode\n");
 		return -ETIME;
 	} else {
 		return 0;
@@ -849,11 +852,12 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					     struct drm_atomic_state *state)
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+	struct drm_device *drm = bridge->dev;
 	int ret;
 
 	ret = mtk_dsi_poweron(dsi);
 	if (ret < 0)
-		DRM_ERROR("failed to power on dsi\n");
+		drm_err(drm, "failed to power on dsi\n");
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
@@ -916,7 +920,7 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 	ret = drm_simple_encoder_init(drm, &dsi->encoder,
 				      DRM_MODE_ENCODER_DSI);
 	if (ret) {
-		DRM_ERROR("Failed to encoder init to drm\n");
+		drm_err(drm, "Failed to encoder init to drm\n");
 		return ret;
 	}
 
@@ -932,7 +936,7 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 
 	dsi->connector = drm_bridge_connector_init(drm, &dsi->encoder);
 	if (IS_ERR(dsi->connector)) {
-		DRM_ERROR("Unable to create bridge connector\n");
+		drm_err(drm, "Unable to create bridge connector\n");
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
@@ -985,6 +989,7 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host *host,
 {
 	struct mtk_dsi *dsi = host_to_dsi(host);
 	struct device *dev = host->dev;
+	struct drm_device *drm = dsi->bridge.dev;
 	int ret;
 
 	dsi->lanes = device->lanes;
@@ -1012,7 +1017,7 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host *host,
 
 	ret = component_add(host->dev, &mtk_dsi_component_ops);
 	if (ret) {
-		DRM_ERROR("failed to add dsi_host component: %d\n", ret);
+		drm_err(drm, "failed to add dsi_host component: %d\n", ret);
 		drm_bridge_remove(&dsi->bridge);
 		return ret;
 	}
@@ -1034,11 +1039,12 @@ static void mtk_dsi_wait_for_idle(struct mtk_dsi *dsi)
 {
 	int ret;
 	u32 val;
+	struct drm_device *drm = dsi->bridge.dev;
 
 	ret = readl_poll_timeout(dsi->regs + DSI_INTSTA, val, !(val & DSI_BUSY),
 				 4, 2000000);
 	if (ret) {
-		DRM_WARN("polling dsi wait not busy timeout!\n");
+		drm_warn(drm, "polling dsi wait not busy timeout!\n");
 
 		mtk_dsi_enable(dsi);
 		mtk_dsi_reset_engine(dsi);
@@ -1123,6 +1129,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 				     const struct mipi_dsi_msg *msg)
 {
 	struct mtk_dsi *dsi = host_to_dsi(host);
+	struct drm_device *drm = dsi->bridge.dev;
 	ssize_t recv_cnt;
 	u8 read_data[16];
 	void *src_addr;
@@ -1153,7 +1160,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	}
 
 	if (!msg->rx_buf) {
-		DRM_ERROR("dsi receive buffer size may be NULL\n");
+		drm_err(drm, "dsi receive buffer size may be NULL\n");
 		ret = -EINVAL;
 		goto restore_dsi_mode;
 	}
@@ -1177,7 +1184,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	if (recv_cnt)
 		memcpy(msg->rx_buf, src_addr, recv_cnt);
 
-	DRM_INFO("dsi get %zd byte data from the panel address(0x%x)\n",
+	drm_info(drm, "dsi get %zd byte data from the panel address(0x%x)\n",
 		 recv_cnt, *((u8 *)(msg->tx_buf)));
 
 restore_dsi_mode:
-- 
2.43.0

