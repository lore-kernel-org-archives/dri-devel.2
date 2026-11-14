Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF65606A89B
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GMF7QJPN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A9B10E5AE;
	Sat, 14 Nov 2026 05:01:04 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5103510E1F3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632456;
 bh=2SW6PmDG0yrD8Yx97C+1giB3T/qSRpEBJOx1Ut6DCZQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GMF7QJPN0an/8lNGE8S+gHB88krufWZw1sMViF1lwK/U3FclciW1Y2xPOEbMp+ai0
 tMOwNXq+9Eiq52w02m27xBf2kr7VBmlrmxKdcsMZGOHuSew+PPOVOmcpIhuvddIm6n
 rd4nAfgR6zosA6OFeKStdjzK5dhI/bgGggpmwYHTTAh3IzaDR9J0UTqRiU84+jpg4+
 aVZjDxAs0GIhWQy6WQnkKEwh7XkWxOrAGrpPsS30Ky5kgKtMEX17yol1dlomJ7JBJO
 N4CID1nqD2KxoEorxaZs/y1uREG5N7UWfigjSWVoTQUL1uaoi6v71+ZyWoWd1JVoWo
 O+evsqy823Msw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5274917E05F1;
 Sat, 14 Nov 2026 06:00:56 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0C73548002B; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:34 +0100
Subject: [PATCH v12 01/23] drm/bridge: synopsys: dw-dp: Register DP AUX on
 bridge attach
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-1-d42d3dc5bdd4@collabora.com>
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
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3654;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=2SW6PmDG0yrD8Yx97C+1giB3T/qSRpEBJOx1Ut6DCZQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36we1n60CfD453KtOLs6rWc47hi3gH14rt
 zZG6MVp8bt0pYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qaCskP/iqFVmWsesC2WC3pt/W1D4MjiyallhsfJe2EDlP3BeHVwkf+It5PQckrEDWALzslZcZ
 xnHDbKGrv9iY+RY+Ulq9RDlMcTiJJnHr6Bi5T8DEf61Pn1Z01AbJZRgQXDIpneOVYlzCBfl8xmP
 T3xJtEAjFrMdW4Zewdr9NAdkuGHXtZfXDumQ6ti8OUYlsskQMFPU1qhqIj1jgeukWoAh/E+rvvp
 o6zT1ZEjmCf+rgB1DYkfRvrs8j8qI/mEjUZayDKz4Dc/as+eRoJXfV8VpmBVmMXtKQno5ZbN7UK
 wL6/tzLC1Vy2bObNtV3CMfx3gukRS5fVTn4Eo8zFWS0zv/YjwTeJj4kGnhi8W5Xk3qxdqUh4RU0
 X2c7ebqzorfipi+mVSjMtWsYZukxJqAHJ4Rt9BQFX+a8PaI6XUNGqIrPSm4ZaDXlfEvtghmlggG
 2XJlRZkwF2G07pE/8IZ1gFfxPiAZl2u71ZEa0CK7g8F9Gb1pZp61UHrB6am/YuII00lDl5dfN/I
 lKf37fGNR8hyEYXVJI+SeN2fAvhlApNT0YsA0BtIGU08Nj9WzPcrC800Hcv25XSfin+UdCXoPTY
 86JoYtc9szytTazTDFy2xBQHqDpno3xgdmFMWh6EjCsVHY0g2LD+MwmrBz4uf2qnDoQULycLP46
 Vus8Lm5hix0sE6Jw98j4fdw==
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

Unregister the DP AUX device at the right spot as documented in the
drm_dp_aux_register() function description. This helps that it is
only accessed when the DRM device is ready and the bridge is powered
and initialized (further fixes are required for that).

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5+
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 55 +++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index cc613c7ee28d..0a34d6a6ace4 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1813,7 +1813,36 @@ static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_b
 	return &state->base;
 }
 
+static int dw_dp_bridge_attach(struct drm_bridge *bridge,
+			       struct drm_encoder *encoder,
+			       enum drm_bridge_attach_flags flags)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+	struct device *dev = dp->dev;
+	int ret;
+
+	dp->aux.dev = dev;
+	dp->aux.drm_dev = encoder->dev;
+	dp->aux.name = dev_name(dev);
+	dp->aux.transfer = dw_dp_aux_transfer;
+
+	ret = drm_dp_aux_register(&dp->aux);
+	if (ret)
+		dev_err(dev, "Aux register failed: %d\n", ret);
+
+	return ret;
+}
+
+static void dw_dp_bridge_detach(struct drm_bridge *bridge)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	drm_dp_aux_unregister(&dp->aux);
+}
+
 static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
+	.attach = dw_dp_bridge_attach,
+	.detach = dw_dp_bridge_detach,
 	.atomic_duplicate_state = dw_dp_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
@@ -2043,20 +2072,10 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 	if (ret)
 		return ERR_PTR(ret);
 
-	dp->aux.dev = dev;
-	dp->aux.drm_dev = encoder->dev;
-	dp->aux.name = dev_name(dev);
-	dp->aux.transfer = dw_dp_aux_transfer;
-	ret = drm_dp_aux_register(&dp->aux);
-	if (ret) {
-		dev_err_probe(dev, ret, "Aux register failed\n");
-		return ERR_PTR(ret);
-	}
-
 	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to attach bridge\n");
-		goto unregister_aux;
+		return ERR_PTR(ret);
 	}
 
 	dw_dp_init_hw(dp);
@@ -2064,35 +2083,31 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 	ret = phy_init(dp->phy);
 	if (ret) {
 		dev_err_probe(dev, ret, "phy init failed\n");
-		goto unregister_aux;
+		return ERR_PTR(ret);
 	}
 
 	ret = devm_add_action_or_reset(dev, dw_dp_phy_exit, dp);
 	if (ret)
-		goto unregister_aux;
+		return ERR_PTR(ret);
 
 	dp->irq = platform_get_irq(pdev, 0);
 	if (dp->irq < 0) {
 		ret = dp->irq;
-		goto unregister_aux;
+		return ERR_PTR(ret);
 	}
 
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
 					IRQF_ONESHOT, dev_name(dev), dp);
 	if (ret)
-		goto unregister_aux;
+		return ERR_PTR(ret);
 
 	return dp;
-
-unregister_aux:
-	drm_dp_aux_unregister(&dp->aux);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(dw_dp_bind);
 
 void dw_dp_unbind(struct dw_dp *dp)
 {
-	drm_dp_aux_unregister(&dp->aux);
+	/* nothing to do */
 }
 EXPORT_SYMBOL_GPL(dw_dp_unbind);
 

-- 
2.53.0

