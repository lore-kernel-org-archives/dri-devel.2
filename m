Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACD7C5B560
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E82110E669;
	Mon, 10 Aug 2026 06:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TQ222sm4";
	dkim-atps=neutral
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com
 [74.125.227.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FB510E0BC
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:49:04 +0000 (UTC)
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-38dc4f9462cso440737a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786236544; x=1786841344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k4gLQSSvHFbbcD/PCjPR8KRUycx+GtAIg2mZ1cizCqU=;
 b=TQ222sm46dPbs/4cJdIuTx933/NgH5sk7RKV/3e+IIKU6d3wk9H6Ot+hkSpd51mDRz
 PsO89d7y1VpDQQv4IkrL2SgmYSvgYbsoaOsLKY3wTUaFGsMrnwhTIGL+YHtPam7y3uJR
 PwZCkRqOKsFXqJ2GOnVJ7r34xWMblE952A5gzL2jYxSprC32+DU8GFzMjNHoVTw73xsp
 P3QiPRDppTHIB6eveAuKIMFOI605QxoLpTTJRZwgOl1EJzn3wLJWNJ76W+yUVNiV0IRN
 BgawUkR7R3EOeMPgDYbZ3dUBeoZL416z9L3r8/hEu3QU2IRr3YiPn7adcLsmoLoIrmRR
 8Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786236544; x=1786841344;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k4gLQSSvHFbbcD/PCjPR8KRUycx+GtAIg2mZ1cizCqU=;
 b=jekvjwJX4wbhnisI5mUc/Tjd9wWj9NZcsuFlwQUGFWyRKhbUyH3oHlo9NluSNRiZWr
 cOUJ20f6UVddRWZSiR0x3cjHc+A+5ihR4q7vAcCOLhyQaMOIWk1XiS/ZsX+cYKWkNPMJ
 hKeJG9UYUpng18u2jbHY/HQqexKhWzV8XklTUgej3leT+LnDSks3ECyOtBHHHFZFRdl5
 HYpwcoR+edH7Y33PQdYFKnED9rg5sdCLbB2A6L2g6s3uBhOeYuAU8hAOcMr7ZOXI3iDi
 t6PmvfzuAFU8AGMie97zoA5AoNmcXTzBdxQeSRw9SPO8x9yHaIy9B0zwHyePZGjJAOYd
 BcUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoI0tpErJLGU0rt6ikApcqMfN437y8gq+e6Mcft64oGdZb3JCPWtjCXD0Evfd6PPwDTm2vaDBiyP1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbzxC5pKEsNTKqowS8B6oqH9NZxVv1Qnr0RTG3XdQyUh8j+yBO
 jQgQdb4+rzHpH1kTHDQG8jOguBsQNVaIRK1ziTsY3i7fxnmMLBEAlNHizIM3uuVz/VKCsg==
X-Gm-Gg: AR+sD12P8ar7PUYr+Fq5f3IdAadvCTLmDZ5U4oNaP44c0PnfAA2LgGUHUdDPfvPgQKR
 eL3rjJOhOes1FqWXqsceTGMeUhrQxOsCXnyZ0SxeSXZhBp+snoCZk1QrP86qBmxrFevG4U3oxqW
 +HBdJvtFUp85Oef1MS3RhWnUWDrM13YeA/7FuOJdzmr6rJ11zGsYNsMc1xaBKDPZBDdFYig7Di6
 yjsmCyOTr8OCpYt//hu/8qOm4uvWQ9nf7QwNkUUz1+PqzcpwqcnCjt2dr0ZuenmhRLiwwMbLF3T
 T9khiDDeJGUC4RZCDMj0PthesixRHCfNezMA9iEtVRH1t1csExv2Ul2aaAx34J4IuP0l3TtivIp
 +gRVxAavt/8osIzc02LudHFSkeuOEd/2RjhhJ7vpyIoc0rRc1oHrtDJwER9bkujOQHkCk0Bx+7z
 9as5CBvqvDY1RuFCOvpOp4D+oAoRhhnCZgAnzAcs8=
X-Received: by 2002:a17:90b:3846:b0:38e:f6eb:2b38 with SMTP id
 98e67ed59e1d1-3903c5b4c53mr32379692a91.17.1786236543501; 
 Sat, 08 Aug 2026 17:49:03 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085f2b2easm9786281a91.11.2026.08.08.17.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 17:49:02 -0700 (PDT)
Date: Sun, 09 Aug 2026 08:48:58 +0800
Message-ID: <685ca4bf1080dbdcc244eba62ed5c03e.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 vkoul@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 olteanv@gmail.com, neil.armstrong@linaro.org, conor+dt@kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH 09/17] drm/spacemit: add Saturn DPU hardware backend
In-Reply-To: <20260725052202.C6AEE1F000E9@smtp.kernel.org>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-9-f22a10a52867@gmail.com>
 <20260725052202.C6AEE1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

On Sat, 25 Jul 2026 05:22:02 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential issue(s) to consider:
> - [High] Usage of sleep-capable functions in atomic CRTC and plane hardware programming callbacks.
> - [High] Unchecked return value of `clk_round_rate` leads to hardware misconfiguration.
> - [High] Data race on `flip_done` between the timeout handler and ISR leading to vblank refcount underflow.
> - [High] Unconditional dereference of `state->fb` triggers kernel panic for solid fill planes.
> - [High] When the cmdlist buffer overflows, `cl->nod_len` is incremented despite the row write being aborted, causing the hardware to read out-of-bounds DMA memory.
> - [High] The `cl_rdma` register buffer is never packed into the cmdlist and gets corrupted when shared across planes.
> - [High] Signed plane coordinates are directly cast to u32, causing massive out-of-bounds register programming when off-screen.
> - [Medium] The `INT_VSYNC_UPDATE` interrupt is missing from the `irq_list` mapping array, preventing its status from being cleared.
> --
>
> --- Patch [9]: [PATCH 09/17] drm/spacemit: add Saturn DPU hardware backend ---
> commit 1cf09ad0cc7d13639bcbfc63e90d8f431590bfbd
> Author: Cody Kang <codykang.hk@gmail.com>
>
> drm/spacemit: add Saturn DPU hardware backend
>
> Add the register-level programming of one Saturn instance: clock and
> reset bring-up, scene control and timing generator setup, RDMA channel
> and composer layer programming, FBC line-buffer budgeting, interrupt
> dispatch and the cfg-ready/vsync handshake that paces commits. The
> backend is exposed as an ops table and hardware descriptor to be
> aggregated by the KMS layer in an upcoming patch.
>
> > diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c b/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c
> > index 0000000000000..8d5f13bc5373c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c
> [ ... ]
> > +static int dpu_enable_clocks(struct spacemit_crtc *a_crtc)
> > +{
> > +	struct dpu_clk_context *clk_ctx = &a_crtc->clk_ctx;
> > +	struct drm_crtc *crtc = &a_crtc->crtc;
> > +	struct drm_display_mode *mode = &crtc->mode;
> > +	u64 clk_val;
> > +	u64 set_clk_val;
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(clk_ctx->pxclk);
> > +	if (ret)
> > +		goto err;
> > +	set_clk_val = mode->clock * 1000;
> > +	if (set_clk_val) {
> > +		set_clk_val = clk_round_rate(clk_ctx->pxclk, set_clk_val);
>
> [Severity: High]
> Does this code properly handle negative error codes from clk_round_rate()?

The rate comes from a mode atomic_check already validated; a
clk_round_rate() failure on this mux is not a reachable
configuration, and the call is a best-effort match.

> If clk_round_rate() fails and returns an error like -EINVAL, the unchecked
> value is cast directly to u64 set_clk_val. This will sign-extend the error
> code into a massive positive integer before it gets passed to clk_set_rate(),
> which can lead to hardware misconfiguration.
>
> > +		clk_val = clk_get_rate(clk_ctx->pxclk);
> > +		if (clk_val != set_clk_val) {
> > +			clk_set_rate(clk_ctx->pxclk, set_clk_val);
> > +			drm_dbg(crtc->dev, "pxclk=%lld\n", clk_val);
> > +		}
> > +	}
> [ ... ]
> > +static inline void dpu_isr_vblank(struct spacemit_crtc *a_crtc, bool *flip)
> > +{
> > +	struct drm_crtc *crtc = &a_crtc->crtc;
> > +	struct drm_device *drm = crtc->dev;
> > +	struct drm_pending_vblank_event *event;
> > +
> > +	drm_crtc_handle_vblank(crtc);
> > +
> > +	if (*flip)
> > +		return;
> > +	*flip = true;
>
> [Severity: High]
> Can this race condition cause a vblank reference underflow?

The watchdog and the ISR arbitrate the vblank reference through the
timer_delete() return value; see the comment in the ISR.

> The timer handler spacemit_cfg_rdy_timer_handler() sets flip_done to true and
> calls drm_crtc_vblank_put() asynchronously.
>
> If the ISR runs concurrently, both threads can observe flip_done as false
> due to the lockless TOCTOU check here. They will both set it to true and
> drop the vblank reference, putting the reference twice.
>
> > +
> > +	/*
> > +	 * event_lock serialises this against the commit arming
> > +	 * crtc->state->event.
> > +	 */
> > +	spin_lock(&drm->event_lock);
> [ ... ]
> > +static u32 dpu_online_isr(struct spacemit_crtc *a_crtc)
> > +{
> > +	u32 irq_raw, irq_bit, irq_ur_bit;
> > +	struct spacemit_drm_private *priv = a_crtc->crtc.dev->dev_private;
> > +	struct spacemit_hw_device *hwdev = priv->hwdev;
> > +	int dev_id = a_crtc->dev_id;
> > +
> > +	trace_dpu_isr(a_crtc->dev_id);
> [ ... ]
> > +	irq_bit = hwdev->get_irq_bit(INT_REST, dev_id) | irq_ur_bit;
> > +	if (irq_raw & irq_bit)
> > +		hwdev->clr_int_sts(a_crtc, irq_bit, dev_id);
> > +
> > +	irq_bit = hwdev->get_irq_bit(INT_VSYNC_UPDATE, dev_id);
> > +	if (irq_raw & irq_bit)
> > +		hwdev->clr_int_sts(a_crtc, irq_bit, dev_id);
>
> [Severity: Medium]
> Is it possible to clear the INT_VSYNC_UPDATE interrupt?

Real in effect: the enum member never had an irq_list[] mapping, so
the branch is dead. Will drop the branch and the enum member in v2;
the register model carries no such status bit.

> The irq_list array in dpu_saturn_hee.c only defines up to INT_REST.
>
> When get_irq_bit() is called with INT_VSYNC_UPDATE (index 5), it triggers
> the ARRAY_SIZE(irq_list) check and returns 0. Consequently, the interrupt
> status can never be cleared by this handler.
>
> > +
> > +	return 0;
> > +}
> [ ... ]
> > diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c b/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c
> > index 0000000000000..c23e4ca36d26b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c
> [ ... ]
> > +void saturn_hee_plane_update_hw_channel(struct drm_plane *plane)
> > +{
> > +	struct drm_plane_state *state = plane->state;
> > +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(state->crtc);
> > +	struct drm_framebuffer *fb = plane->state->fb;
> [ ... ]
> > +	src_w = state->src_w >> 16;
> > +	src_h = state->src_h >> 16;
> > +	src_x = state->src_x >> 16;
> > +	src_y = state->src_y >> 16;
> > +
> > +	crtc_w = state->crtc_w;
> > +	crtc_h = state->crtc_h;
> > +	crtc_x = state->crtc_x;
> > +	crtc_y = state->crtc_y;
>
> [Severity: High]
> Can this cause massive out-of-bounds register programming if the plane is
> partially off-screen?

drm_atomic_helper_check_plane_state() clips the destination
rectangle to the CRTC before the driver reads it; post-clip
coordinates are non-negative.

> The plane coordinates state->crtc_x and state->crtc_y are signed 32-bit
> integers. Directly assigning them to unsigned 32-bit variables will cause
> negative values to overflow into extremely large positive integers.
>
> When these are written to the hardware area control registers, it creates
> invalid constraints like area_left being greater than area_right.
>
> > +
> > +	drm_dbg(plane->dev, "crtc_x %u crtc_y %u\n", crtc_x, crtc_y);
> > +
> > +	if (rdma_id == RDMA_INVALID_ID)
> > +		solid_en = true;
> > +
> > +	trace_dpu_plane_info(state, fb, rdma_id, alpha, state->rotation);
> > +
> > +	/* For solid color both src_w and src_h are 0 */
> > +	if (!solid_en) {
> > +		base = RDMA_BASE_ADDR[rdma_id];
> > +		/* linear scanout only: the FBC decode path is not exposed */
> > +		dpu_write(hwdev, RDMA_PATH_X_REG, base, layer_mode, 0, cl_rdma);
>
> [Severity: High]
> Is the cl_rdma register buffer ever flushed to the command list?

It is: plane_atomic_update packs it into the plane cmdlist via
cmdlist_regs_packing(..., CMDLIST_MOD_RDMA, ...).

> RDMA configurations are written to a_crtc->cl_rdma, but cmdlist_regs_packing()
> is never called for this buffer, meaning the configurations are discarded and
> never reach the hardware.
>
> Furthermore, does sharing a_crtc->cl_rdma across planes corrupt the state?
> When dpu_write() is called, it unconditionally overwrites cl_p->base. If
> multiple planes are updated concurrently, the last plane will overwrite the
> base address for all prior planes' registers in this shared buffer.
>
> > +		dpu_write(hwdev, RDMA_PATH_X_REG, base, layer_cmpsr_id,
> > +			  a_crtc->dev_id, cl_rdma);
> [ ... ]
> > +	} else {
> > +		/* Constant-fill layer: zero-size source, transparent black. */
> > +		solid_r = 0;
> > +		solid_g = 0;
> > +		solid_b = 0;
> > +		solid_a = 0;
> > +	}
> > +
> > +	switch (pixel_alpha) {
> [ ... ]
> > +	}
> > +
> > +	if (state->fb->format && state->fb->format->has_alpha &&
>
> [Severity: High]
> Will this crash if the plane is a solid fill plane?

There is no fb-less plane here: constant fill is a zero-sized src
on an fb-bearing plane, and atomic_update only runs for enabled
planes, which always carry an fb.

> In DRM, solid fill planes do not require an attached framebuffer, meaning
> state->fb can be NULL. Unconditionally dereferencing state->fb->format here
> without verifying if state->fb is valid will trigger a kernel panic.
>
> > +	    pixel_alpha != DRM_MODE_BLEND_PIXEL_NONE) {
> > +		if (alpha != 0xff)
> > +			alpha_sel = 0x2;
> > +		else
> > +			alpha_sel = 0x1;
> > +	} else {
> > +		blend_mode = 0x0;
> > +		alpha_sel = 0x0;
> > +	}
> > +
> > +	cl_cmp = alloc_cmdlist_regs(CMPS_X_REG);
>
> [Severity: High]
> Since plane atomic update callbacks execute in atomic context during
> non-blocking commits, is it safe to allocate memory here?

Plane atomic_update runs in the commit tail, which is process
context; GFP_KERNEL is fine there, and a NULL cmdlist_regs is a
documented direct-MMIO fallback, not a broken update.

> The alloc_cmdlist_regs() macro uses kzalloc() with GFP_KERNEL. Calling
> sleeping functions from an atomic context causes kernel warnings,
> system instability, and potential deadlocks.
>
> > +
> > +	base = CMP_BASE_ADDR[a_crtc->dev_id];
> > +	dpu_write(hwdev, CMPS_X_REG, base, dst_w, mode->hdisplay, cl_cmp);
> [ ... ]
> > +void saturn_hee_cmdlist_fill_data_row(struct cmdlist *cl, u32 strobe,
> > +				      u32 offset, u32 value[])
> > +{
> > +	struct cmdlist_row *row;
> > +	u8 i;
> > +
> > +	/*
> > +	 * packing counts rows blindly; drop the row rather than the buffer end
> > +	 */
> > +	if (WARN_ONCE(CL_HEADER_SZ + (cl->nod_len + 1) * CL_ROW_SZ > cl->size,
> > +		      "cmdlist buffer full (rows %u)\n", cl->nod_len))
> > +		return;
>
> [Severity: High]
> Does this correctly handle command list buffer overflows?

Not reachable: the 4 KiB cmdlist holds 255 rows, the largest
register window (146 words) packs into at most 49, and no single
list carries more than a few windows. v2 I will add a WARN_ONCE
guard in the row-fill helpers rather than trusting the arithmetic.

> When the cmdlist buffer is full, this function issues a warning and returns
> early without writing the row.
>
> However, its caller in cmdlist_regs_packing() ignores this failure and
> still increments cl->nod_len. This artificially inflates the length in the
> header. When the DPU hardware parses the cmdlist, it will attempt to read
> out-of-bounds DMA memory.
>
> > +
> > +	row = (struct cmdlist_row *)((char *)cl->va + CL_HEADER_SZ) + cl->nod_len;
> [ ... ]
> > diff --git a/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c b/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c
> > index 0000000000000..144716ec9b80c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c
> [ ... ]
> > +int saturn_cal_layer_fbcmem_size(struct drm_plane *plane,
> > +				 struct drm_plane_state *state)
> > +{
> > +	struct spacemit_plane_state *pstate = to_spacemit_plane_state(state);
> > +	u32 drm_4cc_fmt = pstate->state.fb->format->format;
>
> [Severity: High]
> Will this crash if the plane is a solid fill plane?

cal_layer_fbcmem_size() is only called for layers that own an RDMA
channel; constant-fill layers skip it.

Cody
