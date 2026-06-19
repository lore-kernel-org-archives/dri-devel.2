Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39466CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C998D10F5A6;
	Fri, 19 Jun 2026 12:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QFup2xj+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE7010F5A1
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:27:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A677A43CFB;
 Fri, 19 Jun 2026 12:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CD31F00AC4;
 Fri, 19 Jun 2026 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872040;
 bh=VjvT61KEh3/5Hv2ssdDBCGmeEvNcEmk+5D3Ndph4JAY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QFup2xj+PFI9nWctXMJxoXyBa7KK1JF5U0B87ZGN7F/MDVXnxq5SvJxl0ek+5Xy8l
 6g7ofKKqrptb6EhI2I2fnG8/oigIPwNafVbsHX/n+jcGbWXvtkZD3Bt3SJjJCGaU1V
 HiGgKh74XeuIqyd3PUiiCfmbKQIbFQWnf1XKdBTAMAoJP7ky6YBhwEOpkccUZphcc0
 dtOSDHmQzXLkkNZzuEI6KcMkvN63swONK8eAKFYOCSpkygafJ6bLZXrQbCQ2Ba5f5t
 TRDiGmlgtADfiZJRYC7bqp4hivondRp8zPEtLb4N8k8hZbXvSqEqmb3AtvKY7HrBYt
 uJNsycAb4b+Yw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:02 +0200
Subject: [PATCH v3 57/78] drm/msm: dp: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-57-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sbCoB8iZTRiwBPh6oaQosd5p3viSJt5pjZLIkzwc950=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmpsyfXlzY4i62coXQdbczDfY3Qx9L/W0sL72lF3PR9
 1BCxb2ijqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRekvGKmbVppxt9/Z1r9kT
 ujHli8XGZ9P7Z040uLtJOfPgvke3di6KVK6baJFW3nbb7L4lR/P0HMaGR8f3uNa+bHz+6mD3ZZE
 FkSvK77/UDF4c3P7m9I8nm4+bMncW3HBaF38gNPekjknJLM9WAA==
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

