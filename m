Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E65606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGXbKkb9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F35112746;
	Thu, 26 Nov 2026 21:45:30 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD249112738
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:49 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4acb44dcd7bso6706121f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729488; x=1796334288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=acaXZc4OKei2F0ZgQ8y8R54n527Bro3xiFkohRD4bNk=;
 b=yGXbKkb9LcBpJaH9uTSFgqnz7l35r6IfqJLOQ1l4ebk8s+5bZ1BFyy4rRim8B7/Ieu
 KVmGvYyjwAw1VfmbB75L3zDHZYQWCa8xDCLuzuRdgd7ign24wx6MmlNCKynz5E8/waMO
 J90ETJWBRrsUtFY5Om95MlxtKl1Z0WK4Pfo6oa4fyzsK/fkQrmcGd3G/dSAlYJee/p9u
 voamRb4i+grlMoqjkHSpFbf4CHos6BEROzV21KrlI+GZjwp1MZp7EwjydrfGnuiIi6KN
 KOhA92Il8iTmT1Bfo2qZej1MaolOTQnET3XoEocQzvxGKJqZKALMmyGGtugx8gXVMF/k
 y0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729488; x=1796334288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=acaXZc4OKei2F0ZgQ8y8R54n527Bro3xiFkohRD4bNk=;
 b=RaWkYfS7D/9PVBRAdgdBTBHSO7z6JkwzL/ILQDY8NtzEvPQrNR9GQ4CZjnz+8rDgei
 0bF0BaCgikFmz0SS5HXT3oKpW/P0xEjrVIBPChs9vb9Tt9BtLADZVDcSUHCm5KrU4l7I
 Lbx/sO+wfopEpquScxM20lumOrCAZOfMaYv1gvAKMkgv5zl1tFvUhuI5MG2OLQmv/Hf7
 yJ8KWuMKgjhAI0EBPnVcfEzRC2+kRGsGNauSxJy+7WSJ9tNTi5emBz2BwQpAGOLwWjp+
 b924N8IeQ3DEoSlTUJ64ThZmNpAvfyZblxcybPikA2fvXS9Qwx3aFakBNq1P+BOONCJn
 wxLg==
X-Forwarded-Encrypted: i=1;
 AL+hErGdFzkqwgXqsocpJWcNV8WMn8O6muFZAVkXYoYoVmIvKdUZFzZtjFB8Zdk4kZscDQQZ/UA0zE41dA8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+al9U/m85S7rwjoHPhOMtuEzXTgTQyIE1c3e8bM68VlzNh86V8
 TTrArIfRB2toh2X8/xVI0Cp4CEjyKCAUb1tJcygb2CC4Zp/RBkTrI6mN
X-Gm-Gg: AZFdTZdvrzkix2qPkIziWpkfWwzpePpGIr+UFAPqmzKnwrXDkoGYtS6aEE48PiH20hq
 GNW1DcmOYINzvcHlrqDw3H8F77W9vtFSXGGdRdQDDkM4J4hIk5b+4xwpMDqHuN/BvtbmfqZYJmk
 l+JIMZ97rnbZAisDEWXXYU2iQyIU6B1qQDmb8GSQiCSm/nhUWp4fysCmIpeZvyScMq2Xtd7RfNt
 Biuxz7qYfrPm6b5yyG5V2OsYdVgEccuZpIK2uUwRO6t9SZkQjVLY+hKEBSqZWUVDZjHid69w5U9
 SAPv8PSQ6JsSGL0hCIkkBkhI5f4a2zX2S1/FiR8rueKkC1B216v+KzhWpHEIhHnkh+Y85Qlp0+S
 OehgxbM0WtTeRk1Yb9REK2tjGhajAxOb/3JT0xVaM+Da4jgBKvlDgjP6uV4vIdFwUaxgKDMl+uR
 lbvCb4sVh0vJex01U2yp/9SpQ/PmD0eci/kbJcLqcL6DI1IPZw4m+ncbf/SIV8se/aj6axKtec8
 oPO2Cxe+Fhxho+CpzajhNaAYRrEkTjYwazPtD1M8/fVz2yVBaA/zYV72suXktd3hsqZNUNfUcQY
 BuO/rrealIX/Zphv0DROdy8THDj0dNNZZA4q52OXqQ7WBWyI4Tt+C2ELCVX7XiJSbQA6i8eQbSc
 8wXk6U68mwTgdonfwJChJnqdZTuKiPyAtMekl2IlwSwobrefI02oNsy9E0Yips3PDctu1nUddvo
 gdBenTD2Tm173Ix5kAgXlRTaQYCp4Dqf4avuwS0bTLi0XGUCGjGwOjUB3ei0DHHxlmV0MlcLBgM
 prX5g0f9Ev23ZpiXtEFUno2400uyMOH1ih5KRtlug==
X-Received: by 2002:a05:6000:2c13:b0:4a7:9630:7b57 with SMTP id
 ffacd0b85a97d-4abb43dece6mr43971087f8f.44.1795729488089; 
 Thu, 26 Nov 2026 13:44:48 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:47 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 jernej.skrabec@gmail.com, p.zabel@pengutronix.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] drm/sun4i: tcon: Add support for R40 LCD
Date: Thu, 26 Nov 2026 22:44:28 +0100
Message-ID: <20261126214433.3562326-7-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
References: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
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

R40 TCON LCD supports LVDS output. It shares the mux function with
TCON TV, so use the same set_mux callback.

Each TCON LCD has analog registers for both LVDS PHYs. TCON LCD1 drives
the second PHY, so in single link mode it has to program the second
analog register instead of the first one. Add a LVDS PHY setup callback
which selects the register based on the TCON index.

Add support for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 49 ++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 77b6026bc895..0cbd6ae66c4e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -139,24 +139,25 @@ static void sun4i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
 			   SUN4I_TCON0_LVDS_ANA0_EN_MB);
 }
 
-static void sun6i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
-				      const struct drm_encoder *encoder)
+static void sun6i_tcon_setup_lvds_phy_reg(struct sun4i_tcon *tcon,
+					  const struct drm_encoder *encoder,
+					  unsigned int reg)
 {
 	u8 val;
 
-	regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+	regmap_write(tcon->regs, reg,
 		     SUN6I_TCON0_LVDS_ANA0_C(2) |
 		     SUN6I_TCON0_LVDS_ANA0_V(3) |
 		     SUN6I_TCON0_LVDS_ANA0_PD(2) |
 		     SUN6I_TCON0_LVDS_ANA0_EN_LDO);
 	udelay(2);
 
-	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+	regmap_update_bits(tcon->regs, reg,
 			   SUN6I_TCON0_LVDS_ANA0_EN_MB,
 			   SUN6I_TCON0_LVDS_ANA0_EN_MB);
 	udelay(2);
 
-	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+	regmap_update_bits(tcon->regs, reg,
 			   SUN6I_TCON0_LVDS_ANA0_EN_DRVC,
 			   SUN6I_TCON0_LVDS_ANA0_EN_DRVC);
 
@@ -165,11 +166,17 @@ static void sun6i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
 	else
 		val = 0xf;
 
-	regmap_write_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+	regmap_write_bits(tcon->regs, reg,
 			  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(0xf),
 			  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(val));
 }
 
+static void sun6i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
+				      const struct drm_encoder *encoder)
+{
+	sun6i_tcon_setup_lvds_phy_reg(tcon, encoder, SUN4I_TCON0_LVDS_ANA0_REG);
+}
+
 static void sun4i_tcon_lvds_set_status(struct sun4i_tcon *tcon,
 				       const struct drm_encoder *encoder,
 				       bool enabled)
@@ -1410,6 +1417,27 @@ static int sun6i_tcon_set_mux(struct sun4i_tcon *tcon,
 	return 0;
 }
 
+static void sun8i_r40_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
+					  const struct drm_encoder *encoder)
+{
+	unsigned int reg = SUN4I_TCON0_LVDS_ANA0_REG;
+	struct device_node *port;
+
+	/*
+	 * Each TCON LCD has analog registers for both LVDS PHYs. TCON LCD1
+	 * drives the second LVDS PHY (LVDS1 pins), so in single link mode
+	 * it has to configure its second analog register.
+	 */
+	port = of_graph_get_port_by_id(tcon->dev->of_node, 0);
+	if (port) {
+		if (sun4i_tcon_of_get_id_from_port(port) == 1)
+			reg = SUN4I_TCON0_LVDS_ANA1_REG;
+		of_node_put(port);
+	}
+
+	sun6i_tcon_setup_lvds_phy_reg(tcon, encoder, reg);
+}
+
 static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
 				     const struct drm_encoder *encoder)
 {
@@ -1521,6 +1549,14 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
 	.has_channel_1		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_r40_lcd_quirks = {
+	.supports_lvds		= true,
+	.has_channel_0		= true,
+	.set_mux		= sun8i_r40_tcon_tv_set_mux,
+	.dclk_min_div		= 1,
+	.setup_lvds_phy		= sun8i_r40_tcon_setup_lvds_phy,
+};
+
 static const struct sun4i_tcon_quirks sun8i_r40_tv_quirks = {
 	.has_channel_1		= true,
 	.polarity_in_ch0	= true,
@@ -1562,6 +1598,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-tv", .data = &sun8i_a83t_tv_quirks },
+	{ .compatible = "allwinner,sun8i-r40-tcon-lcd", .data = &sun8i_r40_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-r40-tcon-tv", .data = &sun8i_r40_tv_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-lcd", .data = &sun9i_a80_tcon_lcd_quirks },
-- 
2.43.0

