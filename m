Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1B606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcEHViPt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4622F10E269;
	Fri,  6 Nov 2026 13:14:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C72010E269
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:14:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4401605DE;
 Fri,  6 Nov 2026 13:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113451F0089F;
 Fri,  6 Nov 2026 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970889;
 bh=nZxgkaB9+YG+f+i6W5cuPmQ20FtlVJguzPTMUSREef0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VcEHViPtNXYrHsyvmmlkabXe48Dwsg3qSM54XA8ZEM3OxROI7ZuOm2FgbH8OIPUrK
 uDXhijbX8208GaoCZ78wz6djhSklG1RlfYoDXRhdUh79Q8de9aUZlwSN7ouXH7IJ6U
 R5oSylViSBYR9nRZlqO8+REywLtX4DXkbhvgiF1cvvo/q/g/r0euYy6kf5v9Zy6Urx
 31eTeppjlrDNisRQQt2x1myQw5HeqmVvea9ugO0k4aQBrrK+3+I+O5MPdx1rDb6ufQ
 m7/rdPC+sgbo/TWxExD6+ioUvM14vgXAdqs39ZDGhQIhE9rWVvsItP0V4pVdh08OCp
 006YKrJCatfFw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:15 +0100
Subject: [PATCH v8 02/39] drm/bridge-helper: Don't unlock the connection
 mutex after a backoff
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-2-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3387; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hC0/YU49tRta7LKNbt/pLe/b3ghPgjNBNcZhCxj8faI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL631mTDnhNTO/ZPtbz4xq33tIfDSfPnHnjtpAZO8F
 kxOrXw7p2MqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBM5CcXY52mx/mI1UXc/3QF
 d/z8VK0kdDqwM3zdIYFdgV89LLemejFOmtF7bWE8w8+M+tqNNrscDzM2dOYcjD0sM0n75KJz24J
 3Bv1ZfNSz3cin4K5dusO0kxbrrr/PrZXtq9vcvPLm9r2zTQwdAA==
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

drm_bridge_helper_reset_crtc() takes the connection mutex using the
acquire context provided by the caller, and then relies on
drm_atomic_get_connector_for_encoder() and
drm_atomic_helper_reset_crtc() that both use the same context.

If either of those functions detects a deadlock, it backs off and drops
every lock held by the context, including the connection mutex taken by
drm_bridge_helper_reset_crtc() itself. The function however still
unlocked the connection mutex unconditionally on its way out, unlocking
a mutex it wasn't holding anymore.

The callers already have to release the context locks through
drm_modeset_drop_locks() and to handle the -EDEADLK error, so we can
leave the connection mutex release to them. We still need to take it
back after drm_atomic_get_connector_for_encoder() returns, since it may
have backed off, before looking at the connector state.

Fixes: 56ae62124177 ("drm/bridge: Add helper to reset bridge pipeline")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge_helper.c | 47 +++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_bridge_helper.c
index 0a3c8fee66b3..2efa4e1bc4b7 100644
--- a/drivers/gpu/drm/drm_bridge_helper.c
+++ b/drivers/gpu/drm/drm_bridge_helper.c
@@ -20,4 +20,8 @@
  * apply.
  *
+ * All the locks taken by this function use @ctx: the caller is
+ * responsible for releasing them with drm_modeset_drop_locks(), and
+ * for handling an -EDEADLK error with drm_modeset_backoff().
+ *
  * Returns:
  *
@@ -34,4 +38,9 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *bridge,
 	int ret;
 
+	/*
+	 * Every lock taken with @ctx is released either by a backoff or
+	 * by the caller through drm_modeset_drop_locks(), so we must not
+	 * unlock the connection mutex ourselves.
+	 */
 	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
 	if (ret)
@@ -39,20 +48,34 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *bridge,
 
 	connector = drm_atomic_get_connector_for_encoder(encoder, ctx);
-	if (IS_ERR(connector)) {
-		ret = PTR_ERR(connector);
-		goto out;
-	}
+	if (IS_ERR(connector))
+		return PTR_ERR(connector);
 
-	if (!connector->state) {
-		ret = -EINVAL;
-		goto out;
-	}
+	/*
+	 * drm_atomic_get_connector_for_encoder() drops the connection
+	 * mutex on its way out, whether or not it was held through @ctx,
+	 * so we need to take it back before looking at the connector
+	 * state.
+	 */
+	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
+	if (ret)
+		return ret;
+
+	if (!connector->state)
+		return -EINVAL;
+
+	/*
+	 * A concurrent atomic commit may have run while the connection
+	 * mutex was released above, and re-routed the connector to
+	 * another encoder or CRTC. Make sure the connector is still
+	 * tied to our encoder before resetting anything.
+	 */
+	if (connector->state->best_encoder != encoder)
+		return -EINVAL;
 
 	crtc = connector->state->crtc;
-	ret = drm_atomic_helper_reset_crtc(crtc, ctx);
+	if (!crtc)
+		return -EINVAL;
 
-out:
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-	return ret;
+	return drm_atomic_helper_reset_crtc(crtc, ctx);
 }
 EXPORT_SYMBOL(drm_bridge_helper_reset_crtc);

-- 
2.55.0

