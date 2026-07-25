Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB43DC531D0
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D6910F508;
	Sat, 25 Jul 2026 05:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="htSORMHc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ABC810F508
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:12:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 593D660A77;
 Sat, 25 Jul 2026 05:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68071F000E9;
 Sat, 25 Jul 2026 05:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956334;
 bh=XQZ5fDiybyEGP8+U2le8dvWGHm1FN2dJmHu5WkRFyh4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=htSORMHcbZGC8SYSpGIolBj4nKXd10WPzJQlBjsDb+ncoP17jT7IPlpRQig2MTy//
 gLni28P2EehsiKEFFWZCQ+2qmRH7otCA4WAYF1nU6cMp4qbVuuL9k5EPk+phrgGuoO
 UhMaU4gPLGclAPP/RnL6m91OYtSGPAxhpW11p6Q6OuuJTqj7YPaQmQ8PEp69OPKxLF
 /IuDWQC5RIA0tZReh/FRT1GMslzBYtsJE3OpAiDrz+lC2a6ri37x67Hdy7HGwZ28AB
 f7/Temi/MPPUjgNMlvthwEyO2TAwemlAlZRzmCe9KkN6vuOnUqPnUath2mpvDZzVGS
 YbLIIxjAF67xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 09/17] drm/spacemit: add Saturn DPU hardware backend
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: olteanv@gmail.com, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org
In-Reply-To: <20260725-k3-display-v1-9-6de34d80e86c@gmail.com>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-9-6de34d80e86c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:12:13 +0000
Message-Id: <20260725051213.B68071F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] Sleeping memory allocations (`GFP_KERNEL`) in atomic context plane=
 and CRTC update paths, with a silent fallback that breaks atomic update se=
mantics.
- [High] Sleeping delay function (`usleep_range`) used in CRTC atomic enabl=
e context.
- [High] Unconditional dereference of `state->fb` for disabled or solid-fil=
l planes.
- [High] Race condition between the configuration timer handler and the VSY=
NC ISR leads to a double `drm_crtc_vblank_put` and refcount underflow.
- [High] The `cfg_rdy_timer` is not synchronously canceled when the DPU har=
dware is uninitialized or disabled.
- [High] `row_eof_tag` and un-strobed `module_regs` are left uninitialized =
in `saturn_hee_cmdlist_fill_data_row()`.
- [High] Accessing `crtc->state->event` from the VBLANK interrupt handler r=
aces with concurrent non-blocking atomic commits, causing leaked and premat=
ure events.
- [High] Command list length counter desynchronization leads to missing EOF=
 tags and display hangs.
- [High] RDMA hardware configuration is written to a shared staging buffer =
but is never packed into the DMA command list, causing updates to be droppe=
d or overwritten.
- [Medium] `dpu_run()` ignores the return value of `drm_crtc_vblank_get()`,=
 potentially leading to refcount underflow.
- [Medium] Using C bitfields for DMA-shared hardware descriptors (`struct c=
mdlist_header` and `struct cmdlist_row`) leads to compiler-dependent memory=
 layout and breaks on different endiannesses.
--

--- Patch [9]: [PATCH RESEND 09/17] drm/spacemit: add Saturn DPU hardware b=
ackend ---
commit 51bff8176b75d13f3aa75c39d52083ed25e121c0
Author: Cody Kang <codykang.hk@gmail.com>
Date:   Sat Jul 25 04:51:18 2026 +0000

    drm/spacemit: add Saturn DPU hardware backend
   =20
    Add the register-level programming of one Saturn instance: clock and
    reset bring-up, scene control and timing generator setup, RDMA channel
    and composer layer programming, FBC line-buffer budgeting, interrupt
    dispatch and the cfg-ready/vsync handshake that paces commits.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c b/drivers/gpu/drm/=
spacemit/dpu/dpu_saturn.c
> index 8d5f13bc5373c.....
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn.c
[ ... ]
> +void spacemit_cfg_rdy_timer_handler(struct timer_list *t)
> +{
[ ... ]
> +	spin_lock_irqsave(&drm->event_lock, flags);
> +	event =3D crtc->state->event;

[Severity: High]
Does this race with concurrent non-blocking atomic commits?=20

The DRM core's atomic helpers synchronously swap the crtc->state pointer
during the commit phase before the hardware's VBLANK interrupt fires. If two
non-blocking commits are issued back-to-back, the second commit swaps
crtc->state to its new state.

When the first commit's VBLANK fires (or this timer handler executes), read=
ing
crtc->state->event prematurely consumes the second commit's event, leaking
the first commit's event. Should the event be stored in a driver-private CR=
TC
structure instead?

> +	if (event) {
> +		crtc->state->event =3D NULL;
> +		drm_crtc_send_vblank_event(crtc, event);
> +	}
> +	spin_unlock_irqrestore(&drm->event_lock, flags);
> +
> +	drm_crtc_vblank_put(crtc);
> +}
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
Is it safe to use a sleeping delay function here?

dpu_init() is hooked to the .init callback of dpu_core_ops, which
executes during the CRTC atomic enable phase. The DRM subsystem guidelines
explicitly state that CRTC atomic enable callbacks run in atomic context
where sleeping is strictly forbidden.=20

Will this trigger a "scheduling while atomic" panic?

> +		timeout--;
> +	}
> +	if (timeout =3D=3D 0)
> +		drm_err(a_crtc->crtc.dev, "wait for cfg ready timed out\n");
> +
> +	hwdev->dpu_init(a_crtc);
> +
> +	return 0;
> +}
> +
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
Does this uninitialization path need to cancel the configuration timer?

saturn_ctrl_cfg_ready() arms a_crtc->cfg_rdy_timer when the DPU is started.
If the display pipeline is disabled before the hardware raises the CFG_RDY
interrupt, this timer will remain active and could fire asynchronously after
shutdown.

Can this lead to spurious timeout errors, incorrect vblank reference decrem=
ents,
or a use-after-free if the CRTC object is destroyed before the timer is
canceled?

> +static inline void dpu_isr_vblank(struct spacemit_crtc *a_crtc, bool *fl=
ip)
> +{
[ ... ]
> +	spin_lock(&drm->event_lock);
> +	event =3D crtc->state->event;

[Severity: High]
Can this read the wrong event pointer?

Similar to the timer handler above, accessing crtc->state->event races with
concurrent non-blocking atomic commits that swap the crtc->state pointer.
If a new commit is queued, this reads the new state's event and leaks the
current flip's event.

> +	if (event) {
[ ... ]
> +static u32 dpu_online_isr(struct spacemit_crtc *a_crtc)
> +{
[ ... ]
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
Does using the non-blocking timer_delete() return value create a race
condition?

If timer_delete() returns 0 (e.g., because the callback is actively executi=
ng
on another CPU), it leaves a_crtc->flip_done unmodified.=20

The ISR then processes INT_VSYNC and calls dpu_isr_vblank(), which reads
flip_done =3D=3D false, sets it to true, and calls drm_crtc_vblank_put().
Concurrently, the timer handler runs, sets flip_done =3D true, and also
unconditionally calls drm_crtc_vblank_put().=20

Could this lead to a double vblank put and refcount underflow?

> +		a_crtc->ur_reported =3D false;
[ ... ]
> +static void dpu_run(struct drm_crtc *crtc,
> +		    struct drm_crtc_state *old_state)
> +{
> +	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
> +	struct spacemit_drm_private *priv =3D a_crtc->crtc.dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +
> +	trace_dpu_run(a_crtc->dev_id);
> +
> +	if (hwdev->conf_dpuctrl)
> +		hwdev->conf_dpuctrl(crtc, old_state);
> +
> +	/* flush all config register writes before CFG_RDY is raised */
> +	mb();
> +
> +	drm_crtc_vblank_get(crtc);

[Severity: Medium]
Should the return value of drm_crtc_vblank_get() be checked?

drm_crtc_vblank_get() can fail (e.g., if vblank interrupts are uninitialized
or disabled), returning a negative error code without incrementing the vbla=
nk
reference count.=20

By ignoring this return value, this function proceeds as if the reference w=
as
successfully acquired. When the hardware interrupt or timeout later trigger=
s,
they unconditionally call drm_crtc_vblank_put(), which could cause a refcou=
nt
underflow.

> +	if (hwdev->enable_cfg_irq)
> +		hwdev->enable_cfg_irq(a_crtc, hwdev, true);
> +
> +	saturn_ctrl_cfg_ready(a_crtc, true);

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c b/drivers/gpu/=
drm/spacemit/dpu/dpu_saturn_hee.c
> index c23e4ca36d26b.....
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c
[ ... ]
> +void saturn_hee_plane_update_hw_channel(struct drm_plane *plane)
> +{
[ ... ]
> +	/* For solid color both src_w and src_h are 0 */
> +	if (!solid_en) {
> +		base =3D RDMA_BASE_ADDR[rdma_id];
> +		/* linear scanout only: the FBC decode path is not exposed */
> +		dpu_write(hwdev, RDMA_PATH_X_REG, base, layer_mode, 0, cl_rdma);

[Severity: High]
Are these RDMA hardware configuration writes dropped because they are never
packed into the DMA command list?

This uses a_crtc->cl_rdma to stage hardware writes for the RDMA block.
However, there is no corresponding call to cmdlist_regs_packing() for
cl_rdma to commit these writes to the DMA-backed command list.

Since a_crtc->cl_rdma is a single shared buffer, do subsequent plane updates
overwrite the staged settings of previous planes, silently corrupting the
configuration and failing to program the hardware?

> +		dpu_write(hwdev, RDMA_PATH_X_REG, base, layer_cmpsr_id,
[ ... ]
> +	switch (pixel_alpha) {
> +	case DRM_MODE_BLEND_COVERAGE:
> +		blend_mode =3D 0x0;
> +		break;
> +	case DRM_MODE_BLEND_PREMULTI:
> +		blend_mode =3D 0x1;
> +		break;
> +	case DRM_MODE_BLEND_PIXEL_NONE:
> +		blend_mode =3D 0x0;
> +		break;
> +	default:
> +		drm_err(plane->dev, "unsupported blend mode for pixel alpha\n");
> +	}
> +
> +	if (state->fb->format && state->fb->format->has_alpha &&

[Severity: High]
Will this unconditionally dereference a NULL pointer for solid-fill planes?

During DRM atomic commits, a plane's state->fb is frequently NULL (e.g., wh=
en
a plane is being disabled, or for solid color fill planes).=20

While the earlier code handles solid fills by skipping the RDMA block
(if (!solid_en)), this block evaluates state->fb->format unconditionally,
which will cause a kernel panic if state->fb is NULL.

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
Can this trigger a "scheduling while atomic" panic or silent fallback
failures?

alloc_cmdlist_regs() is a macro that uses GFP_KERNEL allocations
(kzalloc(sizeof(*cl), GFP_KERNEL)). This plane update callback runs in atom=
ic
context where sleeping is forbidden.

Additionally, if the allocation fails and returns NULL, the dpu_write() mac=
ro
silently falls back to immediate MMIO writes (dpu_write_reg_word). This
bypasses the command list's VBLANK synchronization, applying partial hardwa=
re
state immediately and causing visual tearing or lockups.

> +
> +	base =3D CMP_BASE_ADDR[a_crtc->dev_id];
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
> +
> +struct cmdlist_row {
> +	u32 module_cfg_addr   : 19;
> +	u32 module_cfg_strobe : 12;
> +	/* the last row tag =3D 1, else tag =3D 0. */
> +	u32 row_eof_tag       : 1;
> +	u32 module_regs[3];
> +};

[Severity: Medium]
Does using C bitfields for DMA-shared hardware descriptors break on differe=
nt
compilers or endiannesses?

These structures format command list nodes directly into a DMA buffer consu=
med
by the hardware. The C standard leaves bitfield packing order and alignment
entirely implementation-defined.=20

Mixing u64 and u32 bitfields makes the exact memory layout highly sensitive=
 to
compiler ABIs and versions, and it will not work correctly across different
endiannesses. Could you use explicit bitwise operations with fixed-width ty=
pes
instead?

> +
> +/* DMA stream layout consumed by the cmdlist engine; sizes are load-bear=
ing. */
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
> +
> +	row =3D (struct cmdlist_row *)((char *)cl->va + CL_HEADER_SZ) + cl->nod=
_len;
> +	row->module_cfg_addr =3D offset >> 2;
> +	row->module_cfg_strobe =3D strobe;
> +
> +	for (i =3D 0; i < CMDLIST_ROW_REGS; i++)

[Severity: High]
Are row_eof_tag and un-strobed module_regs left uninitialized here?

This overlays a struct cmdlist_row onto the cl->va DMA buffer without
explicitly clearing or setting row->row_eof_tag. If the buffer is reused
across frames and the current frame is shorter than the previous one,
row_eof_tag could contain a stale 1 from the end of a previous commit's
list.=20

If the hardware sees this uninitialized bitfield as 1, it will terminate
command processing prematurely, ignoring all subsequent commands in the cur=
rent
frame and causing display hangs.

> +		if (strobe & CMDLIST_REG_STROBE(i))
[ ... ]
> +void saturn_hee_cmdlist_fill_conf_row(struct cmdlist *cl, struct spacemi=
t_hw_device *hwdev,
> +				      u8 dev_id)
> +{
[ ... ]
> +	/* At most three rows are appended below; bail before overrunning. */
> +	if (WARN_ONCE(CL_HEADER_SZ + (cl->nod_len + 3) * CL_ROW_SZ > cl->size,
> +		      "cmdlist buffer full (type %u, rows %u)\n",
> +		      cl->type, cl->nod_len))
> +		return;

[Severity: High]
Does a desynchronized cl->nod_len cause the EOF tag to be dropped?

The calling code in cmdlist_regs_packing() unconditionally increments
cl->nod_len after calling saturn_hee_cmdlist_fill_data_row(), even if that
function silently dropped the row due to the buffer being full.

This causes cl->nod_len to artificially inflate beyond the actual rows
written. If it hits this WARN_ONCE, it aborts before appending the critical
configuration row containing row_eof_tag =3D 1.=20

Could the hardware process an incomplete command list lacking an EOF tag,
thereby failing to signal the CFG_RDY interrupt?

> +
> +	header =3D (struct cmdlist_header *)(cl->va);

> diff --git a/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c b/drivers/gpu/d=
rm/spacemit/dpu/saturn_fbcmem.c
> index 144716ec9b80c.....
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c
[ ... ]
> +int saturn_cal_layer_fbcmem_size(struct drm_plane *plane,
> +				 struct drm_plane_state *state)
> +{
> +	struct spacemit_plane_state *pstate =3D to_spacemit_plane_state(state);
> +	u32 drm_4cc_fmt =3D pstate->state.fb->format->format;

[Severity: High]
Will this dereference a NULL pointer when pstate->state.fb is NULL?

Similar to the issue in saturn_hee_plane_update_hw_channel(), state->fb
can be NULL during plane disablement or solid-fill scenarios. This
unconditional dereference will cause a kernel panic in those cases.

> +	u32 crop_w =3D pstate->state.src_w >> 16;
> +
> +	/* Only linear sizing: the compressed path is not exposed. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-k3-display=
-v1-0-6de34d80e86c@gmail.com?part=3D9
