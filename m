Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D30606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRnhr6Y4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197FE1129D9;
	Fri, 20 Nov 2026 12:55:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D969A1129D0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF47D43770;
 Fri, 20 Nov 2026 12:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A3B1F000C0;
 Fri, 20 Nov 2026 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179323;
 bh=S0aOPn/TEo0olvqbt/VbMrHJ/0MCKQnxL6eHqJmbaL0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MRnhr6Y4C84Rfgg5+8p/DnP05e4IoJPu+aNO3CoCFPw5Euqaw7WtI0iHysYqI+hZX
 oaCFPRiJ5zF8SGJkqu5secigik3gUPHNHuVwzFChX+gc/xbBkXUyPsr4jOyWVkhjPa
 SegzHPtv39v5I15blo+wzWp+5jO0lcI/InxxG7W3wd8YAfZo25wssCDxko1OZ4PuU+
 P6aQA5x5zOiYOlHmqgcNThhAn4ZJBmFn/a8UYTiPW+p/w3jBHiiw+nZ0ZsP5RJW2O5
 5GQsiwEPFqfIJnQGwp3bbGUml8Cb4iaw5m5m7/7nPWvWIxFQLOY2vqcyL6XlK/by/l
 R4T/3RUyilk4Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:54:53 +0100
Subject: [PATCH v9 01/42] drm/atomic: Add
 drm_atomic_get_connector_for_encoder_locked()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-1-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4971; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dxtZntBMS7z+8LZ2+SCA0rxLmF+3PiMyQ9ZOoSJFj94=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzsrllY+uqrwxOhZRunW9BdPCdwXixx0rttk1P5vNV
 O4gLfioYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkXRxjw+fDP29tP/F17oqe
 kFtNHxLzVSe9i3DkSzg6zedy/ppV7wwjPzdPvdDzTfWt8SnXf6pdOxnrfXV7i5/8N+rrK/nI+jG
 t94RR4cYnV84t1L9xSO/emrryFX78BdM8noeGTpzeJe8ZInkeAA==
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

drm_atomic_get_connector_for_encoder() takes the connection mutex
through the acquire context it is given, looks up the connector routed
to an encoder, and releases the mutex before returning.

However, callers that need to look at the state of the connector they
just found have to take the connection mutex again afterwards, which
leaves a window where a concurrent commit can re-route the connector.
And if the caller already held the connection mutex through the same
acquire context, drm_atomic_get_connector_for_encoder() releases it
from under it.

Split the lookup into drm_atomic_get_connector_for_encoder_locked(),
which expects the caller to hold the connection mutex, and make
drm_atomic_get_connector_for_encoder() a wrapper around it that takes
and releases the mutex.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 57 ++++++++++++++++++++++++++++++++++----------
 include/drm/drm_atomic.h     |  2 ++
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 81591173265d..d2a46ba7394f 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1289,10 +1289,52 @@ drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_commit *state,
 
 	return NULL;
 }
 EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
 
+/**
+ * drm_atomic_get_connector_for_encoder_locked - Get connector currently assigned to an encoder
+ * @encoder: The encoder to find the connector of
+ *
+ * This function finds and returns the connector currently assigned to
+ * an @encoder.
+ *
+ * It is similar to drm_atomic_get_connector_for_encoder(), but expects
+ * the caller to hold &drm_mode_config.connection_mutex. This is useful
+ * for callers that need to keep looking at the connector state once the
+ * connector has been found, since the connection mutex must be held for
+ * the whole sequence.
+ *
+ * Returns:
+ * The connector connected to @encoder, or an error pointer otherwise.
+ */
+struct drm_connector *
+drm_atomic_get_connector_for_encoder_locked(const struct drm_encoder *encoder)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *out_connector = ERR_PTR(-EINVAL);
+	struct drm_connector *connector;
+	struct drm_device *dev = encoder->dev;
+
+	drm_modeset_lock_assert_held(&dev->mode_config.connection_mutex);
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (!connector->state)
+			continue;
+
+		if (encoder == connector->state->best_encoder) {
+			out_connector = connector;
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return out_connector;
+}
+EXPORT_SYMBOL(drm_atomic_get_connector_for_encoder_locked);
+
 /**
  * drm_atomic_get_connector_for_encoder - Get connector currently assigned to an encoder
  * @encoder: The encoder to find the connector of
  * @ctx: Modeset locking context
  *
@@ -1314,31 +1356,20 @@ EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
  */
 struct drm_connector *
 drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
 				     struct drm_modeset_acquire_ctx *ctx)
 {
-	struct drm_connector_list_iter conn_iter;
-	struct drm_connector *out_connector = ERR_PTR(-EINVAL);
-	struct drm_connector *connector;
+	struct drm_connector *out_connector;
 	struct drm_device *dev = encoder->dev;
 	int ret;
 
 	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		if (!connector->state)
-			continue;
+	out_connector = drm_atomic_get_connector_for_encoder_locked(encoder);
 
-		if (encoder == connector->state->best_encoder) {
-			out_connector = connector;
-			break;
-		}
-	}
-	drm_connector_list_iter_end(&conn_iter);
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 
 	return out_connector;
 }
 EXPORT_SYMBOL(drm_atomic_get_connector_for_encoder);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..c8d0f18fd0fd 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -775,10 +775,12 @@ drm_atomic_get_old_connector_for_encoder(const struct drm_atomic_commit *state,
 					 struct drm_encoder *encoder);
 struct drm_connector *
 drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_commit *state,
 					 struct drm_encoder *encoder);
 struct drm_connector *
+drm_atomic_get_connector_for_encoder_locked(const struct drm_encoder *encoder);
+struct drm_connector *
 drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
 				     struct drm_modeset_acquire_ctx *ctx);
 
 struct drm_crtc *
 drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_commit *state,

-- 
2.56.1

