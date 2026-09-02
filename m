Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CAC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D4A10E1BE;
	Wed,  2 Sep 2026 10:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FLRnY4IL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9008D10F0F9
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:09:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5962E43A7F;
 Wed,  2 Sep 2026 10:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2818B1F000E9;
 Wed,  2 Sep 2026 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788343792;
 bh=/m6dDsXzCZsqomnwfYDDQKo98QJrA7JwhRwTO21UwRk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FLRnY4ILbGTqtiBXq56tEiT2GkOIJowiBi+9+nmX8XxbIPxL5JTUnKlEfoI791ZAQ
 3DrWCT4QI4cKNPRpbdAn50kaFUlQHK2fkNdIAUIt2ILb8q9cIluTYW2S0w68HfKVrO
 1qFb02pl25jwZHLMgXXcsMV9I5XsdDc4L+53h/FSI5eUbcvSSw182UtbxRGm46Wd9n
 yGKGWnkG5uGpa83hz0ZfeR5ePjEwNb85p4wXEvrDbJMdnB0zo+tGPoe4KDoLM2Iz/O
 5aLpHRA/TYZTXMAt9nGgYul3/wxWTX9YjM3exjYXzF7e3fdZmxgtnuQfGplGkPWlDW
 sP+kA58NbwJRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/imagination: Fix page count for page table for
 map() interface
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902-mmu_fix-v1-2-c55a23fb7cab@imgtec.com>
References: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
 <20260902-mmu_fix-v1-2-c55a23fb7cab@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 10:09:51 +0000
Message-Id: <20260902100952.2818B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incorrect calculation of the virtual address range for page table =
preallocation due to mistakenly adding the physical buffer offset (`sgt_off=
set`) to the virtual device address (`device_addr`).

Pre-existing issues:
- [High] Massive integer underflow in page table count calculation when a m=
apping crosses a page table boundary leads to an infinite allocation loop a=
nd kernel memory exhaustion (OOM).
--

commit e3abd749cd49c287313d0450da2a3a8485c9e53f
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

    drm/imagination: Fix page count for page table for map() interface
   =20
    GPU virtual start address wasn't included in page count for page table
    calculation for mapping an BO object in map() interface. It resulted in
    map failure later due to not enough pages at L0/L1 level.
    Update pvr_mmu_op_context_create() interface to pass device address as =
well
    to allow correct calculation for page table memory.

> diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imag=
ination/pvr_mmu.c
> index 175f0ba4d993f..52d8fbc003841 100644
> --- a/drivers/gpu/drm/imagination/pvr_mmu.c
> +++ b/drivers/gpu/drm/imagination/pvr_mmu.c
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
Does this code incorrectly mix the virtual device address (device_addr) and
the physical buffer offset (sgt_offset) to compute the starting address?

If sgt_offset represents the offset within the backing buffer, adding it to
the virtual address skews the calculation for the required page tables. This
could cause valid userspace mapping requests to randomly fail with -ENOMEM
if the shifted range covers fewer page table boundaries than the actual
mapping, causing the driver to allocate too few tables.

[ ... ]

> @@ -2364,16 +2366,16 @@ pvr_mmu_op_context_create(struct pvr_mmu_context =
*ctx, struct sg_table *sgt,
>  	if (size) {
>  		/*
>  		 * The number of page table objects we need to prealloc is
> -		 * indicated by the mapping size, start offset and the sizes
> +		 * indicated by the mapping size, start address and the sizes
>  		 * of the areas mapped per PT or PD. The range calculation is
>  		 * identical to that for the index into a table for a device
>  		 * address, so we reuse those functions here.
>  		 */
> -		const u32 l1_start_idx =3D pvr_page_table_l2_idx(sgt_offset);
> -		const u32 l1_end_idx =3D pvr_page_table_l2_idx(sgt_offset + size);
> +		const u32 l1_start_idx =3D pvr_page_table_l2_idx(start_addr);
> +		const u32 l1_end_idx =3D pvr_page_table_l2_idx(start_addr + size);
>  		const u32 l1_count =3D l1_end_idx - l1_start_idx + 1;
> -		const u32 l0_start_idx =3D pvr_page_table_l1_idx(sgt_offset);
> -		const u32 l0_end_idx =3D pvr_page_table_l1_idx(sgt_offset + size);
> +		const u32 l0_start_idx =3D pvr_page_table_l1_idx(start_addr);
> +		const u32 l0_end_idx =3D pvr_page_table_l1_idx(start_addr + size);
>  		const u32 l0_count =3D l0_end_idx - l0_start_idx + 1;

[Severity: High]
This is a pre-existing issue, but can this subtraction cause a massive
integer underflow when a mapping crosses a page table boundary?

Because pvr_page_table_l1_idx() and pvr_page_table_l2_idx() return local
indices bounded within their parent tables (e.g., 0-511), if the address ra=
nge
crosses a boundary (1GB for L1 tables or 2MB for L0 tables), l0_end_idx cou=
ld
be smaller than l0_start_idx (e.g., 0 and 511).

The subtraction l0_end_idx - l0_start_idx + 1 would evaluate to an unsigned
32-bit underflow.

When this happens, the subsequent loop for (int i =3D 0; i < l0_count; i++)
in pvr_mmu_op_context_create() iterates billions of times, exhausting kernel
memory via kzalloc and triggering the OOM killer. This is directly reachable
by unprivileged userspace via the GPUVM map IOCTL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-mmu_fix-v1=
-0-c55a23fb7cab@imgtec.com?part=3D2
