Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0292DCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBBB10FE41;
	Fri,  9 Oct 2026 03:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KCSRsUkn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB7A10FE41
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:30:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F387660DB0;
 Fri,  9 Oct 2026 03:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB861F000FF;
 Fri,  9 Oct 2026 03:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791516642;
 bh=0Ks10+5VhMrL3rOeNGhm0fjzzaz3VzxUOuLGuCdVyxk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KCSRsUkn2nAZY9yBB9WUq0+ucF0Rqxk2PyNdAKrqJTH4+jij4SPncSk2vhrt9c7GH
 kvKfup4x52FhtXgDEkMf858JNN1w132BbVvA0PE9MLJQa5JgwZuBid//LdOxFLoCHr
 +Xk6jtpVIJTV/rpkYlWeuuCYCyiFq+gnLzgbICwL9QfWgy6sU3uH5hhYWSXO5Qj0UW
 NIGyq0QXgmq4XyEU8dLe42VT5redws8D5OgIntyrfp8PRlb6lDvZAh58/jRMmjh8Ez
 A+SkrVanlKP7kv+5VerF9/TAv96rTODDJHZq45HE5OAPC5IGaMLJVp17ukqOCPkr8a
 6rSD5rH0v6uvQ==
Message-ID: <sashiko-outbox-164766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/20] drm/msm/dp: Serialize stream operations with
 HPD processing
To: "Xilin Wu" <sophon@radxa.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-7-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-7-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:30:41 +0000
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
- [High] drm: sleepable mutex lock in atomic context (plugged_lock)
--

commit cb0347df94f2c11e58ecb3d98faa755fd4b526ef
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Serialize stream operations with HPD processing

HPD PHY test requests stop and restart the mainlink under plugged_lock,
but atomic stream enable and disable do not take that lock. Both paths
can check a resource flag before either updates it and acquire duplicate
clock or PHY references. They can also reset a link while the other path
is training it or enabling video.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 32a2ac89d8ed0..787efbcb6c124 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -1449,7 +1468,13 @@ void msm_dp_display_atomic_enable(struct msm_dp *m=
sm_dp_display,
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> -	rc =3D msm_dp_display_prepare_link(dp);
> +	rc =3D msm_dp_display_prepare(dp);
> +	if (rc)
> +		return;
> +
> +	guard(mutex)(&dp->plugged_lock);

[Severity: High]
Does this introduce a sleeping lock into an atomic context?

The DRM subsystem guidelines state that encoder atomic enable/disable
callbacks run in atomic context during non-blocking commits. Calling sleepi=
ng
functions, like acquiring a mutex, from an atomic context can cause kernel
warnings, system instability, and potential deadlocks.

> +
> +	rc =3D msm_dp_display_prepare_link_locked(dp);
>  	if (rc) {
>  		DRM_ERROR("DP display prepare failed, rc=3D%d\n", rc);
>  		return;

[ ... ]

> @@ -1474,6 +1499,8 @@ void msm_dp_display_atomic_disable(struct msm_dp *d=
p)
> =20
>  	msm_dp_display =3D container_of(dp, struct msm_dp_display_private, msm_=
dp_display);
> =20
> +	guard(mutex)(&msm_dp_display->plugged_lock);

[Severity: High]
Does this also introduce a sleeping lock into an atomic disable callback?

> +
>  	/*
>  	 * If .atomic_enable() bailed out - link training failure is the common
>  	 * case - the mainlink was never brought up and ->power_on stayed false.

[ ... ]

> @@ -1511,7 +1538,8 @@ void msm_dp_display_atomic_post_disable(struct msm_=
dp *dp)
> =20
>  	msm_dp_display_audio_notify_disable(msm_dp_display);
> =20
> -	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
> +	scoped_guard(mutex, &msm_dp_display->plugged_lock)
> +		msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);

[Severity: High]
Could this scoped_guard() cause a sleep in atomic context during the
post-disable phase of an atomic commit?

> =20
>  	msm_dp_display_unprepare(msm_dp_display);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D7
