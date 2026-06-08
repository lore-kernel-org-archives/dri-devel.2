Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA447CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1675D10F50D;
	Mon,  8 Jun 2026 14:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mY98PLQU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC59210F50D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:39:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50179601E2;
 Mon,  8 Jun 2026 14:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825351F00898;
 Mon,  8 Jun 2026 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929585;
 bh=Hssgs1qdu4dED3ac7eIb4wI+S9O4Ng3MAf0qZHVykXE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mY98PLQUyOwUtWCZymMOio+ovGC3cey0/BeZvuNmDx0ndVM8bOPmDfezcsfzmSBiN
 D643KIQAXBfZMfxpDZqsHWdrrQ7xTXtEGRH/r/BuhErpYH8YtSH9aXNDBknwruvXJ1
 WsS+PNsTSSV3rPAY2YqL4QTWdnzig3sMPGRrvJ5rQ/XO9rcsL9bKK/M8aStSrq/txt
 L/QsY4nEVLrQ3ZwLcHOWnrtALYv91XPxISJwebwy43HyvMg+BDcz3lVeMKK4urA9QX
 i/K9jmqkyJwOuXYK4f/VhBtj+cGGaSCZje1wfOaumHDX/sntipyD8M0bk7Urf4Qhs2
 dsUaqFqVG8amg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:56 +0200
Subject: [PATCH v2 74/78] drm/atomic-state-helper: Remove
 drm_atomic_helper_bridge_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-74-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZUTP3AsewnqXwpYqX5wjlNtXMxDO0HqMkfPfjxBi0Dg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql1O5ryzib+b3KHqmYu1hG/PzyfL2yUf//XuW1lGT9
 9p8vVtGx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI+zHGhnd5lrv2ndV+KCmo
 nXJGPTviRaXd7ZnPa+bvW54exluc/J4xqlUlMOzL+9BN978+Tow+z9jw3Vhz7cZrFpHRh+QMczM
 nMF49aXgi/wfLn5k3c0Mqz+6xTw2adzMh4HfcU4YE+6WrTXIA
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

All drivers have been converted to the atomic_create_state callback
and its drm_atomic_helper_bridge_create_state() helper.

Remove the deprecated drm_atomic_helper_bridge_reset().

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 16 ----------------
 include/drm/drm_atomic_state_helper.h     |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 268cff1faad6..db42c3823b12 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -903,26 +903,10 @@ void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
 
-/**
- * drm_atomic_helper_bridge_reset() - Allocate and initialize a bridge state
- *				      to its default
- * @bridge: the bridge this state refers to
- *
- * Allocates the bridge state and initializes it to default values. This helper
- * is meant to be used as a bridge &drm_bridge_funcs.atomic_reset hook for
- * bridges that don't subclass the bridge state.
- */
-struct drm_bridge_state *
-drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
-{
-	return drm_atomic_helper_bridge_create_state(bridge);
-}
-EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
-
 /**
  * drm_atomic_helper_bridge_create_state - default
  *              &drm_bridge_funcs.atomic_create_state hook for bridges
  * @bridge: bridge object
  *
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 68c685ad330f..34a599c3d86d 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -104,7 +104,5 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
 void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 					   struct drm_bridge *bridge);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_create_state(struct drm_bridge *bridge);
-struct drm_bridge_state *
-drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
2.54.0

