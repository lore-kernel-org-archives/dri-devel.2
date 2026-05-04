Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B39FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 18:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFBA110E7F6;
	Mon,  4 May 2026 18:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="B/09ckXK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73F410E7F2
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777919075;
 bh=jHuSqMydnxiUHThU8cOES4vmkolWOAEvO+AN9naJXTY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=B/09ckXKQzf514XPJzFyIS/PKyLlXbepjl2xTrXGkkHHYMpE4F7AHWq97nKrUrxfW
 iSihq+CPx6i1tIWvXrI5os7Q3U0NxwmmQpPZJOIvEx/aehD4ofPVpzgvPHPka/r/qR
 lkW6QSpfW+3LWDOF7eQH/Ix2qF2b+hbYYHTDaJR2py4+JZcg6LzrRLPoCjxR7+fheW
 EshtPwH8zVszmo1gahnwHZcmkzIFVM2GxM1hoNYf+tfmBr2nP877lwiHEd2jcElQ7b
 4urbsWKZ8UmLt6UtTnocb9I3ZO0uvYFGgMVz3+2MIwMeyFY6JqxHFx23UDdiGmI0Nl
 +ImcDG8l8v3lw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B70117E1582;
 Mon,  4 May 2026 20:24:35 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 04 May 2026 21:24:03 +0300
Subject: [PATCH 5/5] drm/rockchip: vop2: Use vop2->old_layer_sel directly
 in wait_for_layer_cfg_done()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-vop2-layer-cfg-tmout-v1-5-730226a7331e@collabora.com>
References: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
In-Reply-To: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
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

After the old_layer_sel local was removed, the only caller of
rk3568_vop2_wait_for_layer_cfg_done() already passes vop2->old_layer_sel
as the expected value.

Drop the redundant parameter and read the member directly inside the
function.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 0849bd922ffb..1d8473a6dfd1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2115,7 +2115,7 @@ static u32 rk3568_vop2_read_layer_cfg(struct vop2 *vop2)
 	return vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
 }
 
-static void rk3568_vop2_wait_for_layer_cfg_done(struct vop2 *vop2, u32 cfg)
+static void rk3568_vop2_wait_for_layer_cfg_done(struct vop2 *vop2)
 {
 	u32 atv_layer_cfg;
 	int ret;
@@ -2124,10 +2124,10 @@ static void rk3568_vop2_wait_for_layer_cfg_done(struct vop2 *vop2, u32 cfg)
 	 * Spin until the previous layer configuration is done.
 	 */
 	ret = readx_poll_timeout_atomic(rk3568_vop2_read_layer_cfg, vop2, atv_layer_cfg,
-					atv_layer_cfg == cfg, 10, 50 * 1000);
+					atv_layer_cfg == vop2->old_layer_sel, 10, 50 * 1000);
 	if (ret)
 		drm_err_ratelimited(vop2->drm, "wait layer cfg done timeout: 0x%x--0x%x\n",
-				    atv_layer_cfg, cfg);
+				    atv_layer_cfg, vop2->old_layer_sel);
 }
 
 static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
@@ -2292,7 +2292,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		 * Changes of other VPs' overlays have not taken effect
 		 */
 		if (cfg_done)
-			rk3568_vop2_wait_for_layer_cfg_done(vop2, vop2->old_layer_sel);
+			rk3568_vop2_wait_for_layer_cfg_done(vop2);
 	}
 
 	if (layer_sel != vop2->old_layer_sel || port_sel != vop2->old_port_sel)

-- 
2.53.0

