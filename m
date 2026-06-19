Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96A2CDB470
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8E310F590;
	Fri, 19 Jun 2026 12:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qq6xLGlO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859B210F58E
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D946403E6;
 Fri, 19 Jun 2026 12:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3901F000E9;
 Fri, 19 Jun 2026 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871973;
 bh=f8p1+C8f0/I2zzZ3pkr60RfB/8Ey6Z5EvIyhW82wvxE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Qq6xLGlOcQid/PYO0qkgh9QNEYShgjysoAF7U57PskorY1qVrb4xaCCMFOwYgb1ZG
 5CArpLuep2UkIzNTqz9QeMZZqPsIfca1Csvt3SeyxMVJ6kSkfGz2mQ3QH80M4ndH32
 2o6Iw0ERL5kqNid+2hOpNc5fnBXOXFtm9/2ph+uqO27I2nFS6O4lNhKPw2dPLYqABq
 3YEu/Q6xpryaf0ejQZchtzkluZUW3ZwU78sgHpBk0wJNqbjTib6yipKZqsp7qPxVdJ
 qjj7n6hVJQT6Yew6I/E+UwR8m6I04otzov8dU71gWpap1HaQ0ylWz4sRlt9XGJqotA
 rXmRCP+G8k7fw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:37 +0200
Subject: [PATCH v3 32/78] drm/bridge: ssd2825: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-32-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8RFKnEE/pkExQr982zKUsAKyOpwejb/YCG8gx9af9IE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJj8CX8/xvTYhaJdopVz+hLbEQInTnRNFZpy17ru97
 d+USXV3OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEGDQYa+Xfsm1V+CDyq8lk
 /tJz1rJ+e8+lHPPbvcCPt6lfx+2eWMJHAz/hWyJdkxaEnNF0+CbmwVinkmzH6737Lourh2IE80m
 5my9dJpzUX2uSOfnarbdtHnfnlHt+epfsrWhl0fgxI2WV+1UA
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
 drivers/gpu/drm/bridge/ssd2825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ssd2825.c
index 91f1510fc2d4..e345f3a652c2 100644
--- a/drivers/gpu/drm/bridge/ssd2825.c
+++ b/drivers/gpu/drm/bridge/ssd2825.c
@@ -678,11 +678,11 @@ static const struct drm_bridge_funcs ssd2825_bridge_funcs = {
 
 	.atomic_pre_enable = ssd2825_bridge_atomic_pre_enable,
 	.atomic_enable = ssd2825_bridge_atomic_enable,
 	.atomic_disable = ssd2825_bridge_atomic_disable,
 
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 };
 
 static const struct drm_bridge_timings default_ssd2825_timings = {

-- 
2.54.0

