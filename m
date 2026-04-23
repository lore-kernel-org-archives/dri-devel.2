Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93436F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DD110F06D;
	Thu, 23 Apr 2026 10:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C82DgoQb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D378F10F068
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:18:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4699260125;
 Thu, 23 Apr 2026 10:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D60BC2BCB8;
 Thu, 23 Apr 2026 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939533;
 bh=F4Qc8XYEpT+fzvIHLqVsB7nFiBt8LIn6DaWkF0x/Js8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=C82DgoQbgsjks0DTdQuFQPa8RjBZjy8eV4b4VuY6EnitThxieFoSlkYqLexAMc4G4
 gBhHlq+evfux7WotqoQ38iPa4wOl32Ds3I3q2qg4b8rRNyb/nr7BIMXPOrlXsmqPlq
 dcj9Y1JWLN0/0YhiG4zqSGzGqoqY9D7N7RNFZY098VWkCRjXnQYqael7OHQoTQS3Br
 73P0EkwLQ3Jsjhks/sCQqs40DX6pj7DADq1OkuBHaXPbeUd0KxGPU0o64w1IVxzO4t
 C+XGwQuDXotpMFnDnN6YkKEQYw9SDA+fdwdGx6VRN0YbzTuqVuYeURTfMYsnConZvy
 e8lo0jmVXJr/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:21 +0200
Subject: [PATCH v2 08/28] drm/atomic: Export drm_atomic_*_print_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-8-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4228; i=mripard@kernel.org;
 h=from:subject:message-id; bh=F4Qc8XYEpT+fzvIHLqVsB7nFiBt8LIn6DaWkF0x/Js8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP7428AuZLKKUYmF37rxZ+b6W2uPT/0ixJTmuS5/L6
 bty4gLhjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR7xsZ61S6r3S+NHUztl/k
 cHX5rKxnsi/My7ZpRT99Ls4qdKjaoZ15p0z26u8RD3fPVV/yY2/BPMaGF2V7/j6+5yz241zVnqb
 Q5mdh6j8dnPuKuS480XbMKVq2lV8n+6fUtterKpfpMzr4acgBAA==
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
index 0a9f5e9fc69b..c714a6e6e9ae 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -521,12 +521,12 @@ static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
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
 	drm_printf(p, "\tenable=%d\n", state->enable);
@@ -916,12 +916,12 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 	}
 
 	drm_printf(p, "\tnext=%d\n", colorop->next ? colorop->next->base.id : 0);
 }
 
-static void drm_atomic_plane_print_state(struct drm_printer *p,
-		const struct drm_plane_state *state)
+void drm_atomic_plane_print_state(struct drm_printer *p,
+				  const struct drm_plane_state *state)
 {
 	struct drm_plane *plane = state->plane;
 	struct drm_rect src  = drm_plane_state_src(state);
 	struct drm_rect dest = drm_plane_state_dest(state);
 
@@ -1402,12 +1402,12 @@ drm_atomic_get_connector_state(struct drm_atomic_state *state,
 
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
 	drm_printf(p, "\tcrtc=%s\n", state->crtc ? state->crtc->name : "(null)");
@@ -2048,12 +2048,12 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 
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
2.53.0

