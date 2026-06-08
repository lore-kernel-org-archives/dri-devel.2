Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41646CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8443910F4D1;
	Mon,  8 Jun 2026 14:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WI3g6rFi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4072C10F4D1
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:37:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B81C6601F8;
 Mon,  8 Jun 2026 14:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ADE1F0089A;
 Mon,  8 Jun 2026 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929448;
 bh=kFUiACoV7rCN63sJwqoS2zZ7ZfifSAI+YSKuNeX8RuM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WI3g6rFi6U/bu2qNOv6bE3K1Dax7OW5vhiw2eiz7kMzcvYtb5Gvpy5TnKvYuYeGn0
 k/J2reDJSPEVRt7BdFIXDBD4xUdSEDS15QT8+jhDWCp/bbO5Z/ZDbwWOwf/luhyXaZ
 FISRKx4YSIxyjTfEgJYv0GvusYCkjItBut9j+Pie701ZvwxzhwrDIZ8l5zK5D2nvBE
 7z7MURTk6l0h1+tCjMShEHbp+zbJMM9tjV0UeHo4w14dntM+BQJfp9xCBzWc6/Zozc
 f13S2qkmxg7ZkWzEEDS00j/8oe/t9ASOYoqAMtM2Q31sLLPr6K+zjo5kBD44lCaGmX
 NDMBp/JiLOEzg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:05 +0200
Subject: [PATCH v2 23/78] drm/bridge: ite-it66121: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-23-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Phong LE <ple@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SXoDxVYA59lx1NBfqxTTNFJlRyW47LXrUPRgVnUcdVg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql/37DNwt15Xc6WKOXOM+Y6JI/1Qlww2Ci/j9HBI6O
 ovafNo6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwET2/mWs95qrHPglNFfZ1rnj
 4SH3mkWfF9ZNm/ZxSn5ijooni+R0G6uQyae21c5tT93rcvT3mbA3jA2/5vT7XDYLOLjr3rqT/v/
 3fOxK9znZw/U86dStMyGpbCu/75r+o/qXr81j6Y4fa1X/rK4FAA==
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
To: Phong LE <ple@baylibre.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index a2f48db369e3..51fc68ffdf8f 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1541,11 +1541,11 @@ static int it66121_hdmi_audio_mute_stream(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs it66121_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it66121_bridge_attach,
 	.atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
 	.atomic_enable = it66121_bridge_enable,
 	.atomic_disable = it66121_bridge_disable,

-- 
2.54.0

