Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30350CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9E210F586;
	Fri, 19 Jun 2026 12:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QoB3NZiD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB3310F57F
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5D3A42B5B;
 Fri, 19 Jun 2026 12:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3118F1F000E9;
 Fri, 19 Jun 2026 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871954;
 bh=t2fYW9Mj1sPf7z8zzQte52e1xAun1ZdfIfaVfw2Yq30=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QoB3NZiDx3lVWM6HToUzS2/XEvoNHURwIht9av5EqtZw70kNcbHHUkYcgrg/rsEvs
 3zQapy6vkm8WGeYnI+16LmXMJW0ZNecPzdyF5zTSYHs6feNmYlJ4DbuM9XROvY7LAo
 HauKwrJU3Lckn0Nf7RrLIu/UA0b89KzhbRvvJ+alpXqmyN20SkpSbj+D8Hk0+m+yDP
 j587bR0Un1zLXAe3DO4Z2qaez7CFYo7nGWiRP5WersClZg5jkTawBZoUYBXtUWX92P
 pRZf5JlYr1l3md6mCBG7lRmr/7JjdQTYw4uSFETAgcG1MCMmfNT6yGCB9Y1ic0TRxg
 YqWuDvCAi2zZg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:30 +0200
Subject: [PATCH v3 25/78] drm/bridge: lontium-lt9611: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-25-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wTkQZrMKtFzc+RSVSjsfKnZoXqE+SSDY6ShQsFwLzFI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJl8yE2yel+dy/dld+s//nNOTop9Xdk3ZEhpQvuepX
 seipf65HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAir08zNvzO3TvV87nD/B0P
 vNTFX6iERvl8YGtpyWP60pBZtutih/B+/ZV7Cl6/Wiw/fY7pkYCYDYx1yt9uJr7rc5vVfunLUn6
 5/XPf7jy789QCZq2M4NzSfaU2DEXnbLUK1lq4NoSduqUl96cXAA==
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
 drivers/gpu/drm/bridge/lontium-lt9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 21305296e111..b6a368f71285 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1024,11 +1024,11 @@ static const struct drm_bridge_funcs lt9611_bridge_funcs = {
 	.atomic_enable = lt9611_bridge_atomic_enable,
 	.atomic_disable = lt9611_bridge_atomic_disable,
 	.atomic_post_disable = lt9611_bridge_atomic_post_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = lt9611_atomic_get_input_bus_fmts,
 
 	.hdmi_tmds_char_rate_valid = lt9611_hdmi_tmds_char_rate_valid,
 	.hdmi_write_audio_infoframe = lt9611_hdmi_write_audio_infoframe,
 	.hdmi_clear_audio_infoframe = lt9611_hdmi_clear_audio_infoframe,

-- 
2.54.0

