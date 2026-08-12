Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34866C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C6010EF68;
	Wed, 12 Aug 2026 10:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YUrrCIQk";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3715F10EF57
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:49:34 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495502852d1so786695e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786531772; x=1787136572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2htw98TlVcP+RIDb3b8KEcHym617Hw0Z8IMjX67kKx8=;
 b=YUrrCIQkBNrOnKQrG0brP22YO/5foOQDpLhiu7znMr7vuzmBc3GIb1KMb9DZUXdNO+
 heegmZ2QRkrR60acRnpMoXoPlnLy55LaX/43z9ie5MF18xEVhlKqOhm4CyGlR0+m7t6N
 eX88cCL9bPExcbI9aMXSWDaxKRRdoEHOQu+ldXzAQSnWLhzaKTV/yFmPmfQOGIGSs17o
 m6+40DorvQvkGffd8QKJ3ck7LW11CDxgUWsgDvsooNwg2oSXZv9JCOv8JsYG/3nhPcdX
 GIV+O5UnI2lApU4151Z48kBas9r5wgE6qGyxA2EdErGphAT/9a0WGZr1pPwqkihBSAGM
 GxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786531772; x=1787136572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2htw98TlVcP+RIDb3b8KEcHym617Hw0Z8IMjX67kKx8=;
 b=IDxH7oKendJBaigAK7BZ5rhnPAkvofRynK1G8bJOocWMrmO3vu/hAj5URPFtNC0qKL
 YBV8R4LoLfIz0QeePf/fWf6Ls+d9Sg/VaK0OVcMq1QyvFCftaT3Z1AzcE36kmC+/1VIT
 +/u18+eBtoXI58oKMZuUyhW6WkajdFC4FMkS/mKL26WZ+zLnGwVoLDqzPgn2AiQ8xxxD
 i4xS4UP6Ou3i8w9+DCDPgBYVdRTuckOyGx942tIbc43m3aNG0o+Cj5mU8GQ+ZOWAlRu3
 htn9FfnYx1eeuXHskaYAQh7pQ9D5CnF+B9mn8QLgbEfYOAjdVg+/Vq4+Dx846YPROLch
 5GiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNWQMqDYn6kOClXLgl6fmj9ktpafOAbKxkrqHY4Ngj1yPIWpo8n/98a81iQQh2JiEzZGkAVKZe0sk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPbZI2XMqxaEqWRuzzqq5kBhM7lVevrsCxVpc4FkzjgkcdWLi4
 SDBt20mb/Ph634awbOs0Prvy/c9LTeAzCfZmnD8hOcnkxGmd3Gw1OOf7
X-Gm-Gg: AR+sD12VLsdyBunkCsa2rQQjib9oO29g+egfOb42IUMRfha5lQjvVGv+pbq83sXB8mc
 /N54RtuH0mkdSYID4ombLxjhFE5wSbfl181Jt9S0h9HFUldQEFnHsX8oPwnMjRphFA619Mla+sW
 TxwUAbVqB1NNsbCq2VqGf+A71Y3U1S5yikHzJZx26FCnBxqReqrakXDHFTb52vihPqKQiEU4IPm
 2fT28b9pvRIbEgj98dO5E5BQxvXKH0gcE5mT5x65MCnzs8XG5lS9rf/RVDYurAkO0qnDxjA/ryL
 L0iN6c/dXWim5dhdPomfhoMoF/pCOESEXfL9sPgr8Jy/JjMrK6u6D9NVj+nVJ2PYBMifcgzVWrF
 Kd0oeLsd/V6d5DPRJPXeUBtUF5lpxQ+ds9Jyp5cuSoWrDBdMjwcMqBSv4CCsdpPrrTmAS7EVD/R
 uhgBiw8DgT3C0/Rd0/efqm5DSPGxQQDzd7uGTkP1E1PNkj3NnXrSxxsUmUqDa0s7HGJS0Eqau9d
 kqOBp7j1rGVWR0Gixkzmm4TCYOeELp3n9Uh5zDiv3SMaeIZ8ggs5vqbttsz1KsGGo8Rc/m1x2MF
 4LIm
X-Received: by 2002:a05:600c:1d02:b0:493:f42e:1b3f with SMTP id
 5b1f17b1804b1-4997c1412a8mr27209975e9.3.1786531772439; 
 Wed, 12 Aug 2026 03:49:32 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B84A600F9E120266BE3CC9B.dsl.pool.telekom.hu.
 [2001:4c4e:1b84:a600:f9e1:2026:6be3:cc9b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abf94c1sm60999775e9.14.2026.08.12.03.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:49:31 -0700 (PDT)
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
Subject: [PATCH] drm/rockchip: vop2: Scale the AXI clock to the bandwidth the
 mode needs
Date: Wed, 12 Aug 2026 12:49:04 +0200
Message-ID: <20260812104909.6390-1-royalnet026@gmail.com>
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

Take the maximum over the video ports that are scanning out rather than
counting them, so that disabling one port cannot drop the rate below
what a port that is still scanning needs.  The rate the platform set up
is used as the lower bound, so a board that already configures a higher
rate keeps it.

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
Cristian, this overlaps with your ACLK work: the condition here is not
FRL-specific, so it also covers the HDMI FRL case that 7e580d1cc3aa
handles in the rockchip-3588 branch.  I did not want to queue this
behind a series that is itself blocked, but I am equally happy to rebase
on top of yours, or to drop this if you would rather carry it.  Whatever
shape it takes should keep the FRL case working rather than replace it.

Chaoyi, thank you for the FIFO description and the downstream decision
flow - the per-port measurement above came directly out of that.

Based on drm-misc-next at c8d3d795dd40.  Tested on an Orange Pi 5 Plus;
DisplayPort Alt Mode there additionally needs the dw-dp series and the
Rockchip USBDP PHY series, neither of which is merged yet, so the test
kernel carried both.
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 46 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  2 +
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 4cce3e336f5b..5dda1fc1c8a1 100644
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
@@ -1008,6 +1022,32 @@ static bool vop2_gamma_lut_in_use(struct vop2 *vop2, struct vop2_video_port *vp)
 	return gamma_en_vp_id != nr_vps && gamma_en_vp_id != vp->id;
 }
 
+/*
+ * Pick the AXI clock rate that satisfies every video port that is scanning
+ * out.  Taking the maximum over the active ports rather than counting them
+ * means a port being disabled can never drop the rate below what a port that
+ * is still scanning needs.
+ */
+static void vop2_update_aclk_rate(struct vop2 *vop2)
+{
+	unsigned long rate = vop2->aclk_rate_normal;
+	struct drm_crtc *crtc;
+
+	if (vop2->version != VOP_VERSION_RK3588)
+		return;
+
+	drm_for_each_crtc(crtc, vop2->drm) {
+		if (!crtc->state->active)
+			continue;
+
+		if (crtc->state->adjusted_mode.crtc_clock > VOP2_HIGH_BW_PIXCLK_KHZ &&
+		    rate < VOP2_ACLK_RATE_HIGH)
+			rate = VOP2_ACLK_RATE_HIGH;
+	}
+
+	clk_set_rate(vop2->aclk, rate);
+}
+
 static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 				     struct drm_atomic_commit *state)
 {
@@ -1053,6 +1093,8 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (!vop2->enable_count)
 		vop2_disable(vop2);
 
+	vop2_update_aclk_rate(vop2);
+
 	vop2_unlock(vop2);
 
 	if (crtc->state->event && !crtc->state->active) {
@@ -1780,6 +1822,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2_lock(vop2);
 
+	vop2_update_aclk_rate(vop2);
+
 	ret = clk_prepare_enable(vp->dclk);
 	if (ret < 0) {
 		drm_err(vop2->drm, "failed to enable dclk for video port%d - %d\n",
@@ -2875,6 +2919,8 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return dev_err_probe(drm->dev, PTR_ERR(vop2->aclk),
 				     "failed to get aclk source\n");
 
+	vop2->aclk_rate_normal = clk_get_rate(vop2->aclk);
+
 	vop2->pclk = devm_clk_get_optional(vop2->dev, "pclk_vop");
 	if (IS_ERR(vop2->pclk))
 		return dev_err_probe(drm->dev, PTR_ERR(vop2->pclk),
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index ffcb39c130aa..50a3513c89ab 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -326,6 +326,8 @@ struct vop2 {
 	unsigned int enable_count;
 	struct clk *hclk;
 	struct clk *aclk;
+	/* AXI clock rate set up by the platform, used as the lower bound. */
+	unsigned long aclk_rate_normal;
 	struct clk *pclk;
 	struct clk *pll_hdmiphy0;
 	struct clk *pll_hdmiphy1;
-- 
2.43.0

