Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C52CCD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9317610E35A;
	Sat, 30 May 2026 14:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zoqab7FD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E4910E33E
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 13:59:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFA6B4404F;
 Sat, 30 May 2026 13:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAB11F00893;
 Sat, 30 May 2026 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149596;
 bh=QVQCRIpDmXHIjlSB3p1viVtLRPqlmR1mRWkM+4W4U+M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Zoqab7FDyACec/DAoil6aet3Ik3Qphuk495b/dez3y/1KNWgUJ6f4q+uJOp/ZiZ59
 ib5qBqBa941x+0ySMkbQ3l9qAjD6Iq/w0AV5U+sbw5MF2MRbkku+yi/Jwae7jqPaRW
 IjnDTg04TumRtf8ne3CkrZe+xaYk1J6ywBIlLVstX5LLmWtmHH0mCdPGxGGpSfQ08n
 n210iWGKzo398NmoWEg2oD3oN/LBY76n0uNkvBD+dgB98eftWjo50OuuIQokRB6tr2
 khvuHSZsCPaLg2CqKL6UxuXxORKGSC5EXpKWPvvg+DzwHn5UzbPI7zaOlh3xfQ+gDQ
 I23Lm37h5ERiQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:06 +0200
Subject: [PATCH 01/76] drm/atomic-state-helper: Rename
 __drm_atomic_helper_bridge_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-1-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6xzYSyez9+CM5LWBEcLdqOqkWKy/VmRQ+TwOTuFZ64w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb03fvnp/5nDLHsWgnp8/RM4uZrHYs/01L390G5/Ye
 o8lmTb7OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEjFkY62wiTbrOSxg37F9W
 w2uwLfKfWWnTmlLpa85uL2b+m3mSfUngsd6Zz045ft6rGOnkfH3zYsaG7gdsFzxtW9+dba5jcjD
 ilnv8NdzmY1YsT5qMsq36y68rp3xJeru7/6ytTNnqSX3HDfsA
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

__drm_atomic_helper_bridge_reset() is used to initialize a
newly allocated drm_bridge_state, and is being typically called by the
drm_bridge_funcs.atomic_reset implementation.

Since we want to consolidate DRM objects state allocation around the
atomic_create_state callback that will only allocate and initialize a
new drm_bridge_state instance, we will need to call
__drm_atomic_helper_bridge_reset() from both the atomic_reset and
atomic_create_state hooks.

To avoid any confusion, we can thus rename
__drm_atomic_helper_bridge_reset() to
__drm_atomic_helper_bridge_state_init().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 drivers/gpu/drm/drm_atomic_state_helper.c           | 6 +++---
 include/drm/drm_atomic_state_helper.h               | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 36c07b71fe04..4e3015d10a97 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1927,11 +1927,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
 		return NULL;
 
-	__drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
+	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);
 
 	return &cdns_mhdp_state->base;
 }
 
 static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 07686e94aae0..c38e514f336f 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -884,27 +884,27 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 	kfree(state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
 
 /**
- * __drm_atomic_helper_bridge_reset() - Initialize a bridge state to its
+ * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
  *					default
  * @bridge: the bridge this state refers to
  * @state: bridge state to initialize
  *
  * Initializes the bridge state to default values. This is meant to be called
  * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
  * the bridge state.
  */
-void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
+void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
 				      struct drm_bridge_state *state)
 {
 	memset(state, 0, sizeof(*state));
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
-EXPORT_SYMBOL(__drm_atomic_helper_bridge_reset);
+EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
 
 /**
  * drm_atomic_helper_bridge_reset() - Allocate and initialize a bridge state
  *				      to its default
  * @bridge: the bridge this state refers to
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index f4b6d8833bc2..6a715d8e1f4a 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -100,9 +100,9 @@ void __drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge,
 						struct drm_bridge_state *state);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
-void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
+void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
 				      struct drm_bridge_state *state);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
2.54.0

