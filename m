Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A94CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A8E11281E;
	Sat, 30 May 2026 14:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ntqXxcjw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE834112814
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B63E04074E;
 Sat, 30 May 2026 14:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4341F00893;
 Sat, 30 May 2026 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149659;
 bh=Oac/bBAShAFqo4rVms4PQg5XhRkE9nmOlw2fpRsSDXM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ntqXxcjwcmvLCUSBtVt98D1zLbkQHHXR0QdX+YQqmJwVXCJcQGyd9cn6UkM41OVoh
 4ia15UTknfb9VAlQEmIdY/dXv2oTFOCdkG0IyLiZ32JWT7pzaYGph5G4ngT8c2bKH+
 bBwftks812sAFNF5iKZPpLO1ezvF0HrgpYV79Y+uLVh1t5+xEdODs/10rZbgQqMRwN
 y9lrQqFuxBGM8L4BPv7sbxhUDQ7ugYn2q6oCUVxLEMH/xlJWW/5fBbq983WqKi6HZR
 rD9C8OfT0dEWE87j9DenikOBOoQVLaxb0lFTmxN6UD72DvImlz1f5iraIZZq3QQ/vc
 5ZBWM9hosVLsg==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:29 +0200
Subject: [PATCH 24/76] drm/bridge: lvds-codec: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-24-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3gel0QHdW0AP23zDK9lENnzE+neWKTrJEI+M1CMeV7s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSbx08xI/Z9QU1fXkt/3OdSIuRrMTxysKilVbh///rN
 LS21cp1TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInkyTI27EqL9+uWzP/l+nnG
 9swr336LeuX/35vSHvyvN/bw8/oSRyufnPyTNavZEkMKd5bz5h5hbHgick/Ab8POGQUP5jdNy4/
 6lTqt47Pr59ILLt/sckUunpQ8oqKaKaCt951lduC85BufywA=
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
 drivers/gpu/drm/bridge/lvds-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/lvds-codec.c
index e6a7147e141b..d1135dc3b99f 100644
--- a/drivers/gpu/drm/bridge/lvds-codec.c
+++ b/drivers/gpu/drm/bridge/lvds-codec.c
@@ -102,11 +102,11 @@ static const struct drm_bridge_funcs funcs = {
 	.attach = lvds_codec_attach,
 	.enable = lvds_codec_enable,
 	.disable = lvds_codec_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = lvds_codec_atomic_get_input_bus_fmts,
 };
 
 static int lvds_codec_probe(struct platform_device *pdev)
 {

-- 
2.54.0

