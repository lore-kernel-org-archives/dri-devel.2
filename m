Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83160A2604
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3/llL+o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F005A1129F3;
	Fri, 20 Nov 2026 12:56:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FAB1129D4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 598AF61926;
 Fri, 20 Nov 2026 12:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6BE1F000CF;
 Fri, 20 Nov 2026 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179361;
 bh=EaVqBrbwb/ij03vj/oG+r2cH58R8FaoSm9uLLU/amPk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=c3/llL+oK+05qZu3zLNWrLJS37tFIBUnXvwkDsF0cpp06cdqu2r3rRZeogyy3KqEt
 jsRGyzcExgGITjkqOpmva+1/5Fulb0AnJrQbidULzSsr01L1bjblsTRkLm+YNTdEaB
 SzCC+7tULXv98jLU7SYXKCrYf+C7QT0UsTMXu9ll4XexMLh0CPQHGEtZtXPPqQogSC
 GEcgMTu6/VmpLEUR7KuWLN8s2FY7DG8MMrsS2jkVAZlX9AXzHw9SQVMQ9pP+wGxBps
 y2gQxLFgWxfSBtg5y+vWUISwwlRJMcJ8ZboaNKSvxSDCGpslxMOQjg1fEc6ZyCis2x
 j9HumyIXQHddA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:04 +0100
Subject: [PATCH v9 12/42] drm/atomic: Export drm_atomic_*_print_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-12-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4366; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CXxUrwg40I/dTAShooln2ZZnLn+29IGHmU87vz7FKQU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzhoXttct3zJN/JHkzrIP/32qRY9y/baqe8miVd/dI
 PG14Id4x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIrR+M9TEtk5rLtde2Zu6Z
 M6dtYklGpUC2U/fDC89NW06zLJEN/D7Xxjki2aQyoUlVLFmSX7mBsWHJBJveGZkrTxfl/RU1ZHd
 X7BeQ7GdknaoclX+rwOzQ4xXl754lq+fIrpdapKUQfWGyBgA=
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

The drm_atomic_plane_print_state(), drm_atomic_crtc_print_state(),
drm_atomic_connector_print_state(), and
drm_atomic_private_obj_print_state() functions are currently static.

The SRO infrastructure needs to call them from
drm_atomic_state_readout.c to print the readout state for debugging
purposes. Make them available by dropping the static qualifier and
declaring them in drm_internal.h.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c   | 16 ++++++++--------
 drivers/gpu/drm/drm_internal.h | 13 +++++++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index bfbd5ef1a6a7..ed0882a31a0a 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -556,12 +556,12 @@ static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
 	}
 
 	return 0;
 }
 
-static void drm_atomic_crtc_print_state(struct drm_printer *p,
-		const struct drm_crtc_state *state)
+void drm_atomic_crtc_print_state(struct drm_printer *p,
+				 const struct drm_crtc_state *state)
 {
 	struct drm_crtc *crtc = state->crtc;
 
 	drm_printf(p, "crtc[%u]: %s\n", crtc->base.id, crtc->name);
 	drm_printf_indent(p, 1, "enable=%d\n", state->enable);
@@ -977,12 +977,12 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 	}
 
 	drm_printf_indent(p, 1, "next=%d\n", colorop->next ? colorop->next->base.id : 0);
 }
 
-static void drm_atomic_plane_print_state(struct drm_printer *p,
-		const struct drm_plane_state *state)
+void drm_atomic_plane_print_state(struct drm_printer *p,
+				  const struct drm_plane_state *state)
 {
 	struct drm_plane *plane = state->plane;
 	struct drm_rect src  = drm_plane_state_src(state);
 	struct drm_rect dest = drm_plane_state_dest(state);
 
@@ -1565,12 +1565,12 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 
 	return connector_state;
 }
 EXPORT_SYMBOL(drm_atomic_get_connector_state);
 
-static void drm_atomic_connector_print_state(struct drm_printer *p,
-		const struct drm_connector_state *state)
+void drm_atomic_connector_print_state(struct drm_printer *p,
+				      const struct drm_connector_state *state)
 {
 	struct drm_connector *connector = state->connector;
 
 	drm_printf(p, "connector[%u]: %s\n", connector->base.id, connector->name);
 	drm_printf_indent(p, 1, "crtc=%s\n", state->crtc ? state->crtc->name : "(null)");
@@ -2211,12 +2211,12 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 
 	return 0;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_set_config);
 
-static void drm_atomic_private_obj_print_state(struct drm_printer *p,
-					       const struct drm_private_state *state)
+void drm_atomic_private_obj_print_state(struct drm_printer *p,
+					const struct drm_private_state *state)
 {
 	struct drm_private_obj *obj = state->obj;
 
 	if (obj->funcs->atomic_print_state)
 		obj->funcs->atomic_print_state(p, state);
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index f893b1e3a596..815486557f51 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -37,19 +37,32 @@
 
 struct dentry;
 struct dma_buf;
 struct iosys_map;
 struct drm_connector;
+struct drm_connector_state;
 struct drm_crtc;
+struct drm_crtc_state;
 struct drm_framebuffer;
 struct drm_gem_object;
 struct drm_master;
 struct drm_minor;
+struct drm_plane_state;
 struct drm_prime_file_private;
 struct drm_printer;
+struct drm_private_state;
 struct drm_vblank_crtc;
 
+/* drm_atomic.c */
+void drm_atomic_plane_print_state(struct drm_printer *p,
+				  const struct drm_plane_state *state);
+void drm_atomic_crtc_print_state(struct drm_printer *p,
+				 const struct drm_crtc_state *state);
+void drm_atomic_connector_print_state(struct drm_printer *p,
+				      const struct drm_connector_state *state);
+void drm_atomic_private_obj_print_state(struct drm_printer *p,
+					const struct drm_private_state *state);
 /* drm_client_event.c */
 #if defined(CONFIG_DRM_CLIENT)
 void drm_client_debugfs_init(struct drm_device *dev);
 #else
 static inline void drm_client_debugfs_init(struct drm_device *dev)

-- 
2.56.1

