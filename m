Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DA9C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BAD10E174;
	Sat, 11 Jul 2026 23:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZhasAK7c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB36910E174
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 23:20:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4ADAF4040A;
 Sat, 11 Jul 2026 23:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57081F000E9;
 Sat, 11 Jul 2026 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783812013;
 bh=UeU0CZa/3I9AV6gyvWg3P/zLMWU+SW7k/xxzhphEKcg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZhasAK7cb/kq040xIOzQZLp9o2OHqueC541XAuaFNsOwN8q5YWj0+QZaXcbSgbb5S
 2xY/4WQ21/lS0OQRS72d5RDhjArndK8G0NF5A67EZPSiF1wRheTafG3+6WWhXBBzVo
 yaSD3ob0cKpWTIIT+r1NR4LJcEBajccazddCEvenyc6sgUx8Phu8YMU/9Exd3654NQ
 zkWIS1dPWxW0Tie044p+l9/2MwNRCTBvL2Zi7/SUZdOONhQqg4/cExpItTUv+ZSw5q
 oVhPTnCgmCjlKvZVVQaqTspwcNytBrd60wYvSsoNEnWrSrKQ/Kmjbt4rzINGeUTM24
 /RE1u7ts9g1bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/modes: reject out-of-range GTF blanking duty cycle
To: "Xiang Mei" <xmei5@asu.edu>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711230728.2250485-1-xmei5@asu.edu>
References: <20260711230728.2250485-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 23:20:12 +0000
Message-Id: <20260711232012.E57081F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Medium] Unchecked `vrefresh` parameter from kernel command line can caus=
e multiple divide-by-zero panics.
--

--- Patch [1]: [PATCH] drm/modes: reject out-of-range GTF blanking duty cyc=
le ---
commit c78fc29b3d453bf33d5cd88746572b5f1e9a5c60
Author: Xiang Mei <xmei5@asu.edu>

drm/modes: reject out-of-range GTF blanking duty cycle

This commit rejects GTF blanking duty cycles of 100% or more to prevent a
divide-by-zero error that occurs when the divisor (100000 - ideal_duty_cycl=
e)
evaluates to 0.

> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index e1eed13a8e94f..291037706b587 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -966,6 +966,10 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdi=
splay, int vdisplay,
>  	/* 18.Find the ideal blanking duty cycle from blanking duty cycle */
>  	ideal_duty_cycle =3D GTF_C_PRIME * 1000 -
>  				(GTF_M_PRIME * 1000000 / hfreq_est);

[Severity: Medium]
This is a pre-existing issue, but while fixing divide-by-zero crashes here,
could an unvalidated vrefresh parameter cause other divide-by-zero panics
in this function?

For example, if an administrator provides a kernel command line parameter
with a refresh rate of @0 (e.g., video=3D1024x768@0), vfieldrate_rqd
evaluates to 0. This would cause a panic earlier in drm_gtf_mode_complex():

    hperiod =3D 1000000 / (vfieldrate_rqd * vtotal_lines);

Also, if the refresh rate is @1818, tmp1 evaluates to 0:

    tmp1 =3D (1000000  - MIN_VSYNC_PLUS_BP * vfieldrate_rqd) / 500;
    // (1000000 - 550 * 1818) / 500 =3D 0

This leads to another direct division by zero:

    hfreq_est =3D (tmp2 * 1000 * vfieldrate_rqd) / tmp1;

And if hfreq_est evaluates to 0, it causes a third divide-by-zero on the
ideal_duty_cycle assignment above.

Should drm_gtf_mode_complex() validate the vrefresh parameter before
performing these calculations?

> +	if (ideal_duty_cycle >=3D 100000) {
> +		drm_mode_destroy(dev, drm_mode);
> +		return NULL;
> +	}
>  	/* 19.Find the number of pixels in the blanking time to the nearest
>  	 * double character cell: */
>  	hblank =3D total_active_pixels * ideal_duty_cycle /

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711230728.2250=
485-1-xmei5@asu.edu?part=3D1
