Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33F0C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D871810E6D8;
	Thu, 17 Sep 2026 16:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="togRMzhk";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B474910E4F6
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zUxbVeJDppzpwrVW9tUGBtinYr+rW3ftNjfGxwjtIRk=; b=togRMzhkcsYyzbdcktxpbnTT22
 YAmtmjd30smB0RobNkzn2boWR53wbEqYpDT0rWPN1VGZ4zu2u3k5GujDb3833B6G7cc41p67ap6B6
 mCpACSKCPEKNX2KAIjZ27viOpu6IvmB+8hruTTCXLNNl9QgIfz4azMx4U1J2IHJ4516I=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (envelope-from <alexeymin@minlexx.ru>)
 id 1x7FDi-0000000Bw3I-1tqM; Thu, 17 Sep 2026 19:44:23 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
Date: Thu, 17 Sep 2026 19:43:07 +0300
Subject: [PATCH v2 5/9] drm/panel: novatek-nt36672a: Combine two init
 callbacks into one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nt36672a-panels-v2-5-f8de8be5b86f@minlexx.ru>
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
In-Reply-To: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
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

The split between .send_init_cmds_1 and _cmds_2 is completely artificial
and unnecessary. Two command sets are split in between by the sequence:
 - exit_sleep_mode
 - delay
 - set_display_on

But not every panel driver follows this "split" in their init sequence.
Some may have different delay timer, or put exit_sleep_mode/display_on
commands into other places in the sequence.

In order to make this driver more extensible, combine two init functions
into one by puting exit_sleep_mode/delay/display_on in the middle,
followed by commands from cmds_2. As part of this step, also move the
tianma-beryllium specific deinit sequence with its delays from
nt36672a_panel_unprepare() to tianma_fhd_video_send_deinit_cmds(), so
that each panel model can have its deinit sequence with its own delays.

No functional change - full init sequence with all the delays for the
tianma_fhd_video panel is kept the same in the end.

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

---
v2: move tianma_fhd deinit commands into its own deinit function
    (set_display_off, msleep, enter_sleep_mode, msleep)
---
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 61 ++++++++++----------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 73bec4f47ec60..a445c8067aa5f 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -51,8 +51,7 @@ struct nt36672a_panel_desc {
 	enum mipi_dsi_pixel_format format;
 	unsigned int lanes;
 
-	void (*send_init_cmds_1)(struct mipi_dsi_multi_context *dsi_ctx);
-	void (*send_init_cmds_2)(struct mipi_dsi_multi_context *dsi_ctx);
+	void (*send_init_cmds)(struct mipi_dsi_multi_context *dsi_ctx);
 	void (*send_deinit_cmds)(struct mipi_dsi_multi_context *dsi_ctx);
 };
 
@@ -92,20 +91,6 @@ static int nt36672a_panel_unprepare(struct drm_panel *panel)
 	if (pinfo->desc->send_deinit_cmds)
 		pinfo->desc->send_deinit_cmds(&dsi_ctx);
 
-	/* Reset error to continue with display off even if send_cmds failed */
-	dsi_ctx.accum_err = 0;
-	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
-	/* Reset error to continue power-down even if display off failed */
-	dsi_ctx.accum_err = 0;
-
-	/* 120ms delay required here as per DCS spec */
-	msleep(120);
-
-	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
-
-	/* 0x3C = 60ms delay */
-	msleep(60);
-
 	nt36672a_panel_power_off(panel);
 
 	return 0;
@@ -140,22 +125,9 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 
 	dsi_ctx.accum_err = nt36672a_panel_power_on(pinfo);
 
-	/* send first part of init cmds */
-	if (pinfo->desc->send_init_cmds_1)
-		pinfo->desc->send_init_cmds_1(&dsi_ctx);
-
-	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
-
-	/* 0x46 = 70 ms delay */
-	mipi_dsi_msleep(&dsi_ctx, 70);
-
-	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
-
-	/* Send rest of the init cmds */
-	if (pinfo->desc->send_init_cmds_2)
-		pinfo->desc->send_init_cmds_2(&dsi_ctx);
-
-	mipi_dsi_msleep(&dsi_ctx, 120);
+	/* send init cmds */
+	if (pinfo->desc->send_init_cmds)
+		pinfo->desc->send_init_cmds(&dsi_ctx);
 
 	if (dsi_ctx.accum_err < 0)
 		gpiod_set_value(pinfo->reset_gpio, 0);
@@ -192,7 +164,7 @@ static const struct drm_panel_funcs panel_funcs = {
 	.get_modes = nt36672a_panel_get_modes,
 };
 
-static void tianma_fhd_video_send_init_cmds_1(struct mipi_dsi_multi_context *dsi_ctx)
+static void tianma_fhd_video_send_init_cmds(struct mipi_dsi_multi_context *dsi_ctx)
 {
 	u8 reg;
 
@@ -352,15 +324,19 @@ static void tianma_fhd_video_send_init_cmds_1(struct mipi_dsi_multi_context *dsi
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0xff);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x00);
-}
 
-static void tianma_fhd_video_send_init_cmds_2(struct mipi_dsi_multi_context *dsi_ctx)
-{
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
+	/* 0x46 = 70 ms delay */
+	mipi_dsi_msleep(dsi_ctx, 70);
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
+
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x24);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc3, 0x01);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc4, 0x54);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
+
+	mipi_dsi_msleep(dsi_ctx, 120);
 }
 
 static void tianma_fhd_video_send_deinit_cmds(struct mipi_dsi_multi_context *dsi_ctx)
@@ -369,6 +345,16 @@ static void tianma_fhd_video_send_deinit_cmds(struct mipi_dsi_multi_context *dsi
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc3, 0x01);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
+
+	/* Reset error to continue with display off even if send_cmds failed */
+	dsi_ctx->accum_err = 0;
+	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
+	/* Reset error to continue power-down even if display off failed */
+	dsi_ctx->accum_err = 0;
+	/* 120ms delay required here as per DCS spec */
+	msleep(120);
+	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
+	msleep(60); /* 0x3C = 60ms delay */
 }
 
 static const struct drm_display_mode tianma_fhd_video_panel_default_mode = {
@@ -399,8 +385,7 @@ static const struct nt36672a_panel_desc tianma_fhd_video_panel_desc = {
 			| MIPI_DSI_MODE_VIDEO_BURST,
 	.format = MIPI_DSI_FMT_RGB888,
 	.lanes = 4,
-	.send_init_cmds_1 = tianma_fhd_video_send_init_cmds_1,
-	.send_init_cmds_2 = tianma_fhd_video_send_init_cmds_2,
+	.send_init_cmds = tianma_fhd_video_send_init_cmds,
 	.send_deinit_cmds = tianma_fhd_video_send_deinit_cmds,
 };
 

-- 
2.55.0

