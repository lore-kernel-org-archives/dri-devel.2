Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B350606A625
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=G775zhRN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3152011289E;
	Thu,  5 Nov 2026 15:54:20 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732FD11287F;
 Thu,  5 Nov 2026 15:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793894043; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a78HBP4P2g0jzKoRoVWuX3AsyMZETCjIl/EEWXSf+vPGbyCaiWH1i9cGfSWZLRlPzd8QJSTmO24vUqjDz/pq72bgQqBreZXlDi+gwrGq3t3Ec+SUh/2S6K6a5bPwN4N4Bvq9c2JTXDZ5Hda+R/hJXUh9drGFVNRpPA2v4R2NkoY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793894043;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wVSP1QV8jlmARNWRy3bvsaIRXKQ7LdLg2AcQdwzTU60=; 
 b=bNWq4FGTjpTMEiTN66YbZUX23qIDR2vIWlcqe39ZoJ/HfXV25TOSLnk+TRwT3kiRnhNiTharqZRtxjGhWX6FOKHh8NQv2Pl2oIepp0GEbvLW77g4uH9prhuAXLejxKZKo/AAjx8wvMS4D2Wy1cWCoA370jBt/qgTTF9JEZCN0u8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=G775zhRN4+Mo1LM4Gk2LETPzVc3WP3n20ZEc1p2DeRvROywMS+7HgOU6Z6pzu2/4OV0+mIbF8LSDk8WaEgaacKOQK9UkyR3n9isltV/EAVOUK4Z5Jxb6S5FhNay8dKmmkHHUlDA9MKD7R/nSheb1sAo6+K0HMnSejmkmT9w/Is0=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=wVSP1QV8jlmARNWRy3bvsaIRXKQ7LdLg2AcQdwzTU60=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894040942663.770671604691;
 Thu, 5 Nov 2026 07:54:00 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:05 +0100
Subject: [PATCH v2 14/27] drm/rockchip: vop2: Enable VRR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-14-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the new VRR state tracking to handle VRR front porch adjustment.

To avoid indenting too deeply, refactor the vblank handling into its own
function while at it, where scope-based cleanup helpers for the lock can
be used.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 65 +++++++++++++++++++++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 10 +++++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c |  4 ++
 3 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index bfb384142568..d93b49025795 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -24,6 +24,7 @@
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
 #include <linux/debugfs.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_flip_work.h>
@@ -2011,6 +2012,25 @@ static void vop2_crtc_atomic_begin(struct drm_crtc *crtc,
 	vop2->ops->setup_overlay(vp);
 }
 
+static void vop2_vp_set_vrr_vtotal(struct vop2_video_port *vp, unsigned int vtotal)
+{
+	const u32 mask = RK3568_VP_DSP_VTOTAL_VS_END__DSP_VTOTAL |
+			 RK3568_VP_DSP_VTOTAL_VS_END__IMD;
+
+	if (!vtotal) {
+		vop2_vp_update_bits(vp, RK3568_VP_DSP_VTOTAL_VS_END,
+				    RK3568_VP_DSP_VTOTAL_VS_END__IMD, 0);
+		return;
+	}
+
+	/* Value is 13 bits at most, saturate it if too large */
+	if (vtotal > RK3568_VP_DSP_VTOTAL_VS_END__DSP_VTOTAL >> 16)
+		vtotal = RK3568_VP_DSP_VTOTAL_VS_END__DSP_VTOTAL >> 16;
+
+	vop2_vp_update_bits(vp, RK3568_VP_DSP_VTOTAL_VS_END, mask,
+			    vtotal << 16 | RK3568_VP_DSP_VTOTAL_VS_END__IMD);
+}
+
 static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
 				   struct drm_atomic_commit *state)
 {
@@ -2029,6 +2049,11 @@ static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	spin_lock_irq(&crtc->dev->event_lock);
 
+	if (crtc_state->vrr_enabled) {
+		if (drm_crtc_helper_vrr_flush(crtc_state))
+			vop2_vp_set_vrr_vtotal(vp, crtc_state->vrr_state.cur_vtotal);
+	}
+
 	if (crtc->state->event) {
 		WARN_ON(drm_crtc_vblank_get(crtc));
 		vp->event = crtc->state->event;
@@ -2371,6 +2396,30 @@ static irqreturn_t rk3576_vp_isr(int irq, void *data)
 	return ret;
 }
 
+static void vop2_vp_handle_vblank(struct vop2_video_port *vp)
+{
+	struct drm_crtc *crtc = &vp->crtc;
+	struct vop2 *vop2 = vp->vop2;
+	u32 val;
+
+	guard(spinlock)(&crtc->dev->event_lock);
+
+	if (!vp->event)
+		return;
+
+	val = vop2_readl(vop2, RK3568_REG_CFG_DONE);
+
+	if (!(val & BIT(vp->id))) {
+		drm_crtc_send_vblank_event(crtc, vp->event);
+		vp->event = NULL;
+		drm_crtc_vblank_put(crtc);
+
+		if (crtc->state->vrr_enabled)
+			if (drm_crtc_helper_vrr_vsync(crtc->state))
+				vop2_vp_set_vrr_vtotal(vp, crtc->state->vrr_state.cur_vtotal);
+	}
+}
+
 static irqreturn_t vop2_isr(int irq, void *data)
 {
 	struct vop2 *vop2 = data;
@@ -2402,18 +2451,7 @@ static irqreturn_t vop2_isr(int irq, void *data)
 
 			if (irqs & VP_INT_FS_FIELD) {
 				drm_crtc_handle_vblank(crtc);
-				spin_lock(&crtc->dev->event_lock);
-				if (vp->event) {
-					u32 val = vop2_readl(vop2, RK3568_REG_CFG_DONE);
-
-					if (!(val & BIT(vp->id))) {
-						drm_crtc_send_vblank_event(crtc, vp->event);
-						vp->event = NULL;
-						drm_crtc_vblank_put(crtc);
-					}
-				}
-				spin_unlock(&crtc->dev->event_lock);
-
+				vop2_vp_handle_vblank(vp);
 				ret = IRQ_HANDLED;
 			}
 
@@ -2635,6 +2673,9 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 
 		drm_crtc_attach_background_color_property(&vp->crtc);
 
+		if (vp->data->vrr_limiter_capable)
+			drm_crtc_attach_vrr_limiter_properties(&vp->crtc);
+
 		drm_crtc_helper_add(&vp->crtc, &vop2_crtc_helper_funcs);
 		if (vop2->lut_regs) {
 			const struct vop2_video_port_data *vp_data = &vop2_data->vp[vp->id];
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index ffcb39c130aa..323e2533de34 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -231,6 +231,7 @@ struct vop2_video_port_data {
 	 * @pixel_rate: pixel per cycle
 	 */
 	u8 pixel_rate;
+	bool vrr_limiter_capable;
 };
 
 struct vop2_video_port {
@@ -655,6 +656,9 @@ enum dst_factor_mode {
 
 #define RK3588_VP_DSP_CTRL__GAMMA_UPDATE_EN		BIT(22)
 
+#define RK3568_VP_DSP_VTOTAL_VS_END__DSP_VTOTAL		GENMASK(28, 16)
+#define RK3568_VP_DSP_VTOTAL_VS_END__IMD		BIT(15)
+
 #define RK3588_VP_CLK_CTRL__DCLK_OUT_DIV		GENMASK(3, 2)
 #define RK3588_VP_CLK_CTRL__DCLK_CORE_DIV		GENMASK(1, 0)
 
@@ -810,6 +814,12 @@ static inline void vop2_vp_write(struct vop2_video_port *vp, u32 offset, u32 v)
 	regmap_write(vp->vop2->map, vp->data->offset + offset, v);
 }
 
+static inline void vop2_vp_update_bits(struct vop2_video_port *vp, u32 offset,
+				       u32 mask, u32 v)
+{
+	regmap_update_bits(vp->vop2->map, vp->data->offset + offset, mask, v);
+}
+
 static inline u32 vop2_readl(struct vop2 *vop2, u32 offset)
 {
 	u32 val;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index c44648e1bc0d..946ca420f3f5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1063,6 +1063,7 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 		/* hdr2sdr sdr2hdr hdr2hdr sdr2sdr */
 		.pre_scan_max_dly = { 76, 65, 65, 54 },
 		.offset = 0xc00,
+		.vrr_limiter_capable = true,
 	}, {
 		.id = 1,
 		.feature = VOP2_VP_FEATURE_OUTPUT_10BIT,
@@ -1071,6 +1072,7 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 		.max_output = { 4096, 2304 },
 		.pre_scan_max_dly = { 76, 65, 65, 54 },
 		.offset = 0xd00,
+		.vrr_limiter_capable = true,
 	}, {
 		.id = 2,
 		.feature = VOP2_VP_FEATURE_OUTPUT_10BIT,
@@ -1079,12 +1081,14 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 		.max_output = { 4096, 2304 },
 		.pre_scan_max_dly = { 52, 52, 52, 52 },
 		.offset = 0xe00,
+		.vrr_limiter_capable = true,
 	}, {
 		.id = 3,
 		.gamma_lut_len = 1024,
 		.max_output = { 2048, 1536 },
 		.pre_scan_max_dly = { 52, 52, 52, 52 },
 		.offset = 0xf00,
+		.vrr_limiter_capable = true,
 	},
 };
 

-- 
2.56.0

