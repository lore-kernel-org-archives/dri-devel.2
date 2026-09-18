Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19D9C982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABB110E8BA;
	Fri, 18 Sep 2026 11:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S+MEo7bZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C76F10E8BA
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:14:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8595E402FA;
 Fri, 18 Sep 2026 11:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2FD1F000FF;
 Fri, 18 Sep 2026 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730065;
 bh=jUqU0NiWKdtzGjAaxgXZCdDBLRMtY0+BF09DlWMh+38=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S+MEo7bZeOmoZcqQo2Q/YT8V6YVJ6cCxIOMB69xcRnBnHdOed2Cp4y0mAQ2HqKZrX
 1ZY4KTzD1JGNdFzp3SUiiQ+IcUMPNg6Sd2gcqTtfZaVO/0HKOkKppUoBhxb4U8v5dK
 qBNQP3e+DJrlxU9jEXrz8+ogeip4YsahYuM06VJ2/tsR5hUJ/EmoBWBLtE+dcLZrHP
 Uk91Q6RJoH67vXeO7BT0N/BWWdnH7u3eQLs6vswSKx17BIO6f/1HfncZ0vBLs3mseQ
 o75KCq/6L7CtMFtgx/GJDeYlPV6BdBS70c0lJOjYxcaQF8aLKe1QttOgaoM8ghX3cH
 BiSv8aLT1p9tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/imagination: Fix page count for page table
 for map() interface
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918-mmu_fix-v3-2-7b3d73aef041@imgtec.com>
References: <20260918-mmu_fix-v3-0-7b3d73aef041@imgtec.com>
 <20260918-mmu_fix-v3-2-7b3d73aef041@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 11:14:24 +0000
Message-Id: <20260918111425.3F2FD1F000FF@smtp.kernel.org>
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
- [High] drm/imagination: map failure due to incorrect page table prealloca=
tion
--

commit 745ba10b948681b4d3d12138bed64dc2fbad043c
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix page count for page table for map() interface

This commit aims to fix the page count calculation for mapping a buffer obj=
ect
by including the GPU virtual start address. It updates the
pvr_mmu_op_context_create function to accept the device address and uses it
to compute the required page table memory.

> diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imag=
ination/pvr_mmu.c
> index 23261d9ad3fdd..62eae7fcd5a26 100644
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
Does this computation incorrectly add the physical buffer offset (sgt_offse=
t)
to the virtual device address (device_addr)?

It appears that shifting the address window this way can lead to
under-allocation of page tables. For instance, if a user-space application
maps a memory region where the true virtual address range from device_addr
to device_addr + size crosses more page directory boundaries than the
shifted range (start_addr to start_addr + size), the preallocation will
fall short.

As an example, if L0 tables cover 2MB (0x200000), and we have
device_addr =3D 0x1FF000, size =3D 0x2000, and sgt_offset =3D 0x1000: the a=
ctual
mapping touches both 0x1FF000 and 0x200000, requiring two L0 tables. Howeve=
r,
start_addr becomes 0x200000, causing the logic to preallocate only one
L0 table. Later, when pvr_mmu_map executes, it could fail to retrieve the
second table from the preallocated list and return -ENOMEM.

Could this result in unprivileged user-space clients experiencing random map
failures depending on the buffer offset?

>  	int err;
> =20
>  	struct pvr_mmu_op_context *op_ctx =3D kzalloc_obj(*op_ctx);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-mmu_fix-v3=
-0-7b3d73aef041@imgtec.com?part=3D2
