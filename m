Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49E4C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061AE10E5B0;
	Mon,  7 Sep 2026 13:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T0mC92yh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B3610E5B0
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78C4340607;
 Mon,  7 Sep 2026 13:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9BE1F00A3A;
 Mon,  7 Sep 2026 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787471;
 bh=xpPWYd3Y0BGB9dv1QR5VEjriZg1mDf0mmXqWO0acjQs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=T0mC92yhuxUyDLdEE9w4wj/c0G1RqINuDoponDhg/xN4J9hh3GdKqb2Zzfqed3LPO
 YzzFhUOPgdOrhWmnipAXdrBzjxCxSiIGjG129atrSRjOhVd59TX2CumRP30MEf3rBz
 yOUqgZSs9FibCE+YwK8YL5jf5G1/lNurbXJqeq7u/u3rcw5PoctBIHscK890esvAqW
 qUOIUbeYUw5Y+PTmpU57HxGnj/gdSGdKR9gG+HD0DThfYSRSwfmaYjPcaiNiBCUpB9
 /Q9NVHf6zyYrnya7YCu+Dvn7F5TCxrOKnqyq/wjIF5EdoIJAheyuNj5N1zpBkiNnHx
 cipS+TzK/7eJg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:44 +0200
Subject: [PATCH v5 08/33] drm/atomic: Only call atomic_destroy_state on a
 !NULL pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-8-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3804; i=mripard@kernel.org;
 h=from:subject:message-id; bh=M99xEYp9CgMan3Ib2C+oR/KSEdJLNtomSAXFANy7/aE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj2ccfzElbVdHRe6H9XNKfh2M7PaZqvpFrOdR96sf
 6djtnvF146pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwke2pjA07fhxgcFYMPBOs
 wX0ovrtsauwruzrf3Ud2XF3wdWH8o5RY0evx1umyh1S1rngmB/nMSGJsWBHysErP5DLrk8kXql/
 sSp9WesLXP1phmY2n7OazFeejdVo3evs/tFCbX3CWvcRo3jkOAA==
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
index c497d550c6c4..223f2d617179 100644
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
2.55.0

