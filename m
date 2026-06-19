Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D14CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B82C10F57E;
	Fri, 19 Jun 2026 12:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iT88YGGI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDA410F57F
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A23F1601E2;
 Fri, 19 Jun 2026 12:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45EC1F000E9;
 Fri, 19 Jun 2026 12:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871957;
 bh=DeWx6iN02e4OqMXFbAdpakSsh29OPp+j7bdDMgNLaAg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iT88YGGIw8ct8kB81vHLLiJBN/G5gCXitj/9TjlLyXV80zv961Tyj4jwSl6YClnck
 XNLAEy6C5zRenokxNelcz8uTYncTQ0UFw5XTb8tv0wil8zUBtXgmcZ/6h7FidJnpbB
 7fm9FMvjIFFdrm2WBY5mGF4i+oiw3vxF03I74UJsxT44pNhlUN1rCYW3xK/4/ImfYB
 AKbP+H12ePfbM3xUZt1xGQbJtaoI5b1mBogIw168ALkDNmWzz2KvlgK2AkA1vCI6dj
 nVkS8Tf7vk0lMyi0FUL6SKWx9mV6jHq8+HCMg3OSkMfQndhyCLdUHAar/UnMXqqoxl
 2HtudRk+Crd0Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:31 +0200
Subject: [PATCH v3 26/78] drm/bridge: lvds-codec: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-26-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pbKNRIay9gU1cIZ9OwGTdkcKNFhu5slRM1DNhbZHOks=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJl/5be1miOz3zDt3oUdXPypsSWAIk46G3CVOJf/9h
 /ZkdS3rmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABM5pMDYsJXp1Dy7q5damo7L
 /ryR33d6Df/P22raXYft1lf/z8wXNrS9LBYy/fD1ArP7D5bX5Wf0MTZsu+a/evF9y5138lNmqjJ
 nx7Jy2H6I5bX5W7zMwzjP7bb8jyrzqL3fs+4KMTXnzV4wWwcA
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

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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

