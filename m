Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552D7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 21:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E21A10F2FE;
	Wed,  8 Jul 2026 21:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Q1lvWiMA";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3F310F2ED
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 21:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783547873;
 bh=1ZKedwsJ6oC5SIR0BUMYpQ5W3KfJQMFG7QsHZgP6Gmk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Q1lvWiMAuysMNLZbzSMLl68ioyDDPxDBjJLIZQwZbT76ycbeUSw1nkbLfpYngf/IL
 /b95WnDIYkIpA4dTVKxB1NGU7a+vd6onyLc14ZWfl7bj5ahHZdfKundvV0tkviPbZY
 p5u/Dw4QmJF0T+sEsnajiwwofqLVaAMtp14V/cKBYtaaO8eDYShwDBCSa6w3ITob4T
 iEV7a2MM7h+idN8D/9765eu2e/mhwA53BE8kQHbFjSKUJs0i/Pc3tvsAM5XuAi6sYl
 MQPeC423mSEOyVbuF6ZJo3Vk8r/6GnFguyydRHYY6BBrc9laCKkEc49mwI3/w6S/1q
 avcfpPlaX5R/A==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 22B6417E0CF4;
 Wed, 08 Jul 2026 23:57:53 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 09 Jul 2026 00:57:25 +0300
Subject: [PATCH v3 03/14] drm/rockchip: vop2: Balance state on
 atomic_enable() error paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-dw-hdmi-qp-yuv-v3-3-a4a982a9f2e7@collabora.com>
References: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
In-Reply-To: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
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

vop2_crtc_atomic_enable() prepares vp->dclk and, for the first CRTC,
calls vop2_enable(), incrementing the shared vop2->enable_count before
programming VOP2 registers.  Two later failure points return early with
only vop2_unlock(), leaking the dclk prepare, the enable_count
increment, and the core clocks / PM runtime reference from
vop2_enable().

Since the disable path decrements enable_count unconditionally, the
leaked increment skews the count, causing an underflow or premature
shutdown of core clocks and PM runtime while another CRTC is active.

Moreover, cleaning up on the enable error paths alone is insufficient.
A CRTC whose atomic_enable() bailed is still committed as active, so
vop2_crtc_atomic_disable() still runs its full teardown, releasing the
same dclk prepare and enable_count a second time, thus underflowing both
counts and, where vop2_enable() ran, touching VOP registers with core
clocks gated.

Fix this by reverting exactly what was set up on failure, and track the
per-VP bring-up state so atomic_disable() skips teardown when
atomic_enable() never completed.  Additionally, ensure any further
hardware programming is also skipped within the affected RPM commit
tail, i.e. in the callbacks gated by drm_atomic_helper_commit_planes():
vop2_crtc_atomic_begin(), vop2_plane_atomic_update{update|disable}() and
vop2_crtc_atomic_flush().

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260623202043.8BFE21F000E9@smtp.kernel.org/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 68 ++++++++++++++++++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  6 +++
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index e11dc8c7f78b..271c3cba6fb4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1033,6 +1033,9 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	vop2_lock(vop2);
 
+	if (!vp->enabled)
+		goto out_unlock;
+
 	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
 	drm_atomic_helper_disable_planes_on_crtc(old_crtc_state, false);
 
@@ -1063,11 +1066,14 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	clk_disable_unprepare(vp->dclk);
 
+	vp->enabled = false;
+
 	vop2->enable_count--;
 
 	if (!vop2->enable_count)
 		vop2_disable(vop2);
 
+out_unlock:
 	vop2_unlock(vop2);
 
 	if (crtc->state->event && !crtc->state->active) {
@@ -1197,13 +1203,21 @@ static void vop2_plane_atomic_disable(struct drm_plane *plane,
 	struct drm_plane_state *old_pstate = NULL;
 	struct vop2_win *win = to_vop2_win(plane);
 	struct vop2 *vop2 = win->vop2;
+	struct vop2_video_port *vp;
 
 	drm_dbg(vop2->drm, "%s disable\n", win->data->name);
 
 	if (state)
 		old_pstate = drm_atomic_get_old_plane_state(state, plane);
-	if (old_pstate && !old_pstate->crtc)
-		return;
+
+	if (old_pstate) {
+		if (!old_pstate->crtc)
+			return;
+
+		vp = to_vop2_video_port(old_pstate->crtc);
+		if (!vp->enabled)
+			return;
+	}
 
 	vop2_win_disable(win);
 	vop2_win_write(win, VOP2_WIN_YUV_CLIP, 0);
@@ -1298,6 +1312,9 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	if (WARN_ON(!crtc))
 		return;
 
+	if (!vp->enabled)
+		return;
+
 	if (!pstate->visible) {
 		vop2_plane_atomic_disable(plane, state);
 		return;
@@ -1803,8 +1820,11 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 		return;
 	}
 
-	if (!vop2->enable_count)
-		vop2_enable(vop2);
+	if (!vop2->enable_count) {
+		ret = vop2_enable(vop2);
+		if (ret)
+			goto err_unprepare_dclk;
+	}
 
 	vop2->enable_count++;
 
@@ -1831,10 +1851,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 		clock = vop2->ops->setup_intf_mux(vp, rkencoder->crtc_endpoint_id, polflags);
 	}
 
-	if (!clock) {
-		vop2_unlock(vop2);
-		return;
-	}
+	if (!clock)
+		goto err_put_enable_count;
 
 	if (vcstate->output_mode == ROCKCHIP_OUT_MODE_AAAA &&
 	    !(vp_data->feature & VOP2_VP_FEATURE_OUTPUT_10BIT))
@@ -1852,8 +1870,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 		default:
 			drm_err(vop2->drm, "Unknown DRM_MODE_CONNECTOR %d\n",
 				vcstate->output_type);
-			vop2_unlock(vop2);
-			return;
+			goto err_put_enable_count;
 		}
 	else
 		out_mode = vcstate->output_mode;
@@ -1965,6 +1982,18 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	drm_crtc_vblank_on(crtc);
 
+	vp->enabled = true;
+
+	vop2_unlock(vop2);
+
+	return;
+
+err_put_enable_count:
+	if (!--vop2->enable_count)
+		vop2_disable(vop2);
+
+err_unprepare_dclk:
+	clk_disable_unprepare(vp->dclk);
 	vop2_unlock(vop2);
 }
 
@@ -2023,6 +2052,9 @@ static void vop2_crtc_atomic_begin(struct drm_crtc *crtc,
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 	struct vop2 *vop2 = vp->vop2;
 
+	if (!vp->enabled)
+		return;
+
 	vop2->ops->setup_overlay(vp);
 }
 
@@ -2034,13 +2066,19 @@ static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 	struct vop2 *vop2 = vp->vop2;
 
-	/* In case of modeset, gamma lut update already happened in atomic enable */
-	if (!drm_atomic_crtc_needs_modeset(crtc_state) && crtc_state->color_mgmt_changed)
-		vop2_crtc_atomic_try_set_gamma_locked(vop2, vp, crtc, crtc_state);
+	if (vp->enabled) {
+		/*
+		 * In case of modeset, gamma lut update already happened
+		 * in atomic enable.
+		 */
+		if (!drm_atomic_crtc_needs_modeset(crtc_state) &&
+		    crtc_state->color_mgmt_changed)
+			vop2_crtc_atomic_try_set_gamma_locked(vop2, vp, crtc, crtc_state);
 
-	vop2_post_config(crtc, false, crtc_state, old_crtc_state);
+		vop2_post_config(crtc, false, crtc_state, old_crtc_state);
 
-	vop2_cfg_done(vp);
+		vop2_cfg_done(vp);
+	}
 
 	spin_lock_irq(&crtc->dev->event_lock);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index ffcb39c130aa..b209b2d5b96d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -243,6 +243,12 @@ struct vop2_video_port {
 
 	struct completion dsp_hold_completion;
 
+	/**
+	 * @enabled: CRTC fully brought up by atomic_enable(); allows
+	 * atomic_disable() to skip teardown after a failed enable.
+	 */
+	bool enabled;
+
 	/**
 	 * @win_mask: Bitmask of windows attached to the video port;
 	 */

-- 
2.54.0

