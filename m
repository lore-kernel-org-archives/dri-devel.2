Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED89606A330
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=airkyi.com header.i=@airkyi.com header.a=rsa-sha256 header.s=altu2504 header.b=tVr5tDMY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AE410F2A8;
	Tue, 20 Oct 2026 07:29:33 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED3910F2A8
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1792481324;
 bh=00DSnvQSLlU7c2a5io39bkdl0ItMeQnbkaYseBDyixg=;
 h=From:To:Subject:Date:Message-Id;
 b=tVr5tDMY480SJldj4Uui1fSaH3thmQcb9Me1tFBp2ARPQ5hQF+Oh4AKa6GKn2eOr/
 VTVUJ5OW6Kyzhrs/HJGx3iY9oyEwO9x2pcaHVxqY8DvDFIvAphsgKCikGaA8CEb6HT
 rQnBnt91R+ztPMznPpDIY0jYq61+XAAgbICYm7r4=
X-QQ-mid: zesmtpsz4t1792481322t514923e1
X-QQ-Originating-IP: /TJ000w8y8vwIxYHjlAvlKq+mX/nB5pqqfq7aEdXmZY=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 20 Oct 2026 15:28:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6990828045487407985
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v8 1/7] drm/bridge: aux-hpd-bridge: Add
 drm_dev_has_dp_hpd_bridge()
Date: Tue, 20 Oct 2026 15:28:10 +0800
Message-Id: <20261020072816.180-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261020072816.180-1-kernel@airkyi.com>
References: <20261020072816.180-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MJ6jNhKcfW6R3v6PMslEjS4Ucgmtk3fxIZa4H9JtnTKBsVcTMUrZl1R/
 /WAFY+Vl4eG+tnTM9gayApsSf/8e/vDoBTQJ2+pi8vyB1k3kG32NW5c35dU9euwVQN5PRgq
 nwobbkTFicPiHYixgj6/88BmqqWT4e/BuvPctbrsS6ErCCYKlBqpeO5hNHKZ2HWOjhUn/4g
 Q69tFGZknXFFhJTQuBZVfHi/IeZx4NSI39SrL1D5yZJacsN1rdovCwC5Rp9olrTF9dy9fju
 zj3npXYdQtInFZEHmOyJgcne4GpKyvqkAqAA0Ekyhr6nD3FgT5mP0M1vnutqrLCOlVb32Kx
 32zMb5Vl60CfOORqw0Kf2qUx6NEMrwjTJOhKNnCdzQDC6B5f861AX5ZnkXylIZ0g7CZ9jFI
 PIuh+HRb0ITK1faQ0B4YoMmrhWuBDMy0oHX/KBMEa+k0kCyiyRTvN9B7maUOTBDHfyXh/Mp
 7qU0YD4w2liAlrVFZ6bCJriLZWwGKCCJSmCsbBEZLMyYoEQpgjxiw+P7SlqAeWEQPjlEIp0
 C/IVhK4EDU45k6PoWXCN/fxpYfzm+nhJvDq9gx7I86n8jdOPS25SNplv2QTy6P1jsY8g2oC
 RTewu/GpSC4mM/GJ8YuXpYbynPpNfWXZUdTgwUd6XBZF3jU9HeG46TspXSknqlMjqFp1Oqy
 ENGohaIUEep6VZxwMI8kKXvd42moN9jNhHLSzaIwdtfvIST7SIS7YTK6HjOL4zruFBRTEEd
 Y78vh8T/AIPF0KTIZRbyyGRS0qa4edvkGMGVIcIoEHDACU+h9vEWNGaikk9HnPJzOOwpHG+
 WPpnDJwpkkSpnstjV9yLIyHmYDTBBuiCCdGjwNvoomFN4aiReF0u0PltzTAzmUlfGxrP418
 cLanHGzSv0lF/OtVV75YHOk5pp3OljAOXMutlG7GoYUToeHigtobuc5JrXyDSu62LdVvOm2
 WoEtvVaaX99qsMT4foUClnNEHgnckhSmsychjDYflSOO9Mw+BFmAV22vm63CPxGCurE/eBK
 ssAtWNww==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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
X-Archived-By: <archiver.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Add a new API to check whether a DisplayPort HPD bridge has already
been registered. This helps avoid duplicate registration of the same
HPD bridge, although the current framework allows doing so.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
(no changes since v7)
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 42 ++++++++++++++++++++++++-
 include/drm/bridge/aux-bridge.h         |  6 ++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index a2e525aa5788..7aa630fcf735 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -13,6 +13,8 @@
 #include <drm/drm_bridge.h>
 #include <drm/bridge/aux-bridge.h>
 
+#define DRM_AUX_HPD_BRIDGE_NAME	"dp_hpd_bridge"
+
 static DEFINE_IDA(drm_aux_hpd_bridge_ida);
 
 struct drm_aux_hpd_bridge_data {
@@ -37,6 +39,44 @@ static void drm_aux_hpd_bridge_free_adev(void *_adev)
 	auxiliary_device_uninit(_adev);
 }
 
+static int hpd_bridge_match(struct device *dev, const void *data)
+{
+	const struct device_node *np = data;
+	struct auxiliary_device *adev;
+
+	if (!dev_is_auxiliary(dev))
+		return 0;
+
+	adev = to_auxiliary_dev(dev);
+	if (strcmp(adev->name, DRM_AUX_HPD_BRIDGE_NAME))
+		return 0;
+
+	return adev->dev.platform_data == np;
+}
+
+/**
+ * drm_dev_has_dp_hpd_bridge - check whether a HPD DisplayPort bridge is registered
+ * @parent: device instance providing this bridge
+ * @np: device node pointer corresponding to this bridge instance
+ *
+ * Walk the children of @parent and check whether a HPD DisplayPort bridge for
+ * the given @np has already been registered via devm_drm_dp_hpd_bridge_add().
+ *
+ * Return: true if a HPD bridge for @parent / @np already exists, false otherwise
+ */
+bool drm_dev_has_dp_hpd_bridge(struct device *parent, struct device_node *np)
+{
+	struct device *child;
+
+	child = device_find_child(parent, np, hpd_bridge_match);
+	if (child) {
+		put_device(child);
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(drm_dev_has_dp_hpd_bridge);
+
 /**
  * devm_drm_dp_hpd_bridge_alloc - allocate a HPD DisplayPort bridge
  * @parent: device instance providing this bridge
@@ -64,7 +104,7 @@ struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct device *parent, str
 	}
 
 	adev->id = ret;
-	adev->name = "dp_hpd_bridge";
+	adev->name = DRM_AUX_HPD_BRIDGE_NAME;
 	adev->dev.parent = parent;
 	adev->dev.release = drm_aux_hpd_bridge_release;
 	adev->dev.platform_data = of_node_get(np);
diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bridge.h
index c2f5a855512f..cca07a8e2d45 100644
--- a/include/drm/bridge/aux-bridge.h
+++ b/include/drm/bridge/aux-bridge.h
@@ -25,6 +25,7 @@ struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct device *parent, str
 int devm_drm_dp_hpd_bridge_add(struct device *dev, struct auxiliary_device *adev);
 struct device *drm_dp_hpd_bridge_register(struct device *parent,
 					  struct device_node *np);
+bool drm_dev_has_dp_hpd_bridge(struct device *parent, struct device_node *np);
 void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status);
 #else
 static inline struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct device *parent,
@@ -44,6 +45,11 @@ static inline struct device *drm_dp_hpd_bridge_register(struct device *parent,
 	return NULL;
 }
 
+static inline bool drm_dev_has_dp_hpd_bridge(struct device *parent, struct device_node *np)
+{
+	return false;
+}
+
 static inline void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status)
 {
 }
-- 
2.53.0

