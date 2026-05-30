Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF09BCD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C8D11284A;
	Sat, 30 May 2026 14:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TyoC/hx0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2456611285A
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05743408DF;
 Sat, 30 May 2026 14:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623641F00899;
 Sat, 30 May 2026 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149742;
 bh=ORKbvzkBH7vipfbQteDD6hoL6cgm9EIt4hjoCQhXZ+k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TyoC/hx0rN5aKN8Lysnn7cQ/sCHrW9ch5wuIcf0ne3LofNj0lH4UDm6YdfaMrC7Pr
 HWhPB0Yzocpf0mXfRAjlLDIC84Na+8gpkQ058XVZbqetXv5dKC36PzkTsNzduCK9qu
 dWQaUxiuscWG0tNgIRh5b6QtEO8qd7uuWn59tZJH/LP0Y4FbpORsjAK9gCaA/k2JGs
 SxLMfakvzKjYfTO98RzvnFoO5DdTdyt1/oDdhc3Kllq6OSiqupKCa+diJjZqVyx2ky
 QHGSeH9CvQn0/rgQrPA/DcJc5EMlBxcFM/A+mk56IdOj62cD7BkIXAj4KFjgvIboVy
 gqsUiNEvphHRA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:00 +0200
Subject: [PATCH 55/76] drm/msm: dp: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-55-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1985; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2pC9TWeT1Qjt83trSHSmk1KHBiCvKQPFL+Jp+Us8a8Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb32FM8trq5oirq5Yd33697z1kwyuXVvU21fjta6yZ
 +2bFomajqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRU/sZ65MLzma+3J5uIrz6
 6yKmDJ2qBu7bfVX1hqJiYUapvM+msU6RUm2w9RNZ8PztzFAWtTl3GOsTWPQL38QfKmwSmvlQoVe
 zJcdS7bPR+YRlzEIxTpyLfp7qdZ2eat6vZyTw/JHRdLE1FwA=
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
 drivers/gpu/drm/msm/dp/dp_drm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 349175457566..d69b4d56dd0e 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -102,11 +102,11 @@ static void msm_dp_bridge_debugfs_init(struct drm_bridge *bridge, struct dentry
 }
 
 static const struct drm_bridge_funcs msm_dp_bridge_ops = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset           = drm_atomic_helper_bridge_reset,
+	.atomic_create_state           = drm_atomic_helper_bridge_create_state,
 	.atomic_enable          = msm_dp_bridge_atomic_enable,
 	.atomic_disable         = msm_dp_bridge_atomic_disable,
 	.atomic_post_disable    = msm_dp_bridge_atomic_post_disable,
 	.mode_set     = msm_dp_bridge_mode_set,
 	.mode_valid   = msm_dp_bridge_mode_valid,
@@ -286,11 +286,11 @@ static const struct drm_bridge_funcs msm_edp_bridge_ops = {
 	.atomic_enable = msm_edp_bridge_atomic_enable,
 	.atomic_disable = msm_edp_bridge_atomic_disable,
 	.atomic_post_disable = msm_edp_bridge_atomic_post_disable,
 	.mode_set = msm_dp_bridge_mode_set,
 	.mode_valid = msm_edp_bridge_mode_valid,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_check = msm_edp_bridge_atomic_check,
 	.debugfs_init = msm_edp_bridge_debugfs_init,
 };

-- 
2.54.0

