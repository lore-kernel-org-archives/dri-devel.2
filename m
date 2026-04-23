Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095C2F99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7185210F069;
	Thu, 23 Apr 2026 10:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eXcF9Y06";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A22D10F069
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:18:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CA4460121;
 Thu, 23 Apr 2026 10:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76641C2BCAF;
 Thu, 23 Apr 2026 10:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939537;
 bh=XLthABTvu6wZbcVZCsOBaQZVrcObStJws8bV4+2Va+Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=eXcF9Y06ANgUBztd5+iSgGwBKzTQ2LH+RO8xMP6OPb9BfWcOREMwOpeoy2cm+ps3i
 uNlRrgb2SSOGzYijYwwUTHyyCslPAaqYahWZWFSeT8RGs2oMrnDizTKE9Hg3pUKxTj
 EGDJip1l5K2TScr3dvdvP0M7/cI8OAFGtLwDlWmXyBt20/4CPwDq71IGLhi8cDAYW7
 ACEncZI32EtRgoUTIZtmSKq6uCtbZNM9jTG8wrJuExHRUjZTM1Iar3+eX6zNtqTMvo
 gGYVzJGjIjAlG0bBhwUf/+LmM1rrfl3YIKBm1BAHQq3IvCTlSGLzZvG28MVMdEnqr7
 Kb0cghSqn4W5A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:22 +0200
Subject: [PATCH v2 09/28] drm/atomic: Only call atomic_destroy_state on a
 !NULL pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-9-8549f87cb978@kernel.org>
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
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3793; i=mripard@kernel.org;
 h=from:subject:message-id; bh=XLthABTvu6wZbcVZCsOBaQZVrcObStJws8bV4+2Va+Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP75mjLL+2ncmS4XhfcLk/KMb3LPTO80OCrBwKRTP2
 tcwX7m5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkRQFjw+vydayzHvb/7BVd
 OSFjxcIG1xp1G/45Nhm/r76Lijq0o00l2shgf8Pe/5FlB3bMT7BiYGyYrldsWWeY1XJ5R4G2OeO
 KkyGMrXcLj69fvDSCIX/hig9/2aSv+s17c/egU8/EPD75DR8A
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

The drm_atomic_state structure is freed through the
drm_atomic_state_put() function, that eventually calls
drm_atomic_state_default_clear() by default when there's no active
users of that state.

It then iterates over all objects with a state, and will call the
atomic_destroy_state callback on the state pointer. The state pointer is
mostly used these days to point to which of the old or new state needs
to be freed, depending on whether the state was committed or not.

So it all makes sense.

However, with the hardware state readout support approaching, we might
have a state, with multiple objects in it, but no state to free because
we want them to persist. In such a case, the state pointer is going to
be NULL, and thus we'll end up with NULL pointer dereference.

Test if the state pointer is non-NULL before calling
atomic_destroy_state on it.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index c714a6e6e9ae..6449a4fd4ae0 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -274,12 +274,14 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		struct drm_connector *connector = state->connectors[i].ptr;
 
 		if (!connector)
 			continue;
 
-		connector->funcs->atomic_destroy_state(connector,
-						       state->connectors[i].state_to_destroy);
+		if (state->connectors[i].state_to_destroy)
+			connector->funcs->atomic_destroy_state(connector,
+							       state->connectors[i].state_to_destroy);
+
 		state->connectors[i].ptr = NULL;
 		state->connectors[i].state_to_destroy = NULL;
 		state->connectors[i].old_state = NULL;
 		state->connectors[i].new_state = NULL;
 		drm_connector_put(connector);
@@ -289,12 +291,13 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		struct drm_crtc *crtc = state->crtcs[i].ptr;
 
 		if (!crtc)
 			continue;
 
-		crtc->funcs->atomic_destroy_state(crtc,
-						  state->crtcs[i].state_to_destroy);
+		if (state->crtcs[i].state_to_destroy)
+			crtc->funcs->atomic_destroy_state(crtc,
+							  state->crtcs[i].state_to_destroy);
 
 		state->crtcs[i].ptr = NULL;
 		state->crtcs[i].state_to_destroy = NULL;
 		state->crtcs[i].old_state = NULL;
 		state->crtcs[i].new_state = NULL;
@@ -309,12 +312,14 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		struct drm_plane *plane = state->planes[i].ptr;
 
 		if (!plane)
 			continue;
 
-		plane->funcs->atomic_destroy_state(plane,
-						   state->planes[i].state_to_destroy);
+		if (state->planes[i].state_to_destroy)
+			plane->funcs->atomic_destroy_state(plane,
+							   state->planes[i].state_to_destroy);
+
 		state->planes[i].ptr = NULL;
 		state->planes[i].state_to_destroy = NULL;
 		state->planes[i].old_state = NULL;
 		state->planes[i].new_state = NULL;
 	}
@@ -337,12 +342,14 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		struct drm_private_obj *obj = state->private_objs[i].ptr;
 
 		if (!obj)
 			continue;
 
-		obj->funcs->atomic_destroy_state(obj,
-						 state->private_objs[i].state_to_destroy);
+		if (state->private_objs[i].state_to_destroy)
+			obj->funcs->atomic_destroy_state(obj,
+							 state->private_objs[i].state_to_destroy);
+
 		state->private_objs[i].ptr = NULL;
 		state->private_objs[i].state_to_destroy = NULL;
 		state->private_objs[i].old_state = NULL;
 		state->private_objs[i].new_state = NULL;
 	}

-- 
2.53.0

