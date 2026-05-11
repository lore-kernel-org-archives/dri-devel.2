Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E1FCD37B7
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 07:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE2A10E4D6;
	Mon, 11 May 2026 07:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QFu8tISw";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E02610E13F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:45:59 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5a8891febd2so4556114e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778485558; x=1779090358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3opfryHfhilZL8PpB6M82lqXji5/jphiotiKFxgDVQo=;
 b=QFu8tISwkQtFl1TJdQJbttwzdoVakdn4ZkHQeE8BklGIo/6eH0jxMMjyzXMZUDtxSW
 LbkxL4WjnU69jAWl3BpRbVZ3hDMPKmp2xWT4Q3z0zmfzyK7vKkKJp/s4pp2wFaLRTgSs
 sNNJKwfF85xctEimukv+az8kTK41YJ/aY3PqVHjH8XTTvGuv+Q6ly5GA99fy+zx48okE
 g6QASPt0TYWsaQMoza8xyCEM+7vH/5cUhmrb6Tud3XhhpFxGFTVA6EjL1Dd9p0g5mAfn
 hyKh+CLEtk5dQnszom1di3BYz90sgnWh88dilXnrxx+8u6a5a4Kmn+AHrs2FwUuzLctP
 NTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778485558; x=1779090358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3opfryHfhilZL8PpB6M82lqXji5/jphiotiKFxgDVQo=;
 b=qL0Zn3h6ZsOZFiMonLMpQkcT8mayEoPII7TS22pOIFxoJcZbs5h8OV4V1v/BjfINbY
 szJQios1h72a6uaIlNgKfoJhT2Dm4fK88I5/tWlrom9+xQ8ImdGWVZanZXH9lTc1PRRS
 BRc1/WQQY31D/gUf2YHJ26mj0Um5cEEpFNm7gOsQ5wa5GzTGu44rvpcPMaNVD4iXyFWe
 pqPuDSC48ZG/feHbP2NpL5TjhwJGGw7H5o32XI/V8UyXHNnEO3ROomQfgjr1yS/Uv+In
 iJccPAZ0sfuGBgMEoZajtasNzi8SqRxuR0IJyeALeuqB5avifnypNtt9yxq3ZnECYLXs
 +HyQ==
X-Gm-Message-State: AOJu0Yw165CXBeVjQlY0IinUeG9YGeAENVXRUwVJou0qayOh6AQLinCV
 FA8c1qychh4oV0dzXPwkhfRAYnyhaiiJdDXtNVld8PPTFK2PeCmSQDBW
X-Gm-Gg: Acq92OHNElqN84qP5EPquHucDaFxkjYrcTW4i2wSc2Gu4xFW3BDwDv4jEPjggahCpC3
 HFNkcYdBnt0SlBbNyOwzQUw24lj0PNPhb7ugTdSZSPmpqWHG7FBYx7QXZzg+H82/my/QfFp6rBn
 O7uWFNQ1uGeuAYZArJavTSbCgG72fYaJLSUsNCmcvYMZC4c9zVPbnAB1ZJ85x8WmiRBpxWCjtMB
 vaFsgSsrOsVEOsWUXlAECXZ+xm8noDI6uA0MFaLWzSS7cwb0xWZkEVpuhXWk6/0oVGFz3uwAHBp
 wK5WZ5imVINdI6v/6QaCTb7p95fW5DWGCeiomnOoLT7q9H6l6SIVpKE/ctAT5Pvp4CzA1PidxgR
 b3i8B8s4cCO0hoAhzWFSDch/g5+NZpaH45kN9rM/WGqE3LNgixnwuzXm6kHTzdsgFVWscEH1Vve
 QzTAtNssZIoVkvuPs2/ivoukM=
X-Received: by 2002:a05:6512:692:b0:5a8:707f:904 with SMTP id
 2adb3069b0e04-5a887a9a8abmr8010872e87.0.1778485557391; 
 Mon, 11 May 2026 00:45:57 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a952705asm2404394e87.32.2026.05.11.00.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 00:45:56 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2 RESEND] drm/tegra: dsi: add support for Tegra20/Tegra30
Date: Mon, 11 May 2026 10:45:36 +0300
Message-ID: <20260511074538.24563-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511074538.24563-1-clamor95@gmail.com>
References: <20260511074538.24563-1-clamor95@gmail.com>
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

Tegra20 and Tegra30 are fully compatible with existing Tegra DSI driver
apart from clock configuration and pad calibration which are addressed by
this patch.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.c |   2 +
 drivers/gpu/drm/tegra/dsi.c | 117 ++++++++++++++++++++++++++----------
 drivers/gpu/drm/tegra/dsi.h |  10 +++
 3 files changed, 98 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 1dcef4e7d104..b73d65cd0ac6 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1358,10 +1358,12 @@ static SIMPLE_DEV_PM_OPS(host1x_drm_pm_ops, host1x_drm_suspend,
 
 static const struct of_device_id host1x_drm_subdevs[] = {
 	{ .compatible = "nvidia,tegra20-dc", },
+	{ .compatible = "nvidia,tegra20-dsi", },
 	{ .compatible = "nvidia,tegra20-hdmi", },
 	{ .compatible = "nvidia,tegra20-gr2d", },
 	{ .compatible = "nvidia,tegra20-gr3d", },
 	{ .compatible = "nvidia,tegra30-dc", },
+	{ .compatible = "nvidia,tegra30-dsi", },
 	{ .compatible = "nvidia,tegra30-hdmi", },
 	{ .compatible = "nvidia,tegra30-gr2d", },
 	{ .compatible = "nvidia,tegra30-gr3d", },
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 7f25c50621c9..fbab10bc5c41 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -54,6 +54,11 @@ to_dsi_state(struct drm_connector_state *state)
 	return container_of(state, struct tegra_dsi_state, base);
 }
 
+struct tegra_dsi_config {
+	bool has_multiple_pad_controls;
+	bool has_mux_parent_clk;
+};
+
 struct tegra_dsi {
 	struct host1x_client client;
 	struct tegra_output output;
@@ -83,6 +88,8 @@ struct tegra_dsi {
 	/* for ganged-mode support */
 	struct tegra_dsi *master;
 	struct tegra_dsi *slave;
+
+	const struct tegra_dsi_config *config;
 };
 
 static inline struct tegra_dsi *
@@ -665,39 +672,46 @@ static int tegra_dsi_pad_enable(struct tegra_dsi *dsi)
 {
 	u32 value;
 
-	value = DSI_PAD_CONTROL_VS1_PULLDN(0) | DSI_PAD_CONTROL_VS1_PDIO(0);
-	tegra_dsi_writel(dsi, value, DSI_PAD_CONTROL_0);
+	if (dsi->config->has_multiple_pad_controls) {
+		/*
+		 * XXX Is this still needed? The module reset is deasserted right
+		 * before this function is called.
+		 */
+		tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_0);
+		tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_1);
+		tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_2);
+		tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_3);
+		tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_4);
+
+		value = DSI_PAD_CONTROL_VS1_PULLDN(0) | DSI_PAD_CONTROL_VS1_PDIO(0);
+		tegra_dsi_writel(dsi, value, DSI_PAD_CONTROL_0);
+
+		value = DSI_PAD_SLEW_UP(0x7) | DSI_PAD_SLEW_DN(0x7) |
+			DSI_PAD_LP_UP(0x1) | DSI_PAD_LP_DN(0x1) |
+			DSI_PAD_OUT_CLK(0x0);
+		tegra_dsi_writel(dsi, value, DSI_PAD_CONTROL_2);
+
+		value = DSI_PAD_PREEMP_PD_CLK(0x3) | DSI_PAD_PREEMP_PU_CLK(0x3) |
+			DSI_PAD_PREEMP_PD(0x03) | DSI_PAD_PREEMP_PU(0x3);
+		tegra_dsi_writel(dsi, value, DSI_PAD_CONTROL_3);
+	} else {
+		value = DSI_PAD_CONTROL_LPUPADJ(0x1) | DSI_PAD_CONTROL_LPDNADJ(0x1) |
+			DSI_PAD_CONTROL_PREEMP_EN(0x1) | DSI_PAD_CONTROL_SLEWDNADJ(0x6) |
+			DSI_PAD_CONTROL_SLEWUPADJ(0x6) | DSI_PAD_CONTROL_PDIO(0) |
+			DSI_PAD_CONTROL_PDIO_CLK(0) | DSI_PAD_CONTROL_PULLDN_ENAB(0);
+		tegra_dsi_writel(dsi, value, DSI_PAD_CONTROL_0);
+	}
 
 	return 0;
 }
 
 static int tegra_dsi_pad_calibrate(struct tegra_dsi *dsi)
 {
-	u32 value;
 	int err;
 
-	/*
-	 * XXX Is this still needed? The module reset is deasserted right
-	 * before this function is called.
-	 */
-	tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_0);
-	tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_1);
-	tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_2);
-	tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_3);
-	tegra_dsi_writel(dsi, 0, DSI_PAD_CONTROL_4);
-
 	/* start calibration */
 	tegra_dsi_pad_enable(dsi);
 
-	value = DSI_PAD_SLEW_UP(0x7) | DSI_PAD_SLEW_DN(0x7) |
-		DSI_PAD_LP_UP(0x1) | DSI_PAD_LP_DN(0x1) |
-		DSI_PAD_OUT_CLK(0x0);
-	tegra_dsi_writel(dsi, value, DSI_PAD_CONTROL_2);
-
-	value = DSI_PAD_PREEMP_PD_CLK(0x3) | DSI_PAD_PREEMP_PU_CLK(0x3) |
-		DSI_PAD_PREEMP_PD(0x03) | DSI_PAD_PREEMP_PU(0x3);
-	tegra_dsi_writel(dsi, value, DSI_PAD_CONTROL_3);
-
 	err = tegra_mipi_start_calibration(dsi->mipi);
 	if (err < 0)
 		return err;
@@ -1174,6 +1188,12 @@ static int tegra_dsi_setup_clocks(struct tegra_dsi *dsi)
 	struct clk *parent;
 	int err;
 
+	/*
+	 * Tegra124+ uses a clock gate, not a mux, so this step
+	 * should be redundant for configuration; yet, DSI refuses
+	 * to work without it.
+	 */
+
 	parent = clk_get_parent(dsi->clk);
 	if (!parent)
 		return -EINVAL;
@@ -1562,6 +1582,10 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	if (!dsi)
 		return -ENOMEM;
 
+	dsi->config = device_get_match_data(&pdev->dev);
+	if (!dsi->config)
+		return -ENODEV;
+
 	dsi->output.dev = dsi->dev = &pdev->dev;
 	dsi->video_fifo_depth = 1920;
 	dsi->host_fifo_depth = 64;
@@ -1600,7 +1624,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
-	dsi->clk_lp = devm_clk_get(&pdev->dev, "lp");
+	dsi->clk_lp = devm_clk_get_optional(&pdev->dev, "lp");
 	if (IS_ERR(dsi->clk_lp)) {
 		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_lp),
 				    "cannot get low-power clock\n");
@@ -1621,10 +1645,12 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
-	err = tegra_dsi_setup_clocks(dsi);
-	if (err < 0) {
-		dev_err(&pdev->dev, "cannot setup clocks\n");
-		goto remove;
+	if (dsi->config->has_mux_parent_clk) {
+		err = tegra_dsi_setup_clocks(dsi);
+		if (err < 0) {
+			dev_err(&pdev->dev, "cannot setup clocks\n");
+			goto remove;
+		}
 	}
 
 	dsi->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -1688,11 +1714,40 @@ static void tegra_dsi_remove(struct platform_device *pdev)
 	tegra_mipi_free(dsi->mipi);
 }
 
+static const struct tegra_dsi_config tegra20_dsi_config = {
+	.has_multiple_pad_controls = false,
+	.has_mux_parent_clk = false,
+};
+
+/*
+ * Tegra30 allows DSIA/DSIB to be muxed to either PLL_D or PLL_D2; this is
+ * simply not modeled in the clock driver yet. If this functionality is
+ * required, the has_mux_parent_clk flag can be set to true once the clock
+ * driver is patched.
+ */
+static const struct tegra_dsi_config tegra30_dsi_config = {
+	.has_multiple_pad_controls = false,
+	.has_mux_parent_clk = false,
+};
+
+static const struct tegra_dsi_config tegra114_dsi_config = {
+	.has_multiple_pad_controls = true,
+	.has_mux_parent_clk = true,
+};
+
+/* TODO: figure out why has_mux_parent_clk = true is necessary on Tegra124+ */
+static const struct tegra_dsi_config tegra124_dsi_config = {
+	.has_multiple_pad_controls = true,
+	.has_mux_parent_clk = true,
+};
+
 static const struct of_device_id tegra_dsi_of_match[] = {
-	{ .compatible = "nvidia,tegra210-dsi", },
-	{ .compatible = "nvidia,tegra132-dsi", },
-	{ .compatible = "nvidia,tegra124-dsi", },
-	{ .compatible = "nvidia,tegra114-dsi", },
+	{ .compatible = "nvidia,tegra210-dsi", .data = &tegra124_dsi_config },
+	{ .compatible = "nvidia,tegra132-dsi", .data = &tegra124_dsi_config },
+	{ .compatible = "nvidia,tegra124-dsi", .data = &tegra124_dsi_config },
+	{ .compatible = "nvidia,tegra114-dsi", .data = &tegra114_dsi_config },
+	{ .compatible = "nvidia,tegra30-dsi", .data = &tegra30_dsi_config },
+	{ .compatible = "nvidia,tegra20-dsi", .data = &tegra20_dsi_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_dsi_of_match);
diff --git a/drivers/gpu/drm/tegra/dsi.h b/drivers/gpu/drm/tegra/dsi.h
index f39594e65e97..d834ac0c47ab 100644
--- a/drivers/gpu/drm/tegra/dsi.h
+++ b/drivers/gpu/drm/tegra/dsi.h
@@ -95,6 +95,16 @@
 #define DSI_TALLY_LRX(x)		(((x) & 0xff) <<  8)
 #define DSI_TALLY_HTX(x)		(((x) & 0xff) <<  0)
 #define DSI_PAD_CONTROL_0		0x4b
+/* Tegra20/Tegra30 */
+#define DSI_PAD_CONTROL_PULLDN_ENAB(x)	(((x) & 0x1) << 28)
+#define DSI_PAD_CONTROL_SLEWUPADJ(x)	(((x) & 0x7) << 24)
+#define DSI_PAD_CONTROL_SLEWDNADJ(x)	(((x) & 0x7) << 20)
+#define DSI_PAD_CONTROL_PREEMP_EN(x)	(((x) & 0x1) << 19)
+#define DSI_PAD_CONTROL_PDIO_CLK(x)	(((x) & 0x1) << 18)
+#define DSI_PAD_CONTROL_PDIO(x)		(((x) & 0x3) << 16)
+#define DSI_PAD_CONTROL_LPUPADJ(x)	(((x) & 0x3) << 14)
+#define DSI_PAD_CONTROL_LPDNADJ(x)	(((x) & 0x3) << 12)
+/* Tegra114+ */
 #define DSI_PAD_CONTROL_VS1_PDIO(x)	(((x) & 0xf) <<  0)
 #define DSI_PAD_CONTROL_VS1_PDIO_CLK	(1 <<  8)
 #define DSI_PAD_CONTROL_VS1_PULLDN(x)	(((x) & 0xf) << 16)
-- 
2.51.0

