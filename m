Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED3606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jcfm1IlZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43D410FB0B;
	Wed, 28 Oct 2026 09:52:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE9810FB04
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:52:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8DFD43E6F;
 Wed, 28 Oct 2026 09:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0559D1F01825;
 Wed, 28 Oct 2026 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793181148;
 bh=vVaENIb3gi4a6qUYmV+6bMnHz0LQhnnIMRxjrtMOFDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Jcfm1IlZnLUVGHKM1UGQMB4TyYId8HGB9mr3U3D3JtG6YB0TK0kPfENOSH+arBb8i
 x57wwbKwrx2sy7JXYRgQsACynci0jvQHoXADO9TU/RwLJxuMqD3NvMDXFYPGlNkFpW
 LpQuaW93PrA4OKrlDQi4+qmA3k8rY1uhr1q4VPh/HK9tcIWYL+950I+zTjfEQdz/96
 fnD3RXsEkqNoUBWIkIwKhf25eGnqLVTCKe1Gzbzk0knjrdvwjgTfB0UbYGoGb5JYKk
 GqANUqulFWkKwYYba1h2nmA4/YbQR3QFr7s5Q1oQMDCeFBg75/AGKWnXDBFNYzWVuF
 qhLkNwNvhPBDQ==
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
Subject: [PATCH 5/8] drm/panel: novatek-nt36672e: Verify the number of D-PHY
 data lanes
Date: Wed, 28 Oct 2026 11:51:48 +0200
Message-ID: <20261028095151.1682096-6-vz@kernel.org>
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

The NT36672E panel in the MIPI D-PHY mode is connected over 4 data lanes,
a mismatching device tree description results in a panel, which won't work.

Get the PHY type of the DSI link from the PHY of the DSI host, and get
the number of data lanes from the DSI host endpoint to check the match.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index 0a2d54ee8069..33676e334b9f 100644
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

