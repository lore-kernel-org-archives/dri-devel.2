Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05148C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B94610E297;
	Thu, 10 Sep 2026 13:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pAezjHYK";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C7F910E22F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 13:08:55 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1ddd5d0aso2242385e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789045734; x=1789650534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9jiJj5iXaGRwv5GTBxHDtnHVVhq6FkY3C1mKKWquRtg=;
 b=pAezjHYKZlhjr7+N5HF2+Wu0LRj3GRVQIrGWZoFDExCctqrgkf/epw/3bLcBG4iFS2
 +C5Lqm8z8hLYRGP7NQThxWHM/WLYPepWlb3gO3o3E+0R/DQA5ZqP1iP4Xhb/4q9K5Mrq
 xHh3vRf9sZvqzz9DoNeYdbCcxWu47wlDG7XaBs+6TP16d2AqsQv4yzRAh0/CpvBIGirp
 SDceJCZqmTecFeU/9aL57UDWsfpLfYtmUJKQXpYrv41uaKDxs+W+AHcQC8fIjGFQkkH6
 P3xBNs5L+2QrPB34FvUwMMQjWWSJzJ5K/mp3aUYWyLejIY9bLV2crT0CacsPijaHxA/u
 onPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789045734; x=1789650534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9jiJj5iXaGRwv5GTBxHDtnHVVhq6FkY3C1mKKWquRtg=;
 b=MzXIEq/EU8vPXe07IsJ6Wh0/XMpykcLSlHaMUoKd4RFaxjcnqtiGvsTFByflNteQnD
 ntg+5Lah6pRrfgrx2sj9/9+OegYBLFaywH+bDCllmiG7g1sWmR4lm7DopiVjrGMujb02
 7k9IvmQUXS/AAwUUFDpAnB9BkJ09m2gVxYY2Xfzw/LC8ss3qIs3JB2JihYx5zJOe/eWp
 neC8VqiRsMMTekiCiCAZAQ/FD60h5xrU4dvenwHg6VYOSmFfUgJPjWbpK9YD55mdg17X
 t8fbndXxJ/0IDZvz79+7NXpeEp41xy4yDrQLoh/K3XlCrqUq/4fczOEK05CJLrZWxjcu
 LquA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEuy8HDwBl5cQncq9HL7FzC/F4SXTi0oxFmwVaUDrxGTgsz4NQ355Wyd/s44Hrn0AuOI4QiB4PAKE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nel10jptsl7W07gxVS3dRBvfn/zxh+CUUaWAmXqKbvuB2xXLi9
 xHrZ9tF9O6D2vzPyLsA4cQrYO6X4IP11fhUJckilj/R7YsPe7jeVvQ6l
X-Gm-Gg: AYBFou1rNwC/D8Q2CcXrf36OAWyHnZxlzhwvBsoKGHfHXYiZTT0GFFk8/uZejgUhqX7
 GwHd5jVJzip8wrm1zyDtnz3qxAu7h0Zoa6bQT4vQlgPFXAZJ6Mb+I9/lcxPJjL/8WcxrKFYxbdi
 cDkQqo6I43JnagR3rDoFRLmqc5GjjsVdCSB6fpmEnQPNz6ieRj3AunwBiSZkS3gTPMIHwOs9U6u
 ckxaEu0SeKWuvpWPFl0tTa5Q8RgYqV37LzGu6zug+H77VPsMm53ViNXtSNvFRhlb/OQ5Lc+P0e8
 N5lF9/o/ZfiODAyDA4nsGqKy6gKx8EP17jis6o4mXWJf8Hwfn78blzj2xNcoNa01gqxklbgKnOC
 ZQwckW2Ni0+ezWxjc0fNqURv6iwOTsvJQnagWQlOy9xMQiYQ1sZNJDQsFqWI+6FxBTAUn1231Qv
 mU7mkSO7hh8HpvWMXT+4WMA6Vo7XiXLP2Q3x/xKiPHS47aWWQjFKN6+tspqbF6nChZ19CRRo4EE
 3wr51xsRSk988zDKA1AysDHz5Uyy/YkWcvjegYwovG2jMyM6Gpr0pUb+YmWBaRpM74GksVDuzCP
 8LU=
X-Received: by 2002:a05:6000:40dd:b0:47f:9283:1f9a with SMTP id
 ffacd0b85a97d-485907b118fmr32061495f8f.2.1789045733341; 
 Thu, 10 Sep 2026 06:08:53 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B914600506D8644FC6130D5.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:4600:506d:8644:fc61:30d5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm51873085f8f.26.2026.09.10.06.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:08:52 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Owen <support@armdesigner.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v3] drm/rockchip: vop2: Scale the AXI clock to the bandwidth
 the mode needs
Date: Thu, 10 Sep 2026 15:08:24 +0200
Message-ID: <20260910130824.6587-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

VOP2 fetches the scanout data for all of its video ports over a single
AXI clock.  On RK3588 that clock is pinned to 500 MHz by the device tree
and nothing ever raises it, so a mode whose pixel rate outruns what the
AXI clock can deliver underruns the internal scanout FIFO.  The hardware
reports this as POST_BUF_EMPTY and the picture is corrupted.

3840x2160@120 over DisplayPort is such a mode.  Measured on an Orange Pi
5 Plus by moving the rate at runtime while the mode was up, with dclk
unchanged at 594 MHz throughout, so that the AXI rate was the only
variable:

  500 MHz: ~594000 suppressed vop2_isr callbacks per 5 s, corrupted
  750 MHz: no POST_BUF_EMPTY at all for the 42 s the phase lasted, clean
  500 MHz: ~607000 suppressed callbacks per 5 s, corrupted again

Both transitions are immediate.  Heiko Stuebner reports the same
starvation on different hardware [1].

The requirement follows each port's pixel rate rather than its interface
clock, and it is per port rather than aggregate.  Two measurements at
500 MHz pin that down:

  - a single port scanning out 3840x2160@120 underruns, while the same
    composed pixel rate spread over three ports - 3840x2160@60 on one
    and 3840x2160@30 on two others - is clean for a minute with no
    underrun on any of them.  The totals are equal to the pixel:
    3840*2160*120 == 3840*2160*(60+30+30).

  - 3840x2160@60 is clean where 3840x2160@120 is not, although both run
    dclk at 594 MHz on this board: the 120 Hz link is YCbCr 4:2:0, which
    halves dclk without halving the rate at which the port consumes
    pixels.

So the condition belongs on each video port's own crtc_clock.  Summing
across ports would be wrong, and keying on dclk would miss 4:2:0
entirely.  The threshold sits between the measured points: 3840x2160@60
(594000 kHz) and 2560x1440@144 (about 586000 kHz) are both clean at the
default rate, 3840x2160@120 (1188000 kHz) is not.

Track the requirement as a global atomic state object: a CRTC that is
being modeset records what its port needs during its own atomic check,
and the rate applied is the maximum over the ports, never below the
rate the platform set up.  Because the clock is shared, it is programmed
from the commit tail rather than from the per-CRTC enable and disable
hooks: it is held at the rate both the old and the new configuration
need from before the first CRTC is touched until every CRTC has moved
over, and only then settled at what the new configuration needs.
Commits that share nothing but this object are ordered through it, the
way vc4 orders commits that share its core clock: each modeset commit
records itself per port and the next one waits for those before it
touches the clock.  The settle write goes out before commit_hw_done(),
which is all the next commit waits for, so it cannot land after that
commit's own.  Page flips do not take the object and are not held up by
it.

rockchip_drm_private carries a pointer to the hooks, and only VOP2 on
RK3588 sets it, so the commit tail is unchanged for every other Rockchip
SoC.

Tested on the same board on a drm-misc-next based tree plus the dw-dp
and Rockchip USBDP PHY series, which DisplayPort Alt Mode needs in order
to come up at all, with three outputs up (DisplayPort and two HDMI):
3840x2160@120 on the DisplayPort output selects 750 MHz, 3840x2160@60
returns the clock to 500 MHz and going back raises it again; disabling
both HDMI outputs at once while the DisplayPort one runs 3840x2160@120
keeps 750 MHz throughout and re-enabling them keeps it; the same
sequence at 3840x2160@60 stays at 500 MHz; no POST_BUF_EMPTY in any of
it.

Link: https://lore.kernel.org/all/20260808104240.13776-1-royalnet026@gmail.com/
Link: https://lore.kernel.org/all/20767137.geO5KgaWL5@diego/ [1]
Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v3:
 - Program the clock from the commit tail instead of the per-CRTC enable
   and disable hooks, and order commits that share only the private
   object through it - the full vc4 pattern rather than half of it.  The
   Sashiko review of v2 [2] found that without an atomic_commit_setup
   hook two non-blocking commits sharing only the private object can
   apply their rates out of order, and that a commit disabling several
   CRTCs lowered the clock from the first atomic_disable while the other
   ports were still scanning out.  Chaoyi Chen was fine with placing it
   in atomic_commit_tail [3].  The settle write is issued before
   drm_atomic_helper_commit_hw_done(), since the next commit only waits
   for that.
 - Only modeset commits take the private object, so a page flip on one
   port no longer waits for the previous commit on every other port.
 - Free the RGB encoder when drm_atomic_private_obj_init() fails [2].
 - Initialise state->obj in create_state as every other private object
   does; v2 left it NULL and the debugfs state dump dereferences it.
 - Report a failed clk_set_rate() instead of ignoring it.
 - Retested with three outputs, including disabling two of them at
   once; see the commit message.  The out-of-order case is not one I
   can provoke from userspace: it is covered by the ordering, not by a
   measurement.
 - Boardcon reports tearing during multi-CRTC reconfiguration in
   production multi-display use on their RK3588 board (dual HDMI plus DP,
   three screens to one), a sustained 3-5 C junction increase at 750 MHz
   on a fanless RK3588J, and offered to test [4]; Cc'd.
 - Mainline has no other code touching this clock.  A tree that carries
   the downstream "Scale ACLK rate up for RK3588 FRL display modes"
   change should not carry both: this patch keys on the pixel rate,
   which is what the FIFO sees, and the two must not fight over the
   clock.
 - Rebased on drm-misc-next 0878e6053d01d.

v2: https://lore.kernel.org/all/20260813094614.9072-1-royalnet026@gmail.com/
 - Each CRTC records its own requirement in a global atomic state object
   instead of the rate being computed by walking the CRTC list, which
   read state the commit holds no lock for (Sashiko review of v1).

[2] https://lore.kernel.org/all/20260813100027.349761F000E9@smtp.kernel.org/
[3] https://lore.kernel.org/all/8d521014-3202-4f62-ba1a-ebe126506048@rock-chips.com/
[4] https://lore.kernel.org/all/2026081916331211222713@armdesigner.com/

 drivers/gpu/drm/rockchip/rockchip_drm_drv.h  |  24 ++
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c   |  54 ++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 227 +++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  25 ++
 4 files changed, 329 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 4705dc6b8bd7d..a7e20a076145f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -61,18 +61,42 @@ struct rockchip_crtc_state {
 #define to_rockchip_crtc_state(s) \
 		container_of(s, struct rockchip_crtc_state, base)
 
+/*
+ * A VOP applies its hardware state one CRTC at a time.  A VOP with a resource
+ * that all of its CRTCs share, such as the AXI clock on RK3588, needs to see
+ * the commit as a whole in order to program it: commits that only share that
+ * resource have to be ordered, and the resource has to be held at the level
+ * both the old and the new configuration need until every CRTC has moved
+ * over.  The VOP points rockchip_drm_private.commit_hooks at its hooks at
+ * bind time, and the atomic commit helpers call them.  All three are
+ * required.
+ */
+struct rockchip_drm_commit_hooks {
+	/* From drm_mode_config_helper_funcs.atomic_commit_setup. */
+	int (*setup)(struct rockchip_drm_commit_hooks *hooks,
+		     struct drm_atomic_commit *state);
+	/* Start of the commit tail, before any CRTC is touched. */
+	void (*tail_begin)(struct rockchip_drm_commit_hooks *hooks,
+			   struct drm_atomic_commit *state);
+	/* After every CRTC has moved over, before commit_hw_done(). */
+	void (*tail_end)(struct rockchip_drm_commit_hooks *hooks,
+			 struct drm_atomic_commit *state);
+};
+
 /*
  * Rockchip drm private structure.
  *
  * @crtc: array of enabled CRTCs, used to map from "pipe" to drm_crtc.
  * @num_pipe: number of pipes for this device.
  * @mm_lock: protect drm_mm on multi-threads.
+ * @commit_hooks: set by a VOP that has to see whole commits, or NULL.
  */
 struct rockchip_drm_private {
 	struct iommu_domain *domain;
 	struct device *iommu_dev;
 	struct mutex mm_lock;
 	struct drm_mm mm;
+	struct rockchip_drm_commit_hooks *commit_hooks;
 };
 
 struct rockchip_encoder {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 45588b79b3d4d..15560b1b004e1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -8,6 +8,7 @@
 
 #include <drm/drm.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -24,8 +25,59 @@ static const struct drm_framebuffer_funcs rockchip_drm_fb_funcs = {
 	.dirty	       = drm_atomic_helper_dirtyfb,
 };
 
+static int rockchip_atomic_commit_setup(struct drm_atomic_commit *state)
+{
+	struct rockchip_drm_private *priv = state->dev->dev_private;
+	struct rockchip_drm_commit_hooks *hooks = priv->commit_hooks;
+
+	if (!hooks)
+		return 0;
+
+	return hooks->setup(hooks, state);
+}
+
+/*
+ * drm_atomic_helper_commit_tail_rpm(), with the VOP's commit hooks: tail_begin
+ * before any CRTC is touched, tail_end once every CRTC has moved over but
+ * before drm_atomic_helper_commit_hw_done().
+ */
+static void rockchip_atomic_commit_tail(struct drm_atomic_commit *state)
+{
+	struct drm_device *dev = state->dev;
+	struct rockchip_drm_private *priv = dev->dev_private;
+	struct rockchip_drm_commit_hooks *hooks = priv->commit_hooks;
+
+	if (hooks)
+		hooks->tail_begin(hooks, state);
+
+	drm_atomic_helper_commit_modeset_disables(dev, state);
+
+	drm_atomic_helper_commit_modeset_enables(dev, state);
+
+	drm_atomic_helper_commit_planes(dev, state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY);
+
+	/*
+	 * Every CRTC has moved over by now: a disabled one stopped inside its
+	 * atomic_disable, an enabled one runs its new mode.  Settle before
+	 * commit_hw_done(): after it the state may not be touched, and the
+	 * next commit only waits for it.
+	 */
+	if (hooks)
+		hooks->tail_end(hooks, state);
+
+	drm_atomic_helper_fake_vblank(state);
+
+	drm_atomic_helper_commit_hw_done(state);
+
+	drm_atomic_helper_wait_for_vblanks(dev, state);
+
+	drm_atomic_helper_cleanup_planes(dev, state);
+}
+
 static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
-	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+	.atomic_commit_setup = rockchip_atomic_commit_setup,
+	.atomic_commit_tail = rockchip_atomic_commit_tail,
 };
 
 static struct drm_framebuffer *
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index b2f3a579bbe52..cf574e48f9561 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -104,6 +104,20 @@ enum vop2_afbc_format {
 
 #define VOP2_MAX_DCLK_RATE		600000000UL
 
+/*
+ * All video ports fetch their scanout data over a single AXI clock.  The
+ * hardware buffers that data in an internal FIFO which is drained at the
+ * pixel rate, so a mode whose pixel rate outruns the fill rate underruns the
+ * FIFO, which the hardware reports as POST_BUF_EMPTY and which shows up as a
+ * corrupted image.  Raise the AXI clock for modes that need it.
+ *
+ * The requirement follows the pixel rate rather than the interface clock: a
+ * YCbCr 4:2:0 link halves dclk but not the rate at which the video port
+ * consumes pixels.
+ */
+#define VOP2_ACLK_RATE_HIGH		750000000UL
+#define VOP2_HIGH_BW_PIXCLK_KHZ		1000000
+
 /*
  * bus-format types.
  */
@@ -1008,6 +1022,174 @@ static bool vop2_gamma_lut_in_use(struct vop2 *vop2, struct vop2_video_port *vp)
 	return gamma_en_vp_id != nr_vps && gamma_en_vp_id != vp->id;
 }
 
+static struct drm_private_state *
+vop2_aclk_create_state(struct drm_private_obj *obj)
+{
+	struct vop2_aclk_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_private_obj_create_state(obj, &state->base);
+
+	return &state->base;
+}
+
+static struct drm_private_state *
+vop2_aclk_duplicate_state(struct drm_private_obj *obj)
+{
+	const struct vop2_aclk_state *old_state = to_vop2_aclk_state(obj->state);
+	struct vop2_aclk_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
+
+	/* The pending commits belong to the old state and are not carried over. */
+	memcpy(state->vp_rate, old_state->vp_rate, sizeof(state->vp_rate));
+
+	return &state->base;
+}
+
+static void vop2_aclk_destroy_state(struct drm_private_obj *obj,
+				    struct drm_private_state *state)
+{
+	struct vop2_aclk_state *aclk_state = to_vop2_aclk_state(state);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(aclk_state->pending_commit); i++)
+		if (aclk_state->pending_commit[i])
+			drm_crtc_commit_put(aclk_state->pending_commit[i]);
+
+	kfree(aclk_state);
+}
+
+static const struct drm_private_state_funcs vop2_aclk_state_funcs = {
+	.atomic_create_state = vop2_aclk_create_state,
+	.atomic_duplicate_state = vop2_aclk_duplicate_state,
+	.atomic_destroy_state = vop2_aclk_destroy_state,
+};
+
+/* The rate that satisfies every video port, never below the platform's own. */
+static unsigned long vop2_aclk_rate(struct vop2 *vop2,
+				    const struct vop2_aclk_state *aclk_state)
+{
+	unsigned long rate = vop2->aclk_rate_normal;
+	unsigned int i;
+
+	for (i = 0; i < vop2->data->nr_vps; i++)
+		rate = max(rate, aclk_state->vp_rate[i]);
+
+	return rate;
+}
+
+static void vop2_set_aclk_rate(struct vop2 *vop2, unsigned long rate)
+{
+	int ret;
+
+	ret = clk_set_rate(vop2->aclk, rate);
+	if (ret)
+		drm_err(vop2->drm, "failed to set aclk to %lu Hz: %d\n", rate, ret);
+}
+
+static struct vop2 *vop2_from_commit_hooks(struct rockchip_drm_commit_hooks *hooks)
+{
+	return container_of(hooks, struct vop2, commit_hooks);
+}
+
+/*
+ * Remember which commit last touched each video port.  The next commit that
+ * takes the shared state waits for all of them in vop2_commit_tail_begin()
+ * before it touches the clock, so two commits that only share the clock cannot
+ * apply their rates out of order.  Only commits that take the shared state get
+ * here; a page flip neither records itself nor waits.
+ */
+static int vop2_commit_setup(struct rockchip_drm_commit_hooks *hooks,
+			     struct drm_atomic_commit *state)
+{
+	struct vop2 *vop2 = vop2_from_commit_hooks(hooks);
+	struct drm_private_state *priv_state;
+	struct vop2_aclk_state *aclk_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	unsigned int i;
+
+	priv_state = drm_atomic_get_new_private_obj_state(state, &vop2->aclk_obj);
+	if (!priv_state)
+		return 0;
+
+	aclk_state = to_vop2_aclk_state(priv_state);
+
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		struct vop2_video_port *vp = to_vop2_video_port(crtc);
+
+		aclk_state->pending_commit[vp->id] =
+			drm_crtc_commit_get(crtc_state->commit);
+	}
+
+	return 0;
+}
+
+/*
+ * Hold the clock at the rate that both the old and the new configuration need
+ * for the whole commit: a port that is being disabled keeps scanning out until
+ * its atomic_disable has waited for it to stop, and a port that is being
+ * enabled needs its rate before it starts.
+ */
+static void vop2_commit_tail_begin(struct rockchip_drm_commit_hooks *hooks,
+				   struct drm_atomic_commit *state)
+{
+	struct vop2 *vop2 = vop2_from_commit_hooks(hooks);
+	struct drm_private_state *old_priv_state, *new_priv_state;
+	struct vop2_aclk_state *old_aclk_state;
+	unsigned int i;
+
+	old_priv_state = drm_atomic_get_old_private_obj_state(state, &vop2->aclk_obj);
+	new_priv_state = drm_atomic_get_new_private_obj_state(state, &vop2->aclk_obj);
+	if (!old_priv_state || !new_priv_state)
+		return;
+
+	old_aclk_state = to_vop2_aclk_state(old_priv_state);
+
+	for (i = 0; i < ARRAY_SIZE(old_aclk_state->pending_commit); i++) {
+		struct drm_crtc_commit *commit = old_aclk_state->pending_commit[i];
+
+		if (!commit)
+			continue;
+
+		if (drm_crtc_commit_wait(commit))
+			drm_err(vop2->drm, "timed out waiting for the commit on vp%u\n", i);
+
+		drm_crtc_commit_put(commit);
+		old_aclk_state->pending_commit[i] = NULL;
+	}
+
+	vop2_set_aclk_rate(vop2,
+			   max(vop2_aclk_rate(vop2, old_aclk_state),
+			       vop2_aclk_rate(vop2, to_vop2_aclk_state(new_priv_state))));
+}
+
+/*
+ * Every port has moved over: settle at the rate the new configuration needs.
+ * Runs before drm_atomic_helper_commit_hw_done(), so the next commit, which
+ * waits for hw_done, never sees this write land after its own.
+ */
+static void vop2_commit_tail_end(struct rockchip_drm_commit_hooks *hooks,
+				 struct drm_atomic_commit *state)
+{
+	struct vop2 *vop2 = vop2_from_commit_hooks(hooks);
+	struct drm_private_state *priv_state;
+
+	priv_state = drm_atomic_get_new_private_obj_state(state, &vop2->aclk_obj);
+	if (!priv_state)
+		return;
+
+	vop2_set_aclk_rate(vop2, vop2_aclk_rate(vop2, to_vop2_aclk_state(priv_state)));
+}
+
 static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 				     struct drm_atomic_commit *state)
 {
@@ -1993,6 +2175,26 @@ static int vop2_crtc_atomic_check(struct drm_crtc *crtc,
 	if (ret)
 		return ret;
 
+	/*
+	 * Only a modeset can change what this port needs from the AXI clock.
+	 * A page flip does not take the shared state, so it neither waits for
+	 * nor holds up commits on the other ports.
+	 */
+	if (vp->vop2->version == VOP_VERSION_RK3588 &&
+	    drm_atomic_crtc_needs_modeset(crtc_state)) {
+		struct drm_private_state *priv_state;
+
+		priv_state = drm_atomic_get_private_obj_state(state,
+							      &vp->vop2->aclk_obj);
+		if (IS_ERR(priv_state))
+			return PTR_ERR(priv_state);
+
+		to_vop2_aclk_state(priv_state)->vp_rate[vp->id] =
+			crtc_state->active &&
+			crtc_state->adjusted_mode.crtc_clock > VOP2_HIGH_BW_PIXCLK_KHZ ?
+			VOP2_ACLK_RATE_HIGH : 0;
+	}
+
 	drm_atomic_crtc_state_for_each_plane(plane, crtc_state)
 		nplanes++;
 
@@ -2875,6 +3077,8 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return dev_err_probe(drm->dev, PTR_ERR(vop2->aclk),
 				     "failed to get aclk source\n");
 
+	vop2->aclk_rate_normal = clk_get_rate(vop2->aclk);
+
 	vop2->pclk = devm_clk_get_optional(vop2->dev, "pclk_vop");
 	if (IS_ERR(vop2->pclk))
 		return dev_err_probe(drm->dev, PTR_ERR(vop2->pclk),
@@ -2944,10 +3148,27 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 
 	rockchip_drm_dma_init_device(vop2->drm, vop2->dev);
 
+	ret = drm_atomic_private_obj_init(vop2->drm, &vop2->aclk_obj,
+					  &vop2_aclk_state_funcs);
+	if (ret)
+		goto err_rgb;
+
+	if (vop2->version == VOP_VERSION_RK3588) {
+		struct rockchip_drm_private *priv = drm->dev_private;
+
+		vop2->commit_hooks.setup = vop2_commit_setup;
+		vop2->commit_hooks.tail_begin = vop2_commit_tail_begin;
+		vop2->commit_hooks.tail_end = vop2_commit_tail_end;
+		priv->commit_hooks = &vop2->commit_hooks;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
 
+err_rgb:
+	if (vop2->rgb)
+		rockchip_rgb_fini(vop2->rgb);
 err_crtcs:
 	vop2_destroy_crtcs(vop2);
 
@@ -2957,9 +3178,15 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 static void vop2_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct vop2 *vop2 = dev_get_drvdata(dev);
+	struct rockchip_drm_private *priv = vop2->drm->dev_private;
 
 	pm_runtime_disable(dev);
 
+	if (priv->commit_hooks == &vop2->commit_hooks)
+		priv->commit_hooks = NULL;
+
+	drm_atomic_private_obj_fini(&vop2->aclk_obj);
+
 	if (vop2->rgb)
 		rockchip_rgb_fini(vop2->rgb);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index ffcb39c130aa1..cfca58d6c7403 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -8,6 +8,7 @@
 #define _ROCKCHIP_DRM_VOP2_H
 
 #include <linux/regmap.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_modes.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
 #include "rockchip_drm_drv.h"
@@ -286,6 +287,26 @@ struct vop2_data {
 	unsigned int soc_id;
 };
 
+/*
+ * The AXI clock is shared by every video port, so the rate it has to run at is
+ * a property of the device rather than of one CRTC.  Track it as a global
+ * atomic state object: each CRTC records its own requirement during atomic
+ * check, and the rate applied is the maximum over the ports.  Going through
+ * the atomic state is what makes this safe - a commit never reads the state of
+ * a CRTC it does not hold a lock for.
+ */
+struct vop2_aclk_state {
+	struct drm_private_state base;
+	unsigned long vp_rate[ROCKCHIP_MAX_CRTC];
+	/*
+	 * The commit that last touched each video port.  The next commit to
+	 * that port waits for it before it changes the clock.
+	 */
+	struct drm_crtc_commit *pending_commit[ROCKCHIP_MAX_CRTC];
+};
+
+#define to_vop2_aclk_state(x) container_of(x, struct vop2_aclk_state, base)
+
 struct vop2 {
 	u32 version;
 	struct device *dev;
@@ -326,6 +347,10 @@ struct vop2 {
 	unsigned int enable_count;
 	struct clk *hclk;
 	struct clk *aclk;
+	/* AXI clock rate set up by the platform, used as the lower bound. */
+	unsigned long aclk_rate_normal;
+	struct drm_private_obj aclk_obj;
+	struct rockchip_drm_commit_hooks commit_hooks;
 	struct clk *pclk;
 	struct clk *pll_hdmiphy0;
 	struct clk *pll_hdmiphy1;

base-commit: 0878e6053d01d87c75bb1d00b0187e8a2e105ead
-- 
2.43.0

