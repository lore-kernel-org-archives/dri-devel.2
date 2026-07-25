Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B1BC53200
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B137110E672;
	Sat, 25 Jul 2026 05:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="awMd5Abg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA7D10E672
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:04:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5E7340AC4;
 Sat, 25 Jul 2026 05:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4CB1F00A3A;
 Sat, 25 Jul 2026 05:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784955879;
 bh=5XEF+qAkWLuT5nSe/bguE8gYGpt4U9yK4reEWVi3igs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=awMd5Abg8UavHKA/stIUBpgXUGPnMi3cgoP7b4Hzg0BxqAXk7CevaHQB6f7uPnSOg
 JlyXRr0Luxl19BxhG5MKtSDda7cWVnxcZVQsWUjF2KLfJCRcWZppM8Vc++0Eb6IWCe
 N5YGoR4EcHHai+n30Y/jQftugbzNZq4nvz3zGd/yDMOkWtiLCjgHCjrul9guyZA1He
 ZLPAUXSRNjN8lFNXGxmAsT0jrdX8W2kJrG+RI1bPz0UyW74YkG+xH42lfw7WUTOcZ1
 SV/LZicOovhAol2woZzmuz64+Rw4frA7BpuJWuTMYY0XyrXPlv0ahcpDpRSdTCdQgs
 NIKhHyV68rGGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 08/17] drm/spacemit: add Saturn DPU core types,
 cmdlist and display MMU
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: conor+dt@kernel.org, linux-phy@lists.infradead.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, olteanv@gmail.com
In-Reply-To: <20260725-k3-display-v1-8-6de34d80e86c@gmail.com>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-8-6de34d80e86c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:04:38 +0000
Message-Id: <20260725050439.2A4CB1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] DMMU page table size calculation underflow allows arbitrary ph=
ysical memory access.
- [Critical] Shallow copy of DMA buffers in atomic state causes active disp=
lay corruption.
- [High] crtc_cmdlist_atomic_commit() passes a guaranteed NULL pointer to t=
he hardware command list execution callback.
- [High] Global `cmdlist_groups` array causes data races across concurrent =
atomic commits.
- [High] Unconditional dereference of `first_cl` in `cmdlist_atomic_commit(=
)` causes a kernel panic if the command list group is empty.
- [High] DMMU maps only the first GEM object, breaking multi-planar framebu=
ffers.
- [High] NULL pointer dereference in `dpu_plane_info` tracepoint.
- [High] Sleeping in atomic context via `drm_gem_shmem_get_pages_sgt()`.
- [High] Missing bounds check on `nod_len` causes DMA buffer overflow.
- [Medium] Unaligned base virtual addresses are used for DMMU translation r=
egions.
- [Medium] Memory leak of DMA buffers upon atomic state destruction.
- [Medium] Speculative array out-of-bounds access in `cmdlist_sort_by_group=
()`.
--

--- Patch [8]: [PATCH RESEND 08/17] drm/spacemit: add Saturn DPU core types=
, cmdlist and display MMU ---
commit dc983d68951c3577447bb897e17c833e557da908
Author: Cody Kang <codykang.hk@gmail.com>

drm/spacemit: add Saturn DPU core types, cmdlist and display MMU

This commit introduces the shared driver types, MMIO accessors, trace
events, command-list builder, and DMMU table code for the Saturn DPU.
It enables batched register programming by building per-module register
lists in memory, which the hardware command-list engine replays.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_trace.h b/drivers/gpu/drm/s=
pacemit/dpu/dpu_trace.h
> index 0000000000000..abfe34a67a4bd 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/dpu_trace.h
[ ... ]
> +TRACE_EVENT(dpu_plane_info,
> +	    TP_PROTO(struct drm_plane_state *state, struct drm_framebuffer *fb,
> +		     u32 rdma_id, u32 alpha, u32 rotation),
> +	TP_ARGS(state, fb, rdma_id, alpha, rotation),
> +	TP_STRUCT__entry(
> +			__field(u32, rdma_id)
> +			__field(u32, src_w)
> +			__field(u32, src_h)
> +			__field(u32, src_x)
> +			__field(u32, src_y)
> +			__field(u32, crtc_w)
> +			__field(u32, crtc_h)
> +			__field(u32, crtc_x)
> +			__field(u32, crtc_y)
> +			__field(u32, width)
> +			__field(u32, height)
> +			__field(u32, format)
> +			__field(u32, blend_mode)
> +			__field(u32, alpha)
> +			__field(u32, zpos)
> +			__field(u32, rotation)
> +	),
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
Can this dereference a NULL pointer? When a plane is disabled during an
atomic commit, state->fb might be NULL. Unconditionally reading fb->width
here could cause a kernel panic if tracing is enabled.

> +			__entry->blend_mode =3D state->pixel_blend_mode;
> +			__entry->alpha =3D alpha;
> +			__entry->zpos =3D state->zpos;
> +			__entry->rotation =3D rotation;
> +	),
[ ... ]
> diff --git a/drivers/gpu/drm/spacemit/spacemit_cmdlist.c b/drivers/gpu/dr=
m/spacemit/spacemit_cmdlist.c
> index 0000000000000..787d38e9e135f 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_cmdlist.c
[ ... ]
> +void cmdlist_regs_packing(struct cmdlist *cl, enum cmdlist_mode_type mod,
> +			  struct cmdlist_regs *cl_regs)
> +{
[ ... ]
> +	for (i =3D 0; i < cl_regs->size;) {
> +		u32 value[CMDLIST_ROW_REGS] =3D {0x0};
> +		u32 offset, strobe =3D 0;
> +		u8 regs_in_row =3D 0;
> +
> +		if (cl_regs->flags[i]) {
> +			offset =3D cl_regs->base + i * sizeof(u32);
> +			for (u8 j =3D 0; j < CMDLIST_ROW_REGS; j++) {
> +				index =3D i + j;
> +				if (likely(index < cl_regs->size)) {
> +					if (cl_regs->flags[index]) {
> +						value[j] =3D reg_base[index];
> +						regs_in_row++;
> +						strobe |=3D CMDLIST_REG_STROBE(j);
> +					}
> +				} else {
> +					break;
> +				}
> +			}
> +			hwdev->cmdlist_fill_data_row(cl, strobe, offset, value);
> +			/*
> +			 * the row covers the whole window; a shorter stride
> +			 * would revisit covered words as duplicate rows
> +			 */
> +			i +=3D CMDLIST_ROW_REGS;
> +			cl->nod_len++;

[Severity: High]
Is there a risk of overflowing the DMA command list buffer here? The loop
increments cl->nod_len and writes to memory, but there doesn't seem to be
a bounds check to ensure the packed rows do not exceed the allocated
capacity in cl->size.

> +		} else {
> +			i++;
> +		}
> +	}
> +
> +	drm_dbg(a_crtc->crtc.dev, "row_num =3D %d\n", cl->nod_len);
> +}
> +
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
> +		u32 rdma_id =3D spacemit_pstate->rdma_id;
> +
> +		first_cl =3D &spacemit_pstate->cl;
> +		if (!first_cl->va)
> +			continue;
> +
> +		last_cl =3D first_cl;
> +		last_cl->next =3D NULL;
> +
> +		rdmas[rdma_id].in_use =3D true;

[Severity: Medium]
Could rdma_id exceed the bounds of the array? It is used directly as an
index for the rdmas array without checking if it is within hwdev->rdma_nums.

> +		if (priv->cmdlist_groups[rdma_id]) {

[Severity: High]
Does modifying the global priv->cmdlist_groups array here cause data races?
Since this array is stored in the shared spacemit_drm_private structure,
concurrent atomic commits on multiple CRTCs might overwrite each other's
command lists without locking.

> +			p =3D priv->cmdlist_groups[rdma_id];
> +			prev =3D NULL;
> +			while (p) {
> +				if (cl_to_spacemit_pstate(p)->state.crtc_y <
> +				    spacemit_pstate->state.crtc_y) {
> +					prev =3D p;
> +					p =3D p->next;
> +				} else {
> +					break;
> +				}
> +			}
> +			if (!prev) {
> +				priv->cmdlist_groups[rdma_id] =3D first_cl;
> +				last_cl->next =3D p;
> +			} else {
> +				prev->next =3D first_cl;
> +				last_cl->next =3D p;
> +			}
> +		} else {
> +			priv->cmdlist_groups[rdma_id] =3D first_cl;
> +		}
> +	}
> +}
> +
> +void cmdlist_atomic_commit(struct drm_crtc *crtc,
> +			   struct drm_crtc_state *old_state)
> +{
[ ... ]
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
Could first_cl be NULL here? If cur_rdmas[i].in_use is true but
priv->cmdlist_groups[i] is empty, first_cl would be NULL. This can happen
if planes are removed from the state but in_use was copied as true from the
old state. The cl_to_spacemit_pstate macro would yield a negative offset
from NULL, resulting in a crash.

> +			addrl =3D (lower_32_bits(priv->cmdlist_groups[i]->pa) &
> +				 CMDLIST_ADDRL_ALIGN_MASK) >> CMDLIST_ADDRL_ALIGN_BITS;
> +
> +			addrh =3D upper_32_bits(priv->cmdlist_groups[i]->pa);
> +			hwdev->cfg_cmdlist(hwdev, i, chy, addrl, addrh);
> +			hwdev->enable_cmdlist(a_crtc, hwdev, i, true);
> +			priv->cmdlist_groups[i] =3D NULL;
> +		}
> +	}
> +}
> +
[ ... ]
> +void crtc_cmdlist_atomic_commit(struct spacemit_crtc *a_crtc)
> +{
> +	struct cmdlist *cur_cl;
> +	struct drm_crtc *crtc =3D &a_crtc->crtc;
> +	struct spacemit_drm_private *priv =3D crtc->dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +	u8 crtc_id =3D drm_crtc_index(crtc);
> +	u8 dev_id =3D a_crtc->dev_id;
> +
> +	drm_dbg(crtc->dev, "cmdlist group =3D %d\n",
> +		hwdev->rdma_nums + crtc_id);
> +	cur_cl =3D priv->cmdlist_groups[hwdev->rdma_nums + crtc_id];
> +	while (cur_cl) {
> +		hwdev->cmdlist_fill_conf_row(cur_cl, hwdev, dev_id);
> +		cmdlist_dump_node(cur_cl);
> +		cur_cl =3D cur_cl->next;
> +	}
> +	hwdev->crtc_cmdlist(cur_cl, hwdev, priv, crtc_id, dev_id);

[Severity: High]
Does this pass a guaranteed NULL pointer to the hardware callback?
The while loop exhausts cur_cl to NULL, which is then immediately passed
to hwdev->crtc_cmdlist. It looks like the head of the list should be
passed instead.

> +}
> +
> +/* Called from atomic_check(), where -ENOMEM is still an answer. */
> +int spacemit_cmdlist_alloc(struct device *dev, struct cmdlist *cl)
> +{
> +	if (cl->va)
> +		return 0;

[Severity: Critical]
Does returning early when cl->va is present cause active display corruption?
Because struct cmdlist is embedded directly in the plane state, DRM's state
duplication will shallow-copy cl->va. If atomic_update mutates this same
virtual address while the hardware is actively reading it from the old
state, it could lead to screen tearing or DPU hangs. DMA buffers for
command lists generally need to be multi-buffered or allocated per-state.

> +
> +	cl->size =3D PER_CMDLIST_SIZE;
> +	cl->va =3D dma_alloc_coherent(dev, cl->size, &cl->pa,
> +				    GFP_KERNEL | __GFP_ZERO);
> +	if (!cl->va)
> +		return -ENOMEM;

[Severity: Medium]
Is there a corresponding dma_free_coherent() during state destruction?
If the allocated cl->va is never freed when the atomic state is destroyed,
this might cause a steady leak of DMA memory.

> +
> +	return 0;
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/spacemit/spacemit_dmmu.c b/drivers/gpu/drm/s=
pacemit/spacemit_dmmu.c
> index 0000000000000..2ae30dd1a4f23 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_dmmu.c
[ ... ]
> +int spacemit_dmmu_map(struct drm_framebuffer *fb, struct dpu_mmu_tbl *mm=
u_tbl,
> +		      u8 tbu_id, struct cmdlist_regs *cl_rdma,
> +		 struct drm_plane *plane)
> +{
> +	struct spacemit_drm_private *priv =3D fb->dev->dev_private;
> +	struct spacemit_hw_device *hwdev =3D priv->hwdev;
> +	const struct drm_format_info *format =3D NULL;
> +	struct sg_table *sgt =3D NULL;
> +	u32 total_size, offset1, offset2;
> +	struct tbu_instance tbu =3D { };
> +	u8 plane_num;
> +	u32 val;
> +
> +	format =3D fb->format;
> +	sgt =3D drm_gem_shmem_get_pages_sgt(to_drm_gem_shmem_obj(fb->obj[0]));

[Severity: High]
Will this sleep in atomic context? This function appears to be called
during hardware programming in the atomic commit phase. Calling
drm_gem_shmem_get_pages_sgt allocates memory and can acquire a mutex,
which is forbidden in atomic context. Buffer mapping typically needs to be
deferred to the sleepable prepare_fb callback.

[Severity: High]
Does mapping only fb->obj[0] break multi-planar framebuffers? If userspace
provides a multi-planar framebuffer where the planes reside in different GEM
objects, extracting the SG table only for obj[0] will result in incorrect
physical memory pages for the secondary planes.

> +	if (IS_ERR(sgt))
> +		return PTR_ERR(sgt);
> +
> +	plane_num =3D format->num_planes;
> +
> +	total_size =3D roundup(fb->obj[0]->size, PAGE_SIZE);
> +
> +	offset1 =3D plane_num > 1 ? fb->offsets[1] : total_size;
> +	offset2 =3D plane_num > 2 ? fb->offsets[2] : total_size;
> +
> +	switch (plane_num) {
> +	case 3:
> +		tbu.ttb_pa[2] =3D mmu_tbl->pa + (offset2 >> PAGE_SHIFT) * 4;
> +		tbu.tbu_va[2] =3D TBU_BASE_VA(tbu_id) + offset2;

[Severity: Medium]
Could adding offset2 directly to TBU_BASE_VA result in unaligned base
virtual addresses? If userspace supplies an offset that is not a multiple
of PAGE_SIZE, programming an unaligned virtual address might confuse the
hardware MMU.

> +		tbu.ttb_size[2] =3D PAGE_ALIGN(total_size - rounddown(offset2, PAGE_SI=
ZE))
> +				  >> PAGE_SHIFT;

[Severity: Critical]
Can this size calculation underflow? If a malicious userspace client
provides offset2 smaller than offset1, the unsigned subtraction
offset2 - rounddown(offset1, PAGE_SIZE) will underflow to a massive
positive value. This could program the DMMU with a huge translation block,
allowing arbitrary out-of-bounds physical memory reads.

> +		fallthrough;
> +	case 2:
> +		tbu.ttb_pa[1] =3D mmu_tbl->pa + (offset1 >> PAGE_SHIFT) * 4;
> +		tbu.tbu_va[1] =3D TBU_BASE_VA(tbu_id) + offset1;
> +		tbu.ttb_size[1] =3D PAGE_ALIGN(offset2 - rounddown(offset1, PAGE_SIZE)=
) >> PAGE_SHIFT;
> +		fallthrough;
> +	case 1:
> +		tbu.ttb_pa[0] =3D mmu_tbl->pa;
> +		tbu.tbu_va[0] =3D TBU_BASE_VA(tbu_id);
> +		tbu.ttb_size[0] =3D PAGE_ALIGN(offset1) >> PAGE_SHIFT;
> +		fallthrough;
> +	default:
> +		break;
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-k3-display=
-v1-0-6de34d80e86c@gmail.com?part=3D8
