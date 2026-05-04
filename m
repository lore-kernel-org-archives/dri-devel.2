Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8C6FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 18:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB6210E7EF;
	Mon,  4 May 2026 18:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XNoP1Bg6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F19C10E7EF
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777919073;
 bh=jm/lt6k4t2SfRczOWUuIy+qaUOxXJRsGSdhhtyXdzA4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XNoP1Bg6q4Sg+qqaqAh2bxRigOTIw0IeoavObVSWfih7ku0MbgGJBl7yoITM4n9zA
 k1/NcadjVIg1+B6fg6oTuYkWuDNFPcrQw8LLVKcmklCq8azji3PjTNODZqE748afU2
 tulqTHi4bnsPMSueuPzim+Iny9hVRfdNAqKIPVopcDbkFvm7fQuGBGTmSavTpzLp5R
 cbj874WmAhEkKFM3MNRsKTGc/I4pg0iQ8LjpU/2FIjK+3LIDofi4u/d7g7Wj3QDp66
 q9F6W1mfNKG6FxxkMuWqEBFwfOJV7Qt9HYHUTqQCZQSFvAk0ei1D6wLq3AkdKStnIC
 M1dwO0WzigYIA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DE42517E1525;
 Mon,  4 May 2026 20:24:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 04 May 2026 21:24:00 +0300
Subject: [PATCH 2/5] drm/rockchip: vop2: Wait for layer cfg done before
 switching LAYERSEL_REGDONE_SEL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-vop2-layer-cfg-tmout-v1-2-730226a7331e@collabora.com>
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

LAYERSEL_REGDONE_SEL mask of RK3568_OVL_CTRL register controls which
Video Port (VP) vsync latches the shared RK3568_OVL_{LAYER|PORT}_SEL
shadow registers into the active configuration.

rk3568_vop2_setup_layer_mixer() overwrites LAYERSEL_REGDONE_SEL to the
current VP ID before waiting for the previous VP layer configuration to
take effect.  As a consequence, the previous VP vsync can no longer
trigger the latch, so the wait polls a value that might never appear.

Move the layer cfg done wait before the RK3568_OVL_CTRL write so the
previous VP vsync can still commit the pending configuration.

Fixes: 3e89a8c68354 ("drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index edca0fb16e08..5206f01ec787 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2289,15 +2289,6 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	 *    lead to the configuration of the previous VP being take effect along with the VSYNC
 	 *    of the new VP.
 	 */
-	if (layer_sel != old_layer_sel || port_sel != old_port_sel)
-		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
-	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
-
-	if (port_sel != old_port_sel) {
-		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
-		vop2_cfg_done(vp);
-		rk3568_vop2_wait_for_port_mux_done(vop2);
-	}
 
 	if (layer_sel != old_layer_sel && atv_layer_sel != old_layer_sel) {
 		cfg_done = vop2_readl(vop2, RK3568_REG_CFG_DONE);
@@ -2310,6 +2301,16 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 			rk3568_vop2_wait_for_layer_cfg_done(vop2, old_layer_sel);
 	}
 
+	if (layer_sel != old_layer_sel || port_sel != old_port_sel)
+		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
+	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
+
+	if (port_sel != old_port_sel) {
+		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
+		vop2_cfg_done(vp);
+		rk3568_vop2_wait_for_port_mux_done(vop2);
+	}
+
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
 	mutex_unlock(&vop2->ovl_lock);
 }

-- 
2.53.0

