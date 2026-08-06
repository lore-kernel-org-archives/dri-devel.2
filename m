Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8176EC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34DC310E372;
	Thu,  6 Aug 2026 17:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RZ9mtBBg";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD9210E368
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786035745;
 bh=txePxYwdFmmkXwiXxafgQt3MgLfgj0QplEgG4SoSLks=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RZ9mtBBg6RV9apCkQJI6wu2VgN0IbivyR14qhQ9+ffnWBABiUaLTXcCdoaBESf+x5
 qGZFC4hcKyjRQdEpgVaRCDyUreGm0c45QH4IxYEhBKtBaLV3AJAVzvZNZotPnEFDa+
 ZYqJ9FQAA5yivdDu+vyEIlnmSTrKrspSiN6DxfGx73q2so5CeO325wlLG1VXtJxMeJ
 Z1g5V17yXfq+iM2J+j3ywUT5wdCp3FCgmdDYP9/qOmH7CqVxKEdgHQReY5k3vnacet
 ZMcKWz05rthnc7VM6IVx2nRJooz57HbwsZAS3gSxRWFMPqbv/AKXCAgaOWtEpyn4mk
 I1x7XKHOp4XKA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AB1AC17E11E6;
 Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 06A40480047; Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 19:02:16 +0200
Subject: [PATCH v11 10/21] drm/bridge: synopsys: dw-dp: Add follow-up
 bridge support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-10-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=txePxYwdFmmkXwiXxafgQt3MgLfgj0QplEgG4SoSLks=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viALByinijk1o/bDaiGRhFLpnvzN1yAnp
 FZRZBagCca5SYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qahEYP+wccCQMpIU4jFcMT0PcwZlmt71631i2RBhQDp3znJdPa6E4eQpTsBxCrZH2rwPeTCya
 O7CV02gRZZ9DYUvR59kzH3VTxyOf0EbO+akq7dHzSiwRZ2PtJhTvUgRYvRkLBaFol/Y/I/XP7Ss
 4WrW4mDUNIcpxOCqrpyU0iH/3MJKhhTXHQ0rxlQr26h/SfgACs+xQZSgKBx9ol3uuMVJtH4VLz5
 0NOa/8Fe7oKFmYH0mQac7Wh9m08Y4bmH4VRryewLisqIowetUNA/q79wFFEoriuExB59SfRft1b
 nkqkp1p09Jt57O5uhtDFs2pQWr8TMrO1fpbC/AQUrQtUU4AoZDZye/BVQId75nBEhvwJwdBwcDu
 0yymk8NeGn4/fc1bMZ7WlptqecCogPWKxiwx8XHf0vL7J6o4Vx6IZaNleRUMhxA4Q8Ql2WzmJ47
 pRN/tsfGWD5uYN33Bz9S9ljKpAE9kKBy69rVb80Qt93LxIctk5N0e82zagJi7+iT6H24oYiHjKn
 La276iOiest4wCftuJhHwsmFPPR824L1TtvJL4NML5mhXXYRlLjBM5HRzMdp+LZHqaKZdm464YK
 2pziLS03IhZ7P6+1LHdpi8t2oMM/DCG3fHHcftB0yBJKj7CsHbpRbzFvV7oL1uAkb32Ea85W3p8
 GwzL6LPACWuYga0t55hwrEg==
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

Add support to use USB-C connectors with the DP altmode helper code on
devicetree based platforms. To get this working there must be a DRM
bridge chain from the DisplayPort controller to the USB-C connector.
E.g. on Rockchip RK3576:

root@rk3576 # cat /sys/kernel/debug/dri/0/encoder-0/bridges
bridge[0]: dw_dp_bridge_funcs
        refcount: 7
        type: [10] DP
        OF: /soc/dp@27e40000:rockchip,rk3576-dp
        ops: [0x47] detect edid hpd
bridge[1]: drm_aux_bridge_funcs
        refcount: 4
        type: [0] Unknown
        OF: /soc/phy@2b010000:rockchip,rk3576-usbdp-phy
        ops: [0x0]
bridge[2]: drm_aux_hpd_bridge_funcs
        refcount: 5
        type: [10] DP
        OF: /soc/i2c@2ac50000/typec-portc@22/connector:usb-c-connector
        ops: [0x4] hpd

It's fine to fatally error out when there is no follow-up bridge
as the Rockchip Designware Displayport controller is the only
user of the bridge helper and has the port marked as required
in its binding.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index b9864a17c01d..a6099f7ddc87 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -330,6 +330,8 @@ struct dw_dp {
 	struct dw_dp_plat_data plat_data;
 	u8 pixel_mode;
 
+	struct drm_bridge *next_bridge;
+
 	DECLARE_BITMAP(sdp_reg_bank, SDP_REG_BANK_SIZE);
 };
 
@@ -1894,7 +1896,22 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 
 	enable_irq(dp->irq);
 
+	ret = drm_bridge_attach(encoder, dp->next_bridge, bridge,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		dev_err(dev, "Failed to attach next bridge: %d\n", ret);
+		goto err_disable_irq;
+	}
+
 	return 0;
+
+err_disable_irq:
+	disable_irq(dp->irq);
+	cancel_work_sync(&dp->hpd_work);
+
+	drm_dp_aux_unregister(&dp->aux);
+
+	return ret;
 }
 
 static void dw_dp_bridge_detach(struct drm_bridge *bridge)
@@ -2060,6 +2077,13 @@ void dw_dp_unbind(struct dw_dp *dp)
 }
 EXPORT_SYMBOL_GPL(dw_dp_unbind);
 
+static void dw_dp_put_next_bridge(void *data)
+{
+	struct dw_dp *dp = data;
+
+	drm_bridge_put(dp->next_bridge);
+}
+
 static void dw_dp_phy_exit(void *data)
 {
 	struct dw_dp *dp = data;
@@ -2157,6 +2181,16 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 		return ERR_PTR(ret);
 	}
 
+	dp->next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
+	if (IS_ERR(dp->next_bridge)) {
+		dev_err_probe(dev, PTR_ERR(dp->next_bridge), "failed to get follow-up bridge\n");
+		return ERR_CAST(dp->next_bridge);
+	}
+
+	ret = devm_add_action_or_reset(dev, dw_dp_put_next_bridge, dp);
+	if (ret)
+		return ERR_PTR(ret);
+
 	dw_dp_init_hw(dp);
 
 	ret = phy_init(dp->phy);

-- 
2.53.0

