Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F81AC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C1A10E393;
	Mon,  6 Jul 2026 13:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TmS/mYbO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7577110E393
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:42:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25D6B4025B;
 Mon,  6 Jul 2026 13:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86101F000E9;
 Mon,  6 Jul 2026 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783345336;
 bh=R2IoAUzZChp9dTL49W5cKe47gmvPYPlx/Qz1ovRM4Xs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TmS/mYbOBKTTXfbltUmlehRmPeHX8rajCv8u0U8kGd7T2OlcOCAyvCE+rZDEpZIvh
 quiVZaYfFm1SiECe04Voj29qY/wax7KTntct5CXR/sy5dVlKCoFcBauHr8k2SxoHnQ
 Elr2FBv5V7LmJyf+Pu6Rd1K2szjuJrsTdxNh/m/r2OTrP/rn2ELcXYRgw5qiX49Gb1
 Gq7hGBesDuuGXot4kiQYXeoepzkuzCR9g7YrIzpEkKxg2sIUyxBXu3yGh1XqU1QDop
 EsjwZn2mt8GMi4v+yN/kaB3+eeUVUD0KeX8UsBK+K3bB5mqJ7zg+HwNR/7jZZ8LSU5
 alYnxeX8xieKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] drm/v3d: Refactor perfmon locking
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-v3d-perfmon-lifetime-v4-1-d7b312ff2c83@igalia.com>
References: <20260706-v3d-perfmon-lifetime-v4-0-d7b312ff2c83@igalia.com>
 <20260706-v3d-perfmon-lifetime-v4-1-d7b312ff2c83@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:42:15 +0000
Message-Id: <20260706134215.E86101F000E9@smtp.kernel.org>
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
- [High] Incorrect checking of pm_runtime_get_if_active() return values lea=
ds to unbalanced pm_runtime_put() calls and hardware access when runtime PM=
 is disabled.
--

commit cf45a6afd7e990783e893c6013389c01aac4b43c
Author: Ma=C3=ADra Canal <mcanal@igalia.com>
Subject: drm/v3d: Refactor perfmon locking

This commit refactors performance monitor locking in the v3d driver to
serialize access to the active perfmon globally. It introduces a
device-wide spinlock and routes state transitions through a small set of
locked entry points.

> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_=
perfmon.c
> index 48ae748247be8..3ad0f022753c8 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
[ ... ]
>  void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
>  {
> +	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
> +
> +	if (!perfmon || v3d->global_perfmon)
> +		return;
> =20
> -	if (WARN_ON_ONCE(!perfmon || v3d->active_perfmon))
> -		return;
> -
> -	if (!pm_runtime_get_if_active(v3d->drm.dev))
> -		return;
> +	if (!pm_runtime_get_if_active(v3d->drm.dev))
> +		return;

[Severity: High]
Does this code correctly handle the case where runtime PM is disabled?

When runtime PM is disabled, pm_runtime_get_if_active() returns a negative
error code (like -EINVAL). Since a negative number evaluates to true in C,
!pm_runtime_get_if_active() evaluates to false.=20

This causes the early return to be bypassed, allowing the code to proceed
with hardware MMIO access when the device might be powered off. It also
results in an unbalanced v3d_pm_runtime_put() call at the end of the functi=
on.

Should this be checking if the return value is <=3D 0?

> +
> +	v3d_perfmon_hw_start(v3d, perfmon);
> +	v3d->perfmon_state.active =3D perfmon;
> +
> +	v3d_pm_runtime_put(v3d);
> +}
[ ... ]
> +static void v3d_perfmon_capture_locked(struct v3d_dev *v3d,
> +				       struct v3d_perfmon *perfmon)
> +{
> +	lockdep_assert_held(&v3d->perfmon_state.lock);
> +
> +	if (!perfmon || perfmon !=3D v3d->perfmon_state.active)
> +		return;
> =20
>  	if (!pm_runtime_get_if_active(v3d->drm.dev))
> -		goto out_clear;
> +		return;

[Severity: High]
Does this face the same issue with negative return values from=20
pm_runtime_get_if_active() as v3d_perfmon_start()?

> =20
> -	if (capture)
> -		for (i =3D 0; i < perfmon->ncounters; i++)
> -			perfmon->values[i] +=3D V3D_CORE_READ(0, V3D_PCTR_0_PCTRX(i));
> +	v3d_perfmon_hw_capture(v3d, perfmon);
> +	v3d_pm_runtime_put(v3d);
> +}
> =20
> +void v3d_perfmon_stop_locked(struct v3d_dev *v3d, struct v3d_perfmon *pe=
rfmon,
> +			     bool capture)
> +{
> +	lockdep_assert_held(&v3d->perfmon_state.lock);
> +
> +	if (!perfmon || perfmon !=3D v3d->perfmon_state.active)
> +		return;
> +
> +	v3d->perfmon_state.active =3D NULL;
> +
> +	/* If the device is suspended, the HW has already stopped counting. */
> +	if (!pm_runtime_get_if_active(v3d->drm.dev))
> +		return;

[Severity: High]
Will a negative return value here prevent the function from returning early,
leading to unexpected hardware access?

> =20
> -	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, 0);
> +	v3d_perfmon_hw_stop(v3d, perfmon, capture);
>  	v3d_pm_runtime_put(v3d);
> +}
[ ... ]
> @@ -482,18 +545,36 @@ int v3d_perfmon_set_global_ioctl(struct drm_device =
*dev, void *data,
[ ... ]
> +		/* If the device is suspended, v3d_perfmon_resume() will
> +		 * program the HW on the next resume.
> +		 */
> +		if (pm_runtime_get_if_active(v3d->drm.dev)) {
> +			v3d_perfmon_hw_start(v3d, perfmon);
> +			v3d_pm_runtime_put(v3d);
> +		}

[Severity: High]
Is it possible for pm_runtime_get_if_active() to return -EINVAL here?

If runtime PM is disabled, the negative return value evaluates to true.
This would incorrectly grant hardware access and execute an unbalanced
v3d_pm_runtime_put() call.

Could this be updated to check if the return value is > 0?

>  	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-v3d-perfmo=
n-lifetime-v4-0-d7b312ff2c83@igalia.com?part=3D1
