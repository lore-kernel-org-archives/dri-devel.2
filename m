Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5CCFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F3710E2AF;
	Mon, 27 Apr 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="jTLfo309";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="ZvhCPiuk";
	dkim-atps=neutral
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26CF10E2BB
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1777298202; bh=18NYeaQ+mVybiXnZoHTdPXC31Y87nOeJpcTxWS0RO8A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jTLfo309rSOvCXDyT+8rU/3neR1kZ5f7IA5vgv0MM8QFNs/PqNUzxbXXYO8YgE+Df
 YBokwzOwbMUIbZ6ZmRbiA/6s27Wqw2BhuEa0ptfkwBiv0l2e+V/KnQr/BxE9SeAJed
 KjCCaE6f0wuC9BbMzsyt1fW1ZORQ95/lVD5RIFDKkFDPRwJlOUtYaYwCRZ6fQfdQ0o
 0C9wBhVDYTv9+h2FOzH1Y50236GyvkRzkEzx+9Yyfr7O1lNCTSpKGKR4uWEFeG+wTt
 0U1eZ17zZz0lZ/2mbYp2z+44J53iFGZHbcPJnSk9InvkWOQB2xscRIe3X2oe/Ogkxs
 ffQeEw1RPeedA==
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id B4906FB02;
 Mon, 27 Apr 2026 15:56:42 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZsWk8qix5cl; Mon, 27 Apr 2026 15:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1777298195; bh=18NYeaQ+mVybiXnZoHTdPXC31Y87nOeJpcTxWS0RO8A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZvhCPiuk9Oil4YBIvzlgHLcDJ0GoWbRWHajmIDWLk89wChekaFdBbtwP6kosB0/N7
 5CcKTlKdTU7AjgywlmuqYGoljvISWcUXxNuqtI2MlPW+858PHSINvpGsb4AOqwCF/P
 wcd3f2Vg/kuZ7ymlRSZgz7WH4DTCadGD0xSaCHUoppBIQ+uKa49eTCjeAAMm9cFYyj
 wH1ZiJpaYd/t73u/2r+3xmnBb6SjPP0FgYJD6HMKQJL2ZRmVQipEnNkTH3SEeoIYeP
 WveHW26cE662Xwqm+oOI9UbB1dqEyGeRj7VeysrBT596WPOmSSAhwBQFuT/76dfwws
 wsKdcVv2TX1Dg==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Mon, 27 Apr 2026 15:56:06 +0200
Subject: [PATCH 1/2] drm/panel: visionox-rm69299: Split DSI commands out
 into enable/disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-visionox-rm69299-enable-v1-1-fa7d62d26d87@sigxcpu.org>
References: <20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org>
In-Reply-To: <20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4304; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=18NYeaQ+mVybiXnZoHTdPXC31Y87nOeJpcTxWS0RO8A=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQnA3MnNROVZ6Si9vTWRzczVVdVFpV3dpWG5POEI3CmVWWHNFSzdEdmp3WjRqc1Bo
 YmVKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYWU5ckVBQUt
 DUkFsdjRaU1N2ekI0NFJLRUFDTk56Y0VsOEVaRkxkYjZQeEhmTHNCSHIrK0JibWdBM1NoZnBIbQ
 pub2R3VmxxUVFMTlhBeUZVQ0NyQWpHMHlobWM0VzdvRTlUbU9pN3lMS0xLT3hjYkpXSjJFTFRUS
 itkcWRnUVl5Ckw2SmhTV0dyeVZCYzJWOTFkbDZuOSs1M25ETWdXWmJYK1BZWGlBeDI2c25BVWJ0
 N0JOcDhJeGxNNHprY2phSWUKSXk5dmtLL0VCcmlxVTJVeHpjWVdDTGY4cGNwcnF6T0c2SUJITGF
 MVHU2dWV5RUZhUFJucTNSRkVyYzFwaEJTSQpmUjgvQzlEcDJwMFdxTzZSZ2ZmRzVSeTJPYlN1Mz
 d3VHFpWDMvRFFiemg0N2JFdlFZL1NWTFhQbHFwdmp4S2t2CnVLeHpkSTdYVVBsSlFpaC9hemFMT
 kFiRmo3b0hmS3ZSQVMxVktjeFZJUnZhVFU1eHRERmlZaEhpbmYxZkJOS3kKQ0lOUHZoZE16SVg3
 eFBVZnV0bHlQNHA1eCttRThPUWpja1JsbG8xNVAxd3VuaDZXQTZHY2pGODNFa2RaSVdUTQp1eHk
 5c2FORDBlS0djWkQ0Unc3Q0o0VEl1VjZKdWUwRWU4dzRCaGM2UitISzhKK0l1VlRsS0h0anBWSF
 Z4MVUxCkU1Z3R5d2FVbXpoN2JLRVFQNWtYaWRscWQvSVBKOWVwVlhFdFRnOHcrZWZ6aGVQaE55U
 XVYR09aWGpkWGVlV3IKZXQ0RXFseGlMQndRUjhkYzdzODBuT2Y2cDVGN1g2dXdUd0s1SW5taEtj
 V25tcjRZMmtVVkYzbnRMY04rSmlxegppQ2toRmZlT0lRTEI1VUNZR3o2eFB2OW5uUUVzb3JQd2R
 zQW02TGh1Ly9KdDVtN3VxQXVUT3AwYkpxU2N4NXhhCjNFMTNtUT09Cj02bFZMCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3
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

It's when DSI commands should be sent and it also fixes these DSI errors
on every screen blank/unblank on the SHIFT6mq:

dmesg:
  msm_dsi ae94000.dsi: [drm:dsi_cmds2buf_tx] *ERROR* wait for video done timed out
  dsi_cmds2buf_tx: cmd dma tx failed, type=0x5, data0=0x28, len=4, ret=-110
  panel-visionox-rm69299 ae94000.dsi.0: sending DCS SET_DISPLAY_OFF failed: -110

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 77 +++++++++++++++-----------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index f1430370ff94..3c92a6ceb8df 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -158,6 +158,46 @@ static inline struct visionox_rm69299 *panel_to_ctx(struct drm_panel *panel)
 	return container_of(panel, struct visionox_rm69299, panel);
 }
 
+static int visionox_rm69299_enable(struct drm_panel *panel)
+{
+	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	for (int i = 0; i < ctx->desc->init_seq_len; i++)
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, &ctx->desc->init_seq[i * 2], 2);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	/* Per DSI spec wait 120ms after sending exit sleep DCS command */
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	/* Per DSI spec wait 120ms after sending set_display_on DCS command */
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	return dsi_ctx.accum_err;
+}
+
+static int visionox_rm69299_disable(struct drm_panel *panel)
+{
+	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+
+	/* 120ms delay required here as per DCS spec */
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
+}
+
 static int visionox_rm69299_power_on(struct visionox_rm69299 *ctx)
 {
 	int ret;
@@ -193,16 +233,6 @@ static int visionox_rm69299_power_off(struct visionox_rm69299 *ctx)
 static int visionox_rm69299_unprepare(struct drm_panel *panel)
 {
 	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
-	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
-
-	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
-
-	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
-
-	/* 120ms delay required here as per DCS spec */
-	mipi_dsi_msleep(&dsi_ctx, 120);
-
-	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	return visionox_rm69299_power_off(ctx);
 }
@@ -210,29 +240,8 @@ static int visionox_rm69299_unprepare(struct drm_panel *panel)
 static int visionox_rm69299_prepare(struct drm_panel *panel)
 {
 	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
-	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
-	int ret, i;
 
-	ret = visionox_rm69299_power_on(ctx);
-	if (ret < 0)
-		return ret;
-
-	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
-
-	for (i = 0; i < ctx->desc->init_seq_len; i++)
-		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, &ctx->desc->init_seq[i * 2], 2);
-
-	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
-
-	/* Per DSI spec wait 120ms after sending exit sleep DCS command */
-	mipi_dsi_msleep(&dsi_ctx, 120);
-
-	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
-
-	/* Per DSI spec wait 120ms after sending set_display_on DCS command */
-	mipi_dsi_msleep(&dsi_ctx, 120);
-
-	return dsi_ctx.accum_err;
+	return visionox_rm69299_power_on(ctx);
 }
 
 static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
@@ -284,7 +293,9 @@ static int visionox_rm69299_get_modes(struct drm_panel *panel,
 
 static const struct drm_panel_funcs visionox_rm69299_drm_funcs = {
 	.unprepare = visionox_rm69299_unprepare,
-	.prepare = visionox_rm69299_prepare,
+	.disable   = visionox_rm69299_disable,
+	.prepare   = visionox_rm69299_prepare,
+	.enable	   = visionox_rm69299_enable,
 	.get_modes = visionox_rm69299_get_modes,
 };
 

-- 
2.53.0

