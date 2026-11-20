Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B9606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYDHZyFU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082F11129E1;
	Fri, 20 Nov 2026 12:56:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B48F1129D0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 242B241827;
 Fri, 20 Nov 2026 12:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102401F000D3;
 Fri, 20 Nov 2026 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179350;
 bh=Mp9hWB8B7AP27KeBfxBiw0TBKt7Zbv2+0WFmOyuZHV4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nYDHZyFUH6g28f73QL3B3fo+uoTBU2wlbJPHZwntSOa13xILJ5fIePU9C9MoQ1pmK
 AcAt7bAtS7YiF7ApkHqZdxsRPVHGO7jBi/F3TqoRuONOkEYNggAOZhj9qkWNp9Ky35
 OM1hI4E0Sz7J+lKEva+YXO3PnRWyBlOSiVUt5lHjGsonG174P0e+Zs8hB2Aju0gOo3
 kzsvBdjb8CaZ5b86ndAAIf6xFPj9egDi5BZ/gdQwWCTmqXTD1EVrwtG9kM061ZqkwV
 DSEyn0AELFdCRQQf8v4bYwaTbn6MrIOFOg7HLwwAoYgYqidLj8xpE1KK1Rl35cHkyE
 8Vfmk+AV5OWmQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:01 +0100
Subject: [PATCH v9 09/42] drm/bridge: Add drm_private_obj_is_bridge()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-9-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8VHR9viboSztx6YkWnDmapeU2zF0PRUyV1trpsngtDQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzmpXVcvOvee5vn7pxNul+1YK67/+VHjcN/fXhmcLu
 j0m7l9V3zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAm8taUseGH/NcjonMOnp7b
 suRkSYQFz8p7lZzST5+u1FeXyDnPnZc550lZ10+3mdXn2b9c/jHBm4+x4bPRpWM3NO/ZxSkUdvb
 KG+tIiBkkRxhKS85mOCCZw1vX7beI6crfxp0GOy7vrk69u80aAA==
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

The SRO readout helpers need to distinguish bridge-backed private
objects from other private objects, because bridges require special
readout ordering through the encoder bridge chains.

Add drm_private_obj_is_bridge() which checks whether a private
object's funcs pointer matches the bridge private state funcs.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 15 +++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index aed3fcf0e180..b6cdbc172f68 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -589,10 +589,25 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 	.atomic_print_state = drm_bridge_atomic_print_priv_state,
 };
 
+/**
+ * drm_private_obj_is_bridge - check if a private object backs a bridge
+ * @obj: private object to check
+ *
+ * RETURNS:
+ *
+ * True if @obj is the &drm_private_obj embedded in a &struct drm_bridge,
+ * false otherwise.
+ */
+bool drm_private_obj_is_bridge(struct drm_private_obj *obj)
+{
+	return obj && obj->funcs == &drm_bridge_priv_state_funcs;
+}
+EXPORT_SYMBOL(drm_private_obj_is_bridge);
+
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
  * @encoder: DRM encoder
  * @bridge: bridge to attach
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 54cf0d223bba..a22a0bdf3251 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1232,10 +1232,12 @@ static inline struct drm_bridge *
 drm_priv_to_bridge(struct drm_private_obj *priv)
 {
 	return container_of(priv, struct drm_bridge, base);
 }
 
+bool drm_private_obj_is_bridge(struct drm_private_obj *obj);
+
 bool drm_bridge_enter(struct drm_bridge *bridge, int *idx);
 void drm_bridge_exit(int idx);
 void drm_bridge_unplug(struct drm_bridge *bridge);
 
 struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge);

-- 
2.56.1

