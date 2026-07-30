Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B595DC54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B31410E53E;
	Thu, 30 Jul 2026 01:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="tWVlWFY6";
	dkim-atps=neutral
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB0D10E53E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1785375262;
 bh=34S38J64YM+H+KpfDbN51lI/VLTj/+Nb2w4k8BEGW5Q=;
 h=From:To:Subject:Date:Message-Id;
 b=tWVlWFY6s0ey5XkgvY4zMcsuNGstZc26AxEGX4/VEY2K65S1IMHb6UU0T2bFU8+ZD
 IMaBCfzakqHhyKEZs9jveo8/YSOtM6wo7UM5yTDDZ5S/AhCh443eQ3IRxPFx6HI7PG
 IAbsx3FkIAY5DALXbzR3gLbojzRgr2YJYCzUB2dE=
X-QQ-mid: esmtpgz16t1785375260tc42de64d
X-QQ-Originating-IP: h2Thze7d4q0oJMo7Urb9mZmDujzRNU31S/lY1AZVkmM=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 30 Jul 2026 09:34:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6195067875191386015
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
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Subject: [PATCH v5 3/6] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
Date: Thu, 30 Jul 2026 09:33:46 +0800
Message-Id: <20260730013349.51-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260730013349.51-1-kernel@airkyi.com>
References: <20260730013349.51-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OZ6Go/7Bj7284kWu0sLCEcTHrj19c5IVbygt/k8x2dtTUP4S9Mkb8ES7
 sXy7ddyTtEx+DD2eFShH2wQcjbfgrqysNTqltqycvNZpyLS3ojIv8ZdXygja8Wtv/LgmW7K
 O7NFhvQLhWaYV7lM48sXnO8tWMzw6bw6JkxADnuYlMrb9/DXqFTqppTPdw/1UWzYoLaZBTz
 MmTer2Y1S15gOqJ9a1HecltyqQPuBHRm+7NK9jxa46D1nfq2R31e3V/6A6zKLtRuEl4Gsf/
 buZ5iecrNy2ZhW8xgVZxBi9W0HorwZKzeKEV/kZKA/Mx1N3HWCAgW3BL+W1tJ2z4oKU5tjo
 1Rsafi8CC6Pvng+QeYiOEiOEnDEm4Scz0WMu2BKY0JNSRG9JB7MbQP+7U9NqjC6vQi2q6Bs
 ZB++r+fQ2/ofLcSn8KH8jTBNCbwwYQpSwgby3OPz0ro9HV7ahojwTZSRZ3rGXfmW8jZHf/2
 Z4Gm1al/5W6/mNCW1jVPWnilCI5sPU+ijlRbo1d1lnueA6JYt0s5ypffd/EyX9Ewrj8a5f5
 HxDsoONFGLwrIhKhLGdwhFgQjAj28uU0/0G5SDwqtvrTSTYZTEZJNoi5zhbullVKhrmf+e0
 13hA8gvaYb0NVZgK1WCOO/MEcjbx2iTcnM/TkfIXU2KnUES4e9SLRh+ygzavqcv0hcxCOEM
 VhNgClFZ/K64UVaKlA0mDK5kYATRhf1MezZiDOK18dh36O2ub/si1T1RBa/l3EE8h05d9Au
 I8aedEyRmhU28Ei1gFhifVjIz2IjXo0PNd4+Qvkfh6Qj24eqZK7ZWVqy5z6myMIWzU+eZay
 ltv5RvYkoMvp9aCemxJkgdbdZ5HLV4pukmEfRn3oKK0TzaFHkjvXwGaQZMInVI801NNKBjS
 1f77xGUx8fe8mrCplhqNHcV35vU0vUPTck6fvl73hsdkCTFnfB7O+H6eU7gQkvsQ83jEs5d
 qE8SeAT8fjv+bX1EfY81yaP+C4JE2MzAuCI8qfYFaEtohc03JrutUj/dG0RDTmji82B9gQg
 hT9ntAPA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

(no changes since v3)

Changes in v2:
- Fix incorrect function names in the documentation comments.
---
 drivers/gpu/drm/bridge/aux-bridge.c | 26 +++++++++++++++++++++++---
 include/drm/bridge/aux-bridge.h     |  6 ++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
index 1ed21a8713bf..06a1466f49bd 100644
--- a/drivers/gpu/drm/bridge/aux-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-bridge.c
@@ -33,8 +33,9 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
 }
 
 /**
- * drm_aux_bridge_register - Create a simple bridge device to link the chain
+ * drm_aux_bridge_register_from_node - Create a simple bridge device to link the chain
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

