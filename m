Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C1AC44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 01:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01AE10E288;
	Sat, 11 Jul 2026 01:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DCxnb8c0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B66710E288
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 01:48:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F1F1416E5;
 Sat, 11 Jul 2026 01:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6EF1F000E9;
 Sat, 11 Jul 2026 01:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783734511;
 bh=zaeAvDlHuOgr1xacoL1QtMGVgRHfk8h/damG4GnbUN0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DCxnb8c0FCzLa3pgo34SGywdUSdkyFw58PDHots55Y9Z7OVOwT4Ic/9GenVRq4e4n
 R60k1n/zlrL+wEKWKU+rXEDJtWZEhUtaSbed+pFv8UYKEr7/lWCIzHgz43poRZ4S5N
 IveVFTOnItSxYgyfkM2nmVQ7Vv3sJfE7vHvyjsu84Hwk4rGsSnqlnrihs5YHsmaTUQ
 Cd6phoTWB7LziHRsydvYtV9ET9xzx25ISvnrcrUPFDpIdPjXDvRH6bBZFLUFsWBnv9
 ASM7uyb6oKZkRG0iwo7sUvUKUWv/r6mZMGgV2FAjZotj8erFsjW5mKSvD7KTVQ7PIh
 g+rHBm5e/0wTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] lib: test bitmap vs Maple Tree performance for region
 allocations
To: "Yury Norov" <ynorov@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260711013910.349586-1-ynorov@nvidia.com>
References: <20260711013910.349586-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 01:48:29 +0000
Message-Id: <20260711014830.6E6EF1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Large uninitialized static arrays marked with `__initdata` bloat=
 the kernel binary by ~9.1MB.
- [Medium] Transient memory allocation failures trigger false positive `WAR=
N_ON` bug reports.
- [Medium] Initializing a maple tree on the stack with `MTREE_INIT` causes =
a lockdep splat.
--

--- Patch [1]: [PATCH] lib: test bitmap vs Maple Tree performance for regio=
n allocations ---
commit b546f14f1527daeb17ae5d45e14a867ddc37369e
Author: Yury Norov <ynorov@nvidia.com>

lib: test bitmap vs Maple Tree performance for region allocations

This commit adds a microbenchmark to compare the performance of allocating
and freeing variable-sized regions. It tests a bitmap implementation against
a Maple Tree implementation across several capacities when the module loads.

Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvi=
dia.com/
Link: https://lore.kernel.org/all/tencent_FBA5367F4AA8C57DE2198975767E416FC=
90A@qq.com/

> diff --git a/lib/region_alloc_benchmark.c b/lib/region_alloc_benchmark.c
> new file mode 100644
> index 0000000000000..7459e37608bca
> --- /dev/null
> +++ b/lib/region_alloc_benchmark.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Benchmark bitmap and Maple Tree allocation of variable-sized regions.=
 */
> +
> +#include <linux/bitmap.h>
> +#include <linux/kernel.h>
> +#include <linux/maple_tree.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/random.h>
> +#include <linux/xarray.h>
> +
> +#define MAP_SIZE	(1000000UL)
> +#define REGION_MAX_SIZE	32
> +
> +static DECLARE_BITMAP(alloc_bitmap, MAP_SIZE) __initdata;
> +/* One more request guarantees that even an all-ones trace reaches ENOSP=
C. */
> +static u8 region_sizes[MAP_SIZE + 1] __initdata;
> +static unsigned long region_indexes[MAP_SIZE] __initdata;

[Severity: Medium]
Does using the __initdata macro on these large uninitialized arrays push
them into the PROGBITS .init.data section instead of .bss?

This can bloat the vmlinux image by around 9.1MB at build time, which
might cause boot or build failures on memory-constrained embedded
architectures with strict size limits.

[ ... ]

> +static unsigned long __init benchmark_maple_tree(unsigned long capacity)
> +{
> +	struct maple_tree mt =3D MTREE_INIT(mt, MT_FLAGS_ALLOC_RANGE);

[Severity: Medium]
Is it safe to initialize this maple tree on the stack using MTREE_INIT?

The MTREE_INIT macro uses __SPIN_LOCK_UNLOCKED, which relies on a C99
compound literal for the lockdep lock class key. At block scope, C99
compound literals have automatic storage duration. This places the lockdep
key on the stack and triggers a lockdep warning about registering a
non-static key.

Should dynamic initialization with mt_init_flags() be used here instead?

> +	unsigned long count, index;
> +	ktime_t alloc_time, free_time;
> +	size_t memory;
> +	int ret;
> +
> +	alloc_time =3D ktime_get();
> +	for (count =3D 0; count < ARRAY_SIZE(region_sizes); count++) {
> +		ret =3D mtree_alloc_range(&mt, &index, xa_mk_value(count + 1),
> +					region_sizes[count], 0, capacity - 1,
> +					GFP_KERNEL);
> +		if (ret)
> +			break;
> +
> +		region_indexes[count] =3D index;
> +	}
> +	alloc_time =3D ktime_get() - alloc_time;
> +	WARN_ON(ret !=3D -EBUSY);

[Severity: Medium]
Could mtree_alloc_range() legitimately fail with -ENOMEM?

Since it uses GFP_KERNEL to allocate tree nodes internally, transient
memory pressure could cause an allocation failure. If that happens, this
WARN_ON will trigger a false positive bug report.

[ ... ]

> +static int __init region_alloc_benchmark(void)
> +{
> +	static const unsigned long capacities[] =3D { 1000000, 100000, 10000, 1=
000 };
> +	unsigned long bitmap_count, maple_count;
> +	unsigned long i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(region_sizes); i++)
> +		region_sizes[i] =3D get_random_u32_below(REGION_MAX_SIZE) + 1;
> +
> +	pr_err("\nStart testing bitmap vs Maple Tree region allocation\n");
> +	pr_err("%-6s   %12s   %12s   %8s   %10s\n", "type", "alloc (ns)", "free=
 (ns)",
> +		"capacity", "memory (B)");
> +	for (i =3D 0; i < ARRAY_SIZE(capacities); i++) {
> +		bitmap_count =3D benchmark_bitmap(capacities[i]);
> +		maple_count =3D benchmark_maple_tree(capacities[i]);
> +		WARN_ON(bitmap_count !=3D maple_count);

[Severity: Medium]
If benchmark_maple_tree() experiences an early -ENOMEM failure, will it
return a different element count than benchmark_bitmap(), leading to a
secondary false positive warning here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711013910.3495=
86-1-ynorov@nvidia.com?part=3D1
