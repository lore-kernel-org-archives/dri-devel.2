Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6870C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F47310E5F4;
	Fri,  3 Jul 2026 13:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ftPnbsNs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E10B10E5F4
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 13:24:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C2EC60051;
 Fri,  3 Jul 2026 13:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001CF1F000E9;
 Fri,  3 Jul 2026 13:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783085050;
 bh=R3DXnaePNVSBz144fjSsWIO8dTSZyP7lTjIFTkrpgYE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ftPnbsNsp6XxNvYyTnFFSf08XPj/DJCltwcFXo6fMupEdIsAbEgrV1qYRGN5ZT408
 qjRwegcUYx6TZgnLCUxNS6GtfxcgTjRU+1SrABM1fuVewcclSoi3R5Lb41Ev3WVz+L
 8nF1ltRKh3892R3KRy2WcZQY8wvyskWxD2nvJJZZ8EP1i/C9fH2PuRxE0m4rSL77MZ
 Zlcc12rW4BPTQn7F9LyKQ4U1owBNhTZkyEG2saoe0Uw6P0WjzDZM/5RTk4EsHaNoY2
 sq8kpg0JEN2xtwCfODf3dAtWHW/S+QhTF3sfgeNjRQHyV88EpBkmpmAC2/PvtSLvdj
 sjSlc4okTKSww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] cgroup/dmem: Add reclaim callback for lowering
 max below current usage
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: tj@kernel.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260703130541.2686-4-thomas.hellstrom@linux.intel.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 13:24:09 +0000
Message-Id: <20260703132410.001CF1F000E9@smtp.kernel.org>
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
- [High] Holding `srcu_read_lock` across a potentially unbounded reclaim lo=
op causes `synchronize_srcu()` to hang indefinitely during region unregistr=
ation.
--

commit a6f9976e310be028f3b0c1a4f382c0d26ce5f305
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Subject: cgroup/dmem: Add reclaim callback for lowering max below current u=
sage

This commit adds an optional reclaim callback to struct dmem_cgroup_region=
=20
that is invoked when dmem.max is lowered. It introduces an SRCU domain to
protect reclaim callbacks against concurrent region unregistrations.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 373ad04d289d5..93bc9813903c8 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c

[ ... ]

> @@ -145,21 +161,52 @@ static void free_cg_pool(struct dmem_cgroup_pool_st=
ate *pool)
>  }
> =20
>  static void
> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val, bool nonb=
lock)
>  {
> -	page_counter_set_max(&pool->cnt, val);
> +	struct dmem_cgroup_region *region =3D pool->region;
> +	unsigned long limit =3D (unsigned long)val;
> +
> +	/* Apply the new limit immediately so concurrent allocations are thrott=
led. */
> +	xchg(&pool->cnt.max, limit);
> +
> +	if (nonblock)
> +		return;
> +
> +	int srcu_idx =3D srcu_read_lock(&dmemcg_srcu);
> +
> +	if (!READ_ONCE(region->unregistered) && region->ops && region->ops->rec=
laim) {
> +		for (int retries =3D DMEM_MAX_RECLAIM_RETRIES; ; ) {
> +			u64 usage =3D page_counter_read(&pool->cnt);
> +			int ret;
> +
> +			if (usage <=3D limit)
> +				break;
> +
> +			if (signal_pending(current))
> +				break;
> +
> +			ret =3D region->ops->reclaim(pool, usage - limit, region->reclaim_pri=
v);
> +
> +			/* -ENOSPC means no progress; other errors are fatal. */
> +			if (ret && (ret !=3D -ENOSPC || !retries--))
> +				break;
> +
> +			cond_resched();
> +		}

[Severity: High]
Can this loop cause synchronize_srcu() in dmem_cgroup_unregister_region() to
hang indefinitely?

If the driver's reclaim() callback repeatedly returns 0 (indicating some
progress) but concurrent allocations keep usage above the limit, this loop
could run for a very long time.

Because srcu_read_lock() is held outside the loop, a concurrent call to
dmem_cgroup_unregister_region() would block in synchronize_srcu() waiting
for this reader to finish.

Would it be safer to scope the SRCU read lock inside the loop iteration?
This would allow synchronize_srcu() to proceed and the loop could safely ab=
ort
when it sees region->unregistered become true.

> +	}
> +	srcu_read_unlock(&dmemcg_srcu, srcu_idx);
>  }

[ ... ]

> @@ -488,9 +539,11 @@ void dmem_cgroup_unregister_region(struct dmem_cgrou=
p_region *region)
>  	 * no new pools should be added to the dead region
>  	 * by get_cg_pool_unlocked.
>  	 */
> -	region->unregistered =3D true;
> +	WRITE_ONCE(region->unregistered, true);
>  	spin_unlock(&dmemcg_lock);
> =20
> +	synchronize_srcu(&dmemcg_srcu);
> +
>  	kref_put(&region->ref, dmemcg_free_region);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703130541.2686=
-1-thomas.hellstrom@linux.intel.com?part=3D3
