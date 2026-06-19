Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51921CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E4310F5B3;
	Fri, 19 Jun 2026 12:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eUeCrQh7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C7810F5AE
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:28:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C92944486;
 Fri, 19 Jun 2026 12:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9001F00A3F;
 Fri, 19 Jun 2026 12:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872086;
 bh=PRei0tl1EcArvol8LC9FFYqjSh+6ouoi+L/EwgNu5Ec=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eUeCrQh7B3QenN1H8V5jtUJWMGPkF8PkLjNEO3rLTOwlgCEhLsXwvPweepw+gejZK
 cZcK6GMKn33oELBx780aiJ441CWU9qIHbpRdgH504uTVMeMhccr3v1r2kMV2+RUz6m
 TNx/LGeJy7qIeOdUloETlWWxgsmns1CXbn95LpDRnqhdMUyjbUH2urwEzSBDXAP1AS
 3u1W30lRQYGFZG9F8NQQ8F2yLvGj+h1/i8xAOBIzpi/ri+YH5GFNXXQctL4h96A+Cp
 TxjRh6lVZO/iIzttpmLlpeDdJKJjzhkfKpVE0GQ3odnqwfMStAvkoaon5zd5G/8jyI
 prajDIQTMO+WQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:19 +0200
Subject: [PATCH v3 74/78] drm/atomic-state-helper: Remove
 drm_atomic_helper_bridge_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-74-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KdRQdxt7tZAtIphU4x4vBY3myQS/3TXPGToeL1F9CkQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmplyXpu7476ro4tzBHXrjg0/J8zOS6gmn386R3idVu
 qMqZPONjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRxr2MteJF76963HP/euWM
 wNEgq3f/AsLVWOe0qi6dKtA1jWXj9joV2/vRYvvnpzjZMUhuleRgZ2x47Xqm2P6XvuQ+LwblC1u
 adDWO7991r+huurbY/VPMD3skOlK2SRS/mN+0QLz7085AEy4A
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
 drivers/gpu/drm/drm_atomic_state_helper.c | 19 +------------------
 include/drm/drm_atomic_state_helper.h     |  2 --
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index cfb54fc853ef..fbdc3d893a0c 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -871,12 +871,11 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_duplicate_state);
  * drm_atomic_helper_bridge_destroy_state() - Destroy a bridge state object
  * @bridge: the bridge this state refers to
  * @state: bridge state to destroy
  *
  * Destroys a bridge state previously created by
- * &drm_atomic_helper_bridge_create_state(),
- * &drm_atomic_helper_bridge_reset() or
+ * &drm_atomic_helper_bridge_create_state() or
  * &drm_atomic_helper_bridge_duplicate_state(). This helper is meant to be
  * used as a bridge &drm_bridge_funcs.atomic_destroy_state hook for bridges
  * that don't subclass the bridge state.
  */
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
@@ -905,26 +904,10 @@ void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
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

