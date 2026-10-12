Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7363DCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF72D10F19F;
	Mon, 12 Oct 2026 15:03:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590E210F19F
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:03:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2764600D4;
 Mon, 12 Oct 2026 15:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696161F0089D;
 Mon, 12 Oct 2026 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791817388;
 bh=DFo0BVTWOl3oiQtv91jf3RMDfVXrYXlDgtBXGpPkDSk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=THnpvxHXr4Ywfiov8zyuR3JQyAi6WWvQid40EyXWXhKFaRH0tmNjgjOi78LGpgiag
 AT4OHlgfE+mIcRGNiBJnjDoFoblE/CDZb3AQsM3mcOClWrAjhSpZmcrnbuFGp+z/pn
 HU56Qa/GhuOU4aqpd3m4aTwYnFls9y6VuifVnb0gXGub4UuhHlgD7SsDES2/nHCcGb
 4eiFWBX5VbfAoNCmmkacVVpvPeELW2SAHZh0J8cxUShHl4LM09ZXIy96bRHBxmSdqu
 8Tmg7iglu+SEcoK4UhV/Q/06FGm/fBhhfJdDmFqwSdLbYjTRhn1sWQIkztHZc5Fg/J
 TtW1PDEwtcZpA==
Message-ID: <sashiko-outbox-168309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-claude-fixes-v15-15-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
 <20261012-claude-fixes-v15-15-bc0a6c498553@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:03:08 +0000
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
- [Medium] drm/panfrost: data race on perfcnt->state during dump error path
- [Low] cleanup: mixing goto and scoped_guard in panfrost_perfcnt_enable_lo=
cked
--

commit f2123ab59275f76a9a44c42db13e01ef9037cc87
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

This commit updates panfrost's performance counter session logic to use
the reset read/write semaphore when accessing hardware registers. It also
expands the perfcnt dump ioctl to notify userspace if a reset occurred,
rendering previous counter states invalid.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a9..a9def452d5ef9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
> @@ -58,27 +70,130 @@ void panfrost_perfcnt_sample_done(struct panfrost_de=
vice *pfdev)
>  		complete(&pfdev->perfcnt->dump_comp);
>  }
> =20
> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u=
32 *state)
>  {
[ ... ]
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*state =3D perfcnt->state;
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> +			return -EIO;
> +
> +		perfcnt->state =3D 0;
> +
> +		reinit_completion(&pfdev->perfcnt->dump_comp);
> +
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +	}
> +
> +	/*
> +	 * Here we release the reset semaphore because perfcnt should not get i=
n the way
> +	 * of a HW reset. Besides, a legitimate reset might be issued during th=
e wait.
> +	 */
>  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
>  							msecs_to_jiffies(1000));
> +
>  	if (!ret)
>  		ret =3D -ETIMEDOUT;
> =20
> -	return ret;
> +	/* We need to restore perfcnt state so the next successful dump can rel=
ay it to UM */
> +	if (ret < 0) {
> +		perfcnt->state |=3D *state;
> +		*state =3D 0;
> +		return ret;
> +	}

[Severity: Medium]
Is there a potential data race on perfcnt->state here?

The dump wait function releases pfdev->reset.lock to allow concurrent GPU
resets. If the wait is interrupted or times out (ret < 0), it performs a
read-modify-write on perfcnt->state without re-acquiring the lock.

Concurrently, if a GPU fault occurs, panfrost_device_reset() will run and
invoke panfrost_perfcnt_reset(), which modifies the same state:

panfrost_perfcnt_reset()
   perfcnt->state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;

Since the error path in panfrost_perfcnt_dump_locked() modifies
perfcnt->state without synchronization against this reset path, the
PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET flag might be silently
overwritten and lost. Would it be safer to wrap this restoration block insi=
de
a scoped_guard to ensure the flag from the reset thread is preserved?

[ ... ]
> @@ -122,54 +252,30 @@ static int panfrost_perfcnt_enable_locked(struct pa=
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
[ ... ]
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/*
> +		 * Clear the counters to start from a fresh state.
> +		 */
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> +		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +		if (ret)
> +			goto err_vunmap;

[Severity: Low]
Does jumping out of a scoped_guard with a goto statement mix cleanup patter=
ns?

The kernel cleanup guidelines note that usage of "goto" and cleanup helpers
(like scoped_guard) should not be mixed in the same function. Doing so can
create confusing ownership semantics and increase the risk of leaks during
future modifications.

Would it be better to either convert all resources in this function to use
scope-based cleanup, or stick to traditional locking (down_read / up_read) =
to
match the existing goto-based error handling?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-claude-fix=
es-v15-0-bc0a6c498553@collabora.com?part=3D15
