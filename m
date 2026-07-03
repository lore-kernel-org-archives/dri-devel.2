Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2A7C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF6610E60A;
	Fri,  3 Jul 2026 13:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I7nP8U2T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68BF10F7EA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 13:20:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9300143CB8;
 Fri,  3 Jul 2026 13:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2993D1F000E9;
 Fri,  3 Jul 2026 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783084800;
 bh=MR1Uz1ZPumsuINWIvyfMm3M0/goV0Y4Ipet3yXA9Fxw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I7nP8U2TgTKJdPCc0sRwlPkXOesRjsPc1e/W+bTazi89RvbsNDLI717CzteC9S5QW
 2I6YSt5yRX4zl8lfb8Wb5AFaqjg42fAA8EYpxtKLw5oi9SelwUWYPye4Hqh5QBOQ2N
 E3lXKd2/IJnad9Cd6IRa/a9sQw38gWQlhLilIwi3WxE9d4YhC1oGQn8EdwrvaKr9OJ
 Ix9z1sIHGHohVm3ni2dnVP+QssMrtV2wnkpBMxwKJM6oOebEdOxj6LG7c+Wgia0ixj
 1sv/oBwd3XZVpFo3dELaycZonrR3zJ3BN1N26wyH7XU49DuJBdODQhwEP7yIFiMUEK
 /LZs1R+sXrfHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] drm/ttm: Hook up a cgroup-aware reclaim callback
 for the dmem controller
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, hannes@cmpxchg.org, mkoutny@suse.com,
 tj@kernel.org
In-Reply-To: <20260703130541.2686-5-thomas.hellstrom@linux.intel.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-5-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 13:19:59 +0000
Message-Id: <20260703132000.2993D1F000E9@smtp.kernel.org>
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
- [High] `ttm_resource_manager_set_dmem_region()` fails to clear the cgroup=
 region pointer when passed `NULL`, leaving a dangling pointer that can cau=
se a use-after-free.
--

commit 02822c8c1770f6a971fca6d0ddb57472d4eea596
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem controller

This commit introduces functionality to evict buffer objects charged to a
specific dmem cgroup pool from a resource manager's LRU. It adds
ttm_resource_manager_set_dmem_region() to associate a dmem cgroup region
with a resource manager, and provides a reclaim callback that drivers can
wire up to TTM eviction.

> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm=
_resource.c
> index 154d6739256f8..ad00723e99ef1 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c

[ ... ]

> +void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *m=
an,
> +					  struct dmem_cgroup_region *region)
> +{
> +	if (!IS_ERR_OR_NULL(region))
> +		man->cg =3D region;
> +}
> +EXPORT_SYMBOL(ttm_resource_manager_set_dmem_region);

[Severity: High]
The v5 changelog mentions handling a NULL region here to clear the reclaim
callback and prevent use-after-free bugs. However, if region is NULL,
!IS_ERR_OR_NULL(region) evaluates to false.=20

Does this skip the assignment and fail to clear man->cg, leaving a dangling
pointer if a driver tries to detach the region before teardown?

Should this code check !IS_ERR(region) instead, or unconditionally assign
man->cg =3D NULL when the passed region is NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703130541.2686=
-1-thomas.hellstrom@linux.intel.com?part=3D4
