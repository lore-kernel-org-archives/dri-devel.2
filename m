Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87563CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D0A10F4F7;
	Mon,  8 Jun 2026 14:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NsmDEif6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B2710F4FB
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD42C43AEE;
 Mon,  8 Jun 2026 14:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198F41F00898;
 Mon,  8 Jun 2026 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929539;
 bh=VjvT61KEh3/5Hv2ssdDBCGmeEvNcEmk+5D3Ndph4JAY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NsmDEif6hq7qH3vnxmSh1x3ZQG3+2KpuYXUO1MYM46S53f5xEGQMEIgHNBYo/lCHi
 bxJId5dhj36bpaJqPC/QEF9vIquo159lSMsvP63YvuF4bC3nQq9ZCMQm0/I+z5Ousv
 2/+t8B2sM29DJUgtvyRVNFM/DA4OCLdKMX1k3opJVyx2HiINUlLo0Xu4G43rpTeWbs
 yE6rYs7HFs2fa6MgtHbuMQShR8fsT31NYi/RXx/nEF3k075kRo3K6zPz1PFNX5zSnG
 vajCjySOmUFfPenOM6D6Ru9p6CQmA57PnuHiwDgvJmPM4QOPYtR5uKZKRa+Tkt4MHq
 vc2DRSkc/5/sw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:39 +0200
Subject: [PATCH v2 57/78] drm/msm: dp: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-57-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sbCoB8iZTRiwBPh6oaQosd5p3viSJt5pjZLIkzwc950=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql+MOVjoayh09elFqdoaGQMf1ypu3135tDt3j1Ly0X
 1j10P76jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRnEOMDSe+N3+rC4r8KON6
 LTGB1+DIq1tr2rewbra6ci5GKHqmxfyJjZ4b+p5/yBEoXmrgFeXYwlhn/GjhwaJ/f213K98vurO
 6InF76O6mb0+upyTZSyhrFhz6sDU71nxikML9Sq33DP+WfSoDAA==
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

