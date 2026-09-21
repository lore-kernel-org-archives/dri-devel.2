Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC12C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9CB10EA92;
	Mon, 21 Sep 2026 15:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="fcrE2OXr";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C295D10EA49;
 Mon, 21 Sep 2026 15:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005985; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MkvctPEgN/opcclJ7AbrHT0NUw5PyfmjTlw1EVX0+A9iCip/vCP3fTYIf4WeCcAmxdjPIfeki2VQrDQYcGZdVseNywFZQf87igLM7iofK+RpNwQExbBpkQ/GBA7eppgMrgnKur3C8we3HtOKWDzWZ/1qkMBPJkuFt9XdZSVZ+ME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005985;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=y/u3vmta3+dbrofrUmndHlgFpIUmssOjUpr8W2OjIi4=; 
 b=bqmI9sT7fNW9pKNoXHo6CGSAoz+HKc8xaQoLIMQjPz0JPYYdbgzRXXDQEkWFL5dFKj4xcPPJK7300o+RNR3Dkuk6CA5coRlKJsIKeKBuUMqEz60Fn9jkiHfxAfvXzAiI3r+GCfuQ6WW78Fdpj0n39jjCY4kIEhUbCEJvrFZ0zA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005985; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=y/u3vmta3+dbrofrUmndHlgFpIUmssOjUpr8W2OjIi4=;
 b=fcrE2OXrBcW4dbZejVZKBloogh6hW3A6feRsFGFcBd4A5tiB57BqLjkWHwbBuKiN
 l6DmQrYGZiaHpBxaeZ8bYc85y0Bq9FNES1a+GcgVJu/iywyvc+9urb8Clkp/lIp9gzr
 1TfyNvvK3GIlrrm9T1WjiL8RsRhKhSn4zUtBDa7M=
Received: by smtp.zohomail.com with SMTPS id 179000598377154.95688948710904;
 Mon, 21 Sep 2026 08:53:03 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:37 +0200
Subject: [PATCH RFC 11/25] drm/rockchip: vop2: Enable VRR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-11-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Use the new VRR state tracking to handle VRR front porch adjustment.

To avoid indenting too deeply, refactor the vblank handling into its own
function while at it, where scope-based cleanup helpers for the lock can
be used.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 62 ++++++++++++++++++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  9 ++++
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index bfb384142568..e79081c04437 100644
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
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index ffcb39c130aa..fdb2030e3ad4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -655,6 +655,9 @@ enum dst_factor_mode {
 
 #define RK3588_VP_DSP_CTRL__GAMMA_UPDATE_EN		BIT(22)
 
+#define RK3568_VP_DSP_VTOTAL_VS_END__DSP_VTOTAL		GENMASK(28, 16)
+#define RK3568_VP_DSP_VTOTAL_VS_END__IMD		BIT(15)
+
 #define RK3588_VP_CLK_CTRL__DCLK_OUT_DIV		GENMASK(3, 2)
 #define RK3588_VP_CLK_CTRL__DCLK_CORE_DIV		GENMASK(1, 0)
 
@@ -810,6 +813,12 @@ static inline void vop2_vp_write(struct vop2_video_port *vp, u32 offset, u32 v)
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

-- 
2.55.0

