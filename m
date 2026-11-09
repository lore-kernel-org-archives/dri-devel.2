Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9A606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5TgHiZN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE30310E687;
	Mon,  9 Nov 2026 17:30:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C036410E687
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:30:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 804C240B8B;
 Mon,  9 Nov 2026 17:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CEC1F0089F;
 Mon,  9 Nov 2026 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794245452;
 bh=mwTQDW4k4GrCFHxdbMXG++dbVCAks4t/Z2lMxkoz4nI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m5TgHiZNxyui20F96Hstx8uSXDavzTeb8fH096DzT2CpBrVgnUrkdTSCjs1t0mYfR
 r4dgktp1B+rWY31ufCEo4utHF5lp5ySeoUeMAPCnb2ly3I7eoT9qHwTtF9YnxVO0Oh
 83Ofi18cN/Cw83iDMUsXQny4hAeCkaKcT9BqrWGrmNfQXjStvfuw+YJqIFj2ILK/A3
 HPqFpWwTTE6cCkHOsfhJNPVhZM4SjLvxdlhQwMkWdS5pEvCjN5MU8LyHnDgpMmLU29
 v5psjCO7pkjXk74PG4iK4FuOW7ZsvML8V/nhCfnrmxJsX0/zxh7opnbYKZWevTAUba
 IT3ggeLSZta6g==
Message-ID: <sashiko-outbox-205304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] drm/amdkfd: avoid NULL kfd_process_device in
 kfd_profiler_pmc
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:30:51 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amdkfd: un-reverted lock state on NULL pdd in
  kfd_profiler_pmc()
- [Low] drm/amdkfd: missing Fixes trailer in kfd_profiler_pmc() commit
--

commit 04f061e589d38a636c5063f9828ed5587bde69f6
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

> drm/amdkfd: avoid NULL kfd_process_device in kfd_profiler_pmc
>
> All other callers of kfd_process_device_data_by_id deal with
> a possible NULL return value except kfd_profiler_pmc.
>
> Check it after the mutex unlock and return -EINVAL as others
> place do.
>
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric=
.pelloux-prayer@amd.com?part=3D4
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

[Severity: Low]
Since this fixes a NULL pointer dereference in kfd_profiler_pmc(), should
the commit message include a Fixes tag?

  Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profi=
ler kernel driver changes")

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index d65ae53c81a5c..95921369abb26 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3463,8 +3463,10 @@ static inline int kfd_profiler_pmc(struct kfd_proc=
ess *p,
>  	/* Enable/disable perfcount if requested */
>  	mutex_lock(&p->mutex);
>  	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> -	dqm =3D pdd->dev->dqm;
>  	mutex_unlock(&p->mutex);
> +	if (!pdd)
> +		return -EINVAL;
> +	dqm =3D pdd->dev->dqm;
> =20
>  	dqm->ops.set_perfcount(dqm, args->perfcount_enable);
>  	return status;

[Severity: Medium]
Does returning -EINVAL here leave the device profiler lock and PTL disable
request leaked when args->lock =3D=3D 1?

profile_lock_device() has already looked up pdd under p->mutex, set
kfd->profiler_process =3D p, and called kfd_ptl_disable_request(pdd, p).
Because p->mutex is dropped between the two lookups, a concurrent
criu_restore_devices() call updating pdd->user_gpu_id (or the device
becoming wedged later in this series) can cause this second
kfd_process_device_data_by_id() call to return NULL.  Returning -EINVAL at
that point leaves kfd->profiler_process and the PTL disable state held
when locking, so later profiling attempts fail with -EALREADY or -EBUSY
(or skips updating perfcount on the queues after unlocking when
args->lock =3D=3D 0).

Looking up pdd once or passing pdd from profile_lock_device() would avoid
the second lookup and the un-reverted state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109171333.4329=
-1-pierre-eric.pelloux-prayer@amd.com?part=3D1
