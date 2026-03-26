Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6DF10A88ED
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A9910EB79;
	Thu, 26 Mar 2026 17:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZtkZzRDW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179D010EB90
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774546299;
 bh=LUVBt0a9e/3u7eeqwpYouo5CnB40cE0kF77UUAB2x5o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZtkZzRDWdfqwCLCoh/EG2llkskWvuI94KvwhfGrROwed8xidwU0/EXCEt5uStGdCi
 RnYwhYF0RdmrP2dtJKF8QPRMiOo5qJLAN/FBUZGx3cC2FKxDQHQi5ugvv/JzRGtLEE
 aO/BbfF0KcG1HKP4cwPqUQEobZYuMsGb0FOmbMVSjOv4XJWQ/rjrtu0UVuMxqR/aXr
 BejdPGAkAy3h14nbnaO+xCqXRp2e5oH9PF8ytR1mZJ4cPIUJlDYwzjSo1n+ezp5XvH
 NOXNKDhg8MxrCMarppsKqv68dqhvrHfndIWRI/zS1vlZ/un1/XVWwVhVFWSFrVIqnz
 UVgX6Y85TVQCA==
Received: from jupiter.universe (dyndsl-091-248-208-149.ewe-ip-backbone.de
 [91.248.208.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C03117E6198;
 Thu, 26 Mar 2026 18:31:39 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 44E1248002F; Thu, 26 Mar 2026 18:31:38 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 26 Mar 2026 18:31:29 +0100
Subject: [PATCH 05/10] drm/bridge: synopsys: dw-dp: Support software
 triggered OOB HPD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-synopsys-dw-dp-improvements-v1-5-501849162290@collabora.com>
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
In-Reply-To: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
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
 Conor Dooley <conor+dt@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3766;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=LUVBt0a9e/3u7eeqwpYouo5CnB40cE0kF77UUAB2x5o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnFbXn8OLq1td1QPrCxAmzGR/Li5V8Xuh/Cr
 bn/q2ss2ZXC5YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpxW15AAoJENju1/PI
 O/qaXFsP/1lQ2vZSGC393cFb19tWxy3npPmE6gfBd4BI2lhwJ4qJndQChOqJGHShu/QMro7XIqb
 5JZJ1hhJtzK6pLJUb1RGhB5S3fA5hiBUbKARN+fW/XvU4jv4S4hmWPJ7Lz/8stxzzFqvMEWxYaG
 KW8DY+PaiCSXUGs1yuP9UT0eyxsZD2DsFUz+gWXPpg+BJAuU0znO/zjO1h/M6TK2QKx/Yvrs7r+
 pvrNnl6Gocej7jKMsPjqMkTO2adtYgTIYNd50+eFbe9Eh/IBLxRt73m1/0WB1ym9K1xOz8g0IWZ
 yzy6QUbAhFGQvpQC+37wWT1HDCkfDiX+lpKRyHWTH4zxReVnayCYzkwynlMELDyEE5mMbh+176a
 xVDDf0dMGGa8xeZ9YxobdBg3mKXiIKRlREwbporK+w6Ruxpys0SfaIrDvoEAVMqw/4cImeuDyDb
 QL8RLQArDaLrflZvcHZh82FBpVEyNwWprI4cEkZ7JgdDWUvAIy8E2+rkwjrQ05zu//qhbo79nov
 doKaZlPBfNI6TeIbMuwEmiEHBdy1+8JXsj2OojkglP4ndeJcYs3YuwtYptiRCNm4adGVt8Vmxtg
 jPS92X8sckKy4o2GrWyc/fTZKCv1dJ4LgBD66kkmQwcokgeIEMdibX980/NVKivBpu8++PKB8pS
 9nW94I/2qOUbx5eZ/dWE20Q==
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
index c3a108f1faa9..df2d629287fd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1824,6 +1824,19 @@ static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_b
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
@@ -1837,6 +1850,7 @@ static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.detect = dw_dp_bridge_detect,
 	.edid_read = dw_dp_bridge_edid_read,
 	.detach = dw_dp_bridge_detach,
+	.oob_notify = dw_dp_bridge_oob_notify,
 };
 
 static int dw_dp_link_retrain(struct dw_dp *dp)
@@ -1973,6 +1987,19 @@ static void dw_dp_phy_exit(void *data)
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
@@ -1988,7 +2015,9 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 
 	dp->dev = dev;
 	dp->pixel_mode = plat_data->pixel_mode;
-
+	dp->plat_data.hpd_sw_sel = plat_data->hpd_sw_sel;
+	dp->plat_data.hpd_sw_cfg = plat_data->hpd_sw_cfg;
+	dp->plat_data.data = plat_data->data;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 	bridge = &dp->bridge;
 	mutex_init(&dp->irq_lock);
@@ -2086,6 +2115,13 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
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
index 25363541e69d..4aacd0e56f50 100644
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

