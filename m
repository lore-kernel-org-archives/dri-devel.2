Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8656F3D601
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 09:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4022D10E44B;
	Sun, 29 Mar 2026 09:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="TaSP/b8G";
	dkim-atps=neutral
X-Greylist: delayed 1879 seconds by postgrey-1.36 at gabe;
 Sat, 28 Mar 2026 12:34:50 UTC
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com
 [203.205.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B53710E05B
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1774701286;
 bh=WZluaPtQ69k8l7GuzC05bLl+YyxVVYSeaFjn8/5d2wA=;
 h=From:To:Cc:Subject:Date;
 b=TaSP/b8GrleOSknnrILVPQA9eTQUL41SVs7CaGDG2rtuzRQDG8kMjTlY5wiypfUHT
 v+cfItS/Lj9Q2Cesyf1spmyRv/FACCFxQd6AaoRDaaFClEKmtzTD4psBr0FBkr90jK
 LHPPz1HGaRtXvwK9f2ZkBCJKnPpwCtAZSGwIa8MM=
Received: from furnace.. ([2408:8207:24a6:39c0:bc6b:e2e:87c0:c5dc])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id D591EF9; Sat, 28 Mar 2026 20:03:21 +0800
X-QQ-mid: xmsmtpt1774699401tvx4ac6a3
Message-ID: <tencent_E0E7D83DF383CC08960CF0070BF1E7CC8505@qq.com>
X-QQ-XMAILINFO: MTEKjEyAppcsPuCah8PQ/+At89IggxJs4hlZiWgba03V1ZItHLvRRkJCJHXbSi
 19foMxPEA/JJpn5c0R0uCyK1w8izWO8GqY7bmPcxwg4maZYgOEORJQoaghwInKK0zehZeHos1iMT
 khxxYpw31u99zmby2RzYyMWQPkvUxYpqiLdIzEgEIuU7rRC/2TzwYK1TolKmZfSlJtqilhmbVl/3
 Xr52WsBxujH27tXLl+IoCFF3cdxgAoXYf4S3v70vfZS2Cp4INMEqRawLcpXTnsCXhtcA42hPYZak
 se1vf2ioDp1q8Kbb+pi9BR6qyGTMQ2fVCK7vAoBtkJafN4oe+hyV66y3jF5lxmDKVpqCf/FoWZLC
 wa+e2FegIHP29oQ3mF7X+/AeNHXubzFMpwJdoBNKvymzPf4RSOpBMKWVLap9qMeuLrZx4iYWHGBn
 p04kpLJ47EkeKeSZPh3qtLA/8hN5BAV9sAgmXASPkgvWu4P1OZbH+YrSiMJ5NtVXHAEBoVuxzad6
 rRXo55bMFzstv8ZAKVQQ6NTFo6EHvZrfq+VflLz3G1CUQqjl6DLE2opnAnoOyc1kHhET1UfI7Kov
 KqoC9rj/+Z9OrHlfoW4OtznEpJcQuggiXOzFW74qTHW4DE2We7DN47eUEVZk/I+1MDn1tMu+JksT
 r4zCu0KRK3mFiOAynZG9TmcnIl9b0oGwYCVZyg542uXSKCabOSyCwmxayjSUuStsbp0h/XeYj89V
 3jLJM96urHnhMSJZaCvz1zLpnXzTAVvR4XLQ+N5kMfZcdQ4mSu12Q+W2cyh0jmodz+MpNBBh8uBq
 qWi+lvfIjSw3H74ZRCV9RcbxuWl0Ys8ghIHfSBe4JVVtrqv1Y3fcmropppFkHH4U3mUZ21yNo4ao
 w8kInopReL3v1dAva4lMKpeZZiFuqKLfUgqErbHrV5mg/v6qH3ldIDsrl/QhQwzQIvASTbaJUVOg
 J67TSmfwRNMBibe/6r/GstS9A5BkLGUACL6BKp4LrBOAeb+c04JxkbzIsP59uD+3gEz5QPxElmUN
 kHCF76WEdMG9tVv8PMxPktfF2MgrI7E8S4seJFNeDEd/XhKZ1mvLO+FT4F0ZPEBd70M8t4Nw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: YoungAndSure <yangshuorex@foxmail.com>
To: dri-devel@lists.freedesktop.org
Cc: neil.armstrong@linaro.org, dianders@chromium.org,
 YoungAndSure <yangshuorex@foxmail.com>
Subject: [PATCH] drm/panel: jdi-lt070me05000: Transition to mipi_dsi *_multi()
 functions
Date: Sat, 28 Mar 2026 20:03:21 +0800
X-OQ-MSGID: <20260328120321.2677141-1-yangshuorex@foxmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:53:39 +0000
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

Replace deprecated mipi_dsi_generic_write() and mipi_dsi_dcs_*()
functions with their *_multi() variants in jdi_panel_init() for better
error handling.  The multi versions handle errors automatically and
accumulate them in mipi_dsi_multi_context, removing the need for
repetitive error checking code.

Signed-off-by: YoungAndSure <yangshuorex@foxmail.com>
---
 .../gpu/drm/panel/panel-jdi-lt070me05000.c    | 71 ++++---------------
 1 file changed, 13 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index 3513e5c4dd..e5deb39e75 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -48,34 +48,17 @@ static inline struct jdi_panel *to_jdi_panel(struct drm_panel *panel)
 static int jdi_panel_init(struct jdi_panel *jdi)
 {
 	struct mipi_dsi_device *dsi = jdi->dsi;
-	struct device *dev = &jdi->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_soft_reset(dsi);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_soft_reset_multi(&ctx);
 
 	usleep_range(10000, 20000);
 
-	ret = mipi_dsi_dcs_set_pixel_format(dsi, MIPI_DCS_PIXEL_FMT_24BIT << 4);
-	if (ret < 0) {
-		dev_err(dev, "failed to set pixel format: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_column_address(dsi, 0, jdi->mode->hdisplay - 1);
-	if (ret < 0) {
-		dev_err(dev, "failed to set column address: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_page_address(dsi, 0, jdi->mode->vdisplay - 1);
-	if (ret < 0) {
-		dev_err(dev, "failed to set page address: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_pixel_format_multi(&ctx, MIPI_DCS_PIXEL_FMT_24BIT << 4);
+	mipi_dsi_dcs_set_column_address_multi(&ctx, 0, jdi->mode->hdisplay - 1);
+	mipi_dsi_dcs_set_page_address_multi(&ctx, 0, jdi->mode->vdisplay - 1);
 
 	/*
 	 * BIT(5) BCTRL = 1 Backlight Control Block On, Brightness registers
@@ -83,56 +66,28 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 	 * BIT(3) BL = 1    Backlight Control On
 	 * BIT(2) DD = 0    Display Dimming is Off
 	 */
-	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
-				 (u8[]){ 0x24 }, 1);
-	if (ret < 0) {
-		dev_err(dev, "failed to write control display: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
 
 	/* CABC off */
-	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_POWER_SAVE,
-				 (u8[]){ 0x00 }, 1);
-	if (ret < 0) {
-		dev_err(dev, "failed to set cabc off: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "failed to set exit sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
 
 	msleep(120);
 
-	ret = mipi_dsi_generic_write(dsi, (u8[]){0xB0, 0x00}, 2);
-	if (ret < 0) {
-		dev_err(dev, "failed to set mcap: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_generic_write_multi(&ctx, (u8[]){0xB0, 0x00}, 2);
 
 	mdelay(10);
 
 	/* Interface setting, video mode */
-	ret = mipi_dsi_generic_write(dsi, (u8[])
-				     {0xB3, 0x26, 0x08, 0x00, 0x20, 0x00}, 6);
-	if (ret < 0) {
-		dev_err(dev, "failed to set display interface setting: %d\n"
-			, ret);
-		return ret;
-	}
+	mipi_dsi_generic_write_multi(&ctx,
+				     (u8[]){0xB3, 0x26, 0x08, 0x00, 0x20, 0x00}, 6);
 
 	mdelay(20);
 
-	ret = mipi_dsi_generic_write(dsi, (u8[]){0xB0, 0x03}, 2);
-	if (ret < 0) {
-		dev_err(dev, "failed to set default values for mcap: %d\n"
-			, ret);
-		return ret;
-	}
+	mipi_dsi_generic_write_multi(&ctx, (u8[]){0xB0, 0x03}, 2);
 
-	return 0;
+	return ctx.accum_err;
 }
 
 static int jdi_panel_on(struct jdi_panel *jdi)
-- 
2.34.1

