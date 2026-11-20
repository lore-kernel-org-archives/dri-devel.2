Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936C606A331
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDqvnf1M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810251129CD;
	Fri, 20 Nov 2026 12:55:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A9A1129CD
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1A4C407D5;
 Fri, 20 Nov 2026 12:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9361F000C6;
 Fri, 20 Nov 2026 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179326;
 bh=0BEGe9h7paMFFmw33NFpECwW8ZfOkXXNnYXTV0wb7eU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jDqvnf1MFNLFWa5IpkHSIrmQn3PhfeL2GcZcJ4rXidBu57Dt5RpPNb26+U3GL4l1p
 csgFJlLmogq9/vyCCee379WS4uLKbu6vv/qEzUJ3UdFxKJelV+qLgdyDIUXK0VrMwq
 Uhcftw5wm7Lc+2itc28Dj1gWo3jxkx62Idvg8ScAjB3oI9atUmpowhrc5tfq9jWzFH
 bACcPvagQc1XftUkRCp0uYIxVtDAURYfbCdDSvBDVSW8NejVBSNzToNPmm6RznsRfb
 NIJfkJjzOjx/FNqk8iswu8nT+CFFdEfbMA0RV/odxZzzZ19cI6I8vYoMReXDlJkPDV
 4IyyOoIZw1dZA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:54:54 +0100
Subject: [PATCH v9 02/42] drm/bridge-helper: Don't unlock the connection
 mutex after a backoff
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-2-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3288; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2CFKl2cK65Sl9KdWawlTiT5m5YLDclXj/00daCNyj28=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzso28Wd/vgi+KOtwN6BrU4Rq66dfOk+k8zL658o0l
 0/91m/UMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbyvY6xofvP9DnN6nsLVE+e
 XZn7dZZDerV1csxdz01yjIxVxpqqbzk05i2vk1xgKr73cdakAsZ2xoY7Ts0qa4IXdq+/PP2Kbu6
 vt6l7f0+4ERT7n0O2SFEmbnpX4yMe9pZLc29sN3XvVSr2nAgA
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

However, drm_atomic_get_connector_for_encoder() takes the connection
mutex itself and unlocks it on its way out. The connection mutex taken
by drm_bridge_helper_reset_crtc() was thus already released when the
function unlocked it again on its exit path, and the connector state
was looked at without holding it.

The callers already have to release the context locks through
drm_modeset_drop_locks() and to handle the -EDEADLK error, so we can
leave the connection mutex release to them. Look the connector up with
drm_atomic_get_connector_for_encoder_locked() instead, so that the
connection mutex stays held from the lookup until the CRTC reset, and
make sure the connector is bound to a CRTC before resetting it.

Fixes: 56ae62124177 ("drm/bridge: Add helper to reset bridge pipeline")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge_helper.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_bridge_helper.c
index 0a3c8fee66b3..53c051cb2d65 100644
--- a/drivers/gpu/drm/drm_bridge_helper.c
+++ b/drivers/gpu/drm/drm_bridge_helper.c
@@ -17,10 +17,14 @@
  * between the CRTC and connector that bridge is connected to.
  *
  * As it relies on drm_atomic_helper_reset_crtc(), the same limitations
  * apply.
  *
+ * All the locks taken by this function use @ctx: the caller is
+ * responsible for releasing them with drm_modeset_drop_locks(), and
+ * for handling an -EDEADLK error with drm_modeset_backoff().
+ *
  * Returns:
  *
  * 0 on success or a negative error code on failure. If the error
  * returned is EDEADLK, the whole atomic sequence must be restarted.
  */
@@ -31,28 +35,27 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *bridge,
 	struct drm_encoder *encoder = bridge->encoder;
 	struct drm_device *dev = encoder->dev;
 	struct drm_crtc *crtc;
 	int ret;
 
+	/*
+	 * Hold the connection mutex across the connector lookup and
+	 * the accesses to its state, so that a concurrent commit can't
+	 * re-route the connector in between. Every lock taken with @ctx
+	 * is released by the caller through drm_modeset_drop_locks(),
+	 * so we must not unlock it ourselves.
+	 */
 	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
 	if (ret)
 		return ret;
 
-	connector = drm_atomic_get_connector_for_encoder(encoder, ctx);
-	if (IS_ERR(connector)) {
-		ret = PTR_ERR(connector);
-		goto out;
-	}
-
-	if (!connector->state) {
-		ret = -EINVAL;
-		goto out;
-	}
+	connector = drm_atomic_get_connector_for_encoder_locked(encoder);
+	if (IS_ERR(connector))
+		return PTR_ERR(connector);
 
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
2.56.1

