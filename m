Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0B6CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCD910F4EB;
	Mon,  8 Jun 2026 14:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OX65sbuM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68BA510F4EB
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF49A601E2;
 Mon,  8 Jun 2026 14:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3E71F00893;
 Mon,  8 Jun 2026 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929499;
 bh=lHQIntAFjgWuDJ5wWRQlEIZFw4sZEb0oMKuHDn83VVw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OX65sbuM1ih83/WdZ3O8rADgGU3fBW3ES0wajy4V5X7qobjJlYDnwajTZD0oXdRpM
 UPpXJDpZAgiSNef5fU7i5Bo0cnjO+ztrVInnBm2opjFqg/geLfErKIQ94PL+exQUB4
 M78IAl4yM1OfVIilhFgcKfle3roSiau9TDiSLBH9VqaOP1HpLuA5ILd6qli4LtxFxs
 /dch1nGcQpzoUntUas4Jj1P+5iIc19WGourREwbXrG1Hgci2Tk5oQ+9tyjOC22gkKz
 CtM6rYOVt/6hlLYIB4bP1FzrVbQ6sFRYPyG1bEiGhYSem/cwHXazK3AcdImPGlZ2mB
 w/Akz6ZG0M6fg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:24 +0200
Subject: [PATCH v2 42/78] drm/bridge: ti-dlpc3433: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-42-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0nh/mhlnO6W+nh/nDhkpTbd0uDKOXYCQVRnfybHdQ1k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql8OnPOjYY/BtfhV3eK9Ytf5+qe0yizO0T8Ydbv5dv
 PXCmWO3O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE3l5krDOodvCPaXMxmhmR
 l/6m4BETEzMXx8vu42l1z9rmPt4ayzfdf7PdQatnm37uevrUJtewjbFh3sKP55bvCTv42OlLpV3
 hpPYp5aevrMmPW/JbM3/tgUusqm/+hz7j1xT4p3BG6baKYIMrAA==
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
 drivers/gpu/drm/bridge/ti-dlpc3433.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index 9c35eade0a78..c16eb3a05cfa 100644
--- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
+++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
@@ -252,11 +252,11 @@ static int dlpc_attach(struct drm_bridge *bridge, struct drm_encoder *encoder,
 
 static const struct drm_bridge_funcs dlpc_bridge_funcs = {
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts	= dlpc_atomic_get_input_bus_fmts,
-	.atomic_reset			= drm_atomic_helper_bridge_reset,
+	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable		= dlpc_atomic_pre_enable,
 	.atomic_enable			= dlpc_atomic_enable,
 	.atomic_post_disable		= dlpc_atomic_post_disable,
 	.mode_set			= dlpc_mode_set,
 	.attach				= dlpc_attach,

-- 
2.54.0

