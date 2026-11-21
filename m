Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56B606A32C
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doU5WfRu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C581B10E2FD;
	Sat, 21 Nov 2026 08:01:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C56D10E2FD
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 08:01:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C0D960D54;
 Sat, 21 Nov 2026 08:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9566B1F000C4;
 Sat, 21 Nov 2026 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795248083;
 bh=/nBFQZEJTSgaKpZnb3TrHVbaCxmksYr/v0Om85PtszQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=doU5WfRuRItUWINkETRxe211mtgU7E7hyrpX4ipDCYohHZ6Iu7F4qxin2F2AsPJBL
 98c34PQmK1nYOFqLHTmXAp/6aWxnpKsiTyxq0Ayp64Rb/Hdep96D/+wnCkCUnPlSZZ
 2UWFb7XJ/P3Sb3Lv3HvEDDJln0DfJ1134NNbXUOgdEkOfPXMEjlT+r27hoYq02e1YA
 wx5+8FMQEaE4Q/FY5K0vYop2d3BKQ//ah35vbtRP0REX+jr+qTSRwMZ4bD/t2UFRGt
 ACg2ZfKh8lfypRt//z3D1+WY4rd8DYnvPUBdEBOPSl5UA8sIFWGwLuQJgdb6I7Gy0Z
 WsghsAfJHwk1w==
Message-ID: <sashiko-outbox-226811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/17] drm/spacemit: add Saturn DPU hardware backend
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 olteanv@gmail.com
In-Reply-To: <20261121-k3-display-v3-9-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <20261121-k3-display-v3-9-ec419e8e96b8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 08:01:22 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/spacemit: vfp underflow in saturn_init_tmg() when front
  porch < 7
- [High] drm/spacemit: unmasked IRQ dispatch and premature vblank event
  in ISR
- [Medium] drm/spacemit: stale underrun IRQ and ur_mask_armed race on
  CFG_RDY
- [Medium] drm/spacemit: race on cfg_rdy_timer and INT_CFG_RDY in
  spacemit_dpu_run()
--

commit feb91f776850387e06b93738a2a9ed3971674069
Author: Cody Kang <codykang@vsit.ai>

drm/spacemit: add Saturn DPU hardware backend

This commit adds the Saturn DPU hardware backend, covering clock setup,
scene control and timing generator programming, RDMA channel and composer
configuration, line-buffer sizing, and interrupt handling.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c b/drivers/gpu/drm/=
spacemit/dpu/dpu_saturn.c
> new file mode 100644
> index 0000000000000..704e64fb9ec7e
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c
> @@ -0,0 +1,353 @@

[ ... ]

> +/* Complete a commit whose lists the engine will not confirm any more. */
> +void spacemit_dpu_complete_event(struct spacemit_crtc *a_crtc)
> +{
> +	struct drm_crtc *crtc =3D &a_crtc->crtc;
> +	struct drm_pending_vblank_event *event;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&crtc->dev->event_lock, flags);
> +	event =3D a_crtc->event;
> +	a_crtc->event =3D NULL;
> +	if (event)
> +		drm_crtc_send_vblank_event(crtc, event);
> +	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> +
> +	if (event)
> +		drm_crtc_vblank_put(crtc);
> +}
> +
> +void spacemit_cfg_rdy_timer_handler(struct timer_list *t)
> +{
> +	struct spacemit_crtc *a_crtc =3D timer_container_of(a_crtc, t,
> +							  cfg_rdy_timer);
> +
> +	drm_err_ratelimited(a_crtc->crtc.dev, "CFG_RDY handshake timeout\n");
> +	/* A CFG_RDY that still comes belongs to no commit any more. */
> +	saturn_hee_enable_irq(a_crtc, INT_CFG_RDY, false);
> +	spacemit_dpu_complete_event(a_crtc);
> +}

[ ... ]

> +/* Returns false when none of the pending status bits was this CRTC's. */
> +bool spacemit_dpu_online_isr(struct spacemit_crtc *a_crtc)
> +{
> +	u32 irq_raw, irq_bit, irq_ur_bit, handled;
> +	struct spacemit_drm_private *priv =3D a_crtc->crtc.dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +
> +	irq_raw =3D saturn_hee_get_int_sts(hwdev);
> +	irq_bit =3D saturn_hee_get_irq_bit(INT_UNDERRUN);
> +	irq_ur_bit =3D irq_raw & irq_bit;
> +	handled =3D irq_ur_bit;
> +	if (irq_ur_bit && !a_crtc->ur_reported) {
> +		saturn_hee_clr_int_sts(a_crtc, irq_ur_bit);
> +		drm_err_ratelimited(a_crtc->crtc.dev, "underrun\n");
> +		a_crtc->ur_reported =3D true;
> +	}
> +	irq_bit =3D saturn_hee_get_irq_bit(INT_CFG_RDY);
> +	if (irq_raw & irq_bit) {
> +		saturn_hee_clr_int_sts(a_crtc, irq_bit);
> +		timer_delete(&a_crtc->cfg_rdy_timer);
> +		a_crtc->ur_reported =3D false;
> +		saturn_hee_enable_irq(a_crtc, INT_CFG_RDY, false);
> +		handled |=3D irq_bit;
> +
> +		/* The lists are taken: the next vblank completes the commit. */
> +		spin_lock(&a_crtc->crtc.dev->event_lock);
> +		if (a_crtc->event) {
> +			drm_crtc_arm_vblank_event(&a_crtc->crtc, a_crtc->event);
> +			a_crtc->event =3D NULL;
> +		}
> +		spin_unlock(&a_crtc->crtc.dev->event_lock);
> +	}
> +	irq_bit =3D saturn_hee_get_irq_bit(INT_VSYNC);
> +	if (irq_raw & irq_bit) {
> +		saturn_hee_clr_int_sts(a_crtc, irq_bit);
> +		drm_crtc_handle_vblank(&a_crtc->crtc);
> +		handled |=3D irq_bit;
> +	}
> +	irq_bit =3D saturn_hee_get_irq_bit(INT_REST) | irq_ur_bit;
> +	if (irq_raw & irq_bit) {
> +		saturn_hee_clr_int_sts(a_crtc, irq_bit);
> +		handled |=3D irq_raw & irq_bit;
> +	}
> +
> +	return handled;
> +}

[Severity: High]
Can spacemit_dpu_online_isr() complete a commit's vblank event a frame
early when INT_CFG_RDY and INT_VSYNC are both set in irq_raw?

As noted in saturn_hee_irq_enable() and spacemit_dpu_run(),
DPU_ONLINE_IRQ_STS latches status bits even while their mask bits in
DPU_ONLINE_IRQ_MSK are cleared, yet saturn_hee_enable_irq() unmasks
interrupts without clearing DPU_ONLINE_IRQ_STS first and
spacemit_dpu_online_isr() does not mask irq_raw against
DPU_ONLINE_IRQ_MSK.  When INT_CFG_RDY fires while INT_VSYNC is also set
(either from a frame boundary or latched while vblank was masked), the
INT_CFG_RDY branch calls drm_crtc_arm_vblank_event() and the following
INT_VSYNC branch immediately calls drm_crtc_handle_vblank() in the same
ISR invocation.  That delivers the flip event before the next vblank and
unblocks drm_atomic_helper_wait_for_flip_done() early, allowing the next
commit to overwrite the active command list slot.

> +
> +void spacemit_dpu_run(struct drm_crtc *crtc, struct drm_atomic_commit *s=
tate)
> +{
> +	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
> +	struct spacemit_drm_private *priv =3D a_crtc->crtc.dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +
> +	saturn_hee_conf_dpuctrl(crtc, state);
> +
> +	/* flush all config register writes before CFG_RDY is raised */
> +	mb();
> +
> +	/* Ack first: one left by a commit that timed out is not this one's. */
> +	saturn_hee_clr_int_sts(a_crtc, saturn_hee_get_irq_bit(INT_CFG_RDY));
> +	saturn_hee_enable_irq(a_crtc, INT_CFG_RDY, true);
> +
> +	mod_timer(&a_crtc->cfg_rdy_timer,
> +		  jiffies + msecs_to_jiffies(SATURN_CFG_RDY_TIMEOUT_MS));
> +	saturn_hee_cfg_ready(a_crtc, hwdev);
> +
> +	if (unlikely(a_crtc->is_1st_f)) {
> +		drm_dbg(a_crtc->crtc.dev, "DPU start\n");
> +		a_crtc->is_1st_f =3D false;
> +		saturn_hee_sw_start(a_crtc, hwdev);
> +	}
> +}

[Severity: Medium]
Can spacemit_cfg_rdy_timer_handler() race with spacemit_dpu_online_isr()
and spacemit_dpu_run() to complete the next commit's vblank event early or
leave INT_CFG_RDY masked?

CPU0 (<softirq>)                  CPU1
spacemit_cfg_rdy_timer_handler()
  drm_err_ratelimited(...)
                                  <hardirq>
                                  spacemit_dpu_online_isr()
                                    timer_delete(&a_crtc->cfg_rdy_timer)
                                    drm_crtc_arm_vblank_event(...)
                                    drm_crtc_handle_vblank(...)
                                  spacemit_crtc_atomic_flush()
                                    a_crtc->event =3D new_event
                                    spacemit_dpu_run()
                                      saturn_hee_enable_irq(..., true)
  saturn_hee_enable_irq(..., false)
  spacemit_dpu_complete_event()
    drm_crtc_send_vblank_event()  <-- completes new commit early

timer_delete() in spacemit_dpu_online_isr() does not wait for an in-flight
spacemit_cfg_rdy_timer_handler(), so the timer callback can mask the next
commit's INT_CFG_RDY and complete its a_crtc->event before the hardware
consumes its command lists.

In addition, spacemit_dpu_run() unmasks INT_CFG_RDY before mod_timer() and
saturn_hee_cfg_ready().  If a late CFG_RDY from a previously timed-out
commit arrives right after saturn_hee_enable_irq(a_crtc, INT_CFG_RDY,
true), spacemit_dpu_online_isr() runs timer_delete() before the timer is
armed, masks INT_CFG_RDY, and arms a_crtc->event before both_cfg_rdy is
written for the new commit.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c b/drivers/gpu/=
drm/spacemit/dpu/dpu_saturn_hee.c
> new file mode 100644
> index 0000000000000..1a194fe7cc7ba
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c
> @@ -0,0 +1,670 @@

[ ... ]

> +void saturn_hee_enable_irq(struct spacemit_crtc *a_crtc,
> +			   enum spacemit_dpu_irq irq_id, bool enable)
> +{
> +	saturn_enable_irq_mask(a_crtc, enable,
> +			       DPU_INT_BASE_ADDR + DPU_ONLINE_IRQ_MSK,
> +			       saturn_hee_get_irq_bit(irq_id));
> +}
> +
> +void saturn_hee_cfg_ready(struct spacemit_crtc *a_crtc,
> +			  struct spacemit_hw_device *hwdev)
> +{
> +	u32 base =3D DPU_SCENE_CTL_ADDR(COMPOSER1);
> +
> +	saturn_hee_enable_irq(a_crtc, INT_UNDERRUN, true);
> +	a_crtc->ur_mask_armed =3D true;
> +	dpu_write(hwdev, DPU_CTL_REG, base, both_cfg_rdy, 1);
> +}

[Severity: Medium]
Does enabling INT_UNDERRUN in saturn_hee_cfg_ready() before setting
a_crtc->ur_mask_armed and without clearing DPU_ONLINE_IRQ_STS race with
spacemit_dpu_online_isr()?

saturn_hee_cfg_ready()
  saturn_hee_enable_irq(a_crtc, INT_UNDERRUN, true)
  <hardirq>
    spacemit_dpu_online_isr()
      saturn_hee_clr_int_sts(a_crtc, ...)
        if (... && a_crtc->ur_mask_armed)  <-- still false; stays unmasked
  a_crtc->ur_mask_armed =3D true

After an underrun, INT_UNDERRUN is masked for the rest of the frame while
the hardware continues latching DPU_INT_FRM_TIMING_UNFLOW in
DPU_ONLINE_IRQ_STS.  When the next commit calls saturn_hee_cfg_ready(),
unmasking INT_UNDERRUN without clearing DPU_ONLINE_IRQ_STS immediately
triggers spacemit_dpu_online_isr().  If the interrupt arrives before
a_crtc->ur_mask_armed =3D true (which also happens in
saturn_hee_irq_enable()), saturn_hee_clr_int_sts() sees ur_mask_armed =3D=3D
false and leaves INT_UNDERRUN unmasked; if it arrives after
ur_mask_armed =3D true but before INT_CFG_RDY clears ur_reported, the bottom
saturn_hee_clr_int_sts() call in spacemit_dpu_online_isr() immediately
masks INT_UNDERRUN again before the new commit takes effect.

> +
> +void saturn_hee_sw_start(struct spacemit_crtc *a_crtc,
> +			 struct spacemit_hw_device *hwdev)
> +{
> +	u32 base;
> +
> +	base =3D DPU_SCENE_CTL_ADDR(COMPOSER1);
> +	dpu_write_reg(hwdev, DPU_CTL_REG, base, sw_start, 1);
> +}
> +
> +static void saturn_init_tmg(struct spacemit_crtc *a_crtc,
> +			    const struct drm_display_mode *mode)
> +{
> +	u32 base =3D TMG0_BASE_ADDR;
> +	struct spacemit_drm_private *priv =3D a_crtc->crtc.dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +	u16 vfp, vbp, vsync, hfp, hbp, hsync;
> +	void __iomem *tmg_addr;
> +	u32 value;
> +
> +	tmg_addr =3D hwdev->base + TMG0_BASE_ADDR;
> +
> +	hsync =3D mode->hsync_end - mode->hsync_start;
> +	hbp =3D mode->htotal - mode->hsync_end;
> +	hfp =3D mode->hsync_start - mode->hdisplay;
> +	vsync =3D mode->vsync_end - mode->vsync_start;
> +	vbp =3D mode->vtotal - mode->vsync_end;
> +	vfp =3D mode->vsync_start - mode->vdisplay;
> +	drm_dbg(a_crtc->crtc.dev, "timing " DRM_MODE_FMT "\n", DRM_MODE_ARG(mod=
e));
> +
> +	dpu_write(hwdev, TMG_REG, base, disp_ready_man_en, 0);
> +	dpu_write(hwdev, TMG_REG, base, background_r, 0);
> +	dpu_write(hwdev, TMG_REG, base, background_g, 0x0);
> +	dpu_write(hwdev, TMG_REG, base, background_b, 0xff);
> +	dpu_write(hwdev, TMG_REG, base, eof_1st_ln_dly_num, vfp - 7);
> +	dpu_write(hwdev, TMG_REG, base, eof_2nd_ln_dly_num, vfp - 6);
> +	dpu_write(hwdev, TMG_REG, base, split_en, 0);
> +	dpu_write(hwdev, TMG_REG, base, cmd_screen, 0);
> +	dpu_write(hwdev, TMG_REG, base, cmd_wait_en, 0);
> +	dpu_write(hwdev, TMG_REG, base, cmd_wait_te, 0);
> +	dpu_write(hwdev, TMG_REG, base, sof_pre_ln_num, 0);
> +	dpu_write(hwdev, TMG_REG, base, hfp, hfp);
> +	dpu_write(hwdev, TMG_REG, base, hbp, hbp);
> +	dpu_write(hwdev, TMG_REG, base, vfp, vfp);
> +	dpu_write(hwdev, TMG_REG, base, vbp, vbp);
> +	dpu_write(hwdev, TMG_REG, base, hsync_width, hsync);
> +	dpu_write(hwdev, TMG_REG, base, vsync_width, vsync);
> +	dpu_write(hwdev, TMG_REG, base, hsp, 1);
> +	dpu_write(hwdev, TMG_REG, base, vsp, 1);
> +	dpu_write(hwdev, TMG_REG, base, h_active, mode->hdisplay);
> +	dpu_write(hwdev, TMG_REG, base, v_active, mode->vdisplay);
> +	dpu_write(hwdev, TMG_REG, base, fm_timing_en, 1);
> +	/* The pipeline always hands RGB888 to the DP/eDP encoder. */
> +	dpu_write(hwdev, TMG_REG, base, user, OUTFMT_RGB888);
> +
> +	value =3D readl(tmg_addr + 4 * dpu_field_word(TMG_REG, vfp));
> +	value &=3D ~dpu_field_mask(TMG_REG, vfp);
> +	value |=3D vfp;
> +	writel(value, tmg_addr + 4 * dpu_field_word(TMG_REG, vfp));

[Severity: High]
Does vfp - 7 and vfp - 6 underflow when the display mode's vertical front
porch is smaller than 7 lines?

Standard modes such as 1920x1080@60Hz (vdisplay =3D 1080, vsync_start =3D
1084, so vfp =3D 4) have vfp < 7, which wraps the 16-bit eof_1st_ln_dly_num
and eof_2nd_ln_dly_num fields to 0xfff9..0xffff, exceeding vtotal so the
EOF line-delay counters cannot fire within the frame.  Also, the raw
readl()/writel() sequence at the end of saturn_init_tmg() redundantly
rewrites the same vfp field that dpu_write(hwdev, TMG_REG, base, vfp, vfp)
just programmed above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-k3-display=
-v3-0-ec419e8e96b8@gmail.com?part=3D9
