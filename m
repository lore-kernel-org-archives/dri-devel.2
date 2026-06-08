Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D70CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9087E10F4C2;
	Mon,  8 Jun 2026 14:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lwWXMs09";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8436310F4C2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DC7541A84;
 Mon,  8 Jun 2026 14:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD8D1F00893;
 Mon,  8 Jun 2026 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929410;
 bh=mOwaueS9Ps5i42N8kBvUDt6vXJXniv+cfRFhpz4q70I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lwWXMs097ZSQoKn3sgM5iVrSIYzyDjLGP6sBk38rafaM/TpwoFmYPnrBS/daqrCMi
 QFYCBhaD5ShWJwqtAOJRf728U3eGmJ/QAeqYz1tB3r+AlpBU0Kp3BYh78nzZghyv5E
 5je4AWpR6bVAVnKGZedzNB/ejc3jrZtXB9jAu9f8B9lOssukCjxZr+KzYAHUHp2axv
 qk6zDMMtDhuhwWqZPpjEHkU8elO/GKtZZcE7+5t4FBrm769gGaK1ITVuenIMGbWQD4
 GRAlh8ZUu+ogPtFMc87mxcSNirP0XBP++X7zlimakG5Pa2J8uohL/a8UPiQzc0BgeA
 RQW2yw8m7wV7g==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:51 +0200
Subject: [PATCH v2 09/78] drm/bridge: analogix_dp: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-9-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6ySruIsRMgCXrxIO7Uv0w1b7gUC9HoXuIli1SFy5VLU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlz1bvN9PNPv2/0IJ65241RU9FrHdmvzLWkr1X9/9F
 vNwhXVyx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIbwnGhn+v5c/+ZLprLrXD
 v/HqmTmrKpgsDv9lCtQRXP7Q68GMkrv2uw6JHNr7Lqr8e8lsx/U2Dox1Nj6L6+bs/XuISXl3qty
 2wzOnvT18chLLDkErZvklCnaylQFvfnpLf3hk4xItNemN6yJuAA==
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
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5dc07ff84cd3..7a85774aaac1 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1221,11 +1221,11 @@ static void analogix_dp_bridge_atomic_post_disable(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable = analogix_dp_bridge_atomic_pre_enable,
 	.atomic_enable = analogix_dp_bridge_atomic_enable,
 	.atomic_disable = analogix_dp_bridge_atomic_disable,
 	.atomic_post_disable = analogix_dp_bridge_atomic_post_disable,
 	.atomic_check = analogix_dp_bridge_atomic_check,

-- 
2.54.0

