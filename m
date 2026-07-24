Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A51C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E3310F46D;
	Fri, 24 Jul 2026 18:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="VLNzWbB/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11D910E069
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784916209;
 bh=ZVoO+TO8uWEwz9LdVqxFuCH+Ajmt6oSDwVT54yj0maE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VLNzWbB/g4HqO8DnfBTdyUeydm4rmk6WHBa6jv5kwj9Whxa8jhC1yiaKz/dCcGyyW
 txRCwCxkTuy872zTMITc2DCBrEoiOY+hSkTIBv7+80mrCxDX9IZMsvFSLRuNICwWoO
 zjTf1Imh+hKXGYtBcfkWgU4Q8FBMYEUPPCfZk9/IhHa3IBW+BakuP7H8U5zq20s+sP
 kHFiWXOSCndaMmm18tf00vit9dyoz3qvHY+hX43Z42eHg4zIdUE9+BDzQpc6MV9dbU
 K597Zem3wSKtFsPPgTiy6RIx3eNTzo+GKuXYo4oDd3wO4LOcbegGWcioBmAG3Qt4Ao
 2+SHHEBVPBFLA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A82E17E0269;
 Fri, 24 Jul 2026 20:03:29 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id E5DEC480038; Fri, 24 Jul 2026 20:03:28 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 20:03:29 +0200
Subject: [PATCH v6 07/16] drm/bridge: synopsys: dw-dp: Add follow-up bridge
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v6-7-041d99a19c4e@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
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
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=ZVoO+TO8uWEwz9LdVqxFuCH+Ajmt6oSDwVT54yj0maE=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpjqPBt+d+PL6B9eF1+QKpltTd/ZEWpxZF0o
 RUjyOZQHg03CYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqY6jwAAoJENju1/PI
 O/qa4bQP/iD1nY7GVxlDczJhQ4MM9ry4m0ubrm6201/KiAAJVW6neTdQUCpq/oK5vxkN88gJFDU
 auulRqBTi7qyXiZbEHYAUlKev1B+nmSemXwyU1o7SYXOMJojyncdmhQvrwRmTyxtjar/Rc8DTl0
 ZHpPpU0jRlLmEf11ciHB8KLBm4kk0qo2hL6V2ps/GyYtAbXIQMBsqtO91dNOJB26koqZIYvdNuR
 tWbblM0Uw/iBpAfcsmlLmPeMGbCZevsZ4UnLhCwBnW4XRSsC4o1RmRP4g73Ld2mTVIRIMrubT3G
 UGFxTR7rMXUK5SwYuEhyxGL4g+D4U5veyUKKlTT+ok7ah88EiLcuXF5TTITKpFaAAIRpxcOVfSW
 PlpWo7qC+Uou8PwbCxXeebiIhTjFL44TGo4W6stbmkJL0aQwmZq1AA78pY/MmqtKuJlgKKVP31K
 N7gZlbIa3xnfE++7oW6uBBN325tXYs/n4qsqoz7QDTRK2GvQVKKEvYQnkhCwEHr7dUs+d+duRJq
 0LqFsfjUrs+LOho21+34Mnvu6z/SvtsgmausVxVBahYOmZFQRYrqgVIfLCCIq8K+Q+rq/D3QsJA
 YqvJTSKPoEG3TH9xY3ub/mQMOT1kZGvk6CfxRADLdq+KQoc+f5Ijn5MBka7oiN6lL5fjIWbSbsH
 nqLiKCc7kje7vgsFCUkksog==
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
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 259efc25b56e..591b75c4cc36 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -329,6 +329,8 @@ struct dw_dp {
 	struct dw_dp_plat_data plat_data;
 	u8 pixel_mode;
 
+	struct drm_bridge *next_bridge;
+
 	DECLARE_BITMAP(sdp_reg_bank, SDP_REG_BANK_SIZE);
 };
 
@@ -2021,18 +2023,35 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 		goto unregister_aux;
 	}
 
+	dp->next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
+	if (IS_ERR(dp->next_bridge)) {
+		ret = PTR_ERR(dp->next_bridge);
+		dev_err_probe(dev, ret, "failed to get follow-up bridge.\n");
+		goto unregister_aux;
+	}
+
+	ret = drm_bridge_attach(encoder, dp->next_bridge, bridge,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to attach next bridge\n");
+		goto put_next_bridge;
+	}
+
 	dw_dp_init_hw(dp);
 
 	ret = phy_init(dp->phy);
 	if (ret) {
 		dev_err_probe(dev, ret, "phy init failed\n");
-		goto unregister_aux;
+		goto put_next_bridge;
 	}
 
 	enable_irq(dp->irq);
 
 	return 0;
 
+put_next_bridge:
+	drm_bridge_put(dp->next_bridge);
+
 unregister_aux:
 	drm_dp_aux_unregister(&dp->aux);
 
@@ -2048,6 +2067,7 @@ void dw_dp_unbind(struct dw_dp *dp)
 	disable_irq(dp->irq);
 	cancel_work_sync(&dp->hpd_work);
 	phy_exit(dp->phy);
+	drm_bridge_put(dp->next_bridge);
 	drm_dp_aux_unregister(&dp->aux);
 	drm_bridge_remove(&dp->bridge);
 }

-- 
2.53.0

