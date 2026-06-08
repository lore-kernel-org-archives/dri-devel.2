Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FD7CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E7F10F4BC;
	Mon,  8 Jun 2026 14:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cnk09TdT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7497210F4BA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D532F601E2;
 Mon,  8 Jun 2026 14:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135121F00893;
 Mon,  8 Jun 2026 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929391;
 bh=0hvpE1evhKsMh/mgIlWu7AmmUrDw1Des0NsDLUTd5i4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Cnk09TdTTvrS8SMmWXZKPTtRJYCMldYuNua0gKL6DfZJnJkGMbigYiDjUVkFqrXNx
 CZiKQ8etCYUQKhWdZWN7aeki7BVLEDQmneOhn19gC9xZ9d3QXN4BDLvJkCtPVCJqZS
 +DkBlGiVAxpppHwHxKHpiQE/z87N2KOkubNg44rmah1/7/jsl2c5f2USgR9QPeFYlw
 XT+vp4WPJopzMq86ARaHramqxG+lTeT+Q6/JboTSJybeI/PT1w8+zPItNvxypx09BI
 DfW5E6tUt0wQ377Lohg0CwFr8U8HJrvzXEIN6HtGwwDXmcGEKOFr4jb1MRycvb8m3a
 QPHBwG8AByeyA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:44 +0200
Subject: [PATCH v2 02/78] drm/bridge: cdns-mhdp8546: Return an error
 pointer on allocation failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-2-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=mripard@kernel.org;
 h=from:subject:message-id; bh=eY5GR/mCqoJZCEmW4cETNiNo3KmzLory2Pq0ao2YAic=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql92M0zYt9puW4tebe+Nvem+sjlXD5e8/bq8Tn6ctH
 pd6I6ygYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkqDBjwwXha1vTRFTPNXx6
 E7ZGIWXOOemlE9t679udlxBQFra6eds3/e6SuY+msqWZSlovPCvzm7Hhmq9GicZWy8MfPn1eH2B
 oeOvKh/nHH+m43Oc1cVviMZtJ5riR8K1vu1c9+Vn0rpxjp/kMAA==
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

The drm_bridge_funcs.atomic_reset documentation states that the hook
must return either a valid drm_bridge_state object or an ERR_PTR().

The cdns_mhdp_bridge_atomic_reset() callback returns NULL when the
allocation of its state fails, violating this contract.

Return ERR_PTR(-ENOMEM) instead.

Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 36c07b71fe04..46779b49545b 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1925,11 +1925,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_bridge_state *cdns_mhdp_state;
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	__drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
 
 	return &cdns_mhdp_state->base;
 }

-- 
2.54.0

