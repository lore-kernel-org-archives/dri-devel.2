Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A11C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2FA10F89D;
	Fri, 10 Jul 2026 12:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WidCZMvT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4E410F89D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:12:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A16B4089B;
 Fri, 10 Jul 2026 12:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9FE1F00A3A;
 Fri, 10 Jul 2026 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783685553;
 bh=PIGwd2rIueduVNVNdw7hsZ87XxwXjgkVQ55fphDb08E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WidCZMvTDEZRS96gXEv5MFxKNwAODVqJh+xKcQO6YsaBMWwZOKOFRBAlkwOy9oZWz
 a9LjkIv9pi/Mjj7HR/9QfmudQEkk38RSIfv1TEgExeATR0HrHwLNSoKqZug/WiE9SO
 EV+VFKw+ENpeQGRqK0/s98TVdsk/jGQ1Zbi3JhlVt9R6+VTjbArxZXsmNaygUiF20M
 En4+U5Zvj8RZ2m8lVe1EFSCM9kt2RXXwYfYGYizucoemytQGrDumVxKUQCq02+cadD
 5kpoQQj+C9ebxgspvJOat2NTELJcwrJBnAjo5oPg7UJt4wfse6CScxeBvgeNcITXxi
 IGKenfqJMAtMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/etnaviv: Add GPU reset counters
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710-etnaviv-reset-notification-v3-2-7a145c8a1d01@igalia.com>
References: <20260710-etnaviv-reset-notification-v3-0-7a145c8a1d01@igalia.com>
 <20260710-etnaviv-reset-notification-v3-2-7a145c8a1d01@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 12:12:31 +0000
Message-Id: <20260710121231.EF9FE1F00A3A@smtp.kernel.org>
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
- [Medium] Data race on `ctx->reset_counter` when a context submits to mult=
iple GPUs.
--

--- Patch [2]: [PATCH v3 2/2] drm/etnaviv: Add GPU reset counters ---
commit abb119dbbf6be05ed3e37091e5708fd834c6fb78
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/etnaviv: Add GPU reset counters

This commit introduces two counters for tracking GPU resets: a per-GPU coun=
ter
and a per-context counter, queryable via a new RESET_QUERY ioctl. Userspace
can use these counters to determine if its context was guilty of a reset or
just an innocent victim.

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index a27ed014fb4e7..5c50e5a244082 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c

[ ... ]

> @@ -296,6 +296,32 @@ static int etnaviv_ioctl_get_param(struct drm_device=
 *dev, void *data,
>  	return etnaviv_gpu_get_param(gpu, args->param, &args->value);
>  }
> =20
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
> +	mutex_lock(&gpu->lock);
> +	args->global_reset_counter =3D gpu->reset_counter;
> +	args->context_reset_counter =3D ctx->reset_counter;

[Severity: Medium]
Will this read of ctx->reset_counter race with updates on other GPUs?

Since ctx (struct etnaviv_file_private) can be shared across multiple GPU
cores, reading it under a single gpu->lock leaves it exposed to concurrent
updates from timeout handlers running on different GPUs.

> +	mutex_unlock(&gpu->lock);
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etna=
viv/etnaviv_drv.h
> index cba4323ae589c..9c348aa7f8d35 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -34,6 +34,7 @@ struct etnaviv_file_private {
>  	int id;
>  	struct etnaviv_iommu_context	*mmu;
>  	struct drm_sched_entity		sched_entity[ETNA_MAX_PIPES];
> +	u32 reset_counter;

[Severity: Medium]
Since this context counter is shared across multiple GPU cores and can be
updated concurrently if jobs on different GPUs hang simultaneously, does th=
is
need to be an atomic_t?

Using a plain u32 for concurrent accesses can lead to data races and lost
updates.

>  };

[ ... ]

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/et=
naviv/etnaviv_sched.c
> index 139e6e38784b3..6e9b677122e3d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> @@ -79,6 +79,11 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_=
job(struct drm_sched_job
>  	if(sched_job)
>  		drm_sched_increase_karma(sched_job);
> =20
> +	mutex_lock(&gpu->lock);
> +	gpu->reset_counter++;
> +	submit->ctx->reset_counter++;

[Severity: Medium]
Could this increment of submit->ctx->reset_counter race with other timeout
handlers?

The gpu->lock only protects the specific GPU, but the ctx is shared across
all pipes. If two GPUs hang simultaneously, two timeout handlers could run
concurrently on different workqueues and race while incrementing this
plain integer, causing lost updates.

> +	mutex_unlock(&gpu->lock);
> +
>  	/* get the GPU back into the init state */
>  	etnaviv_core_dump(submit);
>  	etnaviv_gpu_recover_hang(submit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-etnaviv-re=
set-notification-v3-0-7a145c8a1d01@igalia.com?part=3D2
