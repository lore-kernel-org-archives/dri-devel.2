Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A701FC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9A210ECEA;
	Tue,  7 Jul 2026 13:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kjj+907K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631E310ECEA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:15:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5CA1E40856;
 Tue,  7 Jul 2026 13:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E84C1F000E9;
 Tue,  7 Jul 2026 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430139;
 bh=bYW7jm8kKmk4FfdiHKU0v/JQ8dCDKYPs2iSP7L/iiLI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kjj+907KwtzkZeflgANbFjgXaX3MfA+WrP0YiPKF2IMBXytpT7WY2+Ptz3hjlwLHe
 LVuNrEXOBNz3JLU8ufZu1NXx0Ci8K8xXkXSzyzCtvFVEuukNrCznkx6MlF1oOFvkm1
 ILfhNSqg6ATU8ytQ4yo8XscihyoqJxR9cdzHscFbVot8LDSrOIzOQAeaeQHqLBnl46
 VmqIv+iUAZpugg31h4d2l9h4y98KD6hMSBaEAHKxRz+5O23dvy4WX2fw+ZA/UaTqo/
 K+dDhmXwj4EXKlUOgTZ/RD5SdXuWMb0EqYjkGiQgzqR1j9fJcsD4slMyn+XkvlKEFn
 SEB5lJ86DSHnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V11 07/11] gpu/buddy: Add routine to dump allocated
 buddy blocks
To: "Tejas Upadhyay" <tejas.upadhyay@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707130617.970638-20-tejas.upadhyay@intel.com>
References: <20260707130617.970638-13-tejas.upadhyay@intel.com>
 <20260707130617.970638-20-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:15:38 +0000
Message-Id: <20260707131539.1E84C1F000E9@smtp.kernel.org>
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
- [High] Iterating the entire buddy allocator tree to dump allocated blocks=
 via `pr_info` while holding the driver lock can cause severe CPU stalls an=
d system lockups.
- [Medium] The patch includes an unused DRM header (`<drm/drm_print.h>`), f=
ails to use `drm_printer`, and has a mismatch between the expected output i=
n the commit message and the actual implementation.
--

--- Patch [7]: [PATCH V11 07/11] gpu/buddy: Add routine to dump allocated b=
uddy blocks ---
commit dd1833d79b732eba09f7b2487608ee8cabc53593
Author: Tejas Upadhyay <tejas.upadhyay@intel.com>

gpu/buddy: Add routine to dump allocated buddy blocks

To implement the ability to see allocated blocks under a specific VRAM
instance in the drm driver, new api is introduced. While existing structs
often show the free block list, this addition provides a comprehensive view
of all currently resident VRAM allocations.

> Dump will look like,
>=20
> [  +0.000003] xe 0000:03:00.0: [drm] 0x00000002f8000000-0x00000002f880000=
0: 8388608
> [  +0.000005] xe 0000:03:00.0: [drm] 0x00000002f8800000-0x00000002f884000=
0: 262144

[Severity: Medium]
Is this expected output accurate for this patch?

The commit message implies the use of a DRM-specific printing interface like
drm_printf to provide the "xe ... [drm]" prefix.=20

However, gpu_buddy_dump_allocated_blocks() does not accept a drm_printer
argument and relies on gpu_buddy_block_print() which unconditionally uses
pr_info() instead.

[ ... ]

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 4d5ac375a538c..e11e9cfb8807e 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -10,6 +10,7 @@
>  #include <linux/sizes.h>
> =20
>  #include <linux/gpu_buddy.h>
> +#include <drm/drm_print.h>

[Severity: Medium]
Is this include necessary?

Since this code relies on pr_info() and doesn't take a drm_printer context,
it looks like this include is unused and adds a DRM dependency to the gener=
ic
allocator.

[ ... ]

> +void gpu_buddy_dump_allocated_blocks(struct gpu_buddy *mm)
> +{
> +	struct gpu_buddy_block *block;
> +	LIST_HEAD(dfs);
> +	int i;
> +
> +	gpu_buddy_driver_lock_held(mm);
> +
> +	for (i =3D 0; i < mm->n_roots; ++i)
> +		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
> +
> +	do {
> +		block =3D list_first_entry_or_null(&dfs,
> +						 struct gpu_buddy_block,
> +						 tmp_link);
> +		if (!block)
> +			break;
> +
> +		list_del(&block->tmp_link);
> +
> +		if (gpu_buddy_block_is_allocated(block))
> +			gpu_buddy_block_print(mm, block);

[Severity: High]
Could this cause a regression with CPU stalls or trigger watchdogs on highly
fragmented systems?

When called, this loop iterates over the entire allocator tree while holding
the driver lock. In a modern GPU with multi-gigabyte VRAM, this tree can
contain a massive number of blocks.

gpu_buddy_block_print() unconditionally calls pr_info() for every block:

drivers/gpu/buddy.c:gpu_buddy_block_print() {
    ...
    pr_info("%#018llx-%#018llx: %llu\n", start, start + size, size);
}

Would outputting thousands or millions of lines to the kernel ring buffer a=
nd
serial console synchronously under a global lock block other operations for=
 an
extended period?

> +
> +		if (gpu_buddy_block_is_split(block)) {
> +			list_add(&block->right->tmp_link, &dfs);
> +			list_add(&block->left->tmp_link, &dfs);
> +		}
> +	} while (1);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707130617.9706=
38-13-tejas.upadhyay@intel.com?part=3D7
