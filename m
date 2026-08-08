Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69644C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39ED10E037;
	Sat,  8 Aug 2026 13:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dtt/g4zw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83F010E037
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:32:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC8AC6001A;
 Sat,  8 Aug 2026 13:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADCA1F000E9;
 Sat,  8 Aug 2026 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786195953;
 bh=47lKdowWjkDBMg+/B0nVS3LU/bH/oAHlp43wReLqAfk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dtt/g4zwt/qxOfTALAjrw7s53fRiD+M+krJMfbTVnaJE2vgyylCHBzlt44QfSuGuG
 i/EACFXPpABk37++HL2JYFSAYbVFJaDvmnXg7FZtDgvM4AEgm+JxhkjI2jH7aNgtEl
 Rw6xYww9DNfoCKRZviDNt2bHJRqglgfwnRKT6r8mpc7a1w1VhdX8Xwmymvh1qbI9uw
 5hTGDJ7T4o2wUb9ZVCBUC6wyWjo7L84d9QXR0W/9AWzfy/pxIqyhjKWMf5k0q+891L
 I4remNMW0tvuXFA/RS6rZY5It3yCfOObuWJlj7/eFTEUhkV5TY/ahQ4cPYQNilJfcf
 BvKXnOCA7pX5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808131624.2854412-1-lgs201920130244@gmail.com>
References: <20260808131624.2854412-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:32:32 +0000
Message-Id: <20260808133233.4ADCA1F000E9@smtp.kernel.org>
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
- [High] The GPU object and its associated resources are leaked if `dev_pm_=
opp_of_find_icc_paths()` fails in `adreno_bind()`.
--

--- Patch [1]: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teard=
own ---
commit d01531efa3b8df1b3ab17728c644cfbadd605a8f
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/msm/adreno: fix autosuspend cleanup during teardown

This commit adds a missing pm_runtime_dont_use_autosuspend() call to
adreno_gpu_cleanup() to properly drop the usage count during teardown.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 3370cd44382fe..f4b22e04f9135 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1261,6 +1261,8 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_g=
pu)
>  	for (i =3D 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
>  		release_firmware(adreno_gpu->fw[i]);
> =20
> +	pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
> +
>  	if (priv && pm_runtime_enabled(&priv->gpu_pdev->dev))
>  		pm_runtime_disable(&priv->gpu_pdev->dev);

[Severity: High]
This isn't a regression introduced by this patch, but I noticed a
potential leak in adreno_bind().

Looking at adreno_bind() in drivers/gpu/drm/msm/adreno/adreno_device.c:

drivers/gpu/drm/msm/adreno/adreno_device.c:adreno_bind() {
    ...
	gpu =3D info->funcs->init(drm);
	if (IS_ERR(gpu)) {
		dev_warn(drm->dev, "failed to load adreno gpu\n");
		return PTR_ERR(gpu);
	}

	ret =3D dev_pm_opp_of_find_icc_paths(dev, NULL);
	if (ret)
		return ret;
    ...
}

During component binding in adreno_bind(), if dev_pm_opp_of_find_icc_paths()
fails (which can happen with -EPROBE_DEFER), it returns immediately without
calling gpu->funcs->destroy(gpu).

Because component binding failed, the component framework will not call
adreno_unbind(), which leaves resources allocated during
info->funcs->init(drm) (like a6xx_gpu_init()) leaked. This happens on
every probe deferral.

Does this code leak the GPU object and its associated resources if
dev_pm_opp_of_find_icc_paths() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808131624.2854=
412-1-lgs201920130244@gmail.com?part=3D1
