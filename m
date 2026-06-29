Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9592FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E390110E754;
	Mon, 29 Jun 2026 08:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="logTjlqr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5DD10E754
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B59BB43D6E;
 Mon, 29 Jun 2026 08:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF1A1F000E9;
 Mon, 29 Jun 2026 08:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721059;
 bh=3ZmxC5b4FXalDUG/A/h0iIBqXfMg229DCE18ofgmDZ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=logTjlqrt9FYOCWuVwyaeFKWfMLnROEtYb3kLFXdhciA5D8wGGBHPZWRBQovBoflO
 CWI5pogkDaIzCrriIDkkuI/t3qcfhslUPXd34D5bOy0bO6osWFYYFr+BuB3UwC9Ebc
 bTTpych5GV2aP7I7TpNgtslsfwXFePi+eqQNFHJuFUHkX9piNE/Gr0jR6yYRm5l3Mi
 om4xiShnBb7fsUngT1gKlueBL4dl5ksZBZ3LQVQL7+PntNQguED2ERhRRW7d0t5sST
 g27kVgh8T098yXC4XbMF3EibQ9KHHqaJAmZj4BlotIuzI1B40+w0jFwIlRw7gucHa4
 BQBDjkFtAp/jQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:06 +0200
Subject: [PATCH v4 08/30] drm/atomic: Export drm_atomic_*_print_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-8-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4253; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FQavETsKCfQwSS+lNy9n4ZjgB6q+KBRxwyb370CH2Vs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWsxvL9rky8mYcCV0+jufYN7FXnLXteB0j9g0s2tTz
 +a+TvjYMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACaibs/YsDu4aNse9fAlexr/
 uB8WuhGz8uCVnqPcja8O6/9l0V+j7xoVkV7eXbh4kkidioFzkLAAY319QI7uoquBeotSN9XUZkX
 sTKo7p+40KXbW9y2bsyfdeGxT/Thio/5yd0uXr/mH1jIVXQQA
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

The drm_atomic_plane_print_state(), drm_atomic_crtc_print_state(),
drm_atomic_connector_print_state(), and
drm_atomic_private_obj_print_state() functions are currently static.

The SRO infrastructure needs to call them from drm_atomic_sro.c to
print the readout state for debugging purposes. Make them available
by dropping the static qualifier and declaring them in drm_internal.h.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c   | 16 ++++++++--------
 drivers/gpu/drm/drm_internal.h | 12 ++++++++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 4f1b22551352..6bae998dd36a 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -538,12 +538,12 @@ static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
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
@@ -933,12 +933,12 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
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
 
@@ -1426,12 +1426,12 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 
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
@@ -2072,12 +2072,12 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 
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
index f893b1e3a596..91ce23f69ec4 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -38,18 +38,30 @@
 struct dentry;
 struct dma_buf;
 struct iosys_map;
 struct drm_connector;
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
2.54.0

