Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899A6CD37B6
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 19:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FEE10E3E1;
	Sat,  9 May 2026 19:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UUBjT8fU";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C93810E0ED
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 19:00:24 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so1562444f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778353223; x=1778958023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdLAbqgwB3cbfBit4ZVDmF5fOX+Cth+Nq8mrAQRYaDE=;
 b=UUBjT8fU6Of0K/F0wlVN3KTvjYaOLzyWHB2vSjXTvVMbJEPcRdlm6Y4kB95HsHKABN
 Uo32r/paJJ8EO4dLmFfrCO+L7jIn5Ncla3YTDhdAcjK3R+rXyWXm8OfFTxNmntL5IAuH
 Xnc6GjcUXHGNBBo9aEZ+My4LqC5gOV3KUt8Y+M1mH+zZULe+PWtGljiT2tquRfWFeDhF
 jItsEBDX6wHuC0Q2C8+9loq/ntpq2IAjoS6yIKfoTZTJRfDlEZHpromBlsCE2SK75caq
 fdP9q3JFRrSVFaRotNslFbM8hU+6a+fQ9+y/4PsbUHqjQoe8Ykq21CKqSR/NXJs0dyAl
 gECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778353223; x=1778958023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AdLAbqgwB3cbfBit4ZVDmF5fOX+Cth+Nq8mrAQRYaDE=;
 b=qiiOwRft1sGaPlxjjxy+PG0HVmc6r4gEGoOlijrR5TEMbjcn3Is5ojYjpC/P4THFZH
 ViffRSxkFto9yEJsJbGB8HKxwhfdpL+af/PGlznLCbujLDjVPLM8Aq/QeesZc+RQTY2d
 xugvvbFb4wQf63YQNhmu0XYwQr9EKWfz+NLgaiBF0rmSBYAI9spbFLWr5lbnIOKFcWqP
 Xh/mE557BtMT8AsmljYIMrZiawujg3Nrm0Ghcnc6/s1KRD89vO4vlPQ8X+PKvi4FtByu
 gtLqqZwa2jHbEMB0UU6th2faUe/ztZJ72lc7Lp6BB7fjIQdSDlcusfhI/Lif1m466Vo3
 WGmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kEGmzS0yPDO8hjFctuNsAqm1f9JuSLrxpy80P6bhQUumXKcWrgeN1tm+jUTXVyAKB4BrOmi9cf2E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPkvmJJIjzqV9RnLPdjfoSBpdlWcRIdi4QikR6R01vgOmDnM3N
 Vc+Br4vGj9U+CRj/wcsQP87psYeL6Pte01Uk/5gCS+xYmUo88PxK1jZJ
X-Gm-Gg: Acq92OEa51xMljuoerSZYORlyf3bb6CfcSbU0ivMls3edcM+5kw1MGEa5xD/k0tp3q8
 NQeKs9LdpzoE5DQF7DLP5tR6nT0qx82SrTujCQhu8ALLkBfBlokch0kExF+6HKkZw3WL3NdKNgp
 MUJ/jiTsD/6Bgf51Xnp4hfxQ0+drbDR9Cbx4TdUW1FMXnhGF61Pk52hoR23J1uUkWQ/DPdJaQDS
 NC0DIdVJ6jA6LGZ82bhGS4dwimS/9VYA+4BA7nGIGOKzlHVoiprbRnRA7yNNppM4GrKFM2NTW4h
 RLpfXnkftrrn3AUcAgnniqAVF+1r2kY18V7BHpeSAwdx1GODtiuJVQJcm+NMla7otDYxIH8dujr
 OFm7aVCzm8rTRenAwhW0uQzQXMYzcYgbBB4oxh9Sk0qCY6ouraipiqF7MAy3rERebzh3iJ6JX0E
 SzlNslsZMEjBwJhYnIrCE+IWCzROMcvShEbpU7kjwjpOy6G+pzYd7+pkx5JQeVzbrCIvc=
X-Received: by 2002:a5d:5f90:0:b0:451:ccc:a6e5 with SMTP id
 ffacd0b85a97d-4515d5c68d1mr27318999f8f.30.1778353222950; 
 Sat, 09 May 2026 12:00:22 -0700 (PDT)
Received: from jernej-laptop (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm13254407f8f.19.2026.05.09.12.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 12:00:22 -0700 (PDT)
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
Subject: [PATCH v2 2/8] clk: sunxi-ng: de2: Export register regmap for DE33
Date: Sat,  9 May 2026 21:00:09 +0200
Message-ID: <20260509190015.79086-3-jernej.skrabec@siol.net>
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

DE33 clock pre-set plane mapping, which is not something that we want
from clock driver. Export registers instead, so DRM driver can set them
properly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
- used access tables instead of functions
- used macro for max register
- used dev_of_node() instead of open coding

 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 48 ++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 6ec6c0dc4c26..26d8abd5fac6 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -6,9 +6,11 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 
 #include "ccu_common.h"
@@ -283,6 +285,36 @@ static const struct sunxi_ccu_desc sun50i_h616_de33_clk_desc = {
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
@@ -336,13 +368,23 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
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
+
+		ret = of_syscon_register_regmap(dev_of_node(&pdev->dev), regmap);
+		if (ret)
+			goto err_assert_reset;
 	}
 
 	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, ccu_desc);
-- 
2.54.0

