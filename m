Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DCDCD3426
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 22:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 719A510E49D;
	Thu, 30 Apr 2026 22:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Kb+xh3ji";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFB010E495
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 22:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777587637;
 bh=KldQJCCytI0EOfv1u6SZhFGOllIGEwoVUPG9lE2ZVeQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Kb+xh3jicDUjQZ8W+iM69FXXFRoRN+CFBp62jfJzmfXWrjUHlYd50eiQSin/F9ULB
 M3Ez9zwT7855X8iVpgbZZxVsJ1RdZgOwMDmCmgBUqwvbBDrzjQPnR+EgIz4ClXf8zl
 g+5y7WhwIddE8p27WNDcfckiPiLXQLO8XqovSorBRozn88RJRHF8e6Sz/0GxKD34qN
 VoHQQg2gqhLmt3DmSIiMRMIiKy1sSyg/ifIKnuPiKdS34+a/xa9ttwFk8bO7NKFjg7
 bi/O/cSJNbus8FzYLYm/31dn23JlpWpiFk3C5zvgpp63KwUrTtfyxS5mNm0tbpjyYi
 Wt2KMNVuwSctA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BD27917E1584;
 Fri,  1 May 2026 00:20:37 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 1A618480048; Fri, 01 May 2026 00:20:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 01 May 2026 00:20:35 +0200
Subject: [PATCH v2 08/12] drm/bridge: synopsys: dw-dp: Support software
 triggered OOB HPD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-synopsys-dw-dp-improvements-v2-8-d7e7f6bac77f@collabora.com>
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
In-Reply-To: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=KldQJCCytI0EOfv1u6SZhFGOllIGEwoVUPG9lE2ZVeQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnz1bSYLPjKfe+DkHH3iJ8mNyF4LF/K4ea8o
 VTwmsIMUSzlUokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJp89W0AAoJENju1/PI
 O/qaOe4P/2uhAvGcpzInrYV9+iXJXu5HJQKW5TyvK8kzl5L+iOm+fLiC1tWijU1oEcWJpCwuM88
 kDvBCyPg3hojTGx/wCv2884JPOoqhVVJSihzT7KG2K36pHWAK1GfPQWGP2py4wwYRg9TH2b2zaT
 0NGsL04DmIOz4llF/1qTAgRkIOXj0uV6Y4ADhPSDmwoBzhcjWX0C6Nyh/F7kVBUyVnqTf+NtivM
 imV04L47o3ZxQzdjKFrSdZHJbTwcme67QwAiPdmIZaY0aOgRPjB9yOWPotjWNmAQZrZ3Fix+9Of
 L9gW/ShX8QMbVXUXmgncd4y06dPKILmwjCw78rz2ubJ75wmPc3mSBKSdMVB9kPB37l/Sd93Y2UT
 mwaNIlQBzGJWFrKVLIDshEfCZjLZj4zUXlE4M7DOTG2Z7dbxyVUNhD6rXEY7jDsNt+3dFRnb5o9
 //Ktd/5XoW+rvvbf6n/0Bo1W0mc7Pfbfw27OevtpMPJkQ/FwnHJB+qldlPtq7yZNRGQZK0K/38M
 Yfhs/iw/CZkj9nvqVhUArfxmo0WrrwHjjR8Ov3WbQAOTdjUe7gvis8lvMtsTX2AjOdnsZx1mPXP
 koBdemI+56V9zAE5o9dxLBkUpN5a3KRpmJeobE4RhQDoenH1AkaJ68MnJTFU/3mscm+89gN5CLb
 0maiahiLzbKsyDbQh8SE6HA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Add support for USB-C DP AltMode out-of-band hotplug handling. The
handling itself is implemented in the platform specific driver as the
registers to force HPD state are not part of the Designware DisplayPort
IP itself. Instead the platform integration might provide the necessary
functionality to mux the HPD signal.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 38 ++++++++++++++++++++++++++++++++-
 include/drm/bridge/dw_dp.h              |  3 +++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index ccc55e40e81c..7ade88f74466 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1817,6 +1817,19 @@ static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_b
 	return &state->base;
 }
 
+static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
+				    struct drm_connector *connector,
+				    enum drm_connector_status status)
+{
+	bool hpd_high = status != connector_status_disconnected;
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	if (dp->plat_data.hpd_sw_cfg)
+		dp->plat_data.hpd_sw_cfg(dp->plat_data.data, hpd_high);
+	else
+		dev_err_once(dp->dev, "Missing platform handler for OOB HPD handling\n");
+}
+
 static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.atomic_duplicate_state = dw_dp_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -1829,6 +1842,7 @@ static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.atomic_disable = dw_dp_bridge_atomic_disable,
 	.detect = dw_dp_bridge_detect,
 	.edid_read = dw_dp_bridge_edid_read,
+	.oob_notify = dw_dp_bridge_oob_notify,
 };
 
 static int dw_dp_link_retrain(struct dw_dp *dp)
@@ -1965,6 +1979,19 @@ static void dw_dp_phy_exit(void *data)
 	phy_exit(dp->phy);
 }
 
+static bool dw_dp_is_routed_to_usb_c(struct drm_encoder *encoder)
+{
+	struct drm_bridge *last_bridge __free(drm_bridge_put) = NULL;
+	struct fwnode_handle *fwnode;
+
+	last_bridge = drm_bridge_chain_get_last_bridge(encoder);
+	if (!last_bridge)
+		return false;
+
+	fwnode = of_fwnode_handle(last_bridge->of_node);
+	return fwnode_device_is_compatible(fwnode, "usb-c-connector");
+}
+
 struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 			 const struct dw_dp_plat_data *plat_data)
 {
@@ -1980,7 +2007,9 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 
 	dp->dev = dev;
 	dp->pixel_mode = plat_data->pixel_mode;
-
+	dp->plat_data.hpd_sw_sel = plat_data->hpd_sw_sel;
+	dp->plat_data.hpd_sw_cfg = plat_data->hpd_sw_cfg;
+	dp->plat_data.data = plat_data->data;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 	bridge = &dp->bridge;
 	mutex_init(&dp->irq_lock);
@@ -2078,6 +2107,13 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 		goto unregister_aux;
 	}
 
+	if (dw_dp_is_routed_to_usb_c(encoder)) {
+		dev_dbg(dev, "USB-C mode\n");
+
+		if (dp->plat_data.hpd_sw_sel)
+			dp->plat_data.hpd_sw_sel(dp->plat_data.data, 1);
+	}
+
 	dw_dp_init_hw(dp);
 
 	ret = phy_init(dp->phy);
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
index 22105c3e8e4d..2127afa26b2c 100644
--- a/include/drm/bridge/dw_dp.h
+++ b/include/drm/bridge/dw_dp.h
@@ -20,6 +20,9 @@ enum {
 struct dw_dp_plat_data {
 	u32 max_link_rate;
 	u8 pixel_mode;
+	void *data;
+	void (*hpd_sw_sel)(void *data, bool hpd);
+	void (*hpd_sw_cfg)(void *data, bool hpd);
 };
 
 struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,

-- 
2.53.0

