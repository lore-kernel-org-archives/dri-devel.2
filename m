Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F250FCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5884A10F4B9;
	Mon,  8 Jun 2026 14:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RtzonWDs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2530810F4B9
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 046074366D;
 Mon,  8 Jun 2026 14:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C6C1F00893;
 Mon,  8 Jun 2026 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929388;
 bh=bNsCm+/xC4Aj5xB/FewRlUKJ1BaMITKmRhMkg2BghYs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RtzonWDsuj0y6bdid7BLNMXhzkU1xAnxjNOU6vpynGCFJ7F8aEvxWroPSz1rDYkUw
 VIq3U6OBaqt0JIKkF44lzrolXKcnfhRYxCYWXMvukDGhjbE9vlHRk0q56BeDyXMQNR
 1RkXXg1Xg67hE07Rf7Bn8AyXvU4N8yfTYnyZxYLhvwlHQHNxdG3wmHNu+0UbkhYfMk
 6PKZhnqjIdBgaZZ5/0au8/FQUACnljU5V4nfmqiNHr/f2+hqG+UORUmsl3MOFMshUj
 uV3FRBt69D6c6Q43IiP5Yck7HYxBQMuqYNC8b+h1FKu9kJPtoTB8uYv2AGobY0kDHq
 Oyc+iRPeXYDzg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:43 +0200
Subject: [PATCH v2 01/78] drm/bridge: cdns-dsi: Return an error pointer on
 allocation failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-1-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yMGoYrIvk1wJop8Gd/Jlq9klSvR0CkOx2QGdhhavJgc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql11bE99x+nG0XxRkaTLU5yg08ujjCakPlP7RbnasX
 /CYvl7HVBYGYU4GWTFFlicyYaeXty+ucrBf+QNmDisTyBAGLk4BmIhDIGPDp7ZvLekXfI0qLqSV
 x7XMXR+1amf8tALRFxniBnlNi9ys9t9/dKvZYlu+Rs3zuTJZW0sZ6xT3nlReLL2vRFDnSs0Cne9
 ZLV56Hn0X3iXEbuXT2LXgks3sGiZZ22CvY6//sE9YV+6xFQA=
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

The cdns_dsi_bridge_atomic_reset() callback returns NULL when the
allocation of its state fails, violating this contract.

Return ERR_PTR(-ENOMEM) instead.

Fixes: a53d987756ea ("drm/bridge: cdns-dsi: Move DSI mode check to _atomic_check()")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index cf90d4468b5c..344c3f466018 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1013,11 +1013,11 @@ cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
 {
 	struct cdns_dsi_bridge_state *dsi_state;
 
 	dsi_state = kzalloc_obj(*dsi_state);
 	if (!dsi_state)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	memset(dsi_state, 0, sizeof(*dsi_state));
 	dsi_state->base.bridge = bridge;
 
 	return &dsi_state->base;

-- 
2.54.0

