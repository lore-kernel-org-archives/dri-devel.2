Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18988606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQVCgB/n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5B610FB05;
	Wed, 28 Oct 2026 09:52:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CACE10FAFF
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:52:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB597601FA;
 Wed, 28 Oct 2026 09:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B501F031E6;
 Wed, 28 Oct 2026 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793181140;
 bh=Ujhza5d/TXdxWStAAmiobZSug+sQnRFnUtKXmDKdOmg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fQVCgB/n7BDbNgTK6UE9BR7LsWOIJeOfoQyQI6fMqMFXffZsQVh9x8rApMUSGOOuV
 8JHWktjoTAbFA+31pCxPH7VGPMsQoptsM63TXL4wLXxSvX0ciZcAPMOxMN3jkeswfv
 xznzKkArZ+0UY3Ufa5LYFNJrzQLnRFJSRnTvt2YFX23O4LT55ZmGr7RKkyzN2I63Kn
 yX6fzM0ppe6wI96PfQG5kmVekAGfuGdK7n/HD0Cu6ieK6HJTbhawOEcTvwY46p9KVK
 gkqYyFgsTNdKlEAst7DQE7qQRNkd1EA+pEg0XqpYhnHq1wTBUo8hEBmj0HbC5zS1AO
 loGKLqBW/35ow==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/8] drm/panel: novatek-nt36672e: Make the AVDD and AVEE
 supplies optional
Date: Wed, 28 Oct 2026 11:51:46 +0200
Message-ID: <20261028095151.1682096-4-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261028095151.1682096-1-vz@kernel.org>
References: <20261028095151.1682096-1-vz@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The positive and negative bias supplies of an NT36672E panel, AVDD and
AVEE, are not exposed by the panel modules, which generate the bias on
the module itself.

Split the supplies into the required VDDI supply and the pair of AVDD
and AVEE bias supplies, which are either both described or both absent,
and get the bias supplies only if they are described.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 69 +++++++++++++------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index c5e00eb55722..80934c6bf250 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -13,16 +13,13 @@
 
 #include <video/mipi_display.h>
 
-static const char * const regulator_names[] = {
-	"vddi",
-	"avdd",
-	"avee",
+static const struct regulator_bulk_data nt36672e_supplies[] = {
+	{ .supply = "vddi", .init_load_uA = 62000 },
 };
 
-static const unsigned long regulator_enable_loads[] = {
-	62000,
-	100000,
-	100000,
+static const struct regulator_bulk_data nt36672e_bias_supplies[] = {
+	{ .supply = "avdd", .init_load_uA = 100000 },
+	{ .supply = "avee", .init_load_uA = 100000 },
 };
 
 struct panel_desc {
@@ -40,7 +37,8 @@ struct nt36672e_panel {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
 	struct gpio_desc *reset_gpio;
-	struct regulator_bulk_data supplies[3];
+	struct regulator_bulk_data *supplies;
+	struct regulator_bulk_data *bias_supplies;
 	const struct panel_desc *desc;
 };
 
@@ -362,12 +360,23 @@ static int nt36672e_power_on(struct nt36672e_panel *ctx)
 	struct mipi_dsi_device *dsi = ctx->dsi;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	ret = regulator_bulk_enable(ARRAY_SIZE(nt36672e_supplies), ctx->supplies);
 	if (ret < 0) {
 		dev_err(&dsi->dev, "regulator bulk enable failed: %d\n", ret);
 		return ret;
 	}
 
+	if (ctx->bias_supplies) {
+		ret = regulator_bulk_enable(ARRAY_SIZE(nt36672e_bias_supplies),
+					    ctx->bias_supplies);
+		if (ret < 0) {
+			dev_err(&dsi->dev, "bias regulator enable failed: %d\n", ret);
+			regulator_bulk_disable(ARRAY_SIZE(nt36672e_supplies),
+					       ctx->supplies);
+			return ret;
+		}
+	}
+
 	/*
 	 * Reset sequence of nt36672e panel requires the panel to be out of reset
 	 * for 10ms, followed by being held in reset for 10ms and then out again.
@@ -389,7 +398,14 @@ static int nt36672e_power_off(struct nt36672e_panel *ctx)
 
 	gpiod_set_value(ctx->reset_gpio, 0);
 
-	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ctx->bias_supplies) {
+		ret = regulator_bulk_disable(ARRAY_SIZE(nt36672e_bias_supplies),
+					     ctx->bias_supplies);
+		if (ret)
+			dev_err(&dsi->dev, "bias regulator disable failed: %d\n", ret);
+	}
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(nt36672e_supplies), ctx->supplies);
 	if (ret)
 		dev_err(&dsi->dev, "regulator bulk disable failed: %d\n", ret);
 
@@ -520,7 +536,8 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
 	struct nt36672e_panel *ctx;
-	int i, ret = 0;
+	bool avdd, avee;
+	int ret = 0;
 
 	ctx = devm_drm_panel_alloc(dev, struct nt36672e_panel, panel,
 				   &nt36672e_drm_funcs,
@@ -534,15 +551,27 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++) {
-		ctx->supplies[i].supply = regulator_names[i];
-		ctx->supplies[i].init_load_uA = regulator_enable_loads[i];
-	}
-
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
-			ctx->supplies);
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(nt36672e_supplies),
+					    nt36672e_supplies, &ctx->supplies);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	/* The bias supplies are either both described or generated on the module */
+	avdd = of_property_present(dev->of_node, "avdd-supply");
+	avee = of_property_present(dev->of_node, "avee-supply");
+	if (avdd != avee)
+		return dev_err_probe(dev, -EINVAL,
+				     "avdd and avee supplies must be described together\n");
+
+	if (avdd) {
+		ret = devm_regulator_bulk_get_const(dev,
+						    ARRAY_SIZE(nt36672e_bias_supplies),
+						    nt36672e_bias_supplies,
+						    &ctx->bias_supplies);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to get bias regulators\n");
+	}
 
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio))
-- 
2.51.0

