Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB18CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2E110F5B1;
	Fri, 19 Jun 2026 12:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wi+J8iKH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C14C10F5AE
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:28:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1862601E4;
 Fri, 19 Jun 2026 12:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3221F000E9;
 Fri, 19 Jun 2026 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872088;
 bh=wM0KSzv8SHBSo2g3jELrV82qfH1uAW+IlSKVGyk/58A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Wi+J8iKH8K06RvRvWghtJ+HhlHqgkuGFKxlmZlEn1EIBHdFx7PBb6C2D1iujhbwhp
 MGjLQLMBNTf3glnbDpRhyySX5t2r1H9xV4hFaeyqCY3XKO3Y7r4l6EO7XB5T9NBxLx
 icFH0inQR2qdR7cEIm+Bf5zxmd/9J3TMwdawCFyoZIii7hc5nrssthcEERUbU/GQAq
 fs2iRmuYELQz6QoTgBAsPyRtiLRaUF3w1XyYZFPuxid4ft/Rbyow1yDmott4MlQz0f
 BUMBiq31/BgH3GAhDTV8NlB3P0GvMzva4gdxjloOxwGC1aGl6mXYkF2pnp+lrRZXoR
 1wKifHJ68Tm+g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:20 +0200
Subject: [PATCH v3 75/78] drm/bridge: cdns-dsi: Use
 __drm_atomic_helper_bridge_state_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-75-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=mripard@kernel.org;
 h=from:subject:message-id; bh=r584BfxwxGRxk1Cz0oQEjpYHCWYjKIMpL07dc0nLMG0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmptwlio9XtiydJa0g6fDV2FVn/jIzfu4ZNZymj4990
 FvJ8zC5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEYiZjrUiMys6kjxxero8/
 pb5U2yNxZhe71JPnFdXO8/ibQu+fruwtmfL59cK/F7Us/t73NplSz9iwhOu/+us9iZ8u6GinXXO
 SZf2vPalLU71OatVPY/XPmmUnTbnW2Xw8leDwyzyj7UdIaToA
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

The cdns-dsi bridge open-codes the bridge state initialization with
a memset and a manual assignment of the bridge pointer.

The memset is redundant since the state is already kzalloc-ed, and
__drm_atomic_helper_bridge_state_init() exists for exactly this
purpose.

Switch to it.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 344c3f466018..ca946e755818 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1015,12 +1015,11 @@ cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
 
 	dsi_state = kzalloc_obj(*dsi_state);
 	if (!dsi_state)
 		return ERR_PTR(-ENOMEM);
 
-	memset(dsi_state, 0, sizeof(*dsi_state));
-	dsi_state->base.bridge = bridge;
+	__drm_atomic_helper_bridge_state_init(&dsi_state->base, bridge);
 
 	return &dsi_state->base;
 }
 
 static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {

-- 
2.54.0

