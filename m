Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121B6071A46
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3EEzT6h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7CF10FBDF;
	Thu, 12 Nov 2026 08:33:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB08B10FC6B
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:33:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B504563E3F;
 Thu, 12 Nov 2026 08:33:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794472389;
 b=MysG8S5LL7JgUkNrt83TYQX89xfWzdYZ/MRaeH+1rqPE2vtw/hYK60xWOGhbTDPlebkz
 omj6SKoRIQNmudmWzrmmTI1vLncjeZWqCij2jeBLZQWjv/gGI8xN5RuvPK4TvLongmyOK
 ipTiqQlkMnjtNCg0y4EnD1X0UGK4Ey0ra445MW55J9s0tfXzq/9TLSHJDnOnsLrJOZ0Hc
 87M1TVVmvfE/BtF+sV32q683Rz2YVBUWqs6Mk5GJKznZUjnE+XqGjxILt98cYInC6UOp/
 TRVVeTczfJrSgsdjzjN3Z8RRoH3IHS5L5ajCb0CCEU5MHBwqtlEuvwZOxA4LmHO2TUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794472389;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=qeVQnf/pV/NdnjPqBAkllw+s+Gw9i4R4C0EMLFiQBzE=;
 b=sUaAgmOBOQYKjVzfBxVp8/YISDfLi3j4zlYC07ITewRpqzrmZoq53+dav/AINsPfRSon
 RmEqN6OBPiQKaWMZjsX6kFdHuaf0HIVy91ipJRk00nJ8IXlGQeewYU/dtTmo5SDG0owua
 h+ucUOzZnSz/lvpqCcJKvnMps+Hf5VaC2IhsVB5dZNc/hh/0EDMnvArVhlxQYxJGy5i97
 gYo4qI1jJBQ3REEBp7hrtEKtYTLSVf/3xciREzi1D0Ju8Epo88g1JcvDIwJWVFdvI9/Qg
 P1GZTTmIqL0LfE0jD8AzReP+fue/E5Jei60m5VT6fqBiTl85oM3zyp6r+uICcGfOFdg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F0CCD1F00A11;
 Thu, 12 Nov 2026 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794472389;
 bh=qeVQnf/pV/NdnjPqBAkllw+s+Gw9i4R4C0EMLFiQBzE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=G3EEzT6hxqgxm1Y7QBaKdF/SmBPDQ5ByDq9IsXFwtsoV9YYi7dcZ/0As1kmNtKtsf
 Im95TyLTJmwWEICISu3ml9vJ0//YdoXQiO2DxAOf0yHp1VpBFmDlihz0e5gUxGKIhY
 b5OhXrhedqQaNh9gTiU35TPVFZcciOZL3PWmQTLBIb6jN0DCpSBQek9pqztuSOgez0
 rOl9She9xjPiP3+lUQo7dmpjqBG2xPGsrRPbR1c4URvaHo8w9UpHcIwsD+mHwbD8z+
 XhlHejQgzemuwkKukT0cNH/8ZXuRYoCmh98hDyaQdDWbksYTY6tHzu/zvi369Ux18V
 XK8976vmi9F1g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B3EE8493BA;
 Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:33:10 +0000
Subject: [PATCH v2 6/9] drm/rockchip: vop2: Report POST_BUF_EMPTY at most
 once per frame
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-vop2-fixes-v2-6-8218c1cf8ac8@gmail.com>
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
In-Reply-To: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472385; l=8539;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=P8K1PT4b6yUDtx6AlIkcL335r68htdrkK9c22XrHyII=;
 b=Sjp/4XQjVQRhKDuPvgGl84BlvXEa4fiNbBN+bEBXBua62V0f7CZ4Qx57q0V9qfGr6kRRg9c+w
 mAFUP83cObXCxa6y+iiw0RHvfPHKv3CzKLqfJBaq07qMjcg5b6Bz8xv
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

POST_BUF_EMPTY is raised for every line on which the post processing
stage of a video port finds no data. The interrupt handler only
rate-limits the error message and leaves the interrupt enabled, so an
underflowing video port keeps the CPU in the interrupt handler 50000 to
300000 times per second, for as long as the configuration that causes
the underflow stays in place (e.g. 120000 interrupts per second for
3840x2160@120 with two full screen layers on one AXI port).

Mask POST_BUF_EMPTY when it fires and unmask it at the next frame start.
The frame start (FS) interrupt is enabled for that frame even when
vblank reporting is off, and disabled again once POST_BUF_EMPTY is
re-armed or the video port is switched off. VP_INT_EN is write-masked,
so masking POST_BUF_EMPTY leaves FS alone; FS only needs enabling here
while vblank reporting has it off. A new per video port lock
serialises the interrupt enable bookkeeping between the interrupt
handler and the vblank callbacks. The error is still reported, now at
most once per frame and video port.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 91 ++++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 10 +++
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 684fa46924e7..c59e270739b6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -842,6 +842,70 @@ static void vop2_crtc_disable_irq(struct vop2_video_port *vp, u32 irq)
 	vop2_writel(vop2, RK3568_VP_INT_EN(vp->id), irq << 16);
 }
 
+/*
+ * POST_BUF_EMPTY is raised for every line the post processing stage finds
+ * no data for, so an underflowing video port can raise it 100000 times per
+ * second. Report it at most once per frame: mask it when it fires and
+ * unmask it at the next frame start, using the FS interrupt even when
+ * vblank reporting is off.
+ */
+/* Forget a pending re-arm, called with vp->irq_lock held */
+static void vop2_crtc_unmask_post_buf_empty(struct vop2_video_port *vp)
+{
+	if (vp->post_buf_empty_masked && !vp->vblank_enabled)
+		vop2_crtc_disable_irq(vp, VP_INT_FS_FIELD);
+	vp->post_buf_empty_masked = false;
+}
+
+static void vop2_crtc_enable_post_buf_empty_irq(struct vop2_video_port *vp)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vp->irq_lock, flags);
+	vop2_crtc_unmask_post_buf_empty(vp);
+	vop2_crtc_enable_irq(vp, VP_INT_POST_BUF_EMPTY);
+	spin_unlock_irqrestore(&vp->irq_lock, flags);
+}
+
+static void vop2_crtc_disable_post_buf_empty_irq(struct vop2_video_port *vp)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vp->irq_lock, flags);
+	vop2_crtc_disable_irq(vp, VP_INT_POST_BUF_EMPTY);
+	vop2_crtc_unmask_post_buf_empty(vp);
+	spin_unlock_irqrestore(&vp->irq_lock, flags);
+}
+
+static void vop2_crtc_handle_post_buf_empty(struct vop2_video_port *vp)
+{
+	spin_lock(&vp->irq_lock);
+	vop2_crtc_disable_irq(vp, VP_INT_POST_BUF_EMPTY);
+	vp->post_buf_empty_masked = true;
+	/*
+	 * POST_BUF_EMPTY is unmasked again by the FS interrupt at the next
+	 * frame start, so FS must be enabled. With vblank reporting on it
+	 * is already, and a pending FS may carry a vblank event. Otherwise
+	 * enable it here, clearing the FS status of the current frame so
+	 * that FS fires at the next frame start only.
+	 */
+	if (!vp->vblank_enabled)
+		vop2_crtc_enable_irq(vp, VP_INT_FS_FIELD);
+	spin_unlock(&vp->irq_lock);
+}
+
+static void vop2_crtc_rearm_post_buf_empty(struct vop2_video_port *vp)
+{
+	spin_lock(&vp->irq_lock);
+	if (vp->post_buf_empty_masked) {
+		vp->post_buf_empty_masked = false;
+		vop2_crtc_enable_irq(vp, VP_INT_POST_BUF_EMPTY);
+		if (!vp->vblank_enabled)
+			vop2_crtc_disable_irq(vp, VP_INT_FS_FIELD);
+	}
+	spin_unlock(&vp->irq_lock);
+}
+
 static int vop2_core_clks_prepare_enable(struct vop2 *vop2)
 {
 	int ret;
@@ -1095,6 +1159,7 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 		drm_info(vop2->drm, "wait for vp%d dsp_hold timeout\n", vp->id);
 
 	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
+	vop2_crtc_disable_post_buf_empty_irq(vp);
 
 	if (vp->dclk_src)
 		clk_set_parent(vp->dclk, vp->dclk_src);
@@ -1884,8 +1949,14 @@ static const struct drm_plane_funcs vop2_plane_funcs = {
 static int vop2_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
+	unsigned long flags;
 
-	vop2_crtc_enable_irq(vp, VP_INT_FS_FIELD);
+	spin_lock_irqsave(&vp->irq_lock, flags);
+	vp->vblank_enabled = true;
+	/* FS is enabled already while POST_BUF_EMPTY waits to be re-armed */
+	if (!vp->post_buf_empty_masked)
+		vop2_crtc_enable_irq(vp, VP_INT_FS_FIELD);
+	spin_unlock_irqrestore(&vp->irq_lock, flags);
 
 	return 0;
 }
@@ -1893,8 +1964,13 @@ static int vop2_crtc_enable_vblank(struct drm_crtc *crtc)
 static void vop2_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
+	unsigned long flags;
 
-	vop2_crtc_disable_irq(vp, VP_INT_FS_FIELD);
+	spin_lock_irqsave(&vp->irq_lock, flags);
+	vp->vblank_enabled = false;
+	if (!vp->post_buf_empty_masked)
+		vop2_crtc_disable_irq(vp, VP_INT_FS_FIELD);
+	spin_unlock_irqrestore(&vp->irq_lock, flags);
 }
 
 static enum drm_mode_status vop2_crtc_mode_valid(struct drm_crtc *crtc,
@@ -2193,7 +2269,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vcstate->yuv_overlay = is_yuv_output(vcstate->bus_format);
 
-	vop2_crtc_enable_irq(vp, VP_INT_POST_BUF_EMPTY);
+	vop2_crtc_enable_post_buf_empty_irq(vp);
 
 	polflags = 0;
 	if (vcstate->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
@@ -2342,6 +2418,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 	return;
 
 err_put_enable_count:
+	vop2_crtc_disable_post_buf_empty_irq(vp);
 	if (!--vop2->enable_count)
 		vop2_disable(vop2);
 
@@ -2751,6 +2828,7 @@ static irqreturn_t rk3576_vp_isr(int irq, void *data)
 	}
 
 	if (irqs & VP_INT_FS_FIELD) {
+		vop2_crtc_rearm_post_buf_empty(vp);
 		drm_crtc_handle_vblank(crtc);
 		spin_lock(&crtc->dev->event_lock);
 		if (vp->event) {
@@ -2768,6 +2846,7 @@ static irqreturn_t rk3576_vp_isr(int irq, void *data)
 	}
 
 	if (irqs & VP_INT_POST_BUF_EMPTY) {
+		vop2_crtc_handle_post_buf_empty(vp);
 		drm_err_ratelimited(vop2->drm, "POST_BUF_EMPTY irq err at vp%d\n", vp->id);
 		ret = IRQ_HANDLED;
 	}
@@ -2807,6 +2886,7 @@ static irqreturn_t vop2_isr(int irq, void *data)
 			}
 
 			if (irqs & VP_INT_FS_FIELD) {
+				vop2_crtc_rearm_post_buf_empty(vp);
 				drm_crtc_handle_vblank(crtc);
 				spin_lock(&crtc->dev->event_lock);
 				if (vp->event) {
@@ -2824,6 +2904,7 @@ static irqreturn_t vop2_isr(int irq, void *data)
 			}
 
 			if (irqs & VP_INT_POST_BUF_EMPTY) {
+				vop2_crtc_handle_post_buf_empty(vp);
 				drm_err_ratelimited(vop2->drm,
 						    "POST_BUF_EMPTY irq err at vp%d\n",
 						    vp->id);
@@ -3200,7 +3281,7 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 	struct vop2 *vop2;
 	struct resource *res;
 	size_t alloc_size;
-	int ret;
+	int ret, i;
 
 	vop2_data = of_device_get_match_data(dev);
 	if (!vop2_data)
@@ -3317,6 +3398,8 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 
 	mutex_init(&vop2->vop2_lock);
 	mutex_init(&vop2->ovl_lock);
+	for (i = 0; i < ARRAY_SIZE(vop2->vps); i++)
+		spin_lock_init(&vop2->vps[i].irq_lock);
 
 	ret = devm_request_irq(dev, vop2->irq, vop2_isr, IRQF_SHARED, dev_name(dev), vop2);
 	if (ret)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 48a852fec2bf..ccbfbdb8d246 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -297,6 +297,16 @@ struct vop2_video_port {
 	struct drm_pending_vblank_event *event;
 
 	unsigned int nlayers;
+
+	/** @irq_lock: protects @vblank_enabled and @post_buf_empty_masked */
+	spinlock_t irq_lock;
+	/** @vblank_enabled: the FS interrupt is enabled for vblank reporting */
+	bool vblank_enabled;
+	/**
+	 * @post_buf_empty_masked: POST_BUF_EMPTY is masked until the next
+	 * frame start
+	 */
+	bool post_buf_empty_masked;
 };
 
 /**

-- 
2.55.0


