Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A427CDB466
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C041710F560;
	Fri, 19 Jun 2026 12:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wugi0aPG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5346510F560
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:24:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 93492601E2;
 Fri, 19 Jun 2026 12:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51B91F000E9;
 Fri, 19 Jun 2026 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871898;
 bh=5l7f2IeEXJT1jsWO4xFWWRx3uCxA/3FtwdBfOkabJBw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Wugi0aPGkYPmf5ATlbK1S/EpRcA5onH3ry0Wv3zEZ6zNqpgWMqMN7TPcGgW4M6XN1
 fU93RMYS/862RuaD+HBlnIFo75+W4IND28A8Umo3F8PSz2EcWx2MUo52IRgkYKKxfc
 umZlTAcHWc1RxUaCK7/9grR3x6b9Br2JDWTmpmzfgeCGPSyTr96ZODF1YfBj2OGwB8
 YZiuoYCSLHF6Hfp4QXBgIHAJTPyywvJgWY4j0ru2zXHHg4M7TJgcIIMmT4fX/DNZjA
 Q+GZ4ZUC+QbHJqInSoXE/UrmdRRmtTzHwMvVB90r1Zx43Ek3Fwz7EbIA9v6Uau8M0G
 BGTai+LV8j0ag==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:09 +0200
Subject: [PATCH v3 04/78] drm/atomic-state-helper: Reorder
 __drm_atomic_helper_bridge_state_init() arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-4-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4005; i=mripard@kernel.org;
 h=from:subject:message-id; bh=A1ezfTi7c4/rtN61V7AYIxnf+A/QqcrOejoDg7dOOkU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJq8TWL91bW8JOGb5/P7R/7umxactF992be7KDMvq9
 ymPXoXWdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ9E9jrGJm+jhbQJdxWfSp
 j9MZ/n1gsuJxMXO3Ko24qJ907cSDK/KGUQKsvjECB1ZufNKqvZlrCWOd2drSkuPR087bdtfbL1x
 6937dx57zbAwd0ycv+fHb8zBvd7CE+9Nf/hYPDZnTjs8OSX8NAA==
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

The convention for state init helpers is to pass the state pointer
as the first argument and the object pointer second.

__drm_atomic_helper_bridge_state_init() has them in the opposite
order. Swap the arguments to follow the convention, and update the
cdns-mhdp8546 caller.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 drivers/gpu/drm/drm_atomic_state_helper.c           | 8 ++++----
 include/drm/drm_atomic_state_helper.h               | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 2e74dc33e085..b9574289c247 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1927,11 +1927,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
 		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);
+	__drm_atomic_helper_bridge_state_init(&cdns_mhdp_state->base, bridge);
 
 	return &cdns_mhdp_state->base;
 }
 
 static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 73e76426da1f..8f04eae7a754 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -886,19 +886,19 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
 
 /**
  * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
  *					default
- * @bridge: the bridge this state refers to
  * @state: bridge state to initialize
+ * @bridge: the bridge this state refers to
  *
  * Initializes the bridge state to default values. This is meant to be called
  * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
  * the bridge state.
  */
-void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
-				      struct drm_bridge_state *state)
+void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
+					   struct drm_bridge *bridge)
 {
 	memset(state, 0, sizeof(*state));
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
@@ -920,9 +920,9 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
 
 	bridge_state = kzalloc_obj(*bridge_state);
 	if (!bridge_state)
 		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_bridge_state_init(bridge, bridge_state);
+	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
 	return bridge_state;
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 6a715d8e1f4a..cbc760598b9e 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -100,9 +100,9 @@ void __drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge,
 						struct drm_bridge_state *state);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
-void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
-				      struct drm_bridge_state *state);
+void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
+					   struct drm_bridge *bridge);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
2.54.0

