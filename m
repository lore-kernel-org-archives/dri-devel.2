Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069E6CD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687DB112829;
	Sat, 30 May 2026 14:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZjnSDgm3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC23B11281A
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FC98600BB;
 Sat, 30 May 2026 14:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CD11F00893;
 Sat, 30 May 2026 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149689;
 bh=zo3xORrcrD+PIXabeoQ/JuzpoaRul4k9z11FHweTuLw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZjnSDgm3EhToJhjvXwoY3eSdRxQh91Lv3ig8ToZMwsUGSK0Dl+MWEYW8QqsnZTyxI
 UVY7/bSlOE+hMaCMjjLGglJIBCOmzTMUb1TDLFH0tYKiw95+0SmARFXAKIXnKtuGlZ
 bwC4clMwTUIW5CNeLN6/DeW56eFGhj9mFol0hC+vrsQegcb5jeu7PHTikaNXQQMtGa
 agS9tVnSTymJGyljHsuDVD/eIWuK8uf5FHxh292K4GTYmlS4agnTdUecVcSraBdPlq
 uS5+qcPDAjAkaF6YkXuN4agPrze8LO0nxmRV8OSC3v5AioshofeGT8HEyFu2wZxLWX
 PFY8jXcgEb8PQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:40 +0200
Subject: [PATCH 35/76] drm/bridge: dw-mipi-dsi2: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-35-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jIkHyo3G623WNlodzt9biSoGxL3iUK8XUBjeEqduURo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb106D0w8XtvU3cFyfZLY22lZBxrNbATSJzzeYpwdI
 Ho5hWt5x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIezFjDd+fe/aCv70fP0+8
 a6H7QijFd6bOZPWdj3kquU5HqpRILwhnmXf1uu/dS1IbOYNFmbbvYayzU322NafMNNGeV2dP2bU
 njz2r1qvmz5nL9Fxg6i6lsh5p5y+N1veO5SvNfTCre+qfNxoA
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
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
index b2a022d266d9..5f06cb03b4c0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
@@ -891,11 +891,11 @@ static int dw_mipi_dsi2_bridge_attach(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs dw_mipi_dsi2_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = dw_mipi_dsi2_bridge_atomic_get_input_bus_fmts,
 	.atomic_check		= dw_mipi_dsi2_bridge_atomic_check,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable	= dw_mipi_dsi2_bridge_atomic_pre_enable,
 	.atomic_enable		= dw_mipi_dsi2_bridge_atomic_enable,
 	.atomic_post_disable	= dw_mipi_dsi2_bridge_post_atomic_disable,
 	.mode_set		= dw_mipi_dsi2_bridge_mode_set,
 	.mode_valid		= dw_mipi_dsi2_bridge_mode_valid,

-- 
2.54.0

