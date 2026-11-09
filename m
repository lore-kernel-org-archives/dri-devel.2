Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F74606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mo7290iF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DE010E254;
	Mon,  9 Nov 2026 16:07:21 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104DF10E3D2
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:07:15 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so12828805e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794240433; x=1794845233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+NgIZ94zuDgUp+uszh12oHM+e3kglPF/onpqBOfOj5g=;
 b=Mo7290iFzUlVgWJpT82sj3YZak1lqNCb9I70oGGU0XmurbsTKHl9npjs9QD7jrkD78
 6C9e4K/3/IdeyfD5z/jmz84N31uMwlPLrY+16OrhGG3acaIP2Dxu0Rs3hDCv/miX+Ng9
 Nr6okJ3tYLm8djno4abindTV2c3DLfb8Ok5SMkq4Zl87B1fbuBwHLpw82fl3L4mvACcX
 t0bvFtcZAxFuiZlyDc3nl+GHRdL4yUgE/cUmFyTrjgprORMuJNsL4ugJDAEOXrYCVBW+
 LuCYqIkudsRg+J37+giDxxWbOMElz2okWieFJPGB6LUL+ZgA4Mkbp8sOq4MuLPAk+gHI
 IwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240433; x=1794845233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+NgIZ94zuDgUp+uszh12oHM+e3kglPF/onpqBOfOj5g=;
 b=D9XuTC7XN9DCMadPWG41e4T08A0M0bmJMNR4Ur0+nHvCu/APE2C70TuQMylbgLwzrn
 RVfQlf/fZUTz9PHMHpxWTC2XPgVepBgKkeeIMmbZUMWJBbh31/xYOUZkIFtJMroRaL3l
 6r9LcV6F3lqpVgyB6fSxBpT/iuXQmPc6GiR+H3niijESS6ZCkWWeiqFVlVW01Fa8l++D
 iQtx7qN+VYD7IxLxJ0DSIUZCOpTVl8ReyWYoNNPhg78/E+QaOms13EYRNfK5y1/nEnOd
 qOgOzFizFg0Wjvj+TQNpfEWzqZCbWrYcIYCsQ5jvSzm3+qLyYwuUH4Mkz144teJcHyhu
 tM1g==
X-Forwarded-Encrypted: i=1;
 AL+hErFhbeR1EK0Un8LvFy4zP8IoSOl244n+TA6wUBmtcvrliK4I4n0k2ZDl/Gbm13Jrzdsgm1FBlEp9iJU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z85baORaBQJstx02A4PgsKdsIXL4DQjr+g5iJHE/paMIWV3KOKi
 7V8g/ZSpmGdiUQHFHD1Cr/gB/cyYHTFiw//K4q6wEOXbIMumh/k8eVQ1
X-Gm-Gg: AYBFou3ZlgVXWHPPDGB6Z7tAJYBYYAVQHJ4Tw0vwegOpMFXl+z17sj1SRsW4FwOX8lE
 A/CAAP2z7pxVjo+ifGEDceMhgidHFXIFvT+FqSKiCEktukc2JyvJPOyJHfneDa0XMoAzurPZ233
 3rJCA/K2IwcIOMmNAzfDfp9Vv9fCPs2fsvC8aDzyc6dd9uJIS0K3pr/1St49pmVBx/Jel/2hgt1
 OpBfmOB74iiBgqgggTptktDokngKM3zyhKRYo2CYM3kVcusgaytIWs4pMnF5zpj0D5mD2lRl0iO
 V4tQUHACJTr9z0zmj75GHQ2cAEROEFtR3UPNXdVzCjHpRQ722V194K+2aGvPoMizLLpp3L8Td9U
 U9F7weA5fmufx2xxjzStLOmI02Upxn4md26xz94vMOqVE2EGfoOBFR5HA96kgJbw05QVAbXY+iT
 jgmiK44K2XMd3cmzNL3wgOCtFwkbn2HOcojkXGu/QlqsaTkPKLxCq6JobMxpelQ5U8P037J8nKL
 bLt+HR+YgcdVEs/0rpkCJR8VU2+R+Otu8t5bVwRgn7aO+RsIy1wOvAo4hPuP5SewlTSuVMGCcYL
 ojK76dMpgi+V/Y1m/lYQivLuWgoXu2MKYbVvQh3zWddI9SkQ0PCeAcev1qTvW5cd3MOrVnpRSbu
 1Aj//6aue/pOxP5srCr4gnptc9eSSyCpGRaXS+bLrBLISbglXt9qpSz2Ly9AoisA=
X-Received: by 2002:a05:600c:1d0a:b0:4b1:4017:c4f4 with SMTP id
 5b1f17b1804b1-4b963c741f8mr77671625e9.20.1794240433343; 
 Mon, 09 Nov 2026 08:07:13 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:863:742:6109:ac9d:152:38c3:6463])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90f119b96sm159174245e9.15.2026.11.09.08.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:07:13 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Igor Reznichenko <igor@reznichenko.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: [PATCH v2 3/3] drm/panel: ilitek-ili9488: add the PocketGo S30 panel
Date: Mon,  9 Nov 2026 17:07:06 +0100
Message-ID: <20261109160706.2272332-4-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109160706.2272332-1-romain.tisserand@gmail.com>
References: <20261109160706.2272332-1-romain.tisserand@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Miyoo PocketGo S30 handheld (Allwinner A33) has a 320x480 1-lane
MIPI-DSI panel built around an Ilitek ILI9488.

The init sequence is the stock kernel's, read back from the running
stock system. It differs from the E35GH-I-MW800CB sequence only in VCOM
(0x26 instead of 0x25), the display function control (2 parameters
instead of 3) and the position of the inversion command. The interface
pixel format (COLMOD) is kept at the stock value.

Timings and video mode are from the stock configuration: 12 MHz pixel
clock, htotal 382, vtotal 524, active low sync (lcd_hv_sync_polarity 0),
non-burst video mode with sync pulses and without EoT packets.

Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9488.c b/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
index 6ab8ae72abbf..29b869a6e909 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
@@ -86,6 +86,50 @@ static const struct drm_display_mode e35gh_i_mw800cb_display_mode = {
 	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 };
 
+static void pocketgo_s30_init(struct mipi_dsi_multi_context *ctx)
+{
+	/* Gamma control 1,2 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xE0, 0x00, 0x10, 0x14, 0x01, 0x0E, 0x04, 0x33,
+				     0x56, 0x48, 0x03, 0x0C, 0x0B, 0x2B, 0x34, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xE1, 0x00, 0x12, 0x18, 0x05, 0x12, 0x06, 0x40,
+				     0x34, 0x57, 0x06, 0x10, 0x0C, 0x3B, 0x3F, 0x0F);
+	/* Power control 1,2 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xC0, 0x0F, 0x0C);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xC1, 0x41);
+	/* VCOM Control */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xC5, 0x00, 0x26, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x36, 0x48);
+	/* Interface pixel format 18bpp */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x3A, 0x66);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB1, 0xA0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB4, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB6, 0x02, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xE9, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x21);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xF7, 0xA9, 0x51, 0x2C, 0x82);
+}
+
+static const struct drm_display_mode pocketgo_s30_display_mode = {
+	.clock = 12000,
+
+	.hdisplay = 320,
+	.hsync_start = 320 + 22,
+	.hsync_end = 320 + 22 + 12,
+	.htotal = 320 + 22 + 12 + 28,
+
+	.vdisplay = 480,
+	.vsync_start = 480 + 22,
+	.vsync_end = 480 + 22 + 4,
+	.vtotal = 480 + 22 + 4 + 18,
+
+	.width_mm = 49,
+	.height_mm = 74,
+
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
 static inline struct ili9488 *panel_to_ili9488(struct drm_panel *panel)
 {
 	return container_of(panel, struct ili9488, panel);
@@ -269,8 +313,19 @@ static const struct ili9488_desc e35gh_i_mw800cb_desc = {
 	.bpc = 6,
 };
 
+static const struct ili9488_desc pocketgo_s30_desc = {
+	.init_sequence = pocketgo_s30_init,
+	.display_mode = &pocketgo_s30_display_mode,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 1,
+	.bpc = 6,
+};
+
 static const struct of_device_id ili9488_of_match[] = {
 	{ .compatible = "focuslcds,e35gh-i-mw800cb", .data = &e35gh_i_mw800cb_desc },
+	{ .compatible = "miyoo,pocketgo-s30-panel", .data = &pocketgo_s30_desc },
 	{ }
 };
 
-- 
2.43.0

