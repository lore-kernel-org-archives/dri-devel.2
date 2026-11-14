Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A1606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=V/oY3YUM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8B010EC67;
	Sat, 14 Nov 2026 05:01:18 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC78D10E660
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632457;
 bh=GpnBpqyy46Ez4LTGmSkCOWuQ1xcTftBjGoq1pGuIDVk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=V/oY3YUMk24DO2LuksYMEZbE2Z2LSuCywYKaPkHBTuyWgLyGI4JRz/3BTmIRsONG+
 WXhmj9MC1qRntXXdPDYEGL8SKt1ai0ijpYPU85b2SBxMU7PHGEhUtkKoTPqQqWeUip
 S+FRwlG+SGMDzRqbz/WJ4Wqs7XouV71eL+OzZZLFd/ODxlAQ+wE+2EKixE0bbRNedX
 c1TXME/trc3DsadBBba/A0F2x/DYcUK7eYS2sH5ZMoUZuN4boRuBsmyznYvjd4oxkD
 LtAEyyG1kUQ6p0tr/Sm1uUqK6zmSBL0aq9Mbf6NenqpQ8Deb+RUjd7zKDxinT+NQkv
 TTLcgsbF/wwaA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C813517E3BE7;
 Sat, 14 Nov 2026 06:00:56 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 1D83A48004E; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:45 +0100
Subject: [PATCH v12 12/23] drm/bridge: synopsys: dw-dp: Support software
 triggered OOB HPD
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-12-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3865;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=GpnBpqyy46Ez4LTGmSkCOWuQ1xcTftBjGoq1pGuIDVk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wcCgnukFFPLnUGlzPnTRdyTyLwNCnij0
 5DIIGK9BxtFSokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qaBvcP/RWsXBY1HJAnFh6ipqBYjtQ0tYHPfUYzCVmTJKtspig6LFu26eqmPlEn2SiNPCUbiDz
 mQUtr7eaALpTgIDofy/z3YlBSYOeUI1TUS1PklJKNPqfMELU8DplyOeD9LbkZnq1PTmDQf1kZf2
 x36/OAh/AbM+qzIrDhryD4aa0RzxVZv/VXJ5TK8C6Ex1BY7SvhS18npNi7tyO+jJFpEIeFrICDN
 O38yLJRHfC4tYaWy9dd0tQ97YBG8UR8zknRxVsoCQUqvBCEL8HuDW/alLcHfE74EiT1FwJ9mRd6
 sKInOVwy2spkfot/d3RwZfGxD1i1dhj6G+kmkf3+xXNFrpIUa1CK7eC91QNAj1Uw3lWlhH+brgg
 RCaeTSRvCCVHyJpY+ZuTF8eGM01kWUxjpIX0yv+7KEW7FoQ9XUP3ivWsFfJPBQcLkiZW8FyA4UA
 g90Puj+LuJ3eGgKM0lTzMNNeVZHkyMS2cLGH67WavHCle2kpLftJ3jVte7aMIFKilHdmYoO9qFO
 eMg1JVFb0X8aPe2fjxcQ7Jsg/ErV+hCqp1b932GOfNwYGka6hg0bZn9dxl4mrNAnk6Uq7ezFjlB
 HfELQsjgnk0KKI6a6WfHVbuFSaPciu1+1zv/T7VVNVO7LCUTTF2p1zJoUsbuGXrPfmUqTk8b4Jw
 h4XaTECafMwXNt0yeQPcpyw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for USB-C DP AltMode out-of-band hotplug handling. The
handling itself is implemented in the platform specific driver as the
registers to force HPD state are not part of the Designware DisplayPort
IP itself. Instead the platform integration might provide the necessary
functionality to mux the HPD signal.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5+
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 41 +++++++++++++++++++++++++++++++++
 include/drm/bridge/dw_dp.h              |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 74ba1306caee..b4eed4d0a520 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1875,6 +1875,19 @@ static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_b
 	return &state->base;
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
 static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 			       struct drm_encoder *encoder,
 			       enum drm_bridge_attach_flags flags)
@@ -1903,6 +1916,13 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 		goto err_disable_irq;
 	}
 
+	if (dw_dp_is_routed_to_usb_c(encoder)) {
+		dev_dbg(dev, "USB-C mode\n");
+
+		if (dp->plat_data.hpd_sw_sel)
+			dp->plat_data.hpd_sw_sel(dp->plat_data.data, 1);
+	}
+
 	return 0;
 
 err_disable_irq:
@@ -1923,6 +1943,22 @@ static void dw_dp_bridge_detach(struct drm_bridge *bridge)
 	drm_dp_aux_unregister(&dp->aux);
 }
 
+static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
+				    struct drm_connector *connector,
+				    enum drm_connector_status status)
+{
+	bool hpd_high = status != connector_status_disconnected;
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	if (!dp->plat_data.hpd_sw_cfg) {
+		dev_err_once(dp->dev, "Missing platform handler for OOB HPD handling\n");
+		return;
+	}
+
+	dev_dbg(dp->dev, "Force HPD connected=%s\n", str_yes_no(hpd_high));
+	dp->plat_data.hpd_sw_cfg(dp->plat_data.data, hpd_high);
+}
+
 static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.attach = dw_dp_bridge_attach,
 	.detach = dw_dp_bridge_detach,
@@ -1937,6 +1973,7 @@ static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.atomic_disable = dw_dp_bridge_atomic_disable,
 	.detect = dw_dp_bridge_detect,
 	.edid_read = dw_dp_bridge_edid_read,
+	.oob_notify = dw_dp_bridge_oob_notify,
 };
 
 static int dw_dp_link_retrain(struct dw_dp *dp)
@@ -2105,6 +2142,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 
 	dp->dev = dev;
 	dp->pixel_mode = plat_data->pixel_mode;
+
+	dp->plat_data.hpd_sw_sel = plat_data->hpd_sw_sel;
+	dp->plat_data.hpd_sw_cfg = plat_data->hpd_sw_cfg;
+	dp->plat_data.data = plat_data->data;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 
 	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
index a82412a9e769..79b2cdf0df99 100644
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
 
 int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder);

-- 
2.53.0

