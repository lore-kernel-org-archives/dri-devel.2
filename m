Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C57ECD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FD410F611;
	Fri, 12 Jun 2026 18:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mDO51Hzs";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C558010EAF3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781287253;
 bh=KpZ/GTLLPgVDKAOSipReW62jls7h/kg8HzcOThxf+bY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mDO51HzsDiBGsO9QlE4qEQ7gfU88d3uubEJU9gj36ij15dRLw+7GSUdECIOtga14k
 zJ8gnxc4aRcz4KplzTCyEfhuZa4JC9/cjqPF/u95v94fDQ9qquthbmgPk5iV6aG5Qo
 cQ+4X/Cw+FkFrzFROkN5i4rXYi3/lqm/nyK8FKuxy28v76CW1QbGAzM6j/wGQNtiqS
 MU/xZX9cLPk9ziVd2pmQhM5su8RAI0fHhrSAAJDqWKSlGj1P5RFsZ7HOJLyzF5TbXn
 TlFKV4e/vHwLgNqyE40Rl/JBgorWKhrQYyZmA1uyMgyglHMNL/Zf5j0+QXdydkjixj
 pRb64JCS8285A==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E24417E0E6E;
 Fri, 12 Jun 2026 20:00:53 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 822DD480035; Fri, 12 Jun 2026 20:00:52 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 12 Jun 2026 20:00:53 +0200
Subject: [PATCH v3 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-synopsys-dw-dp-improvements-v3-7-dc61e6352508@collabora.com>
References: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=KpZ/GTLLPgVDKAOSipReW62jls7h/kg8HzcOThxf+bY=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGosSVR4BiIQqHL+BfJfXPL7BIkISy7bH1dRq
 7ZTxEvb9UpdRIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqLElUAAoJENju1/PI
 O/qanSwP/1Kxg/dEXQeX6oToNqMfpeYNrrseyzEiKoR5WBb50EXZl3UQpMgXARjveRkI6/NV5SY
 vU2OTcs1Pr8INeYLPWt37c8ktmaOfFuNgRtyogC7MqshZKARH+BF3atyeS6WuPkcqq8gCi2AEIM
 1X2wyVrq/DGf//DoRJhpXSnnqDfuhrHRAjzMaYlhrD2SU5iWtZehMteShj/CCNH7SaT+VbylaS2
 zT4sNwmiXc6us4uMeED762gdCZn4Ti2rGmkoUvTyLALeAigmIKCMEeXsCsYwC5vig1V5EF0qeNT
 Y3YN/Tg/sk9jjQTU7rNXPG3O0IbSoKmh+UcJIXQhi7GpvOTiXIpZl/d7PhVGifM2nN9cekS3fDI
 P7sHl8jQOSQ6ty7cW4VXqpXa+uFv+nCeVZPqf7SeI6QlMwCYGUkJMSfaIzUjG+VsbnEkaLF91xU
 fnBLTryLukcHoVK7+HL67No8WhrZD8DB/j1tW9deFQF74pxZBpydSD3DVhpDLuSBcioTUd+r33r
 Zsf0ea3Bm8Sn8EBuvIotCNzMac1Xpyw1/bm36leXaUEIpnDAokjzMo/oePoVGFl5X7mzUfCjdCe
 owkbT75vJG5cmIHSCG6vb12CZ1OUcIcDnjjOksdcPOHagwsoAeGQN1iFKIVk8vW1mJyoM2wpvVQ
 iJvgD8mOy+0Nl/F5hnK0tiw==
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

Add runtime PM stubs to the Synopsys DesignWare DisplayPort bridge
driver. Support is not enabled automatically and must be hooked up
in the vendor specific glue code.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 27 +++++++++++++++++++++++++++
 include/drm/bridge/dw_dp.h              |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 7fa38145e35c..7f4f36c61484 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
+
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
 	case DP_AUX_NATIVE_WRITE:
 	case DP_AUX_I2C_WRITE:
@@ -1655,6 +1657,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	int ret;
 
+	pm_runtime_get_sync(dp->dev);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (!connector) {
 		dev_err(dp->dev, "failed to get connector\n");
@@ -1709,6 +1713,7 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 	dw_dp_link_disable(dp);
 	bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
 	dw_dp_reset(dp);
+	pm_runtime_put_autosuspend(dp->dev);
 }
 
 static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connector *connector)
@@ -1729,6 +1734,8 @@ static enum drm_connector_status dw_dp_bridge_detect(struct drm_bridge *bridge,
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
+
 	if (!dw_dp_hpd_detect(dp))
 		return connector_status_disconnected;
 
@@ -2153,6 +2160,26 @@ void dw_dp_unbind(struct dw_dp *dp)
 }
 EXPORT_SYMBOL_GPL(dw_dp_unbind);
 
+int dw_dp_runtime_suspend(struct dw_dp *dp)
+{
+	clk_disable_unprepare(dp->aux_clk);
+	clk_disable_unprepare(dp->apb_clk);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);
+
+int dw_dp_runtime_resume(struct dw_dp *dp)
+{
+	clk_prepare_enable(dp->apb_clk);
+	clk_prepare_enable(dp->aux_clk);
+
+	dw_dp_init_hw(dp);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);
+
 MODULE_AUTHOR("Andy Yan <andyshrk@163.com>");
 MODULE_DESCRIPTION("DW DP Core Library");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
index 2127afa26b2c..3037e0290861 100644
--- a/include/drm/bridge/dw_dp.h
+++ b/include/drm/bridge/dw_dp.h
@@ -28,4 +28,7 @@ struct dw_dp_plat_data {
 struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 			 const struct dw_dp_plat_data *plat_data);
 void dw_dp_unbind(struct dw_dp *dp);
+
+int dw_dp_runtime_suspend(struct dw_dp *dp);
+int dw_dp_runtime_resume(struct dw_dp *dp);
 #endif /* __DW_DP__ */

-- 
2.53.0

