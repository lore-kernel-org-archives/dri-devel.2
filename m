Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACEBCD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B27C10F05F;
	Thu, 11 Jun 2026 18:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G9fbIALG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4093910F05B
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:01:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A59F434AE;
 Thu, 11 Jun 2026 18:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01451F00899;
 Thu, 11 Jun 2026 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781200868;
 bh=oSdVfhRIxYVSIvZRCsc9ClAjraWTFuEromwYbZiyG4U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G9fbIALGZs0CivdQrlTBKGC1FnkLNIoCY/1Tux7mh5XnHJxE0TN3G0TEYHUr30Qx2
 iR387NFLqXGtzSHsPvoDHMmYzlI5gKY5EHMQZprwMWhON6Y38zAQMC1ItoZBvJq9gJ
 Bga/SfglH+M9wo6FwZ4bkMOQqAZAfIytUljctMklBaryIfN38j6BQoQ3hvvafktUwN
 +5De+TYlMGRvZYDdue8sMm9sDXhmwtKguOMVc0RbrC2fw0X78GkW+9FDkXWM7aJEuA
 fANsUhXAArD8bElDM1iJkA+VXcANSg3ExzXcHzBclBpdWdFIXZz4PGSBpBt9ZoZc34
 z2du8VAt8Hnsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] cgroup/dmem: Add reclaim callback for lowering
 max below current usage
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
In-Reply-To: <20260611173301.17473-4-thomas.hellstrom@linux.intel.com>
References: <20260611173301.17473-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:01:07 +0000
Message-Id: <20260611180107.C01451F00899@smtp.kernel.org>
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

Pre-existing issues:
- [High] dmemcg_parse_limit does not clamp parsed limits to PAGE_COUNTER_MA=
X, leading to silent truncation and broken limits on 32-bit systems.
--

commit 71a34045a2531fca277baab558f3a81add06614b
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

cgroup/dmem: Add reclaim callback for lowering max below current usage

This patch adds an optional reclaim callback to dmem_cgroup_region to
allow memory eviction when dmem.max is lowered below current usage. It
handles reclaim in a bounded loop and respects O_NONBLOCK to avoid
charging reclaim costs to writers.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 373ad04d289d5..f7166b8255c7b 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
[ ... ]
> @@ -145,21 +170,71 @@ static void free_cg_pool(struct dmem_cgroup_pool_st=
ate *pool)
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
This isn't a bug introduced by this patch, but does casting the u64 value
to unsigned long here cause issues on 32-bit systems?

It looks like dmemcg_parse_limit() parses user input into a u64 via
memparse() without clamping it to PAGE_COUNTER_MAX. The dmem controller uses
page_counter to track raw bytes rather than pages.

On 32-bit systems, page_counter tracks limits using unsigned long and usage
using atomic_long_t (signed), meaning it can safely track at most LONG_MAX
(2GB-1) bytes. If a user writes a limit larger than 4GB (e.g., 5GB), the
cast to unsigned long will silently truncate it to 1GB.

Additionally, if a value between 2GB and 4GB is written, does actual usage
exceeding 2GB cause atomic_long_sub_return() in page_counter_cancel() to
result in a negative value, triggering a WARN_ONCE and permanently
resetting the cgroup's usage to 0?

Would it be safer to clamp the parsed value to PAGE_COUNTER_MAX in
dmemcg_parse_limit() before it reaches this point?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611173301.1747=
3-1-thomas.hellstrom@linux.intel.com?part=3D3
