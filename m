Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B01C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D5BC10E61D;
	Fri, 24 Jul 2026 00:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TJODu6oK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8343110E61D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:16:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63D3E40668;
 Fri, 24 Jul 2026 00:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BFD1F000E9;
 Fri, 24 Jul 2026 00:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784852162;
 bh=3sZLtpr90dH8aISQDzfZaTLS7u9UGY1ls6rKw3pLIfI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TJODu6oK2VQ6cwgg9r2JXVwI1KGUBR/DTKU8SS6KgBwUYbJThlexVofGsN6ys9EHf
 kBa2Vf7ryGMeIAhR9NRK499y+7BBnGzS1FrLyQSU5jtlmW5QByayrcgdwQI77AUwHo
 MHntcokY13MgNVyT2hL3Px8i0R5ujdjc02WUs/uMuS9cYVOiX+8AS3OhLb95DH0tvO
 9Ul/UUpXf0w1dxZAh3tPTryZxCiaWPr4Fu9M9c5BhkDFWdU/sqZXIO/BYUm5OSvkZX
 j+a6dDcXAg/yeBayJnJ2BWeKnHDb5FWSY2IAqcX4WLWjhZbRgd0pyr2MK4mUK0Y0Co
 Rmv9xQ/nCm9CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-13-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-13-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:16:01 +0000
Message-Id: <20260724001602.26BFD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Infinite loop in `panfrost_perfcnt_dump_locked` due to unsigned in=
teger underflow.
- [High] Race condition bypassing wait for completion in `panfrost_perfcnt_=
dump_locked`.
- [High] Dead code in reset recovery during performance counter enablement =
leads to spurious timeouts.
- [High] Ignored return value of `panfrost_perfcnt_hw_enable()` leads to ad=
dress space reference count underflow.
- [Medium] Stale `reset_happened` flag masks timeout errors in subsequent p=
erformance counter sessions.
- [Medium] Race condition in `panfrost_perfcnt_dump_locked()` fails to noti=
fy userspace of hardware resets.
--

--- Patch [13]: [PATCH v3 13/13] drm/panfrost: Bump driver minor to reflect=
 new DUMP IOCTL req field ---
commit a7210878c461c0a2b1d591ac0e3e2de27fb4740f
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Bump driver minor to reflect new DUMP IOCTL req field
   =20
Expose expanded PERFCNT_DUMP IOCTL interface to user mode.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index 7020c0192e189..a6f1b0b961fcd 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
> +					u64 *reset_happened)
>  {
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u64 retries =3D PERFCNT_DUMP_MAX_RETRIES;
> +	bool previous_reset;
>  	u64 gpuva;
>  	int ret;
> =20
>  	reinit_completion(&pfdev->perfcnt->dump_comp);
>  	gpuva =3D pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> +	previous_reset =3D atomic_read(&perfcnt->reset_happened);
> +
> +dump_retry:

[Severity: High]
Does this sequence have a race condition if a GPU reset occurs during the d=
ump?

The reinit_completion() is called outside the dump_retry loop.

If a hardware sample completion IRQ fires (waking the wait and consuming the
completion so done=3D0), and a GPU reset occurs immediately after but before
atomic_cmpxchg(), the reset handler calls complete(&dump_comp) (done=3D1).

The code then jumps to dump_retry because of the reset.

Will the second wait_for_completion immediately consume the pending complet=
ion
(done=3D1) and return without actually waiting for the new sample commands =
to
finish?

> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
[ ... ]
> +	}
> +
>  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
>  							msecs_to_jiffies(1000));
> +	if (retries =3D=3D PERFCNT_DUMP_MAX_RETRIES)
> +		*reset_happened =3D previous_reset || atomic_read(&perfcnt->reset_happ=
ened);
> +
> +	if (atomic_cmpxchg(&perfcnt->reset_happened, 1, 0)) {

[Severity: Medium]
Can this miss notifying userspace of a hardware reset?

If a GPU reset occurs precisely between the atomic_read() and
atomic_cmpxchg(&perfcnt->reset_happened, 1, 0), *reset_happened is assigned=
 0.

The atomic_cmpxchg() then succeeds, decrements retries, and loops to
dump_retry. On the subsequent successful iteration, the condition
(retries =3D=3D PERFCNT_DUMP_MAX_RETRIES) is false, so *reset_happened is n=
ever
updated to true.

Will this break userspace counter accumulation logic by causing it to aggre=
gate
post-reset small counter values as if they were continuous?

> +		if (--retries >=3D 0)
> +			goto dump_retry;

[Severity: High]
Is it possible for this to enter an infinite loop?

The retries variable is declared as a u64.

When it reaches 0, --retries will underflow to UINT64_MAX, making the condi=
tion
>=3D 0 always evaluate to true.

If resets continuously occur, could this bypass the PERFCNT_DUMP_MAX_RETRIES
limit and cause a soft lockup?

> +		ret =3D -EBUSY;
> +	} else {
[ ... ]
> @@ -117,57 +191,37 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
[ ... ]
> +	ret =3D wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
>  					  msecs_to_jiffies(1000));
> -	if (!ret) {
> +	if (!ret && !atomic_read(&perfcnt->reset_happened)) {
>  		ret =3D -ETIMEDOUT;
>  		goto err_vunmap;
>  	}

[Severity: High]
Is this reset recovery path dead code?

In panfrost_perfcnt_enable_locked(), the code waits for cache cleaning and
expects perfcnt->reset_happened to be set if a reset occurs during the wait.
However, panfrost_perfcnt_reset() checks if (!perfcnt->user) and returns ea=
rly.

Because perfcnt->user is only assigned after the wait completes, any reset
during the wait causes the reset handler to return without setting
reset_happened.

Does this mean the wait will just time out and return -ETIMEDOUT instead of
recovering?

[ ... ]
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> -
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		perfcnt->counterset =3D counterset;
> +		perfcnt->user =3D user;
> +		atomic_set(&perfcnt->reset_happened, 0);
> +		panfrost_perfcnt_hw_enable(pfdev);
> +	}

[Severity: High]
Is it safe to ignore the return value of panfrost_perfcnt_hw_enable()?

If panfrost_mmu_as_get() fails inside the helper, the hardware is not enabl=
ed
and the AS refcount is not incremented. However, perfcnt->user is still set
and the ioctl returns success.

Upon closing the session, panfrost_perfcnt_disable_locked() unconditionally
calls panfrost_mmu_as_put().

Will this cause an MMU address space reference count underflow?

[ ... ]
> @@ -193,18 +247,15 @@ static int panfrost_perfcnt_disable_locked(struct p=
anfrost_device *pfdev,
>  	if (user !=3D perfcnt->user)
>  		return -EINVAL;
> =20
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
[ ... ]
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> +		panfrost_perfcnt_gpu_disable(pfdev);
> +		perfcnt->user =3D NULL;
> +	}

[Severity: Medium]
Does tearing down the session here without clearing the reset_happened atom=
ic
flag cause issues for future sessions?

If a GPU reset occurs during a performance counter session, the flag is set
to 1.

If the session is then closed without calling PERFCNT_DUMP (which normally
clears it), the flag remains 1.

When a new session is started via panfrost_perfcnt_enable_locked(), will the
stale flag cause the wait timeout condition !ret &&
!atomic_read(&perfcnt->reset_happened) to evaluate to false, masking any
legitimate timeouts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D13
