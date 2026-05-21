Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EA6CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 03:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0665C10E469;
	Thu, 21 May 2026 03:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="IOOmMb71";
	dkim-atps=neutral
X-Greylist: delayed 300 seconds by postgrey-1.36 at gabe;
 Thu, 21 May 2026 03:34:51 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8797810E469
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 03:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1779334485;
 bh=NA3zWcCN+LNcIiy4LfRk+qi3M7FDJHrSG6hmfEKlJsw=;
 h=From:To:Subject:Date:Message-Id;
 b=IOOmMb71xzqhVt9WnD+cw3qYsyCguWKp3sr+v7FVsWchKYywbrrJBnQUQ8E38Sxu+
 voJhYqTvUnoZ7fMz1zakPxbqCWQU/JsxoZFKqPQB2Rr064gxwK3B5LeA+mj3h/6DtL
 nFyq6qpUByVvFWAAIY5w3/QYCr3MMNN12KFjd8mY=
X-QQ-mid: zesmtpsz7t1779334164ta5a04dd0
X-QQ-Originating-IP: hBQ95K8MTql32AYs7HMJrJ6z3IXUmXk+VXXcCPVKIvY=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 21 May 2026 11:29:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3257350597745359929
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 2/5] drm/bridge: aux: Add drm_aux_bridge_register_from_node()
Date: Thu, 21 May 2026 11:28:51 +0800
Message-Id: <20260521032854.103-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260521032854.103-1-kernel@airkyi.com>
References: <20260521032854.103-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MWLCkAjnYYm5R4umknh2+DmXnTKDHhodEy+51hjzScvfmmCC216y0kaG
 EE2ZYF/nPZqSuImhA22AfixjEyxVe5zRpxKEA9sCVbb744p9PPD+C5X94mZV60UuOjo7BUh
 A8zXJHf1/Etbzxk5lg1N4v+V4gEMtZEbEoYk5SWfu1Km/y4RHkdgeGn2k+vXW08VwAaB2HO
 q7Iai/wXpQUPgA/OOFQhd65OGRjEp7MyIjoSOiZFyVpLbxBv8BBSSwpPQcpUkke6x2WMd+H
 ybAVlf2ibCp6SE53LDUf5Rne07QfnFapjE4ayaSGnIL5TCAjvuwHjbw06arah2aMoqdgxEi
 BWdulVYyTqn6hxGG/PdVnLsA00vHw2hNoqjQzNI9Ss7ZpOEvfzuzMOS5ptXqEw+iZpPdvW3
 KiXKSBKg7Gnuw7fG/4EdPWHExc5kJErDUsIYhPqzHL2vsXMKobqPLKKSER8Wze95kfZIu7u
 eHUveRZsknv0UdcZfKnrouxnmMyNvpOb4RNvj5b+KsB0hkmnWqRXIWejF807RPFTQI6Yyrr
 HxnYJVHlE601yYsxB500hZULRg880v/RrdlZucSOVWzSHfsUvV1/Ms0u/GNkmgzXf8byPfS
 g5vYNlJWuaARQtphl8U92MzPffDW70OAb7xH6CLW/aTrVHZ6DIviwV8Zj+N3e7jgSRjIuRp
 /7vT4Pi1Ko0SB+ITZohOLkM99AHPEDBrGuomqvIjVSV3h1bFCYNPJ9B0/f5iAMXag4nhM8L
 YCL9eJL7ki9LxhhcJY8gB3RcWkDZ1Sr3fmeJwOHKazEaqpWQdGHW/t/NQBjumBchdRNFyZg
 o1adqeoDVQOi9W7Hp3YVfjiuUt1vurwYCTYff7+ZG1d1R1nFoQp+1IBI2hoHQH+kpXKjq9v
 /Eg0fwSjBu206a3mPp+hIvWy4Qcc7RAwrGvMiOiNCgfC//AB4WiIvxinCV8K6eYEbjZZjjn
 KBuje7fnxnRs7zs4h8tddJ8n4YPfMLaXCFM5RxFqKof9tBkiSssRtILnBWFLZfPzskCye4q
 ZwLkI8w7udS4a0uHt2U6KBcm6znNs=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The drm_aux_bridge_register() uses the device->of_node as the
bridge->of_node.

This patch adds drm_aux_bridge_register_from_node() to allow
specifying the of_node corresponding to the bridge.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/bridge/aux-bridge.c | 24 ++++++++++++++++++++++--
 include/drm/bridge/aux-bridge.h     |  6 ++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
index 1ed21a8713bf..f50283abed5f 100644
--- a/drivers/gpu/drm/bridge/aux-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-bridge.c
@@ -35,6 +35,7 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
 /**
  * drm_aux_bridge_register - Create a simple bridge device to link the chain
  * @parent: device instance providing this bridge
+ * @np: device node pointer corresponding to this bridge instance
  *
  * Creates a simple DRM bridge that doesn't implement any drm_bridge
  * operations. Such bridges merely fill a place in the bridge chain linking
@@ -42,7 +43,7 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
  *
  * Return: zero on success, negative error code on failure
  */
-int drm_aux_bridge_register(struct device *parent)
+int drm_aux_bridge_register_from_node(struct device *parent, struct device_node *np)
 {
 	struct auxiliary_device *adev;
 	int ret;
@@ -62,7 +63,10 @@ int drm_aux_bridge_register(struct device *parent)
 	adev->dev.parent = parent;
 	adev->dev.release = drm_aux_bridge_release;
 
-	device_set_of_node_from_dev(&adev->dev, parent);
+	if (np)
+		device_set_node(&adev->dev, of_fwnode_handle(np));
+	else
+		device_set_of_node_from_dev(&adev->dev, parent);
 
 	ret = auxiliary_device_init(adev);
 	if (ret) {
@@ -80,6 +84,22 @@ int drm_aux_bridge_register(struct device *parent)
 
 	return devm_add_action_or_reset(parent, drm_aux_bridge_unregister_adev, adev);
 }
+EXPORT_SYMBOL_GPL(drm_aux_bridge_register_from_node);
+
+/**
+ * drm_aux_bridge_register - Create a simple bridge device to link the chain
+ * @parent: device instance providing this bridge
+ *
+ * Creates a simple DRM bridge that doesn't implement any drm_bridge
+ * operations. Such bridges merely fill a place in the bridge chain linking
+ * surrounding DRM bridges.
+ *
+ * Return: zero on success, negative error code on failure
+ */
+int drm_aux_bridge_register(struct device *parent)
+{
+	return drm_aux_bridge_register_from_node(parent, NULL);
+}
 EXPORT_SYMBOL_GPL(drm_aux_bridge_register);
 
 struct drm_aux_bridge_data {
diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bridge.h
index c2f5a855512f..7dd1f17a1354 100644
--- a/include/drm/bridge/aux-bridge.h
+++ b/include/drm/bridge/aux-bridge.h
@@ -13,11 +13,17 @@ struct auxiliary_device;
 
 #if IS_ENABLED(CONFIG_DRM_AUX_BRIDGE)
 int drm_aux_bridge_register(struct device *parent);
+int drm_aux_bridge_register_from_node(struct device *parent, struct device_node *np);
 #else
 static inline int drm_aux_bridge_register(struct device *parent)
 {
 	return 0;
 }
+
+static inline int drm_aux_bridge_register_from_node(struct device *parent, struct device_node *np)
+{
+	return 0;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_DRM_AUX_HPD_BRIDGE)
-- 
2.53.0

