Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EBA606A681
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9yUiRww
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52E411292F;
	Fri, 27 Nov 2026 09:54:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33E210E6BD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:53:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47AC662440;
 Fri, 27 Nov 2026 09:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4DE1F0089A;
 Fri, 27 Nov 2026 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773236;
 bh=rrApX75lnByiHbTtdPpa1WsPnkpnupIwz1oeZkvymG8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=T9yUiRwwOnXJhcY6C6+SMFs41xjCEJRegJ1W3FPC2iC0qYF/N/XTLxKGyhOGIGu3Z
 5lS4aAdd49Wp3qLbnUDqBExzI7g0bu61KNBJtg9B+zu0auDJ1cQF+8eTSseGj00Qry
 yKwjkb83rNSdUVi+UhKt2XHInS7MqFnWrI3665BXjy42knVX3y42ORiHxGeS+d2XQP
 uSBdVwfvrSn8W21bzleGTTCTLbho7Mk0Qoe6wixVxCZVw0J4iF0hD5aHifopi05PTc
 hgmgVaSXByJ6ABHbCo/ZNlb7tTc4g5DRK4+M3/jjJs0q/jVc6D5vOnl0m0mDP7DWbD
 ff4D5+yMNKTcA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:52:53 +0100
Subject: [PATCH v10 11/36] drm/mode-config: Read out hardware state in
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-11-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4402; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iS4H0KMcEylVFkbuEVjUhr9+icqXA76qQQiJmJZDVfc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwYxS9bXy3smdgm93FYdPMXvkdO7x8bfqOZt+tK86E
 uLgt3xBx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIn/mMDSe1pvs/F+nT6rW7
 7FKeeLb066UZCcd5D+z+frrb5/7juTsYuXcs+PjJoC3eesPHLeWzmxkbJn7RS594sXOPt2OxhrX
 ZlM54sSOsS5UeKueJWv42jBPfUMuZLxr3R2C77RWppmWTjp0HAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_create_initial_state() creates the initial state for
all KMS objects at driver registration time.

Call the drm_mode_config_funcs.atomic_sro_readout_state hook from it
so that the initial state is populated from the hardware rather than
being left as a pristine default. If the readout isn't supported or
fails, fall back to allocating pristine states, which moves to a
static drm_mode_config_create_state() helper.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c | 69 ++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index c1e993a78702..d6f92e1a54d2 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -29,10 +29,11 @@
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_modeset_lock.h>
 #include <drm/drm_print.h>
 #include <drm/drm_colorop.h>
 #include <linux/dma-resv.h>
 
 #include "drm_crtc_internal.h"
@@ -320,25 +321,11 @@ void drm_mode_config_reset(struct drm_device *dev)
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
@@ -406,10 +393,62 @@ int drm_mode_config_create_initial_state(struct drm_device *dev)
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
+ * The function holds all the modeset locks for the duration of the
+ * readout and the state creation, so drivers don't need to guarantee
+ * any kind of exclusivity themselves.
+ *
+ * Returns: 0 on success, negative error value on failure.
+ */
+int drm_mode_config_create_initial_state(struct drm_device *dev)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	int ret;
+
+	/*
+	 * The initial state is usually created while the device is
+	 * being initialized and nothing can access it concurrently,
+	 * but holding all the modeset locks puts the readout, the
+	 * installation of its result and the creation of the pristine
+	 * states under the same locking contract as the regular
+	 * atomic paths.
+	 */
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
+
+	if (dev->mode_config.funcs->atomic_sro_readout_state) {
+		ret = dev->mode_config.funcs->atomic_sro_readout_state(dev);
+		if (!ret)
+			goto out;
+	}
+
+	ret = drm_mode_config_create_state(dev);
+
+out:
+	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
+
+	return ret;
+}
 EXPORT_SYMBOL(drm_mode_config_create_initial_state);
 
 /*
  * Global properties
  */

-- 
2.56.1

