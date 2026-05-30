Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C26CD6E57
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57354112845;
	Sat, 30 May 2026 14:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bphkh3Z6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B96A112838
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95FCE600CB;
 Sat, 30 May 2026 14:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC0E1F00893;
 Sat, 30 May 2026 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149764;
 bh=GNl9FOy9Ix19VA8ulFghHHdbCugAk+tj+Vcor/u18O0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bphkh3Z6y4f+U7pqrYgA5zVNul8eOAyYvmmaLyZXvHQp+p6CSgjRanXxw31qGM+zx
 /cxquDGqy84x+yqjiquAakrcWM3N/VGSI6/DU6KMykaVPd8utr/6dxN9n+Q2u4KXo7
 1qbsMRbRLhGoWMlbh4MrkAL/a564fM4jyuaG7X0i+8v4FsLLqtsx8NBH2U9pxCVRdo
 oXVBlg40Z36G46z0pXvIndyV5lwEOT4bYcXuXnsjUXtX/0yRAfSRh7FcytsiKmvVMX
 kyV0MQxQLnZBdwx/2HFG77TrD8WBLRziV+qFvFnmIi5UJf+TvHkqj5082WRsLO4kch
 luOaQcooTKXSg==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:08 +0200
Subject: [PATCH 63/76] drm/rockchip: rk3066_hdmi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-63-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=mripard@kernel.org;
 h=from:subject:message-id; bh=RpRLFH4wlWNiMYLwvBRpsy60KmT6bRKyF+DLn9QpabU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSbwOn/Ji6RWL2gcYcm+zbH7fNij+t4bundgbbjRKdu
 Kvf1O+WdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJqK5grHdQ41x/wObUB37V
 VM1l3Y18Hn3/Ts63fW4yVeKWr+78nMYohhmsWQuD3ydoSKy4YOFTxtiwWGZylcu2C4LmVmbajdu
 21nm5K5oufb3g7zLdlLPxjEV7dBmXPjxsa2GwyoQ/Y5n1RD4A
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
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 1996f8656612..9b8981fa19ae 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -495,11 +495,11 @@ rk3066_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs rk3066_hdmi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = rk3066_hdmi_bridge_atomic_enable,
 	.atomic_disable = rk3066_hdmi_bridge_atomic_disable,
 	.detect = rk3066_hdmi_bridge_detect,
 	.edid_read = rk3066_hdmi_bridge_edid_read,
 	.hdmi_clear_avi_infoframe = rk3066_hdmi_bridge_clear_avi_infoframe,

-- 
2.54.0

