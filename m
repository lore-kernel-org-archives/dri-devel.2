Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68438CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1A710E7C6;
	Thu, 11 Jun 2026 14:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KOhLT4Fs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5F110E7C6
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 14:40:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4326040176;
 Thu, 11 Jun 2026 14:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF91F00893;
 Thu, 11 Jun 2026 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781188847;
 bh=5/UWbGdSCmGDdIhOfMc2IusuSl6d/rmknI7aPw7r7VY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KOhLT4Fsq66ZyA4UNo4cI/hogROru132nsN/7vsZp2tELhzdHKa6m10fqWOeEVDoi
 r2JdIyKzANeE+wL0hr+CLKIh7uRdH6A+Oa1pKcPz9LtED5APLXZA5NGswDtpreYcV9
 lI+WPkFmh+9O8hLOfcVSN7sRDBuBcVv6NAgcluepOj2n26bA/2esIzrSIXLI4Y2lb0
 WEyMrZI4yh2pFw2yDyGRl5a5ApIqo9GuKknkTwrJQROeBBFOpt3N+OxtCrgZfI2Ad8
 0BLRDTJW9Bx6ATzpFH5nYu1hRuV0gNPmeB70vBWpxLPk5aUzhWzFrA63RZrbqmfIwu
 Jkc3twWUEp1eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] cgroup/dmem: Add reclaim callback for lowering
 max below current usage
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: tj@kernel.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260611142242.2529-4-thomas.hellstrom@linux.intel.com>
References: <20260611142242.2529-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 14:40:46 +0000
Message-Id: <20260611144046.E1EF91F00893@smtp.kernel.org>
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
- [Medium] The docstring for `struct dmem_cgroup_ops->reclaim` explicitly c=
ontradicts the implementation for `-ENOSPC` return values.

Pre-existing issues:
- [High] On 32-bit systems, `dmemcg` limits tracked in bytes are truncated =
to 32-bit `unsigned long`, leading to overflows and artificially severe con=
straints.
--

commit ccfc580d266b8b80afec154f819853307351d98a
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

cgroup/dmem: Add reclaim callback for lowering max below current usage

Add an optional reclaim callback to struct dmem_cgroup_region. When
dmem.max is set below the current usage of a cgroup pool, the new limit
is applied immediately and then the driver is asked to evict memory.

> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
> index d9eab8a2c1ee6..d705e94d8784d 100644
> --- a/include/linux/cgroup_dmem.h
> +++ b/include/linux/cgroup_dmem.h
> @@ -14,12 +14,33 @@ struct dmem_cgroup_pool_state;
>  /* Opaque definition of a cgroup region, used internally */
>  struct dmem_cgroup_region;
> =20
> +/**
> + * struct dmem_cgroup_ops - Operations for a dmem cgroup region.
> + * @reclaim: Optional callback invoked when dmem.max is set below the cu=
rrent
> + *           usage of a pool. The driver should attempt to free at least
> + *           @target_bytes from @pool. May be called multiple times if u=
sage
> + *           remains above the limit after returning.
> + *
> + *           Return: 0 if some progress was made (even if less than
> + *           @target_bytes was freed), -ENOSPC if no progress could be m=
ade,
> + *           or another negative error code if a fatal error occurred.
> + *           Any non-zero return stops further reclaim attempts.

[Severity: Medium]
Is the documentation accurate regarding the -ENOSPC return code?

The docstring here explicitly states that any non-zero return stops further
reclaim attempts. However, the implementation in set_resource_max() appears
to intercept -ENOSPC and will retry up to 16 times:

    if (ret && (ret !=3D -ENOSPC || !retries--))
        break;

Could this mislead driver authors into assuming -ENOSPC is a terminal
return code that aborts the loop immediately, when it actually subjects
the driver to continuous retries?

> + */
> +struct dmem_cgroup_ops {
> +	int (*reclaim)(struct dmem_cgroup_pool_state *pool,
> +		       u64 target_bytes, void *priv);
> +};

[ ... ]

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 373ad04d289d5..f7166b8255c7b 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c

[ ... ]

>  static void
> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val, bool nonb=
lock)
>  {
> -	page_counter_set_max(&pool->cnt, val);
> +	struct dmem_cgroup_region *region =3D pool->region;
> +	unsigned long limit =3D (unsigned long)val;

[Severity: High]
This is a pre-existing issue, but does this truncation to unsigned long cau=
se
severe limitations on 32-bit systems?

The dmemcg subsystem accounts for memory limits in bytes, but integrates wi=
th
the page_counter infrastructure which tracks limits using unsigned long. The
64-bit byte limit is truncated here, wrapping values larger than 4GB on 32-=
bit
architectures.

Additionally, when setting the limit to 'max' via dmemcg_parse_limit() or
reset_all_resource_limits(), it translates to PAGE_COUNTER_MAX (which is
~524,287 on 32-bit). Because dmem_cgroup_try_charge() passes the allocation
size in bytes to page_counter_try_charge(), a limit of 'max' restricts usage
to ~512KB instead of being unlimited. Will this cause 32-bit workloads to O=
OM
on allocations larger than ~512KB?

> +
> +	/*
> +	 * Always update the limit, even if usage currently exceeds it.
> +	 * Concurrent allocations will be throttled against the new limit
> +	 * while reclaim is in progress.
> +	 */
> +	xchg(&pool->cnt.max, limit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611142242.2529=
-1-thomas.hellstrom@linux.intel.com?part=3D3
