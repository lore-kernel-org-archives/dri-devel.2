Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87C8CD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 18:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC45110E7F3;
	Mon,  4 May 2026 18:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JP5VsES8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A34A10E7EF
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777919073;
 bh=CrUMD80L0tPh/ReWZWhyFAP6sKoT7Ci2SErvfpP/5Yw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JP5VsES8QC1489VuseSPugmyxnxbDiuYlt8+kzwVkBDDylqpXKJusT9MIQh5C1sMG
 y3E83asCjPuVmbkyDC2EjGW/npf9cwyZ4bfqf3S+XwcU40F55chYjBX3eg7quNLeVl
 wV2eZ9wtDrpTTc6RmF094up8hDhZP+kHwe1QcjXZ6TDXzpCD+Eduno4ZlQJ9Jivh68
 cNReNQaFZaZEvD5EWv/V15iriP/1qxDfCYIWDR8IVphwDyFFe67Hb19CSKEpv3Gsax
 POgzyFY7MWM672rRs87w2g0v5dRz0OAFNeWz6fVu4Yry6Lv0/WNOp1pTgj5M3vAIJd
 BTsCn7Man/5ow==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B448717E1544;
 Mon,  4 May 2026 20:24:33 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 04 May 2026 21:24:01 +0300
Subject: [PATCH 3/5] drm/rockchip: vop2: Delay old_{layer|port}_sel updates
 in setup_layer_mixer()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-vop2-layer-cfg-tmout-v1-3-730226a7331e@collabora.com>
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

The old_layer_sel and old_port_sel local variables were introduced to
hold the previous VP configuration for comparisons and wait targets,
working around the premature update of vop2->old_layer_sel and
vop2->old_port_sel earlier in the function.

Remove these superfluous locals and instead defer the assignments of
vop2->old_layer_sel and vop2->old_port_sel to just before the
corresponding shadow register writes, where the transition from old to
new logically belongs.

No functional change intended.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 5206f01ec787..1f5e8c2acecd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2136,9 +2136,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct drm_plane *plane;
 	u32 layer_sel = 0;
 	u32 port_sel;
-	u32 old_layer_sel = 0;
 	u32 atv_layer_sel = 0;
-	u32 old_port_sel = 0;
 	u8 layer_id;
 	u8 old_layer_id;
 	u8 layer_sel_id;
@@ -2161,8 +2159,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	else
 		ovl_ctrl &= ~RK3568_OVL_CTRL__YUV_MODE(vp->id);
 
-	old_port_sel = vop2->old_port_sel;
-	port_sel = old_port_sel;
+	port_sel = vop2->old_port_sel;
 	port_sel &= RK3568_OVL_PORT_SEL__SEL_PORT;
 
 	if (vp0->nlayers)
@@ -2188,8 +2185,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		port_sel |= FIELD_PREP(RK3588_OVL_PORT_SET__PORT3_MUX, 7);
 
 	atv_layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
-	old_layer_sel = vop2->old_layer_sel;
-	layer_sel = old_layer_sel;
+	layer_sel = vop2->old_layer_sel;
 
 	ofs = 0;
 	for (i = 0; i < vp->id; i++)
@@ -2273,8 +2269,6 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 			     old_win->data->layer_sel_id[vp->id]);
 	}
 
-	vop2->old_layer_sel = layer_sel;
-	vop2->old_port_sel = port_sel;
 	/*
 	 * As the RK3568_OVL_LAYER_SEL and RK3568_OVL_PORT_SEL are shared by all Video Ports,
 	 * and the configuration take effect by one Video Port's vsync.
@@ -2290,7 +2284,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	 *    of the new VP.
 	 */
 
-	if (layer_sel != old_layer_sel && atv_layer_sel != old_layer_sel) {
+	if (layer_sel != vop2->old_layer_sel && atv_layer_sel != vop2->old_layer_sel) {
 		cfg_done = vop2_readl(vop2, RK3568_REG_CFG_DONE);
 		cfg_done &= (BIT(vop2->data->nr_vps) - 1);
 		cfg_done &= ~BIT(vp->id);
@@ -2298,20 +2292,23 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		 * Changes of other VPs' overlays have not taken effect
 		 */
 		if (cfg_done)
-			rk3568_vop2_wait_for_layer_cfg_done(vop2, old_layer_sel);
+			rk3568_vop2_wait_for_layer_cfg_done(vop2, vop2->old_layer_sel);
 	}
 
-	if (layer_sel != old_layer_sel || port_sel != old_port_sel)
+	if (layer_sel != vop2->old_layer_sel || port_sel != vop2->old_port_sel)
 		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
 	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
 
-	if (port_sel != old_port_sel) {
+	if (port_sel != vop2->old_port_sel) {
+		vop2->old_port_sel = port_sel;
 		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
 		vop2_cfg_done(vp);
 		rk3568_vop2_wait_for_port_mux_done(vop2);
 	}
 
+	vop2->old_layer_sel = layer_sel;
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
+
 	mutex_unlock(&vop2->ovl_lock);
 }
 

-- 
2.53.0

