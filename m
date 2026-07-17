Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9B8C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6763510F603;
	Fri, 17 Jul 2026 20:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CJ9UIDkh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6EB910F603
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:58:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E77B260051;
 Fri, 17 Jul 2026 20:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9841F000E9;
 Fri, 17 Jul 2026 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784321936;
 bh=Bkk+NgR+lYxBDFAjXlAgQY08fhvV7ZFde5bMUI9Mo30=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CJ9UIDkhwcm2JE5ovPmenFTgYctG7LGATnf5grSTJCAKvEszRPK2OAeBGLPsdp78h
 C3HaVgifvpFN0+nz70pIo9FjAofCKllb+YolyJOMHvwzLp7dLsRnmgd2SvRa3yZBMN
 C6Wmvu9dez0yRD/MUi08dswUVX02ADOtVQcUpDmBU8KwZyB9Na+pMM7iN/Kk2WZbry
 14scHe7ufIpx5RCouHEnzB/8cUnYz3c031XkuBqcgzQ/cQuHzy8e8ALuKxy9nldx5p
 an9uwn0ti/SjGuEZq01wiyIYGbLvO616c/E2zt0gOpVhBOiSsAz2XCtESIewzOl6JA
 GVfWdpS23oh9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/16] drm/msm: Remove redundant SIZE_MAX check
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-7-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 20:58:55 +0000
Message-Id: <20260717205856.7C9841F000E9@smtp.kernel.org>
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
- [Critical] Direct access to ctx->vm before VM lazy initialization in ioct=
l entry point.
--

--- Patch [6]: [PATCH v6 06/16] drm/msm: Remove redundant SIZE_MAX check ---
commit f2972a9fd99ad8ac26829ed01da6279a307ca6e7
Author: Rob Clark <robin.clark@oss.qualcomm.com>

    drm/msm: Remove redundant SIZE_MAX check

    kmalloc() will already fail and return NULL if passed SIZE_MAX.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index d55897c358371..62acee148bf2b 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -250,11 +250,6 @@ static int submit_lookup_cmds(struct msm_gem_submit =
*submit,
> =20
>  		sz =3D array_size(submit_cmd.nr_relocs,
>  				sizeof(struct drm_msm_gem_submit_reloc));
> -		/* check for overflow: */
> -		if (sz =3D=3D SIZE_MAX) {
> -			ret =3D -ENOMEM;
> -			goto out;
> -		}
>  		submit->cmd[i].relocs =3D kmalloc(sz, GFP_KERNEL | __GFP_NOWARN);
>  		if (!submit->cmd[i].relocs) {
>  			ret =3D -ENOMEM;

[Severity: Critical]
This is a pre-existing issue, but looking at the same file in
msm_ioctl_gem_submit(), there appears to be a direct access to ctx->vm
before it is lazily initialized:

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
	...
	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");
	...
}

If a userspace process opens the DRM device and immediately calls the
DRM_IOCTL_MSM_GEM_SUBMIT ioctl before calling any other ioctls that would
initialize the VM (using the msm_context_vm() accessor), won't ctx->vm be
NULL?

Since to_msm_vm() is a container_of macro wrapping the first struct member,
passing a NULL pointer yields a NULL pointer. Could dereferencing ->unusable
here allow an unprivileged local user to trigger a kernel panic by calling
this ioctl before the VM is initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D6
