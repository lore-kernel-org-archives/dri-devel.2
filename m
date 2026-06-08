Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D69CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BE710F4EF;
	Mon,  8 Jun 2026 14:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fPbTTIIG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FBF10F507
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:39:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 502B9601E1;
 Mon,  8 Jun 2026 14:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818171F0089B;
 Mon,  8 Jun 2026 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929569;
 bh=/Sgvp0HnOX4tR3YU+1zHtf+8w5wGt08fk50a1kFIO1E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fPbTTIIGxYKdDXg2s6C/cI0eAZlGLgXAv5BQ3Cvj4q00NlHDdMs7RImsAhHwfCVWq
 dhxxygtAFIlhJHeYaJCPCxwyeMY+cydu2xnOKvm6Yxfd+FQu1ptWkIWeIdMcPcvFoJ
 t9f5hfr25bNyZzp+d/A+OKfSpX2/cDIcdHAeqUrjoPpSKCoTYWt4TMZaNQe628XwIi
 NYQa6rRFczGFMpUJgovs5mUK8Lf6M909Qj9ljnts7t1UoN2Q2yiXQwd5/LNfpHYxSS
 Eaml2PEBTCkLkNhdEMfLOEq+5NpQ+lHRA6Mb3HSnW5qhM9OcdsMV/d+rn1j/M8GTKU
 lRR6O5wxxOULw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:50 +0200
Subject: [PATCH v2 68/78] drm/tests: bridge: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-68-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iLi31YK8thDs9gXrS9NHz5YOP9L7/OAPZIRrd7oBzBs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql5O9Q1gf1fE26Z0++brSbJXEbuHZNhs//u1x8v77x
 Zjp2gqjjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARGx/Ghl0B53VOGJ+bPqXc
 /8L0KjlVjXlOr7V2bGMU/M7qen5v4STHDNMT8yzu3Ergjm1d+nITA2M164+rd9Ma2S7axnd9bFn
 xnkn56YSQ1Zobrx0N4FZqXLHoVpF1Y7+Fp2Xs+fbmFEH/H/cA
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 64b665580a88..3f0269e52432 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -90,11 +90,11 @@ static const struct drm_bridge_funcs drm_test_bridge_atomic_funcs = {
 	.destroy		= drm_test_bridge_priv_destroy,
 	.atomic_enable		= drm_test_bridge_atomic_enable,
 	.atomic_disable		= drm_test_bridge_atomic_disable,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 };
 
 KUNIT_DEFINE_ACTION_WRAPPER(drm_bridge_remove_wrapper,
 			    drm_bridge_remove,
 			    struct drm_bridge *);

-- 
2.54.0

