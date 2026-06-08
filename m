Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E42FCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A6610F4F0;
	Mon,  8 Jun 2026 14:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HQK1rP35";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D4910F4EF
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B80C601D8;
 Mon,  8 Jun 2026 14:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4C11F00893;
 Mon,  8 Jun 2026 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929504;
 bh=oSJpS1z2vXHmxaGCPnf+v6pZUmXde2xn8LfrzqIj/po=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HQK1rP35DNcfM26PZQCxTc5EzOI4Pjr4kN7K5k2+HpfRdobnPoNlkrV/d8UILZixx
 DGWTQ/3ppK4t6P2RvThy48JKMhcTf0LfEbHdDj6QY+FJLNr+MEXJRfZJpFyATqC5Uy
 kHcefp0fndt+qFozx2D1RSMOhHcsz8PBFwHakE0E1vtNitYkxtOKtQTWboOrZPkDmg
 R22awpj/LrPGhUQxZ52QbUrAHfBCl+e31l/EO1PfFb0G/pmh8UZE1QSH4p8RUVU9kq
 olT+lYG0y6a5rO8MOwOaCXMSmvgtiLsG89qdD3vvHNjN5/9c6/T2A+o5A7hiZ7dNGr
 Jy7VsvJ6Roqbg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:26 +0200
Subject: [PATCH v2 44/78] drm/bridge: ti-sn65dsi86: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-44-0a91018bf886@kernel.org>
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
 Douglas Anderson <dianders@chromium.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uDASBSXKnVoUUMH8XNAx7DjYkrwZFsU9fSmzKxyQT9Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlyNCvcVCfFcutAhPuf5YRXGz1SvrK0zXJ+lP+s10+
 /+kG8I3OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEPugzVrNovJ6y8tiJ7CCe
 9oXTyxbvK749d/KTiWm3795IYFytdeOAx1/2pv3Fd3Q66nqzDX9E/WNsOG39fvFTkzzBeabMH0I
 9r4f+Wc+Y8yd7O6NdbWTZnu7FPZZL7Ot3L/2uz/l3H28px8V+AA==
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

Acked-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 0884ec459cc5..1da242f17413 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1300,11 +1300,11 @@ static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
 	.detect = ti_sn_bridge_detect,
 	.atomic_pre_enable = ti_sn_bridge_atomic_pre_enable,
 	.atomic_enable = ti_sn_bridge_atomic_enable,
 	.atomic_disable = ti_sn_bridge_atomic_disable,
 	.atomic_post_disable = ti_sn_bridge_atomic_post_disable,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.debugfs_init = ti_sn65dsi86_debugfs_init,
 	.hpd_enable = ti_sn_bridge_hpd_enable,
 	.hpd_disable = ti_sn_bridge_hpd_disable,

-- 
2.54.0

