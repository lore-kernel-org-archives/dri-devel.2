Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC97EC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440CF10E173;
	Fri, 10 Jul 2026 09:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L44O7l22";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC1010E173
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:27:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EA78601D9;
 Fri, 10 Jul 2026 09:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17D21F000E9;
 Fri, 10 Jul 2026 09:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783675662;
 bh=8fXskwVGXuHDUpQxB7DaxmLsyZqr4m9Nw+mLRcDQVGU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L44O7l22qU/hoUzFsULV14pB2a+qcz06U4nffI/CK3/oUnn9Z9w05wcxFLxqsjNl0
 1FlajL1y7kKiJV2OLdHT6GNS64RLCxyM7OOl3p35bRYFjro5Nnic+1ashFroTmQSEj
 mE6cjxm4x2Su4s0a+5HIGYuI0v+FYxzg2yYPmQDxKQldcX+Fa2YojkD9zos60tsEtx
 K+gdnkWu5iNb9ZrkIO3FCz2O/pvFUg+6ZThmLP0FqDTkBuBzjFWCqJuD5HVnrs+pi0
 JwWfFU9P88QzS85E5SEwiTlTP0uxNHATAVCh+ryYXEu4CHCb5Tb+WQxsEqr/RSx4xa
 o2T5Y7YlUYXPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/etnaviv: Add GPU reset counters
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710-etnaviv-reset-notification-v2-2-90cfebcf22a2@igalia.com>
References: <20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com>
 <20260710-etnaviv-reset-notification-v2-2-90cfebcf22a2@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:27:42 +0000
Message-Id: <20260710092742.B17D21F000E9@smtp.kernel.org>
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
- [Medium] Concurrent modification and unannotated lockless reads of `gpu->=
reset_counter` and `ctx->reset_counter` lead to data races and lost increme=
nts.
--

--- Patch [2]: [PATCH v2 2/2] drm/etnaviv: Add GPU reset counters ---
commit 0f536ab6e10b2d00764a49473b750d556dcda8ee
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/etnaviv: Add GPU reset counters

This commit adds per-GPU and per-context reset counters to etnaviv to allow
userspace to detect GPU resets and determine if their context was guilty.

> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
[ ... ]
> +static int etnaviv_ioctl_reset_query(struct drm_device *dev, void *data,
> +		struct drm_file *file)
> +{
> +	struct etnaviv_drm_private *priv =3D dev->dev_private;
> +	struct etnaviv_file_private *ctx =3D file->driver_priv;
> +	struct drm_etnaviv_reset_query *args =3D data;
> +	struct etnaviv_gpu *gpu;
> +
> +	if (args->flags)
> +		return -EINVAL;
> +
> +	if (args->pipe >=3D ETNA_MAX_PIPES)
> +		return -EINVAL;
> +
> +	gpu =3D priv->gpu[args->pipe];
> +	if (!gpu)
> +		return -ENXIO;
> +
> +	args->global_reset_counter =3D gpu->reset_counter;
> +	args->context_reset_counter =3D ctx->reset_counter;

[Severity: Medium]
Is it possible for these counters to be updated concurrently while being
read here?=20

Since etnaviv_sched_timedout_job() can increment the counters on another CP=
U,
it seems this lockless read might need READ_ONCE() to prevent load tearing =
and
ensure the compiler doesn't optimize the read incorrectly.

> +
> +	return 0;
> +}
[ ... ]
> --- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
[ ... ]
> @@ -79,6 +79,9 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_j=
ob(struct drm_sched_job
>  	if(sched_job)
>  		drm_sched_increase_karma(sched_job);
> =20
> +	gpu->reset_counter++;
> +	submit->ctx->reset_counter++;

[Severity: Medium]
Can a single userspace context submit jobs to multiple GPU pipes that
might hang at the same time?=20

If so, could multiple per-GPU scheduler timeout workers execute
etnaviv_sched_timedout_job() simultaneously? If they do, both workers would
evaluate submit->ctx->reset_counter++ concurrently, which could lead to a
multi-writer data race and lost increments.=20

Would it make sense to use atomic_t for the context reset counter, or at
least WRITE_ONCE() if exact counts are less critical than preventing data
races?

>  	/* get the GPU back into the init state */
>  	etnaviv_core_dump(submit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-etnaviv-re=
set-notification-v2-0-90cfebcf22a2@igalia.com?part=3D2
