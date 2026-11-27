Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aoREaC6V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC591124B8;
	Fri, 27 Nov 2026 02:08:39 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DED112799
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:08:22 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so76697385e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795745301; x=1796350101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XhodWS1aWkSeFvJLIKsGNbnaDQgoaSu4UhdyHeAK+6E=;
 b=aoREaC6VYpWm5hdvkrE0GZ+Y80vzwef7HHqNOEanNuYQ0vouATCcL27pqfUWiOaxPu
 rNDcfcAlSdzz9o86Lztn5z6D0kGcR95XoCOBbOiDgrH6YYr5xoZkreNJcIkj+i/p1U1W
 Es2ukThxHvnHBIMM3uA1A/tSWR4+7hutOJ8dVhPo2TZrlFymilnczJveFN0163rn+PWK
 6HZA614+Uwmo2Aqvpb1a75XrdIXVxZ30kqwNxhrDtjVSXCqGPzrc49kVeGKVVQ/baJ3c
 xHCQKaTRKRRHnNJgRh91ynxnpOh3maJ/8CP9SON5A6Iwu742v4SqFqzmGgErMITeId7e
 JUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745301; x=1796350101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XhodWS1aWkSeFvJLIKsGNbnaDQgoaSu4UhdyHeAK+6E=;
 b=Ly6QXBfBOvIjmJRLLorjFY4c3py4+Z9mBgwd8C8P3a+5buGjLUwKtNXkL9InXp63rb
 +74759DOl119QhdI5dCtc46RXELWAqR4BAiik41Vzh8YKdn6i4MkTadqsU49To5FpST3
 uRHgg3ClaH0/eJ+sHiyOyAcjjiQXIwPVGh+pLRHkTrNIWdNt8obpZ7s2Zd+Uxgd4Thz+
 YTUK+LGdtOrBJG3C2EOk2SBaY+JZkXjEw7JY5wYcQLLrXyHW1gdbQJGtC6ASfGjr4Cgh
 B250eB2+bVETqN6hP2z53p36rwSin333K0O/pydKCQ6doKkhP0Jakc+MqvyOAR3pBnaq
 s9EQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHI6eT/QtOPn5aT65xmqe3dc6cshZtDVrdsuNx+dXHMJMvBSetim7uVRupcJuEsdNZMIRkPMPlKuQg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9zGiIMSmJZo+w3ZpT5xx8Uu8bz75adjsKP+nAtv/1VDT2wmX4W
 7JfnapwUjkbAQsrwdMBlklSeyKe55fhFFXaLW7j9j/6q7AI+YUe8TUYv
X-Gm-Gg: AZFdTZezfnGQmuDg+zTgRAyhwtu/cqVeRCxTy6euj5aOkBti2WJhsfMWav1OldnfpvE
 yKabQtY+ySYv6PDyIJiEhU1sY+o0es45kfeBjeiwiAnNDLh+IstJT41IcUQ/llUhLwo0ksTbWE6
 QtcJnCtZV3J81ooGVW0OMQebkJbcDpmUIv6DQ//OK+hMuMXrxzI0ca3Ham0mTPQxl+bTGtsCZRy
 1gxm5Bqxx19Xp1g/Jwo/vOLTi6bsaIfuJCizOtlfNURx24zZO1W15SzVCHI2Osw7b7VKDASq7UX
 EZdRYwp/IcLS5tzPT8Aj94RtqlZF1bWUGUx/4j32K0GHdJhec3Px6z6Sa08RhhCY5iMKT4tjN18
 VHB03b7IqXbv/ny17UoGUaSRc+6iAf0IbnQe+C0xrY5dSGnvj0s3vN77TFYUF3Msac8kPBEObsQ
 eKuOw2izwcNgm6L4qKNW/st6/ERJOZ6idaclMgymJG1gOD0kgZB665rQlhymdyvIh3oTm8/nAWF
 fAtvQEY7MDsqxDjHBgK3xeJa9PK8YKlXneEyr1UZcno+ADVj1r1tOi4+YC1JuW+0uSYzfJYyMZw
 6j8R9nHNYdcrnUifMh/h3OZqRvnH428IFb3I3ikpWoMVxdcKHeC6AO7gVsYC7hrJvNXU3WOtw1V
 koj/P/LX/7TdHeWH45SpKrWUcyQw2O+9uq035+ZtuIryDRmMGgKTbaUw5K+NBLw6ZrRc=
X-Received: by 2002:a05:600d:8449:b0:4bb:8e95:8ce1 with SMTP id
 5b1f17b1804b1-4bb8e958ce4mr325490295e9.23.1795745300965; 
 Thu, 26 Nov 2026 18:08:20 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm43390844f8f.49.2026.11.26.18.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:08:20 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
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
Subject: [PATCH 4/4] drm/panel: st7701: add the Miyoo A30 panel
Date: Fri, 27 Nov 2026 03:08:15 +0100
Message-ID: <20261127020815.1621790-5-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127020815.1621790-1-romain.tisserand@gmail.com>
References: <20261127020815.1621790-1-romain.tisserand@gmail.com>
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

The Miyoo A30 handheld (Allwinner A33) has a 480x640 2-lane MIPI-DSI
panel driven by a Sitronix ST7701S.

Its init table, taken from the stock kernel, doesn't fit the encoding of
st7701_init_sequence(): byte 0 of C2 (INVSEL) lacks the 0x30 bits and
RTNI is not derived from htotal. Send it as-is through the new
init_sequence hook.

The stock configuration runs the panel in non-burst video mode with
sync pulses and without EoT packets; in burst mode the picture is
unstable and the colours are wrong.

Timings and size are from the stock configuration: 23 MHz pixel clock,
htotal 560, vtotal 684, 43x57 mm.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index f288c8c8aab8..a87da36dc60a 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -421,6 +421,64 @@ static void dmt028vghmcmi_1a_gip_sequence(struct st7701 *st7701)
 	ST7701_WRITE(st7701, 0x3A, 0x70);
 }
 
+static void miyoo_a30_init_sequence(struct st7701 *st7701)
+{
+	/* Vendor table, from the Miyoo A30 stock kernel (default_panel). */
+	msleep(200);
+
+	st7701_switch_cmd_bkx(st7701, true, 3);
+	ST7701_WRITE(st7701, 0xEF, 0x08);
+
+	st7701_switch_cmd_bkx(st7701, true, 0);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK0_LNESET, 0x4F, 0x00);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK0_PORCTRL, 0x10, 0x0C);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK0_INVSEL, 0x01, 0x14);
+	ST7701_WRITE(st7701, 0xCC, 0x10);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK0_PVGAMCTRL,
+		   0x0A, 0x18, 0x1E, 0x12, 0x16, 0x0C, 0x0E, 0x0D,
+		   0x0C, 0x29, 0x06, 0x14, 0x13, 0x29, 0x33, 0x1C);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK0_NVGAMCTRL,
+		   0x0A, 0x19, 0x21, 0x0A, 0x0C, 0x00, 0x0C, 0x03,
+		   0x03, 0x23, 0x01, 0x0E, 0x0C, 0x27, 0x2B, 0x1C);
+
+	st7701_switch_cmd_bkx(st7701, true, 1);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_VRHS, 0x5D);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_VCOM, 0x71);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_VGHSS, 0x8A);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_TESTCMD, 0x80);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_VGLS, 0x4D);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_PWCTLR1, 0x85);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_PWCTLR2, 0x20);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_SPD1, 0x78);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_SPD2, 0x78);
+	ST7701_WRITE(st7701, ST7701_CMD2_BK1_MIPISET1, 0x88);
+
+	ST7701_WRITE(st7701, 0xE0, 0x00, 0x00, 0x02);
+	ST7701_WRITE(st7701, 0xE1, 0x06, 0xA0, 0x08, 0xA0, 0x05, 0xA0, 0x07,
+		   0xA0, 0x00, 0x44, 0x44);
+	ST7701_WRITE(st7701, 0xE2, 0x20, 0x20, 0x44, 0x44, 0x96, 0xA0, 0x00,
+		   0x00, 0x96, 0xA0, 0x00, 0x00);
+	ST7701_WRITE(st7701, 0xE3, 0x00, 0x00, 0x22, 0x22);
+	ST7701_WRITE(st7701, 0xE4, 0x44, 0x44);
+	ST7701_WRITE(st7701, 0xE5, 0x0D, 0x91, 0x0A, 0xA0, 0x0F, 0x93, 0x0A,
+		   0xA0, 0x09, 0x8D, 0x0A, 0xA0, 0x0B, 0x8F, 0x0A, 0xA0);
+	ST7701_WRITE(st7701, 0xE6, 0x00, 0x00, 0x22, 0x22);
+	ST7701_WRITE(st7701, 0xE7, 0x44, 0x44);
+	ST7701_WRITE(st7701, 0xE8, 0x0C, 0x90, 0x0A, 0xA0, 0x0E, 0x92, 0x0A,
+		   0xA0, 0x08, 0x8C, 0x0A, 0xA0, 0x0A, 0x8E, 0x0A, 0xA0);
+	ST7701_WRITE(st7701, 0xE9, 0x36, 0x00);
+	ST7701_WRITE(st7701, 0xEB, 0x00, 0x01, 0xE4, 0xE4, 0x44, 0x88, 0x40);
+	ST7701_WRITE(st7701, 0xED, 0xFF, 0x45, 0x67, 0xFA, 0x01, 0x2B, 0xCF,
+		   0xFF, 0xFF, 0xFC, 0xB2, 0x10, 0xAF, 0x76, 0x54, 0xFF);
+	ST7701_WRITE(st7701, 0xEF, 0x10, 0x0D, 0x04, 0x08, 0x3F, 0x1F);
+
+	ST7701_WRITE(st7701, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(200);
+
+	ST7701_WRITE(st7701, MIPI_DCS_SET_TEAR_ON, 0x00);
+	ST7701_WRITE(st7701, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
+}
+
 static void kd50t048a_gip_sequence(struct st7701 *st7701)
 {
 	/**
@@ -874,6 +932,35 @@ static const struct st7701_panel_desc dmt028vghmcmi_1a_desc = {
 	.gip_sequence = dmt028vghmcmi_1a_gip_sequence,
 };
 
+static const struct drm_display_mode miyoo_a30_mode = {
+	.clock		= 23000,
+
+	.hdisplay	= 480,
+	.hsync_start	= 480 + 48,
+	.hsync_end	= 480 + 48 + 10,
+	.htotal		= 480 + 48 + 10 + 22,
+
+	.vdisplay	= 640,
+	.vsync_start	= 640 + 26,
+	.vsync_end	= 640 + 26 + 4,
+	.vtotal		= 640 + 26 + 4 + 14,
+
+	.width_mm	= 43,
+	.height_mm	= 57,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct st7701_panel_desc miyoo_a30_desc = {
+	.mode = &miyoo_a30_mode,
+	.lanes = 2,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_sequence = miyoo_a30_init_sequence,
+	/* stock sys_config: lcd_dsi_if = 0 (non-burst video), lcd_dsi_eotp = 0 */
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
+};
+
 static const struct drm_display_mode kd50t048a_mode = {
 	.clock          = 27500,
 
@@ -1401,6 +1488,7 @@ static const struct of_device_id st7701_dsi_of_match[] = {
 	{ .compatible = "anbernic,rg-arc-panel", .data = &rg_arc_desc },
 	{ .compatible = "densitron,dmt028vghmcmi-1a", .data = &dmt028vghmcmi_1a_desc },
 	{ .compatible = "elida,kd50t048a", .data = &kd50t048a_desc },
+	{ .compatible = "miyoo,a30-panel", .data = &miyoo_a30_desc },
 	{ .compatible = "techstar,ts8550b", .data = &ts8550b_desc },
 	{ .compatible = "winstar,wf40eswaa6mnn0", .data = &wf40eswaa6mnn0_desc },
 	{ }
-- 
2.43.0

