Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31D0C88E40
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB12310E299;
	Sun, 13 Sep 2026 06:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="FghLU0R3";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1797010E299
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 06:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=65W/FSxxZFdwnexgqJn56yiNp1ZgSH9CLT9ySrXuhO0=; b=FghLU0R3Rk4JxTWAG3e+ZlavHA
 f2kutqnRTzEAQGV1Vg6XKIH8VYbsK1UMd7cT3e0cGbZqrZuekudzjt81gSQlzqi5eCypO3Dp+4NGW
 abdIew/pvR5LVMZ3xzJ6a1r127vR3fmoQkROofJXamMUPbeub7eGQo/Ly3wQEjrXVsg0=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (envelope-from <alexeymin@minlexx.ru>)
 id 1x5cuK-0000000Dxg1-1aUj; Sun, 13 Sep 2026 08:37:41 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
Date: Sun, 13 Sep 2026 08:36:39 +0300
Subject: [PATCH 7/9] drm/panel: novatek-nt36672a: Add Tianma panel for
 Xiaomi Mi A2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-nt36672a-panels-v1-7-ce097402c6ea@minlexx.ru>
References: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
In-Reply-To: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 phone-devel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
X-Mailer: b4 0.16.0
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

Add support for Tianma TL060FVXS16-00 video mode panel based on
Novatek NT36672A, used in Xiaomi Mi A2 smartphone (xiaomi-jasmine).
It shares some code with already supported panel in this driver
for xiaomi-lavender, so we can reuse the same panel deinit function.

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index e6971ba6ef464..1bfa808365874 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -445,6 +445,29 @@ static void lavender_tulip_deinit_cmds(struct mipi_dsi_multi_context *dsi_ctx)
 	mipi_dsi_msleep(dsi_ctx, 120);
 }
 
+static void tianma_jasmine_init_cmds(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	dsi_ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x20);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PARTIAL_ROWS, 0x10);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PARTIAL_COLUMNS, 0x50);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x32, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 70);
+
+	mipi_dsi_dcs_set_display_brightness_multi(dsi_ctx, 0x00ff);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x68, 0x03, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
+	usleep_range(5000, 6000);
+}
+
 static const struct drm_display_mode tianma_fhd_video_panel_default_mode = {
 	.clock		= 161331,
 
@@ -556,6 +579,39 @@ static const struct nt36672a_panel_desc tianmaplus_e7t_tulip_panel_desc = {
 	.send_deinit_cmds = lavender_tulip_deinit_cmds,
 };
 
+static const struct drm_display_mode tianma_jasmine_panel_default_mode = {
+	.clock		= (1080 + 96 + 4 + 56) * (2160 + 4 + 2 + 33) * 60 / 1000,
+
+	.hdisplay	= 1080,
+	.hsync_start	= 1080 + 96,
+	.hsync_end	= 1080 + 96 + 4,
+	.htotal		= 1080 + 96 + 4 + 56,
+
+	.vdisplay	= 2160,
+	.vsync_start	= 2160 + 4,
+	.vsync_end	= 2160 + 4 + 2,
+	.vtotal		= 2160 + 4 + 2 + 33,
+
+	.width_mm = 68,
+	.height_mm = 136,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct nt36672a_panel_desc tianma_jasmine_panel_desc = {
+	.display_mode = &tianma_jasmine_panel_default_mode,
+
+	.width_mm = 68,
+	.height_mm = 136,
+
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+	.send_init_cmds = tianma_jasmine_init_cmds,
+	/* jasmine panel uses the same deinit sequence as lavender/tulip */
+	.send_deinit_cmds = lavender_tulip_deinit_cmds,
+};
+
 static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
 {
 	struct device *dev = &pinfo->link->dev;
@@ -634,6 +690,7 @@ static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
 static const struct of_device_id panel_nt36672a_match[] = {
 	{ .compatible = "shenchao,fhdplus-video", .data = &shenchao_lavender_panel_desc },
 	{ .compatible = "tianma,fhd-video", .data = &tianma_fhd_video_panel_desc },
+	{ .compatible = "tianma,tl060fvxs16-00", .data = &tianma_jasmine_panel_desc },
 	{ .compatible = "tianma,tl063fvmca01-00", .data = &tianma_lavender_panel_desc },
 	{ .compatible = "tianma,tl063fvmc43-02", .data = &tianmaplus_e7t_tulip_panel_desc },
 	{ },

-- 
2.55.0

