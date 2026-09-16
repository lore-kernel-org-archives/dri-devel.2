Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57933C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970E410E3D2;
	Wed, 16 Sep 2026 13:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vJhCH9as";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E09A10E844
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:46:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8DBE4C5CD60;
 Wed, 16 Sep 2026 13:47:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 94B6A60337;
 Wed, 16 Sep 2026 13:46:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2319A11C7B031; 
 Wed, 16 Sep 2026 15:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566384; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7JYe70QxeTzij/tSzgebCehRNZ/P8wl4nEuocul1G1A=;
 b=vJhCH9asXkMbC8mU6xmTlwqD3d1PepS3t3atiWwABctTcX4/6JCoCiilaYSJxmgap4i0Hi
 FXfV2kkY0Y/NGOdcwONJ8/Cs/n1L7aT5O8G7EGE9U6ZaiYr9SG8HdMfFZTC5w481G82zXL
 OHqg2kpZlol6boPgCn10aADQHClvGL1vonHyUHMfXx8pGKoK0oitXM8OItttDFNnT7giW2
 +sXku2Cop9KZtsP+psuns7ZeRK4Y6dF9LSFXHS69y+Izo/1zhX+/iOI9EP6bXNokxbkzxz
 RGF7ForS3BiW6EPqxC3dVApq4tlkmUaXRP15Y0CJm3U+h2Mqxi7Hvmng86DhTA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:30 +0200
Subject: [PATCH v3 06/19] drm/bridge: remove devm_drm_put_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-6-83afb4f1a707@bootlin.com>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

The deprecated devm_drm_put_bridge() function is not used anymore.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/gpu/todo.rst   | 16 ----------------
 drivers/gpu/drm/drm_bridge.c | 17 -----------------
 include/drm/drm_bridge.h     |  2 --
 3 files changed, 35 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index b7351467dc74..cb0ce432c114 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -484,22 +484,6 @@ Contact: Douglas Anderson <dianders@chromium.org>
 
 Level: Starter
 
-Remove devm_drm_put_bridge()
-----------------------------
-
-Due to how the panel bridge handles the drm_bridge object lifetime, special
-care must be taken to dispose of the drm_bridge object when the
-panel_bridge is removed. This is currently managed using
-devm_drm_put_bridge(), but that is an unsafe, temporary workaround. To fix
-that, the DRM panel lifetime needs to be reworked. After the rework is
-done, remove devm_drm_put_bridge() and the TODO in
-drm_panel_bridge_remove().
-
-Contact: Maxime Ripard <mripard@kernel.org>,
-         Luca Ceresoli <luca.ceresoli@bootlin.com>
-
-Level: Intermediate
-
 Convert users of of_drm_find_bridge() to of_drm_find_and_get_bridge()
 ---------------------------------------------------------------------
 
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 649f6b6ab5c8..632dccd79e91 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1737,23 +1737,6 @@ struct drm_bridge *of_drm_get_bridge_by_endpoint(const struct device_node *np,
 EXPORT_SYMBOL_GPL(of_drm_get_bridge_by_endpoint);
 #endif
 
-/**
- * devm_drm_put_bridge - Release a bridge reference obtained via devm
- * @dev: device that got the bridge via devm
- * @bridge: pointer to a struct drm_bridge obtained via devm
- *
- * Same as drm_bridge_put() for bridge pointers obtained via devm functions
- * such as devm_drm_bridge_alloc().
- *
- * This function is a temporary workaround and MUST NOT be used. Manual
- * handling of bridge lifetime is inherently unsafe.
- */
-void devm_drm_put_bridge(struct device *dev, struct drm_bridge *bridge)
-{
-	devm_release_action(dev, drm_bridge_put_void, bridge);
-}
-EXPORT_SYMBOL(devm_drm_put_bridge);
-
 static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
 					   struct drm_bridge *bridge,
 					   unsigned int idx,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 11c203391de5..9a688b20bc1e 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1473,8 +1473,6 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge);
 void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status);
 
-void devm_drm_put_bridge(struct device *dev, struct drm_bridge *bridge);
-
 void drm_bridge_debugfs_params(struct dentry *root);
 void drm_bridge_debugfs_encoder_params(struct dentry *root, struct drm_encoder *encoder);
 

-- 
2.55.0

