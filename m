Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8D4C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0970F10E642;
	Mon,  7 Sep 2026 20:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="THcuzyIf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570B410E642
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:36:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 865CB601FB;
 Mon,  7 Sep 2026 20:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118861F00A3A;
 Mon,  7 Sep 2026 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788813370;
 bh=7d2xiETMvaM1bg7Nu1/+9PHAUCmMjjG2EnYplsARrj4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=THcuzyIfZZugDUY2SVUGRvX5h9LS3csGt1u5aqP3CwUrFnRevqiM98Hd9mbckToeA
 4pe5y0p8oZhsjxdCDZEqStXSl86q23qqTp84m9MbX9r2JEqjXwPCBNAMQzmtAcmfXe
 zXgZf5qsg6mi5tx3u6euAQOoJ6EZv/DpQBzG/bgtED/uCajfNVfkp4Upa27ZnKuWRJ
 TFrj/9Sl9XJdoSaB9cI0cVw53AMc9ZMWNIUceXkV3dKOUWDd/nVRSJfFocLSW34g+p
 jfrFzgOSzzSdRzvdOOaW4+a2J/737Q3Dk6Y1d7ZIVXya33taZ1p9/Bt1Jwl2bX4TiR
 0bGw2C6nnwGnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/16] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-15-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-15-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:36:09 +0000
Message-Id: <20260907203610.118861F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] State Loss: The `reset_happened` flag is cleared prematurely on er=
ror paths
- [Medium] API Flaw: Uninitialized userspace memory leaked back as flags an=
d unvalidated padding
- [Low] Cleanup Rule Violation: Mixing goto-based error handling and scoped=
_guard in the same function

Pre-existing issues:
- [High] Race Condition / GPU Fault: Pending asynchronous GPU sample operat=
ion is not cancelled when wait is interrupted
--

commit 9121f328e8a02b83046e96373b7d6c617fd603c1
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

This commit uses the reset read/write semaphore to manage access to hardware
during reset time. It expands the DRM uAPI for the perfcnt dump operation so
userspace can be aware of hardware resets. It also attempts to reestablish
the perfcnt configuration if a session was enabled during a reset.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -47,11 +52,15 @@ static void panfrost_perfcnt_hw_disable(struct panfro=
st_device *pfdev)
>  void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
>  {
> -	if (pfdev->features.selected_coherency !=3D COHERENCY_ACE)
> +	if (pfdev->features.selected_coherency !=3D COHERENCY_ACE) {
>  		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> -	else
> +	} else {
> +		pfdev->perfcnt->dump_finished =3D true;
>  		complete(&pfdev->perfcnt->dump_comp);
> +	}
>  }

[Severity: High]
This is a pre-existing issue, but does this IRQ handler complete the dump_c=
omp
unconditionally without verifying if it corresponds to the currently active
dump request?=20

If the wait in panfrost_perfcnt_dump_locked() is interrupted by a signal, t=
he
hardware GPU_CMD_PERFCNT_SAMPLE command could still be running. If userspace
immediately closes the file descriptor, the GEM object and MMU mappings cou=
ld
be freed while the GPU is still actively writing to memory, potentially
causing a GPU page fault.

[ ... ]

> @@ -60,25 +105,43 @@ static int panfrost_perfcnt_dump_locked(struct panfr=
ost_device *pfdev)
> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u=
32 *state)
>  {
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		if (!perfcnt->owns_as_ref) {
> +			*state =3D PANFROST_PERFCNT_SESSION_DEAD;
> +			return -EIO;
> +		}
> +
> +		if (perfcnt->reset_happened) {
> +			*state =3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> +			perfcnt->reset_happened =3D false;
> +		}

[Severity: High]
If wait_for_completion_interruptible_timeout() gets interrupted (e.g., by a
signal) or times out, it will return an error like -ERESTARTSYS. Since
perfcnt->reset_happened is cleared here at the start of the function, won't
the reset condition be permanently lost?

If the ioctl is retried by VFS or userspace, userspace might incorrectly
accumulate counter values across a GPU reset without knowing it happened.

[ ... ]

> @@ -122,54 +200,31 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
>  	ret =3D drm_gem_vmap(&bo->base, &map);
>  	if (ret)
>  		goto err_put_mapping;
> +
>  	perfcnt->buf =3D map.vaddr;
> +	perfcnt->counterset =3D counterset;
> =20
>  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> =20
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/*
> +		 * Clear the counters to start from a fresh state.
> +		 */
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
> +		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +		if (ret)
> +			goto err_vunmap;

[Severity: Low]
Does this goto statement jump out of the scoped_guard() block directly into
legacy error handling labels?=20
   =20
The subsystem coding guidelines specify that goto-based cleanup and
scoped_guard() / __free() shouldn't be mixed in the same function to avoid
confusing ownership semantics.

[ ... ]

> @@ -255,7 +313,7 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *de=
v, void *data,
>  		goto out;
>  	}
> =20
> -	ret =3D panfrost_perfcnt_dump_locked(pfdev);
> +	ret =3D panfrost_perfcnt_dump_locked(pfdev, &req->state);

[Severity: Medium]
Since DRM_IOCTL_PANFROST_PERFCNT_DUMP uses DRM_IOWR, is it possible that
req->state and req->pad contain uninitialized user stack memory here?=20

It appears req->state is passed directly into panfrost_perfcnt_dump_locked()
where it is conditionally updated using a bitwise OR, without ever being
unconditionally zero-initialized first. Also, req->pad doesn't seem to be
validated to be zero, which could complicate extending this struct in the
future.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D15
