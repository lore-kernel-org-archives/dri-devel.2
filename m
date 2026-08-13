Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1992CC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490E310E004;
	Thu, 13 Aug 2026 09:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jphidZnK";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9811A10E004
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:46:25 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4706f016316so123868f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786614384; x=1787219184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ACK6suDD45CZ07tgkZL9oiPF+BXY/lG7ANXuekOfOK4=;
 b=jphidZnKWLR6lTvG4bcwCGmHPIbb3UyBdN4/qr5yns3I6110+hgnEp4W8HwxDgOxSw
 slQbsG9NPGX2Zb6Zd1S6KxiEKzfjiYZd9aK4v3ja0mwwH8DUPxoEI7fTacxRycV7DMK/
 prUEGf8XBYRHRKy6qsW2k3hflGELi+VpEjAzxZ2nypDv586pyJnRyTcfbNeFx1+wBWea
 Tz0fGnth68HEElfYl0pCtop2rEKmGAqm76DClCJ41WI90djOxxG+pdS3V5f13lXBKFU3
 dyIslL+2LPZ1lcC9yBRboZcLHhFTArhnXRS/o4PFQNPJpuzbCA60/lJGYKI81WGUuLSz
 tjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786614384; x=1787219184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ACK6suDD45CZ07tgkZL9oiPF+BXY/lG7ANXuekOfOK4=;
 b=PdHHWlMncfpkfBQylZ6pntJGkSin0vS8K+1n7ED09Ejkg7HL59AjGkhsc1n0e/ToNw
 /xOZwHwnfzo6x2dVsnGJb01trf9PWpN6eeLFx4XBR7Q0yUWggWSWH3SPBTPBNe4qVYqF
 bGplYcGzHkhyNYPlk6UuK6bpiV0+vG8Owc9uJVRX6Lifffvg6UZvcfW7QGpJhR7t0YsY
 bGJu4FzxLFj6rj4rwUfx2dpi583+GVqXstLSHxbmkVmQ8pAkcO7/JH0F0MRXeRHTYQ9c
 DJW9XY6tRsKvQwb7r4G1WX08jWcCdl7ClmQ3+kz7gyOL2LZ2gW58LmqmRugZZ/ee29ji
 Hd6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSjN2AiG44iraZk+pVxinaxlD6LNAoz4KOVJgUKW023e2/12+WVM15TbK2+PyTmKEmXv0bnCm/KC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVttx5xtRmMfjpo4svanY9QRnP++DzuivBa4hIO3hyjfjTbvWE
 Pq6u8THfj2pHIWRnT2419zyT64wXebcu6EZsssXrmNNhNQrKxKVEevu1SgB0Xlyp
X-Gm-Gg: AR+sD10642dCr/Wz22qv+Pu4lrkfMWB6/rierYZW826Q0qtRP6gbVEP9bu4DjofTFmY
 V8nGkm87jOSw+qUkLg8hdcgjcx0o9svD3d2W2jQIbZ1kKnmkNubcwpFxRQe6iliVKVnyJmIv7Bv
 /C9RYqXhRWOzd9ImIHbRMyQgCobHzC2bqSEYw1LsYEXjDDYFi/JZzuvq9gBKGUThdulTJK8QRFI
 vZvyb1DWgA+nvb8H/Q11oWhKBmScWHEkCY+IaLaQkPlNYk14y76QB32uzns8zoLU2m0FR39ClUa
 3FGm5P2smwdJffaIomI318iC5/rkLwFqhdF24j7IHOY+inYbYKfbPOla+y5bXG75rUSmCuPbFgp
 9y5x97dCRaqHCz3eg+zOGzoQ1jgVnASc7i/VkulJEaR49lXsx9Jm28zwncS530Kh1xV/OujC2DO
 0VQHa8p2WYbY4vRwsawJBpJXoOIFeSDQZ4YuFcKodndGa8r3NXchVOM3Fy8Oz6OtlUgVGzT6xjM
 JCUOrqc+KQ2rA20FbCCAgfOUdLu2cLz/pk2Vgqkj6ZosJDxdHLh1a1W8+f6Y4R3pMoVXxs2pX0c
 lZbe
X-Received: by 2002:a05:600c:3b09:b0:499:59a1:96f7 with SMTP id
 5b1f17b1804b1-4998261b11fmr26856695e9.1.1786614383669; 
 Thu, 13 Aug 2026 02:46:23 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B911C009377EE8DF6D0A1C2.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:1c00:9377:ee8d:f6d0:a1c2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a568c40sm4870863f8f.13.2026.08.13.02.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 02:46:23 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/rockchip: vop2: Scale the AXI clock to the bandwidth
 the mode needs
Date: Thu, 13 Aug 2026 11:45:56 +0200
Message-ID: <20260813094614.9072-1-royalnet026@gmail.com>
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

Track the requirement as a global atomic state object rather than by
walking the CRTC list when the rate is applied.  Each CRTC records what
it needs during its own atomic check, and the rate applied is the
maximum over the ports.  Going through the atomic state is what makes
this safe: a commit only ever writes the entry for a CRTC it holds a
lock for, and never reads the state of a CRTC that a concurrent commit
may be swapping underneath it.  The rate the platform set up is used as
the lower bound, so a board that already configures a higher rate keeps
it.

Tested on the same board on drm-misc-next plus the dw-dp and Rockchip
USBDP PHY series, which DisplayPort Alt Mode needs in order to come up
at all: 3840x2160@120 selects 750 MHz and runs with no underrun,
dropping to 3840x2160@60 returns the clock to 500 MHz and stays clean,
and going back raises it again.  On that same kernel without this patch
the output shows no picture at any mode.

Link: https://lore.kernel.org/all/20260808104240.13776-1-royalnet026@gmail.com/
Link: https://lore.kernel.org/all/20767137.geO5KgaWL5@diego/ [1]
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v2:
 - Reworked how the requirement is tracked.  v1 computed the rate by walking
   the CRTC list at the point it applied it, which read the state of CRTCs the
   commit holds no lock for; a concurrent non-blocking commit on another CRTC
   can swap and free that state underneath.  Caught by the Sashiko AI review
   [2] before anyone had to trip over it.  v2 has each CRTC record its own
   requirement in a global atomic state object during its own atomic check and
   takes the maximum over the ports, so a commit never reads state it does not
   own.  The shape follows vc4's handling of its core clock, which is the same
   problem.
 - Retested on hardware with the new mechanism, since the old measurement no
   longer applies to it: 3840x2160@120 selects 750 MHz, dropping to
   3840x2160@60 returns the clock to 500 MHz, and going back raises it again,
   with no POST_BUF_EMPTY in any phase and nothing failing in the atomic path.

v1: https://lore.kernel.org/all/20260812104909.6390-1-royalnet026@gmail.com/
[2] https://lore.kernel.org/all/20260812105649.39CBA1F000E9@smtp.kernel.org/
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 107 +++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  19 ++++
 2 files changed, 126 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 4cce3e336f5b..fdee08042ac7 100644
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
@@ -1008,6 +1022,72 @@ static bool vop2_gamma_lut_in_use(struct vop2 *vop2, struct vop2_video_port *vp)
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
+	return &state->base;
+}
+
+static struct drm_private_state *
+vop2_aclk_duplicate_state(struct drm_private_obj *obj)
+{
+	struct vop2_aclk_state *state;
+
+	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
+
+	return &state->base;
+}
+
+static void vop2_aclk_destroy_state(struct drm_private_obj *obj,
+				    struct drm_private_state *state)
+{
+	kfree(to_vop2_aclk_state(state));
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
+static void vop2_apply_aclk_rate(struct vop2 *vop2, struct drm_atomic_commit *state)
+{
+	struct drm_private_state *priv_state;
+
+	if (vop2->version != VOP_VERSION_RK3588)
+		return;
+
+	priv_state = drm_atomic_get_new_private_obj_state(state, &vop2->aclk_obj);
+	if (!priv_state)
+		return;
+
+	clk_set_rate(vop2->aclk,
+		     vop2_aclk_rate(vop2, to_vop2_aclk_state(priv_state)));
+}
+
 static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 				     struct drm_atomic_commit *state)
 {
@@ -1053,6 +1133,8 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (!vop2->enable_count)
 		vop2_disable(vop2);
 
+	vop2_apply_aclk_rate(vop2, state);
+
 	vop2_unlock(vop2);
 
 	if (crtc->state->event && !crtc->state->active) {
@@ -1780,6 +1862,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2_lock(vop2);
 
+	vop2_apply_aclk_rate(vop2, state);
+
 	ret = clk_prepare_enable(vp->dclk);
 	if (ret < 0) {
 		drm_err(vop2->drm, "failed to enable dclk for video port%d - %d\n",
@@ -1993,6 +2077,20 @@ static int vop2_crtc_atomic_check(struct drm_crtc *crtc,
 	if (ret)
 		return ret;
 
+	if (vp->vop2->version == VOP_VERSION_RK3588) {
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
 
@@ -2875,6 +2973,8 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return dev_err_probe(drm->dev, PTR_ERR(vop2->aclk),
 				     "failed to get aclk source\n");
 
+	vop2->aclk_rate_normal = clk_get_rate(vop2->aclk);
+
 	vop2->pclk = devm_clk_get_optional(vop2->dev, "pclk_vop");
 	if (IS_ERR(vop2->pclk))
 		return dev_err_probe(drm->dev, PTR_ERR(vop2->pclk),
@@ -2944,6 +3044,11 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 
 	rockchip_drm_dma_init_device(vop2->drm, vop2->dev);
 
+	ret = drm_atomic_private_obj_init(vop2->drm, &vop2->aclk_obj,
+					  &vop2_aclk_state_funcs);
+	if (ret)
+		goto err_crtcs;
+
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
@@ -2960,6 +3065,8 @@ static void vop2_unbind(struct device *dev, struct device *master, void *data)
 
 	pm_runtime_disable(dev);
 
+	drm_atomic_private_obj_fini(&vop2->aclk_obj);
+
 	if (vop2->rgb)
 		rockchip_rgb_fini(vop2->rgb);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index ffcb39c130aa..df148dc61703 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -8,6 +8,7 @@
 #define _ROCKCHIP_DRM_VOP2_H
 
 #include <linux/regmap.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_modes.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
 #include "rockchip_drm_drv.h"
@@ -286,6 +287,21 @@ struct vop2_data {
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
+};
+
+#define to_vop2_aclk_state(x) container_of(x, struct vop2_aclk_state, base)
+
 struct vop2 {
 	u32 version;
 	struct device *dev;
@@ -326,6 +342,9 @@ struct vop2 {
 	unsigned int enable_count;
 	struct clk *hclk;
 	struct clk *aclk;
+	/* AXI clock rate set up by the platform, used as the lower bound. */
+	unsigned long aclk_rate_normal;
+	struct drm_private_obj aclk_obj;
 	struct clk *pclk;
 	struct clk *pll_hdmiphy0;
 	struct clk *pll_hdmiphy1;
-- 
2.43.0

