Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA561CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F4510F503;
	Mon,  8 Jun 2026 14:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YDJjC9eo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D003810F503
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:39:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA2F543AEE;
 Mon,  8 Jun 2026 14:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252D41F00893;
 Mon,  8 Jun 2026 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929547;
 bh=cUS+NhU1EbhxpOlvdMT8nK/779tKHewjcc5rPGYe0bM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YDJjC9eoSSWQ10M3tYu7BFRo+TU/hIaXJpQTXKuU+jwMgqG6wqqP9md4AhuH4U2i/
 rCVizWpPGt6Ic96QDi/5x/8rqZrca3mkOD9UQqOIJ7R5nSzUeV6VNYlugGn+8t+/to
 8G/DbAMRxWQrnFDMTwiD7qkS2hY5aAs5vQIfWOoQ7dNlmbC8vnr7PMJ3lQr0c8U/kn
 vIdHtqdPHHjY+pzMBMKqloroxZA20eqYUY2BBtT6TZQQabWUhbEcC47ZJpwDHRcWY0
 I5KTZUynN31FwY6n5tXdRD+ge3X1W0Ws2LlkvBtPWM2hyKs1WqdN+S7tGRcHy7/xue
 iNzNqDq3ZNVbQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:42 +0200
Subject: [PATCH v2 60/78] drm/omap: hdmi5: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-60-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rjsigK9rWC8v2xjOsFlTU9vVQXFHXuvYh9CGx/Ps75I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql+N/37GV7dy5RUz+p2I2T8vWWtVee9PcO26paetZJ
 QOsFB92TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInc4GGsFUsxT7CytOm6mJX8
 LGVTfvfEKnPug4H7Gm/t9/j3+gDvM/WQuiUCKwXl9jqKHJxluvwxY31BSZle2gV/1R7HPTkaIas
 cz6UdWWOz2Ltiw/y2W1JPlriaMnO+U/RrMeB+e2W/Ss3ZEgA=
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
 drivers/gpu/drm/omapdrm/dss/hdmi5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index ab2d4eb6787f..1ee3bbe20583 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -470,11 +470,11 @@ static const struct drm_edid *hdmi5_bridge_edid_read(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs hdmi5_bridge_funcs = {
 	.attach = hdmi5_bridge_attach,
 	.mode_set = hdmi5_bridge_mode_set,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = hdmi5_bridge_enable,
 	.atomic_disable = hdmi5_bridge_disable,
 	.edid_read = hdmi5_bridge_edid_read,
 };
 

-- 
2.54.0

