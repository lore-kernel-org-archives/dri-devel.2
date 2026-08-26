Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57181C61DC4
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7595210E3CE;
	Wed, 26 Aug 2026 17:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmjV4KYK";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4A810E32C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:49:04 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so181658466b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787766543; x=1788371343; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8tYJ5KaLpfQx62wkTVDpvEmEjM+VL8f8SScga+Yd39Y=;
 b=HmjV4KYKPcIEFIK+XoTENA2O6ywXsl4IIEJ5ZNZ6vbY6Nd52L6GdmMxibY9YhGvCtI
 fSnpJL1SazAkySXBmfubL5Vetetk7MgFXfjuWve9c6gu7+YW7BwjcQbUuirQ410ZEq2n
 Yan77zSBq1D0KbQkFLav9cfVAnrn3HwxJQJFfHrM6WfPP+2MYDYyHclhKFsAkOrv893g
 6BEK8niODnl/xKTSb3uLxK7Ike1tnvuvG57SSajm7LOolag3kgBU8FI0Zs7NyJyoihgy
 0UcABhrKJH9CnoF8e2IdXu2eQHT5cpTGzZQolv+IsGxyK95/geqyjbml2mx2OvVe0xbY
 1ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766543; x=1788371343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8tYJ5KaLpfQx62wkTVDpvEmEjM+VL8f8SScga+Yd39Y=;
 b=Zsz9V5COYmkwq/Sn5fcJeVnX21gqb7dLacsl1G/oKojbrPZozcBK5/xyScYirXIz09
 OSOZfSp/WThHGC3bbA8mjum0SP0wOMS7X7Hbc1l8ZUK5KR329ayN3k7VroqAv+sJvIdn
 YH3WJ6zvvqCL6HvKrxzRZJTFca2/svrKllkNoSp6LlNheuwxmZQfE4YQwhSUlkxMayBT
 0EH9SCuY9nW+FNoOhMFxrOgnZHqT62ea4YoKKoGi9PwjjJ/DAA/BI/4s0P8Cw3WnkaAF
 YffUGetVxErvAsKiKLrUEvRN7LMYM2m1Q3dM7Dc+lCgqUMs6ptgI5y0nz9lUFSLfjOu9
 uiTQ==
X-Gm-Message-State: AFuF++mept8ImXHUGBLKo/kSiUw1VHWo3Qbik6nZJMA1en8alk3dxSTT
 9Ca/oWU4GLivIQMKfZAaDohYuFpNN+KHT0gg8JMPEWxqixSTEPBreriJ
X-Gm-Gg: AR+sD11xn1/jDVfdIzDqrqdqq+iGwZ+J38sryZLV5ZSBi9gSAemDHwn1c47X5QkpTLV
 /82T9RFTtcSR4W9SeDGv4ZZsXsYH0OcuZYxVb+UslztDWhOQxpRApRENZTa+oHNiOdmBabW5DSQ
 tFNvKYHUalfenTHbeDVeDD/aG6R1hyjahtK1VjpMQs1EpAIp7q9A8uQmG2ZPnJimzctESsd+T0Z
 8CsqB5aHfszniYlIpVdr+8UJy5XnP0PQudrI3mbdx5Wn3946SjVrDlEEHMb95dMDMAyThicHuAn
 xZAB1BrUi35G8FoupMwq6yGJrCrlNVKLqTDPQjxlzsaOJQWvxl6ou/Ver8UzCr9LFsJnO+YqVXn
 0kA9QNYvvAPlU1j2gsq9oO0k2hkNou2CKbwFcMqundF9LEDsSMjyQKGOCrgnX0lZxufof/yc2sn
 k+dxirSduklqh/N+smbf+Yv8BXAaZhvMTtkk6R1LDFPfUvX841xRoxHFDDcBewiiJMUgJuerGDK
 IUV/jnJQOT3WQ==
X-Received: by 2002:a17:906:9f86:b0:c24:e0dc:8b66 with SMTP id
 a640c23a62f3a-c250c485f66mr1016315266b.6.1787766542674; 
 Wed, 26 Aug 2026 10:49:02 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:aa64:3da0:a259:ecd5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac7fsm777752766b.30.2026.08.26.10.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:49:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 05/13] drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI
 support
Date: Wed, 26 Aug 2026 18:48:39 +0100
Message-ID: <20260826174854.199139-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for the MIPI DSI controller found on the Renesas RZ/G3L
(R9A08G046) SoC. The D-PHY global timing table of RZ/G3L SoC different
compared to the other SoCs. Introduce a dedicated D-PHY global timing
table rzg3l_mipi_dsi_global_timings and wire it up via a new
rzg3l_mipi_dsi_info hw_info variant for RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Moved set duty cycle to DU encoder.
v1->v2:
 * Replaced syscon_field->pwrrdy in struct rzg3l_mipi_dsi_info.
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 7df5f4a4161b..88ec0612d529 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -226,6 +226,107 @@ static const struct rzg2l_mipi_dsi_timings rzg2l_mipi_dsi_global_timings[] = {
 	},
 };
 
+static const struct rzg2l_mipi_dsi_timings rzg3l_mipi_dsi_global_timings[] = {
+	{
+		.hsfreq_max = 100000000,
+		.t_init = 79801,
+		.tclk_prepare = 10,
+		.ths_prepare = 18,
+		.tclk_zero = 35,
+		.tclk_pre = 13,
+		.tclk_post = 94,
+		.tclk_trail = 10,
+		.ths_zero = 16,
+		.ths_trail = 22,
+		.ths_exit = 15,
+		.tlpx = 9,
+	},
+	{
+		.hsfreq_max = 150000000,
+		.t_init = 79801,
+		.tclk_prepare = 10,
+		.ths_prepare = 16,
+		.tclk_zero = 35,
+		.tclk_pre = 13,
+		.tclk_post = 94,
+		.tclk_trail = 10,
+		.ths_zero = 16,
+		.ths_trail = 15,
+		.ths_exit = 15,
+		.tlpx = 9,
+	},
+	{
+		.hsfreq_max = 250000000,
+		.t_init = 79801,
+		.tclk_prepare = 10,
+		.ths_prepare = 13,
+		.tclk_zero = 35,
+		.tclk_pre = 13,
+		.tclk_post = 58,
+		.tclk_trail = 8,
+		.ths_zero = 16,
+		.ths_trail = 10,
+		.ths_exit = 15,
+		.tlpx = 9,
+	},
+	{
+		.hsfreq_max = 400000000,
+		.t_init = 79801,
+		.tclk_prepare = 10,
+		.ths_prepare = 12,
+		.tclk_zero = 35,
+		.tclk_pre = 4,
+		.tclk_post = 58,
+		.tclk_trail = 7,
+		.ths_zero = 16,
+		.ths_trail = 9,
+		.ths_exit = 15,
+		.tlpx = 9,
+	},
+	{
+		.hsfreq_max = 600000000,
+		.t_init = 79801,
+		.tclk_prepare = 10,
+		.ths_prepare = 11,
+		.tclk_zero = 35,
+		.tclk_pre = 4,
+		.tclk_post = 35,
+		.tclk_trail = 5,
+		.ths_zero = 16,
+		.ths_trail = 6,
+		.ths_exit = 15,
+		.tlpx = 9,
+	},
+	{
+		.hsfreq_max = 1000000000,
+		.t_init = 79801,
+		.tclk_prepare = 10,
+		.ths_prepare = 11,
+		.tclk_zero = 35,
+		.tclk_pre = 4,
+		.tclk_post = 35,
+		.tclk_trail = 5,
+		.ths_zero = 16,
+		.ths_trail = 6,
+		.ths_exit = 15,
+		.tlpx = 9,
+	},
+	{
+		.hsfreq_max = 1500000000,
+		.t_init = 79801,
+		.tclk_prepare = 10,
+		.ths_prepare = 11,
+		.tclk_zero = 35,
+		.tclk_pre = 4,
+		.tclk_post = 35,
+		.tclk_trail = 4,
+		.ths_zero = 16,
+		.ths_trail = 5,
+		.ths_exit = 15,
+		.tlpx = 9,
+	},
+};
+
 /**
  * struct rzv2h_mipi_dsi_timings - Timing parameter table structure
  *
@@ -1580,7 +1681,23 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 	.activation_dly = 1000,
 };
 
+static const struct rzg2l_mipi_dsi_hw_info rzg3l_mipi_dsi_info = {
+	.dphy_init = rzg2l_mipi_dsi_dphy_init,
+	.dphy_exit = rzg2l_mipi_dsi_dphy_exit,
+	.dphy_conf_clks = rzg2l_dphy_conf_clks,
+	.dsi_global_timings = rzg3l_mipi_dsi_global_timings,
+	.num_dsi_global_timings = ARRAY_SIZE(rzg3l_mipi_dsi_global_timings),
+	.link_reg_offset = 0x10000,
+	.dphyctrl0_init_val = DSIDPHYCTRL0_CMN_MASTER_EN | DSIDPHYCTRL0_EN_BGR,
+	.min_dclk = 5440,
+	.max_dclk = 187500,
+	.activation_dly = 100,
+	.features = RZ_MIPI_DSI_FEATURE_16BPP,
+	.pwrrdy = true,
+};
+
 static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
+	{ .compatible = "renesas,r9a08g046-mipi-dsi", .data = &rzg3l_mipi_dsi_info, },
 	{ .compatible = "renesas,r9a09g057-mipi-dsi", .data = &rzv2h_mipi_dsi_info, },
 	{ .compatible = "renesas,rzg2l-mipi-dsi", .data = &rzg2l_mipi_dsi_info, },
 	{ /* sentinel */ }
-- 
2.43.0

