Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9C6C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D9C10EA93;
	Mon,  6 Jul 2026 19:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="S94KRAQn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FA710EA8B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783366355;
 bh=swh/JeIMm9ReiTXix+vwRFJ6g6E243o3S3Lb9kHImP0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=S94KRAQnx+P/IMzPSi84I0nsyTi5dIUy7gVJe2rsiaLwlO87GiJPVX5jn4tE0gsAx
 A7LSep9DOuTCsd1s0c0Gt+1CSd3ZWXbkDePyYjY+onBTF9znFdFeGGfxIkwFJahAVi
 BQLkNRZwAO0BpqZWpUlJLxQdO5gm/WF07T/cwi6pgkB7FnkFaCjRh8V/yraubn5y67
 CK3DmnUVcIGJ24knWi+ysFTZWW1khx5GcQJvpl52F5DS3jlLOeaFJsrfGCVygQ+o1y
 d0BOzrEWwmX/ppXG/i8MNL8Kl5iyM91s4iEDscZafAzlG1jIp2G8sxbkug8Ol9b8yu
 kp0p6D9hyCwHA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9CA5017E0DFB;
 Mon, 06 Jul 2026 21:32:35 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 06 Jul 2026 22:32:15 +0300
Subject: [PATCH v2 03/13] drm/rockchip: vop2: Balance state on
 atomic_enable error paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-dw-hdmi-qp-yuv-v2-3-b91beb33dedf@collabora.com>
References: <20260706-dw-hdmi-qp-yuv-v2-0-b91beb33dedf@collabora.com>
In-Reply-To: <20260706-dw-hdmi-qp-yuv-v2-0-b91beb33dedf@collabora.com>
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

Cleaning up on the enable error paths alone is insufficient, however.
A CRTC whose atomic_enable() bailed is still committed as active, so
vop2_crtc_atomic_disable() still runs its full teardown, releasing the
same dclk prepare and enable_count a second time - underflowing both
counts and, where vop2_enable() ran, touching VOP registers with core
clocks gated.

Fix this by reverting exactly what was set up on failure, and track the
per-VP bring-up state so atomic_disable() skips teardown when
atomic_enable() never completed.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260623202043.8BFE21F000E9@smtp.kernel.org/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 34 +++++++++++++++++++++-------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  6 +++++
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index e11dc8c7f78b..c2328b35466d 100644
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
@@ -1803,8 +1809,11 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
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
 
@@ -1831,10 +1840,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
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
@@ -1852,8 +1859,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 		default:
 			drm_err(vop2->drm, "Unknown DRM_MODE_CONNECTOR %d\n",
 				vcstate->output_type);
-			vop2_unlock(vop2);
-			return;
+			goto err_put_enable_count;
 		}
 	else
 		out_mode = vcstate->output_mode;
@@ -1965,6 +1971,18 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
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

