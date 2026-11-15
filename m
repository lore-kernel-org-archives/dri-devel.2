Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17D606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kOfdagFa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A0010E20A;
	Sun, 15 Nov 2026 06:11:42 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 638B710E1D0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:11:25 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so19755655e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 22:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794723084; x=1795327884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tAc8EDwX+oraDK+6dFO3Rvp07/tBaltgJEnu0lCCOi8=;
 b=kOfdagFaj/bnPzwXEl3dU1RaoCWW0pRLKJGMRnKHe2lIxYF2dl9YnnhIYGg34xxMXi
 fImRQ/IfJ4CAGlWZGfe1jZibm1OSK73Cq8CDpDT2Yyf1hdsAXWQsg7a2GkgHJIFKmrRp
 FUa1aDsilP1Ur7bDIihlKscL6rOzMjzOxrRp3dW0YhGfJAxFy8q//XnNDxy8y75Wg8Tl
 zZkdnLsHzb6oXa6uLJmXU0DE2aEe52Z1h5H/EWdvvsu26QvkTUV/0I+5T3jRKJ++YFSt
 lN4FOBUj0wTod7j6KEmiGHcOdUO54qDIqU94Aiykn/DBSpJxdiPGkkxbsVjwuiH7WZv3
 0iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723084; x=1795327884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tAc8EDwX+oraDK+6dFO3Rvp07/tBaltgJEnu0lCCOi8=;
 b=vb5zO8pG0Y9wWGsDKonJLNOSIwDVxs/ZdgnyW3rVAMi8z2bjRSGZU4eFN0jc9vFAMM
 072csE+QTsKUYaVEVhdr0sVMH8f70v+1dluTejx/85A/HhIbXGl0eT3EmRIUz+A4RSxf
 bneHVWFWfhgcCjYYnUFOBzjDYk7Lbhq8GsQc5G+7LBCmLb3fNe1W05QeR2ACTStvkkuJ
 Oukxz9aioUcC9s5UdX09tKenwRRBq1jUI5wedQ5L3/bsFkEOgiygLb4hfeN/fjvlHDvy
 GSPgPmpph5OkIVI8IqkmdtwOtxpbtRYKwcbSt10mh0AhMjQhJeK1O97angDaDeoEePRg
 mhlg==
X-Forwarded-Encrypted: i=1;
 AL+hErF4vaTbY9uGXgaTHtDw79znlZF5IGJdF9t6k5wZDL2n4NraVl4fMHbudBuE6L88G8OhodFlZGyKEwc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9nVXS80de8m4o1U+DCmTYAf2Sfb+zhPwJfMhnX7nG1Y/9ILKfb
 JqMHRzAOMgR3JOL9IALiKlTSUrMdNQ4G4yiCHsZefxHPCocxtj4zMq0+
X-Gm-Gg: AYBFou1EcIEM1nWxR+bRHtmQMpBG7cbgGhMkOs6KupjnaccXmAs+vFYxTv4bu5ZJpor
 zB2nwHLnIvrgWE5W5AiwXkzfgggDDRq/gPsXfDyhw2TxQsMYRGDvo6KQUhidiwFkhleIiJQSOcT
 UxSKxgWRJKTb9gahaUO3SYg1xorLjLvAPpuQFQXRD+7jOTN1CLoxl1PQTTR+knKzOa36gxU5m2L
 CrKiwb93/USup6l7u6bEjML8N00S6vxh04WTZ/KJFk12doJtozUqNtCYlIOjTSCvpc095pU+4z7
 My/6zx0y75fvXI3qFj/veRv6tKN/EEudsZO4J1yBO9j/vOdruZvay8aJKEd+8aePjKmBguSEE4s
 XgFYEc/LGKMNg8t/+uqQDwOPnt45VzpbHoruc0IYctRvlOOdc9shqk9DOhWTlsX2sYW26a5d06x
 YEwhtMlolBP4YIKhybAp4UzHplYaeYaDstZTsyylkANJ8OsI9B2LfE7K2j9hSvKF/Olhcr+LAwW
 dzuvjX9F2uz7wtvosfrnYFjlRiUM7sw6wXKifHPq6uzxRpT+DTbZn67lC60jjFNyRdJdV6TWILF
 E/YQJB/stpw71AHBqJwwB1r1mC7ZtayfZwAyBRcs5Zk1+EFOsaZ3HiE45nr8umv2wsU4wikcrdz
 a7qLB8EHO5ObeC75/OsGvSDnU3u0UW7b66LsTG/6ehtQqRsCbJzRYl05jDQDe9A9UBdVPHa95f2
 9r5mdIdoIgcA3oFF9QKAodRnTnB75Ggq+IuX0vvfmR4/0dghq9e1J16MaZIUmkqZsGyLZoh73SP
 TPSSqXoureCug==
X-Received: by 2002:a05:600c:4f90:b0:4a2:8c5:5e5 with SMTP id
 5b1f17b1804b1-4bb55a47680mr145173255e9.7.1794723083470; 
 Sat, 14 Nov 2026 22:11:23 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm139331075e9.14.2026.11.14.22.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:11:23 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 sboyd@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 2/8] clk: sunxi-ng: de2: Export register regmap for DE33
Date: Sun, 15 Nov 2026 07:10:56 +0100
Message-ID: <20261115061102.229680-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115061102.229680-1-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
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

The DE33 clock driver presets the plane mapping, which is not something
that a clock driver should do. Remove that and export the mapping
registers through a regmap instead, so the DRM driver can set them
properly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 43 ++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 6ec6c0dc4c26..f17570efafaa 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 
 #include "ccu_common.h"
@@ -283,6 +284,36 @@ static const struct sunxi_ccu_desc sun50i_h616_de33_clk_desc = {
 	.num_resets	= ARRAY_SIZE(sun50i_h616_de33_resets),
 };
 
+/*
+ * Add a regmap for the DE33 plane driver to access plane
+ * mapping registers.
+ * Only these registers are allowed to be written, to prevent
+ * overriding clock and reset configuration.
+ */
+
+#define SUN50I_DE33_CHN2CORE_REG 0x24
+#define SUN50I_DE33_PORT12CHN_REG 0x2c
+
+static const struct regmap_range sun8i_de2_ccu_regmap_accessible_ranges[] = {
+	regmap_reg_range(SUN50I_DE33_CHN2CORE_REG, SUN50I_DE33_PORT12CHN_REG),
+};
+
+static const struct regmap_access_table sun8i_de2_ccu_regmap_accessible_table = {
+	.yes_ranges = sun8i_de2_ccu_regmap_accessible_ranges,
+	.n_yes_ranges = ARRAY_SIZE(sun8i_de2_ccu_regmap_accessible_ranges),
+};
+
+static const struct regmap_config sun8i_de2_ccu_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= SUN50I_DE33_PORT12CHN_REG,
+
+	/* other devices have no business accessing other registers */
+	.wr_table	= &sun8i_de2_ccu_regmap_accessible_table,
+	.rd_table	= &sun8i_de2_ccu_regmap_accessible_table,
+};
+
 static int sunxi_de2_clk_probe(struct platform_device *pdev)
 {
 	struct clk *bus_clk, *mod_clk;
@@ -336,13 +367,19 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * The DE33 requires these additional (unknown) registers set
+	 * The DE33 requires these additional plane mapping registers set
 	 * during initialisation.
 	 */
 	if (of_device_is_compatible(pdev->dev.of_node,
 				    "allwinner,sun50i-h616-de33-clk")) {
-		writel(0, reg + 0x24);
-		writel(0x0000a980, reg + 0x28);
+		struct regmap *regmap;
+
+		regmap = devm_regmap_init_mmio(&pdev->dev, reg,
+					       &sun8i_de2_ccu_regmap_config);
+		if (IS_ERR(regmap)) {
+			ret = PTR_ERR(regmap);
+			goto err_assert_reset;
+		}
 	}
 
 	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, ccu_desc);
-- 
2.43.0

