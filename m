Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3767C5AE49
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514BA10E571;
	Sun,  9 Aug 2026 13:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UuVJzp4P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A816010E571
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:31:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D7C5600AB;
 Sun,  9 Aug 2026 13:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5776C1F000E9;
 Sun,  9 Aug 2026 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786282303;
 bh=ejPdgbVfgw5V8U8PhcQ2tH70UH1Z9rPYw9PMMJnGwHU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UuVJzp4PYwlqPSwVgHUO7rSfedE3//qrQYrjLj56OhPQ1RPltuHwZJsvh2dKhLcA2
 IICF+agHlgbdqrCnrxpGFGp64D3eCO1bUq3Bj2Gr4U3cmo4clodrxv/RoGVZuiiv/I
 RI07nMXVlPIpqV+8FTWBcHbJdNTqC/yWoXl3aZjCk9RLxAXJylBbrGO5tMCkY57npf
 WnMOWY1b1NpLkNt3/BDowiWPi/ohpt+vinv7lZOdX5tE5DFK1seFmuybw/lvZZBUYt
 ASL8Pw4l8KP3zuMSQbGQinHlk1m2vP37YbGPdH6EF2f2mOO6GbEVOsYLQD3C0oR+KX
 U9E0YT6F8SJrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/17] drm/spacemit: add Saturn DPU hardware backend
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: neil.armstrong@linaro.org, olteanv@gmail.com, robh@kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260809-k3-display-v2-9-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-9-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 13:31:42 +0000
Message-Id: <20260809133143.5776C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 14 potential issue=
(s) to consider:
- [High] Dynamic memory allocation using GFP_KERNEL inside plane atomic upd=
ate, disable, and CRTC flush paths.
- [High] If cmdlist memory allocation fails, the driver falls back to direc=
t MMIO writes during atomic updates, breaking transaction semantics.
- [High] Unsynchronized lockless access to `flip_done` between ISR and time=
r handler allows double `drm_crtc_vblank_put()`.
- [High] Dereferencing `state->fb` without checking for NULL causes a crash=
 when configuring pixel blending for solid fill planes.
- [High] Potential NULL pointer dereference of `state->fb` in `saturn_cal_l=
ayer_fbcmem_size`.
- [High] The `dpu_init` function uses the sleeping function `usleep_range()=
` while executing from an atomic commit path.
- [High] The `cfg_rdy_timer` is not synchronously cancelled during device t=
eardown, leading to a potential use-after-free.
- [High] The VBLANK ISR and timer handler directly access `crtc->state->eve=
nt`, causing a race condition with concurrent atomic commits.
- [High] Silently dropped cmdlist rows cause the hardware DMA to read out-o=
f-bounds memory.
- [Medium] Hardware clocks are disabled in the same forward order they were=
 enabled, violating clock dependencies.
- [Medium] C bitfields are used for defining hardware DMA descriptor layout=
s.
- [Medium] Unchecked `drm_crtc_vblank_get` return value leads to refcount u=
nderflow.
- [Medium] Double-clearing of underrun interrupt status due to stale irq_ra=
w snapshot.
- [Medium] Useless and contextually incorrect read memory barrier (dma_rmb).
--

--- Patch [9]: [PATCH v2 09/17] drm/spacemit: add Saturn DPU hardware backe=
nd ---
commit 203a676effd210733651accaca4eebc02e32d9c2
Author: Cody Kang <codykang.hk@gmail.com>
Subject: drm/spacemit: add Saturn DPU hardware backend

This commit adds the register-level programming of the Saturn instance,
including clock and reset bring-up, scene control, and timing generator set=
up.
The backend is exposed as an ops table for the KMS layer.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c b/drivers/gpu/drm/=
spacemit/dpu/dpu_saturn.c
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c
[ ... ]
> +static int dpu_disable_clocks(struct spacemit_crtc *a_crtc)
> +{
> +	struct dpu_clk_context *clk_ctx =3D &a_crtc->clk_ctx;
> +
> +	trace_dpu_disable_clocks(a_crtc->dev_id);
> +
> +	clk_disable_unprepare(clk_ctx->pxclk);
> +	clk_disable_unprepare(clk_ctx->mclk);
> +	clk_disable_unprepare(clk_ctx->escclk);
> +
> +	clk_disable_unprepare(clk_ctx->aclk);
> +	clk_disable_unprepare(clk_ctx->dscclk);

[Severity: Medium]
Providers should usually be disabled after their consumers, but this matches
the exact forward order they were enabled in dpu_enable_clocks().

Are these clocks being disabled in the correct order?

[ ... ]
> +static int dpu_init(struct spacemit_crtc *a_crtc)
> +{
> +	unsigned int timeout =3D 1000;
> +	struct spacemit_drm_private *priv =3D a_crtc->crtc.dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +
> +	if (!a_crtc->clocks_on)
> +		return 0;
> +
> +	while (timeout) {
> +		if (hwdev->get_cfg_rdy(a_crtc, hwdev) =3D=3D 0)
> +			break;
> +		usleep_range(100, 200);

[Severity: High]
dpu_init() appears to be called from the CRTC's atomic enable sequence,
where sleeping is strictly forbidden and can cause kernel warnings or
deadlocks.

Is it safe to call a sleeping function like usleep_range() here?

[ ... ]
> +static void dpu_uninit(struct spacemit_crtc *a_crtc)
> +{
> +	struct spacemit_drm_private *priv =3D a_crtc->crtc.dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +
> +	if (!a_crtc->clocks_on)
> +		return;
> +
> +	trace_dpu_uninit(a_crtc->dev_id);
> +	hwdev->irq_enable(a_crtc, false);
> +}

[Severity: High]
If the driver unbinds while the timer is pending, the timer callback could
execute on freed spacemit_crtc memory, leading to a use-after-free.

Should there be a synchronous cancellation of cfg_rdy_timer here?

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
> +
> +	/*
> +	 * event_lock serialises this against the commit arming
> +	 * crtc->state->event.
> +	 */
> +	spin_lock(&drm->event_lock);
> +	event =3D crtc->state->event;
> +	if (event) {

[Severity: High]
The crtc->state can be swapped asynchronously by
drm_atomic_helper_swap_state(), which could cause this handler to point to a
new event and lose the old one if multiple commits are queued rapidly.

Is it safe to directly dereference crtc->state->event dynamically from an
asynchronous context?

[ ... ]
> +static u32 dpu_online_isr(struct spacemit_crtc *a_crtc)
> +{
[ ... ]
> +	irq_raw =3D hwdev->get_int_sts(hwdev, dev_id);
> +	trace_dpu_isr_status("ONLINE", irq_raw);
> +	irq_bit =3D hwdev->get_irq_bit(INT_UNDERRUN, dev_id);
> +	irq_ur_bit =3D irq_raw & irq_bit;
> +	if (irq_ur_bit && !a_crtc->ur_reported) {
> +		hwdev->clr_int_sts(a_crtc, irq_ur_bit, dev_id);
> +		trace_dpu_isr_status("underrun", irq_ur_bit);
> +		drm_err_ratelimited(a_crtc->crtc.dev, "underrun\n");
> +		a_crtc->ur_reported =3D true;
> +	}
> +	irq_bit =3D hwdev->get_irq_bit(INT_CFG_RDY, dev_id);
> +	if (irq_raw & irq_bit) {
> +		hwdev->clr_int_sts(a_crtc, irq_bit, dev_id);
> +		trace_dpu_isr_status("cfg_rdy_clr", irq_raw & irq_bit);
> +		/*
> +		 * A fired watchdog already sent the event and put this flip's
> +		 * vblank reference; re-arming the vsync path would put twice.
> +		 */
> +		if (timer_delete(&a_crtc->cfg_rdy_timer))
> +			a_crtc->flip_done =3D false;

[Severity: High]
If the timer executes on another CPU, timer_delete() returns 0 and both the
ISR and the timer handler could execute lockless modifications to flip_done
and call drm_crtc_vblank_put() twice.

Could this non-synchronous timer cancellation leave the callback running
concurrently?

[ ... ]
> +	irq_bit =3D hwdev->get_irq_bit(INT_REST, dev_id) | irq_ur_bit;
> +	if (irq_raw & irq_bit)
> +		hwdev->clr_int_sts(a_crtc, irq_bit, dev_id);

[Severity: Medium]
The code takes a single snapshot of irq_raw at the start of the ISR, clears
irq_ur_bit if present, and then clears it again here using the stale
snapshot. A new underrun firing in that window could be cleared without
being processed.

Does double-clearing the underrun interrupt status risk losing interrupts?

[ ... ]
> +static void dpu_run(struct drm_crtc *crtc,
> +		    struct drm_crtc_state *old_state)
> +{
[ ... ]
> +	/* flush all config register writes before CFG_RDY is raised */
> +	mb();
> +
> +	drm_crtc_vblank_get(crtc);

[Severity: Medium]
If getting the vblank fails, the reference is not taken, but the ISR still
unconditionally calls drm_crtc_vblank_put(), which can lead to a vblank
reference count underflow.

Should the return value of drm_crtc_vblank_get() be checked?

> +	if (hwdev->enable_cfg_irq)
> +		hwdev->enable_cfg_irq(a_crtc, hwdev, true);
> +
> +	saturn_ctrl_cfg_ready(a_crtc, true);
> +
> +	if (unlikely(a_crtc->is_1st_f)) {
> +		drm_dbg(a_crtc->crtc.dev, "DPU start\n");
> +		a_crtc->is_1st_f =3D false;
> +		saturn_ctrl_sw_start(a_crtc, true);
> +	}
> +	dma_rmb();
> +}

[Severity: Medium]
A read memory barrier strictly enforces ordering between CPU reads, but the
preceding operation writes to DMA control registers to start the engine.

Is this read memory barrier required here? It seems semantically out of
place.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c b/drivers/gpu/=
drm/spacemit/dpu/dpu_saturn_hee.c
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c
[ ... ]
> +void saturn_hee_plane_update_hw_channel(struct drm_plane *plane)
> +{
[ ... ]
> +	if (state->fb->format && state->fb->format->has_alpha &&
> +	    pixel_alpha !=3D DRM_MODE_BLEND_PIXEL_NONE) {

[Severity: High]
For solid fill planes, state->fb is typically NULL. Evaluating
state->fb->format without a NULL check could cause a kernel oops when
userspace submits an atomic commit for a solid-color plane.

Can state->fb be NULL here?

[ ... ]
> +	cl_cmp =3D alloc_cmdlist_regs(CMPS_X_REG);
> +
> +	base =3D CMP_BASE_ADDR[a_crtc->dev_id];
> +	dpu_write(hwdev, CMPS_X_REG, base, dst_w, mode->hdisplay, cl_cmp);
> +	dpu_write(hwdev, CMPS_X_REG, base, dst_h, mode->vdisplay, cl_cmp);
> +
> +	SATURN_WRITE_COMPOSER_LAYER(00);

[Severity: High]
The alloc_cmdlist_regs macro internally uses kzalloc with GFP_KERNEL.

Can this allocation sleep in an atomic context and trigger deadlock warning=
s,
since it is called from the plane atomic update callback?

Also, if this allocation fails and returns NULL, cl_cmp is passed directly =
to
SATURN_WRITE_COMPOSER_LAYER and dpu_write. The dpu_write logic falls back to
direct MMIO writes when the command list is NULL.

Does this bypass command list synchronization to VBLANK and risk applying
partial state immediately?

[ ... ]
> +struct cmdlist_header {
> +	u64 next_list_addr : 39;
> +	/* reserved */
> +	u32: 1;
> +	u32 nod_len : 16;
> +	/* 1: the last cmdlist node, 2: pending node, otherwise 0 */
> +	u32 nod_type : 2;
> +	u32 next_nod_secu : 1;
> +	u64 wait_event_low    : 5;
> +	u64 wait_event    : 59;
> +	/* reserved */
> +	u32: 5;
> +};

[Severity: Medium]
Bitfield packing and ordering are heavily compiler and architecture depende=
nt,
which might produce incorrect structures in memory for the hardware DMA to
read.

Is it safe to use C bitfields for hardware DMA descriptor layouts?

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
Since this function silently drops the row and returns void, the caller
cmdlist_regs_packing() will blindly increment cl->nod_len regardless of
buffer truncation.

Could this inflated length cause the DMA engine to read past the end of the
initialized buffer?

> diff --git a/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c b/drivers/gpu/d=
rm/spacemit/dpu/saturn_fbcmem.c
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c
[ ... ]
> +int saturn_cal_layer_fbcmem_size(struct drm_plane *plane,
> +				 struct drm_plane_state *state)
> +{
> +	struct spacemit_plane_state *pstate =3D to_spacemit_plane_state(state);
> +	u32 drm_4cc_fmt =3D pstate->state.fb->format->format;

[Severity: High]
If a plane is being disabled or is in a solid fill mode, the framebuffer
pointer will be NULL, which would cause an immediate crash during the atomic
check phase.

Is it guaranteed that pstate->state.fb is non-NULL here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-k3-display=
-v2-0-327d7910bf71@gmail.com?part=3D9
