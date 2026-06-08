Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B4BCD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3CD10F4C0;
	Mon,  8 Jun 2026 14:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aLYZcSR3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D0510F4C2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB18141868;
 Mon,  8 Jun 2026 14:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255241F00898;
 Mon,  8 Jun 2026 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929407;
 bh=PoIEuMMpahjDD7I1sr/KG+eFE/sQcE3ph0n4a6zxr+g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aLYZcSR3bydXzZ7oFBSPWjzhxijRMyLULxBQ0W9Hj9imeoA4W0VsOJNtcsWGK9V8+
 zc4jOx9QcHZ2OXM1oRJzpBQEX/6XOlewmjSoYB+VBBs1X9L4OQbO9XmbqRCWxbZPe2
 5vXlfLPdvClfquIES3Qd/bqWHQ1zQKaDRKloqGB0qFfcB9pJPn0t7DqErqtGgTVCEN
 ShX1a+KOArnpMFpflpa8G1PghbaUcYlFmX+NsOpZHXSU3bMRXawDL1APV2QdhSwydr
 KqACsCcHtMVgDMj8/LgZ85u1sWPR69a6KMpTvUr5eDi/qJ7Xk58JTHBRr7hY104W0/
 hnGT6XZGJY1IA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:50 +0200
Subject: [PATCH v2 08/78] drm/bridge: adv7511: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-8-0a91018bf886@kernel.org>
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=mripard@kernel.org;
 h=from:subject:message-id; bh=a2yzrl5/fZSisrEFtoDg7BuSSseoAD8P/TrazQGmBa0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlz1kZCJrZuvGzI3+eOyLddW+o69ecC+9c2ujUFLkl
 KmuWQsYO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEvmoy1pm8MRP7unKL4grm
 DY1Re7WX6c/wrjOKlwm72p7Y5rJoXeWpusu2dctkl72bOusn7yeWU4z1Ts9/7ZGa9zNE4SZbiNW
 d+Iz5TwXq78SrRO7y26e91rDU6KnF9+eWYvV/v756dkNR+LM/AA==
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

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 02f8f7e78a16..db99e252aeeb 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1002,11 +1002,11 @@ static const struct drm_bridge_funcs adv7511_bridge_funcs = {
 
 	.atomic_enable = adv7511_bridge_atomic_enable,
 	.atomic_disable = adv7511_bridge_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 
 	.hdmi_tmds_char_rate_valid = adv7511_bridge_hdmi_tmds_char_rate_valid,
 	.hdmi_clear_audio_infoframe = adv7511_bridge_hdmi_clear_audio_infoframe,
 	.hdmi_write_audio_infoframe = adv7511_bridge_hdmi_write_audio_infoframe,
 	.hdmi_clear_avi_infoframe = adv7511_bridge_hdmi_clear_avi_infoframe,

-- 
2.54.0

