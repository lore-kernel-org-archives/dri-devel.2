Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3200D10A88F2
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3805110EBB2;
	Thu, 26 Mar 2026 17:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kKMSbr4+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1827310EBA4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774546299;
 bh=Cc/hsE27RhzeShv1G95aL+9ZQZFkIaFrEmCWFQE08M0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kKMSbr4+2ODo+Rtfv32nwMmdqlqG1VLNXRQ75PG8XA3TvpfVG3vnNhXCRKyMdGTkJ
 lZhWARAyvWznXFBOyvGkD/3oGAJwL0CZSuWqP2toKtKx4lSAmoYbJxCPLPTlmKimx6
 YCl3BC+T/0wQViDGeIdc/lnbEOi4FnIjgxN4ZtEcSHlMDoU3WaYRDA26TyJaq1vGtn
 Ay5EeoTWalqXZyISsfmFtNNnxh/bfXTr8/o1mdkY1JN9CmGc54l3k9LZ2HWC2o+gUq
 XzGPRkcQZJv7LUzBaz0QGhO8kwdnPUz8ArdEeazXEI4Nu2Op0RkYNyNETn2m2Nfkhu
 +6mF9nz6toh6g==
Received: from jupiter.universe (dyndsl-091-248-208-149.ewe-ip-backbone.de
 [91.248.208.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 01EDF17E6196;
 Thu, 26 Mar 2026 18:31:39 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 48240480031; Thu, 26 Mar 2026 18:31:38 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 26 Mar 2026 18:31:31 +0100
Subject: [PATCH 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-synopsys-dw-dp-improvements-v1-7-501849162290@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Cc/hsE27RhzeShv1G95aL+9ZQZFkIaFrEmCWFQE08M0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnFbXq20wXgacG8r8YAcir/+b19fw2zDTf/H
 3txgWvXsne7bYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpxW16AAoJENju1/PI
 O/qa5AQQAIcAjV/ywr3p/SPXBeOqCkYyHh0KXePSvx5bZhJnU0J78RfBgTWznpDQA0odvWFTDpm
 +hKyHMqRXVu0lX5NoSLNOGVXGUJQgCn1PPRO5ddBBm4hnCj7cc5F4ecm5F4RytGNYAsubHAQYuD
 FBPaxWH9Of8BjZikrs6kmZHwqXSy/hdr0hzkWgKZJtEfAicbbKx9dbXC4L4KgQXAJyw1nPNYHga
 DtTvBkyMNbaSE4OBp7lc1KINB2BuxAfGF/M05x/WoA9VPNDxId7YrRTaXyQ09UBdHsGc0YgeFZa
 g2ynBTAucekIXvP0NznzEm7TkkhGAuvav5PHgewhDXSzVfHO7Or5vA7zRoZ2usSuEw1RfSUMaB7
 QtEgbqnFPxq9mJYuWWZoPjbvpP9TOt5VvfuvxAIpM0+GO1VCJUeszmYPbOks+QHpFaCaec8g3xl
 VU5xB0yYLCS8U4ysHNs6F6B1F4q58sB0XA0U/Q28u3+sglNpB613A3K3iLmfP0wf6T3j083HYav
 aS5OEFVzqXjL9FO/q3bJQ4SuSSn8soh0lZ8/CAzuNN8Xse1bhWdaxqBoAW3LME6sy4Nn3C8EQN/
 r2SFdttjU0duTm7zSMPRjfJMCalEqUvLRy8W8UNoVoNMWZZgqbx4nEGbF3QjmbpPm9Hkv2E1MI+
 vZUxmij3e1yltmQxw/OwlGQ==
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
index df2d629287fd..9ee9e3b9d912 100644
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
 
@@ -2155,6 +2162,26 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 }
 EXPORT_SYMBOL_GPL(dw_dp_bind);
 
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
index 4aacd0e56f50..8377f4be8e9e 100644
--- a/include/drm/bridge/dw_dp.h
+++ b/include/drm/bridge/dw_dp.h
@@ -27,4 +27,7 @@ struct dw_dp_plat_data {
 
 struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 			 const struct dw_dp_plat_data *plat_data);
+
+int dw_dp_runtime_suspend(struct dw_dp *dp);
+int dw_dp_runtime_resume(struct dw_dp *dp);
 #endif /* __DW_DP__ */

-- 
2.53.0

