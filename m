Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0E606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKcGqqBB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF4C112240;
	Fri,  6 Nov 2026 13:17:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E5F10EA20
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FA8B601E3;
 Fri,  6 Nov 2026 13:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9AF1F0089F;
 Fri,  6 Nov 2026 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970951;
 bh=O8nG501tz6nOL1D7+S0vDlAsbTxdcVxWvUpHXkejRDM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aKcGqqBBwEt6BnNRHp3JD/mrcw2D+Aw0pFI0rCUUoJVBVqBKV6zVPzjNzP9rZKWwN
 ZiLsFKQCITnXhQSgXFflgv6Be6hJgx2NPUM3xaI7O2R75FG7jHpIXQ+A1nKLCJiPjD
 rIwZwYLdFVVupdJTQH6eCwhrjeIp4yXZ/vxBp+kvuAI6TXb2kr3ePUQLNi1sEn+nYE
 CE2rJ6sN0THrsNEL4AaCKmwdGuNInhoNuTOgRJoaJCGp3G47+f6RXQQay6ZKXhvjZj
 tWh+XeusgBvV6xSfJlFkIAqYMcx9V1jCrm0BMtvutNCVuX80KbqO7RWadI2lsjFqdA
 44dGZZ5kcn8hQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:32 +0100
Subject: [PATCH v8 19/39] drm/mode-config: Read out hardware state in
 drm_mode_config_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-19-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4002; i=mripard@kernel.org;
 h=from:subject:message-id; bh=a/pJLqYsmzkI7USeSITPPy3+eBPK2Rmob7H1eHf7s/g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL231dA6dvs1i+USJJrNrUjsmKFw/fPQn48yip1sLS
 px+dFkadkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJqK1jrDOvZvl+jyUn3WvG
 I7M5GZWX1rvtdnGxu2Zkfi3mR5rk7MUSnzvnLrT4evcF1/POxYYtgoy14jqr14X++ndSKpazbJt
 P19cdPwrXOGazHcn+tq06/6R25F5p1fUPxFiyGPOPWW+sv+wBAA==
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

drm_mode_config_create_state() creates the initial state for all
KMS objects at driver registration time.

Call the drm_mode_config_funcs.atomic_sro_readout_state hook from it
so that the initial state is populated from the hardware rather than
being left as a pristine default.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c | 70 ++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index c1e993a78702..9f242e2654c8 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -25,4 +25,5 @@
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_state_readout.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
@@ -32,4 +33,5 @@
 #include <drm/drm_mode_config.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_modeset_lock.h>
 #include <drm/drm_print.h>
 #include <drm/drm_colorop.h>
@@ -323,19 +325,5 @@ void drm_mode_config_reset(struct drm_device *dev)
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
@@ -409,4 +397,56 @@ int drm_mode_config_create_initial_state(struct drm_device *dev)
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
 

-- 
2.55.0

