Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB42CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C52610F4E7;
	Mon,  8 Jun 2026 14:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kHpJe+00";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 189AA10F4E7
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 006B840AD2;
 Mon,  8 Jun 2026 14:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD4C1F00893;
 Mon,  8 Jun 2026 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929488;
 bh=iH0Zf7SoqE67oHfGQyry5Zqy/me26I0DDgCKx3pekvw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kHpJe+00NMWdoqpKEogNNnmJXE1WqFbNy15dL4Zn0+6beZ0KGw/6n3/HYqj81XD+a
 bn3hb4iDsqMoYvzFm4qFidzNogT7Rot5Nqo8p/N/Ibl3GkUKbK+OU7uzMwY54d18Yr
 ZbDa+ytZsbbQ5ghmCQN/anAq31Vh4Z+9F22CXPqhcNvTYQbFtYHCsd/Z29mowhQ5gD
 2xTD2ZMNXvUyqPpUI8Jidje5YuTEHP94X/2khVHAGH1fv7eQpVFRwKf/n1I2p7s0IA
 SZNqV+L3dqLwKLAzhiMtt0B+vwUIgxHeTbJfPl8AW2BLoTIlqJQna5p0VuOVupiMHd
 oY8BN/uNBpyIA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:20 +0200
Subject: [PATCH v2 38/78] drm/bridge: tc358762: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-38-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uIH1Vsiy/PIP8FdkgwM3Hl+3+xdT6qOEjmmMqnPw6gw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql0PfeJopLGXN065vCfKMVl6/rJPtxY8/DxvXGWu/3
 L+weP7KjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARnhOMDSfnyMd9eTDtclJL
 xvvtx1r9O5LCrWZyZGo53Uzq9uCJ47+9b544o3JxyIwZLRs/P5aqYKyV3bNslf4LTg0PueR/mv/
 1zwhpLz1g4b34g7X9rxumPkYbH2o8XaYgJHzgneFxpWt7Pj0AAA==
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
 drivers/gpu/drm/bridge/tc358762.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 3d75d9cfa45e..4f9943b0223e 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -224,11 +224,11 @@ static const struct drm_bridge_funcs tc358762_bridge_funcs = {
 	.atomic_post_disable = tc358762_post_disable,
 	.atomic_pre_enable = tc358762_pre_enable,
 	.atomic_enable = tc358762_enable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = tc358762_attach,
 	.mode_set = tc358762_bridge_mode_set,
 };
 
 static int tc358762_parse_dt(struct tc358762 *ctx)

-- 
2.54.0

