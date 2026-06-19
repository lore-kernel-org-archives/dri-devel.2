Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E0ECD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D69710F585;
	Fri, 19 Jun 2026 12:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oUd0SHU4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2F510F578
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2F5C601F5;
 Fri, 19 Jun 2026 12:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53501F000E9;
 Fri, 19 Jun 2026 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871949;
 bh=kFUiACoV7rCN63sJwqoS2zZ7ZfifSAI+YSKuNeX8RuM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oUd0SHU45yt57hUcYQZDTM6FBrh3lVj0dvGTAyrli5U7DMusjxrucLI2ZNi87xlIe
 LvuLrucE6cUyRABOyN27aWBPCt5ldci+cVL0xb0z2CxPF6VoXnIkgzBN7AVlViftZg
 /VinZJooM0BiGqdarkNydZPaSUSq5OiDEURqNB10sYXIxOpBhOm4Qk6Tkd4odkmZUt
 qnW88hadZHxHja6+0C47tI9mdfGWax2jl5D/YzY/jZ2Hp3FoH0Nu3uCuEm2+aAFanw
 WmaTIWynkmWDbn3wahWvrpEIBtb+lSjIA6wUt97XSfpBqdLSNyXpagg2pGIgkWaYaz
 3xG3Tbb2vaorA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:28 +0200
Subject: [PATCH v3 23/78] drm/bridge: ite-it66121: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-23-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Phong LE <ple@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SXoDxVYA59lx1NBfqxTTNFJlRyW47LXrUPRgVnUcdVg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJl+enY244RqSqq7cnPYobHnD6oWeWsce3jnu0m7Ep
 HxkqmNVx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIXRxjQ+tJnjlmflVzuu/3
 veyVdbr0ZGr82Zx9SX3P7kdtTVVs/yjw4nWSEbuV3q1TG+IM2x8sZ6wvCjvHejg5s8TW0n3/0gX
 r6hjEdh70mW1tyDf7VfP7zUnzy8Q8e/c8F+OYdeBCw5qex0kA
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
To: Phong LE <ple@baylibre.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index a2f48db369e3..51fc68ffdf8f 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1541,11 +1541,11 @@ static int it66121_hdmi_audio_mute_stream(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs it66121_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it66121_bridge_attach,
 	.atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
 	.atomic_enable = it66121_bridge_enable,
 	.atomic_disable = it66121_bridge_disable,

-- 
2.54.0

