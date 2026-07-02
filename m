Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B28C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923BC10F67F;
	Fri,  3 Jul 2026 07:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=romanilin.is header.i=@romanilin.is header.b="nJMqCDYa";
	dkim-atps=neutral
Received: from mail.romanilin.is (mail.romanilin.is [146.185.235.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B45E10F460
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:23:59 +0000 (UTC)
Received: from macbook-pro (unknown [188.134.85.196])
 by mail.romanilin.is (Postfix) with ESMTPSA id B37D2600D0;
 Thu,  2 Jul 2026 18:23:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=romanilin.is;
 s=default; t=1783005836;
 bh=k0HqL8dLD4HvBZrngv5oLWK6wy8X/W41hO8c9B8rBRA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nJMqCDYanmpR3xylVuSiv/yCDc5eD7fvji3UxDB2/fkqKLmVmRXPHRussZZWiT5GM
 N+iTKr7EwX22R3vAiB0OBe5SXRsD9na0Ms3BsdIGU+QXicTl5vcDcONmjWoCW6Uwb0
 jk/NL6n9UhvZDTpMuvLmCrXePLPihXJjCEvKijDXsgDv7BrddhzhrbDHcCdma6K1rk
 ogkGz1eDEV24nj3U9UNZgBt8cP3oiO7X0L/RM80Xt7yKPguNyN8jIGNvTWictxKAM6
 aAo5yY0GN8hzchgfyLwe4pxBdzZvlbYXwJ3j1JfBLEeIGu//WYxsysHG8Am7vktn5O
 m0c/oGTfeEe5g==
From: Roman Ilin <me@romanilin.is>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Peter Arnesen <peter.m.arnesen@gmail.com>, Roman Ilin <me@romanilin.is>
Subject: [PATCH v2] drm/vblank: Don't arm vblank timer with invalid frame
 duration
Date: Thu,  2 Jul 2026 18:23:56 +0300
Message-ID: <20260702152356.45045-1-me@romanilin.is>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613224434.96501-1-me@romanilin.is>
References: <20260613224434.96501-1-me@romanilin.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

When a CRTC's display mode carries a too small pixel clock,
drm_calc_timestamping_constants() computes a frame duration that exceeds
INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
interval, after which vblank events are no longer delivered. Pending
page flips never complete and the display appears frozen.

This could be triggered on virtio-gpu guests that have dynamic
resolution enabled: when the SPICE agent or the X server resizes the
output, it submits a mode whose pixel clock is off by a factor of 1000,
e.g.:

    clock = 406 kHz, htotal = 3152, vtotal = 2148

    framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)

16675852216 does not fit into an int and wraps to roughly -504000000.
ns_to_ktime() then yields a negative interval and the timer stops
working.

Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
Use vblank timer"). That commit merely made virtio-gpu use the vblank
timer and thereby exposed the pre-existing problem in the timer setup
added by commit 74afeb812850 ("drm/vblank: Add vblank timer").

To fix this, modify drm_calc_timestamping_constants() to use u64 for
calculations, check for INT_MAX overflows, and return an error code.
drm_crtc_vblank_start_timer() will then propagate the error, enabling
the driver to fall back to immediate vblank events. Valid modes are
unaffected, and the timer self-heals on the next mode with a sane clock.

Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Roman Ilin <me@romanilin.is>
---
Changes in v2:

- Moved the bounds check directly into drm_calc_timestamping_constants()
- Changed the helper's return type to int to propagate errors
- Used u64 for intermediate duration calculations to prevent overflows
- Added drm_WARN_ON_ONCE() when durations exceed INT_MAX
- Dropped virtio-gpu specific workarounds to keep the bugfix contained
  to DRM core

Notes:
Tested on 7.2.0-rc1.

 drivers/gpu/drm/drm_vblank.c | 67 +++++++++++++++++++++---------------
 include/drm/drm_vblank.h     |  4 +--
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13..b6a342e48 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -631,44 +631,51 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
  * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
  * CRTC's true scanout timing, so they take things like panel scaling or
  * other adjustments into account.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
  */
-void drm_calc_timestamping_constants(struct drm_crtc *crtc,
-				     const struct drm_display_mode *mode)
+int drm_calc_timestamping_constants(struct drm_crtc *crtc,
+				    const struct drm_display_mode *mode)
 {
 	struct drm_device *dev = crtc->dev;
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-	int linedur_ns = 0, framedur_ns = 0;
+	u64 linedur_ns, framedur_ns;
 	int dotclock = mode->crtc_clock;
+	unsigned int frame_size;
 
 	if (!drm_dev_has_vblank(dev))
-		return;
+		return 0;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
-		return;
+		return -EINVAL;
 
-	/* Valid dotclock? */
-	if (dotclock > 0) {
-		int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
-
-		/*
-		 * Convert scanline length in pixels and video
-		 * dot clock to line duration and frame duration
-		 * in nanoseconds:
-		 */
-		linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
-		framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
-
-		/*
-		 * Fields of interlaced scanout modes are only half a frame duration.
-		 */
-		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-			framedur_ns /= 2;
-	} else {
-		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
-			crtc->base.id);
+	if (dotclock <= 0) {
+		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
+			crtc->base.id, dotclock);
+		return -EINVAL;
 	}
 
+	frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode->crtc_vtotal;
+
+	/*
+	 * Convert scanline length in pixels and video dot clock to line duration
+	 * and frame duration in nanoseconds.
+	 */
+	linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
+	framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
+
+	/*
+	 * Fields of interlaced scanout modes are only half a frame duration.
+	 */
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		framedur_ns /= 2;
+
+	if (drm_WARN_ON_ONCE(dev, linedur_ns > INT_MAX) ||
+	    drm_WARN_ON_ONCE(dev, framedur_ns > INT_MAX))
+		return -EINVAL;
+
 	vblank->linedur_ns  = linedur_ns;
 	vblank->framedur_ns = framedur_ns;
 	drm_mode_copy(&vblank->hwmode, mode);
@@ -678,7 +685,10 @@ void drm_calc_timestamping_constants(struct drm_crtc *crtc,
 		     crtc->base.id, mode->crtc_htotal,
 		     mode->crtc_vtotal, mode->crtc_vdisplay);
 	drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
-		     crtc->base.id, dotclock, framedur_ns, linedur_ns);
+		     crtc->base.id, dotclock,
+		     vblank->framedur_ns, vblank->linedur_ns);
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_calc_timestamping_constants);
 
@@ -2221,6 +2231,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
 	unsigned long flags;
+	int ret;
 
 	if (!vtimer->crtc) {
 		/*
@@ -2239,7 +2250,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 			hrtimer_try_to_cancel(&vtimer->timer);
 	}
 
-	drm_calc_timestamping_constants(crtc, &crtc->mode);
+	ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&vtimer->interval_lock, flags);
 	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 2fcef9c0f..d99772dfa 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
 u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
 void drm_crtc_vblank_restore(struct drm_crtc *crtc);
 
-void drm_calc_timestamping_constants(struct drm_crtc *crtc,
-				     const struct drm_display_mode *mode);
+int drm_calc_timestamping_constants(struct drm_crtc *crtc,
+				    const struct drm_display_mode *mode);
 wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
 void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
 				   u32 max_vblank_count);
-- 
2.54.0

