Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1254FC531D0
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7078410F511;
	Sat, 25 Jul 2026 05:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="STmcpFqq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52CD10F511
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:22:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6988A43B27;
 Sat, 25 Jul 2026 05:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AEE1F000E9;
 Sat, 25 Jul 2026 05:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956923;
 bh=bG66rhHvJ03E/3MxvHqTQu0vzSPnTuJRVoJfRS1ke/A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=STmcpFqqNkddAsNbnqEkO6fcohLg7IzzhVnv/YKT1KlsnfYUsWHlO6imbbMWjqLTT
 EcfPpNStzl3xhcNOuJYyBxHxqAzyJm3NNxX6lrbEgRY+mwCFIwaGSXXcp6oJAFGtPV
 yomTfztGQoJTsLO2TI5AvEqoznPLcsSiY9TsLt7Zso7mMBVpAQXN/aS7KuSmnTFEMV
 U6LAdjuqO+2CLihQVTxSzn9kxBTv5AJB7KyG0+bVe1fZHoE9J54QoQpmpIe9gA4pp4
 2zoBagh6HV9WpGenJ0Tp3sCBJ26e0oR2KZzXpce3WTAilyNcRXJScQyo15S3E6l+n6
 q5MnQ00IBJa3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/17] drm/spacemit: add Saturn DPU hardware backend
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, vkoul@kernel.org,
 robh@kernel.org, dri-devel@lists.freedesktop.org, olteanv@gmail.com,
 neil.armstrong@linaro.org, conor+dt@kernel.org
In-Reply-To: <20260724-k3-display-v1-9-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-9-f22a10a52867@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:22:02 +0000
Message-Id: <20260725052202.C6AEE1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Usage of sleep-capable functions in atomic CRTC and plane hardware=
 programming callbacks.
- [High] Unchecked return value of `clk_round_rate` leads to hardware misco=
nfiguration.
- [High] Data race on `flip_done` between the timeout handler and ISR leadi=
ng to vblank refcount underflow.
- [High] Unconditional dereference of `state->fb` triggers kernel panic for=
 solid fill planes.
- [High] When the cmdlist buffer overflows, `cl->nod_len` is incremented de=
spite the row write being aborted, causing the hardware to read out-of-boun=
ds DMA memory.
- [High] The `cl_rdma` register buffer is never packed into the cmdlist and=
 gets corrupted when shared across planes.
- [High] Signed plane coordinates are directly cast to u32, causing massive=
 out-of-bounds register programming when off-screen.
- [Medium] The `INT_VSYNC_UPDATE` interrupt is missing from the `irq_list` =
mapping array, preventing its status from being cleared.
--

--- Patch [9]: [PATCH 09/17] drm/spacemit: add Saturn DPU hardware backend =
---
commit 1cf09ad0cc7d13639bcbfc63e90d8f431590bfbd
Author: Cody Kang <codykang.hk@gmail.com>

drm/spacemit: add Saturn DPU hardware backend

Add the register-level programming of one Saturn instance: clock and
reset bring-up, scene control and timing generator setup, RDMA channel
and composer layer programming, FBC line-buffer budgeting, interrupt
dispatch and the cfg-ready/vsync handshake that paces commits. The
backend is exposed as an ops table and hardware descriptor to be
aggregated by the KMS layer in an upcoming patch.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c b/drivers/gpu/drm/=
spacemit/dpu/dpu_saturn.c
> index 0000000000000..8d5f13bc5373c
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c
[ ... ]
> +static int dpu_enable_clocks(struct spacemit_crtc *a_crtc)
> +{
> +	struct dpu_clk_context *clk_ctx =3D &a_crtc->clk_ctx;
> +	struct drm_crtc *crtc =3D &a_crtc->crtc;
> +	struct drm_display_mode *mode =3D &crtc->mode;
> +	u64 clk_val;
> +	u64 set_clk_val;
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(clk_ctx->pxclk);
> +	if (ret)
> +		goto err;
> +	set_clk_val =3D mode->clock * 1000;
> +	if (set_clk_val) {
> +		set_clk_val =3D clk_round_rate(clk_ctx->pxclk, set_clk_val);

[Severity: High]
Does this code properly handle negative error codes from clk_round_rate()?

If clk_round_rate() fails and returns an error like -EINVAL, the unchecked
value is cast directly to u64 set_clk_val. This will sign-extend the error
code into a massive positive integer before it gets passed to clk_set_rate(=
),
which can lead to hardware misconfiguration.

> +		clk_val =3D clk_get_rate(clk_ctx->pxclk);
> +		if (clk_val !=3D set_clk_val) {
> +			clk_set_rate(clk_ctx->pxclk, set_clk_val);
> +			drm_dbg(crtc->dev, "pxclk=3D%lld\n", clk_val);
> +		}
> +	}
[ ... ]
> +static inline void dpu_isr_vblank(struct spacemit_crtc *a_crtc, bool *fl=
ip)
> +{
> +	struct drm_crtc *crtc =3D &a_crtc->crtc;
> +	struct drm_device *drm =3D crtc->dev;
> +	struct drm_pending_vblank_event *event;
> +
> +	drm_crtc_handle_vblank(crtc);
> +
> +	if (*flip)
> +		return;
> +	*flip =3D true;

[Severity: High]
Can this race condition cause a vblank reference underflow?

The timer handler spacemit_cfg_rdy_timer_handler() sets flip_done to true a=
nd
calls drm_crtc_vblank_put() asynchronously.

If the ISR runs concurrently, both threads can observe flip_done as false
due to the lockless TOCTOU check here. They will both set it to true and
drop the vblank reference, putting the reference twice.

> +
> +	/*
> +	 * event_lock serialises this against the commit arming
> +	 * crtc->state->event.
> +	 */
> +	spin_lock(&drm->event_lock);
[ ... ]
> +static u32 dpu_online_isr(struct spacemit_crtc *a_crtc)
> +{
> +	u32 irq_raw, irq_bit, irq_ur_bit;
> +	struct spacemit_drm_private *priv =3D a_crtc->crtc.dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +	int dev_id =3D a_crtc->dev_id;
> +
> +	trace_dpu_isr(a_crtc->dev_id);
[ ... ]
> +	irq_bit =3D hwdev->get_irq_bit(INT_REST, dev_id) | irq_ur_bit;
> +	if (irq_raw & irq_bit)
> +		hwdev->clr_int_sts(a_crtc, irq_bit, dev_id);
> +
> +	irq_bit =3D hwdev->get_irq_bit(INT_VSYNC_UPDATE, dev_id);
> +	if (irq_raw & irq_bit)
> +		hwdev->clr_int_sts(a_crtc, irq_bit, dev_id);

[Severity: Medium]
Is it possible to clear the INT_VSYNC_UPDATE interrupt?

The irq_list array in dpu_saturn_hee.c only defines up to INT_REST.

When get_irq_bit() is called with INT_VSYNC_UPDATE (index 5), it triggers
the ARRAY_SIZE(irq_list) check and returns 0. Consequently, the interrupt
status can never be cleared by this handler.

> +
> +	return 0;
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c b/drivers/gpu/=
drm/spacemit/dpu/dpu_saturn_hee.c
> index 0000000000000..c23e4ca36d26b
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c
[ ... ]
> +void saturn_hee_plane_update_hw_channel(struct drm_plane *plane)
> +{
> +	struct drm_plane_state *state =3D plane->state;
> +	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(state->crtc);
> +	struct drm_framebuffer *fb =3D plane->state->fb;
[ ... ]
> +	src_w =3D state->src_w >> 16;
> +	src_h =3D state->src_h >> 16;
> +	src_x =3D state->src_x >> 16;
> +	src_y =3D state->src_y >> 16;
> +
> +	crtc_w =3D state->crtc_w;
> +	crtc_h =3D state->crtc_h;
> +	crtc_x =3D state->crtc_x;
> +	crtc_y =3D state->crtc_y;

[Severity: High]
Can this cause massive out-of-bounds register programming if the plane is
partially off-screen?

The plane coordinates state->crtc_x and state->crtc_y are signed 32-bit
integers. Directly assigning them to unsigned 32-bit variables will cause
negative values to overflow into extremely large positive integers.

When these are written to the hardware area control registers, it creates
invalid constraints like area_left being greater than area_right.

> +
> +	drm_dbg(plane->dev, "crtc_x %u crtc_y %u\n", crtc_x, crtc_y);
> +
> +	if (rdma_id =3D=3D RDMA_INVALID_ID)
> +		solid_en =3D true;
> +
> +	trace_dpu_plane_info(state, fb, rdma_id, alpha, state->rotation);
> +
> +	/* For solid color both src_w and src_h are 0 */
> +	if (!solid_en) {
> +		base =3D RDMA_BASE_ADDR[rdma_id];
> +		/* linear scanout only: the FBC decode path is not exposed */
> +		dpu_write(hwdev, RDMA_PATH_X_REG, base, layer_mode, 0, cl_rdma);

[Severity: High]
Is the cl_rdma register buffer ever flushed to the command list?

RDMA configurations are written to a_crtc->cl_rdma, but cmdlist_regs_packin=
g()
is never called for this buffer, meaning the configurations are discarded a=
nd
never reach the hardware.

Furthermore, does sharing a_crtc->cl_rdma across planes corrupt the state?
When dpu_write() is called, it unconditionally overwrites cl_p->base. If
multiple planes are updated concurrently, the last plane will overwrite the
base address for all prior planes' registers in this shared buffer.

> +		dpu_write(hwdev, RDMA_PATH_X_REG, base, layer_cmpsr_id,
> +			  a_crtc->dev_id, cl_rdma);
[ ... ]
> +	} else {
> +		/* Constant-fill layer: zero-size source, transparent black. */
> +		solid_r =3D 0;
> +		solid_g =3D 0;
> +		solid_b =3D 0;
> +		solid_a =3D 0;
> +	}
> +
> +	switch (pixel_alpha) {
[ ... ]
> +	}
> +
> +	if (state->fb->format && state->fb->format->has_alpha &&

[Severity: High]
Will this crash if the plane is a solid fill plane?

In DRM, solid fill planes do not require an attached framebuffer, meaning
state->fb can be NULL. Unconditionally dereferencing state->fb->format here
without verifying if state->fb is valid will trigger a kernel panic.

> +	    pixel_alpha !=3D DRM_MODE_BLEND_PIXEL_NONE) {
> +		if (alpha !=3D 0xff)
> +			alpha_sel =3D 0x2;
> +		else
> +			alpha_sel =3D 0x1;
> +	} else {
> +		blend_mode =3D 0x0;
> +		alpha_sel =3D 0x0;
> +	}
> +
> +	cl_cmp =3D alloc_cmdlist_regs(CMPS_X_REG);

[Severity: High]
Since plane atomic update callbacks execute in atomic context during
non-blocking commits, is it safe to allocate memory here?

The alloc_cmdlist_regs() macro uses kzalloc() with GFP_KERNEL. Calling
sleeping functions from an atomic context causes kernel warnings,
system instability, and potential deadlocks.

> +
> +	base =3D CMP_BASE_ADDR[a_crtc->dev_id];
> +	dpu_write(hwdev, CMPS_X_REG, base, dst_w, mode->hdisplay, cl_cmp);
[ ... ]
> +void saturn_hee_cmdlist_fill_data_row(struct cmdlist *cl, u32 strobe,
> +				      u32 offset, u32 value[])
> +{
> +	struct cmdlist_row *row;
> +	u8 i;
> +
> +	/*
> +	 * packing counts rows blindly; drop the row rather than the buffer end
> +	 */
> +	if (WARN_ONCE(CL_HEADER_SZ + (cl->nod_len + 1) * CL_ROW_SZ > cl->size,
> +		      "cmdlist buffer full (rows %u)\n", cl->nod_len))
> +		return;

[Severity: High]
Does this correctly handle command list buffer overflows?

When the cmdlist buffer is full, this function issues a warning and returns
early without writing the row.

However, its caller in cmdlist_regs_packing() ignores this failure and
still increments cl->nod_len. This artificially inflates the length in the
header. When the DPU hardware parses the cmdlist, it will attempt to read
out-of-bounds DMA memory.

> +
> +	row =3D (struct cmdlist_row *)((char *)cl->va + CL_HEADER_SZ) + cl->nod=
_len;
[ ... ]
> diff --git a/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c b/drivers/gpu/d=
rm/spacemit/dpu/saturn_fbcmem.c
> index 0000000000000..144716ec9b80c
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c
[ ... ]
> +int saturn_cal_layer_fbcmem_size(struct drm_plane *plane,
> +				 struct drm_plane_state *state)
> +{
> +	struct spacemit_plane_state *pstate =3D to_spacemit_plane_state(state);
> +	u32 drm_4cc_fmt =3D pstate->state.fb->format->format;

[Severity: High]
Will this crash if the plane is a solid fill plane?

In DRM, solid fill planes do not require an attached framebuffer, meaning
state->fb can be NULL. Unconditionally dereferencing state->fb->format here
without verifying if state->fb is valid will trigger a kernel panic.

> +	u32 crop_w =3D pstate->state.src_w >> 16;
> +
> +	/* Only linear sizing: the compressed path is not exposed. */
> +	return get_raw_data_plane_rdma_mem_size(drm_4cc_fmt, crop_w,
> +						&pstate->fbcmem_size);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-k3-display=
-v1-0-f22a10a52867@gmail.com?part=3D9
