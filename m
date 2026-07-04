Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4600C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1269A10E68B;
	Sat,  4 Jul 2026 09:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdyA+vMT";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B145F10E059
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:39 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so11517735e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157678; x=1783762478; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYVZTDuvtPuLzEvWGqRrMFm4g3sqVFgVTtW213vAnDE=;
 b=BdyA+vMT5owqqGZFgdF1W2XXA0JIUhJ7YNwEok5BRrtPFQ2GzeIMKKMOEyFa/MmAsx
 SAp4WLPeWOITkp1R6fBtBoO4pgWHeYqaMrJFp2Rf/vaeRZ7RoiQCyznEdusFtmd2eEYm
 fCwn+gOAUE07+1UsxNdFIaFsqkOah/60pxIJuUGgDtXyETe+csuJGFK27jDG6fi3fiQW
 zeOiLAoehKTFJxvUM+nBKal71HDQybiuaP+wk32c1OtYg14ZzpwQRshpHNSE2l5uUYa0
 HmRMa3jj0u+Q8QRL6fCFA77zeLagZQKq/sZOk+KT+9N6/TXh3N1AJdqTT66DArwHaQxW
 17Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157678; x=1783762478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iYVZTDuvtPuLzEvWGqRrMFm4g3sqVFgVTtW213vAnDE=;
 b=CtRRSAMYMWXM3KyhR0csJ2Jgmdsj3uOrv6A9jnwzJ2yGNwD/2IqVqAFTVlbHfwCNfS
 1P15xVcG4nn1cKqQCw1v239pFnAcJKrl/ImjXV+bI3bcPaQtaTrEwOzdG9TcLfVthC0e
 nz4bbVMNP917e6n94MishSMuzN/oaBaJdZbSY6hwNx884sz+fWED3odLbQRfn8hSqaat
 T3DeLw9MwZLiU58Jt8TCgYblrQTUxyFiRczEOsX2wUUUMIxOxR+mve5B7k+iIm+N8qii
 pQfM/3ZyYpDlTC+tZbeBwpg5AOYdCTfLjrNhgIDQ4sxAOTpODy+fCBQ1wOLTKRd4mfab
 v71Q==
X-Gm-Message-State: AOJu0YxHVgx+jGv2xJyibOSCKGpW1fWorcSG0FSw1Dco2WTHGyXWhd82
 eF2TQ/OU0IWQKW7l1vLhr1maZXQUQ6YIvO66ThofxU3S8T47GtO0iZIS
X-Gm-Gg: AfdE7clx97xvojTc470VHsp0PdgzAfbVp/UeMzRw+MHVURgVHwDOCWxuuqSa2vLj8J8
 DmYZYhPHoqrsVNViFdLXOPKqssobmvqptOa00XSb8XoBfYeA5Ih1T33mo7FpReL9igwl3l6+IOr
 Ym6JmYmi+Dp6zLvE6XCjGjYUS3Fce2oUhGYHReqvhBOeb2j2+YQ3itTpZ8HjSND24Un98wZL4Z4
 xleyiUYHNaSFzsoa3SWfjDBwPUKDiHQi9hPgw8NGUb0CMJMjYa9evL3FldbzfKN+bdJ/qaSYuPP
 a8zMxcD4ljydJZzNs0wAxKzXxagQCaRqUGnYElVVstxJZVZuOkomigYTH1P5m8Jvah7zm0R+f/u
 ASVsUsY1Ir69Q34W32OXlzZPWXAuJVqqLOfcV4uLnnoff2yHJD/k3DVVxSe+RWZ9QhAVoQulZuL
 DeMYti26BLvAbWIzpqU5LA
X-Received: by 2002:a05:600c:a213:b0:493:b962:4abe with SMTP id
 5b1f17b1804b1-493d11fb898mr18527475e9.36.1783157677924; 
 Sat, 04 Jul 2026 02:34:37 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:34:37 -0700 (PDT)
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
Subject: [PATCH 05/16] drm: renesas: rzg2l_mipi_dsi: Add support for DSI PWRRDY
Date: Sat,  4 Jul 2026 10:34:15 +0100
Message-ID: <20260704093433.273672-6-biju.das.jz@bp.renesas.com>
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

The register for controlling power to the DSI region is in the SYSC
(System Controller) block. Add support for controlling the DSI PWRRDY
signal so the driver can efficiently manage power to the DSI region.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 180384c10264..8bd664aa69ac 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -13,11 +13,13 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/math.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/units.h>
@@ -54,6 +56,7 @@ struct rzg2l_mipi_dsi_hw_info {
 		const u8 *table;
 		const u8 table_size;
 	} cpg_plldsi;
+	const struct reg_field *syscon_field;
 	const struct rzg2l_mipi_dsi_timings *dsi_global_timings;
 	unsigned int num_dsi_global_timings;
 	u32 phy_reg_offset;
@@ -87,6 +90,8 @@ struct rzg2l_mipi_dsi {
 	struct clk *vclk;
 	struct clk *lpclk;
 
+	struct regmap_field *pwrrdy;
+
 	enum mipi_dsi_pixel_format format;
 	unsigned int num_data_lanes;
 	unsigned int lanes;
@@ -1396,6 +1401,53 @@ static const struct dev_pm_ops rzg2l_mipi_pm_ops = {
  * Probe & Remove
  */
 
+static int rzg2l_mipi_dsi_set_pwrrdy(struct rzg2l_mipi_dsi *dsi, bool power_on)
+{
+	u32 val, mask;
+
+	mask = BIT(dsi->info->syscon_field->msb);
+	val = power_on ? 0 : mask;
+
+	return regmap_field_update_bits(dsi->pwrrdy, mask, val);
+}
+
+static void rzg2l_mipi_dsi_pwrrdy_off(void *data)
+{
+	rzg2l_mipi_dsi_set_pwrrdy(data, false);
+}
+
+static int rzg2l_mipi_dsi_pwrrdy_init(struct rzg2l_mipi_dsi *dsi)
+{
+	struct regmap *regmap;
+	u32 args[2];
+	int ret;
+
+	if (!dsi->info->syscon_field)
+		return 0;
+
+	regmap = syscon_regmap_lookup_by_phandle_args(dsi->dev->of_node,
+						      "renesas,sysc-pwrrdy",
+						     ARRAY_SIZE(args), args);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	if (args[0] != dsi->info->syscon_field->reg)
+		return -EINVAL;
+
+	if (args[1] != BIT(dsi->info->syscon_field->msb))
+		return -EINVAL;
+
+	dsi->pwrrdy = devm_regmap_field_alloc(dsi->dev, regmap, *dsi->info->syscon_field);
+	if (IS_ERR(dsi->pwrrdy))
+		return PTR_ERR(dsi->pwrrdy);
+
+	ret = rzg2l_mipi_dsi_set_pwrrdy(dsi, true);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dsi->dev, rzg2l_mipi_dsi_pwrrdy_off, dsi);
+}
+
 static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 {
 	unsigned int num_data_lanes;
@@ -1424,6 +1476,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi->mmio))
 		return PTR_ERR(dsi->mmio);
 
+	ret = rzg2l_mipi_dsi_pwrrdy_init(dsi);
+	if (ret)
+		return ret;
+
 	dsi->vclk = devm_clk_get(dsi->dev, "vclk");
 	if (IS_ERR(dsi->vclk))
 		return PTR_ERR(dsi->vclk);
-- 
2.43.0

