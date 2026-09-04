Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67455C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35DB10E164;
	Fri,  4 Sep 2026 13:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ootvdjbH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE3610E164
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22616600CB;
 Fri,  4 Sep 2026 13:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8481F00A3D;
 Fri,  4 Sep 2026 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788527764;
 bh=fdtDQDGSW6L5UA1qp+cf0p0salwd8ZP/nYzrZlWndCg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ootvdjbHuvu9LAo2U+IJDTBlmL3F9sjhsDGN8xWAJWccFFjayKirTXdHl24FPiday
 SldBxBKb95eKmVB6rSlNikHxllSmE+YWCS97/SxuCVjCWVuQ6eqwz0p/FuqeU3qREq
 GdblYPPsPEOLc27DQkx4ixqYGyUeWhfjGy8Z/ggVlLbRLXXu9e6npH9DwTLBU3fyRO
 AifjFCleCYnEKVFgigxI10ki2qBlxVY0djUOptAYMHhx75iOtQyaxH4bDG3TCIFDb9
 0y6Xmj+UO0HYGRoIfopdNXVqKrTBpG03QUAQR+wwlNjdB1RymTz4ZAyMt0Rq5hvCBu
 SmTZzZ8U3J6Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: check pm_runtime_resume_and_get() during
 resume
To: "Roman Demidov" <roman.demidov.nn@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904125523.43813-1-roman.demidov.nn@gmail.com>
References: <20260904125523.43813-1-roman.demidov.nn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:16:04 +0000
Message-Id: <20260904131604.AB8481F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unconditional `pm_runtime_resume_and_get()` on `gmu->gxpd` causes =
a NULL pointer dereference if the gxpd power domain is absent.
- [High] The `opp` pointer is used after its reference count has been dropp=
ed, creating a Use-After-Free vulnerability.
--

commit 8f5f79a7915a90cb43eb05a5eb535e070ae669bd
Author: Roman Demidov <roman.demidov.nn@gmail.com>

drm/msm/a6xx: check pm_runtime_resume_and_get() during resume

This commit adds return value checks to pm_runtime_resume_and_get() calls
during a6xx GPU resume to prevent hardware access on suspended devices. It
also unwinds acquired resources properly if these calls fail.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index f9de9329dee39..0cf205ea744be 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2175,44 +2175,48 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
>  	opp =3D dev_pm_opp_find_freq_ceil(&gpu->pdev->dev, &freq);
>  	if (IS_ERR(opp)) {
>  		ret =3D PTR_ERR(opp);
> -		goto err_set_opp;
> +		goto err_unlock;
>  	}
>  	dev_pm_opp_put(opp);
> =20
>  	/* Set the core clock and bus bw, having VDD scaling in mind */
>  	dev_pm_opp_set_opp(&gpu->pdev->dev, opp);

[Severity: High]
This is a pre-existing issue, but does this code cause a use-after-free of
the opp pointer?

The dev_pm_opp_find_freq_ceil() function returns an OPP object with an
incremented reference count. Dropping this reference via dev_pm_opp_put()
could cause the object to be freed if it is concurrently removed from the
OPP table. Can dev_pm_opp_set_opp() then dereference the freed memory?

> =20
> -	pm_runtime_resume_and_get(gmu->dev);
> -	pm_runtime_resume_and_get(gmu->gxpd);
> +	ret =3D pm_runtime_resume_and_get(gmu->dev);
> +	if (ret < 0)
> +		goto err_opp_clear;
> +	ret =3D pm_runtime_resume_and_get(gmu->gxpd);

[Severity: High]
This isn't a bug introduced by this patch, but can this cause a NULL pointer
dereference if the gxpd power domain is absent?

If the driver initializes a GMU wrapper device on a platform where the
device tree does not provide a 'gx' power domain, gmu->gxpd remains NULL.
Calling pm_runtime_resume_and_get(NULL) will immediately dereference the
pointer inside __pm_runtime_resume().

> +	if (ret < 0)
> +		goto err_put_dev;

[ ... ]

> -	/* If anything goes south, tear the GPU down piece by piece.. */
> -	if (ret) {
> -err_bulk_clk:
> -		pm_runtime_put(gmu->gxpd);
> -		pm_runtime_put(gmu->dev);
> -		dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
> -	}
> -err_set_opp:
>  	mutex_unlock(&a6xx_gpu->gmu.lock);
> +	msm_devfreq_resume(gpu);
> +	a6xx_llc_activate(a6xx_gpu);
> =20
> -	if (!ret) {
> -		msm_devfreq_resume(gpu);
> -		a6xx_llc_activate(a6xx_gpu);
> -	}
> +	return 0;
> =20
> +	/* If anything goes south, tear the GPU down piece by piece.. */
> +err_put_gxpd:
> +	pm_runtime_put(gmu->gxpd);

[Severity: High]
Can this error path also crash by unconditionally dereferencing a NULL gxpd
pointer?

While the initial pm_runtime_resume_and_get() issue is pre-existing, this
patch introduces an additional crash point here. If gmu->gxpd is NULL, this
newly added pm_runtime_put() will trigger a kernel panic.

> +err_put_dev:
> +	pm_runtime_put(gmu->dev);
> +err_opp_clear:
> +	dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
> +err_unlock:
> +	mutex_unlock(&a6xx_gpu->gmu.lock);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904125523.4381=
3-1-roman.demidov.nn@gmail.com?part=3D1
