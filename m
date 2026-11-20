Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879F606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7p3tTAR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363F51129D0;
	Fri, 20 Nov 2026 12:55:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EAE91129D4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB83644E6A;
 Fri, 20 Nov 2026 12:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7CF1F000D4;
 Fri, 20 Nov 2026 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179340;
 bh=JdTWumvc9n2bCV3YQUSMi2nQpyXgefMPJDC9VJfjT6Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=D7p3tTARdaK9Bs1j1tjQS8hKi/p5OMOOpNfen1mEJKcoIx9GaCVXSn1Hi4E944aCy
 5kvt0cEiJ8v73zCMu6KVok+cYJqBC8RMKX5qVndScJHDTTZhAzbfag8Adsgi85vxNO
 0o99PLN8nKc813BTkR8bORWLS2x2RbyXmOCCJ2UVHtYwqq6RXFC/2GOkUTLc7F3Qsm
 PTjd4M/nN2JsGYVwybFe10mFiDR4uKPyIV25seojFUMsTKd7CYXV+ndF6EQ/eO1qkK
 RudtO480GRqp7YepBMbIZbOKuEp1Er5WT8dbD1mhS8FMEPAMLqpAgfDBKzJ5AABFTX
 s0OuUc5jZwVuQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:54:58 +0100
Subject: [PATCH v9 06/42] drm/atomic: Fix private obj error handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-6-a67c2b45b8ec@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2921; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NLGP55ne1s4VzJJdZyWZz/4IDKZ0eBtxQLjNgLTOcjo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzqqHp3SWsWYaRGVe+/Oy75Xk6V9BBlPD7zAusL48J
 95M7pFvx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIlRZjwxWbD4kFERxtzyR7
 F5Ul5vxaveSuzPYZ3V/55Q6l/9q5sG6nSLGcto7bTpm7V7fIdi3SY2xYqXWlwP9uxsvUhWmqzpw
 anoraNfw/bbIj3JT82BJVe01EJxiwi8v6v4ubbp//hJfJHwA=
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

drm_atomic_private_obj_init() initializes the modeset lock and adds the
object to the privobj_list before calling atomic_create_state().

However, if atomic_create_state() fails, the function returns the error
directly without removing the object from the list or cleaning up the
lock. This leaves a dangling entry in privobj_list and a leaked lock.

Fix this by unwinding both operations in an error path.

Fixes: 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback to drm_private_obj")
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index d2a46ba7394f..11a533184250 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1060,25 +1060,41 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
 int drm_atomic_private_obj_init(struct drm_device *dev,
 				struct drm_private_obj *obj,
 				const struct drm_private_state_funcs *funcs)
 {
 	struct drm_private_state *state;
+	int ret;
+
 	memset(obj, 0, sizeof(*obj));
 
+	/*
+	 * Keep the list node in a state drm_atomic_private_obj_fini()
+	 * can safely handle if we fail before adding it to the private
+	 * objects list.
+	 */
+	INIT_LIST_HEAD(&obj->head);
+
 	drm_modeset_lock_init(&obj->lock);
 
 	obj->dev = dev;
 	obj->funcs = funcs;
 	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
 
 	state = obj->funcs->atomic_create_state(obj);
-	if (IS_ERR(state))
-		return PTR_ERR(state);
+	if (IS_ERR(state)) {
+		ret = PTR_ERR(state);
+		goto err_list_del;
+	}
 
 	obj->state = state;
 
 	return 0;
+
+err_list_del:
+	list_del_init(&obj->head);
+	drm_modeset_lock_fini(&obj->lock);
+	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_init);
 
 /**
  * drm_atomic_private_obj_fini - finalize private object
@@ -1087,11 +1103,22 @@ EXPORT_SYMBOL(drm_atomic_private_obj_init);
  * Finalize the private object.
  */
 void
 drm_atomic_private_obj_fini(struct drm_private_obj *obj)
 {
-	list_del(&obj->head);
+	/*
+	 * Some callers ignore drm_atomic_private_obj_init() failures
+	 * and unconditionally register a teardown action that calls
+	 * this function. Use list_del_init() rather than list_del() so
+	 * that calling drm_atomic_private_obj_fini() twice, after both
+	 * a failed and a successful drm_atomic_private_obj_init(),
+	 * remains safe.
+	 */
+	if (list_empty(&obj->head))
+		return;
+
+	list_del_init(&obj->head);
 	obj->funcs->atomic_destroy_state(obj, obj->state);
 	drm_modeset_lock_fini(&obj->lock);
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_fini);
 

-- 
2.56.1

