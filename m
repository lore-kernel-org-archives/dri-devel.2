Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCBACD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F402510F4C1;
	Mon,  8 Jun 2026 14:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nkAk+5d7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCF110F4C1
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1301940B2E;
 Mon,  8 Jun 2026 14:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722341F00893;
 Mon,  8 Jun 2026 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929405;
 bh=ucDeJJcnc3o9kBpI3Raqck+mm3VntP+C7nTB3DMC5yk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nkAk+5d7rQdRnsUH+UoJBI/JCmzSONgfr5K4pAwWUnufzEl3XltbAYcEseHRBOhQd
 hELF3EKQJgo/TJETVZtab2aBbytMvEu303AUM/1yGGWp/KTVAaStm1PT0+SQ9doBS6
 ec8usLF4V+zNH2JZlXPFH5bCWm7dE3LoGXTpOUr3lW//yISjXmC6XBxgkZznlAtGB5
 KVp8MTdcUtEji5+5ZecMKvXJ1U1Xj21I2AayHcstq+1Urk3W1rFukJx+pYDkijGkSt
 5dzA0aH9lCiaLFXPVKHv1E3iQhbElHeL2ARVI/n7I/Lxg3r5yxs3PLi/rNCj5AI3QF
 TzwFzvsoBwfxg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:49 +0200
Subject: [PATCH v2 07/78] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-7-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2859; i=mripard@kernel.org;
 h=from:subject:message-id; bh=R/5jnFSMI3V3sckQLWwHUm1r3b2LO/TytRGami9SeCE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlz02Msx4Jy0c8EL51FWnhJAFtpsZV0y39bs5v3PJL
 I/NvC2SHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAitVqMdXZvd+ZsE7tj2qyk
 djBngpXxjvwzmpEBlYulzvpIT1u7VejVY1v5u9vZ9poqH7fek/sxhrFh94NIjcSL8478l7/ZMqG
 hZoHZxss351y/tvBczLsCqddvXvap9/hNOK4urRoaWHVhcuRPAA==
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
 drivers/gpu/drm/drm_atomic_state_helper.c | 21 ++++++++++++++++++++-
 include/drm/drm_atomic_state_helper.h     |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index f0688f2d83fe..268cff1faad6 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -914,16 +914,35 @@ EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
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

