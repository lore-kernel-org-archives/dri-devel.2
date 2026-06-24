Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCC1CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 03:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B400E10E025;
	Wed, 24 Jun 2026 03:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G42b6V3M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6143D10E025
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 03:27:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 082F041A50;
 Wed, 24 Jun 2026 03:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63391F000E9;
 Wed, 24 Jun 2026 03:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782271619;
 bh=0qW8cjE+jdxzwm1Exj3TrJ9on/5HEPiKKfQKexTZocM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G42b6V3MfIpoMzYkzLtiUSd38ZxgxzahNNEaVRkisYxD7gqIhg0kqMIsr5Auxckd0
 DTTlQqdE4Qrdn1MtC+dFjcq4zSdzGntibvIrnBe4OnbIvLOwbvB2JvvG/j4rC3516o
 JqSFIeHYTN6XvoR+7Jzc1sP8BL3kPOq3yVCR0ZNXdAdmbAzHLd+6HFQLyuMTFBWl8s
 lW7g5GMThS+ZNL7KsGxK8bwPey5yD6dTRSkX5Q46Ek7z2OWBRgKjZfYmbhEB0WufUh
 PuQvOphdrqrDjdy4RGf5q63seLWaL8WdVZshd1ZEyBD+XhPbz7V3AARBcvB7v6Ipw5
 PmtTOJkTr6AOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
To: "Hongfu Li" <lihongfu@kylinos.cn>
Cc: tj@kernel.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260624031107.667253-2-lihongfu@kylinos.cn>
References: <20260624031107.667253-1-lihongfu@kylinos.cn>
 <20260624031107.667253-2-lihongfu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 03:26:59 +0000
Message-Id: <20260624032659.A63391F000E9@smtp.kernel.org>
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
- [Medium] DMEMCG_LOW event counter is heavily inflated by incrementing per=
-skipped-object during LRU walks instead of per reclaim fallback.
--

commit 36a407edf0ff46972d31f3cdddb8b463ec3f07d8
Author: Hongfu Li <lihongfu@kylinos.cn>
cgroup/dmem: add per-region event counters

This patch adds the dmem.events interface to report hierarchical low and max
event counts per DMEM region. It introduces counters that increment on
dmem.max allocation failures and dmem.low protection events.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 4753a67d0f0f2..79d4c5d0a0469 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c

[ ... ]

> @@ -345,6 +374,7 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgr=
oup_pool_state *limit_pool,
>  			return true;
> =20
>  		*ret_hit_low =3D true;
> +		dmemcg_memory_event(test_pool, DMEMCG_LOW);

[Severity: Medium]
Does incrementing the event here inflate the DMEMCG_LOW counter by counting
every single skipped object during an LRU walk?

Because dmem_cgroup_state_evict_valuable() is typically called in a loop for
each object during eviction (for example, in ttm_bo_evict_cb), this will hit
for every protected object rather than once per reclaim fallback.

Could this also introduce a performance overhead, as the atomic increments
and hierarchical cgroup_file_notify() calls are now happening inside the
tight eviction loop?

>  		return false;
>  	}
>  	return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624031107.6672=
53-1-lihongfu@kylinos.cn?part=3D1
