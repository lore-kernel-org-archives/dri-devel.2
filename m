Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C04DC5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E837110E577;
	Sun,  9 Aug 2026 13:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j4Sa+1D5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E519510E577
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:32:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 409F560008;
 Sun,  9 Aug 2026 13:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F325B1F000E9;
 Sun,  9 Aug 2026 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786282356;
 bh=lEXjqIf8lufJp/FLdgsOxISP2ZL1yVis2DgezW671Eg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j4Sa+1D53xHlPJRHF0373NAIgSRcBvxs5xfHdWX5xScKwNUpESULi6rka9gDA2m2r
 IXoNZei/AL2wSsXVbKJSloeYfEx5PXvTjtyn7VZsg6YhADWIyufgeNoZK6X1E9KxQ5
 BKiGDS5VuJ5RuJpQ6mkAqBDS7BRmkNNwBx957Z39dsDu0s24oG7DVB7gBLJMGAoLxL
 IyNBhjiU/ikyGueViLejDKoaNKIVNoH3lJu7w+wYln74BIXHsMBzg2FJAw2WoocOr8
 XLYhv4dExjqiDjKWH3i8/spS7AReSWd48fWnc3GTHieAy7r5VmEFMMkSlofC8UBzI3
 T7bgC9wj1QhnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/17] drm/spacemit: add Saturn DPU core types,
 cmdlist and display MMU
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, linux-phy@lists.infradead.org, vkoul@kernel.org,
 robh@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20260809-k3-display-v2-8-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-8-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 13:32:34 +0000
Message-Id: <20260809133234.F325B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Modifying the command list of unmodified planes during CRTC co=
mmits leads to unbounded growth of `cl->nod_len` and DMA buffer overflow.
- [High] Command list DMA buffers are embedded in transient atomic states, =
leading to lifecycle conflicts and shared buffer corruption.
- [High] Unconditional dereference of `priv->cmdlist_groups[i]` leads to a =
NULL pointer dereference in `cmdlist_atomic_commit`.
- [High] Directly accessing `plane->state` and `crtc->state` during atomic =
commits creates TOCTOU races with subsequent non-blocking commits.
- [High] Hardware DMMU reads out of bounds if the page table entries exceed=
 the pre-allocated buffer size limit.
- [High] NULL pointer dereference on `fb` in the `dpu_plane_info` tracepoin=
t.
- [High] Potential NULL pointer dereference of `a_crtc->crtc.dev` in `cmdli=
st_regs_packing` if a plane is being disabled.
- [High] Calling `spacemit_dmmu_map` sleeps in an atomic context and introd=
uces data races on the command list.
- [Medium] Unprotected read-modify-write on MMIO registers in the `__dpu_mm=
io_field_write` macro.
- [Medium] Unvalidated `rdma_id` is used directly as an array index, leadin=
g to out-of-bounds writes.
--

--- Patch [8]: [PATCH v2 08/17] drm/spacemit: add Saturn DPU core types, cm=
dlist and display MMU ---
commit 4c661acb763f61ae82caefcc3ef85c607c0b6ffe
Author: Cody Kang <codykang.hk@gmail.com>

drm/spacemit: add Saturn DPU core types, cmdlist and display MMU

Register programming of the Saturn DPU is batched: the driver builds
per-module register lists in memory and the hardware command-list
engine replays them at frame boundaries, while scanout buffers are
mapped through the DPU's private address translation unit (DMMU)
rather than scanned out by physical address.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_trace.h b/drivers/gpu/drm/s=
pacemit/dpu/dpu_trace.h
> index 0000000000000..abfe34a67a4bd 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_trace.h
[ ... ]
> +	TP_fast_assign(
> +			__entry->rdma_id =3D rdma_id;
> +			__entry->src_w =3D state->src_w >> 16;
> +			__entry->src_h =3D state->src_h >> 16;
> +			__entry->src_x =3D state->src_x >> 16;
> +			__entry->src_y =3D state->src_y >> 16;
> +			__entry->crtc_w =3D state->crtc_w;
> +			__entry->crtc_h =3D state->crtc_h;
> +			__entry->crtc_x =3D state->crtc_x;
> +			__entry->crtc_y =3D state->crtc_y;
> +			__entry->width =3D fb->width;
> +			__entry->height =3D fb->height;
> +			__entry->format =3D fb->format->format;

[Severity: High]
Is it possible for fb to be NULL here?=20

During a plane disable operation in the DRM atomic framework, the plane
state will have a NULL framebuffer. Would this tracepoint cause a NULL
pointer dereference when capturing these fields?

> diff --git a/drivers/gpu/drm/spacemit/spacemit_cmdlist.c b/drivers/gpu/dr=
m/spacemit/spacemit_cmdlist.c
> index 0000000000000..f4f14eaa12a0f 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_cmdlist.c
[ ... ]
> +void cmdlist_regs_packing(struct cmdlist *cl, enum cmdlist_mode_type mod,
> +			  struct cmdlist_regs *cl_regs)
> +{
[ ... ]
> +	if (cl->type =3D=3D CMDLIST_PLANE) {
> +		struct spacemit_plane_state *spacemit_pstate =3D
> +				cl_to_spacemit_pstate(cl);
> +
> +		a_crtc =3D to_spacemit_crtc(spacemit_pstate->state.crtc);
> +
> +		drm_dbg(a_crtc->crtc.dev, "rch_id =3D %d, ch_y =3D %u\n",

[Severity: High]
When a plane is disabled, its state.crtc is set to NULL. Could a_crtc end
up being NULL here, leading to a dereference when accessing
a_crtc->crtc.dev for logging?

> +			spacemit_pstate->rdma_id,
> +			spacemit_pstate->state.crtc_y);
> +	} else if (cl->type =3D=3D CMDLIST_CRTC) {
[ ... ]
> +void cmdlist_sort_by_group(struct drm_crtc *crtc)
> +{
> +	struct cmdlist *first_cl;
> +	struct cmdlist *last_cl;
> +	struct cmdlist *p;
> +	struct cmdlist *prev;
> +	struct drm_plane *plane;
> +	struct spacemit_crtc_rdma *rdmas =3D
> +			to_spacemit_crtc_state(crtc->state)->rdmas;
> +	struct spacemit_drm_private *priv =3D crtc->dev->dev_private;
> +
> +	drm_atomic_crtc_for_each_plane(plane, crtc) {
> +		struct spacemit_plane_state *spacemit_pstate =3D
> +			to_spacemit_plane_state(plane->state);

[Severity: High]
Does directly accessing the current plane->state create a TOCTOU race
with subsequent non-blocking commits?=20

In asynchronous commit tails, the DRM core swaps these pointers. Using
plane->state directly instead of the passed drm_atomic_state might result
in reading uncommitted state.

> +		u32 rdma_id =3D spacemit_pstate->rdma_id;
> +
> +		first_cl =3D &spacemit_pstate->cl;
> +		if (!first_cl->va)
> +			continue;
> +
> +		last_cl =3D first_cl;
> +		last_cl->next =3D NULL;

[Severity: Critical]
What happens to the command list of unmodified planes during CRTC commits?=
=20

It looks like we mutate last_cl->next for all active planes, even those
not modified by the current commit. Later in cmdlist_atomic_commit(),
cmdlist_fill_conf_row() appends configuration rows to it. Since the plane
state isn't duplicated, does cl->nod_len grow unboundedly on every update
until it overflows the fixed DMA buffer?

> +
> +		rdmas[rdma_id].in_use =3D true;
> +		if (priv->cmdlist_groups[rdma_id]) {

[Severity: Medium]
Is there a guarantee that rdma_id is within bounds?=20

We are using it as an index into rdmas[] and priv->cmdlist_groups[]
without validating it against the hardware limit (hwdev->rdma_nums) or
checking for RDMA_INVALID_ID.

[ ... ]
> +void cmdlist_atomic_commit(struct drm_crtc *crtc,
> +			   struct drm_crtc_state *old_state)
> +{
> +	int i;
> +	struct cmdlist *cur_cl, *first_cl;
> +	struct spacemit_crtc *a_crtc =3D NULL;
> +	u32 chy, addrl, addrh;
> +	struct spacemit_drm_private *priv =3D crtc->dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +	struct spacemit_crtc_rdma *cur_rdmas =3D
> +			to_spacemit_crtc_state(crtc->state)->rdmas;

[Severity: High]
Similar to the plane state access earlier, does accessing crtc->state
directly create a race condition with asynchronous commits?

> +	struct spacemit_crtc_rdma *old_rdmas =3D
> +			to_spacemit_crtc_state(old_state)->rdmas;
> +
> +	a_crtc =3D to_spacemit_crtc(crtc);
> +
> +	for (i =3D 0; i < hwdev->rdma_nums; i++) {
> +		if (old_rdmas[i].in_use)
> +			hwdev->enable_cmdlist(a_crtc, hwdev, i, false);
> +
> +		if (cur_rdmas[i].in_use) {
> +			drm_dbg(crtc->dev, "cmdlist group =3D %d\n", i);
> +			cur_cl =3D priv->cmdlist_groups[i];
> +			first_cl =3D cur_cl;
> +			while (cur_cl) {
> +				hwdev->cmdlist_fill_conf_row(cur_cl, hwdev,
> +					CMDLIST_CMP_INVALID);
> +				cmdlist_dump_node(cur_cl);
> +				cur_cl =3D cur_cl->next;
> +			}
> +			chy =3D cl_to_spacemit_pstate(first_cl)->state.crtc_y;

[Severity: High]
If cmdlist_sort_by_group() skips populating priv->cmdlist_groups[i]
because first_cl->va was NULL, but cur_rdmas[i].in_use remains true
(inherited from the old state before disabling), could cur_cl become NULL?

If so, this would lead to a NULL pointer dereference when accessing
first_cl or priv->cmdlist_groups[i]->pa just below.

> +			addrl =3D (lower_32_bits(priv->cmdlist_groups[i]->pa) &
> +				 CMDLIST_ADDRL_ALIGN_MASK) >> CMDLIST_ADDRL_ALIGN_BITS;
[ ... ]
> +int spacemit_cmdlist_alloc(struct device *dev, struct cmdlist *cl)
> +{
> +	if (cl->va)
> +		return 0;
> +
> +	cl->size =3D PER_CMDLIST_SIZE;
> +	cl->va =3D dma_alloc_coherent(dev, cl->size, &cl->pa,
> +				    GFP_KERNEL | __GFP_ZERO);

[Severity: High]
Should the command list DMA buffer be embedded directly in the transient
plane state?=20

By skipping allocation when cl->va is non-NULL, duplicating plane states
results in a shallow copy where all states share the same physical DMA
buffer. Mutating this buffer during a new atomic commit might overwrite
the command list actively being scanned out by the hardware.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_dmmu.c b/drivers/gpu/drm/s=
pacemit/spacemit_dmmu.c
> index 0000000000000..ff4b3378a087c 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_dmmu.c
[ ... ]
> +static inline void spacemit_dmmu_fill_pgtable(struct dpu_mmu_tbl *tbl,
> +					      struct sg_table *sgt)
> +{
> +	struct sg_dma_page_iter dma_iter;
> +	u32 max_entries =3D tbl->size / 4;
> +	u32 *ttbr =3D tbl->va;
> +	u32 i =3D 0, n =3D 0, temp =3D 0;
> +
> +	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
> +		/*
> +		 * atomic_check sized the table off this same fb; catch a drift
> +		 */
> +		if (WARN_ON_ONCE(n + HW_ALIGN_TTB_NUM >=3D max_entries))
> +			break;

[Severity: High]
If we hit this WARN_ON_ONCE and break early, we don't communicate the
truncated size back to the caller.=20

> +		ttbr[n++] =3D (sg_page_iter_dma_address(&dma_iter) >> PAGE_SHIFT) & 0x=
3FFFFFF;
> +	}
[ ... ]
> +int spacemit_dmmu_map(struct drm_framebuffer *fb, struct dpu_mmu_tbl *mm=
u_tbl,
> +		      u8 tbu_id, struct cmdlist_regs *cl_rdma,
> +		 struct drm_plane *plane)
> +{
> +	struct spacemit_drm_private *priv =3D fb->dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +	struct sg_table *sgt =3D NULL;
> +	struct tbu_instance tbu =3D { };
> +	u32 val;
> +
> +	sgt =3D drm_gem_shmem_get_pages_sgt(to_drm_gem_shmem_obj(fb->obj[0]));

[Severity: High]
Is it safe to call this here?=20

drm_gem_shmem_get_pages_sgt() performs a sleepable allocation (GFP_KERNEL)
and acquires a mutex. If called during atomic_update (the standard
hardware programming phase), it sleeps in an atomic context.

If called during prepare_fb to avoid the atomic context, does mutating
the cl_rdma buffer below introduce data races with the hardware
processing the previous frame?

> +	if (IS_ERR(sgt))
> +		return PTR_ERR(sgt);
> +
> +	/* Every advertised format is single-planar */
> +	tbu.ttb_pa[0] =3D mmu_tbl->pa;
> +	tbu.tbu_va[0] =3D TBU_BASE_VA(tbu_id);
> +	tbu.ttb_size[0] =3D roundup(fb->obj[0]->size, PAGE_SIZE) >> PAGE_SHIFT;

[Severity: High]
Since tbu.ttb_size[0] is programmed to the full FB size regardless of
whether spacemit_dmmu_fill_pgtable() truncated the table, could this
cause the hardware DMMU to read out of bounds past the physical
allocation of mmu_tbl?

> +
> +	spacemit_dmmu_fill_pgtable(mmu_tbl, sgt);
> +
> +	/*
> +	 * enable =3D 1, fbc_mode =3D 0 (linear only)
> +	 * single plane in bits [3:2]
> +	 */
> +	val =3D 0x1;
> +	/* tbu_burst_limit_en =3D 1, tlb_fetch_active_en =3D 1 */
> +	val |=3D BIT(4) | BIT(5);
> +	val =3D val | (DPU_QOS_URGENT << 8);
> +	hwdev->rdma_dmmu(hwdev, tbu_id, &tbu, fb, val, cl_rdma, plane);

> diff --git a/drivers/gpu/drm/spacemit/spacemit_dpu_reg.h b/drivers/gpu/dr=
m/spacemit/spacemit_dpu_reg.h
> index 0000000000000..a57ed34d38e2f 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_dpu_reg.h
[ ... ]
> +#define __dpu_mmio_field_write(__addr, __mask, data)			\
> +do {									\
> +	if ((__mask) =3D=3D 0xffU)						\
> +		writeb((u8)((data) & 0xffU), __addr);			\
> +	else if ((__mask) =3D=3D 0xff00U)					\
> +		writeb((u8)((data) & 0xffU), (__addr) + 1);		\
> +	else if ((__mask) =3D=3D 0xff0000U)					\
> +		writeb((u8)((data) & 0xffU), (__addr) + 2);		\
> +	else if ((__mask) =3D=3D 0xff000000U)				\
> +		writeb((u8)((data) & 0xffU), (__addr) + 3);		\
> +	else if ((__mask) =3D=3D 0xffffU)					\
> +		writew((u16)((data) & 0xffffU), __addr);		\
> +	else if ((__mask) =3D=3D 0xffff0000U)				\
> +		writew((u16)((data) & 0xffffU), (__addr) + 2);		\
> +	else if ((__mask) =3D=3D 0xffffffffU)				\
> +		writel((u32)(data), __addr);				\
> +	else								\
> +		writel((readl(__addr) & ~(__mask)) |			\
> +		       FIELD_PREP(__mask, (u32)(data)), __addr);	\

[Severity: Medium]
Could concurrent updates corrupt the hardware state here?=20

This is an unprotected read-modify-write sequence. If a register contains
multiple fields updated from different contexts (e.g., process context
during atomic commits and interrupt context during ISR handling), it
might lose updates without a spinlock.

> +} while (0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-k3-display=
-v2-0-327d7910bf71@gmail.com?part=3D8
