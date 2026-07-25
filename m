Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B55EC53200
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCBE10F50B;
	Sat, 25 Jul 2026 05:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ixww+LbD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC57210F50B
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:16:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61B5B60A77;
 Sat, 25 Jul 2026 05:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE561F000E9;
 Sat, 25 Jul 2026 05:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956587;
 bh=smB236X8XNJqOB0/6cz9B1Uf3icxzbvnX/NRFA+C+hA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ixww+LbDqOB7nhukK4bNMJfw6x4osZM6BvYUrH9FDKFfceuxfS1PWhqSg0VznYo5t
 RvNuJ2NZVbM8sKpYEj3A6TLRFU731F3JE0gEV6lbU0lz2Q6sFQmetzkAbxiIZ5gMTC
 DIc6fWo7r7cPjiWiSUhIvwRrgVt22jW1o9rgS/mpoFrEwHT+kCUB3FP0eIB3RDDueC
 Sna65R9QhVVKuzsz9MmLPVOkoFy7M8DcAx5NhlZ4+BygrgGycz+dllkt2AmRWdf7q4
 e3ersTBsrPDBC6m14gxOXzf+g8eFZhYLsD9PjXX+mmLifrfb6aaJaPR5sXy1hTrC9N
 KUo4jhy1giiMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/17] drm/spacemit: add Saturn DPU core types, cmdlist
 and display MMU
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 conor+dt@kernel.org, vkoul@kernel.org, robh@kernel.org, olteanv@gmail.com
In-Reply-To: <20260724-k3-display-v1-8-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-8-f22a10a52867@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:16:26 +0000
Message-Id: <20260725051626.9AE561F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Passing exhausted NULL pointer to hardware programming function.
- [High] NULL pointer dereference when accessing state for disabled planes =
due to stale `in_use` flag.
- [High] DMMU page tables map multi-planar framebuffers out-of-bounds by ex=
clusively using the first GEM object.
- [High] Hardware DMA state buffers are reused across atomic commits withou=
t double-buffering.
- [High] Missing bounds check in `cmdlist_regs_packing` causes DMA buffer o=
verflow.
- [Medium] Unconditional dereference of `fb` in `dpu_plane_info` tracepoint.
--

--- Patch [8]: [PATCH 08/17] drm/spacemit: add Saturn DPU core types, cmdli=
st and display MMU ---
commit 82f0596ca65ff96e2081646dccab37f7bb9d1c0c
Author: Cody Kang <codykang.hk@gmail.com>
Subject: drm/spacemit: add Saturn DPU core types, cmdlist and display MMU

This commit introduces the Saturn DPU driver core types, register accessors,
and MMU table code. It implements a batched register programming model using
in-memory command lists mapped through the DPU's private address translation
unit.

> diff --git a/drivers/gpu/drm/spacemit/dpu/dpu_trace.h b/drivers/gpu/drm/s=
pacemit/dpu/dpu_trace.h
> new file mode 100644
> index 0000000000000..abfe34a67a4bd
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

[Severity: Medium]
If this tracepoint fires during a plane disable operation, will the fb
parameter be NULL? Since state->fb is typically NULL during a disable, it
looks like evaluating fb->format->format here could cause a kernel panic
when tracing is enabled.

> +			__entry->blend_mode =3D state->pixel_blend_mode;
> +			__entry->alpha =3D alpha;
> +			__entry->zpos =3D state->zpos;
> +			__entry->rotation =3D rotation;
> +	),
> +	TP_printk("rdma_id=3D%d src: w=3D%d h=3D%d x=3D%d y=3D%d crtc: w=3D%d h=
=3D%d x=3D%d y=3D%d width=3D%d height=3D%d fmt=3D0x%x blend=3D%d alpha=3D%d=
 zpos=3D%d rot=3D%d",
[ ... ]
> diff --git a/drivers/gpu/drm/spacemit/spacemit_cmdlist.c b/drivers/gpu/dr=
m/spacemit/spacemit_cmdlist.c
> new file mode 100644
> index 0000000000000..787d38e9e135f
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_cmdlist.c
[ ... ]
> +void cmdlist_regs_packing(struct cmdlist *cl, enum cmdlist_mode_type mod,
> +			  struct cmdlist_regs *cl_regs)
> +{
[ ... ]
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
Is there a bounds check missing here to prevent cl->nod_len from exceeding
cl->size? If cl is shallow-copied and reused across commits, nod_len might
accumulate and eventually overflow the 4096-byte DMA buffer, overwriting
adjacent physical memory.

> +		} else {
> +			i++;
> +		}
> +	}
> +
> +	drm_dbg(a_crtc->crtc.dev, "row_num =3D %d\n", cl->nod_len);
> +}
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
Could first_cl be NULL here for a disabled plane? During atomic state
duplication, it seems the in_use flag is inherited. If a plane is disabled,
it is removed from the plane_mask and cmdlist_sort_by_group skips clearing
the flag. This would cause cur_cl and first_cl to be NULL, leading
cl_to_spacemit_pstate to apply container_of to a NULL pointer and trigger a
negative offset dereference.

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
Does this loop exhaust cur_cl to NULL before passing it to
hwdev->crtc_cmdlist? Once the while loop finishes, cur_cl is guaranteed to =
be
NULL, which seems like it would pass an invalid pointer to the hardware
programming function instead of the intended command list head.

> +}
> +
> +/* Called from atomic_check(), where -ENOMEM is still an answer. */
> +int spacemit_cmdlist_alloc(struct device *dev, struct cmdlist *cl)
> +{
> +	if (cl->va)
> +		return 0;
> +
> +	cl->size =3D PER_CMDLIST_SIZE;
> +	cl->va =3D dma_alloc_coherent(dev, cl->size, &cl->pa,
> +				    GFP_KERNEL | __GFP_ZERO);

[Severity: High]
Does bypassing reallocation when cl->va is present cause the active hardware
state to be overwritten during the prepare phase of a non-blocking commit?
It looks like writing new register sequences directly into this reused buff=
er
could corrupt the in-flight display state being scanned out by the hardware.

> +	if (!cl->va)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/spacemit/spacemit_dmmu.c b/drivers/gpu/drm/s=
pacemit/spacemit_dmmu.c
> new file mode 100644
> index 0000000000000..2ae30dd1a4f23
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
> +		tbu.ttb_size[2] =3D PAGE_ALIGN(total_size - rounddown(offset2, PAGE_SI=
ZE))
> +				  >> PAGE_SHIFT;
> +		fallthrough;
> +	case 2:
> +		tbu.ttb_pa[1] =3D mmu_tbl->pa + (offset1 >> PAGE_SHIFT) * 4;
> +		tbu.tbu_va[1] =3D TBU_BASE_VA(tbu_id) + offset1;
> +		tbu.ttb_size[1] =3D PAGE_ALIGN(offset2 - rounddown(offset1, PAGE_SIZE)=
) >> PAGE_SHIFT;

[Severity: High]
For multi-planar formats with discrete GEM objects, does this map the
secondary planes out of bounds? The scatter/gather table is fetched strictly
from fb->obj[0]. Applying secondary offsets to the physical pages of the
first GEM object might break hardware isolation.

Could the size calculation offset2 - rounddown(offset1, PAGE_SIZE) also
underflow if these offsets belong to separate, un-ordered buffers?

> +		fallthrough;
> +	case 1:
> +		tbu.ttb_pa[0] =3D mmu_tbl->pa;
> +		tbu.tbu_va[0] =3D TBU_BASE_VA(tbu_id);
> +		tbu.ttb_size[0] =3D PAGE_ALIGN(offset1) >> PAGE_SHIFT;
> +		fallthrough;
> +	default:
> +		break;
> +	}
> +	spacemit_dmmu_fill_pgtable(mmu_tbl, sgt);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-k3-display=
-v1-0-f22a10a52867@gmail.com?part=3D8
