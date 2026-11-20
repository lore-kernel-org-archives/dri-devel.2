Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BF606A339
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOAgp+en
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64A11129EE;
	Fri, 20 Nov 2026 12:56:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88051129E6
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 382E26264F;
 Fri, 20 Nov 2026 12:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC751F000C4;
 Fri, 20 Nov 2026 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179381;
 bh=rrApX75lnByiHbTtdPpa1WsPnkpnupIwz1oeZkvymG8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lOAgp+enY0XrbqEqGqHB9dku1M7o7Xq5OuryDkGrr3GTdnWb7r2zdOLfQCrMYYtkV
 aGP8WSbpxtOmRu8GtPApEj/12w+y5rxUz0wXmiXu408buvCPXSbzR15phN4CeglzEN
 y1HzXc35uvHG0psijMLX/B5oIlMfjp0HCFcTf4voXC2AiftdffnB8foPIWwbQ8qmir
 ZS0Cm1gBoFmvpRYQAZsxvSpDGX+wKcOXieuq/uQNQBi4yhIAYIwS3wa9WBnvUWhv8x
 S3HMGUaVQlIBt7jAU2HGf7WlHmAYMFfnmZmon1EFWYRU2ih2CLVrEgnz4/w6TT64Ud
 Tx1480YceTztQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:10 +0100
Subject: [PATCH v9 18/42] drm/mode-config: Read out hardware state in
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-18-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzlrvrOI8pX7YhDCks/uX39dJ9C5Qm33/QatKXufl0
 uKfPGs7prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwET8HzA2TIjcLFjjff6e2RHt
 DxVfH/SZJO6ZtH2+6X3zzMkKB+8mbZDLPWNaeHiqXc7z0ir9jMMZjA3votdGMIpOWx5udOapos6
 hsELjo3WKPjb7GHSNb714YH/1ffPSu5Fs7fbPH0tPYPGQ+gAA
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

