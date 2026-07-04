Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DFCC43602
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2A810E573;
	Sat,  4 Jul 2026 09:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JYDNmFXQ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D27310E059
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:40 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493c59f740cso9046445e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157679; x=1783762479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBc2uiELVda9BWyrE7kxnlr1R11N6flK1V2UNIs9oz4=;
 b=JYDNmFXQFlkqKNSZfwdJDP7++WYtxNCM+k41tPkaCV/wAv+j03mE8yD8EVEH/Nkug9
 sqVNN1opSEI+J+RGR1vs6BbS4gkE0KgFXj4WWH94h/cbhDdWTF926glIvxOUNul5WH1w
 xcCTcZRAVb5bcx89LfB5J6uwEF+2/hr6yXWL0fAhCoEOI8u56IQiUGNwyitkQT3A/KwM
 uK/0BtxgZAKVMXToe4mSa+8HlDER10kJDkqVQluGheRV6h2fv+8/dHgAv1FByb5ZIYKe
 k/MBBwzkbgbFQMrb8YrFfXDzc0OXJKOkd1AtnTLa47hzC4kzWR5QT82GUBJhh4PDzJF6
 /JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157679; x=1783762479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MBc2uiELVda9BWyrE7kxnlr1R11N6flK1V2UNIs9oz4=;
 b=hFASa+EPIvF4LQdFJpgTWVEtuOCgIMFPLWb28ajn70ERllO1+y+hLp6Tzh2emxfpw0
 JLx+yYnk+b+rctL1X6UQMHVV9YQlxlUnbR+19y4PQFyGEGNTYEOY6sOtxW8hO2XaWOO/
 Auh9qV24SJh1eXmSIfaYFsgWbHtxucmKlyfJkFStxdwJQ/TTUCT/4D+u2KKmpGVc4joK
 MAnA9x4/UWFHiU0g2gGSm5VASi33y1TaTlgpOM697wabT7E2hUGQWHqb+yKMYBJSFhz+
 Cz/poXwOUHH5cz/SIusIXtAVeTU5eoW+ol+HgaxKUfdkdkx2lLooXH0uD2MVB4Sxfjql
 aqpA==
X-Gm-Message-State: AOJu0Yw6GR1JjSQTaukSQp/dMMHPPCJif5QcZ1XVAV9Jc06M7CGWPCl9
 mEu+OKC+4wlMsocgXbZIQDheLNefX4nqJtttb3b5bzkPU26qPBMlhyul
X-Gm-Gg: AfdE7cmd8ofNZ3G7YlS7gnsDCh/u55L+1zRjDlD3Sha3s5vLlW+IYxsMYeP58fvB4ZY
 v7uLQ/7aZMQi9P/Lyk1xEKvatPpzSxY8CPKh0Tp/LSzty6dPFApgn5KmItWLxHVnbntV42tUlef
 K/vXIrpj8J8YcmYuca+e4IBl6OUP75Wd5c7hQKaln9b+2k9Mtq7pMuSNmYlOhY9yA2GnJiplBlo
 7LVJ9RaHWRSzwqnNzVbn8sGrBIgJivxAeXF+VPxgm8kH9v4I7O6ofZgfmHRdJE1eOaStSujWnqc
 LozWPRVDCicmBtaqo6LI4Cxmjz6waFecmIItfgqtlBy+ROKgYccEScvWUZWJrkyZLD2Gfu9cSU4
 90IytGdx/D1/8r07w7SdphItuI39Ro8T6Ccs0A3C0IJXOtj+PQ0g6f2GoQDAWb9qAFLTvPRi3A1
 zYzq+j3uEg16XmhgJEOMBzmAzw2r0gghw=
X-Received: by 2002:a05:600c:3e0b:b0:492:41c9:886b with SMTP id
 5b1f17b1804b1-493d11d9d69mr26648055e9.14.1783157678929; 
 Sat, 04 Jul 2026 02:34:38 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:34:38 -0700 (PDT)
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
Subject: [PATCH 06/16] drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI
 support
Date: Sat,  4 Jul 2026 10:34:16 +0100
Message-ID: <20260704093433.273672-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
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
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 129 +++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 8bd664aa69ac..25f7602397dc 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -227,6 +227,107 @@ static const struct rzg2l_mipi_dsi_timings rzg2l_mipi_dsi_global_timings[] = {
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
@@ -1132,6 +1233,7 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 				      struct mipi_dsi_device *device)
 {
 	struct rzg2l_mipi_dsi *dsi = host_to_rzg2l_mipi_dsi(host);
+	struct clk *clk_parent;
 	int bpp;
 	int ret;
 
@@ -1186,7 +1288,10 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	 */
 	rzg2l_cpg_dsi_div_set_divider(bpp * 2 / dsi->lanes, PLL5_TARGET_DSI);
 
-	return 0;
+	/* DSI has symmetric 50% duty cycle */
+	clk_parent = clk_get_parent(dsi->vclk);
+
+	return clk_set_duty_cycle(clk_parent, 1, 2);
 }
 
 static int rzg2l_mipi_dsi_host_detach(struct mipi_dsi_host *host,
@@ -1600,7 +1705,29 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 	.activation_dly = 1000,
 };
 
+static const struct reg_field rzg3l_pwrrdy_reg_field = {
+	.reg = 0xd70,
+	.lsb = 0,
+	.msb = 1,
+};
+
+static const struct rzg2l_mipi_dsi_hw_info rzg3l_mipi_dsi_info = {
+	.dphy_init = rzg2l_mipi_dsi_dphy_init,
+	.dphy_exit = rzg2l_mipi_dsi_dphy_exit,
+	.dphy_conf_clks = rzg2l_dphy_conf_clks,
+	.syscon_field = &rzg3l_pwrrdy_reg_field,
+	.dsi_global_timings = rzg3l_mipi_dsi_global_timings,
+	.num_dsi_global_timings = ARRAY_SIZE(rzg3l_mipi_dsi_global_timings),
+	.link_reg_offset = 0x10000,
+	.dphyctrl0_init_val = DSIDPHYCTRL0_CMN_MASTER_EN | DSIDPHYCTRL0_EN_BGR,
+	.min_dclk = 5440,
+	.max_dclk = 187500,
+	.activation_dly = 100,
+	.features = RZ_MIPI_DSI_FEATURE_16BPP,
+};
+
 static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
+	{ .compatible = "renesas,r9a08g046-mipi-dsi", .data = &rzg3l_mipi_dsi_info, },
 	{ .compatible = "renesas,r9a09g057-mipi-dsi", .data = &rzv2h_mipi_dsi_info, },
 	{ .compatible = "renesas,rzg2l-mipi-dsi", .data = &rzg2l_mipi_dsi_info, },
 	{ /* sentinel */ }
-- 
2.43.0

