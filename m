Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBF9C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6048D10F2C0;
	Fri, 18 Sep 2026 10:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F2N7UW+d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5B610F2C0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:23:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3985441B11;
 Fri, 18 Sep 2026 10:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A0B1F000FF;
 Fri, 18 Sep 2026 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789726996;
 bh=aP6sxzGnR2r5EiygJGLcRleZTJlCHRlOQxv3vuBCyXA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F2N7UW+dZ2ozGHiyQaKV7UeT44L2l30OqT9PdVo2GeEShjbWZxJSqooSM369UWqO4
 jPlHUoFlxAAIUQWUODsCY8XzdGqSNlf4BKar8GFZf95/55nSeuVdr+P90GmYBA3ZfH
 AR0pofkd0NptkA2DRr0/qQg+ekRs+gFidNkRoyl8baBLaDYA+xc/hzveqGeQNL9ClY
 A3rkWoygJskwid0qGsDPRf9jPjWQBNu8HWMzVOF8rgtuutnbXMYmwP7bgVuLTCFOxa
 8HCLEPM1My3NMMSmQ1UIu+drl55W0ZiHbdrTZ1iwQenhCmzWVA3ENHDXmTdyWu/pES
 itVfYEjD6812Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/imagination: Fix page count for page table
 for map() interface
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918-mmu_fix-v2-2-f7c004fbe203@imgtec.com>
References: <20260918-mmu_fix-v2-0-f7c004fbe203@imgtec.com>
 <20260918-mmu_fix-v2-2-f7c004fbe203@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:23:15 +0000
Message-Id: <20260918102315.E4A0B1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/imagination: Incorrect page table preallocation range due to a=
dding `sgt_offset` to `device_addr`
--

commit 2e37e7dddaa25fcebfc6ed4f14676377ac438e44
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix page count for page table for map() interface

This patch updates the page table preallocation calculation for mapping a
buffer object. It passes the device address to pvr_mmu_op_context_create()
to include it in the page count calculation, aiming to fix under-allocations
at the L0/L1 level.

> diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imag=
ination/pvr_mmu.c
> --- a/drivers/gpu/drm/imagination/pvr_mmu.c
> +++ b/drivers/gpu/drm/imagination/pvr_mmu.c
[ ... ]
> @@ -2347,8 +2348,9 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_c=
ontext *op_ctx)
>   */
>  struct pvr_mmu_op_context *
>  pvr_mmu_op_context_create(struct pvr_mmu_context *ctx, struct sg_table *=
sgt,
> -			  u64 sgt_offset, u64 size)
> +			  u64 device_addr, u64 sgt_offset, u64 size)
>  {
> +	u64 start_addr =3D device_addr + sgt_offset;

[Severity: High]
Does this calculation incorrectly add a physical buffer offset to the virtu=
al
address?

In pvr_mmu_op_context_create(), device_addr is the virtual address where the
mapping begins, and sgt_offset represents the physical byte offset into the
backing buffer object (the scatter-gather table). Adding sgt_offset to
device_addr artificially shifts the bounds for the page table calculations.

When this shifted start_addr is used a few lines down to calculate the
required L0 and L1 page tables:

    const u32 l1_start_idx =3D pvr_page_table_l2_idx(start_addr);
    const u32 l1_end_idx =3D pvr_page_table_l2_idx(start_addr + size);

Will this under-allocate the required number of page tables if the true
virtual address range [device_addr, device_addr + size - 1] crosses a page
table boundary (e.g., a 2MB boundary for L0 tables), but the erroneously
shifted range does not?

If the tables are under-allocated here, traversing the true virtual address
boundaries later in pvr_mmu_map() will exhaust the preallocated tables and
cause an -ENOMEM failure. Could this be triggered by untrusted user space v=
ia
the VM_BIND ioctl to abort a valid user mapping request?

>  	int err;
> =20
>  	struct pvr_mmu_op_context *op_ctx =3D kzalloc_obj(*op_ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-mmu_fix-v2=
-0-f7c004fbe203@imgtec.com?part=3D2
