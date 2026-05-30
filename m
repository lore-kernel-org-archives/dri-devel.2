Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A745ECD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7310E112847;
	Sat, 30 May 2026 14:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lMxJ1+x7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190F511283F
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91DE7600BB;
 Sat, 30 May 2026 14:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C417C1F00893;
 Sat, 30 May 2026 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149748;
 bh=6bRnXJ/Sv7s18eVI67BUB/fjkaxlKurWxyPQndAxfDI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lMxJ1+x73VSIs9JrR8h4vOMu6mSHuKh8UQq7Ke2lFRUlgZ8BVWWUCq6nq7M0FOMm3
 osa6k8r2XeYsmWGgyX+GqLx6AAPE7rO21dva1kCP7+VDOB3fReb7vjdnxouZ8S9opX
 Ynv7cLnKhChw4Y2vnCuTerQDvyP3M6rNzUgsML3s80nT4YYDDHk0BqHs7AJuNzhjWK
 l1Ty2Vs17NUtPMMzRl2XXUlnP8ay4NEwKO4gvMWNokGMBqQ+V7I2wQDzb6qzeXuV/D
 DcODKxRplUrLsgfRkck/MyaONKliLh+ndX5qD4Hu8Wb0RdYNpMyU2f3x3CJEtz2KZ2
 ZkmUEq6JbJ68A==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:02 +0200
Subject: [PATCH 57/76] drm/omap: hdmi4: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-57-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=mripard@kernel.org;
 h=from:subject:message-id; bh=MOI8srgDfYVCei3Om2Jg6m26yMz67zVR9apZK9bl0BA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb/1WP3bVEPvEsp1PRKn0x7Xb/xa+VFs90yyLTetDZ
 ItdZ41Zx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZgIUyFjnaWWfDZnL6fYIb0z
 F7fOVaoSPXKaZ/4P4YopG5uWHDghtTl0ceAjvjlcypflpu5QaA3sZKwVWin7boKH8IUQW5lT/ul
 H7hm2zN75wn+r5NUPafHCvJducJS9vd30OfLw4cdbGw7sqt8BAA==
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/hdmi4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index e306247ed8a0..61cfd003569c 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -495,11 +495,11 @@ static const struct drm_edid *hdmi4_bridge_edid_read(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs hdmi4_bridge_funcs = {
 	.attach = hdmi4_bridge_attach,
 	.mode_set = hdmi4_bridge_mode_set,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = hdmi4_bridge_enable,
 	.atomic_disable = hdmi4_bridge_disable,
 	.hpd_notify = hdmi4_bridge_hpd_notify,
 	.edid_read = hdmi4_bridge_edid_read,
 };

-- 
2.54.0

