Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1B606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Al6Bzy8h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DD610E332;
	Thu, 26 Nov 2026 13:46:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F0A10E332
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:46:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A64B6344C;
 Thu, 26 Nov 2026 13:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4611F000E0;
 Thu, 26 Nov 2026 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700767;
 bh=LpCQaTekFEeyqZMNoHTvHNWTZGVrsIL1ToHn2ap47Sg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Al6Bzy8h+tbTvECl3QO04WDeA7Q1+g+vC028/Zf2jWKzhAl7ZxGRX3AYITkIKJ5Ex
 i7WB9B/CkgwpJdUXd8S6k2MSsez136gPIZFjatw/zAqckBgsjtiqeo+QVqw2JR2flo
 F7PLWh8kYfv1+iA+vzCcoEwuEkQJGaanD3J+nhwh+CtwXe9SUELXVe/xbMt5YoZ4o/
 +eIe6qZ2FoNcBe148w01zL5LKhsI33TPMlDsaWXTXMEQD4idUiCNXdTqLbV6eC22k3
 G5AbW73hzqPUpuCHfq8fhTMG0bmejV7OlqAfimasscg7SXCO/nfOdstNz3opfQe/W9
 v1ePHfcdbGvFQ==
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
Subject: [PATCH v2 06/10] drm/panel: novatek-nt36672e: Verify the number of
 D-PHY data lanes
Date: Thu, 26 Nov 2026 15:45:04 +0200
Message-ID: <20261126134508.320700-7-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261126134508.320700-1-vz@kernel.org>
References: <20261126134508.320700-1-vz@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NT36672E panel in the MIPI D-PHY mode is connected over 4 data lanes,
a mismatching device tree description results in a panel, which won't work.

Get the PHY type of the DSI link from the PHY of the DSI host, and get
the number of data lanes from the DSI host endpoint to check the match.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index 4836751b7d5d..cc3f4d251f55 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -5,14 +5,18 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
 
+#include <dt-bindings/phy/phy.h>
+
 static const struct regulator_bulk_data nt36672e_supplies[] = {
 	{ .supply = "vddi", .init_load_uA = 62000 },
 };
@@ -536,6 +540,30 @@ static const struct drm_panel_funcs nt36672e_drm_funcs = {
 	.get_modes = nt36672e_panel_get_modes,
 };
 
+/*
+ * Get the PHY type of the DSI link from the PHY of the DSI host, MIPI D-PHY
+ * is the default, if the PHY type is not specified.
+ */
+static u32 nt36672e_get_dsi_phy_type(struct device *dev)
+{
+	struct device_node *host, *phy;
+	u32 phy_type = PHY_TYPE_DPHY;
+
+	host = of_graph_get_remote_node(dev->of_node, 0, 0);
+	if (!host)
+		return phy_type;
+
+	phy = of_parse_phandle(host, "phys", 0);
+	of_node_put(host);
+	if (!phy)
+		return phy_type;
+
+	of_property_read_u32(phy, "phy-type", &phy_type);
+	of_node_put(phy);
+
+	return phy_type;
+}
+
 static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -598,6 +626,15 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->format = ctx->desc->format;
 	dsi->mode_flags = ctx->desc->mode_flags;
 
+	/* A MIPI D-PHY link to the panel shall have exactly 4 data lanes */
+	if (nt36672e_get_dsi_phy_type(dev) == PHY_TYPE_DPHY) {
+		ret = drm_of_get_data_lanes_count_remote(dev->of_node, 0, -1, 1, 4);
+		if (ret > 0 && ret != 4)
+			return dev_err_probe(dev, -EINVAL,
+					     "%d D-PHY data lanes described, 4 required\n",
+					     ret);
+	}
+
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
-- 
2.51.0

