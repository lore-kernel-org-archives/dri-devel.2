Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83FAC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADB710E69A;
	Mon,  7 Sep 2026 13:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NrzspH1/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE69210E803
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52A8660AB5;
 Mon,  7 Sep 2026 13:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740701F00A3A;
 Mon,  7 Sep 2026 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787498;
 bh=LJma4IwsPxu3sKurlgdPymVOCP2nPXjTwwJJdQLv4OQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NrzspH1/3lmkzfLWjyXNK4WWmNrBe3M8iLed42SkPgrKzYPti5Mjndk6iyJB3PL+G
 40hsguRcv99u3My5qth9EaDjq64pW8rSRoafLAdMBMxDoGN+XDcXM7BKPbWXIsZQTJ
 UNNUI+KZnjtZM+X/UYUX+pWvQueSaYePfMNnkEh4ykc/8sNaAvV5pXeGFpOZcFBM1b
 Rgs336mEqTGDrc61FBd/Y2aIIqokvHtTxygbyCWjHVilwWuGSO7o2v4BYTkxzz0Fx6
 gy9LboAvncA48V2VPIMmWeny5RtnQNCKeEiUbHqgqj+IXCAj15c39mJx2d63n6w0NG
 WpL0ShFOLZENw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:51 +0200
Subject: [PATCH v5 15/33] drm/mode-config: Read out hardware state in
 drm_mode_config_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-15-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Zb7qG/QDqT2ZuXITumhRjdYTXUgGlOlxqnaOJdfhY5g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj2pjbf5+rLhNrPjswvFnvwBRzWOertd4brltnlnz
 cGgJUu0OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEBOQY631+VpaZ7u9QrXh9
 T0JWwOzt04hZG+dtEfqw4Hx0aKSozhbZ0yYMGy59UT8uczJT93T4RcaGO6zGPAbZqw6+epLibHM
 s48X+W8amcpH8p198bN/VV7LypYZB+LzOxTfkI+u6Hm23Pn8cAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_mode_config_create_state() creates the initial state for all
KMS objects at driver registration time.

Call the drm_mode_config_funcs.atomic_sro_readout_state hook from it
so that the initial state is populated from the hardware rather than
being left as a pristine default.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c | 49 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index c7c8e38b192d..deb0590b01e2 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -22,10 +22,11 @@
 
 #include <linux/export.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_sro.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_managed.h>
@@ -324,25 +325,11 @@ void drm_mode_config_reset(struct drm_device *dev)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
 EXPORT_SYMBOL(drm_mode_config_reset);
 
-/**
- * drm_mode_config_create_initial_state - Allocates the initial state
- * @dev: drm device
- *
- * This functions creates the initial state for all the objects. Drivers
- * can use this in e.g. probe to initialize their software state.
- *
- * It has two main differences with drm_mode_config_reset(): the reset()
- * hooks aren't called and thus the hardware will be left untouched, but
- * also the &drm_private_obj structures will be initialized as opposed
- * to drm_mode_config_reset() that skips them.
- *
- * Returns: 0 on success, negative error value on failure.
- */
-int drm_mode_config_create_initial_state(struct drm_device *dev)
+static int drm_mode_config_create_state(struct drm_device *dev)
 {
 	struct drm_crtc *crtc;
 	struct drm_colorop *colorop;
 	struct drm_plane *plane;
 	struct drm_connector *connector;
@@ -410,10 +397,42 @@ int drm_mode_config_create_initial_state(struct drm_device *dev)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
 	return 0;
 }
+
+/**
+ * drm_mode_config_create_initial_state - Allocates the initial state
+ * @dev: drm device
+ *
+ * This functions creates the initial state for all the objects. Drivers
+ * can use this in e.g. probe to initialize their state.
+ *
+ * It creates the initial state in several steps. It first tries to
+ * read-out the initial state from the hardware for all objects if state
+ * read-out is enabled and the driver supports it. Then, if state
+ * read-out isn't supported or fails, it creates a new, pristine state
+ * using the objects atomic_create_state callback.
+ *
+ * For historical reasons, drm_mode_config_reset() is similar, but
+ * doesn't support state read-out, and will always reset the hardware.
+ * It will also ignore all &drm_private_obj.
+ *
+ * Returns: 0 on success, negative error value on failure.
+ */
+int drm_mode_config_create_initial_state(struct drm_device *dev)
+{
+	int ret;
+
+	if (dev->mode_config.funcs->atomic_sro_readout_state) {
+		ret = dev->mode_config.funcs->atomic_sro_readout_state(dev);
+		if (!ret)
+			return 0;
+	}
+
+	return drm_mode_config_create_state(dev);
+}
 EXPORT_SYMBOL(drm_mode_config_create_initial_state);
 
 /*
  * Global properties
  */

-- 
2.55.0

