Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA722CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1664E10F4C5;
	Mon,  8 Jun 2026 14:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Urg3t0Dx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC86E10F4C5
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6B5C4191F;
 Mon,  8 Jun 2026 14:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315BE1F00893;
 Mon,  8 Jun 2026 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929415;
 bh=VQKymBOZpsnbHmFX8MYgIe20POG7J33RFGorY/FIZv0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Urg3t0DxxsmzJ06CU7yEaMyEdk5bl8OO5+MOvGTXDjJsIpko1/LQ1lQ8wX1UGZL0W
 M9VD4qQw2MxwNCioxj98sEk3quBb8GQUXh1MPX/oNseF8cYxiLtvF2t1UZOI7KL/bg
 MplwX2Iq0aFMm/PWWLyMDQQJ+KV2LmtjEwlSAQrh6EhWVYaVrFA9Y+a144Kn5ItDOg
 9es62VAhEn5Zfx7gZyBw6r3INdkh5+vXFD/51CJHtY00W0yF2c3YUenRUmJd4b0wpt
 UJG1gNVwhVE/b9vQcz5k3NbJvG26GLDcO1cMe9HY7ujcvu+rdhLm+CNo3vf1WcEgOa
 ko+kVuw89nAVA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:53 +0200
Subject: [PATCH v2 11/78] drm/bridge: chipone-icn6211: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-11-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pXwvSJQolCmhqu+d/AspDqHRt0jTXTtfMl7BZ3+008Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlz1TRcL0lNQ5hfw19/op+dWffVKnyOtrLPlSLl/q+
 4NXnrs7prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwETaVzPWCtnUrzB+uFJsqnQZ
 g9F2S4FFb02UfI5+UYn6k7SeY0bjNs0Ht16yZE5a+cPM9Z0Qd4AhY32Z8/PJTMfL6yaITRfdduN
 S1LTAmR6Tti6POyV6/OH2nFeTT2pVzN97/6/BpG1r5r/79K8JAA==
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
To: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index d8344e011818..eb628a0ce6ec 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -616,11 +616,11 @@ chipone_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs chipone_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable	= chipone_atomic_pre_enable,
 	.atomic_enable		= chipone_atomic_enable,
 	.atomic_post_disable	= chipone_atomic_post_disable,
 	.mode_set		= chipone_mode_set,
 	.attach			= chipone_attach,

-- 
2.54.0

