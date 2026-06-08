Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952E8CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A1C10F4D2;
	Mon,  8 Jun 2026 14:37:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ckb3OOka";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDE410F4D6
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:37:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B0989601E2;
 Mon,  8 Jun 2026 14:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FB41F00893;
 Mon,  8 Jun 2026 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929459;
 bh=nHR1gDkHFy27JqR3VB7JuCZe4hSMhthC8M5Zk28a5V8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ckb3OOkat9mzhmAlzhU3dwe937UxpAQhKLfmXMpeQke+D1QXnz4rwSFrhtIUMFLzn
 HmWAXrxf1T2QwRZgGYsdEr4jH+XD3ns0j4ujpcW0REb6nwc0xVsCXQ572LBFraOWXX
 0foNR7UZu+c0F16N09RVsExNEt+o3rUVs62uRv9G7IspICjpi64lPve3O6xEGa0XAq
 0LrMLAr+oM7lu+fsoQrE//4z/HC6bkXEx1fuTvIGCgLd1tIozQ4477njGc6nPslyub
 XeXxCYTkWaQ4GGXb114gjb7lYEK9Tju3Vc0KLEejClqefmXCunGWEjU2dBQUvv6uKh
 uCspxkyJGOQ3w==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:09 +0200
Subject: [PATCH v2 27/78] drm/bridge: nwl-dsi: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-27-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=mripard@kernel.org;
 h=from:subject:message-id; bh=c6NPaYQaqGp+lY0oc3b8ziCMalLHIq/s+T1XUxylp34=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlwNNj6/cYaEwcduLLebXilS+/f+wVPlMzYNir5S4j
 99kjFuiOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEDJ4x1vC+++8uLJ26+66V
 y6vmK96Ke/iYmxbHneX/xzjZf1rKu86P4uqRf14XCJ82eXLs113/L4wN77U3ebbK7zV4Y3KtlWv
 1iuMvVv5P/RvsO6FPSWBH08UL5wOLn/iILLniE/l+k6yJxf0tAA==
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
 drivers/gpu/drm/bridge/nwl-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 3c9ae93c4f67..09992529f3d8 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -958,11 +958,11 @@ static u32 *nwl_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_check		= nwl_dsi_bridge_atomic_check,
 	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
 	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
 	.atomic_get_input_bus_fmts = nwl_bridge_atomic_get_input_bus_fmts,
 	.mode_set		= nwl_dsi_bridge_mode_set,

-- 
2.54.0

