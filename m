Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB83CD3445
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 19:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F52B10E0EA;
	Sat,  9 May 2026 19:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J/AOefOe";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D21310E0B6
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 19:00:23 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso21165755e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778353222; x=1778958022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3EJ0517xJNtY9t4icYdcJ6JRwvMjYIpIptqEEIrShg=;
 b=J/AOefOeluW5fh8hOd1wRIN5iBgwTNruJlrcgUn2NUoeOmYuLJY8eRZyD7MfoRvt0f
 fWhoTXXsFCz7jvzp6nYMW/5wFjSGwQEViI2Pr6Pfe/sDMzbINcD/Aa8eKsRcL6aUXCOj
 C6ylWk4LZfM/iI2XzOcT/q70t5MNF56eNxGblXislWExNxX3LmtP0L8dcs8Jpz4JUhJt
 1OlTkUmUmvkRx+/EQNmGRfXGmW4zKhCtSkhF1tCKtM9NMoDwwjFF6cpid/xU+Tjk7kBm
 qr+ZtgUCI9P0rvbF2pCSNNhPOURk74aZu4iyN9tPD0377v7tGwW7ST0C+ledzp1V+irh
 UvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778353222; x=1778958022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F3EJ0517xJNtY9t4icYdcJ6JRwvMjYIpIptqEEIrShg=;
 b=pKiPfeV7OwuTjz5Km12zNbqHaFm5uLFytXBx7g0coS3q8LLhK4Upp+HICcWcSEZoq6
 vLuQZTWTeOdUJrIcmM6jenw72Sw/39TE0ZhPGlXUD5wbd037Eh5HN9a4fuu226WuoUWb
 pg5vaqX4AgPbLVrlBXphG2PJyRDCObj+WsPBgyXxGrkc3mUW/wywv0VtwGsuRp+4vAVY
 bHo8TtCqLFZo1mPcg5e83erjOpGJghXKVV6GnmCa/7fSD7Z8H3BRqpM/uAdnTmPPj8sx
 BolwQITAHzMMG3y9wodjohV+Ju7JVkZfsSNSC0bKygWd6cuxH6Xaeyu9VPO+y0IgK7NG
 gt3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ99W/8iXrZEausUKS2/frHlcxdAhFxWdJ6XVFTbYGCOauBrpocnIUvhUanNk9cQG4ovx4zQON3akQA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwV/k2abnmLTy8tlhKk9FhDVUHSJ2tT9tJw1N8DYhH6pCRVItaA
 VPYM5kJ++YXmWN6AqWvsuT4g4mMX1IJTs1X2/ABrokWZlMZt5/eudr4W
X-Gm-Gg: Acq92OF8ZcMp927WUAZZkkU3a+ot/XByuXNMMvJdYQNRRV2Y6ANXPEvLcUKPXQcgqN9
 yG0uSujrDRLyK1LBZokayyizqIdWDIEqBQvLfrUnKTL9jXDZEmMvqZJ9GCmJ/OfErs/cqBlhzGq
 TmKTmQe5cxSsqt+eCX7ht61VJZUfTLYTVbslhVVqRP+kCFxksc/HGPcUuLE0IbjLWRSaCZHQH3q
 CNQM09UG1fRd/H5OAOZ8K1D1crnRGRE817z4kiYHePHsirgYapa/Q2opO61QVHGFNdPpL7gJfb6
 +YBzu4cB5KCWMklKHTkFmUDrvd4+awosLr1lR5+XoMRpgX04t2H/btgETWIuBRpAZCDWIxvgmVv
 V5DEhQTboP1YfWwn5hsJH4y1sjKSXQ8W4ydwwEyrBnSMISmMqAquR0wZua0kZcDsVkit5PXNHRp
 8qhmXxfkD2D87ws1anuDf+ZrRjcQnDuPMo2VZBrz9tQDB99LmIvnHJ1zBYZsYp7EVT7OY=
X-Received: by 2002:a05:600c:1e0f:b0:48e:51f5:2764 with SMTP id
 5b1f17b1804b1-48e676c0353mr137860975e9.27.1778353221568; 
 Sat, 09 May 2026 12:00:21 -0700 (PDT)
Received: from jernej-laptop (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm13254407f8f.19.2026.05.09.12.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 12:00:21 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
X-Google-Original-From: Jernej Skrabec <jernej.skrabec@siol.net>
To: wens@csie.org,
	samuel@sholland.org
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 jernej.skrabec@gmail.com
Subject: [PATCH v2 1/8] clk: sunxi-ng: de2: Fix Display Engine 3.3 definitions
Date: Sat,  9 May 2026 21:00:08 +0200
Message-ID: <20260509190015.79086-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509190015.79086-1-jernej.skrabec@siol.net>
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

Positions of clocks and resets changed when version 3.3 was introduced.
However, old positions still work, just by luck.

Fix Display Engine 3.3 resets and clocks according vendor driver.

Fixes: be0e9a372787 ("clk: sunxi-ng: ccu: add Display Engine 3.3 (DE33) support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
- new patch

 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 39 +++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index a6cd0f988859..6ec6c0dc4c26 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -36,6 +36,13 @@ static SUNXI_CCU_GATE(wb_clk,		"wb",		"wb-div",
 static SUNXI_CCU_GATE(rot_clk,		"rot",		"rot-div",
 		      0x00, BIT(3), CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE(mixer0_h616_clk,	"mixer0",	"de",
+		      0x04, BIT(0), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(mixer1_h616_clk,	"mixer1",	"de",
+		      0x04, BIT(1), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(wb_h616_clk,	"wb",		"de",
+		      0x04, BIT(4), CLK_SET_RATE_PARENT);
+
 static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
 		   CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div", "de", 0x0c, 4, 4,
@@ -54,6 +61,9 @@ static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
 static SUNXI_CCU_M(rot_div_a83_clk, "rot-div", "pll-de", 0x0c, 0x0c, 4,
 		   CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE(bus_mixer0_h616_clk, "bus-mixer0", "bus-de",
+		      0x08, BIT(0), 0);
+
 static struct ccu_common *sun8i_de2_ccu_clks[] = {
 	&mixer0_clk.common,
 	&mixer1_clk.common,
@@ -74,6 +84,12 @@ static struct ccu_common *sun8i_de2_ccu_clks[] = {
 	&mixer1_div_a83_clk.common,
 	&wb_div_a83_clk.common,
 	&rot_div_a83_clk.common,
+
+	&mixer0_h616_clk.common,
+	&mixer1_h616_clk.common,
+	&wb_h616_clk.common,
+
+	&bus_mixer0_h616_clk.common
 };
 
 static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks = {
@@ -147,6 +163,17 @@ static struct clk_hw_onecell_data sun50i_a64_de2_hw_clks = {
 	.num	= CLK_NUMBER_WITH_ROT,
 };
 
+static struct clk_hw_onecell_data sun50i_h616_de33_hw_clks = {
+	.hws	= {
+		[CLK_MIXER0]		= &mixer0_h616_clk.common.hw,
+		[CLK_MIXER1]		= &mixer1_h616_clk.common.hw,
+		[CLK_WB]		= &wb_h616_clk.common.hw,
+
+		[CLK_BUS_MIXER0]	= &bus_mixer0_h616_clk.common.hw,
+	},
+	.num	= CLK_NUMBER_WITHOUT_ROT,
+};
+
 static const struct ccu_reset_map sun8i_a83t_de2_resets[] = {
 	[RST_MIXER0]	= { 0x08, BIT(0) },
 	/*
@@ -180,6 +207,12 @@ static const struct ccu_reset_map sun50i_h5_de2_resets[] = {
 	[RST_WB]	= { 0x08, BIT(2) },
 };
 
+static const struct ccu_reset_map sun50i_h616_de33_resets[] = {
+	[RST_MIXER0]	= { 0x00, BIT(0) },
+	[RST_MIXER1]	= { 0x00, BIT(1) },
+	[RST_WB]	= { 0x00, BIT(4) },
+};
+
 static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
 	.ccu_clks	= sun8i_de2_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
@@ -244,10 +277,10 @@ static const struct sunxi_ccu_desc sun50i_h616_de33_clk_desc = {
 	.ccu_clks	= sun8i_de2_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
 
-	.hw_clks	= &sun8i_h3_de2_hw_clks,
+	.hw_clks	= &sun50i_h616_de33_hw_clks,
 
-	.resets		= sun50i_h5_de2_resets,
-	.num_resets	= ARRAY_SIZE(sun50i_h5_de2_resets),
+	.resets		= sun50i_h616_de33_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_h616_de33_resets),
 };
 
 static int sunxi_de2_clk_probe(struct platform_device *pdev)
-- 
2.54.0

