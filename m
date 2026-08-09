Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1EBC5AD5A
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 20:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818C810E5BA;
	Sun,  9 Aug 2026 20:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Due7pVUu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xQHZnjd+";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493CB10E5B2
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 20:01:39 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hJ80d5L5hzKmD5;
 Sun, 09 Aug 2026 22:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786305697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQcYfBCZZMtnsgJnUDgQokMrOafV77vdez+yaEZc47s=;
 b=Due7pVUuwbYyb6yBWTmUnE8+otUI445vtW0+rrWiAGlMPfWkRudHa4PSOfX2JemJWwCLIU
 JdDXxyAUjFSFzLsHl7+iWAV2ThGUeWIKTph3Ep2NbIgwWKNDpuM/ph4lRoBbV0jD7XjfQs
 oaJZ//qSNG/stmXbjXP3TQsojvb0nsb1GDyPttnh+XX+ZdiLb/wMDAMCeZlKxFvzHx4u0a
 RH9AZRR2XFYIJy+94n0mkzU7kTGOPZXhyOkMkEGxqXzq6qOfaupRhnZEnYTGfAkzxfh6qq
 mcRtyltLLniMtqNqwgXnhAjaUYUKSjL+oTVIMPCa7Qty7B4HfQQI9YAoqYODpw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786305696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQcYfBCZZMtnsgJnUDgQokMrOafV77vdez+yaEZc47s=;
 b=xQHZnjd+lxxQLcsJ2q/6ANQZEP0YayQ1Q7IvCtlwqgzMU2yUzrkFf/itJf+PhGB+YgrxOy
 Ik1UfWty9jkQD95Kc8uIEbbAjHlkE1GGo40FNpuAgOAjKgt+2OcA3aTB/C2zLrqRBLeCnr
 HESbIwYTt3xM81e+oPpWfbmFJ6ReRW7JuyUkHj1qWGq5ofXEJF0Z1YWBhaqi1E46qmVX9g
 8VcS/6SczUznlz28YPSFX2dauSXCAuRoE0kYpsNGiAwxaFLBYeBbEXF1UPFTb/Y0Biv277
 befwKaFGTeorqfV/5Lzz8PXuGj3Z4pZM3TLtdTMqKovOdswHfbVBBseqNN6bVg==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/4] drm/panel: ilitek-ili9882t: Add support for Ilitek
 ILI79600A-based panels
Date: Sun,  9 Aug 2026 21:58:53 +0200
Message-ID: <20260809200107.842945-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
References: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 859a69f184f28dd62af
X-MBO-RS-META: otw4443bc657krtwobbqc3deq98pyiyb
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

The Ilitek ILI79600A display controller is similar to the ILI9882T and can
be supported within the existing `panel-ilitek-ili9882t.c` driver.

This patch extends the ILI9882T driver to handle ILI79600A-based panels,
such as the 10" Raspberry Pi Touch Display 2. The ILI79600A uses a similar
command sequence and initialization flow, with minor differences in power
supply configuration and timing.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 231 ++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 24e72ad0d29a1..5581100a1f8a5 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -133,6 +133,207 @@ static const struct drm_dsc_config tianma_il79900a_dsc = {
 	.flatness_min_qp = 3,
 };
 
+static int rpi_10inch_init(struct ili9882t *ili)
+{
+	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
+
+	mipi_dsi_usleep_range(&ctx, 5000, 5100);
+
+	il79900a_switch_page(&ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x00, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x02, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x03, 0x00);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x04, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x05, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x06, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x00);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x08, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x09, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0a, 0x71);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0f, 0x00);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x31, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x32, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x33, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x34, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x36, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x37, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x38, 0x29);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x39, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3A, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3B, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3C, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3D, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3E, 0x0D);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3F, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x40, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x41, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x42, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x43, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x44, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x45, 0x02);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x48, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x49, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4A, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4B, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4C, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4D, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4E, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4F, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x50, 0x29);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x51, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x52, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x54, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x56, 0x0C);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x57, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x58, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x59, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5A, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5B, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5C, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5D, 0x02);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2C, 0xB0);
+
+	il79900a_switch_page(&ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x06, 0xD2);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5E, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29, 0x3A);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2A, 0x3B);
+
+	il79900a_switch_page(&ctx, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x3C);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x22, 0xFA);
+
+	il79900a_switch_page(&ctx, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x2C);
+
+	il79900a_switch_page(&ctx, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x61, 0x8F);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6D, 0xBB);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5A, 0x7C);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x67, 0x7C);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x54, 0x92);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x92);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x40, 0xD2);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x46, 0x70);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7A, 0x89);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA4, 0x0B);
+
+	il79900a_switch_page(&ctx, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xC0, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xC1, 0x7);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xCA, 0x58);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xCB, 0x2);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xCE, 0x58);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xCF, 0x2);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x10, 0x0);
+
+	il79900a_switch_page(&ctx, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x76, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x78, 0x68);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x77, 0x0D);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x79, 0x60);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7A, 0x10);
+
+	il79900a_switch_page(&ctx, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&ctx,
+				     0xE0, 0x00, 0x1E, 0x3F,
+				     0x68, 0x7D, 0x72, 0x86,
+				     0x89, 0x92, 0x8E, 0xA5,
+				     0xA8, 0xAA, 0xBD, 0xB8,
+				     0xBE, 0xC5, 0xD6, 0xCD,
+				     0xC3, 0xDA, 0xEB, 0xED);
+	mipi_dsi_dcs_write_seq_multi(&ctx,
+				     0xE1, 0x00, 0x1E, 0x3F,
+				     0x68, 0x7D, 0x72, 0x86,
+				     0x89, 0x92, 0x8E, 0xA5,
+				     0xA8, 0xAA, 0xBD, 0xB8,
+				     0xBE, 0xC5, 0xD6, 0xCD,
+				     0xC3, 0xDA, 0xEB, 0xED);
+
+	il79900a_switch_page(&ctx, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0xCC);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x91);
+
+	il79900a_switch_page(&ctx, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11, 0x3);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x10, 0x1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x13, 0x4);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x14, 0xBB);
+
+	il79900a_switch_page(&ctx, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x94, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x95, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x96, 0x0B);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x97, 0x0B);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x98, 0xC6);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x99, 0xC6);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA6, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA7, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA8, 0x5);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA9, 0x5);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xAA, 0xBA);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xAB, 0xBA);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xBD, 0x92);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xBE, 0xE0);
+
+	il79900a_switch_page(&ctx, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x14, 0x3);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0x0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x13, 0x4);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11, 0x1);
+
+	il79900a_switch_page(&ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x80, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x11);
+	il79900a_switch_page(&ctx, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x2C);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0x2C);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x2C);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x88, 0xEC);
+	il79900a_switch_page(&ctx, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4, 0x1);
+	il79900a_switch_page(&ctx, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0C, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3C, 0x80);
+
+	il79900a_switch_page(&ctx, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0E, 0x0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0E, 0x3F);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x10, 0x0);
+
+	il79900a_switch_page(&ctx, 0x00);
+	mipi_dsi_dcs_set_tear_on_multi(&ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
+
+	mipi_dsi_msleep(&ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
+
+	mipi_dsi_msleep(&ctx, 20);
+
+	return ctx.accum_err;
+};
+
 static int starry_ili9882t_init(struct ili9882t *ili)
 {
 	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
@@ -670,6 +871,19 @@ static int ili9882t_enable(struct drm_panel *panel)
 	return 0;
 }
 
+static const struct drm_display_mode rpi_10inch_default_mode = {
+	.clock = 166666,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 28,
+	.hsync_end = 1200 + 28 + 10,
+	.htotal = 1200 + 28 + 10 + 30,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 238,
+	.vsync_end = 1920 + 238 + 4,
+	.vtotal = 1920 + 238 + 4 + 28,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
 static const struct drm_display_mode starry_ili9882t_default_mode = {
 	.clock = 165280,
 	.hdisplay = 1200,
@@ -696,6 +910,20 @@ static const struct drm_display_mode tianma_il79900a_default_mode = {
 	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 };
 
+static const struct panel_desc rpi_10inch_desc = {
+	.modes = &rpi_10inch_default_mode,
+	.bpc = 8,
+	.size = {
+		.width_mm = 135,
+		.height_mm = 216,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init = rpi_10inch_init,
+};
+
 static const struct panel_desc starry_ili9882t_desc = {
 	.modes = &starry_ili9882t_default_mode,
 	.bpc = 8,
@@ -866,6 +1094,9 @@ static void ili9882t_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id ili9882t_of_match[] = {
+	{ .compatible = "raspberrypi,dsi-10inch",
+	  .data = &rpi_10inch_desc
+	},
 	{ .compatible = "starry,ili9882t",
 	  .data = &starry_ili9882t_desc
 	},
-- 
2.53.0

