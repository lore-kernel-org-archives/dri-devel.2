Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB1CC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4ED710F70B;
	Thu, 24 Sep 2026 18:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TmQDn59K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E5110E565
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:26:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8F6C601FE;
 Thu, 24 Sep 2026 18:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D141F000FF;
 Thu, 24 Sep 2026 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790274415;
 bh=rfOJj2dcp3PWljoy8ksov8HtIVmDykyhJ3RFyVUGue4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TmQDn59KUueU4QUSdYPvktKJbmq3ixGoectIojNFoyXmjGND1cJCxzHReLvykqh+o
 RSL+IydD+84mumPKNDvYCo4RUwOmiIqkmcx2Q0IWMEKcMbbf/HwM2IvR2rxTTMCNue
 SR0JTRd3QozxrNHwSqKDD2wJX8ed4OB2Mtdn7ad1d6a7pAnRK7PfqZevzZ/82K72IY
 xgpxCKtXjwaFzUkIFgXpL+wxZjssX7Wr5au6ynXViHyesRf0msJ8YXWVqo+LYp78vA
 mwXltAaJ+m4AEH2FmLNFB13SyVtGfmqq60zCp3JoyiEVbd4JAX0gIR5+2IVhC/Sjyn
 /XhkMaNa+EDUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-claude-fixes-v10-15-755929b3cc19@collabora.com>
References: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
 <20260924-claude-fixes-v10-15-755929b3cc19@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:26:54 +0000
Message-Id: <20260924182655.51D141F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/panfrost: unnormalized positive return value causes ioctl to s=
kip copy_to_user
- [High] drm/panfrost: missing state reset causes permanent DoS for perfcnt=
 after SESSION_DEAD
- [Low] drm/panfrost: mixing goto and scoped_guard violates cleanup subsyst=
em rules
--

commit 3965f7ad946ecef84cbe249a17983ab972ee3c12
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

This commit uses the reset r/w semaphore to govern access to the hardware
at reset time, preventing races with tearing down perfcnt sessions or
ongoing hardware resets. It also expands the DRM uAPI for the perfcnt
DUMP operation to notify userspace if a reset occurred.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a9..91983d450c246 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
> @@ -58,25 +69,100 @@ void panfrost_perfcnt_sample_done(struct panfrost_de=
vice *pfdev)
[ ... ]
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u=
32 *state)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u64 gpuva =3D perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> +	int ret;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*state =3D perfcnt->state;
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> +			return -EIO;
> +
> +		perfcnt->state =3D 0;

[Severity: High]
Does this permanently lock out the perfcnt session if it dies?

If PANFROST_PERFCNT_SESSION_DEAD is set, the code returns -EIO here before
reaching `perfcnt->state =3D 0`. Since panfrost_perfcnt_enable_locked() also
does not clear `perfcnt->state` when starting a new session, won't this
leave the dead state stuck permanently and fail all future dump attempts?

[ ... ]
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
> +	/* A reset might come through in the gap between the completion returni=
ng and the following
> +	 * check, but because no sample was produced, we don't care to relay th=
e state back to UM
> +	 */
>  	if (!ret)
> -		ret =3D -ETIMEDOUT;
> -	else if (ret > 0)
> -		ret =3D 0;
> +		return -ETIMEDOUT;

[Severity: High]
Will this return the remaining jiffies as a positive value on success?

Since the previous code `else if (ret > 0) ret =3D 0;` was removed, a succe=
ssful
completion will now return a positive number. When this propagates back up =
to
the caller:

panfrost_ioctl_perfcnt_dump()
    ret =3D panfrost_perfcnt_dump_locked(pfdev, &req->state);
    if (ret)
        goto out;

won't this positive return value be treated as an error by the `if (ret)`
check? If so, this skips the copy_to_user() call entirely and prevents
userspace from receiving the requested performance counter data.

[ ... ]
> @@ -87,9 +173,8 @@ static int panfrost_perfcnt_enable_locked(struct panfr=
ost_device *pfdev,
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
Is it intended to use a goto statement inside a scoped_guard block?

The cleanup subsystem guidelines indicate that goto-based error handling
and scope-based cleanup helpers shouldn't be mixed in the same function
to avoid confusing ownership semantics. Should this be refactored to avoid
jumping out of the scope to the err_vunmap label?

> =20
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +		perfcnt->user =3D user;
> +	}
> =20
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-claude-fix=
es-v10-0-755929b3cc19@collabora.com?part=3D15
