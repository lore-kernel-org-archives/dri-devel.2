Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C62FC43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B91810F62D;
	Fri, 26 Jun 2026 13:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a+rFLHs5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC0510F618
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:57:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5044600DA;
 Fri, 26 Jun 2026 13:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEDA1F000E9;
 Fri, 26 Jun 2026 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782482266;
 bh=3ZmxC5b4FXalDUG/A/h0iIBqXfMg229DCE18ofgmDZ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=a+rFLHs5/X8WXNPsMjrofSuGSPisB0HJ+3RF32EZu7XuGUFbm4TW14WXAQmwY71oJ
 cXqNCfZnnTn1fvBKsexKlQDfR4YaMI+Hz4KtsSYmRwSZwXQIco3Zstrp1947IuudzB
 ZEB+7V75Ad9EKzuYQGM5a99Cz9SOsyoOt6FmkViOFjU1yz1bPl294clHb0qLEUjgk1
 N28yFiFVZviu5MDntKjP/Id8BcQnqp9rOd05oeQfQzQXa6NB0yp6IueZUjAyJA34yQ
 eD6vhTwFnUKOFQe8ODH3+AgU9RqRY3heyp+DBhGTdmUhIBsoq+IjmdQNPfqZasTy2/
 87zWYlFZrXDJQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 26 Jun 2026 15:57:09 +0200
Subject: [PATCH v3 08/30] drm/atomic: Export drm_atomic_*_print_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-drm-state-readout-v3-8-d5825e3299a8@kernel.org>
References: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
In-Reply-To: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl2rSbVp9sdXf/Jny7eXN7/VajKUGuDxrO7fK/nLXu0w
 pMx739Dx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjId03Ghi8/vFXOiNd0q5ak
 aLPueyjmfd/W1PXryjVJCpUR7zdGWvlkPeh4xKpUYnz2OZtUDUsnY8OxH/sP/bK8Yr4/MNw40iN
 jnmfO9KY3piJ8k/gCWLb+VnVZ1egutMh2wQpR7yZN4WNctQA=
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

