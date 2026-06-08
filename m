Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72006CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D679910F4E6;
	Mon,  8 Jun 2026 14:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jazttTmr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678B010F4E6
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 508C4416C0;
 Mon,  8 Jun 2026 14:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD861F00893;
 Mon,  8 Jun 2026 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929486;
 bh=ETI+9Ht1vTDYzRbXTxW6OapvfZxGPJ/Cyodyi5/7fV0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jazttTmrB3lrmmmoyx8evo6TjEg+ukHh/JxuyC+IsZR9ezzWGajGxdNqobtBj31Cb
 X3oRnHyHJk6/r2vZ7Q9hIJ4zy1lCbDTX+a7ILy6B235gCFQ8uEhhUKghyizqrEJ309
 mQmarqtshxKhy00x3DmBZlEjTgoG9gqb7nWiRjLMro3tL28pWBfbLLkFsp2kHXbgNR
 e2FXCvetfKrXSmtzox50KEfUETaPznBogQRvJAvFl86vZTtXHbAEYDSzZZ5cOpGIZB
 wHlkuM68yXwvHDKgwb0mw8hNM6cLUZafDobQIhQ83F/XBkXXAigqFLkoZJP581sCEC
 suv39B5AV6vDg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:19 +0200
Subject: [PATCH v2 37/78] drm/bridge: dw-mipi-dsi2: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-37-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9e3aMiNkanAizeMOrKJnqJpLyIoV8nKUKfmkylP7Igs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql0MVWU92mJ3UvJjod9Wv8sfkXzrH7tkunv5y1tw1i
 7R6BG8c7JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATMfzMWO/aZ/Tnmwr7jHwR
 T13xJQcf7LqvPz3DJfBca93RrLWGOTIC/3/fzFMtTl4+w3Xm/J3tNoz1JYULfJ9EbWVtdrN7HBW
 m3lwa0hKpGmEnn5deL73oz2YRp/qLEiEr1Pe4iWhPOTq5/z4A
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

