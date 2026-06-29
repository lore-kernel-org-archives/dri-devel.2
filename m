Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF928C44500
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2354310E766;
	Mon, 29 Jun 2026 08:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PP8vVViM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC68010E760
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C2B360008;
 Mon, 29 Jun 2026 08:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723FD1F00A3A;
 Mon, 29 Jun 2026 08:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721061;
 bh=vmHOtXIPi6T8bC/fuazWCmvGNZ+r2Sa+CyXVtmNQV5w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PP8vVViMZMDRXLNBu7VwpiflzPeZyoWdt1oll24QFZJrLPZP6u84cxJZOZ3Bc8QDE
 kdxnpmPqgf8GmGdELLLVeIfSnoBGkAL1gND5sJ2MsVusrHpUK88S+zA4ldPOIJpmvC
 u2H8ylAT2CVQePEXQve27+2DP14BKLwBtaerSy6aj4enqBtpFQkmi+wPxxzPVZeYKA
 n54i+vkL/Sn3P30LEdxq7+HPgZKfL8Mb73Uq1N4XQefCsnJuhrq5XQrfMzfJawnR4o
 MxmZH8WA3AIWgf9mj1gXTPgHRxnRtreD60LO109VFLe66WcHmxuKWWiDpJjdAuvyWW
 A1EbfeeEJBsWg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:07 +0200
Subject: [PATCH v4 09/30] drm/atomic: Only call atomic_destroy_state on a
 !NULL pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-9-5966657980ed@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3804; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IEju5m12o3e2ISvuQrkRaWIUzfb3UiWjNXTMdzzX+H4=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGpCKgSjnGkj3ekYWB/4AOHtbjVfxAcTXDWx7uTtz7C0CKNt6
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmpCKgQACgkQJ1/OGaI9vnaSAgF/aJMp
 2NcPVTjBOduaRuRfW0+EtMms3iogPxBHxSFctrbIk5hCyoNCOaeJMYSOUOhtAX4wxdkBtILzd00
 CJmv0DwjWE/YMVimwfxQAYut1tSUAU5XpJDtCxJmVgKAGVLJH1mw=
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

The drm_atomic_commit structure is freed through the
drm_atomic_commit_put() function, that eventually calls
drm_atomic_commit_default_clear() by default when there's no active
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
index 6bae998dd36a..d43ea69c2c9c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -291,12 +291,14 @@ void drm_atomic_commit_default_clear(struct drm_atomic_commit *state)
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
@@ -306,12 +308,13 @@ void drm_atomic_commit_default_clear(struct drm_atomic_commit *state)
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
@@ -326,12 +329,14 @@ void drm_atomic_commit_default_clear(struct drm_atomic_commit *state)
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
@@ -354,12 +359,14 @@ void drm_atomic_commit_default_clear(struct drm_atomic_commit *state)
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
2.54.0

