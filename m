Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8089CCD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929B4112851;
	Sat, 30 May 2026 14:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N9EEsTxp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA74B112838
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DD8D600BB;
 Sat, 30 May 2026 14:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783771F00893;
 Sat, 30 May 2026 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149766;
 bh=VX9UkL/aUZ21uwDspjPLpzb+sZ2hhHYQ7zcsgltZ61s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=N9EEsTxpL17y8VQvr1xdQbvg43Zr7gDM5Vsrp7t6NE5eoBwLFIAvI4tBjAFhPHEek
 r//dVTLoXNbpmd0dcB4yxSfZ49e0aMpNYPD4UOoInyb+Rdy/jpAwVykm1RPNgayZv5
 tHtODHpxA9rboq4l9rC6UtiBtYnenyKUCrpoTY4SUALSr4xR5P80eVHfkKOiDg7Z2A
 0gwYeeOTdhD+BcdoL04ZwT2jkNIqSLVarDwRSblAa6eDnGTBuS/iR7M3VRGfybgG5S
 CJbbYpaDOUJYOBMGhxRaZDl89aa8DlAszT0hFD7+hXCUB7xf83SwKanxMPuydt0MKE
 TopbRMYPxeEyw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:09 +0200
Subject: [PATCH 64/76] drm/rockchip: lvds: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-64-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7poMGZsc4qYOmnjjpVnsIzzY2m8NXj5hxMxHLfHyq24=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSbwObzy57PvXgXyPJaLsMFYd/D+ODI/vr7ab6X73wU
 D9Rwd2xYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkxz7GOrUlc9QE54jNlnD4
 MCdEPt387z7p4Oinmv33DjBdf+T5/5Fa276PCw7Jaayy1+KJbnGayNjwh4XR4tV6x8Xvj7u3Ll2
 6o55lzxHvv3Nsv2jUJmrNc91m33tl7he35Vszp+gUZD/8d0sWAA==
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

