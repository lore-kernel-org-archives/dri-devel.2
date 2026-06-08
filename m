Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3171CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2048E10F50B;
	Mon,  8 Jun 2026 14:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MEGUBPrU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF55610F50B
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:39:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE61A40A0E;
 Mon,  8 Jun 2026 14:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217F61F0089B;
 Mon,  8 Jun 2026 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929563;
 bh=m+e14BDat+MUjEfuuLwU2YmrZXyOKxN5Zuv/P5Bg+9k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MEGUBPrUEyq75kUQv9n9rw9t69ZBK4r2qUneM42o6P5Pm83ajbNge8U5uBrtPNJlH
 d31XLL+iVFTes2gwd1TgWMC5rzrA/vmjjsdQChA/y406Sl/d21kCs1+ijPlz3/fSPz
 Sh64DAAFYw6S7pQoPscM2ZjciCBkhEBAze2V87fSfAgTE6jYTEopk6r2p3SSkJp0ac
 znyPgeR9jv9pfmrXp1+k5KuED09Ynq4An1+o1STxkvY7FupyZj6QV393xXMp2TEWgr
 wIfeZEOwPrtsogs2TE23ipO/5zjU07ZJCMUA18jrxtj9tdrIR+JrevkLpFi/y3oBfg
 Xou/X2OOsbGeg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:48 +0200
Subject: [PATCH v2 66/78] drm/rockchip: lvds: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-66-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TdGEn/Nph6zclvRJJyS70UnRjDHuOTWgKeHyi9X/fKE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql5NCZFuuhP8RDjry+0Cs9jN9Jok7QnUOBiZHk5aaN
 DQ67pPsmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABP5aMnYcOfMl/6r9fJc7GyX
 jD7wS16ctYBl97R9WnovOTl2aK26Z8it0LX/SLPd9tjdFvKv+fPMGRs+zTmj4HQz6+GP9FAzp/J
 I1wsTVJY4fg7h1BHwmjrLemHaoVO+hq0T3ObFW2snMETeMwcA
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

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Sandy Huang <hjc@rock-chips.com>
To: "Heiko Stübner" <heiko@sntech.de>
To: Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 7a0c4fa29f2f..31dc206bedeb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -117,11 +117,11 @@ rockchip_lvds_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *
 
 static const
 struct drm_bridge_funcs rockchip_lvds_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.get_modes = rockchip_lvds_bridge_get_modes,
 };
 
 static int
 rockchip_lvds_encoder_atomic_check(struct drm_encoder *encoder,

-- 
2.54.0

