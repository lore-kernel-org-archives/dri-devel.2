Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82219C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 05:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DE510E763;
	Fri, 17 Jul 2026 05:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="igKK97G+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C1910E763
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 05:43:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F31B460204;
 Fri, 17 Jul 2026 05:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6542F1F00A3A;
 Fri, 17 Jul 2026 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784267010;
 bh=myHJWGInQlIPF58WHXut/jsPSkJDly3gzsw5316HRm4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=igKK97G+HOtYoXsI+5eShYhP9fODMZQrlJCXrv2q/85Ci57nRTrMENs4x4lXcN5Oa
 gFtHQDrB4IMc/krXZSGOQ6EAEgOcOJcf11COLcW7+thv3mOXmf8zxK2TWqqBCD2lVk
 Z51fIy/ZJam4AJGkb/A6Xap+PM4yZFY/u20POviSCe1ik2Qrf/4ptyBKJFP1Xtq30X
 IjSB3jFIaSPDMIbEJlW5ppdTB89e44HbvY8k6Fa0SbYbF5bXPY5VREMaAkHpMrX931
 mNcDSTm4B7jI+WWV5o3t3fS5Kh/asCGDSjakolwW2KXhnI5q2Z/LQgvc5i8r4saDQs
 FKnRBvNfacUHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] lib: test bitmap vs IDA vs Maple Tree performance
 for region allocations
To: "Yury Norov" <ynorov@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260717053241.916441-1-ynorov@nvidia.com>
References: <20260717053241.916441-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:43:29 +0000
Message-Id: <20260717054330.6542F1F00A3A@smtp.kernel.org>
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
- [Medium] Silent integer truncation for capacities > UINT_MAX leads to cor=
rupted benchmark state and false positive warnings.
- [Medium] Unhandled -ENOMEM from internal allocations triggers false posit=
ive WARN_ON.
--

--- Patch [1]: [PATCH v3] lib: test bitmap vs IDA vs Maple Tree performance=
 for region allocations ---
commit d6b29e543ce674f28d588ee458044d2815d73caa
Author: Yury Norov <ynorov@nvidia.com>

lib: test bitmap vs IDA vs Maple Tree performance for region allocations
   =20
Compare the cost of allocating and freeing variable-sized regions using
a bitmap, IDA and a Maple Tree. All implementations process the same
randomly generated sequence of regions containing up to 32 entries, until
the configured capacity is exhausted.
   =20
Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvi=
dia.com/

> diff --git a/lib/region_alloc_benchmark.c b/lib/region_alloc_benchmark.c
> index 0000000000000..e88b4cf55c629
> --- /dev/null
> +++ b/lib/region_alloc_benchmark.c

[ ... ]

> +static unsigned long capacities[64] =3D { 1000000, 100000, 10000, 1000, =
100, 10 };
> +static unsigned int cap_cnt =3D 6;
> +
> +module_param_array(capacities, ulong, &cap_cnt, 0400);
> +MODULE_PARM_DESC(capacities, "Region capacities to benchmark");
> +
> +static unsigned long __init benchmark_bitmap(unsigned long cap)
> +{

[ ... ]

> +	alloc_time =3D ktime_get();
> +	for (cnt =3D 0; cnt <=3D cap; cnt++) {
> +		idx =3D bitmap_find_next_zero_area(bitmap, cap, 0, reg_sz[cnt], 0);
> +		if (idx >=3D cap)
> +			break;
> +
> +		reg_idx[cnt] =3D idx;
> +		bitmap_set(bitmap, idx, reg_sz[cnt]);

[Severity: Medium]
Since the capacities array is populated from a module parameter using ulong,
but bitmap_set() expects an unsigned int for the start index, could passing
a capacity larger than UINT_MAX cause the start index to silently truncate
to 32 bits here?

[ ... ]

> +static unsigned long __init benchmark_ida(unsigned long cap)
> +{

[ ... ]

> +	alloc_time =3D ktime_get();
> +	for (cnt =3D 0; cnt <=3D cap; cnt++) {
> +		for (off =3D 0; off < reg_sz[cnt]; off++) {
> +			id =3D ida_alloc_max(&ida, cap - 1, GFP_KERNEL);

[Severity: Medium]
Similarly, ida_alloc_max() takes an unsigned int max parameter. Does this
code truncate the 64-bit capacity bounds when cap exceeds UINT_MAX?

> +			if (id < 0)
> +				break;
> +
> +			if (!off)
> +				reg_idx[cnt] =3D id;
> +		}
> +		if (id < 0) {
> +			while (off--)
> +				ida_free(&ida, reg_idx[cnt] + off);
> +			break;
> +		}
> +		WARN_ON(id !=3D reg_idx[cnt] + reg_sz[cnt] - 1);
> +		nr_ids +=3D reg_sz[cnt];
> +	}
> +	alloc_time =3D ktime_get() - alloc_time;
> +
> +	WARN_ON(id !=3D -ENOSPC);

[Severity: Medium]
If the system is under memory pressure, ida_alloc_max() can return -ENOMEM
since it allocates with GFP_KERNEL. Will this trigger a false positive
warning if internal allocations fail before reaching the capacity limit?

[ ... ]

> +static unsigned long __init benchmark_maple_tree(unsigned long cap)
> +{

[ ... ]

> +	alloc_time =3D ktime_get() - alloc_time;
> +
> +	WARN_ON(ret !=3D -EBUSY);

[Severity: Medium]
Like the IDA implementation, mtree_alloc_range() can fail with -ENOMEM.
Can this code trigger a system warning if memory is exhausted early?

[ ... ]

> +static int __init region_alloc_benchmark(void)
> +{

[ ... ]

> +		bitmap_count =3D benchmark_bitmap(capacities[i]);
> +		maple_count  =3D benchmark_maple_tree(capacities[i]);
> +		ida_count    =3D benchmark_ida(capacities[i]);
> +
> +		WARN_ON(bitmap_count !=3D ida_count);
> +		WARN_ON(bitmap_count !=3D maple_count);

[Severity: Medium]
If one of the allocators fails early due to -ENOMEM while the others
succeed, could that cause their region counts to diverge and trigger
these assertions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717053241.9164=
41-1-ynorov@nvidia.com?part=3D1
