Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F077FC54FCD
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A024E10EC13;
	Wed, 29 Jul 2026 12:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AH5HbHqT";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F0510EBF8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:34 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f92e3c14bso850786f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329732; x=1785934532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hhzzyg0xbZvJC/hGyaob+lgTLTfoRj2Ty2Bq5ZjXfF0=;
 b=AH5HbHqTf2vqPFQE8QJsmaqUG6PS8u6bnEjNHQCfk6GKixpJMzGntKikMPRN3Re7AN
 59pG8HgEyVnlqbRi16yfO+BLNvk20QdzvFDpy+N2f202IzgaanWXb3BZ3WiweKS4yenq
 4tWwqzvZki9N/jbBNP1cTTGdGGrQED/pygrUCnAA2N72ZWXyw+yggIY/Q7FbvpPcc7IA
 Ti6ma5KVaiZl5HBJmxV8cVZR8ApLj2j4BVkoI7CybEKgPm8L1OkpFW5cBLo9kMSrv3Ia
 t9bUBqoaQ+Wl0JJBWY3MmDwljt10+hkrlCQ5zp+scpFJGMdkZga/2NlFcLrc0lFOJ1Dp
 n9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329732; x=1785934532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hhzzyg0xbZvJC/hGyaob+lgTLTfoRj2Ty2Bq5ZjXfF0=;
 b=B1Co6aldyLDiXMQAmWhxZOerjX6KXIAG8AyPv1D9aMXyVmf1ciYnPjWm4CnMMkVjXm
 uTCilyF7kBaHbqtAfUoGCzgBo6aAOFBMuvYxtYIoosScMv8pbwpM+SQV6LnciDpu6aVy
 IZgjBwMQ4zq6FXhEW8YnqgSn/v5S4k/j4wXpdzxx3xqHZXC6E2hJAU54KUnGVhzqFTms
 3XtUnG2ZazqZejWofB9UeMNxDXU7ecCeJpTkKAGQWYJgdRdyv9j8Gw4F31EJVQss/Wiz
 8KtKiNcNeEFQmLxiJYX0bX7YHzDvK/ZQ6c6I+QPa5NIfzUl11IANkh/jQKX/81xZxd6f
 iqCg==
X-Gm-Message-State: AOJu0YwmL+m3qc07UAhUEd6j9HvFzrmkbqcUasUB4M39UEY0Lwr/OobY
 uRTGDSZ7ZhI2PZ8Dub1AAJVM8mG8st/RBlzUZfE1JVM+tUOaY7Vjaudz
X-Gm-Gg: AR+sD10sQWZVS6UhAC9+ovbM2iE1wcUqFtGrxGO8E2qYmcTL945JFtb7xDt3+gsPpn6
 yf0KxF3QG7PzaL1g212EiO2qZTazNIp0PqFqKviL9LsB8PbwDchtsZBhVD3iLCxo6CHx/yiU5Rc
 tzdl6MeRy8egYEJF1gM17briHEN5bCWVe8DsVjoUd/J5hrwyBTkwjdA9O1TYJptjFV5kHpMFtlP
 F2qe/Ax7Tk2qRTSCTCWkxRyjYCubgdwKndRG1H0MqvxWWHvFEP9Y7evk2+osvKhz2GTM3/nDgeJ
 ILHBe0jIylN0Qgj0c1A+6Kkyq01ZI/RJdnG/66FF6iQfGVBU5vjSiNrxgGlgwDqiEock8ja86Se
 IlCXQ2LBbiQzYgdj+/86F4ArvebKrU+BTAfMF+V4QBOJw4uFi9bCn4LLYA4Dr3dHOjX7m3eTTl7
 Y4vly5H1Sqza1xDvOUybJ2aAwYqaBNEF6dSNt9k1r/fSROGfA6FCNEyLrMHWCEshWsBmZ5F0tUq
 /P4nzWbc1Sy5W3nTqQ2+dUR1A==
X-Received: by 2002:a05:6000:4025:b0:47f:9108:59d5 with SMTP id
 ffacd0b85a97d-47fb1eab2e6mr8075833f8f.42.1785329732474; 
 Wed, 29 Jul 2026 05:55:32 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:31 -0700 (PDT)
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
Subject: [PATCH v2 06/16] drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI
 support
Date: Wed, 29 Jul 2026 13:54:58 +0100
Message-ID: <20260729125516.230757-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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
 * Replaced syscon_field->pwrrdy in struct rzg3l_mipi_dsi_info.
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 123 +++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 7fdcee98450b..4759842a4d78 100644
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
@@ -1131,6 +1232,7 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 				      struct mipi_dsi_device *device)
 {
 	struct rzg2l_mipi_dsi *dsi = host_to_rzg2l_mipi_dsi(host);
+	struct clk *clk_parent;
 	int bpp;
 	int ret;
 
@@ -1185,7 +1287,10 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	 */
 	rzg2l_cpg_dsi_div_set_divider(bpp * 2 / dsi->lanes, PLL5_TARGET_DSI);
 
-	return 0;
+	/* DSI has symmetric 50% duty cycle */
+	clk_parent = clk_get_parent(dsi->vclk);
+
+	return clk_set_duty_cycle(clk_parent, 1, 2);
 }
 
 static int rzg2l_mipi_dsi_host_detach(struct mipi_dsi_host *host,
@@ -1582,7 +1687,23 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
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

