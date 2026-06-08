Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B284CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A4610F4E4;
	Mon,  8 Jun 2026 14:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qtd/AHJn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5350B10F4E3
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA7B0601D8;
 Mon,  8 Jun 2026 14:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073601F00893;
 Mon,  8 Jun 2026 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929483;
 bh=Nalnlxr5Wp0yqYOfW/X9NsaIL/p0auxEZzs+q8u9yDQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Qtd/AHJnFsOxGnPSZjLvqfRa5+34hhPBgsI0+9KnY59oUEq+TpBl6+ZHWcXSSGKQx
 JyJ0McHefvPvHv0Y3lXA/0fxxxiDIcrbTriZpmGEFsZs3wZ4ZCMiPi/3pr4BOku7I1
 6YRZ4iK/a9pot2U6hWQRKOInWLNsBEglUphiTw+936yUImbZ7e0sW1jk3qWbIhGaIq
 J2izZQkoObfhShX5wD5EXeb3ElJRFzU5lzJo6t285TOFS/b5ZRzTO3ppzzeCVvYiLh
 uHn20ip21KdkdsXbckgF8uDDUl99qYDHuCYgOO1jHW3YLrzsNihZlsef7dVrDSSm1n
 Rzsd4XIk2QzfQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:18 +0200
Subject: [PATCH v2 36/78] drm/bridge: dw-mipi-dsi: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-36-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jNjyZLuLPCmhPpjdGnEI/dVl4uQsMAI5jrY5ASM5T+Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql0PW+vXVWs42eLYu4NH7Pw88ForPDvq1se3Kmp7/f
 OknvKRVO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBELA4xNrQ9jUhp+VF47GLc
 w+VR+ybEfVl67ubWi3brFuUeUdvsM7lF6vaUmxPVquTjUt5Ossj5eoSxYddOgY9hKr9/yXP3Kdi
 +31j92pHH7lTKV9s4Z1eR0yJB3003tdv+nHrX7F7hlckB7g+NAA==
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
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index af176e136f85..5dd475fcaacf 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1093,11 +1093,11 @@ static int dw_mipi_dsi_bridge_attach(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = dw_mipi_dsi_bridge_atomic_get_input_bus_fmts,
 	.atomic_check		= dw_mipi_dsi_bridge_atomic_check,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable	= dw_mipi_dsi_bridge_atomic_pre_enable,
 	.atomic_enable		= dw_mipi_dsi_bridge_atomic_enable,
 	.atomic_post_disable	= dw_mipi_dsi_bridge_post_atomic_disable,
 	.mode_set		= dw_mipi_dsi_bridge_mode_set,
 	.mode_valid		= dw_mipi_dsi_bridge_mode_valid,

-- 
2.54.0

