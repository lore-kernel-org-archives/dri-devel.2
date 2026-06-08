Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B41CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86F410F4B8;
	Mon,  8 Jun 2026 14:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fo4DE+lj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665EA10F4BF
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF095601E6;
 Mon,  8 Jun 2026 14:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8551F00893;
 Mon,  8 Jun 2026 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929399;
 bh=aC81P1EOMs5ujLVb9/vRUkePFQ7d9DBuzn5PiZ6Fq/U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Fo4DE+ljHX4HhiXC4MilLxcuiidg1KG94f29WkEr/jKujf2okqpHaGTMXn7Nf2wnU
 FdItY32HSs5q4ggyrltvvZ9jYfXFTVEsayPVOW9w0LmnSWTp+6eobYhZeC/aEfg+K2
 divyzKv7V67duXdbSauHUObuL/KF9NMheGKLGsYHFrhjA/SuKcXpOIlfeh9qrNFGzd
 jwvyC+3HqozO8nNX0eee+7nvUnGn91xj+177vlsZ/EHrODguRWKnTZ8P4ryiX0YLNU
 rdB582BWZnY+t2UtPC+9iLHePu8M4hWvjmspvEfVKyEz7gIkuxANYDhBMPBUC9Bl6A
 CaclHyU3gwsgA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:47 +0200
Subject: [PATCH v2 05/78] drm/atomic-state-helper: Drop memset from
 __drm_atomic_helper_bridge_state_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-5-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vGZ2TzncWuetCe9M5dOdUunEWOv38Fr1ZnhiY5jEL2k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql91tmpYvTbvq+449qmLX6zXsnNsmuBsIvjn5KIht0
 tcFTe0dHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiTayMtXKXXhsvLvu6eXnL
 1tALbtuPdFwM7LA3LxVkL/kidmTH7EPKNb0/bjy9frWL08Xuzpb8v4wNG9ZuSD53zkZ7W9LCyqn
 u1WX1PXf3luecnb848v6pqfp2Gfr/f53K1jLb7cn7LOz7Dhk9AA==
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

__drm_atomic_helper_bridge_state_init() is always called on a freshly
kzalloc-ed state, so the memset is redundant.

Drop it and document the expectation that the state is already zeroed.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 8f04eae7a754..f0688f2d83fe 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -889,18 +889,19 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
  * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
  *					default
  * @state: bridge state to initialize
  * @bridge: the bridge this state refers to
  *
+ * @state is assumed to be zeroed.
+ *
  * Initializes the bridge state to default values. This is meant to be called
  * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
  * the bridge state.
  */
 void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 					   struct drm_bridge *bridge)
 {
-	memset(state, 0, sizeof(*state));
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
 

-- 
2.54.0

