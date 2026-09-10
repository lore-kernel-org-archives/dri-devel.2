Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB89EC79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142C310E42A;
	Thu, 10 Sep 2026 18:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b/WMVmNm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SGygRzFi";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C175E10E411
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 18:19:43 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hgmDG1928zMlCq;
 Thu, 10 Sep 2026 20:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789064382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VuGgE5X6V9SY/xFZLkGQ1I9fwLTgUpS7+mItu85ws1w=;
 b=b/WMVmNmeNiPS7qH0FqqmbTy3w1T5PDX+3WHL/aXTD1RhS5YZeOX8qp+0gRN21jS2bEINC
 XX6XAfItsH2yiwm8GhTIinkUbrIE7d56mJI2SMm4GyWcNNsYN2cS6NioR/FZsTch1gJq3I
 Tupbckg98LYrT16Z1fJ2ZcXxzQorI/K41WnUzmYQwCv52HA+meVl7SQFasdLtAN09Opxiv
 LP6opUrjL8CZicnrctKlRcpc1lf6a14L9UqE7uY5gei7SIAxkxCNgdfM4GjDyWMn8apZnm
 GPxkfwwUXGJ/kfxDPOvZqU/GxE1eYIurbYVudxes0f3V0f97rWBJ7upoc9OQBw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SGygRzFi;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789064379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VuGgE5X6V9SY/xFZLkGQ1I9fwLTgUpS7+mItu85ws1w=;
 b=SGygRzFiEpaAWrikPn53zCgROWXOVE/89gxx79oiD7MpQuuL0gfOE714mVAN9uGHfyLPUD
 bbV0bY5ImHKFayWwSelzuuMuW+qga49XripDCxZtykCXW4bEuZUF7bqwXZwDv4rrciBE2J
 Unwh11s1zDi9kKf5t6FhUmA1t5VThCvs5vQPIjPylqpND51LvUijOlCo3UftwZLGohobV1
 cLJHx2Igp6sTkYpPB6EShawSG0r2IbN/CjnQJw4Np2LkUsOkcEIpNMlHWjOsTU0gSXMqa+
 Uei3eV7S5vNuZz4BJM9Jo2zQRvhHzNladuIRq9HUGjxaAh552Ul7TZy6yIqQAQ==
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 4/4] drm/panel: ilitek-ili9882t: Add support for Ilitek
 IL79600A-based panels
Date: Thu, 10 Sep 2026 20:18:45 +0200
Message-ID: <20260910181918.31551-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260910181918.31551-1-marek.vasut+renesas@mailbox.org>
References: <20260910181918.31551-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sncire745xddja5nx41fatt9bt8einot
X-MBO-RS-ID: 0f7a4d87bfebbbb9f64
X-Rspamd-Queue-Id: 4hgmDG1928zMlCq
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

The Ilitek IL79600A display controller is similar to the ILI9882T and can
be supported within the existing `panel-ilitek-ili9882t.c` driver.

This patch extends the ILI9882T driver to handle IL79600A-based panels,
such as the 10" Raspberry Pi Touch Display 2. The IL79600A uses a similar
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
V2: No change
V3: - Rename ILI79600A to IL79600A, there is really no ILI anymore, just IL
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 231 ++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 862b1c81a609b..bea5ca70c775d 100644
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
@@ -847,6 +1075,9 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
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

