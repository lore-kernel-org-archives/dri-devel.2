Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921A0CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E510510E4DE;
	Wed, 14 Oct 2026 08:32:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38E910E4DE
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:32:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 68C0940B46;
 Wed, 14 Oct 2026 08:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DEA1F000FF;
 Wed, 14 Oct 2026 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791966737;
 bh=6aSh+YmVh2sQqEiS+voknLyPsgz9cCNnI84fYIIjbb4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HKM9NiKRyLz/9hsOvQEqtgQZ4YlkDCWgR++/p8sr6Njo5ylKDyYFYVVZoWYsjZ6Wz
 GBF5NdBvXuaNfeKZbs3AUtnRcPAXoEJoCS1AfZjEpx+vTs8swJmO4SNieCvZtA/fKX
 DC/o9G6y0JAvkmZyov5NQfvo6wQ5yOPnFEBVNPsa3PpnMiiWwlmvfHwG6gxjl+SF+j
 MdoV51blVygK9kk9MvuOHvpaABfWiGYDMxPUK5DHRPjsmF7IGD2oY1J5DGrtL2oKdw
 2MED81xU+ZewRKT4XflS7/jOcn/74eyPAq5tI5rCAtfZxeKzmohP/6tEZUDwnWRO5e
 KXQ+SbfhAquCA==
Message-ID: <sashiko-outbox-171014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/imagination: Limit access to the MIPS firmware
 interface
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-b4-simplify-mips-pte-defs-v1-1-b4ad7bb68e22@imgtec.com>
References: <20261014-b4-simplify-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com>
 <20261014-b4-simplify-mips-pte-defs-v1-1-b4ad7bb68e22@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:32:16 +0000
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
- [High] drm/imagination: kernel panic in pvr_vm_mips_map() on 64KB-page sy=
stems due to 0-page vmap
--

commit f751c0095eefbac6525746590080b3626f16f23d
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Limit access to the MIPS firmware interface

This commit restricts access to the MIPS firmware interface by using the
generic firmware interface or the MIPS-specific VM interface. It splits the
pvr_fw_mips_data struct into internal structures and removes the public
MIPS firmware interface header.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/=
imagination/pvr_vm_mips.c
> index 5847a1c92bea8..264ea0fccf9c1 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
> @@ -43,49 +69,49 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)

[ ... ]

> -	mips_data->pt =3D vmap(mips_data->pt_pages, pt_size >> PAGE_SHIFT, VM_M=
AP,
> -			     pgprot_writecombine(PAGE_KERNEL));
> -	if (!mips_data->pt) {
> +	vm_data->pt =3D vmap(vm_data->pt_pages, pt_size >> PAGE_SHIFT, VM_MAP,
> +			   pgprot_writecombine(PAGE_KERNEL));
> +	if (!vm_data->pt) {

[Severity: High]
Does this code handle architectures with 64KB pages correctly?

During DRM driver initialization, pvr_vm_mips_init() allocates firmware
page tables. The page table size pt_size evaluates to 16384 bytes (16KB).
When vmap() is called here, pt_size >> PAGE_SHIFT evaluates to 0 on
architectures with 64KB pages (PAGE_SHIFT=3D16). Passing a 0 page count to
vmap() returns a non-NULL pointer to an unmapped guard page area.

> @@ -190,10 +216,10 @@ pvr_vm_mips_map(struct pvr_device *pvr_dev, struct =
pvr_fw_object *fw_obj)
>  			goto err_unmap_pages;
> =20
>  		pte =3D ((dma_addr >> ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K)
> -		       << ROGUE_MIPSFW_ENTRYLO_PFN_SHIFT) & mips_data->pfn_mask;
> +		       << ROGUE_MIPSFW_ENTRYLO_PFN_SHIFT) & vm_data->pfn_mask;
>  		pte |=3D pte_flags;
> =20
> -		WRITE_ONCE(mips_data->pt[pfn], pte);
> +		WRITE_ONCE(vm_data->pt[pfn], pte);

[Severity: High]
Can this write trigger a kernel panic on 64KB-page systems?

If vm_data->pt points to an unmapped guard page returned by vmap() due to
the 0 page count, writing to vm_data->pt[pfn] here will dereference that
unmapped address and cause a page fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-simplif=
y-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com?part=3D1
