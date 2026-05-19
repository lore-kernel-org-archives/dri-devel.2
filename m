Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7988BCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B901F10EBBC;
	Tue, 19 May 2026 09:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IOig0wHt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AAA10EBD2;
 Tue, 19 May 2026 09:02:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 233326020F;
 Tue, 19 May 2026 09:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5073BC2BCB3;
 Tue, 19 May 2026 09:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779181372;
 bh=jxSIny2eDy5UApT+259+z4ah0co5cF9vQfWozPSJv4g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IOig0wHtQgljskr8D2A2ABitshcAzchAEQv+PNjkm6RmNhprEohxRSpD9e4jsCFqD
 zNRqHuTRhOwlHcowMw1UXHKXRCtfOJVMrur0pwJc++e+SVu6UG5sII0vIV87FKgQAj
 ijXmuCjTwKI25uSHYHOEGaQPrw/LkXqcvmfnKX/R0uRYMMM5jgtTkscw5ywLXL1zCk
 yTjDe/5A+rgqZl/5yiVaRUnYY+CjGIIsyyjQWFLtR/r6PByAlCoICMzENK4Aewsbug
 vAlfTm4Jin18KPSB1vdwXRWvXmmNyypa6avwIvjVLznef1GJQI4VsAEPow9Rfh5kYL
 8pyO0HgQmhz4Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 19 May 2026 11:01:58 +0200
Subject: [PATCH v5 16/19] drm/mode-config: Create
 drm_mode_config_create_initial_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-mode-config-init-v5-16-388b03321e38@kernel.org>
References: <20260519-drm-mode-config-init-v5-0-388b03321e38@kernel.org>
In-Reply-To: <20260519-drm-mode-config-init-v5-0-388b03321e38@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Simon Ser <contact@emersion.fr>, Harry Wentland <harry.wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Sebastian Wick <sebastian.wick@redhat.com>, 
 Alex Hung <alex.hung@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6204; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jxSIny2eDy5UApT+259+z4ah0co5cF9vQfWozPSJv4g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFk86gwSZy7+v6d6dt8lG+1JS95orwswdrizxOedwMUZu
 9aIxZtd7JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATWf2KsWFR4dn1+1kNIpbX
 6DZynlU6JjZ73Xytc4+Fz08PE9d55bVSzUeJO2iHhMTmviu3OJfOncnYcGvaom15KiyxZ0QdGKr
 7GLQzBN+xBwoHM8wVfxW7zKeVaTubHQMLp+mxduNzCyZfXpAPAA==
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

drm_mode_config_reset() can be used to create the initial state, but
also to return to the initial state, when doing a suspend/resume cycle
for example.

It also affects both the software and the hardware, and drivers can
choose to reset the hardware as well. Most will just create an empty
state and the synchronisation between hardware and software states will
effectively be done when the first commit is done.

That dual role can be harmful, since some objects do need to be
initialized but also need to be preserved across a suspend/resume cycle.
drm_private_obj are such objects for example.

Thus, create another helper for drivers to call to initialize their
state when the driver is loaded, so we can make
drm_mode_config_reset() only about handling suspend/resume and similar.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c      | 13 +++++-
 drivers/gpu/drm/drm_mode_config.c | 89 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_mode_config.h     |  1 +
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index d98586d89bbe..ea021250925c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -59,12 +59,21 @@
  * preparing the update and kept alive as long as they are active in the
  * device.
  *
  * Their respective lifetimes are:
  *
- * - at reset time, the object reset implementation will allocate a new
- *   default state and will store it in the object state pointer.
+ * - at driver initialization time, the driver will call
+ *   drm_mode_config_create_initial_state() to allocate an initial,
+ *   pristine, state for each object and will store it in the objects
+ *   state pointer. Historically, this was one of
+ *   drm_mode_config_reset() job, so one might still encounter it in a
+ *   driver.
+ *
+ * - at reset time, for example during suspend/resume,
+ *   drm_mode_config_reset() will reset the software and hardware state
+ *   to a known default and will store it in the object's state pointer.
+ *   Not all objects are affected by drm_mode_config_reset() though.
  *
  * - whenever a new update is needed:
  *
  *   + A new &struct drm_atomic_commit is allocated using
  *     drm_atomic_commit_alloc().
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 9d240817f8b6..f432f485a914 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -21,10 +21,11 @@
  */
 
 #include <linux/export.h>
 #include <linux/uaccess.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_managed.h>
@@ -314,10 +315,98 @@ void drm_mode_config_reset(struct drm_device *dev)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
 EXPORT_SYMBOL(drm_mode_config_reset);
 
+/**
+ * drm_mode_config_create_initial_state - Allocates the initial state
+ * @dev: drm device
+ *
+ * This functions creates the initial state for all the objects. Drivers
+ * can use this in e.g. probe to initialize their software state.
+ *
+ * It has two main differences with drm_mode_config_reset(): the reset()
+ * hooks aren't called and thus the hardware will be left untouched, but
+ * also the &drm_private_obj structures will be initialized as opposed
+ * to drm_mode_config_reset() that skips them.
+ *
+ * Returns: 0 on success, negative error value on failure.
+ */
+int drm_mode_config_create_initial_state(struct drm_device *dev)
+{
+	struct drm_crtc *crtc;
+	struct drm_colorop *colorop;
+	struct drm_plane *plane;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	struct drm_private_obj *privobj;
+	int ret;
+
+	drm_for_each_privobj(privobj, dev) {
+		struct drm_private_state *privobj_state;
+
+		if (privobj->state)
+			continue;
+
+		if (!privobj->funcs->atomic_create_state)
+			continue;
+
+		privobj_state = privobj->funcs->atomic_create_state(privobj);
+		if (IS_ERR(privobj_state))
+			return PTR_ERR(privobj_state);
+
+		privobj->state = privobj_state;
+	}
+
+	drm_for_each_colorop(colorop, dev) {
+		struct drm_colorop_state *colorop_state;
+
+		if (colorop->state)
+			continue;
+
+		colorop_state = drm_atomic_helper_colorop_create_state(colorop);
+		if (IS_ERR(colorop_state))
+			return PTR_ERR(colorop_state);
+
+		colorop->state = colorop_state;
+	}
+
+	drm_for_each_plane(plane, dev) {
+		if (plane->state)
+			continue;
+
+		ret = drm_mode_config_plane_create_state(plane);
+		if (ret)
+			return ret;
+	}
+
+	drm_for_each_crtc(crtc, dev) {
+		if (crtc->state)
+			continue;
+
+		ret = drm_mode_config_crtc_create_state(crtc);
+		if (ret)
+			return ret;
+	}
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (connector->state)
+			continue;
+
+		ret = drm_mode_config_connector_create_state(connector);
+		if (ret) {
+			drm_connector_list_iter_end(&conn_iter);
+			return ret;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_mode_config_create_initial_state);
+
 /*
  * Global properties
  */
 static const struct drm_prop_enum_list drm_plane_type_enum_list[] = {
 	{ DRM_PLANE_TYPE_OVERLAY, "Overlay" },
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index e584652ddf67..d8f5b7e9673e 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -1005,9 +1005,10 @@ int __must_check drmm_mode_config_init(struct drm_device *dev);
 static inline int drm_mode_config_init(struct drm_device *dev)
 {
 	return drmm_mode_config_init(dev);
 }
 
+int drm_mode_config_create_initial_state(struct drm_device *dev);
 void drm_mode_config_reset(struct drm_device *dev);
 void drm_mode_config_cleanup(struct drm_device *dev);
 
 #endif

-- 
2.54.0

