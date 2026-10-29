Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35B4606A334
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kY5OvH6S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F2210FFCF;
	Thu, 29 Oct 2026 07:34:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB5B110FFD0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:34:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 909D441823;
 Thu, 29 Oct 2026 07:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF7D1F01825;
 Thu, 29 Oct 2026 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259267;
 bh=mhx3WJpMWE5zGWjK+95eg0scHdbDa7CUv35JfSGDykw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kY5OvH6S6oycNLyTAoi3Mav909P7E/KvvbCpI7b7WInUVvPGdM5MQPq/6laiNJYhj
 PUNtnL+0d31POPGe/TlmNGXacyAsX80nrILiklkpq39XuYGE7HEs1GnmnICYnqBWJt
 /DsbKIN6m2Ui59et6wuMR2dp/Dy5POS+HdzhbSB+SDSJ95gR2cojs+u35ScEjioVb2
 xwjMJTg1JwfzVRx/io4X+49cjWGM5G5fVMJ20gpTFQthyqOf3CvNG1o437xNKFYA39
 z+1V3UTIP6rOUHwRGouEuTlSVMjLFAbk+/uOAoqmRu3sFZJn0+bKiEoMk8yxpIC2S/
 Wjz9s7ZvuKRrA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:33:51 +0100
Subject: [PATCH v7 01/34] drm/bridge-helper: Don't unlock the connection
 mutex after a backoff
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-1-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; i=mripard@kernel.org;
 h=from:subject:message-id; bh=20iJEHq+ZPkDdytuQKmTM/vU1ZvaIvKAZCNhPBwfs8I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvr1dWt6ZMSnVpTJqzvEl25I/qBltO5iyeHdUT7rvh
 dXNtz8e75jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT2XedsYZ74zaGPdudJpYn
 ce0v+bKL6+eN73xtk1xW62S+UV4/aafVimM7p+yf3Hsn4gQbQ1/oj1bGepfuZ11LbvYrS7DLmz9
 JLpgdyS3/yV7Kcuvpu289Ul3DBFWaCnI9Jbs/bj572Sn7mT4bAA==
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
 drivers/gpu/drm/drm_bridge_helper.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_bridge_helper.c
index 0a3c8fee66b3..6998e7c41d30 100644
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
@@ -39,20 +48,22 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *bridge,
 
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
+	 * drm_atomic_get_connector_for_encoder() may have backed off,
+	 * releasing the connection mutex in the process. Take it back
+	 * before looking at the connector state.
+	 */
+	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
+	if (ret)
+		return ret;
+
+	if (!connector->state)
+		return -EINVAL;
 
 	crtc = connector->state->crtc;
-	ret = drm_atomic_helper_reset_crtc(crtc, ctx);
 
-out:
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-	return ret;
+	return drm_atomic_helper_reset_crtc(crtc, ctx);
 }
 EXPORT_SYMBOL(drm_bridge_helper_reset_crtc);

-- 
2.55.0

