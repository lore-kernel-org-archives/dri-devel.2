Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E241CCD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542A810F56B;
	Fri, 19 Jun 2026 12:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HCqIOcY5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A3410F55E
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C3BB601EE;
 Fri, 19 Jun 2026 12:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9261F00A3A;
 Fri, 19 Jun 2026 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871906;
 bh=T9Hmn5GpETReMiYkDaa76ou/fJac+DNBpLs2lRaysTg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HCqIOcY5Mz4JxbyqXTqnhic0vgB2dldRV0DXYpbqMF8lRI9cTE3BThssgf9Sk+upk
 7M5BtlK8/0iSd8a1wgWoRFMMFzC1BcD7hfQM1TEr1pJ81udpK/DtkfKsGzoRj1LXCs
 zvUOYgF5aPSk6J5CmVHaB36aMyrPVZm6XPLPKLU7ODHyVgPzFQKpxrOmzwsQ1ZWpys
 4o8x9zxMtJREtAg9xAq2J8O58kEqio8UmzhdDBYiMAIfmfiJi/qtI8Qh0uNwe3UwgG
 FX00D9TEsGs+5msVvVpzHGeVjeqAs/PVQKkQ4YFtFfRbSeviEYQaFL+9TdEvyuvHTO
 D3Db4RsB2kJUg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:12 +0200
Subject: [PATCH v3 07/78] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-7-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PrnixmN2KhbGjKnXtXoSkR+gqJwDaMF9uZpnvyvJa+A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJm8fsu8/dk75w+bldx3yO0TuLTeJkPv9/rKoufakn
 X31vGL+HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAifkcY611eHH+49oS54vx1
 vUdOLA7Mr+37Y8U3pW3X6e7nbi7l904cj1hrv+V2RdAj/ZhD0pxcxoz1wTPXlH5q+KlcMbG7lEX
 rUphSxYV9fNfbQ/0ytCQPGT6S8NV3sEi9vPzthCl9R3QOLgoCAA==
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

The drm_atomic_helper_bridge_reset() helper is deprecated in favour
of the new atomic_create_state callback.

Add drm_atomic_helper_bridge_create_state() as the counterpart helper
for this new callback, and make drm_atomic_helper_bridge_reset() call
this new helper.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 22 +++++++++++++++++++++-
 include/drm/drm_atomic_state_helper.h     |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 9dfb9b6ba392..cfb54fc853ef 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -871,10 +871,11 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_duplicate_state);
  * drm_atomic_helper_bridge_destroy_state() - Destroy a bridge state object
  * @bridge: the bridge this state refers to
  * @state: bridge state to destroy
  *
  * Destroys a bridge state previously created by
+ * &drm_atomic_helper_bridge_create_state(),
  * &drm_atomic_helper_bridge_reset() or
  * &drm_atomic_helper_bridge_duplicate_state(). This helper is meant to be
  * used as a bridge &drm_bridge_funcs.atomic_destroy_state hook for bridges
  * that don't subclass the bridge state.
  */
@@ -915,16 +916,35 @@ EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
  * is meant to be used as a bridge &drm_bridge_funcs.atomic_reset hook for
  * bridges that don't subclass the bridge state.
  */
 struct drm_bridge_state *
 drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
+{
+	return drm_atomic_helper_bridge_create_state(bridge);
+}
+EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
+
+/**
+ * drm_atomic_helper_bridge_create_state - default
+ *              &drm_bridge_funcs.atomic_create_state hook for bridges
+ * @bridge: bridge object
+ *
+ * Allocates and initializes pristine @drm_bridge_state.
+ *
+ * This is useful for drivers that don't subclass @drm_bridge_state.
+ *
+ * RETURNS:
+ * Pointer to new bridge state, or ERR_PTR on failure.
+ */
+struct drm_bridge_state *
+drm_atomic_helper_bridge_create_state(struct drm_bridge *bridge)
 {
 	struct drm_bridge_state *bridge_state;
 
 	bridge_state = kzalloc_obj(*bridge_state);
 	if (!bridge_state)
 		return ERR_PTR(-ENOMEM);
 
 	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
 	return bridge_state;
 }
-EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
+EXPORT_SYMBOL(drm_atomic_helper_bridge_create_state);
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index cbc760598b9e..68c685ad330f 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -103,6 +103,8 @@ drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
 void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 					   struct drm_bridge *bridge);
 struct drm_bridge_state *
+drm_atomic_helper_bridge_create_state(struct drm_bridge *bridge);
+struct drm_bridge_state *
 drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
2.54.0

