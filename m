Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772C9C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC02310E5BC;
	Tue, 22 Sep 2026 04:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N1EZEM63";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C44C10E5BC
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 04:41:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B413E600CB;
 Tue, 22 Sep 2026 04:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6AD1F000FF;
 Tue, 22 Sep 2026 04:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790052076;
 bh=4nrIoJohicZV8Ao8qIYZK1mmDE3bXGUBhEF8KAxCsZg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N1EZEM63HzZXkuLnR0fNawD9/8sLl2Ofj+Sc8zgciBtiyelGzc6Qpc+kFxUmYUilz
 mSzba5U5+zDi8x1dEy0aco1hRYPfk5fLlcn6VxxGqKmqd2azc2Rhe78HZMx8RNzsLK
 bgcTJSivjRf6oF6q3SRzBBal+cVKxhbt9D514usNxNeVyV0FfY+3QUkwSo8y3L1qkv
 1vhazS5U6PCgTmm5tuBsjrur5eU4ZtVmP28eEKorVFGt/X+TIWkSPs41TYqnneX5xh
 5kckuqoiqBb7V9E931MZMl+n0QnX4MRDQsmf0qRbn8PJHE8rr+W6fr5rUOTBOnvvFE
 5Zb3CkcA30faA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/imagination: Fix page count for page table
 for map() interface
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922-mmu_fix-v4-2-12f1a871456a@imgtec.com>
References: <20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com>
 <20260922-mmu_fix-v4-2-12f1a871456a@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:41:15 +0000
Message-Id: <20260922044116.3F6AD1F000FF@smtp.kernel.org>
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
- [High] drm/imagination: under-allocation of page tables due to incorrect =
start_addr computation
--

commit 2406b8d6a0a1f7f5c8f27c8165d80a69f8753892
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix page count for page table for map() interface

This patch updates pvr_mmu_op_context_create() to accept a device address
and includes it in the page table count calculations for the map()
interface. This aims to fix mapping failures that occurred when the virtual
start address was omitted.

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
Since device_addr is the virtual address where the mapping starts, and
sgt_offset is the physical offset within the backing buffer object, does
adding the physical offset to the virtual address incorrectly shift the
preallocation start address here?

>  	int err;
> =20
>  	struct pvr_mmu_op_context *op_ctx =3D kzalloc_obj(*op_ctx);
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

[Severity: High]
By using this shifted start_addr, could we under-allocate page tables if the
actual virtual mapping from device_addr to device_addr + size crosses a page
table boundary (like a 2MB L0 block), but the incorrectly shifted start_addr
range does not?

If we preallocate fewer tables than needed, pvr_page_table_l0_get_or_insert=
()
might fail to pop from the empty preallocation list during pvr_mmu_map() and
return -ENOMEM, causing valid user mapping requests to unpredictably fail.

>  		const u32 l0_count =3D l0_end_idx - l0_start_idx + 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-mmu_fix-v4=
-0-12f1a871456a@imgtec.com?part=3D2
